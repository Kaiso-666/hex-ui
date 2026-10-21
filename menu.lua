-- Hex executor UI (public).
-- HEXUI_PROTOCOL 1
--
-- This file is loaded by the executor's private host bridge. It only builds the
-- Roblox UI and calls the small Host API; it contains no VM transport, codec,
-- capability bridge or host internals.

local Host = Host
local CoreGui = Host.GetService("CoreGui")
local UIS = Host.GetService("UserInputService")
local TextService = Host.GetService("TextService")

-- -------------------------------------------------------------------- menu
local gui = Instance.new("ScreenGui")
gui.Name = "HexMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
Host.Parent(gui, CoreGui)

-- ---------------------------------------------------------------- console
local consoleGui = Instance.new("ScreenGui")
consoleGui.Name = "HexConsole"
consoleGui.ResetOnSpawn = false
consoleGui.IgnoreGuiInset = false
consoleGui.DisplayOrder = 1000
consoleGui.Enabled = false
Host.Parent(consoleGui, CoreGui)

local consoleFrame = Instance.new("ScrollingFrame")
consoleFrame.Name = "Panel"
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

local function consolePush(line)
    line = tostring(line)
    if line == "" then return end
    if #line > MAX_CONSOLE_CHARS then
        line = line:sub(1, MAX_CONSOLE_CHARS) .. "..."
    end
    if consoleLines[#consoleLines] == line then return end
    consoleLines[#consoleLines + 1] = line
    if #consoleLines > MAX_CONSOLE_LINES then
        table.remove(consoleLines, 1)
    end
    consoleDirty = true
end

Host.OnLog(consolePush)

consoleClear.MouseButton1Click:Connect(function()
    consoleLines = {}
    consoleDirty = true
end)

-- One flush per 100 ms at most; TextService computes the wrapped height.
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

-- ---------------------------------------------------------------- main UI
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
title.Text = "HEX  |  remote"
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

-- --------------------------------------------------------------- execution
local lastExecute = 0
runBtn.MouseButton1Click:Connect(function()
    local now = os.clock()
    if now - lastExecute < 1.0 then return end
    lastExecute = now
    local src = editor.Text
    if type(src) ~= "string" or #src == 0 then
        status.Text = "empty source"
        return
    end
    status.Text = "running editor"
    task.spawn(function()
        local ok, err = Host.Execute(src, "editor")
        status.Text = ok and "executed editor" or ("error: " .. tostring(err))
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
