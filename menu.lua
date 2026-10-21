-- Hex executor menu -- native loadstring + native HTTP.
-- HEXUI_PROTOCOL 1
--
-- Runs as the injected CoreScript blob (RobloxScript identity, CoreGui access).
-- User scripts are compiled by the engine's VM through our loadstring entry;
-- game:HttpGet is backed by the payload's JNI transport, not HttpService.

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Stealth: the engine attributes prints and errors to the Script instance that
-- owns the running thread, which here is a CoreGui CoreScript.  Rename that
-- instance for the session so logs do not point at the host we replaced.
pcall(function()
    if script ~= nil then
        script.Name = ("App%05d"):format(math.random(0, 99999))
    end
end)

-- Idempotence: the CoreScript loader can load the same host twice (it does so
-- after a load timeout).  A second menu instance would stack a second UI, a
-- second host pump and a second auto-run, so stop here if this chunk already
-- booted.  The UI check below is the cross-environment fallback.
if getfenv().__HEX_BOOTED then
    return
end
getfenv().__HEX_BOOTED = true

-- Diagnostics: when true, menu prints also go to the engine log (LogService).
-- Keep false in normal use; engine-side lines carry the host script's CoreGui
-- path and are the one fingerprint the console cannot strip.
local HEX_DEBUG_PRINT = false

-- Cross-environment guard: the CoreScript loader can also reload the host in a
-- fresh environment.  If the UI is already there, this is a duplicate load.
if CoreGui:FindFirstChild("HexMenu") ~= nil then
    return
end

-- The loader runs CoreScripts in sequence.  Blocking the injected chunk blocks
-- every CoreScript after it (notably PlayerScriptsLoader, which inserts
-- PlayerScripts.PlayerModule).  Keep the menu alive on a spawned thread and
-- return from the loader's thread immediately.
task.spawn(function()
-- ------------------------------------------------------------- native HTTP
-- loadstring("HEXHTTP:<url>") makes the payload fetch the URL with Java's TLS
-- and hand back a closure whose result is the body.  No HttpService involved:
-- the engine refuses every client request ("... only ... by game server").
local function hexHttpGet(a, b)
    local url = b ~= nil and b or a
    if type(url) ~= "string" then
        return nil
    end
    local f = loadstring("HEXHTTP:" .. url)
    if type(f) ~= "function" then
        return nil
    end
    return f()
end

-- --------------------------------------------------------------- host env
-- This file is UI + transport only.  Executor APIs, require semantics and
-- legacy-client compatibility live in the VM (src/hexvm.cpp), not here.
local realGlobals = getfenv()

local realLoadstring = loadstring

-- Host transport chunks (HEXSTEP/HEXREPLY/HEXREAD/HEXVM) run with this env.
-- User scripts never execute in the host state; they are compiled and run by
-- libhex's own Luau VM.
local scriptEnv
local function envLoadstring(src, chunkname)
    local f, err = realLoadstring(src, chunkname, scriptEnv)
    if type(f) == "function" and scriptEnv then
        setfenv(f, scriptEnv)
    end
    return f, err
end

scriptEnv = setmetatable({
    loadstring = envLoadstring,
}, { __index = realGlobals })

-- ===================================================== native VM host bridge
-- User scripts run in libhex's own Luau VM (src/hexvm.cpp), NOT in the
-- client's.  The client denies Instance.new / UI classes / getfenv to every
-- chunk created by loadstring -- the capability belongs to the script that
-- owns the proto, and a runtime chunk has none.  The VM sends each Roblox
-- operation here as a compact string; these functions run in THIS chunk,
-- which is prepended to a real CoreScript and therefore holds the host's
-- capabilities.
--
-- The transport is the engine's loadstring: the pump asks for the next
-- request with loadstring("HEXSTEP:"), receives a chunk that only RETURNS the
-- request text (a chunk that does no engine work cannot trip the sandbox),
-- and hands the result back with loadstring("HEXREPLY:...").
local VMREG = {}
local VMREV = setmetatable({}, { __mode = "k" })
local VM_CREATED = {}
local unpackFn = unpack or table.unpack

local function vmput(v)
    local id = VMREV[v]
    if id then return id end
    VMREG[#VMREG + 1] = v
    id = #VMREG
    VMREV[v] = id
    return id
end

local function venc(v, depth, seen)
    local t = type(v)
    if v == nil then return "n" end
    if t == "boolean" then return v and "t" or "f" end
    if t == "number" then
        if v ~= v then return "dnan;" end
        return "d" .. string.format("%.17g", v) .. ";"
    end
    if t == "string" then return "s" .. #v .. ":" .. v end
    if t == "table" and (depth or 0) < 2 then
        seen = seen or {}
        if not seen[v] then
            seen[v] = true
            local parts = {}
            local n = 0
            for k, val in pairs(v) do
                if type(k) == "string" or type(k) == "number" then
                    parts[#parts + 1] = venc(k, (depth or 0) + 1, seen)
                    parts[#parts + 1] = venc(val, (depth or 0) + 1, seen)
                    n = n + 1
                    if n >= 256 then break end
                end
            end
            return "x" .. n .. ":" .. table.concat(parts)
        end
    end
    return "h" .. vmput(v) .. ";"
end

local function vdec(s, i)
    local c = string.sub(s, i, i)
    if c == "n" then return nil, i + 1 end
    if c == "t" then return true, i + 1 end
    if c == "f" then return false, i + 1 end
    if c == "d" then
        local j = string.find(s, ";", i + 1, true)
        return tonumber(string.sub(s, i + 1, j - 1)), j + 1
    end
    if c == "s" then
        local j = string.find(s, ":", i + 1, true)
        local n = tonumber(string.sub(s, i + 1, j - 1))
        return string.sub(s, j + 1, j + n), j + 1 + n
    end
    if c == "h" then
        local j = string.find(s, ";", i + 1, true)
        return VMREG[tonumber(string.sub(s, i + 1, j - 1))], j + 1
    end
    if c == "F" then
        -- A closure that lives in the native VM.  The host gets a plain Lua
        -- function; calling it posts the arguments back into the VM.
        -- ('f' is boolean false, hence the capital.)
        local j = string.find(s, ";", i + 1, true)
        local id = tonumber(string.sub(s, i + 1, j - 1))
        i = j + 1
        return function(...)
            local n = select("#", ...)
            local parts = {}
            for k = 1, n do
                parts[k] = venc((select(k, ...)))
            end
            envLoadstring("HEXCALL:" .. id .. ":" .. table.concat(parts), "=hex")
        end, i
    end
    if c == "x" then
        local j = string.find(s, ":", i + 1, true)
        local n = tonumber(string.sub(s, i + 1, j - 1))
        local t = {}
        i = j + 1
        for _ = 1, n do
            local k
            local v
            k, i = vdec(s, i)
            v, i = vdec(s, i)
            t[k] = v
        end
        return t, i
    end
    error("bad value tag " .. tostring(c))
end

local BINOPS = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end,
    ["%"] = function(a, b) return a % b end,
    ["^"] = function(a, b) return a ^ b end,
    ["."] = function(a, b) return tostring(a) .. tostring(b) end,
    ["<"] = function(a, b) return a < b end,
    ["q"] = function(a, b) return a <= b end,
    ["m"] = function(a) return -a end,
    ["l"] = function(a) return #a end,
}

local VM_GLOBALS = {
    "game", "workspace", "Workspace", "Instance", "Enum",
    "UDim", "UDim2", "Vector2", "Vector3", "Vector2int16", "Vector3int16",
    "CFrame", "Color3", "BrickColor", "TweenInfo", "Ray", "Region3",
    "NumberSequence", "NumberSequenceKeypoint", "ColorSequence",
    "ColorSequenceKeypoint", "NumberRange", "Rect", "Font", "DateTime",
    "Random", "PhysicalProperties", "RaycastParams", "OverlapParams",
    "PathWaypoint", "RotationCurveKey", "FloatCurveKey",
    "CatalogSearchParams", "SharedTable", "Faces", "Axes",
    "settings", "UserSettings", "stats", "version",
}

local hexPrint, hexWarn, hexVMLog

local function vdispatch(req)
    local op = string.sub(req, 1, 1)
    local i = 2

    if op == "N" then                    -- Instance.new
        local cls
        local parent
        cls, i = vdec(req, i)
        parent, i = vdec(req, i)
        local inst
        if parent ~= nil then
            inst = Instance.new(cls, parent)
        else
            inst = Instance.new(cls)
            VM_CREATED[#VM_CREATED + 1] = inst
            if #VM_CREATED > 512 then table.remove(VM_CREATED, 1) end
        end
        return venc(inst)

    elseif op == "G" then                -- index
        local o
        local k
        o, i = vdec(req, i)
        k, i = vdec(req, i)
        return venc(o[k])

    elseif op == "S" then                -- newindex
        local o
        local k
        local v
        o, i = vdec(req, i)
        k, i = vdec(req, i)
        v, i = vdec(req, i)
        o[k] = v
        return "t"

    elseif op == "C" then                -- call
        local n
        local f
        n, i = vdec(req, i)
        f, i = vdec(req, i)
        local a = {}
        for k = 1, n do
            a[k], i = vdec(req, i)
        end
        -- WaitForChild can yield forever on a missing child.  Cap it so one
        -- broken script cannot starve the pump (and every other VM call).
        local okw, wf = pcall(function() return a[1].WaitForChild end)
        local fname = nil
        pcall(function() fname = debug.info(f, "n") end)
        if (okw and wf == f) or fname == "WaitForChild" then
            local name = a[2]
            local timeout = tonumber(a[3]) or 20
            if timeout > 20 then timeout = 20 end
            local deadline = os.clock() + timeout
            repeat
                local child = a[1]:FindFirstChild(name)
                if child ~= nil then return venc(child) end
                task.wait(0.1)
            until os.clock() >= deadline
            return venc(nil)
        end
        return venc(f(unpackFn(a, 1, n)))

    elseif op == "P" or op == "W" then   -- print / warn
        local m
        m, i = vdec(req, i)
        if op == "P" then
            -- VM prints stay in the Hex console only.  Routing them through
            -- the engine's print would tag every line with the host script's
            -- CoreGui path in LogService, which is exactly the fingerprint we
            -- are trying not to leave.
            (hexVMLog or hexPrint or print)(m)
        else
            (hexWarn or warn)(m)
        end
        return "t"

    elseif op == "L" then                -- import host globals
        local parts = {}
        for _, k in ipairs(VM_GLOBALS) do
            local ok, v = pcall(function() return realGlobals[k] end)
            if ok and v ~= nil then
                parts[#parts + 1] = "s" .. #k .. ":" .. k .. venc(v)
            end
        end
        return table.concat(parts)

    elseif op == "H" then                -- game:HttpGet / HttpGet
        local url
        url, i = vdec(req, i)
        return venc(hexHttpGet(url))

    elseif op == "T" then                -- typeof
        local v
        v, i = vdec(req, i)
        return venc(typeof(v))

    elseif op == "O" then                -- tostring
        local v
        v, i = vdec(req, i)
        return venc(tostring(v))

    elseif op == "E" then                -- equality
        local a
        local b
        a, i = vdec(req, i)
        b, i = vdec(req, i)
        return venc(a == b)

    elseif op == "D" then                -- clone a handle (cloneref)
        local o
        o, i = vdec(req, i)
        return venc(o)

    elseif op == "B" then                -- binary / unary operator
        local which = string.sub(req, i, i)
        local a
        local b
        local fn = BINOPS[which]
        i = i + 1
        a, i = vdec(req, i)
        if which ~= "m" and which ~= "l" then
            b, i = vdec(req, i)
        end
        if not fn then
            error("bad operator " .. tostring(which))
        end
        if b ~= nil or which == "m" or which == "l" then
            return venc(fn(a, b))
        end
        return venc(fn(a))

    elseif op == "R" then                -- getrenv
        return venc(realGlobals)

    elseif op == "I" then                -- unparented instances created by the VM
        local out = {}
        local keep = {}
        for _, o in ipairs(VM_CREATED) do
            local ok, p = pcall(function() return o.Parent end)
            if ok and p == nil then
                keep[#keep + 1] = o
                if #out < 256 then out[#out + 1] = o end
            end
        end
        VM_CREATED = keep
        return venc(out)

    elseif op == "Q" then                -- require
        local m
        m, i = vdec(req, i)
        local ok, res = pcall(require, m)
        if not ok then
            return venc(nil)
        end
        return venc(res)

    elseif op == "J" then                -- scripts (all / running / modules)
        local kind
        kind, i = vdec(req, i)
        local out = {}
        local ok, desc = pcall(function() return game:GetDescendants() end)
        if ok and type(desc) == "table" then
            -- Order matters: script-list consumers expect scripts[1] to be a ModuleScript or
            -- LocalScript.  Group by class instead of returning whatever
            -- GetDescendants happened to put first (often a server Script).
            local modules, locals, scripts = {}, {}, {}
            for _, d in ipairs(desc) do
                local ok2, cls = pcall(function() return d.ClassName end)
                if ok2 then
                    if cls == "ModuleScript" then
                        modules[#modules + 1] = d
                    elseif cls == "LocalScript" then
                        locals[#locals + 1] = d
                    elseif cls == "Script" then
                        scripts[#scripts + 1] = d
                    end
                end
            end
            if kind == "modules" then
                out = modules
            elseif kind == "running" then
                out = modules
                for _, d in ipairs(locals) do out[#out + 1] = d end
            else
                out = modules
                for _, d in ipairs(locals) do out[#out + 1] = d end
                for _, d in ipairs(scripts) do out[#out + 1] = d end
            end
            while #out > 256 do
                table.remove(out)
            end
        end
        return venc(out)

    elseif op == "Y" then                -- LuaSourceContainer.Source
        local o
        o, i = vdec(req, i)
        local ok, src = pcall(function() return o.Source end)
        if ok and type(src) == "string" then return venc(src) end
        return venc(nil)

    elseif op == "Z" then                -- fresh module execution (new cache slot)
        local m
        m, i = vdec(req, i)
        local ok, res = pcall(function()
            local c = m:Clone()
            c.Parent = m.Parent
            local r = require(c)
            c:Destroy()
            return r
        end)
        if ok then return venc(res) end
        return venc(nil)

    elseif op == "K" then                -- game:GetService(name)
        local name
        name, i = vdec(req, i)
        local ok, svc = pcall(function() return game:GetService(name) end)
        if ok then return venc(svc) end
        return venc(nil)

    elseif op == "M" then                -- batched property sets
        local o, n
        o, i = vdec(req, i)
        n, i = vdec(req, i)
        for k = 1, n do
            local key, val
            key, i = vdec(req, i)
            val, i = vdec(req, i)
            o[key] = val
        end
        return "t"
    end

    error("unknown vm op " .. tostring(op))
end

-- Pump: one request at a time, inline.  The VM is blocked while we dispatch,
-- so a yielding host call (WaitForChild/require) cannot starve another VM
-- request -- there is none.  Inline dispatch removes a task.spawn and a poll
-- per operation, which is the difference between a snappy and a sluggish
-- executor on this bridge.
task.spawn(function()
    local served = 0
    local idle = 0

    local function reply(ok, payload)
        local rep = (ok and "1:" or "0:") .. tostring(payload)
        envLoadstring("HEXREPLY:" .. rep, "=hex")
    end

    while true do
        local fn = envLoadstring("HEXSTEP:", "=hex")
        if type(fn) == "function" then
            local ok, req = pcall(fn)
            if ok and type(req) == "string" then
                local ok2, r2 = pcall(vdispatch, req)
                reply(ok2, r2)
            else
                reply(false, req)
            end
            served = served + 1
            -- Large scripts can queue thousands of back-to-back ops; yield often
            -- enough that Roblox's script watchdog never sees a long run.
            if served % 64 == 0 then
                task.wait()
            end
        else
            idle = idle + 1
            if idle % 64 == 0 then
                task.wait()
            end
        end
    end
end)


-- -------------------------------------------------------------------- ui
local gui = Instance.new("ScreenGui")
gui.Name = "HexMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = CoreGui

-- ---------------------------------------------------------------- console
-- Live output panel.  The client's F9 dev console is not reachable on mobile
-- (F9 is ignored), so the executor carries its own.  This is deliberately
-- event-driven and batched: setting a TextLabel per line (and polling the full
-- LogService history) is what made heavy output feel like it was running
-- through mud.
local LogService = game:GetService("LogService")
local TextService = game:GetService("TextService")

local consoleGui = Instance.new("ScreenGui")
consoleGui.Name = "HexConsole"
consoleGui.ResetOnSpawn = false
consoleGui.IgnoreGuiInset = false
consoleGui.DisplayOrder = 1000
consoleGui.Enabled = false
consoleGui.Parent = CoreGui

local consoleFrame = Instance.new("ScrollingFrame")
consoleFrame.Name = "Panel"
-- Scale-based so it fits every phone in portrait and landscape.
consoleFrame.Size = UDim2.new(0.94, 0, 0.32, 0)
consoleFrame.Position = UDim2.new(0.03, 0, 0.02, 0)
consoleFrame.BackgroundColor3 = Color3.fromRGB(14, 15, 19)
consoleFrame.BackgroundTransparency = 0.08
consoleFrame.BorderSizePixel = 0
consoleFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleFrame.ScrollBarThickness = 4
consoleFrame.ScrollingDirection = Enum.ScrollingDirection.Y
consoleFrame.Parent = consoleGui

local consoleCorner = Instance.new("UICorner")
consoleCorner.CornerRadius = UDim.new(0, 8)
consoleCorner.Parent = consoleFrame

local consoleStroke = Instance.new("UIStroke")
consoleStroke.Color = Color3.fromRGB(60, 210, 255)
consoleStroke.Thickness = 1
consoleStroke.Parent = consoleFrame

local consoleTitle = Instance.new("TextLabel")
consoleTitle.Name = "Title"
consoleTitle.Size = UDim2.new(1, -80, 0, 26)
consoleTitle.Position = UDim2.fromOffset(8, 0)
consoleTitle.BackgroundTransparency = 1
consoleTitle.Font = Enum.Font.Code
consoleTitle.TextSize = 13
consoleTitle.TextColor3 = Color3.fromRGB(90, 220, 255)
consoleTitle.TextXAlignment = Enum.TextXAlignment.Left
consoleTitle.Text = "CONSOLE"
consoleTitle.ZIndex = 2
consoleTitle.Parent = consoleGui

local consoleClear = Instance.new("TextButton")
consoleClear.Name = "Clear"
consoleClear.Size = UDim2.new(0, 58, 0, 22)
consoleClear.Position = UDim2.new(1, -66, 0, 2)
consoleClear.BackgroundColor3 = Color3.fromRGB(40, 44, 54)
consoleClear.BackgroundTransparency = 0.1
consoleClear.BorderSizePixel = 0
consoleClear.Font = Enum.Font.Code
consoleClear.TextSize = 12
consoleClear.TextColor3 = Color3.fromRGB(220, 230, 240)
consoleClear.Text = "CLEAR"
consoleClear.ZIndex = 2
consoleClear.Parent = consoleGui

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 5)
clearCorner.Parent = consoleClear

local consoleText = Instance.new("TextLabel")
consoleText.Name = "Text"
consoleText.Size = UDim2.new(1, -10, 0, 0)
consoleText.Position = UDim2.fromOffset(5, 30)
consoleText.BackgroundTransparency = 1
consoleText.Font = Enum.Font.Code
consoleText.TextSize = 12
consoleText.TextColor3 = Color3.fromRGB(190, 215, 240)
consoleText.TextXAlignment = Enum.TextXAlignment.Left
consoleText.TextYAlignment = Enum.TextYAlignment.Top
consoleText.TextWrapped = true
consoleText.AutomaticSize = Enum.AutomaticSize.None
consoleText.Text = ""
consoleText.Parent = consoleFrame

local MAX_CONSOLE_LINES = 180
local MAX_CONSOLE_CHARS = 260
local consoleLines = {}
local consoleDirty = true
local selfEcho = {}
local selfEchoCount = 0

-- LogService stores the engine's formatted line, including the
-- "[Roblox][ScriptPath]" prefix.  Our panel should not advertise the host.
local function stripPrefix(line)
    return (tostring(line):gsub("^%[Roblox%]%[[^%]]*%]%s*", ""))
end

local function consolePush(line)
    line = stripPrefix(line)
    if line == "" or line:find("FLog::", 1, true) then
        return
    end
    if #line > MAX_CONSOLE_CHARS then
        line = line:sub(1, MAX_CONSOLE_CHARS) .. "..."
    end
    if consoleLines[#consoleLines] == line then
        return
    end
    consoleLines[#consoleLines + 1] = line
    if #consoleLines > MAX_CONSOLE_LINES then
        table.remove(consoleLines, 1)
    end
    consoleDirty = true
end

local realPrint = print
hexPrint = function(...)
    local parts = {}
    for i = 1, select("#", ...) do
        parts[#parts + 1] = tostring(select(i, ...))
    end
    local line = table.concat(parts, "  ")
    if HEX_DEBUG_PRINT then
        realPrint(line)
    end
    consolePush(line)
end
print = hexPrint

hexVMLog = function(m)
    consolePush(tostring(m))
end

local realWarn = warn
hexWarn = function(...)
    local parts = {}
    for i = 1, select("#", ...) do
        parts[#parts + 1] = tostring(select(i, ...))
    end
    local line = table.concat(parts, "  ")
    if realWarn then realWarn(line) end
    consolePush("warn: " .. line)
    -- The same line comes back through LogService a moment later; remember it
    -- so MessageOut does not print every executor warning twice.
    selfEcho[line] = (selfEcho[line] or 0) + 1
    selfEchoCount = selfEchoCount + 1
    if selfEchoCount > 256 then
        selfEcho = {}
        selfEchoCount = 0
    end
end
warn = hexWarn

LogService.MessageOut:Connect(function(message)
    local msg = stripPrefix(tostring(message))
    local pending = selfEcho[msg]
    if pending and pending > 0 then
        selfEcho[msg] = pending - 1
        return
    end
    consolePush(msg)
end)

consoleClear.MouseButton1Click:Connect(function()
    consoleLines = {}
    consoleDirty = true
end)

-- One flush per 100 ms at most.  TextService computes the wrapped height
-- instead of relying on AbsoluteSize callbacks (which fired on every line and
-- caused a layout cascade).
task.spawn(function()
    local wasVisible = false
    while true do
        task.wait(0.1)
        local visible = consoleGui.Enabled
        if visible and not wasVisible then
            consoleDirty = true
        end
        wasVisible = visible
        if consoleDirty and visible then
            local width = consoleFrame.AbsoluteSize.X - 10
            if width >= 80 then
                consoleDirty = false
                local maxScroll = consoleFrame.CanvasSize.Y.Offset - consoleFrame.AbsoluteSize.Y
                local atBottom = maxScroll <= 0 or
                    consoleFrame.CanvasPosition.Y >= maxScroll - 6
                local text = table.concat(consoleLines, "\n")
                local size = TextService:GetTextSize(text, 12, Enum.Font.Code, Vector2.new(width, 100000))
                consoleText.Text = text
                consoleText.Size = UDim2.new(1, -10, 0, size.Y)
                local canvas = size.Y + 38
                consoleFrame.CanvasSize = UDim2.new(0, 0, 0, canvas)
                if atBottom then
                    consoleFrame.CanvasPosition =
                        Vector2.new(0, math.max(0, canvas - consoleFrame.AbsoluteSize.Y))
                end
            end
        end
    end
end)


local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.94, 0, 0.50, 0)
main.Position = UDim2.new(0.03, 0, 0.46, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 25, 30)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 210, 255)
stroke.Thickness = 1
stroke.Parent = main

local bar = Instance.new("Frame")
bar.Name = "Bar"
bar.Size = UDim2.new(1, 0, 0, 34)
bar.BackgroundColor3 = Color3.fromRGB(32, 34, 42)
bar.BorderSizePixel = 0
bar.Parent = main

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 8)
barCorner.Parent = bar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "HEX  |  executor"
title.TextColor3 = Color3.fromRGB(230, 240, 255)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = bar

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(28, 24)
close.Position = UDim2.new(1, -34, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(48, 50, 60)
close.BorderSizePixel = 0
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 13
close.TextColor3 = Color3.fromRGB(255, 120, 120)
close.Parent = bar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = close

local logBtn = Instance.new("TextButton")
logBtn.Size = UDim2.fromOffset(38, 24)
logBtn.Position = UDim2.new(1, -78, 0, 5)
logBtn.BackgroundColor3 = Color3.fromRGB(48, 50, 60)
logBtn.BorderSizePixel = 0
logBtn.Text = "LOG"
logBtn.Font = Enum.Font.GothamBold
logBtn.TextSize = 11
logBtn.TextColor3 = Color3.fromRGB(120, 220, 255)
logBtn.Parent = bar

local logCorner = Instance.new("UICorner")
logCorner.CornerRadius = UDim.new(0, 6)
logCorner.Parent = logBtn

logBtn.MouseButton1Click:Connect(function()
    consoleGui.Enabled = not consoleGui.Enabled
end)

local editor = Instance.new("TextBox")
editor.Name = "Editor"
editor.Size = UDim2.new(1, -24, 1, -160)
editor.Position = UDim2.fromOffset(12, 44)
editor.BackgroundColor3 = Color3.fromRGB(18, 19, 23)
editor.BorderSizePixel = 0
editor.Font = Enum.Font.Code
editor.TextSize = 14
editor.TextColor3 = Color3.fromRGB(220, 230, 240)
editor.PlaceholderText = 'loadstring(game:HttpGet("https://..."))()'
editor.PlaceholderColor3 = Color3.fromRGB(90, 95, 110)
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.MultiLine = true
editor.ClearTextOnFocus = false
editor.TextWrapped = true
editor.Text = ""
editor.Parent = main

local editorCorner = Instance.new("UICorner")
editorCorner.CornerRadius = UDim.new(0, 6)
editorCorner.Parent = editor

local function button(text, x, w, accent)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(w, 30)
    b.Position = UDim2.new(0, x, 1, -100)
    b.BackgroundColor3 = accent and Color3.fromRGB(0, 170, 220) or Color3.fromRGB(44, 46, 56)
    b.BorderSizePixel = 0
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(240, 248, 255)
    b.Text = text
    b.AutoButtonColor = true
    b.Parent = main
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    return b
end

local runBtn = button("Execute", 12, 110, true)
local clearBtn = button("Clear", 130, 80, false)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -24, 0, 34)
status.Position = UDim2.new(0, 12, 1, -64)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Code
status.TextSize = 12
status.TextColor3 = Color3.fromRGB(150, 220, 170)
status.TextWrapped = true
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextYAlignment = Enum.TextYAlignment.Top
status.Text = "ready"
status.Parent = main

-- Floating restore button: on mobile there is no keyboard shortcut, so closing
-- the main window must leave a way back.  Script UIs have their own buttons up top; this
-- sits at the left edge halfway down.
local mini = Instance.new("TextButton")
mini.Name = "Mini"
mini.Size = UDim2.fromOffset(46, 32)
mini.Position = UDim2.new(0, 8, 0.5, -16)
mini.BackgroundColor3 = Color3.fromRGB(24, 25, 30)
mini.BackgroundTransparency = 0.15
mini.BorderSizePixel = 0
mini.Text = "HEX"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 12
mini.TextColor3 = Color3.fromRGB(120, 220, 255)
mini.Visible = false
mini.Parent = gui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 6)
miniCorner.Parent = mini

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(60, 210, 255)
miniStroke.Thickness = 1
miniStroke.Parent = mini

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

-- --------------------------------------------------------------- dragging
local dragging, dragStart, startPos = false, nil, nil

bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                 startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ------------------------------------------------------------ execution
local function execute(source, label)
    if type(source) ~= "string" or #source == 0 then
        status.Text = "empty source"
        return
    end
    status.Text = "running " .. (label or "editor")
    -- Never log script contents or lengths.
    -- The native VM owns the script from here; the engine only sees a tiny
    -- no-op closure.  loadstring's result is deliberately ignored.
    envLoadstring("HEXVM:" .. source, "=hex")
    status.Text = "executed " .. (label or "editor")
end

local lastExecute = 0
runBtn.MouseButton1Click:Connect(function()
    -- Never run a script in the click callback: it would block input (and the
    -- keepalive) for as long as the script runs.  Each press gets its own thread.
    local now = os.clock()
    if now - lastExecute < 1.0 then
        return
    end
    lastExecute = now
    local src = editor.Text
    task.spawn(function()
        execute(src, "editor")
    end)
end)

clearBtn.MouseButton1Click:Connect(function()
    editor.Text = ""
    status.Text = "ready"
end)

close.MouseButton1Click:Connect(function()
    main.Visible = false
    consoleGui.Enabled = false
    mini.Visible = true
end)

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if main.Visible then
            main.Visible = false
            consoleGui.Enabled = false
            mini.Visible = true
        else
            main.Visible = true
            mini.Visible = false
        end
    end
end)

-- Keepalive: the menu thread must never return while the loader thread does.
while true do
    task.wait(0.5)
end
end)
