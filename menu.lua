-- HEXUI_PROTOCOL 2
local Host = Host

local function getService(name)
    if Host and type(Host.GetService) == "function" then
        return Host.GetService(name)
    end
    return game:GetService(name)
end

local UIS = getService("UserInputService")
local TextService = getService("TextService")
local Players = getService("Players")
local TweenService = getService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") or nil

-- CoreGui exists on a CoreScript host but is not writable from the per-place
-- PlayerScripts bootstrap.  Host.GuiParent resolves the right container; the
-- raw getService call is only a compatibility fallback for an older bridge.
local CoreGui = nil
if Host and type(Host.GuiParent) == "function" then
    CoreGui = Host.GuiParent()
end
if CoreGui == nil then
    pcall(function() CoreGui = game:GetService("CoreGui") end)
end
if PlayerGui == nil and LocalPlayer ~= nil then
    pcall(function() PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5) end)
end

for _, name in ipairs({ "HexMenu", "HexConsole" }) do
    if CoreGui then
        local old = CoreGui:FindFirstChild(name)
        if old then old:Destroy() end
    end
    if PlayerGui then
        local old = PlayerGui:FindFirstChild(name)
        if old then old:Destroy() end
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HexMenu"
-- Identifies the server this menu belongs to.  The bridge uses it to avoid
-- rebuilding a second menu when both host scripts load for the same place.
pcall(function() ScreenGui:SetAttribute("HexJob", game.JobId) end)
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

if Host and type(Host.Parent) == "function" then
    Host.Parent(ScreenGui, CoreGui)
else
    local ok = CoreGui ~= nil and pcall(function()
        ScreenGui.Parent = CoreGui
    end)
    if not ok and PlayerGui then
        ScreenGui.Parent = PlayerGui
    end
end

local ICONS = {
    HexLogo         = "rbxassetid://10723407092",
    Home            = "rbxassetid://10723407389",
    Console         = "rbxassetid://10734982144",
    Editor          = "rbxassetid://10709810463",
    Settings        = "rbxassetid://10734950309",
    SidebarOpen     = "rbxassetid://10709797382",
    Play            = "rbxassetid://10734923549",
    Trash           = "rbxassetid://10747362241",
    Save            = "rbxassetid://10734941499",
    Clipboard       = "rbxassetid://10709798574",
    Minimize        = "rbxassetid://10734896206",
    Close           = "rbxassetid://10747384394",
}

local THEME = {
    BackgroundDark    = Color3.fromRGB(13, 15, 28),
    BackgroundMedium  = Color3.fromRGB(18, 20, 38),
    BackgroundLight   = Color3.fromRGB(26, 28, 52),
    CardBackground    = Color3.fromRGB(16, 18, 35),
    SidebarBackground = Color3.fromRGB(11, 13, 24),
    AccentPurple      = Color3.fromRGB(130, 85, 255),
    AccentBlue        = Color3.fromRGB(65, 125, 255),
    BorderStroke      = Color3.fromRGB(50, 46, 84),
    BorderStrokeLight = Color3.fromRGB(75, 68, 120),
    TextPrimary       = Color3.fromRGB(242, 245, 255),
    TextSecondary     = Color3.fromRGB(145, 152, 185),
    TextMuted         = Color3.fromRGB(95, 102, 130),
    SuccessGreen      = Color3.fromRGB(50, 220, 130),
    WarningYellow     = Color3.fromRGB(255, 195, 60),
    DangerRed         = Color3.fromRGB(255, 80, 80),
}

local function create(className, properties, children)
    local inst = Instance.new(className)
    for prop, val in pairs(properties or {}) do
        inst[prop] = val
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

local function tween(inst, duration, props, style, dir)
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        style or Enum.EasingStyle.Quart,
        dir or Enum.EasingDirection.Out
    )
    local tw = TweenService:Create(inst, tweenInfo, props)
    tw:Play()
    return tw
end

local function escapeXml(str)
    local s = str:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;")
    return s
end

local KEYWORDS = {
    ["and"] = true, ["break"] = true, ["do"] = true, ["else"] = true,
    ["elseif"] = true, ["end"] = true, ["false"] = true, ["for"] = true,
    ["function"] = true, ["if"] = true, ["in"] = true, ["local"] = true,
    ["nil"] = true, ["not"] = true, ["or"] = true, ["repeat"] = true,
    ["return"] = true, ["then"] = true, ["true"] = true, ["until"] = true,
    ["while"] = true, ["continue"] = true, ["export"] = true, ["type"] = true,
    ["self"] = true
}

local BUILTINS = {
    ["print"] = true, ["warn"] = true, ["error"] = true, ["pairs"] = true,
    ["ipairs"] = true, ["next"] = true, ["tostring"] = true, ["tonumber"] = true,
    ["type"] = true, ["typeof"] = true, ["pcall"] = true, ["xpcall"] = true,
    ["select"] = true, ["rawget"] = true, ["rawset"] = true, ["setmetatable"] = true,
    ["getmetatable"] = true, ["task"] = true, ["math"] = true, ["table"] = true,
    ["string"] = true, ["os"] = true, ["coroutine"] = true, ["bit32"] = true,
    ["utf8"] = true, ["debug"] = true, ["game"] = true, ["workspace"] = true,
    ["script"] = true, ["Instance"] = true, ["Vector3"] = true, ["Vector2"] = true,
    ["CFrame"] = true, ["Color3"] = true, ["UDim2"] = true, ["UDim"] = true,
    ["BrickColor"] = true, ["Enum"] = true, ["Ray"] = true, ["TweenInfo"] = true,
    ["loadstring"] = true, ["wait"] = true, ["spawn"] = true, ["delay"] = true,
    ["writefile"] = true, ["readfile"] = true, ["getclipboard"] = true, ["setclipboard"] = true,
    ["identifyexecutor"] = true, ["getgenv"] = true, ["Host"] = true
}

local SYNTAX_COLORS = {
    keyword  = "rgb(198, 120, 255)",
    builtin  = "rgb(86, 204, 242)",
    string   = "rgb(152, 224, 138)",
    number   = "rgb(255, 179, 71)",
    comment  = "rgb(110, 122, 155)",
    boolean  = "rgb(255, 215, 0)",
    operator = "rgb(160, 190, 245)",
    default  = "rgb(230, 235, 248)",
}

local function highlightLuau(src)
    local result = {}
    local i = 1
    local len = #src

    while i <= len do
        if src:sub(i, i + 3) == "--[[" then
            local finish = src:find("]]", i + 4, true)
            if finish then
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.comment, escapeXml(src:sub(i, finish + 1))))
                i = finish + 2
            else
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.comment, escapeXml(src:sub(i))))
                break
            end
        elseif src:sub(i, i + 1) == "--" then
            local finish = src:find("\n", i + 2, true)
            if finish then
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.comment, escapeXml(src:sub(i, finish - 1))))
                table.insert(result, "\n")
                i = finish + 1
            else
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.comment, escapeXml(src:sub(i))))
                break
            end
        elseif src:sub(i, i) == '"' or src:sub(i, i) == "'" then
            local quote = src:sub(i, i)
            local j = i + 1
            local escaped = false
            while j <= len do
                local c = src:sub(j, j)
                if c == "\\" and not escaped then
                    escaped = true
                elseif c == quote and not escaped then
                    break
                else
                    escaped = false
                end
                j = j + 1
            end
            table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.string, escapeXml(src:sub(i, j))))
            i = j + 1
        elseif src:sub(i, i + 1) == "[[" then
            local finish = src:find("]]", i + 2, true)
            if finish then
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.string, escapeXml(src:sub(i, finish + 1))))
                i = finish + 2
            else
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.string, escapeXml(src:sub(i))))
                break
            end
        elseif src:sub(i):match("^0[xX]%x+") then
            local match = src:sub(i):match("^0[xX]%x+")
            table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.number, match))
            i = i + #match
        elseif src:sub(i):match("^%d+%.?%d*[eE]?[+-]?%d*") and src:sub(i, i):match("%d") then
            local match = src:sub(i):match("^%d+%.?%d*[eE]?[+-]?%d*")
            table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.number, match))
            i = i + #match
        elseif src:sub(i):match("^[%a_][%w_]*") then
            local word = src:sub(i):match("^[%a_][%w_]*")
            if word == "true" or word == "false" or word == "nil" then
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.boolean, word))
            elseif KEYWORDS[word] then
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.keyword, word))
            elseif BUILTINS[word] then
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.builtin, word))
            else
                table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.default, escapeXml(word)))
            end
            i = i + #word
        elseif src:sub(i, i):match("[%+%-%*%/%%%^#=<>&|~:;,%.%(%)%{%}%[%]]") then
            local sym = src:sub(i, i)
            table.insert(result, string.format('<font color="%s">%s</font>', SYNTAX_COLORS.operator, escapeXml(sym)))
            i = i + 1
        else
            table.insert(result, escapeXml(src:sub(i, i)))
            i = i + 1
        end
    end

    return table.concat(result)
end

local MAIN_WIDTH = 640
local MAIN_HEIGHT = 420

-- The design is a fixed 640x420 panel.  On a phone in portrait the logical
-- viewport can be narrower than 640, and Roblox may additionally apply a DPI
-- scale; a raw offset panel then renders wider than the screen, which looks
-- like random-coloured CoreGui blocks clipped at both edges.  Fit the panel to
-- the actual ScreenGui size and let UIScale shrink every child (text, icons,
-- paddings) with it.
local viewport = ScreenGui.AbsoluteSize
if viewport.X < 2 or viewport.Y < 2 then
    local cam = workspace.CurrentCamera
    viewport = cam and cam.ViewportSize or Vector2.new(MAIN_WIDTH, MAIN_HEIGHT)
end
local fitScale = math.clamp(
    math.min((viewport.X - 24) / MAIN_WIDTH, (viewport.Y - 24) / MAIN_HEIGHT),
    0.45, 1.0
)
local mainW = MAIN_WIDTH * fitScale
local mainH = MAIN_HEIGHT * fitScale

local MainFrame = create("Frame", {
    Name = "MainFrame",
    Size = UDim2.new(0, MAIN_WIDTH, 0, MAIN_HEIGHT),
    Position = UDim2.new(0.5, -mainW / 2, 0.5, -mainH / 2),
    BackgroundColor3 = THEME.BackgroundDark,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = ScreenGui,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 12) }),
    create("UIStroke", {
        Color = THEME.BorderStroke,
        Thickness = 1.2,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }),
    create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(15, 17, 34)),
            ColorSequenceKeypoint.new(0.55, Color3.fromRGB(23, 18, 46)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(12, 14, 26)),
        }),
        Rotation = 135,
    }),
})

local mainScale = Instance.new("UIScale")
mainScale.Scale = fitScale
mainScale.Parent = MainFrame

if Host and type(Host.Debug) == "function" then
    Host.Debug(string.format(
        "UI vp=%.0fx%.0f abs=%.0fx%.0f fit=%.3f main=%.0fx%.0f",
        viewport.X, viewport.Y, ScreenGui.AbsoluteSize.X, ScreenGui.AbsoluteSize.Y,
        fitScale, mainW, mainH))
end

local Topbar = create("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, 38),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = THEME.BackgroundDark,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = MainFrame,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 12) }),
    create("Frame", {
        Name = "Divider",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = THEME.BorderStroke,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
    }),
})

create("Frame", {
    Name = "TitleContainer",
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0, 12, 0, 0),
    BackgroundTransparency = 1,
    Parent = Topbar,
}, {
    create("ImageLabel", {
        Name = "Logo",
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 0, 0.5, -10),
        BackgroundTransparency = 1,
        Image = ICONS.HexLogo,
        ImageColor3 = THEME.AccentPurple,
    }),
    create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0, 42, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = "Hex",
        TextColor3 = THEME.TextPrimary,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
    }),
    create("TextLabel", {
        Name = "Badge",
        Size = UDim2.new(0, 42, 0, 16),
        Position = UDim2.new(0, 72, 0.5, -8),
        BackgroundColor3 = THEME.AccentPurple,
        BackgroundTransparency = 0.8,
        Text = "LUAU",
        TextColor3 = THEME.AccentPurple,
        Font = Enum.Font.GothamBold,
        TextSize = 9,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 4) }),
    }),
})

local WindowControls = create("Frame", {
    Name = "WindowControls",
    Size = UDim2.new(0, 70, 1, 0),
    Position = UDim2.new(1, -78, 0, 0),
    BackgroundTransparency = 1,
    Parent = Topbar,
})

local MinimizeBtn = create("ImageButton", {
    Name = "MinimizeBtn",
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(0, 6, 0.5, -13),
    BackgroundColor3 = THEME.BackgroundLight,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    Image = ICONS.Minimize,
    ImageColor3 = THEME.TextSecondary,
    Parent = WindowControls,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 6) }),
})

local CloseBtn = create("ImageButton", {
    Name = "CloseBtn",
    Size = UDim2.new(0, 26, 0, 26),
    Position = UDim2.new(0, 38, 0.5, -13),
    BackgroundColor3 = THEME.BackgroundLight,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    Image = ICONS.Close,
    ImageColor3 = THEME.TextSecondary,
    Parent = WindowControls,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 6) }),
})

local MiniBtn = create("TextButton", {
    Name = "HexMini",
    Size = UDim2.fromOffset(48, 32),
    Position = UDim2.new(0, 12, 0.5, -16),
    BackgroundColor3 = THEME.BackgroundDark,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
    Text = "HEX",
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextColor3 = THEME.AccentPurple,
    Visible = false,
    Parent = ScreenGui,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    create("UIStroke", { Color = THEME.AccentPurple, Thickness = 1.2 }),
})

local miniScale = Instance.new("UIScale")
miniScale.Scale = fitScale
miniScale.Parent = MiniBtn

MiniBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniBtn.Visible = false
end)

MinimizeBtn.MouseEnter:Connect(function()
    tween(MinimizeBtn, 0.2, { BackgroundTransparency = 0.3, ImageColor3 = THEME.TextPrimary })
end)
MinimizeBtn.MouseLeave:Connect(function()
    tween(MinimizeBtn, 0.2, { BackgroundTransparency = 0.8, ImageColor3 = THEME.TextSecondary })
end)

CloseBtn.MouseEnter:Connect(function()
    tween(CloseBtn, 0.2, { BackgroundColor3 = THEME.DangerRed, BackgroundTransparency = 0.2, ImageColor3 = Color3.new(1, 1, 1) })
end)
CloseBtn.MouseLeave:Connect(function()
    tween(CloseBtn, 0.2, { BackgroundColor3 = THEME.BackgroundLight, BackgroundTransparency = 0.8, ImageColor3 = THEME.TextSecondary })
end)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        tween(MainFrame, 0.3, { Size = UDim2.new(0, MAIN_WIDTH, 0, 38) })
    else
        tween(MainFrame, 0.3, { Size = UDim2.new(0, MAIN_WIDTH, 0, MAIN_HEIGHT) })
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniBtn.Visible = true
end)

local isDragging = false
local dragStartPos, startFramePos

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStartPos = input.Position
        startFramePos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        MainFrame.Position = UDim2.new(
            startFramePos.X.Scale,
            startFramePos.X.Offset + delta.X,
            startFramePos.Y.Scale,
            startFramePos.Y.Offset + delta.Y
        )
    end
end)

local SIDEBAR_COLLAPSED_WIDTH = 50
local SIDEBAR_EXPANDED_WIDTH = 145

local Sidebar = create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, SIDEBAR_COLLAPSED_WIDTH, 1, -38),
    Position = UDim2.new(0, 0, 0, 38),
    BackgroundColor3 = THEME.SidebarBackground,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 5,
    Parent = MainFrame,
}, {
    create("Frame", {
        Name = "RightBorder",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = THEME.BorderStroke,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
    }),
})

local TabButtonsContainer = create("Frame", {
    Name = "TabButtonsContainer",
    Size = UDim2.new(1, 0, 1, -48),
    Position = UDim2.new(0, 0, 0, 10),
    BackgroundTransparency = 1,
    ZIndex = 6,
    Parent = Sidebar,
}, {
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
    }),
})

local SidebarToggleBtn = create("TextButton", {
    Name = "SidebarToggleBtn",
    Size = UDim2.new(1, -12, 0, 34),
    Position = UDim2.new(0, 6, 1, -42),
    BackgroundColor3 = THEME.BackgroundLight,
    BackgroundTransparency = 0.85,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    ZIndex = 6,
    Parent = Sidebar,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0, 10, 0.5, -9),
        BackgroundTransparency = 1,
        Image = ICONS.SidebarOpen,
        ImageColor3 = THEME.TextSecondary,
        ZIndex = 7,
    }),
    create("TextLabel", {
        Name = "ExpandLabel",
        Size = UDim2.new(1, -42, 1, 0),
        Position = UDim2.new(0, 36, 0, 0),
        BackgroundTransparency = 1,
        Text = "Collapse",
        TextColor3 = THEME.TextSecondary,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 1,
        ZIndex = 7,
    }),
})

local ContentContainer = create("Frame", {
    Name = "ContentContainer",
    Size = UDim2.new(1, -(SIDEBAR_COLLAPSED_WIDTH + 14), 1, -50),
    Position = UDim2.new(0, SIDEBAR_COLLAPSED_WIDTH + 8, 0, 44),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Parent = MainFrame,
})

local TabData = {
    { Id = "Home",     Title = "Home",     Icon = ICONS.Home,     Order = 1 },
    { Id = "Console",  Title = "Console",  Icon = ICONS.Console,  Order = 2 },
    { Id = "Editor",   Title = "Editor",   Icon = ICONS.Editor,   Order = 3 },
    { Id = "Settings", Title = "Settings", Icon = ICONS.Settings, Order = 4 },
}

local TabButtons = {}
local TabPages = {}
local CurrentTabId = "Home"
local isSidebarExpanded = false

local function collapseSidebar()
    if not isSidebarExpanded then return end
    isSidebarExpanded = false
    tween(Sidebar, 0.25, { Size = UDim2.new(0, SIDEBAR_COLLAPSED_WIDTH, 1, -38) })
    tween(ContentContainer, 0.25, {
        Position = UDim2.new(0, SIDEBAR_COLLAPSED_WIDTH + 8, 0, 44),
        Size = UDim2.new(1, -(SIDEBAR_COLLAPSED_WIDTH + 14), 1, -50),
    })
    tween(SidebarToggleBtn.Icon, 0.25, { Rotation = 0 })
    tween(SidebarToggleBtn.ExpandLabel, 0.2, { TextTransparency = 1 })

    for _, btnData in pairs(TabButtons) do
        tween(btnData.Label, 0.15, { TextTransparency = 1 })
    end
end

local function expandSidebar()
    if isSidebarExpanded then return end
    isSidebarExpanded = true
    tween(Sidebar, 0.25, { Size = UDim2.new(0, SIDEBAR_EXPANDED_WIDTH, 1, -38) })
    tween(ContentContainer, 0.25, {
        Position = UDim2.new(0, SIDEBAR_EXPANDED_WIDTH + 8, 0, 44),
        Size = UDim2.new(1, -(SIDEBAR_EXPANDED_WIDTH + 14), 1, -50),
    })
    tween(SidebarToggleBtn.Icon, 0.25, { Rotation = 180 })
    tween(SidebarToggleBtn.ExpandLabel, 0.25, { TextTransparency = 0 })

    for _, btnData in pairs(TabButtons) do
        tween(btnData.Label, 0.25, { TextTransparency = 0 })
    end
end

SidebarToggleBtn.MouseButton1Click:Connect(function()
    if isSidebarExpanded then
        collapseSidebar()
    else
        expandSidebar()
    end
end)

SidebarToggleBtn.MouseEnter:Connect(function()
    tween(SidebarToggleBtn, 0.2, { BackgroundTransparency = 0.6 })
    tween(SidebarToggleBtn.Icon, 0.2, { ImageColor3 = THEME.TextPrimary })
end)
SidebarToggleBtn.MouseLeave:Connect(function()
    tween(SidebarToggleBtn, 0.2, { BackgroundTransparency = 0.85 })
    tween(SidebarToggleBtn.Icon, 0.2, { ImageColor3 = THEME.TextSecondary })
end)

local function switchTab(targetId)
    if CurrentTabId == targetId then
        if isSidebarExpanded then
            collapseSidebar()
        end
        return
    end

    local oldPage = TabPages[CurrentTabId]
    local newPage = TabPages[targetId]
    if not newPage then return end

    local oldBtn = TabButtons[CurrentTabId]
    local newBtn = TabButtons[targetId]

    if oldBtn then
        tween(oldBtn.Button, 0.2, { BackgroundTransparency = 1 })
        tween(oldBtn.Icon, 0.2, { ImageColor3 = THEME.TextSecondary })
        tween(oldBtn.Indicator, 0.2, { BackgroundTransparency = 1 })
        if isSidebarExpanded then
            tween(oldBtn.Label, 0.2, { TextColor3 = THEME.TextSecondary })
        end
    end

    if newBtn then
        tween(newBtn.Button, 0.2, { BackgroundColor3 = THEME.BackgroundLight, BackgroundTransparency = 0.4 })
        tween(newBtn.Icon, 0.2, { ImageColor3 = THEME.AccentPurple })
        tween(newBtn.Indicator, 0.2, { BackgroundTransparency = 0 })
        if isSidebarExpanded then
            tween(newBtn.Label, 0.2, { TextColor3 = THEME.TextPrimary })
        end
    end

    if isSidebarExpanded then
        collapseSidebar()
    end

    if oldPage then
        local outTw = tween(oldPage, 0.18, { Position = UDim2.new(0, -18, 0, 0) })
        outTw.Completed:Connect(function()
            oldPage.Visible = false
        end)
    end

    newPage.Visible = true
    newPage.Position = UDim2.new(0, 18, 0, 0)
    tween(newPage, 0.25, { Position = UDim2.new(0, 0, 0, 0) })

    CurrentTabId = targetId
end

for _, tab in ipairs(TabData) do
    local isInitial = (tab.Id == "Home")
    local TabButton = create("TextButton", {
        Name = tab.Id .. "TabBtn",
        Size = UDim2.new(1, -12, 0, 36),
        BackgroundColor3 = THEME.BackgroundLight,
        BackgroundTransparency = (isInitial and 0.4 or 1),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = tab.Order,
        ZIndex = 6,
        Parent = TabButtonsContainer,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create("Frame", {
            Name = "ActiveIndicator",
            Size = UDim2.new(0, 3, 0, 18),
            Position = UDim2.new(0, 0, 0.5, -9),
            BackgroundColor3 = THEME.AccentPurple,
            BackgroundTransparency = (isInitial and 0 or 1),
            BorderSizePixel = 0,
            ZIndex = 7,
        }, {
            create("UICorner", { CornerRadius = UDim.new(0, 2) }),
        }),
        create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 9, 0.5, -10),
            BackgroundTransparency = 1,
            Image = tab.Icon,
            ImageColor3 = (isInitial and THEME.AccentPurple or THEME.TextSecondary),
            ZIndex = 7,
        }),
        create("TextLabel", {
            Name = "TitleLabel",
            Size = UDim2.new(1, -44, 1, 0),
            Position = UDim2.new(0, 38, 0, 0),
            BackgroundTransparency = 1,
            Text = tab.Title,
            TextColor3 = (isInitial and THEME.TextPrimary or THEME.TextSecondary),
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTransparency = 1,
            ZIndex = 7,
        }),
    })

    TabButtons[tab.Id] = {
        Button = TabButton,
        Icon = TabButton.Icon,
        Label = TabButton.TitleLabel,
        Indicator = TabButton.ActiveIndicator,
    }

    TabButton.MouseEnter:Connect(function()
        if CurrentTabId ~= tab.Id then
            tween(TabButton, 0.2, { BackgroundTransparency = 0.75 })
            tween(TabButton.Icon, 0.2, { ImageColor3 = THEME.TextPrimary })
        end
    end)

    TabButton.MouseLeave:Connect(function()
        if CurrentTabId ~= tab.Id then
            tween(TabButton, 0.2, { BackgroundTransparency = 1 })
            tween(TabButton.Icon, 0.2, { ImageColor3 = THEME.TextSecondary })
        end
    end)

    TabButton.MouseButton1Click:Connect(function()
        switchTab(tab.Id)
    end)
end

local function createTabPage(id, isVisible)
    local page = create("Frame", {
        Name = id .. "Page",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Visible = isVisible or false,
        Parent = ContentContainer,
    })
    TabPages[id] = page
    return page
end

local HomePage = createTabPage("Home", true)
local ConsolePage = createTabPage("Console", false)
local EditorPage = createTabPage("Editor", false)
local SettingsPage = createTabPage("Settings", false)

local ProfileCard = create("Frame", {
    Name = "ProfileCard",
    Size = UDim2.new(1, 0, 0, 78),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = THEME.CardBackground,
    BorderSizePixel = 0,
    Parent = HomePage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 10) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
    create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.0, Color3.fromRGB(22, 24, 46)),
            ColorSequenceKeypoint.new(1.0, Color3.fromRGB(16, 18, 34)),
        }),
        Rotation = 90,
    }),
})

local AvatarFrame = create("Frame", {
    Name = "AvatarFrame",
    Size = UDim2.new(0, 56, 0, 56),
    Position = UDim2.new(0, 12, 0.5, -28),
    BackgroundColor3 = THEME.BackgroundLight,
    BorderSizePixel = 0,
    Parent = ProfileCard,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    create("UIStroke", { Color = THEME.AccentPurple, Thickness = 1.5 }),
})

local safeUserId = (LocalPlayer and LocalPlayer.UserId and LocalPlayer.UserId > 0) and LocalPlayer.UserId or 1
local safeName = LocalPlayer and tostring(LocalPlayer.Name) or "Player"
local safeDisplay = LocalPlayer and tostring(LocalPlayer.DisplayName) or safeName
local AvatarImage = create("ImageLabel", {
    Name = "AvatarImage",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxthumb://type=AvatarHeadShot&id=" .. safeUserId .. "&w=150&h=150",
    Parent = AvatarFrame,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
})

create("Frame", {
    Name = "StatusDot",
    Size = UDim2.new(0, 12, 0, 12),
    Position = UDim2.new(1, -12, 1, -12),
    BackgroundColor3 = THEME.SuccessGreen,
    BorderSizePixel = 0,
    ZIndex = 3,
    Parent = AvatarFrame,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    create("UIStroke", { Color = THEME.CardBackground, Thickness = 2 }),
})

create("TextLabel", {
    Name = "GreetingTitle",
    Size = UDim2.new(1, -85, 0, 24),
    Position = UDim2.new(0, 80, 0, 16),
    BackgroundTransparency = 1,
    Text = "Hello, " .. safeName,
    TextColor3 = THEME.TextPrimary,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
})

create("TextLabel", {
    Name = "GreetingSubtitle",
    Size = UDim2.new(1, -85, 0, 18),
    Position = UDim2.new(0, 80, 0, 42),
    BackgroundTransparency = 1,
    Text = "Display: " .. safeDisplay .. "  •  Hex Ready",
    TextColor3 = THEME.TextSecondary,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
})

task.spawn(function()
    pcall(function()
        local content, isReady = Players:GetUserThumbnailAsync(
            safeUserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size100x100
        )
        if isReady and content then
            AvatarImage.Image = content
        end
    end)
end)

local QuickHacksCard = create("Frame", {
    Name = "QuickHacksCard",
    Size = UDim2.new(1, 0, 1, -90),
    Position = UDim2.new(0, 0, 0, 88),
    BackgroundColor3 = THEME.CardBackground,
    BorderSizePixel = 0,
    Parent = HomePage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 10) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
})

create("TextLabel", {
    Name = "SectionHeader",
    Size = UDim2.new(1, -24, 0, 24),
    Position = UDim2.new(0, 14, 0, 12),
    BackgroundTransparency = 1,
    Text = "QUICK HACKS & SLIDERS",
    TextColor3 = THEME.AccentPurple,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = QuickHacksCard,
})

local SlidersContainer = create("Frame", {
    Name = "SlidersContainer",
    Size = UDim2.new(1, -28, 1, -44),
    Position = UDim2.new(0, 14, 0, 38),
    BackgroundTransparency = 1,
    Parent = QuickHacksCard,
}, {
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 14),
    }),
})

local function createSlider(title, minVal, maxVal, defaultVal, suffix, onValueChanged)
    local currentValue = defaultVal

    local SliderFrame = create("Frame", {
        Name = title .. "Slider",
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = THEME.BackgroundDark,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = SlidersContainer,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
    })

    create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0.6, 0, 0, 20),
        Position = UDim2.new(0, 12, 0, 6),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = THEME.TextPrimary,
        Font = Enum.Font.GothamSemibold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SliderFrame,
    })

    local ValueLabel = create("TextLabel", {
        Name = "ValueLabel",
        Size = UDim2.new(0.35, 0, 0, 20),
        Position = UDim2.new(0.65, -12, 0, 6),
        BackgroundTransparency = 1,
        Text = tostring(math.round(defaultVal)) .. (suffix or ""),
        TextColor3 = THEME.AccentPurple,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = SliderFrame,
    })

    local Track = create("Frame", {
        Name = "Track",
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.new(0, 12, 0, 34),
        BackgroundColor3 = THEME.BackgroundLight,
        BorderSizePixel = 0,
        Parent = SliderFrame,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    })

    local initRatio = math.clamp((defaultVal - minVal) / (maxVal - minVal), 0, 1)
    local Fill = create("Frame", {
        Name = "Fill",
        Size = UDim2.new(initRatio, 0, 1, 0),
        BackgroundColor3 = THEME.AccentPurple,
        BorderSizePixel = 0,
        Parent = Track,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, THEME.AccentBlue),
                ColorSequenceKeypoint.new(1, THEME.AccentPurple),
            }),
        }),
    })

    local Knob = create("Frame", {
        Name = "Knob",
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(initRatio, -7, 0.5, -7),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = Track,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create("UIStroke", { Color = THEME.AccentPurple, Thickness = 2 }),
    })

    local isSliding = false

    local function updateFromInput(input)
        local trackAbsPos = Track.AbsolutePosition.X
        local trackAbsSize = Track.AbsoluteSize.X
        local ratio = math.clamp((input.Position.X - trackAbsPos) / trackAbsSize, 0, 1)
        local calcVal = minVal + ratio * (maxVal - minVal)
        currentValue = math.round(calcVal)

        ValueLabel.Text = tostring(currentValue) .. (suffix or "")
        Fill.Size = UDim2.new(ratio, 0, 1, 0)
        Knob.Position = UDim2.new(ratio, -7, 0.5, -7)

        if onValueChanged then
            pcall(onValueChanged, currentValue)
        end
    end

    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isSliding = true
            updateFromInput(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isSliding = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromInput(input)
        end
    end)

    return {
        SetValue = function(newVal)
            local ratio = math.clamp((newVal - minVal) / (maxVal - minVal), 0, 1)
            currentValue = newVal
            ValueLabel.Text = tostring(currentValue) .. (suffix or "")
            Fill.Size = UDim2.new(ratio, 0, 1, 0)
            Knob.Position = UDim2.new(ratio, -7, 0.5, -7)
            if onValueChanged then pcall(onValueChanged, currentValue) end
        end
    }
end

local hackSettings = {
    Gravity = workspace.Gravity,
    WalkSpeed = 16,
    JumpPower = 50,
}

local function applyCharacterMods(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.WalkSpeed = hackSettings.WalkSpeed
        humanoid.UseJumpPower = true
        humanoid.JumpPower = hackSettings.JumpPower
    end
end

if LocalPlayer and LocalPlayer.Character then
    applyCharacterMods(LocalPlayer.Character)
end
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(applyCharacterMods)
end

createSlider("Gravity", 0, 400, workspace.Gravity or 196.2, " u", function(val)
    hackSettings.Gravity = val
    workspace.Gravity = val
end)

createSlider("WalkSpeed", 0, 250, 16, " spd", function(val)
    hackSettings.WalkSpeed = val
    local char = LocalPlayer and LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = val
        end
    end
end)

createSlider("Jump Power", 0, 300, 50, " pwr", function(val)
    hackSettings.JumpPower = val
    local char = LocalPlayer and LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = val
        end
    end
end)

local ConsoleHeader = create("Frame", {
    Name = "ConsoleHeader",
    Size = UDim2.new(1, 0, 0, 36),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = THEME.CardBackground,
    BorderSizePixel = 0,
    Parent = ConsolePage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
    create("TextLabel", {
        Name = "HeaderTitle",
        Size = UDim2.new(0, 120, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        Text = "Output Console",
        TextColor3 = THEME.TextPrimary,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }),
})

local ConsoleCountBadge = create("TextLabel", {
    Name = "CountBadge",
    Size = UDim2.new(0, 65, 0, 20),
    Position = UDim2.new(0, 128, 0.5, -10),
    BackgroundColor3 = THEME.BackgroundLight,
    BackgroundTransparency = 0.5,
    Text = "0 logs",
    TextColor3 = THEME.TextSecondary,
    Font = Enum.Font.GothamMedium,
    TextSize = 10,
    Parent = ConsoleHeader,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 4) }),
})

local ClearConsoleBtn = create("TextButton", {
    Name = "ClearConsoleBtn",
    Size = UDim2.new(0, 80, 0, 26),
    Position = UDim2.new(1, -88, 0.5, -13),
    BackgroundColor3 = THEME.BackgroundLight,
    BackgroundTransparency = 0.7,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    Parent = ConsoleHeader,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 6) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
    create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 8, 0.5, -7),
        BackgroundTransparency = 1,
        Image = ICONS.Trash,
        ImageColor3 = THEME.TextPrimary,
    }),
    create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, -26, 1, 0),
        Position = UDim2.new(0, 24, 0, 0),
        BackgroundTransparency = 1,
        Text = "Clear",
        TextColor3 = THEME.TextPrimary,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }),
})

ClearConsoleBtn.MouseEnter:Connect(function()
    tween(ClearConsoleBtn, 0.2, { BackgroundColor3 = THEME.DangerRed, BackgroundTransparency = 0.3 })
end)
ClearConsoleBtn.MouseLeave:Connect(function()
    tween(ClearConsoleBtn, 0.2, { BackgroundColor3 = THEME.BackgroundLight, BackgroundTransparency = 0.7 })
end)

local ConsoleScroll = create("ScrollingFrame", {
    Name = "ConsoleScroll",
    Size = UDim2.new(1, 0, 1, -44),
    Position = UDim2.new(0, 0, 0, 44),
    BackgroundColor3 = THEME.BackgroundDark,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = THEME.AccentPurple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Parent = ConsolePage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
    create("UIPadding", {
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
    }),
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4),
    }),
})

local consoleLogsCount = 0

local function addConsoleLog(message, messageType)
    consoleLogsCount = consoleLogsCount + 1
    ConsoleCountBadge.Text = tostring(consoleLogsCount) .. " logs"

    local timeStamp = os.date("%H:%M:%S")
    local typeColor = THEME.TextPrimary
    local typeTag = "[INFO]"

    if messageType == Enum.MessageType.MessageWarning then
        typeColor = THEME.WarningYellow
        typeTag = "[WARN]"
    elseif messageType == Enum.MessageType.MessageError then
        typeColor = THEME.DangerRed
        typeTag = "[ERR]"
    elseif messageType == Enum.MessageType.MessageInfo then
        typeColor = THEME.AccentBlue
        typeTag = "[INFO]"
    end

    local cleanMsg = escapeXml(tostring(message))
    local colorRgb = string.format("rgb(%d,%d,%d)", math.round(typeColor.R * 255), math.round(typeColor.G * 255), math.round(typeColor.B * 255))
    local timeRgb = "rgb(110,120,150)"

    create("TextLabel", {
        Name = "LogEntry",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        RichText = true,
        Text = string.format('<font color="%s">[%s]</font> <font color="%s"><b>%s</b> %s</font>', timeRgb, timeStamp, colorRgb, typeTag, cleanMsg),
        Font = Enum.Font.Code,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = consoleLogsCount,
        Parent = ConsoleScroll,
    })

    if consoleLogsCount > 200 then
        for _, child in ipairs(ConsoleScroll:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
                break
            end
        end
    end

    ConsoleScroll.CanvasPosition = Vector2.new(0, 999999)
end

ClearConsoleBtn.MouseButton1Click:Connect(function()
    for _, child in ipairs(ConsoleScroll:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    consoleLogsCount = 0
    ConsoleCountBadge.Text = "0 logs"
end)

-- The private bridge already forwards LogService.MessageOut through
-- Host.OnLog.  Connecting to LogService here as well duplicated every console
-- line; one sink is enough.
if Host and type(Host.OnLog) == "function" then
    Host.OnLog(function(line)
        addConsoleLog(line, Enum.MessageType.MessageOutput)
    end)
end

local EditorCard = create("Frame", {
    Name = "EditorCard",
    Size = UDim2.new(1, 0, 1, -44),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = THEME.CardBackground,
    BorderSizePixel = 0,
    Parent = EditorPage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 10) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
})

local GutterFrame = create("Frame", {
    Name = "GutterFrame",
    Size = UDim2.new(0, 32, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = THEME.BackgroundDark,
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = EditorCard,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 10) }),
    create("Frame", {
        Name = "GutterBorder",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = THEME.BorderStroke,
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
    }),
})

local GutterLabel = create("TextLabel", {
    Name = "LineNumbers",
    Size = UDim2.new(1, -6, 1, 0),
    Position = UDim2.new(0, 0, 0, 8),
    BackgroundTransparency = 1,
    Text = "1",
    TextColor3 = THEME.TextMuted,
    Font = Enum.Font.Code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextYAlignment = Enum.TextYAlignment.Top,
    LineHeight = 1.15,
    Parent = GutterFrame,
})

local CodeScroll = create("ScrollingFrame", {
    Name = "CodeScroll",
    Size = UDim2.new(1, -36, 1, 0),
    Position = UDim2.new(0, 34, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 5,
    ScrollBarImageColor3 = THEME.AccentPurple,
    CanvasSize = UDim2.new(0, 800, 0, 400),
    Parent = EditorCard,
})

local HighlightLabel = create("TextLabel", {
    Name = "HighlightLabel",
    Size = UDim2.new(1, -16, 1, -16),
    Position = UDim2.new(0, 8, 0, 8),
    BackgroundTransparency = 1,
    RichText = true,
    Text = "",
    TextColor3 = THEME.TextPrimary,
    Font = Enum.Font.Code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    LineHeight = 1.15,
    ZIndex = 1,
    Parent = CodeScroll,
})

local EditorTextBox = create("TextBox", {
    Name = "EditorTextBox",
    Size = UDim2.new(1, -16, 1, -16),
    Position = UDim2.new(0, 8, 0, 8),
    BackgroundTransparency = 1,
    PlaceholderText = 'loadstring(game:HttpGet("https://..."))()',
    PlaceholderColor3 = Color3.fromRGB(90, 95, 110),
    Text = 'print("Hello from Hex!")\n',
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextTransparency = 0.88,
    Font = Enum.Font.Code,
    TextSize = 13,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    LineHeight = 1.15,
    ZIndex = 2,
    Parent = CodeScroll,
})

local function syncEditor()
    local text = EditorTextBox.Text
    local _, lineCount = text:gsub("\n", "\n")
    lineCount = lineCount + 1

    local nums = table.create(lineCount)
    for l = 1, lineCount do
        nums[l] = tostring(l)
    end
    GutterLabel.Text = table.concat(nums, "\n")
    HighlightLabel.Text = highlightLuau(text)

    local neededHeight = math.max(lineCount * 17 + 30, 200)
    CodeScroll.CanvasSize = UDim2.new(0, 900, 0, neededHeight)
    HighlightLabel.Size = UDim2.new(0, 880, 0, neededHeight)
    EditorTextBox.Size = UDim2.new(0, 880, 0, neededHeight)
end

CodeScroll:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    GutterLabel.Position = UDim2.new(0, 0, 0, 8 - CodeScroll.CanvasPosition.Y)
end)

local highlightPending = false
EditorTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    if highlightPending then return end
    highlightPending = true
    task.defer(function()
        highlightPending = false
        syncEditor()
    end)
end)

syncEditor()

local EditorActionBar = create("Frame", {
    Name = "EditorActionBar",
    Size = UDim2.new(1, 0, 0, 34),
    Position = UDim2.new(0, 0, 1, -34),
    BackgroundTransparency = 1,
    Parent = EditorPage,
}, {
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }),
})

local function createEditorButton(name, text, icon, isPrimary, onClick)
    local btnBg = isPrimary and THEME.AccentPurple or THEME.BackgroundLight
    local bgTrans = isPrimary and 0.15 or 0.75

    local Btn = create("TextButton", {
        Name = name .. "Btn",
        Size = UDim2.new(0.25, -6, 1, 0),
        BackgroundColor3 = btnBg,
        BackgroundTransparency = bgTrans,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = EditorActionBar,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create("UIStroke", {
            Color = isPrimary and THEME.AccentPurple or THEME.BorderStroke,
            Thickness = 1,
        }),
        create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(0, 10, 0.5, -8),
            BackgroundTransparency = 1,
            Image = icon,
            ImageColor3 = isPrimary and Color3.new(1, 1, 1) or THEME.TextPrimary,
        }),
        create("TextLabel", {
            Name = "Title",
            Size = UDim2.new(1, -32, 1, 0),
            Position = UDim2.new(0, 30, 0, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = isPrimary and Color3.new(1, 1, 1) or THEME.TextPrimary,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }),
    })

    if isPrimary then
        create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, THEME.AccentPurple),
                ColorSequenceKeypoint.new(1, THEME.AccentBlue),
            }),
            Parent = Btn,
        })
    end

    Btn.MouseEnter:Connect(function()
        tween(Btn, 0.2, { BackgroundTransparency = (isPrimary and 0 or 0.4) })
    end)
    Btn.MouseLeave:Connect(function()
        tween(Btn, 0.2, { BackgroundTransparency = bgTrans })
    end)

    if onClick then
        Btn.MouseButton1Click:Connect(function()
            local curSize = Btn.Size
            tween(Btn, 0.08, { Size = UDim2.new(curSize.X.Scale, curSize.X.Offset - 2, curSize.Y.Scale, curSize.Y.Offset - 2) }).Completed:Connect(function()
                tween(Btn, 0.12, { Size = curSize })
            end)
            onClick()
        end)
    end

    return Btn
end

_G.HexSavedScript = _G.HexSavedScript or ""

local lastExecuteTime = 0
local function executeCode(src, tag)
    local now = os.clock()
    if now - lastExecuteTime < 0.5 then return end
    lastExecuteTime = now

    if type(src) ~= "string" or #src == 0 or src:gsub("%s+", "") == "" then
        return
    end

    task.spawn(function()
        if Host and type(Host.Execute) == "function" then
            local ok, err = Host.Execute(src, tag or "editor")
            if not ok then
                addConsoleLog("error: " .. tostring(err), Enum.MessageType.MessageError)
            end
        else
            local fn, parseErr = loadstring(src)
            if not fn then
                addConsoleLog("syntax error: " .. tostring(parseErr), Enum.MessageType.MessageError)
                return
            end
            local ok, runErr = pcall(fn)
            if not ok then
                addConsoleLog("runtime error: " .. tostring(runErr), Enum.MessageType.MessageError)
            end
        end
    end)
end

createEditorButton("Execute", "Execute", ICONS.Play, true, function()
    executeCode(EditorTextBox.Text, "editor")
end)

createEditorButton("Clear", "Clear", ICONS.Trash, false, function()
    EditorTextBox.Text = ""
    syncEditor()
end)

createEditorButton("Save", "Save", ICONS.Save, false, function()
    local code = EditorTextBox.Text
    if writefile then
        pcall(writefile, "Hex_Script_" .. os.time() .. ".luau", code)
    elseif setclipboard then
        setclipboard(code)
        _G.HexSavedScript = code
    else
        _G.HexSavedScript = code
    end
end)

createEditorButton("ExecClipboard", "Execute Clipboard", ICONS.Clipboard, false, function()
    local clipText = ""
    if getclipboard then
        local success, res = pcall(getclipboard)
        if success and res then
            clipText = res
        end
    end

    if clipText == "" and _G.HexSavedScript and _G.HexSavedScript ~= "" then
        clipText = _G.HexSavedScript
    end

    if clipText ~= "" and clipText:gsub("%s+", "") ~= "" then
        executeCode(clipText, "clipboard")
    end
end)

local SettingsCard = create("Frame", {
    Name = "SettingsCard",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = THEME.CardBackground,
    BorderSizePixel = 0,
    Parent = SettingsPage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 10) }),
    create("UIStroke", { Color = THEME.BorderStroke, Thickness = 1 }),
    create("ImageLabel", {
        Name = "SettingsIcon",
        Size = UDim2.new(0, 48, 0, 48),
        Position = UDim2.new(0.5, -24, 0.35, -24),
        BackgroundTransparency = 1,
        Image = ICONS.Settings,
        ImageColor3 = THEME.TextMuted,
    }),
    create("TextLabel", {
        Name = "NoticeTitle",
        Size = UDim2.new(1, -40, 0, 24),
        Position = UDim2.new(0, 20, 0.35, 34),
        BackgroundTransparency = 1,
        Text = "Settings Hub",
        TextColor3 = THEME.TextPrimary,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
    }),
    create("TextLabel", {
        Name = "NoticeDesc",
        Size = UDim2.new(1, -40, 0, 20),
        Position = UDim2.new(0, 20, 0.35, 62),
        BackgroundTransparency = 1,
        Text = "Configuration preferences under development.",
        TextColor3 = THEME.TextSecondary,
        Font = Enum.Font.Gotham,
        TextSize = 12,
    }),
})

UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.Insert then
            if MainFrame.Visible then
                MainFrame.Visible = false
                MiniBtn.Visible = true
            else
                MainFrame.Visible = true
                MiniBtn.Visible = false
            end
        end
    end
end)

task.defer(function()
    task.wait()
    if Host and type(Host.Debug) == "function" then
        Host.Debug(string.format("UI layout abs=%s pos=%s scale=%.3f",
            tostring(MainFrame.AbsoluteSize), tostring(MainFrame.AbsolutePosition), fitScale))
    end
end)
