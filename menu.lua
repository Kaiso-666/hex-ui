--HEXUI_PROTOCOL 1
local GetService = Host.GetService

local CoreGui = GetService("CoreGui")
local UIS = GetService("UserInputService")
local Players = GetService("Players")
local TweenService = GetService("TweenService")
local ContextActionService = GetService("ContextActionService")
local RunService = GetService("RunService")
local Workspace = GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

for _, parent in ipairs({ CoreGui, PlayerGui }) do
    for _, name in ipairs({ "HexMenu", "HexV2" }) do
        local old = parent:FindFirstChild(name)
        if old then
            old:Destroy()
        end
    end
end

local uiScale = 1
local UI_SCALE_MIN, UI_SCALE_MAX = 0.5, 1.5

local function create(className, props, children)
    local inst = Host.New(className)
    for prop, val in pairs(props or {}) do
        if prop ~= "Parent" then
            inst[prop] = val
        end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    if props and props.Parent then
        inst.Parent = props.Parent
    end
    return inst
end

local function tween(inst, duration, props, style, dir)
    local info = TweenInfo.new(duration or 0.25, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out)
    local tw = TweenService:Create(inst, info, props)
    tw:Play()
    return tw
end

local function gradient(c1, c2, rotation)
    return create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, c1),
            ColorSequenceKeypoint.new(1, c2),
        }),
        Rotation = rotation or 0,
    })
end

local ScreenGui = create("ScreenGui", {
    Name = "HexV2",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999,
    Parent = CoreGui,
})

local ICONS = {
    Home        = "rbxassetid://10723407389",
    Console     = "rbxassetid://10734982144",
    Editor      = "rbxassetid://10709810463",
    Settings    = "rbxassetid://10734950309",
    SidebarOpen = "rbxassetid://10709797382",
    Play        = "rbxassetid://10734923549",
    Trash       = "rbxassetid://10747362241",
    Minimize    = "rbxassetid://10734896206",
    Close       = "rbxassetid://10747384394",
}

local THEME = {
    Base      = Color3.fromRGB(12, 14, 24),
    Panel     = Color3.fromRGB(18, 20, 34),
    PanelHi   = Color3.fromRGB(28, 30, 52),
    Sidebar   = Color3.fromRGB(14, 16, 28),
    Stroke    = Color3.fromRGB(44, 42, 74),
    Accent    = Color3.fromRGB(140, 92, 255),
    AccentAlt = Color3.fromRGB(72, 132, 255),
    Text      = Color3.fromRGB(240, 243, 255),
    Sub       = Color3.fromRGB(150, 156, 190),
    Muted     = Color3.fromRGB(96, 103, 135),
    Success   = Color3.fromRGB(60, 220, 140),
    Warning   = Color3.fromRGB(255, 195, 60),
    Danger    = Color3.fromRGB(255, 85, 95),
}

local function drawCube(parent, size, color, thickness)
    local k = size / 24
    local container = create("Frame", {
        Name = "CubeIcon",
        Size = UDim2.fromOffset(size, size),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1,
        Parent = parent,
    })
    local edges = {
        { 12, 2, 21, 7 }, { 21, 7, 21, 17 }, { 21, 17, 12, 22 },
        { 12, 22, 3, 17 }, { 3, 17, 3, 7 }, { 3, 7, 12, 2 },
        { 3, 7, 12, 12 }, { 12, 12, 21, 7 }, { 12, 12, 12, 22 },
    }
    for _, e in ipairs(edges) do
        local x1, y1, x2, y2 = e[1] * k, e[2] * k, e[3] * k, e[4] * k
        local dx, dy = x2 - x1, y2 - y1
        local len = math.sqrt(dx * dx + dy * dy)
        create("Frame", {
            Name = "Edge",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2),
            Size = UDim2.fromOffset(len + thickness, thickness),
            Rotation = math.deg(math.atan2(dy, dx)),
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            Parent = container,
        }, {
            create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        })
    end
    return container
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
    ["self"] = true,
}

local BUILTINS = {
    ["print"] = true, ["warn"] = true, ["error"] = true, ["pairs"] = true,
    ["ipairs"] = true, ["next"] = true, ["tostring"] = true, ["tonumber"] = true,
    ["typeof"] = true, ["pcall"] = true, ["xpcall"] = true, ["select"] = true,
    ["rawget"] = true, ["rawset"] = true, ["setmetatable"] = true, ["getmetatable"] = true,
    ["task"] = true, ["math"] = true, ["table"] = true, ["string"] = true,
    ["game"] = true, ["workspace"] = true, ["script"] = true, ["Instance"] = true,
    ["Vector3"] = true, ["Vector2"] = true, ["CFrame"] = true, ["Color3"] = true,
    ["UDim2"] = true, ["UDim"] = true, ["Enum"] = true, ["TweenInfo"] = true,
    ["wait"] = true, ["spawn"] = true, ["delay"] = true,
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

local function span(color, text)
    return string.format('<font color="%s">%s</font>', color, text)
end

local function highlightLuau(src)
    local result = {}
    local i = 1
    local len = #src

    while i <= len do
        if src:sub(i, i + 3) == "--[[" then
            local finish = src:find("]]", i + 4, true)
            local stop = finish and finish + 1 or len
            table.insert(result, span(SYNTAX_COLORS.comment, escapeXml(src:sub(i, stop))))
            i = stop + 1
        elseif src:sub(i, i + 1) == "--" then
            local finish = src:find("\n", i + 2, true)
            local stop = finish and finish - 1 or len
            table.insert(result, span(SYNTAX_COLORS.comment, escapeXml(src:sub(i, stop))))
            i = stop + 1
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
            table.insert(result, span(SYNTAX_COLORS.string, escapeXml(src:sub(i, j))))
            i = j + 1
        elseif src:sub(i, i + 1) == "[[" then
            local finish = src:find("]]", i + 2, true)
            local stop = finish and finish + 1 or len
            table.insert(result, span(SYNTAX_COLORS.string, escapeXml(src:sub(i, stop))))
            i = stop + 1
        elseif src:sub(i):match("^0[xX]%x+") then
            local m = src:sub(i):match("^0[xX]%x+")
            table.insert(result, span(SYNTAX_COLORS.number, m))
            i = i + #m
        elseif src:sub(i, i):match("%d") then
            local m = src:sub(i):match("^%d+%.?%d*")
            table.insert(result, span(SYNTAX_COLORS.number, m))
            i = i + #m
        elseif src:sub(i):match("^[%a_][%w_]*") then
            local word = src:sub(i):match("^[%a_][%w_]*")
            if word == "true" or word == "false" or word == "nil" then
                table.insert(result, span(SYNTAX_COLORS.boolean, word))
            elseif KEYWORDS[word] then
                table.insert(result, span(SYNTAX_COLORS.keyword, word))
            elseif BUILTINS[word] then
                table.insert(result, span(SYNTAX_COLORS.builtin, word))
            else
                table.insert(result, span(SYNTAX_COLORS.default, escapeXml(word)))
            end
            i = i + #word
        elseif src:sub(i, i):match("[%+%-%*%/%%%^#=<>&|~:;,%.%(%)%{%}%[%]]") then
            table.insert(result, span(SYNTAX_COLORS.operator, escapeXml(src:sub(i, i))))
            i = i + 1
        else
            table.insert(result, escapeXml(src:sub(i, i)))
            i = i + 1
        end
    end

    return table.concat(result)
end

local MAIN_WIDTH = 680
local MAIN_HEIGHT = 440
local TOPBAR_HEIGHT = 46
local SIDEBAR_COLLAPSED = 58
local SIDEBAR_EXPANDED = 164

local MainFrame = create("Frame", {
    Name = "MainFrame",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, MAIN_WIDTH, 0, MAIN_HEIGHT),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = THEME.Base,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Active = true,
    Parent = ScreenGui,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 16) }),
    create("UIStroke", { Color = THEME.Stroke, Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }),
    gradient(Color3.fromRGB(16, 18, 34), Color3.fromRGB(10, 12, 22), 135),
    create("UIScale", { Name = "HexScale", Scale = uiScale }),
})

local Topbar = create("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, TOPBAR_HEIGHT),
    BackgroundColor3 = THEME.Panel,
    BackgroundTransparency = 0.35,
    BorderSizePixel = 0,
    Active = true,
    Parent = MainFrame,
}, {
    create("Frame", {
        Name = "Divider",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = THEME.Stroke,
        BorderSizePixel = 0,
    }),
})

drawCube(create("Frame", {
    Name = "Brand",
    Size = UDim2.fromOffset(26, 26),
    Position = UDim2.new(0, 14, 0.5, -13),
    BackgroundColor3 = THEME.Accent,
    BorderSizePixel = 0,
    Parent = Topbar,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    gradient(THEME.Accent, THEME.AccentAlt, 135),
}), 16, Color3.new(1, 1, 1), 2)

create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(0, 60, 1, 0),
    Position = UDim2.new(0, 48, 0, 0),
    BackgroundTransparency = 1,
    Text = "Hex",
    TextColor3 = THEME.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Topbar,
})

create("TextLabel", {
    Name = "Version",
    Size = UDim2.fromOffset(34, 17),
    Position = UDim2.new(0, 90, 0.5, -8),
    BackgroundColor3 = THEME.Accent,
    BackgroundTransparency = 0.8,
    Text = "V2",
    TextColor3 = THEME.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    Parent = Topbar,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
})

local WindowControls = create("Frame", {
    Name = "WindowControls",
    Size = UDim2.new(0, 70, 1, 0),
    Position = UDim2.new(1, -78, 0, 0),
    BackgroundTransparency = 1,
    Parent = Topbar,
})

local function makeControl(name, icon, xOffset)
    return create("ImageButton", {
        Name = name,
        Size = UDim2.fromOffset(26, 26),
        Position = UDim2.new(0, xOffset, 0.5, -13),
        BackgroundColor3 = THEME.PanelHi,
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        Image = icon,
        ImageColor3 = THEME.Sub,
        AutoButtonColor = false,
        Parent = WindowControls,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    })
end

local MinimizeBtn = makeControl("MinimizeBtn", ICONS.Minimize, 6)
local CloseBtn = makeControl("CloseBtn", ICONS.Close, 38)

local MiniBtn = create("TextButton", {
    Name = "HexToggle",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 16, 0.5, -24),
    BackgroundColor3 = THEME.Accent,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    Parent = ScreenGui,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    create("UIStroke", { Color = THEME.Text, Thickness = 1, Transparency = 0.8 }),
    gradient(THEME.Accent, THEME.AccentAlt, 135),
    create("UIScale", { Name = "HexScale", Scale = uiScale }),
})
drawCube(MiniBtn, 24, Color3.new(1, 1, 1), 2)

MiniBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniBtn.Visible = false
end)

MinimizeBtn.MouseEnter:Connect(function()
    tween(MinimizeBtn, 0.2, { BackgroundTransparency = 0.2, ImageColor3 = THEME.Text })
end)
MinimizeBtn.MouseLeave:Connect(function()
    tween(MinimizeBtn, 0.2, { BackgroundTransparency = 0.6, ImageColor3 = THEME.Sub })
end)
CloseBtn.MouseEnter:Connect(function()
    tween(CloseBtn, 0.2, { BackgroundColor3 = THEME.Danger, BackgroundTransparency = 0.1, ImageColor3 = Color3.new(1, 1, 1) })
end)
CloseBtn.MouseLeave:Connect(function()
    tween(CloseBtn, 0.2, { BackgroundColor3 = THEME.PanelHi, BackgroundTransparency = 0.6, ImageColor3 = THEME.Sub })
end)

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    tween(MainFrame, 0.3, { Size = UDim2.new(0, MAIN_WIDTH, 0, isMinimized and TOPBAR_HEIGHT or MAIN_HEIGHT) })
end)

local function hideWindow()
    MainFrame.Visible = false
    MiniBtn.Visible = true
end

local function showWindow()
    MainFrame.Visible = true
    MiniBtn.Visible = false
end

CloseBtn.MouseButton1Click:Connect(hideWindow)

MiniBtn.MouseEnter:Connect(function()
    tween(MiniBtn, 0.2, { Size = UDim2.fromOffset(52, 52), Position = UDim2.new(0, 14, 0.5, -26) })
end)
MiniBtn.MouseLeave:Connect(function()
    tween(MiniBtn, 0.2, { Size = UDim2.fromOffset(48, 48), Position = UDim2.new(0, 16, 0.5, -24) })
end)

local isDragging = false
local dragStartPos, startFramePos
local dragStartCam
local DRAG_SINK_ACTION = "HexV2DragSink"
local DRAG_CAM_PIN = "HexV2DragCameraPin"

local function sinkDragInput()
    return Enum.ContextActionResult.Sink
end

local function beginDrag(input)
    isDragging = true
    dragStartPos = input.Position
    startFramePos = MainFrame.Position
    local cam = Workspace.CurrentCamera
    dragStartCam = cam and cam.CFrame or nil

    ContextActionService:BindActionAtPriority(
        DRAG_SINK_ACTION,
        sinkDragInput,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.UserInputType.MouseMovement,
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.Touch
    )

    RunService:BindToRenderStep(DRAG_CAM_PIN, Enum.RenderPriority.Camera.Value + 1, function()
        local c = Workspace.CurrentCamera
        if isDragging and c and dragStartCam then
            c.CFrame = dragStartCam
        end
    end)
end

local function endDrag()
    if not isDragging then return end
    isDragging = false
    dragStartCam = nil
    ContextActionService:UnbindAction(DRAG_SINK_ACTION)
    RunService:UnbindFromRenderStep(DRAG_CAM_PIN)
end

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        endDrag()
    end
end)

UIS.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = (input.Position - dragStartPos) / uiScale
        MainFrame.Position = UDim2.new(
            startFramePos.X.Scale,
            startFramePos.X.Offset + delta.X,
            startFramePos.Y.Scale,
            startFramePos.Y.Offset + delta.Y
        )
    end
end)

local Sidebar = create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, SIDEBAR_COLLAPSED, 1, -TOPBAR_HEIGHT),
    Position = UDim2.new(0, 0, 0, TOPBAR_HEIGHT),
    BackgroundColor3 = THEME.Sidebar,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 5,
    Parent = MainFrame,
}, {
    create("Frame", {
        Name = "RightBorder",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = THEME.Stroke,
        BorderSizePixel = 0,
    }),
})

local TabButtonsContainer = create("Frame", {
    Name = "TabButtons",
    Size = UDim2.new(1, 0, 1, -56),
    Position = UDim2.new(0, 0, 0, 10),
    BackgroundTransparency = 1,
    ZIndex = 6,
    Parent = Sidebar,
}, {
    create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
    }),
})

local SidebarToggleBtn = create("TextButton", {
    Name = "SidebarToggle",
    Size = UDim2.new(1, -12, 0, 36),
    Position = UDim2.new(0, 6, 1, -44),
    BackgroundColor3 = THEME.PanelHi,
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    ZIndex = 6,
    Parent = Sidebar,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 10) }),
})

local ToggleIcon = create("ImageLabel", {
    Name = "Icon",
    Size = UDim2.fromOffset(18, 18),
    Position = UDim2.new(0, 12, 0.5, -9),
    BackgroundTransparency = 1,
    Image = ICONS.SidebarOpen,
    ImageColor3 = THEME.Sub,
    ZIndex = 7,
    Parent = SidebarToggleBtn,
})

local ToggleLabel = create("TextLabel", {
    Name = "Label",
    Size = UDim2.new(1, -44, 1, 0),
    Position = UDim2.new(0, 40, 0, 0),
    BackgroundTransparency = 1,
    Text = "Collapse",
    TextColor3 = THEME.Sub,
    Font = Enum.Font.GothamMedium,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTransparency = 1,
    ZIndex = 7,
    Parent = SidebarToggleBtn,
})

local ContentContainer = create("Frame", {
    Name = "ContentContainer",
    Size = UDim2.new(1, -(SIDEBAR_COLLAPSED + 24), 1, -(TOPBAR_HEIGHT + 12)),
    Position = UDim2.new(0, SIDEBAR_COLLAPSED + 12, 0, TOPBAR_HEIGHT + 10),
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

local function setSidebar(expanded)
    isSidebarExpanded = expanded
    local w = expanded and SIDEBAR_EXPANDED or SIDEBAR_COLLAPSED
    tween(Sidebar, 0.3, { Size = UDim2.new(0, w, 1, -TOPBAR_HEIGHT) })
    tween(ContentContainer, 0.3, {
        Position = UDim2.new(0, w + 12, 0, TOPBAR_HEIGHT + 10),
        Size = UDim2.new(1, -(w + 24), 1, -(TOPBAR_HEIGHT + 12)),
    })
    tween(ToggleIcon, 0.3, { Rotation = expanded and 180 or 0 })
    tween(ToggleLabel, 0.25, { TextTransparency = expanded and 0 or 1 })
    for _, data in pairs(TabButtons) do
        tween(data.Label, 0.25, { TextTransparency = expanded and 0 or 1 })
    end
end

SidebarToggleBtn.MouseButton1Click:Connect(function()
    setSidebar(not isSidebarExpanded)
end)
SidebarToggleBtn.MouseEnter:Connect(function()
    tween(SidebarToggleBtn, 0.2, { BackgroundTransparency = 0.3 })
    tween(ToggleIcon, 0.2, { ImageColor3 = THEME.Text })
end)
SidebarToggleBtn.MouseLeave:Connect(function()
    tween(SidebarToggleBtn, 0.2, { BackgroundTransparency = 0.6 })
    tween(ToggleIcon, 0.2, { ImageColor3 = THEME.Sub })
end)

local function setTabActive(id, active)
    local data = TabButtons[id]
    if not data then return end
    if active then
        tween(data.Button, 0.25, { BackgroundTransparency = 0.25 })
        tween(data.Icon, 0.25, { ImageColor3 = THEME.Accent })
        tween(data.Label, 0.25, { TextColor3 = THEME.Text })
        tween(data.Indicator, 0.25, { BackgroundTransparency = 0, Size = UDim2.new(0, 3, 0, 18) })
    else
        tween(data.Button, 0.25, { BackgroundTransparency = 1 })
        tween(data.Icon, 0.25, { ImageColor3 = THEME.Sub })
        tween(data.Label, 0.25, { TextColor3 = THEME.Sub })
        tween(data.Indicator, 0.25, { BackgroundTransparency = 1, Size = UDim2.new(0, 3, 0, 0) })
    end
end

local function switchTab(targetId)
    if CurrentTabId == targetId then
        if isSidebarExpanded then setSidebar(false) end
        return
    end

    local oldPage = TabPages[CurrentTabId]
    local newPage = TabPages[targetId]
    if not newPage then return end

    setTabActive(CurrentTabId, false)
    setTabActive(targetId, true)

    if isSidebarExpanded then setSidebar(false) end

    if oldPage then
        local outTw = tween(oldPage, 0.2, { Position = UDim2.new(0, -24, 0, 0), BackgroundTransparency = 1 })
        outTw.Completed:Connect(function()
            oldPage.Visible = false
        end)
    end

    newPage.Visible = true
    newPage.Position = UDim2.new(0, 24, 0, 0)
    tween(newPage, 0.3, { Position = UDim2.new(0, 0, 0, 0) })

    CurrentTabId = targetId
end

for _, tab in ipairs(TabData) do
    local isInitial = (tab.Id == "Home")
    local TabButton = create("TextButton", {
        Name = tab.Id .. "TabBtn",
        Size = UDim2.new(1, -14, 0, 38),
        BackgroundColor3 = THEME.PanelHi,
        BackgroundTransparency = isInitial and 0.25 or 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = tab.Order,
        ZIndex = 6,
        Parent = TabButtonsContainer,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 10) }),
        create("Frame", {
            Name = "ActiveIndicator",
            Size = UDim2.new(0, 3, 0, isInitial and 18 or 0),
            Position = UDim2.new(0, 0, 0.5, -9),
            BackgroundColor3 = THEME.Accent,
            BackgroundTransparency = isInitial and 0 or 1,
            BorderSizePixel = 0,
            ZIndex = 7,
        }, {
            create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        }),
        create("ImageLabel", {
            Name = "Icon",
            Size = UDim2.fromOffset(20, 20),
            Position = UDim2.new(0, 12, 0.5, -10),
            BackgroundTransparency = 1,
            Image = tab.Icon,
            ImageColor3 = isInitial and THEME.Accent or THEME.Sub,
            ZIndex = 7,
        }),
        create("TextLabel", {
            Name = "TitleLabel",
            Size = UDim2.new(1, -44, 1, 0),
            Position = UDim2.new(0, 42, 0, 0),
            BackgroundTransparency = 1,
            Text = tab.Title,
            TextColor3 = isInitial and THEME.Text or THEME.Sub,
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
            tween(TabButton, 0.2, { BackgroundTransparency = 0.6 })
            tween(TabButton.Icon, 0.2, { ImageColor3 = THEME.Text })
        end
    end)
    TabButton.MouseLeave:Connect(function()
        if CurrentTabId ~= tab.Id then
            tween(TabButton, 0.2, { BackgroundTransparency = 1 })
            tween(TabButton.Icon, 0.2, { ImageColor3 = THEME.Sub })
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

local function card(size, position, parent)
    return create("Frame", {
        Size = size,
        Position = position,
        BackgroundColor3 = THEME.Panel,
        BorderSizePixel = 0,
        Parent = parent,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 14) }),
        create("UIStroke", { Color = THEME.Stroke, Thickness = 1 }),
        gradient(Color3.fromRGB(24, 26, 46), Color3.fromRGB(16, 18, 32), 90),
    })
end

local ProfileCard = card(UDim2.new(1, 0, 0, 84), UDim2.new(0, 0, 0, 0), HomePage)

local safeUserId = (LocalPlayer.UserId and LocalPlayer.UserId > 0) and LocalPlayer.UserId or 1
local AvatarRing = create("Frame", {
    Name = "AvatarRing",
    Size = UDim2.fromOffset(58, 58),
    Position = UDim2.new(0, 14, 0.5, -29),
    BackgroundColor3 = THEME.Accent,
    BorderSizePixel = 0,
    Parent = ProfileCard,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    gradient(THEME.Accent, THEME.AccentAlt, 135),
})

local AvatarImage = create("ImageLabel", {
    Name = "AvatarImage",
    Size = UDim2.new(1, -4, 1, -4),
    Position = UDim2.new(0, 2, 0, 2),
    BackgroundColor3 = THEME.PanelHi,
    Image = "rbxthumb://type=AvatarHeadShot&id=" .. safeUserId .. "&w=150&h=150",
    Parent = AvatarRing,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
})

create("Frame", {
    Name = "StatusDot",
    Size = UDim2.fromOffset(12, 12),
    Position = UDim2.new(1, -12, 1, -12),
    BackgroundColor3 = THEME.Success,
    BorderSizePixel = 0,
    ZIndex = 3,
    Parent = AvatarRing,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    create("UIStroke", { Color = THEME.Panel, Thickness = 2 }),
})

create("TextLabel", {
    Name = "GreetingTitle",
    Size = UDim2.new(1, -100, 0, 24),
    Position = UDim2.new(0, 88, 0, 18),
    BackgroundTransparency = 1,
    Text = "Hello, " .. LocalPlayer.Name,
    TextColor3 = THEME.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
})

create("TextLabel", {
    Name = "GreetingSubtitle",
    Size = UDim2.new(1, -100, 0, 18),
    Position = UDim2.new(0, 88, 0, 44),
    BackgroundTransparency = 1,
    Text = "Display: " .. LocalPlayer.DisplayName .. "  ·  Hex V2 ready",
    TextColor3 = THEME.Sub,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ProfileCard,
})

Host.Spawn(function()
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

local QuickCard = card(UDim2.new(1, 0, 1, -96), UDim2.new(0, 0, 0, 96), HomePage)

create("TextLabel", {
    Name = "SectionHeader",
    Size = UDim2.new(1, -28, 0, 22),
    Position = UDim2.new(0, 16, 0, 12),
    BackgroundTransparency = 1,
    Text = "QUICK TUNING",
    TextColor3 = THEME.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = QuickCard,
})

local SlidersContainer = create("Frame", {
    Name = "SlidersContainer",
    Size = UDim2.new(1, -32, 1, -46),
    Position = UDim2.new(0, 16, 0, 40),
    BackgroundTransparency = 1,
    Parent = QuickCard,
}, {
    create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 12),
    }),
})

local function createSlider(title, minVal, maxVal, defaultVal, suffix, onValueChanged, parent)
    local SliderFrame = create("Frame", {
        Name = title .. "Slider",
        Size = UDim2.new(1, 0, 0, 54),
        BackgroundColor3 = THEME.Base,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Parent = parent or SlidersContainer,
    }, {
        create("UICorner", { CornerRadius = UDim.new(0, 10) }),
        create("UIStroke", { Color = THEME.Stroke, Thickness = 1 }),
    })

    create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0.6, 0, 0, 20),
        Position = UDim2.new(0, 14, 0, 8),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = THEME.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = SliderFrame,
    })

    local ValueLabel = create("TextLabel", {
        Name = "ValueLabel",
        Size = UDim2.new(0.35, 0, 0, 20),
        Position = UDim2.new(0.65, -14, 0, 8),
        BackgroundTransparency = 1,
        Text = tostring(math.round(defaultVal)) .. (suffix or ""),
        TextColor3 = THEME.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = SliderFrame,
    })

    local Track = create("Frame", {
        Name = "Track",
        Size = UDim2.new(1, -28, 0, 6),
        Position = UDim2.new(0, 14, 0, 36),
        BackgroundColor3 = THEME.PanelHi,
        BorderSizePixel = 0,
        Parent = SliderFrame,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    })

    local initRatio = math.clamp((defaultVal - minVal) / (maxVal - minVal), 0, 1)
    local Fill = create("Frame", {
        Name = "Fill",
        Size = UDim2.new(initRatio, 0, 1, 0),
        BackgroundColor3 = THEME.Accent,
        BorderSizePixel = 0,
        Parent = Track,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        gradient(THEME.AccentAlt, THEME.Accent, 0),
    })

    local Knob = create("Frame", {
        Name = "Knob",
        Size = UDim2.fromOffset(14, 14),
        Position = UDim2.new(initRatio, -7, 0.5, -7),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = Track,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create("UIStroke", { Color = THEME.Accent, Thickness = 2 }),
    })

    local isSliding = false

    local function apply(ratio)
        local value = math.round(minVal + ratio * (maxVal - minVal))
        ValueLabel.Text = tostring(value) .. (suffix or "")
        Fill.Size = UDim2.new(ratio, 0, 1, 0)
        Knob.Position = UDim2.new(ratio, -7, 0.5, -7)
        if onValueChanged then
            pcall(onValueChanged, value)
        end
    end

    local function updateFromInput(input)
        local trackAbsPos = Track.AbsolutePosition.X
        local trackAbsSize = Track.AbsoluteSize.X
        if trackAbsSize <= 0 then return end
        apply(math.clamp((input.Position.X - trackAbsPos) / trackAbsSize, 0, 1))
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

    return SliderFrame
end

local function getHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

createSlider("Gravity", 0, 400, Workspace.Gravity, " u", function(val)
    Workspace.Gravity = val
end, SlidersContainer)

createSlider("WalkSpeed", 0, 250, 16, " spd", function(val)
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = val end
end, SlidersContainer)

createSlider("Jump Power", 0, 300, 50, " pwr", function(val)
    local hum = getHumanoid()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = val
    end
end, SlidersContainer)

local ConsoleHeader = card(UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 0), ConsolePage)

create("TextLabel", {
    Name = "HeaderTitle",
    Size = UDim2.new(0, 140, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    BackgroundTransparency = 1,
    Text = "Output Console",
    TextColor3 = THEME.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ConsoleHeader,
})

local ConsoleCountBadge = create("TextLabel", {
    Name = "CountBadge",
    Size = UDim2.fromOffset(64, 20),
    Position = UDim2.new(0, 140, 0.5, -10),
    BackgroundColor3 = THEME.PanelHi,
    BackgroundTransparency = 0.2,
    Text = "0 logs",
    TextColor3 = THEME.Sub,
    Font = Enum.Font.GothamMedium,
    TextSize = 10,
    Parent = ConsoleHeader,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
})

local ClearConsoleBtn = create("TextButton", {
    Name = "ClearConsoleBtn",
    Size = UDim2.fromOffset(84, 26),
    Position = UDim2.new(1, -94, 0.5, -13),
    BackgroundColor3 = THEME.PanelHi,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    Parent = ConsoleHeader,
}, {
    create("UICorner", { CornerRadius = UDim.new(1, 0) }),
    create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.fromOffset(13, 13),
        Position = UDim2.new(0, 12, 0.5, -6),
        BackgroundTransparency = 1,
        Image = ICONS.Trash,
        ImageColor3 = THEME.Text,
    }),
    create("TextLabel", {
        Name = "Text",
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = "Clear",
        TextColor3 = THEME.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    }),
})

ClearConsoleBtn.MouseEnter:Connect(function()
    tween(ClearConsoleBtn, 0.2, { BackgroundColor3 = THEME.Danger, BackgroundTransparency = 0.2 })
end)
ClearConsoleBtn.MouseLeave:Connect(function()
    tween(ClearConsoleBtn, 0.2, { BackgroundColor3 = THEME.PanelHi, BackgroundTransparency = 0.4 })
end)

local ConsoleScroll = create("ScrollingFrame", {
    Name = "ConsoleScroll",
    Size = UDim2.new(1, 0, 1, -48),
    Position = UDim2.new(0, 0, 0, 48),
    BackgroundColor3 = THEME.Panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = THEME.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Parent = ConsolePage,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 14) }),
    create("UIStroke", { Color = THEME.Stroke, Thickness = 1 }),
    create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
    }),
    create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4),
    }),
})

local consoleLogsCount = 0
local MAX_CONSOLE_LINES = 200

local function addConsoleLog(message, color)
    consoleLogsCount = consoleLogsCount + 1
    ConsoleCountBadge.Text = tostring(consoleLogsCount) .. " logs"

    local stamp = string.format("%.1fs", Host.Clock())
    local rgb = color or THEME.Text
    local colorRgb = string.format("rgb(%d,%d,%d)", math.round(rgb.R * 255), math.round(rgb.G * 255), math.round(rgb.B * 255))

    create("TextLabel", {
        Name = "LogEntry",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        RichText = true,
        Text = string.format('<font color="rgb(110,120,150)">[%s]</font> <font color="%s">%s</font>', stamp, colorRgb, escapeXml(tostring(message))),
        Font = Enum.Font.Code,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = consoleLogsCount,
        Parent = ConsoleScroll,
    })

    if consoleLogsCount > MAX_CONSOLE_LINES then
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

Host.OnLog(function(line)
    addConsoleLog(line, THEME.AccentAlt)
end)

local EditorCard = card(UDim2.new(1, 0, 1, -46), UDim2.new(0, 0, 0, 0), EditorPage)
EditorCard.ClipsDescendants = true

local GutterFrame = create("Frame", {
    Name = "GutterFrame",
    Size = UDim2.new(0, 36, 1, 0),
    BackgroundColor3 = THEME.Base,
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = EditorCard,
}, {
    create("UICorner", { CornerRadius = UDim.new(0, 14) }),
    create("Frame", {
        Name = "GutterBorder",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, -1, 0, 0),
        BackgroundColor3 = THEME.Stroke,
        BorderSizePixel = 0,
    }),
})

local GutterLabel = create("TextLabel", {
    Name = "LineNumbers",
    Size = UDim2.new(1, -8, 1, 0),
    Position = UDim2.new(0, 0, 0, 10),
    BackgroundTransparency = 1,
    Text = "1",
    TextColor3 = THEME.Muted,
    Font = Enum.Font.Code,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextYAlignment = Enum.TextYAlignment.Top,
    LineHeight = 1.15,
    Parent = GutterFrame,
})

local CodeScroll = create("ScrollingFrame", {
    Name = "CodeScroll",
    Size = UDim2.new(1, -44, 1, 0),
    Position = UDim2.new(0, 40, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = THEME.Accent,
    CanvasSize = UDim2.new(0, 800, 0, 400),
    Parent = EditorCard,
})

local HighlightLabel = create("TextLabel", {
    Name = "HighlightLabel",
    Size = UDim2.new(0, 880, 0, 200),
    Position = UDim2.new(0, 8, 0, 8),
    BackgroundTransparency = 1,
    RichText = true,
    Text = "",
    TextColor3 = THEME.Text,
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
    Size = UDim2.new(0, 880, 0, 200),
    Position = UDim2.new(0, 8, 0, 8),
    BackgroundTransparency = 1,
    PlaceholderText = 'loadstring(game:HttpGet("https://..."))()',
    PlaceholderColor3 = THEME.Muted,
    Text = 'print("Hello from Hex V2!")\n',
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
    local _, newlines = text:gsub("\n", "\n")
    local lineCount = newlines + 1

    local nums = {}
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
    GutterLabel.Position = UDim2.new(0, 0, 0, 10 - CodeScroll.CanvasPosition.Y)
end)

local highlightPending = false
EditorTextBox:GetPropertyChangedSignal("Text"):Connect(function()
    if highlightPending then return end
    highlightPending = true
    Host.Spawn(function()
        Host.Wait(0.05)
        highlightPending = false
        syncEditor()
    end)
end)

syncEditor()

local EditorActionBar = create("Frame", {
    Name = "EditorActionBar",
    Size = UDim2.new(1, 0, 0, 36),
    Position = UDim2.new(0, 0, 1, -36),
    BackgroundTransparency = 1,
    Parent = EditorPage,
}, {
    create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }),
})

local function createEditorButton(name, text, icon, isPrimary, order, onClick)
    local Btn = create("TextButton", {
        Name = name .. "Btn",
        Size = UDim2.new(0.5, -4, 1, 0),
        BackgroundColor3 = isPrimary and THEME.Accent or THEME.PanelHi,
        BackgroundTransparency = isPrimary and 0 or 0.4,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        Parent = EditorActionBar,
    }, {
        create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create("UIStroke", {
            Color = isPrimary and THEME.Accent or THEME.Stroke,
            Thickness = 1,
            Transparency = isPrimary and 0.5 or 0,
        }),
    })

    if isPrimary then
        gradient(THEME.Accent, THEME.AccentAlt, 0).Parent = Btn
    end

    create("ImageLabel", {
        Name = "Icon",
        Size = UDim2.fromOffset(14, 14),
        Position = UDim2.new(0, 14, 0.5, -7),
        BackgroundTransparency = 1,
        Image = icon,
        ImageColor3 = THEME.Text,
        Parent = Btn,
    })

    create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -36, 1, 0),
        Position = UDim2.new(0, 34, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = THEME.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = Btn,
    })

    Btn.MouseEnter:Connect(function()
        tween(Btn, 0.2, { BackgroundTransparency = isPrimary and 0 or 0.15 })
    end)
    Btn.MouseLeave:Connect(function()
        tween(Btn, 0.2, { BackgroundTransparency = isPrimary and 0 or 0.4 })
    end)
    if onClick then
        Btn.MouseButton1Click:Connect(onClick)
    end
    return Btn
end

local lastExecuteClock = -1
local function executeCode(src, label)
    local now = Host.Clock()
    if lastExecuteClock >= 0 and now - lastExecuteClock < 0.5 then return end
    lastExecuteClock = now

    if type(src) ~= "string" or src:gsub("%s+", "") == "" then
        return
    end

    Host.Spawn(function()
        local ok, err = pcall(Host.Execute, src, label or "editor")
        if not ok then
            addConsoleLog("error: " .. tostring(err), THEME.Danger)
        end
    end)
end

createEditorButton("Execute", "Execute", ICONS.Play, true, 1, function()
    executeCode(EditorTextBox.Text, "editor")
end)

createEditorButton("Clear", "Clear", ICONS.Trash, false, 2, function()
    EditorTextBox.Text = ""
    syncEditor()
end)

local SettingsCard = card(UDim2.new(1, 0, 0, 150), UDim2.new(0, 0, 0, 0), SettingsPage)
SettingsCard.Name = "InterfaceCard"

create("TextLabel", {
    Name = "SectionHeader",
    Size = UDim2.new(1, -28, 0, 22),
    Position = UDim2.new(0, 16, 0, 12),
    BackgroundTransparency = 1,
    Text = "INTERFACE",
    TextColor3 = THEME.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SettingsCard,
})

local SettingsSliders = create("Frame", {
    Name = "SettingsSliders",
    Size = UDim2.new(1, -32, 1, -46),
    Position = UDim2.new(0, 16, 0, 40),
    BackgroundTransparency = 1,
    Parent = SettingsCard,
}, {
    create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 12),
    }),
})

createSlider("UI Scale", 50, 150, math.round(uiScale * 100), "%", function(val)
    uiScale = math.clamp(val / 100, UI_SCALE_MIN, UI_SCALE_MAX)
    local mainScale = MainFrame:FindFirstChild("HexScale")
    if mainScale then mainScale.Scale = uiScale end
    local miniScale = MiniBtn:FindFirstChild("HexScale")
    if miniScale then miniScale.Scale = uiScale end
end, SettingsSliders)

local AboutCard = card(UDim2.new(1, 0, 1, -162), UDim2.new(0, 0, 0, 162), SettingsPage)

create("TextLabel", {
    Name = "AboutTitle",
    Size = UDim2.new(1, -32, 0, 22),
    Position = UDim2.new(0, 16, 0, 14),
    BackgroundTransparency = 1,
    Text = "Hex V2",
    TextColor3 = THEME.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard,
})

create("TextLabel", {
    Name = "AboutDesc",
    Size = UDim2.new(1, -32, 0, 40),
    Position = UDim2.new(0, 16, 0, 40),
    BackgroundTransparency = 1,
    Text = "Drag the top bar to move the window. The cube button toggles it.",
    TextColor3 = THEME.Sub,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    Parent = AboutCard,
})

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.Insert then
        if MainFrame.Visible then
            hideWindow()
        else
            showWindow()
        end
    end
end)

Host.Log("Hex V2 loaded")
