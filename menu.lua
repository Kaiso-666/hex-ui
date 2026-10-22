--HEXUI_PROTOCOL 1
local Host = Host
local GetService = Host.GetService
local CoreGui = GetService("CoreGui")
local Workspace = GetService("Workspace")
local Players = GetService("Players")

local warn = warn or function(...) Host.Log(...) end
local print = print or function(...) Host.Log(...) end

local game = {}
function game:GetService(name)
    local ok, service = pcall(GetService, name)
    if ok then
        return service
    end
    warn("service unavailable: " .. tostring(name))
    return nil
end

local task = {}
function task.spawn(fn, ...)
    return Host.Spawn(fn, ...)
end
function task.defer(fn, ...)
    return Host.Spawn(fn, ...)
end
function task.wait(seconds)
    Host.Wait(seconds or 0)
    return seconds or 0
end
function task.delay(seconds, fn)
    Host.Delay(seconds or 0, fn)
end

local vfs = {}
local clipboardText = ""

local function isfile(path)
    return vfs[path] ~= nil
end

local function readfile(path)
    local content = vfs[path]
    if content == nil then
        error("file not found: " .. tostring(path))
    end
    return content
end

local function writefile(path, content)
    vfs[path] = tostring(content)
end

local function listfiles(folder)
    local out = {}
    local prefix = folder .. "/"
    for path in pairs(vfs) do
        if string.sub(path, 1, #prefix) == prefix then
            table.insert(out, path)
        end
    end
    return out
end

local function setclipboard(text)
    clipboardText = tostring(text)
end

local function getclipboard()
    return clipboardText
end

local function runCode(source)
    if type(source) ~= "string" or source:gsub("%s+", "") == "" then
        return
    end
    Host.Spawn(function()
        local ok, err = pcall(Host.Execute, source, "editor")
        if not ok then
            Host.Log("error: " .. tostring(err))
        end
    end)
end

local function loadstring(source)
    if type(source) ~= "string" then
        return nil, "source must be a string"
    end
    return function()
        runCode(source)
    end
end

local G2L = {};

-- StarterGui.! | Hex - Minimal
G2L["1"] = Host.New("ScreenGui", CoreGui);
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.None;
G2L["1"]["Name"] = [[! | Hex - Minimal]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.! | Hex - Minimal.LocalScript
G2L["2"] = Host.New("LocalScript", G2L["1"]);



-- StarterGui.! | Hex - Minimal.pulse_glow
G2L["3"] = Host.New("ImageLabel", G2L["1"]);
G2L["3"]["ZIndex"] = 0;
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3"]["ImageTransparency"] = 0.7;
G2L["3"]["ImageColor3"] = Color3.fromRGB(105, 143, 242);
G2L["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["3"]["Image"] = [[rbxassetid://102299464796278]];
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["BackgroundTransparency"] = 1;
G2L["3"]["Name"] = [[pulse_glow]];
G2L["3"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.pulse_glow.pulse_glow
G2L["4"] = Host.New("ImageLabel", G2L["3"]);
G2L["4"]["ZIndex"] = 0;
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4"]["ImageTransparency"] = 0.7;
G2L["4"]["ImageColor3"] = Color3.fromRGB(105, 143, 242);
G2L["4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4"]["Image"] = [[rbxassetid://102299464796278]];
G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["BackgroundTransparency"] = 1;
G2L["4"]["Name"] = [[pulse_glow]];
G2L["4"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.pulse_glow.pulse_glow
G2L["5"] = Host.New("ImageLabel", G2L["3"]);
G2L["5"]["ZIndex"] = 0;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["ImageTransparency"] = 0.7;
G2L["5"]["ImageColor3"] = Color3.fromRGB(105, 143, 242);
G2L["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["5"]["Image"] = [[rbxassetid://102299464796278]];
G2L["5"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["Name"] = [[pulse_glow]];
G2L["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.btnposition
G2L["6"] = Host.New("Frame", G2L["1"]);
G2L["6"]["Visible"] = false;
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["Position"] = UDim2.new(-10, 0, -10, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Name"] = [[btnposition]];
G2L["6"]["BackgroundTransparency"] = 1;


-- StarterGui.! | Hex - Minimal.OpenUI
G2L["7"] = Host.New("ImageButton", G2L["1"]);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["AutoButtonColor"] = false;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(22, 24, 27);
G2L["7"]["ImageColor3"] = Color3.fromRGB(105, 143, 242);
G2L["7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7"]["Image"] = [[rbxassetid://105334603868078]];
G2L["7"]["Size"] = UDim2.new(0, 50, 0, 50);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Name"] = [[OpenUI]];
G2L["7"]["Position"] = UDim2.new(0.5, 0, 0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.UICorner
G2L["8"] = Host.New("UICorner", G2L["7"]);
G2L["8"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.UIStroke
G2L["9"] = Host.New("UIStroke", G2L["7"]);
G2L["9"]["Thickness"] = 2;
G2L["9"]["Color"] = Color3.fromRGB(105, 143, 242);


-- StarterGui.! | Hex - Minimal.OpenUI.UIStrokeOuter
G2L["a"] = Host.New("UIStroke", G2L["7"]);
G2L["a"]["Name"] = [[UIStrokeOuter]];
G2L["a"]["Thickness"] = 3;
G2L["a"]["Color"] = Color3.fromRGB(105, 143, 242);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main
G2L["b"] = Host.New("CanvasGroup", G2L["7"]);
G2L["b"]["BorderSizePixel"] = 0;
G2L["b"]["BackgroundColor3"] = Color3.fromRGB(22, 24, 27);
G2L["b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b"]["Name"] = [[! | Hex - Main]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.UIAspectRatioConstraint
G2L["c"] = Host.New("UIAspectRatioConstraint", G2L["b"]);
G2L["c"]["AspectRatio"] = 1.61619;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu
G2L["d"] = Host.New("Frame", G2L["b"]);
G2L["d"]["Visible"] = false;
G2L["d"]["ZIndex"] = 3;
G2L["d"]["BorderSizePixel"] = 0;
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(23, 25, 31);
G2L["d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["d"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d"]["Name"] = [[Menu]];
G2L["d"]["BackgroundTransparency"] = 0.45;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu
G2L["e"] = Host.New("Frame", G2L["d"]);
G2L["e"]["ZIndex"] = 2;
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["e"]["Size"] = UDim2.new(0.58017, 0, 0.38175, 0);
G2L["e"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["Name"] = [[ScriptMenu]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.UICorner
G2L["f"] = Host.New("UICorner", G2L["e"]);
G2L["f"]["CornerRadius"] = UDim.new(0.1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CodePlacement
G2L["10"] = Host.New("Frame", G2L["e"]);
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["10"]["Size"] = UDim2.new(0.90918, 0, 0.20002, 0);
G2L["10"]["Position"] = UDim2.new(0.0446, 0, 0.38495, 0);
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["Name"] = [[CodePlacement]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CodePlacement.UICorner
G2L["11"] = Host.New("UICorner", G2L["10"]);
G2L["11"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CodePlacement.ScrollingFrame
G2L["12"] = Host.New("ScrollingFrame", G2L["10"]);
G2L["12"]["Active"] = true;
G2L["12"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["12"]["Size"] = UDim2.new(0.9524, 0, 0.468, 0);
G2L["12"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["Position"] = UDim2.new(0.5007, 0, 0.5, 0);
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["ScrollBarThickness"] = 0;
G2L["12"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CodePlacement.ScrollingFrame.TextBox
G2L["13"] = Host.New("TextBox", G2L["12"]);
G2L["13"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["13"]["PlaceholderColor3"] = Color3.fromRGB(133, 139, 175);
G2L["13"]["BorderSizePixel"] = 0;
G2L["13"]["TextWrapped"] = true;
G2L["13"]["TextSize"] = 14;
G2L["13"]["TextColor3"] = Color3.fromRGB(133, 139, 175);
G2L["13"]["TextScaled"] = true;
G2L["13"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13"]["Font"] = Enum.Font.GothamSemibold;
G2L["13"]["PlaceholderText"] = [[My Fav Script :D]];
G2L["13"]["Size"] = UDim2.new(1.42278, 0, 0.468, 0);
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13"]["Text"] = [[]];
G2L["13"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CodePlacement.CanvasGroup
G2L["14"] = Host.New("CanvasGroup", G2L["10"]);
G2L["14"]["ZIndex"] = 2;
G2L["14"]["BorderSizePixel"] = 0;
G2L["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["14"]["Size"] = UDim2.new(0.23964, 0, 0.468, 0);
G2L["14"]["Position"] = UDim2.new(0.73726, 0, 0.266, 0);
G2L["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CodePlacement.CanvasGroup.UIGradient
G2L["15"] = Host.New("UIGradient", G2L["14"]);
G2L["15"]["Rotation"] = -180;
G2L["15"]["Transparency"] = NumberSequence.new(0, 1);
G2L["15"]["Color"] = ColorSequence.new(Color3.fromRGB(34, 33, 39), Color3.fromRGB(34, 33, 39));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.ImageLabel
G2L["16"] = Host.New("ImageLabel", G2L["e"]);
G2L["16"]["BorderSizePixel"] = 0;
G2L["16"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["Image"] = [[rbxassetid://76793970636872]];
G2L["16"]["Size"] = UDim2.new(0.07315, 0, 0.16819, 0);
G2L["16"]["Visible"] = false;
G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16"]["BackgroundTransparency"] = 1;
G2L["16"]["Rotation"] = 45;
G2L["16"]["Position"] = UDim2.new(0.8801, 0, 0.07261, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.FavoriteButton
G2L["17"] = Host.New("TextButton", G2L["e"]);
G2L["17"]["BorderSizePixel"] = 0;
G2L["17"]["TextSize"] = 14;
G2L["17"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17"]["BackgroundColor3"] = Color3.fromRGB(56, 59, 74);
G2L["17"]["Font"] = Enum.Font.SourceSans;
G2L["17"]["ZIndex"] = 2;
G2L["17"]["Size"] = UDim2.new(0.24566, 0, 0.19757, 0);
G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17"]["Text"] = [[]];
G2L["17"]["Name"] = [[FavoriteButton]];
G2L["17"]["Visible"] = false;
G2L["17"]["Position"] = UDim2.new(0.46789, 0, 0.67645, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.FavoriteButton.ImageLabel
G2L["18"] = Host.New("ImageLabel", G2L["17"]);
G2L["18"]["BorderSizePixel"] = 0;
G2L["18"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["18"]["Image"] = [[rbxassetid://82062242798816]];
G2L["18"]["Size"] = UDim2.new(0.16491, 0, 0.5, 0);
G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18"]["BackgroundTransparency"] = 1;
G2L["18"]["Position"] = UDim2.new(0.16056, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.FavoriteButton.UICorner
G2L["19"] = Host.New("UICorner", G2L["17"]);
G2L["19"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.FavoriteButton.TextLabel
G2L["1a"] = Host.New("TextLabel", G2L["17"]);
G2L["1a"]["TextWrapped"] = true;
G2L["1a"]["BorderSizePixel"] = 0;
G2L["1a"]["TextSize"] = 14;
G2L["1a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1a"]["TextScaled"] = true;
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["Font"] = Enum.Font.GothamBold;
G2L["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["BackgroundTransparency"] = 1;
G2L["1a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1a"]["Size"] = UDim2.new(0.6105, 0, 0.50065, 0);
G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a"]["Text"] = [[Save ]];
G2L["1a"]["Position"] = UDim2.new(0.62345, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CopyButton
G2L["1b"] = Host.New("TextButton", G2L["e"]);
G2L["1b"]["BorderSizePixel"] = 0;
G2L["1b"]["TextSize"] = 14;
G2L["1b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["1b"]["Font"] = Enum.Font.SourceSans;
G2L["1b"]["ZIndex"] = 2;
G2L["1b"]["Size"] = UDim2.new(0.08158, 0, 0.19757, 0);
G2L["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b"]["Text"] = [[]];
G2L["1b"]["Name"] = [[CopyButton]];
G2L["1b"]["Visible"] = false;
G2L["1b"]["Position"] = UDim2.new(0.35331, 0, 0.68, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CopyButton.ImageLabel
G2L["1c"] = Host.New("ImageLabel", G2L["1b"]);
G2L["1c"]["BorderSizePixel"] = 0;
G2L["1c"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c"]["Image"] = [[rbxassetid://94896558256649]];
G2L["1c"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c"]["BackgroundTransparency"] = 1;
G2L["1c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.CopyButton.UICorner
G2L["1d"] = Host.New("UICorner", G2L["1b"]);
G2L["1d"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.TextLabel
G2L["1e"] = Host.New("TextLabel", G2L["e"]);
G2L["1e"]["TextWrapped"] = true;
G2L["1e"]["BorderSizePixel"] = 0;
G2L["1e"]["TextSize"] = 14;
G2L["1e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1e"]["TextScaled"] = true;
G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["Font"] = Enum.Font.GothamMedium;
G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["BackgroundTransparency"] = 1;
G2L["1e"]["RichText"] = true;
G2L["1e"]["Size"] = UDim2.new(0.70864, 0, 0.07352, 0);
G2L["1e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e"]["Text"] = [[Please press the <font color="rgb(105, 143, 243)">Save</font> button, to name your Script,]];
G2L["1e"]["Position"] = UDim2.new(0.04378, 0, 0.24997, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.ExitButton
G2L["1f"] = Host.New("TextButton", G2L["e"]);
G2L["1f"]["BorderSizePixel"] = 0;
G2L["1f"]["TextSize"] = 14;
G2L["1f"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1f"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["1f"]["Font"] = Enum.Font.SourceSans;
G2L["1f"]["ZIndex"] = 2;
G2L["1f"]["Size"] = UDim2.new(0.08158, 0, 0.19757, 0);
G2L["1f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1f"]["Text"] = [[]];
G2L["1f"]["Name"] = [[ExitButton]];
G2L["1f"]["Visible"] = false;
G2L["1f"]["Position"] = UDim2.new(0.87159, 0, 0.67951, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.ExitButton.UICorner
G2L["20"] = Host.New("UICorner", G2L["1f"]);
G2L["20"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.ExitButton.ImageLabel
G2L["21"] = Host.New("ImageLabel", G2L["1f"]);
G2L["21"]["BorderSizePixel"] = 0;
G2L["21"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["21"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["21"]["Image"] = [[rbxassetid://103740833279681]];
G2L["21"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["21"]["BackgroundTransparency"] = 1;
G2L["21"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.RunButton
G2L["22"] = Host.New("TextButton", G2L["e"]);
G2L["22"]["BorderSizePixel"] = 0;
G2L["22"]["TextSize"] = 14;
G2L["22"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["22"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["22"]["Font"] = Enum.Font.SourceSans;
G2L["22"]["ZIndex"] = 2;
G2L["22"]["Size"] = UDim2.new(0.19664, 0, 0.198, 0);
G2L["22"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["22"]["Text"] = [[]];
G2L["22"]["Name"] = [[RunButton]];
G2L["22"]["Position"] = UDim2.new(0.0446, 0, 0.68009, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.RunButton.ImageLabel
G2L["23"] = Host.New("ImageLabel", G2L["22"]);
G2L["23"]["BorderSizePixel"] = 0;
G2L["23"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["23"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["23"]["Image"] = [[rbxassetid://110351064802458]];
G2L["23"]["Size"] = UDim2.new(0.1613, 0, 0.5, 0);
G2L["23"]["Visible"] = false;
G2L["23"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["23"]["BackgroundTransparency"] = 1;
G2L["23"]["Position"] = UDim2.new(0.17266, 0, 0.4826, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.RunButton.UICorner
G2L["24"] = Host.New("UICorner", G2L["22"]);
G2L["24"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.RunButton.TextLabel
G2L["25"] = Host.New("TextLabel", G2L["22"]);
G2L["25"]["TextWrapped"] = true;
G2L["25"]["BorderSizePixel"] = 0;
G2L["25"]["TextSize"] = 14;
G2L["25"]["TextScaled"] = true;
G2L["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["25"]["Font"] = Enum.Font.GothamBold;
G2L["25"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["25"]["BackgroundTransparency"] = 1;
G2L["25"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["25"]["Size"] = UDim2.new(0.90223, 0, 0.51, 0);
G2L["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["25"]["Text"] = [[Save]];
G2L["25"]["Position"] = UDim2.new(0.49682, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.LabelPlacement
G2L["26"] = Host.New("ScrollingFrame", G2L["e"]);
G2L["26"]["Active"] = true;
G2L["26"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["26"]["BorderSizePixel"] = 0;
G2L["26"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["26"]["Name"] = [[LabelPlacement]];
G2L["26"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["26"]["Size"] = UDim2.new(0.81639, 0, 0.08466, 0);
G2L["26"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["26"]["Position"] = UDim2.new(0.45198, 0, 0.14453, 0);
G2L["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["26"]["ScrollBarThickness"] = 0;
G2L["26"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.LabelPlacement.TextLabel
G2L["27"] = Host.New("TextLabel", G2L["26"]);
G2L["27"]["TextWrapped"] = true;
G2L["27"]["BorderSizePixel"] = 0;
G2L["27"]["TextSize"] = 14;
G2L["27"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["27"]["TextScaled"] = true;
G2L["27"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["27"]["Font"] = Enum.Font.GothamBold;
G2L["27"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["27"]["BackgroundTransparency"] = 1;
G2L["27"]["Size"] = UDim2.new(0.20194, 0, 0.08356, 0);
G2L["27"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["27"]["Text"] = [[Example Lua]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.ScriptMenu.ImageButton
G2L["28"] = Host.New("ImageButton", G2L["e"]);
G2L["28"]["BorderSizePixel"] = 0;
G2L["28"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["28"]["BackgroundTransparency"] = 1;
G2L["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["28"]["Image"] = [[rbxassetid://78391259860999]];
G2L["28"]["Size"] = UDim2.new(0.04857, 0, 0.11858, 0);
G2L["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["28"]["Position"] = UDim2.new(0.906, 0, 0.10818, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup
G2L["29"] = Host.New("Frame", G2L["d"]);
G2L["29"]["Visible"] = false;
G2L["29"]["ZIndex"] = 2;
G2L["29"]["BorderSizePixel"] = 0;
G2L["29"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["29"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["29"]["Size"] = UDim2.new(0.27238, 0, 0.28241, 0);
G2L["29"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["29"]["Name"] = [[MiniPopup]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.UICorner
G2L["2a"] = Host.New("UICorner", G2L["29"]);
G2L["2a"]["CornerRadius"] = UDim.new(0.15, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.FavoriteButton
G2L["2b"] = Host.New("TextButton", G2L["29"]);
G2L["2b"]["BorderSizePixel"] = 0;
G2L["2b"]["TextSize"] = 14;
G2L["2b"]["AutoButtonColor"] = false;
G2L["2b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2b"]["BackgroundColor3"] = Color3.fromRGB(56, 59, 74);
G2L["2b"]["Font"] = Enum.Font.SourceSans;
G2L["2b"]["ZIndex"] = 2;
G2L["2b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["2b"]["Size"] = UDim2.new(0.78669, 0, 0.29326, 0);
G2L["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2b"]["Text"] = [[]];
G2L["2b"]["Name"] = [[FavoriteButton]];
G2L["2b"]["Position"] = UDim2.new(0.5, 0, 0.685, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.FavoriteButton.LocalScript
G2L["2c"] = Host.New("LocalScript", G2L["2b"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.FavoriteButton.ImageLabel
G2L["2d"] = Host.New("ImageLabel", G2L["2b"]);
G2L["2d"]["BorderSizePixel"] = 0;
G2L["2d"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["2d"]["Image"] = [[rbxassetid://114505038667653]];
G2L["2d"]["Size"] = UDim2.new(0.12711, 0, 0.5, 0);
G2L["2d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2d"]["BackgroundTransparency"] = 1;
G2L["2d"]["Position"] = UDim2.new(0.125, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.FavoriteButton.UICorner
G2L["2e"] = Host.New("UICorner", G2L["2b"]);
G2L["2e"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.FavoriteButton.TextLabel
G2L["2f"] = Host.New("TextLabel", G2L["2b"]);
G2L["2f"]["TextWrapped"] = true;
G2L["2f"]["BorderSizePixel"] = 0;
G2L["2f"]["TextSize"] = 14;
G2L["2f"]["TextScaled"] = true;
G2L["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2f"]["Font"] = Enum.Font.GothamBold;
G2L["2f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2f"]["BackgroundTransparency"] = 1;
G2L["2f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["2f"]["Size"] = UDim2.new(0.68763, 0, 0.50065, 0);
G2L["2f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2f"]["Text"] = [[Confirmation]];
G2L["2f"]["Position"] = UDim2.new(0.57956, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.TextLabel
G2L["30"] = Host.New("TextLabel", G2L["29"]);
G2L["30"]["TextWrapped"] = true;
G2L["30"]["BorderSizePixel"] = 0;
G2L["30"]["TextSize"] = 14;
G2L["30"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["30"]["TextScaled"] = true;
G2L["30"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["30"]["Font"] = Enum.Font.GothamBold;
G2L["30"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["30"]["BackgroundTransparency"] = 1;
G2L["30"]["Size"] = UDim2.new(0.54068, 0, 0.13054, 0);
G2L["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["30"]["Text"] = [[Run This Script?]];
G2L["30"]["Position"] = UDim2.new(0.10662, 0, 0.13522, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.ImageButton
G2L["31"] = Host.New("ImageButton", G2L["29"]);
G2L["31"]["BorderSizePixel"] = 0;
G2L["31"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["31"]["BackgroundTransparency"] = 1;
G2L["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["31"]["Image"] = [[rbxassetid://78391259860999]];
G2L["31"]["Size"] = UDim2.new(0.08651, 0, 0.13076, 0);
G2L["31"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["31"]["Position"] = UDim2.new(0.828, 0, 0.135, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.TextLabel
G2L["32"] = Host.New("TextLabel", G2L["29"]);
G2L["32"]["TextWrapped"] = true;
G2L["32"]["BorderSizePixel"] = 0;
G2L["32"]["TextSize"] = 14;
G2L["32"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["32"]["TextScaled"] = true;
G2L["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["32"]["Font"] = Enum.Font.GothamMedium;
G2L["32"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["32"]["BackgroundTransparency"] = 1;
G2L["32"]["RichText"] = true;
G2L["32"]["Size"] = UDim2.new(0.722, 0, 0.11364, 0);
G2L["32"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["32"]["Text"] = [[Sure you want to <font color="rgb(105, 143, 243)">Run this</font>?]];
G2L["32"]["Position"] = UDim2.new(0.106, 0, 0.33, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.Filler4
G2L["33"] = Host.New("Frame", G2L["d"]);
G2L["33"]["BorderSizePixel"] = 0;
G2L["33"]["BackgroundColor3"] = Color3.fromRGB(23, 25, 31);
G2L["33"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["33"]["Size"] = UDim2.new(1, 0, 0.237, 0);
G2L["33"]["Position"] = UDim2.new(0.5, 0, 1.117, 0);
G2L["33"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["33"]["Name"] = [[Filler4]];
G2L["33"]["BackgroundTransparency"] = 0.45;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.Filler3
G2L["34"] = Host.New("Frame", G2L["d"]);
G2L["34"]["BorderSizePixel"] = 0;
G2L["34"]["BackgroundColor3"] = Color3.fromRGB(23, 25, 31);
G2L["34"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["34"]["Size"] = UDim2.new(1, 0, 0.237, 0);
G2L["34"]["Position"] = UDim2.new(0.5, 0, -0.117, 0);
G2L["34"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["34"]["Name"] = [[Filler3]];
G2L["34"]["BackgroundTransparency"] = 0.45;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.Filler2
G2L["35"] = Host.New("Frame", G2L["d"]);
G2L["35"]["ZIndex"] = 2;
G2L["35"]["BorderSizePixel"] = 0;
G2L["35"]["BackgroundColor3"] = Color3.fromRGB(23, 25, 31);
G2L["35"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["35"]["Size"] = UDim2.new(0.19, 0, 1, 0);
G2L["35"]["Position"] = UDim2.new(-0.09384, 0, 0.5, 0);
G2L["35"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["35"]["Name"] = [[Filler2]];
G2L["35"]["BackgroundTransparency"] = 0.45;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.Filler1
G2L["36"] = Host.New("Frame", G2L["d"]);
G2L["36"]["BorderSizePixel"] = 0;
G2L["36"]["BackgroundColor3"] = Color3.fromRGB(23, 25, 31);
G2L["36"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["36"]["Size"] = UDim2.new(0.19015, 0, 1, 0);
G2L["36"]["Position"] = UDim2.new(1.0947, 0, 0.5, 0);
G2L["36"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["36"]["Name"] = [[Filler1]];
G2L["36"]["BackgroundTransparency"] = 0.45;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar
G2L["37"] = Host.New("Frame", G2L["b"]);
G2L["37"]["BorderSizePixel"] = 0;
G2L["37"]["BackgroundColor3"] = Color3.fromRGB(22, 24, 27);
G2L["37"]["Size"] = UDim2.new(0.10703, 0, 0.97516, 0);
G2L["37"]["Position"] = UDim2.new(0, 0, 0.01207, 0);
G2L["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["37"]["Name"] = [[SideBar]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.LocalScript
G2L["38"] = Host.New("LocalScript", G2L["37"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.PageScript
G2L["39"] = Host.New("LocalScript", G2L["37"]);
G2L["39"]["Name"] = [[PageScript]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.UIAspectRatioConstraint
G2L["3a"] = Host.New("UIAspectRatioConstraint", G2L["37"]);
G2L["3a"]["AspectRatio"] = 0.17738;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Frame
G2L["3b"] = Host.New("Frame", G2L["37"]);
G2L["3b"]["BorderSizePixel"] = 0;
G2L["3b"]["BackgroundColor3"] = Color3.fromRGB(106, 144, 244);
G2L["3b"]["Size"] = UDim2.new(0.57547, 0, 0.10194, 0);
G2L["3b"]["Position"] = UDim2.new(0.20755, 0, 0.03828, 0);
G2L["3b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3b"]["BackgroundTransparency"] = 1;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Frame.UICorner
G2L["3c"] = Host.New("UICorner", G2L["3b"]);
G2L["3c"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Frame.ImageLabel
G2L["3d"] = Host.New("ImageLabel", G2L["3b"]);
G2L["3d"]["BorderSizePixel"] = 0;
G2L["3d"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["3d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["3d"]["Image"] = [[rbxassetid://76793970636872]];
G2L["3d"]["Size"] = UDim2.new(0.7079, 0, 0.7081, 0);
G2L["3d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3d"]["BackgroundTransparency"] = 1;
G2L["3d"]["Rotation"] = 45;
G2L["3d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Frame.TextLabel
G2L["3e"] = Host.New("TextLabel", G2L["3b"]);
G2L["3e"]["TextWrapped"] = true;
G2L["3e"]["BorderSizePixel"] = 0;
G2L["3e"]["TextSize"] = 14;
G2L["3e"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["3e"]["TextScaled"] = true;
G2L["3e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3e"]["Font"] = Enum.Font.GothamBold;
G2L["3e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3e"]["BackgroundTransparency"] = 1;
G2L["3e"]["RichText"] = true;
G2L["3e"]["Size"] = UDim2.new(2.28252, 0, 0.44262, 0);
G2L["3e"]["Visible"] = false;
G2L["3e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3e"]["Text"] = [[FLUXUS]];
G2L["3e"]["Position"] = UDim2.new(1.24507, 0, 0.27869, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Indicator
G2L["3f"] = Host.New("Frame", G2L["37"]);
G2L["3f"]["BorderSizePixel"] = 0;
G2L["3f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3f"]["Size"] = UDim2.new(0.1104, 0, 0.03509, 0);
G2L["3f"]["Position"] = UDim2.new(-0.065, 0, 0.285, 0);
G2L["3f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3f"]["Name"] = [[Indicator]];
G2L["3f"]["BackgroundTransparency"] = 1;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Indicator.Fill
G2L["40"] = Host.New("Frame", G2L["3f"]);
G2L["40"]["BorderSizePixel"] = 0;
G2L["40"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["40"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["40"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["40"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["40"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["40"]["Name"] = [[Fill]];
G2L["40"]["BackgroundTransparency"] = 0.2;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.Indicator.Fill.UICorner
G2L["41"] = Host.New("UICorner", G2L["40"]);
G2L["41"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.HomeButton
G2L["42"] = Host.New("TextButton", G2L["37"]);
G2L["42"]["BorderSizePixel"] = 0;
G2L["42"]["TextSize"] = 14;
G2L["42"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["42"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["42"]["Font"] = Enum.Font.SourceSans;
G2L["42"]["ZIndex"] = 2;
G2L["42"]["BackgroundTransparency"] = 0.999;
G2L["42"]["Size"] = UDim2.new(0.57547, 0, 0.10194, 0);
G2L["42"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["42"]["Text"] = [[]];
G2L["42"]["Name"] = [[HomeButton]];
G2L["42"]["Position"] = UDim2.new(0.20755, 0, 0.25234, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.HomeButton.Frame
G2L["43"] = Host.New("TextButton", G2L["42"]);
G2L["43"]["BorderSizePixel"] = 0;
G2L["43"]["TextSize"] = 14;
G2L["43"]["AutoButtonColor"] = false;
G2L["43"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["43"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["43"]["Font"] = Enum.Font.SourceSans;
G2L["43"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["43"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["43"]["Text"] = [[]];
G2L["43"]["Name"] = [[Frame]];
G2L["43"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.HomeButton.Frame.Tween
G2L["44"] = Host.New("LocalScript", G2L["43"]);
G2L["44"]["Name"] = [[Tween]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.HomeButton.Frame.ImageLabel
G2L["45"] = Host.New("ImageLabel", G2L["43"]);
G2L["45"]["BorderSizePixel"] = 0;
G2L["45"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["45"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["45"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["45"]["Image"] = [[rbxassetid://91669405653032]];
G2L["45"]["Size"] = UDim2.new(0.48, 0, 0.48, 0);
G2L["45"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["45"]["BackgroundTransparency"] = 1;
G2L["45"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.HomeButton.Frame.UICorner
G2L["46"] = Host.New("UICorner", G2L["43"]);
G2L["46"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.CloseButton
G2L["47"] = Host.New("TextButton", G2L["37"]);
G2L["47"]["BorderSizePixel"] = 0;
G2L["47"]["TextSize"] = 14;
G2L["47"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["47"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["47"]["Font"] = Enum.Font.SourceSans;
G2L["47"]["ZIndex"] = 2;
G2L["47"]["BackgroundTransparency"] = 0.999;
G2L["47"]["Size"] = UDim2.new(0.57547, 0, 0.10194, 0);
G2L["47"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["47"]["Text"] = [[]];
G2L["47"]["Name"] = [[CloseButton]];
G2L["47"]["Position"] = UDim2.new(0.20755, 0, 0.86314, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.CloseButton.Frame
G2L["48"] = Host.New("TextButton", G2L["47"]);
G2L["48"]["BorderSizePixel"] = 0;
G2L["48"]["TextSize"] = 14;
G2L["48"]["AutoButtonColor"] = false;
G2L["48"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["48"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["48"]["Font"] = Enum.Font.SourceSans;
G2L["48"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["48"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["48"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["48"]["Text"] = [[]];
G2L["48"]["Name"] = [[Frame]];
G2L["48"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.CloseButton.Frame.Tween
G2L["49"] = Host.New("LocalScript", G2L["48"]);
G2L["49"]["Name"] = [[Tween]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.CloseButton.Frame.UICorner
G2L["4a"] = Host.New("UICorner", G2L["48"]);
G2L["4a"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.CloseButton.Frame.ImageLabel
G2L["4b"] = Host.New("ImageLabel", G2L["48"]);
G2L["4b"]["BorderSizePixel"] = 0;
G2L["4b"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["4b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4b"]["Image"] = [[rbxassetid://103740833279681]];
G2L["4b"]["Size"] = UDim2.new(0.44262, 0, 0.44262, 0);
G2L["4b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4b"]["BackgroundTransparency"] = 1;
G2L["4b"]["Position"] = UDim2.new(0.27869, 0, 0.27869, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.EditorButton
G2L["4c"] = Host.New("TextButton", G2L["37"]);
G2L["4c"]["BorderSizePixel"] = 0;
G2L["4c"]["TextSize"] = 14;
G2L["4c"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4c"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["4c"]["Font"] = Enum.Font.SourceSans;
G2L["4c"]["ZIndex"] = 2;
G2L["4c"]["BackgroundTransparency"] = 0.999;
G2L["4c"]["Size"] = UDim2.new(0.57547, 0, 0.10194, 0);
G2L["4c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4c"]["Text"] = [[]];
G2L["4c"]["Name"] = [[EditorButton]];
G2L["4c"]["Position"] = UDim2.new(0.20755, 0, 0.39625, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.EditorButton.Frame
G2L["4d"] = Host.New("TextButton", G2L["4c"]);
G2L["4d"]["BorderSizePixel"] = 0;
G2L["4d"]["TextSize"] = 14;
G2L["4d"]["AutoButtonColor"] = false;
G2L["4d"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4d"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["4d"]["Font"] = Enum.Font.SourceSans;
G2L["4d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4d"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["4d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4d"]["Text"] = [[]];
G2L["4d"]["Name"] = [[Frame]];
G2L["4d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.EditorButton.Frame.Tween
G2L["4e"] = Host.New("LocalScript", G2L["4d"]);
G2L["4e"]["Name"] = [[Tween]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.EditorButton.Frame.UICorner
G2L["4f"] = Host.New("UICorner", G2L["4d"]);
G2L["4f"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.EditorButton.Frame.ImageLabel
G2L["50"] = Host.New("ImageLabel", G2L["4d"]);
G2L["50"]["ZIndex"] = 0;
G2L["50"]["BorderSizePixel"] = 0;
G2L["50"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["50"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["50"]["ImageColor3"] = Color3.fromRGB(133, 139, 175);
G2L["50"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["50"]["Image"] = [[rbxassetid://88897453061768]];
G2L["50"]["Size"] = UDim2.new(0.48, 0, 0.48, 0);
G2L["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["50"]["BackgroundTransparency"] = 1;
G2L["50"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.SettingsButton
G2L["51"] = Host.New("TextButton", G2L["37"]);
G2L["51"]["BorderSizePixel"] = 0;
G2L["51"]["TextSize"] = 14;
G2L["51"]["AutoButtonColor"] = false;
G2L["51"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["51"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["51"]["Font"] = Enum.Font.SourceSans;
G2L["51"]["ZIndex"] = 2;
G2L["51"]["BackgroundTransparency"] = 0.999;
G2L["51"]["Size"] = UDim2.new(0.57547, 0, 0.10194, 0);
G2L["51"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["51"]["Text"] = [[]];
G2L["51"]["Name"] = [[SettingsButton]];
G2L["51"]["Position"] = UDim2.new(0.19811, 0, 0.54017, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.SettingsButton.Frame
G2L["52"] = Host.New("TextButton", G2L["51"]);
G2L["52"]["BorderSizePixel"] = 0;
G2L["52"]["TextSize"] = 14;
G2L["52"]["AutoButtonColor"] = false;
G2L["52"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["52"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["52"]["Font"] = Enum.Font.SourceSans;
G2L["52"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["52"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["52"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["52"]["Text"] = [[]];
G2L["52"]["Name"] = [[Frame]];
G2L["52"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.SettingsButton.Frame.Tween
G2L["53"] = Host.New("LocalScript", G2L["52"]);
G2L["53"]["Name"] = [[Tween]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.SettingsButton.Frame.UICorner
G2L["54"] = Host.New("UICorner", G2L["52"]);
G2L["54"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.SettingsButton.Frame.ImageLabel
G2L["55"] = Host.New("ImageLabel", G2L["52"]);
G2L["55"]["BorderSizePixel"] = 0;
G2L["55"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["55"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["55"]["ImageColor3"] = Color3.fromRGB(133, 139, 175);
G2L["55"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["55"]["Image"] = [[rbxassetid://99360822375725]];
G2L["55"]["Size"] = UDim2.new(0.48, 0, 0.48, 0);
G2L["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["55"]["BackgroundTransparency"] = 1;
G2L["55"]["Position"] = UDim2.new(0.526, 0, 0.52603, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window
G2L["56"] = Host.New("Frame", G2L["b"]);
G2L["56"]["ZIndex"] = 2;
G2L["56"]["BorderSizePixel"] = 0;
G2L["56"]["BackgroundColor3"] = Color3.fromRGB(32, 34, 43);
G2L["56"]["Size"] = UDim2.new(0.89257, 0, 0.82086, 0);
G2L["56"]["Position"] = UDim2.new(0.10703, 0, 0.17848, 0);
G2L["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["56"]["Name"] = [[Window]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.UICorner
G2L["57"] = Host.New("UICorner", G2L["56"]);
G2L["57"]["CornerRadius"] = UDim.new(0.08, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Filler
G2L["58"] = Host.New("Frame", G2L["56"]);
G2L["58"]["BorderSizePixel"] = 0;
G2L["58"]["BackgroundColor3"] = Color3.fromRGB(32, 34, 43);
G2L["58"]["Size"] = UDim2.new(0.10097, 0, 0.16711, 0);
G2L["58"]["Position"] = UDim2.new(0, 0, 0.83205, 0);
G2L["58"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["58"]["Name"] = [[Filler]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Filler
G2L["59"] = Host.New("Frame", G2L["56"]);
G2L["59"]["BorderSizePixel"] = 0;
G2L["59"]["BackgroundColor3"] = Color3.fromRGB(32, 34, 43);
G2L["59"]["Size"] = UDim2.new(0.10097, 0, 0.16711, 0);
G2L["59"]["Position"] = UDim2.new(0.8989, 0, 0, 0);
G2L["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["59"]["Name"] = [[Filler]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Filler
G2L["5a"] = Host.New("Frame", G2L["56"]);
G2L["5a"]["BorderSizePixel"] = 0;
G2L["5a"]["BackgroundColor3"] = Color3.fromRGB(32, 34, 43);
G2L["5a"]["Size"] = UDim2.new(0.10097, 0, 0.16711, 0);
G2L["5a"]["Position"] = UDim2.new(0.8989, 0, 0.83267, 0);
G2L["5a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5a"]["Name"] = [[Filler]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home
G2L["5b"] = Host.New("Frame", G2L["56"]);
G2L["5b"]["BorderSizePixel"] = 0;
G2L["5b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5b"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["5b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5b"]["Name"] = [[Home]];
G2L["5b"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets
G2L["5c"] = Host.New("Frame", G2L["5b"]);
G2L["5c"]["BorderSizePixel"] = 0;
G2L["5c"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["5c"]["Size"] = UDim2.new(0.36579, 0, 0.54839, 0);
G2L["5c"]["Position"] = UDim2.new(0.03534, 0, 0.38951, 0);
G2L["5c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5c"]["Name"] = [[QuickWidgets]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.UICorner
G2L["5d"] = Host.New("UICorner", G2L["5c"]);
G2L["5d"]["CornerRadius"] = UDim.new(0.1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.TextLabel
G2L["5e"] = Host.New("TextLabel", G2L["5c"]);
G2L["5e"]["TextWrapped"] = true;
G2L["5e"]["BorderSizePixel"] = 0;
G2L["5e"]["TextSize"] = 14;
G2L["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5e"]["TextScaled"] = true;
G2L["5e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5e"]["Font"] = Enum.Font.GothamMedium;
G2L["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5e"]["BackgroundTransparency"] = 1;
G2L["5e"]["RichText"] = true;
G2L["5e"]["Size"] = UDim2.new(0.862, 0, 0.11955, 0);
G2L["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5e"]["Text"] = [[Quick actions let you quickly <font color="rgb(105, 143, 243)">run</font> your <font color="rgb(105, 143, 243)">clipboard</font> or a <font color="rgb(105, 143, 243)">recent script</font>,]];
G2L["5e"]["Position"] = UDim2.new(0.069, 0, 0.21413, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.TextLabel
G2L["5f"] = Host.New("TextLabel", G2L["5c"]);
G2L["5f"]["TextWrapped"] = true;
G2L["5f"]["BorderSizePixel"] = 0;
G2L["5f"]["TextSize"] = 14;
G2L["5f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5f"]["TextScaled"] = true;
G2L["5f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5f"]["Font"] = Enum.Font.GothamBold;
G2L["5f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5f"]["BackgroundTransparency"] = 1;
G2L["5f"]["Size"] = UDim2.new(0.4204, 0, 0.07337, 0);
G2L["5f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5f"]["Text"] = [[Quick Actions,]];
G2L["5f"]["Position"] = UDim2.new(0.06943, 0, 0.08027, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.ImageLabel
G2L["60"] = Host.New("ImageLabel", G2L["5c"]);
G2L["60"]["BorderSizePixel"] = 0;
G2L["60"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["60"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["60"]["Image"] = [[rbxassetid://72042062308859]];
G2L["60"]["Size"] = UDim2.new(0.05923, 0, 0.06946, 0);
G2L["60"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["60"]["BackgroundTransparency"] = 1;
G2L["60"]["Position"] = UDim2.new(0.86903, 0, 0.09143, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.CanvasGroup
G2L["61"] = Host.New("CanvasGroup", G2L["5c"]);
G2L["61"]["ZIndex"] = 2;
G2L["61"]["BorderSizePixel"] = 0;
G2L["61"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["61"]["Size"] = UDim2.new(1, 0, 0.47763, 0);
G2L["61"]["Position"] = UDim2.new(-0, 0, 0.46402, 0);
G2L["61"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.CanvasGroup.UIGradient
G2L["62"] = Host.New("UIGradient", G2L["61"]);
G2L["62"]["Rotation"] = -90;
G2L["62"]["Transparency"] = NumberSequence.new(0, 0);
G2L["62"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.CanvasGroup.UICorner
G2L["63"] = Host.New("UICorner", G2L["61"]);
G2L["63"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.CodeContainer
G2L["64"] = Host.New("ScrollingFrame", G2L["5c"]);
G2L["64"]["Active"] = true;
G2L["64"]["ZIndex"] = 0;
G2L["64"]["BorderSizePixel"] = 0;
G2L["64"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["64"]["Name"] = [[CodeContainer]];
G2L["64"]["Size"] = UDim2.new(0.86157, 0, 0.50027, 0);
G2L["64"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["64"]["Position"] = UDim2.new(0.069, 0, 0.416, 0);
G2L["64"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["64"]["ScrollBarThickness"] = 0;
G2L["64"]["BackgroundTransparency"] = 1;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.CodeContainer.TextLabel
G2L["65"] = Host.New("TextLabel", G2L["64"]);
G2L["65"]["TextWrapped"] = true;
G2L["65"]["ZIndex"] = 0;
G2L["65"]["BorderSizePixel"] = 0;
G2L["65"]["TextSize"] = 17;
G2L["65"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["65"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["65"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["65"]["Font"] = Enum.Font.RobotoMono;
G2L["65"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["65"]["BackgroundTransparency"] = 1;
G2L["65"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["65"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["65"]["Text"] = [[local x=0 local y=10 local z=5 local w=2 local a=1 local b=3 local function u() x=x+1 if x>=y then x=0 end end local function v() z=z-1 if z<=0 then z=5 end end local function r() w=w*2 if w>16 then w=2 end end local function s() a=a+b if a>10 then a=1 end end local function t() for i=1,y do u() v() r() s() end end t()
]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.RunButton
G2L["66"] = Host.New("TextButton", G2L["5c"]);
G2L["66"]["BorderSizePixel"] = 0;
G2L["66"]["TextSize"] = 14;
G2L["66"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["66"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["66"]["Font"] = Enum.Font.SourceSans;
G2L["66"]["ZIndex"] = 2;
G2L["66"]["Size"] = UDim2.new(0.1447, 0, 0.16916, 0);
G2L["66"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["66"]["Text"] = [[]];
G2L["66"]["Name"] = [[RunButton]];
G2L["66"]["Position"] = UDim2.new(0.78205, 0, 0.74711, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.RunButton.LocalScript
G2L["67"] = Host.New("LocalScript", G2L["66"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.RunButton.ImageLabel
G2L["68"] = Host.New("ImageLabel", G2L["66"]);
G2L["68"]["BorderSizePixel"] = 0;
G2L["68"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["68"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["68"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["68"]["Image"] = [[rbxassetid://110351064802458]];
G2L["68"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["68"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["68"]["BackgroundTransparency"] = 1;
G2L["68"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.RunButton.UICorner
G2L["69"] = Host.New("UICorner", G2L["66"]);
G2L["69"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.PasteButton
G2L["6a"] = Host.New("TextButton", G2L["5c"]);
G2L["6a"]["BorderSizePixel"] = 0;
G2L["6a"]["TextSize"] = 14;
G2L["6a"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6a"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["6a"]["Font"] = Enum.Font.SourceSans;
G2L["6a"]["ZIndex"] = 2;
G2L["6a"]["Size"] = UDim2.new(0.1447, 0, 0.16916, 0);
G2L["6a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6a"]["Text"] = [[]];
G2L["6a"]["Name"] = [[PasteButton]];
G2L["6a"]["Position"] = UDim2.new(0.59031, 0, 0.74711, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.PasteButton.LocalScript
G2L["6b"] = Host.New("LocalScript", G2L["6a"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.PasteButton.UICorner
G2L["6c"] = Host.New("UICorner", G2L["6a"]);
G2L["6c"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.PasteButton.ImageLabel
G2L["6d"] = Host.New("ImageLabel", G2L["6a"]);
G2L["6d"]["BorderSizePixel"] = 0;
G2L["6d"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["6d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["6d"]["Image"] = [[rbxassetid://129221218163002]];
G2L["6d"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["6d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6d"]["BackgroundTransparency"] = 1;
G2L["6d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget
G2L["6e"] = Host.New("Frame", G2L["5b"]);
G2L["6e"]["BorderSizePixel"] = 0;
G2L["6e"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["6e"]["Size"] = UDim2.new(0.36579, 0, 0.27306, 0);
G2L["6e"]["Position"] = UDim2.new(0.03534, 0, 0.06359, 0);
G2L["6e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6e"]["Name"] = [[KeyWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.UICorner
G2L["6f"] = Host.New("UICorner", G2L["6e"]);
G2L["6f"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.TextLabel
G2L["70"] = Host.New("TextLabel", G2L["6e"]);
G2L["70"]["TextWrapped"] = true;
G2L["70"]["BorderSizePixel"] = 0;
G2L["70"]["TextSize"] = 14;
G2L["70"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["70"]["TextScaled"] = true;
G2L["70"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["70"]["Font"] = Enum.Font.GothamBold;
G2L["70"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["70"]["BackgroundTransparency"] = 1;
G2L["70"]["Size"] = UDim2.new(0.24722, 0, 0.14923, 0);
G2L["70"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["70"]["Text"] = [[Your Key,]];
G2L["70"]["Position"] = UDim2.new(0.06943, 0, 0.16739, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.ImageLabel
G2L["71"] = Host.New("ImageLabel", G2L["6e"]);
G2L["71"]["BorderSizePixel"] = 0;
G2L["71"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["71"]["Image"] = [[rbxassetid://90309777103099]];
G2L["71"]["Size"] = UDim2.new(0.05923, 0, 0.14128, 0);
G2L["71"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["71"]["BackgroundTransparency"] = 1;
G2L["71"]["Position"] = UDim2.new(0.86903, 0, 0.17534, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.ImageLabel
G2L["72"] = Host.New("ImageLabel", G2L["6e"]);
G2L["72"]["BorderSizePixel"] = 0;
G2L["72"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["72"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["72"]["Image"] = [[rbxassetid://105334603868078]];
G2L["72"]["Size"] = UDim2.new(0.86128, 0, 0.16711, 0);
G2L["72"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["72"]["Position"] = UDim2.new(0.06943, 0, 0.63316, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.ImageLabel.UICorner
G2L["73"] = Host.New("UICorner", G2L["72"]);
G2L["73"]["CornerRadius"] = UDim.new(0.4, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.ImageLabel.UIGradient
G2L["74"] = Host.New("UIGradient", G2L["72"]);
G2L["74"]["Rotation"] = -50;
G2L["74"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["74"]["Color"] = ColorSequence.new(Color3.fromRGB(106, 144, 244), Color3.fromRGB(106, 144, 244));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.TextLabel
G2L["75"] = Host.New("TextLabel", G2L["6e"]);
G2L["75"]["TextWrapped"] = true;
G2L["75"]["BorderSizePixel"] = 0;
G2L["75"]["TextSize"] = 14;
G2L["75"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["75"]["TextScaled"] = true;
G2L["75"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["Font"] = Enum.Font.GothamMedium;
G2L["75"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["75"]["BackgroundTransparency"] = 1;
G2L["75"]["RichText"] = true;
G2L["75"]["Size"] = UDim2.new(0.74922, 0, 0.19246, 0);
G2L["75"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["75"]["Text"] = [[Your key currently has <font color="rgb(105, 143, 243)">24 hours</font> left,]];
G2L["75"]["Position"] = UDim2.new(0.069, 0, 0.365, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.KeyWidget.TextLabel
G2L["76"] = Host.New("TextLabel", G2L["6e"]);
G2L["76"]["TextWrapped"] = true;
G2L["76"]["BorderSizePixel"] = 0;
G2L["76"]["TextSize"] = 14;
G2L["76"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["76"]["TextScaled"] = true;
G2L["76"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["76"]["Font"] = Enum.Font.GothamBold;
G2L["76"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["76"]["BackgroundTransparency"] = 1;
G2L["76"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["76"]["Size"] = UDim2.new(0.12278, 0, 0.14923, 0);
G2L["76"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["76"]["Text"] = [[100%]];
G2L["76"]["Position"] = UDim2.new(0.5, 0, 0.71105, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget
G2L["77"] = Host.New("Frame", G2L["5b"]);
G2L["77"]["BorderSizePixel"] = 0;
G2L["77"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["77"]["Size"] = UDim2.new(0.53095, 0, 0.31586, 0);
G2L["77"]["Position"] = UDim2.new(0.435, 0, 0.62, 0);
G2L["77"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["77"]["Name"] = [[InviteWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.UICorner
G2L["78"] = Host.New("UICorner", G2L["77"]);
G2L["78"]["CornerRadius"] = UDim.new(0.15, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.TextLabel
G2L["79"] = Host.New("TextLabel", G2L["77"]);
G2L["79"]["TextWrapped"] = true;
G2L["79"]["BorderSizePixel"] = 0;
G2L["79"]["TextSize"] = 14;
G2L["79"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["79"]["TextScaled"] = true;
G2L["79"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["79"]["Font"] = Enum.Font.GothamBold;
G2L["79"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["79"]["BackgroundTransparency"] = 1;
G2L["79"]["Size"] = UDim2.new(0.2784, 0, 0.1339, 0);
G2L["79"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["79"]["Text"] = [[You're Invited,]];
G2L["79"]["Position"] = UDim2.new(0.04561, 0, 0.13375, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.ImageLabel
G2L["7a"] = Host.New("ImageLabel", G2L["77"]);
G2L["7a"]["BorderSizePixel"] = 0;
G2L["7a"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["7a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7a"]["Image"] = [[rbxassetid://74865617157095]];
G2L["7a"]["Size"] = UDim2.new(0.04067, 0, 0.12676, 0);
G2L["7a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7a"]["BackgroundTransparency"] = 1;
G2L["7a"]["Position"] = UDim2.new(0.91, 0, 0.142, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.JoinButton
G2L["7b"] = Host.New("TextButton", G2L["77"]);
G2L["7b"]["BorderSizePixel"] = 0;
G2L["7b"]["TextSize"] = 14;
G2L["7b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["7b"]["Font"] = Enum.Font.SourceSans;
G2L["7b"]["ZIndex"] = 2;
G2L["7b"]["Size"] = UDim2.new(0.0997, 0, 0.29046, 0);
G2L["7b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7b"]["Text"] = [[]];
G2L["7b"]["Name"] = [[JoinButton]];
G2L["7b"]["Position"] = UDim2.new(0.84927, 0, 0.57061, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.JoinButton.LocalScript
G2L["7c"] = Host.New("LocalScript", G2L["7b"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.JoinButton.ImageLabel
G2L["7d"] = Host.New("ImageLabel", G2L["7b"]);
G2L["7d"]["BorderSizePixel"] = 0;
G2L["7d"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["7d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["7d"]["Image"] = [[rbxassetid://130248739020723]];
G2L["7d"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["7d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7d"]["BackgroundTransparency"] = 1;
G2L["7d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.JoinButton.UICorner
G2L["7e"] = Host.New("UICorner", G2L["7b"]);
G2L["7e"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.NextButton
G2L["7f"] = Host.New("TextButton", G2L["77"]);
G2L["7f"]["BorderSizePixel"] = 0;
G2L["7f"]["TextSize"] = 14;
G2L["7f"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7f"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["7f"]["Font"] = Enum.Font.SourceSans;
G2L["7f"]["ZIndex"] = 2;
G2L["7f"]["Size"] = UDim2.new(0.0997, 0, 0.29046, 0);
G2L["7f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7f"]["Text"] = [[]];
G2L["7f"]["Name"] = [[NextButton]];
G2L["7f"]["Visible"] = false;
G2L["7f"]["Position"] = UDim2.new(0.71716, 0, 0.57061, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.NextButton.LocalScript
G2L["80"] = Host.New("LocalScript", G2L["7f"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.NextButton.ImageLabel
G2L["81"] = Host.New("ImageLabel", G2L["7f"]);
G2L["81"]["BorderSizePixel"] = 0;
G2L["81"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["81"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["81"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["81"]["Image"] = [[rbxassetid://133507906299380]];
G2L["81"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["81"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["81"]["BackgroundTransparency"] = 1;
G2L["81"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.NextButton.UICorner
G2L["82"] = Host.New("UICorner", G2L["7f"]);
G2L["82"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.AdButton
G2L["83"] = Host.New("TextButton", G2L["77"]);
G2L["83"]["BorderSizePixel"] = 0;
G2L["83"]["TextSize"] = 14;
G2L["83"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["83"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["83"]["Font"] = Enum.Font.SourceSans;
G2L["83"]["ZIndex"] = 2;
G2L["83"]["Size"] = UDim2.new(0.0997, 0, 0.29046, 0);
G2L["83"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["83"]["Text"] = [[]];
G2L["83"]["Name"] = [[AdButton]];
G2L["83"]["Position"] = UDim2.new(0.046, 0, 0.571, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.AdButton.ImageLabel
G2L["84"] = Host.New("ImageLabel", G2L["83"]);
G2L["84"]["BorderSizePixel"] = 0;
G2L["84"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["84"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["84"]["Image"] = [[rbxassetid://96074466346855]];
G2L["84"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["84"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["84"]["BackgroundTransparency"] = 1;
G2L["84"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.AdButton.UICorner
G2L["85"] = Host.New("UICorner", G2L["83"]);
G2L["85"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.TextLabel
G2L["86"] = Host.New("TextLabel", G2L["77"]);
G2L["86"]["TextWrapped"] = true;
G2L["86"]["BorderSizePixel"] = 0;
G2L["86"]["TextSize"] = 14;
G2L["86"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["86"]["TextScaled"] = true;
G2L["86"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["86"]["Font"] = Enum.Font.GothamMedium;
G2L["86"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["86"]["BackgroundTransparency"] = 1;
G2L["86"]["RichText"] = true;
G2L["86"]["Size"] = UDim2.new(0.81, 0, 0.166, 0);
G2L["86"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["86"]["Text"] = [[You've been <font color="rgb(105, 143, 243)">invited</font> to join <font color="rgb(105, 143, 243)">this community</font> by Hex,]];
G2L["86"]["Position"] = UDim2.new(0.043, 0, 0.325, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.TextHolderName
G2L["87"] = Host.New("ScrollingFrame", G2L["77"]);
G2L["87"]["Active"] = true;
G2L["87"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["87"]["ZIndex"] = 3;
G2L["87"]["BorderSizePixel"] = 0;
G2L["87"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["87"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["87"]["Name"] = [[TextHolderName]];
G2L["87"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["87"]["Size"] = UDim2.new(0.43043, 0, 0.11818, 0);
G2L["87"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["87"]["Position"] = UDim2.new(0.40288, 0, 0.6696, 0);
G2L["87"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["87"]["ScrollBarThickness"] = 0;
G2L["87"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.TextHolderName.TextLabel
G2L["88"] = Host.New("TextLabel", G2L["87"]);
G2L["88"]["TextWrapped"] = true;
G2L["88"]["BorderSizePixel"] = 0;
G2L["88"]["TextSize"] = 14;
G2L["88"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["88"]["TextTransparency"] = 0.08;
G2L["88"]["TextScaled"] = true;
G2L["88"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["88"]["Font"] = Enum.Font.GothamBlack;
G2L["88"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["88"]["BackgroundTransparency"] = 1;
G2L["88"]["Size"] = UDim2.new(0.08, 0, 0.115, 0);
G2L["88"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["88"]["Text"] = [[FLUXUSZ'S COMMUNITY]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.TextHolderTag
G2L["89"] = Host.New("ScrollingFrame", G2L["77"]);
G2L["89"]["Active"] = true;
G2L["89"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["89"]["ZIndex"] = 3;
G2L["89"]["BorderSizePixel"] = 0;
G2L["89"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["89"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["89"]["Name"] = [[TextHolderTag]];
G2L["89"]["Size"] = UDim2.new(0.252, 0, 0.078, 0);
G2L["89"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["89"]["Position"] = UDim2.new(0.188, 0, 0.729, 0);
G2L["89"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["89"]["ScrollBarThickness"] = 0;
G2L["89"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.TextHolderTag.TextLabel
G2L["8a"] = Host.New("TextLabel", G2L["89"]);
G2L["8a"]["TextWrapped"] = true;
G2L["8a"]["BorderSizePixel"] = 0;
G2L["8a"]["TextSize"] = 14;
G2L["8a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["8a"]["TextTransparency"] = 0.08;
G2L["8a"]["TextScaled"] = true;
G2L["8a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8a"]["Font"] = Enum.Font.GothamBlack;
G2L["8a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8a"]["BackgroundTransparency"] = 1;
G2L["8a"]["Size"] = UDim2.new(0.08, 0, 0.082, 0);
G2L["8a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8a"]["Text"] = [[Roblox, Freemium]];
G2L["8a"]["Position"] = UDim2.new(-0.00022, 0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget
G2L["8b"] = Host.New("Frame", G2L["5b"]);
G2L["8b"]["BorderSizePixel"] = 0;
G2L["8b"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["8b"]["Size"] = UDim2.new(0.53133, 0, 0.51076, 0);
G2L["8b"]["Position"] = UDim2.new(0.43466, 0, 0.06174, 0);
G2L["8b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8b"]["Name"] = [[TipsWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget.UICorner
G2L["8c"] = Host.New("UICorner", G2L["8b"]);
G2L["8c"]["CornerRadius"] = UDim.new(0.1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget.TextLabel
G2L["8d"] = Host.New("TextLabel", G2L["8b"]);
G2L["8d"]["TextWrapped"] = true;
G2L["8d"]["BorderSizePixel"] = 0;
G2L["8d"]["TextSize"] = 14;
G2L["8d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["8d"]["TextScaled"] = true;
G2L["8d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8d"]["Font"] = Enum.Font.GothamMedium;
G2L["8d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8d"]["BackgroundTransparency"] = 1;
G2L["8d"]["RichText"] = true;
G2L["8d"]["Size"] = UDim2.new(0.77096, 0, 0.10052, 0);
G2L["8d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8d"]["Text"] = [[You can press the <font color="rgb(105, 143, 243)">X icon</font>, to close the User Interface,]];
G2L["8d"]["Position"] = UDim2.new(0.04597, 0, 0.19633, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget.TextLabel
G2L["8e"] = Host.New("TextLabel", G2L["8b"]);
G2L["8e"]["TextWrapped"] = true;
G2L["8e"]["BorderSizePixel"] = 0;
G2L["8e"]["TextSize"] = 14;
G2L["8e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["8e"]["TextScaled"] = true;
G2L["8e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8e"]["Font"] = Enum.Font.GothamBold;
G2L["8e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8e"]["BackgroundTransparency"] = 1;
G2L["8e"]["Size"] = UDim2.new(0.20648, 0, 0.07794, 0);
G2L["8e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8e"]["Text"] = [[Quick Tips,]];
G2L["8e"]["Position"] = UDim2.new(0.04626, 0, 0.08515, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget.ImageLabel
G2L["8f"] = Host.New("ImageLabel", G2L["8b"]);
G2L["8f"]["BorderSizePixel"] = 0;
G2L["8f"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["8f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8f"]["Image"] = [[rbxassetid://102052067088007]];
G2L["8f"]["Size"] = UDim2.new(0.04059, 0, 0.07379, 0);
G2L["8f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8f"]["BackgroundTransparency"] = 1;
G2L["8f"]["Position"] = UDim2.new(0.91, 0, 0.089, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget.ImageLabel
G2L["90"] = Host.New("ImageLabel", G2L["8b"]);
G2L["90"]["BorderSizePixel"] = 0;
G2L["90"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["90"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["90"]["Image"] = [[rbxassetid://85844859038779]];
G2L["90"]["Size"] = UDim2.new(0.90485, 0, 0.57086, 0);
G2L["90"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["90"]["BackgroundTransparency"] = 1;
G2L["90"]["Position"] = UDim2.new(0.04579, 0, 0.3388, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.TipsWidget.ImageLabel.UICorner
G2L["91"] = Host.New("UICorner", G2L["90"]);
G2L["91"]["CornerRadius"] = UDim.new(0.1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor
G2L["92"] = Host.New("Frame", G2L["56"]);
G2L["92"]["Visible"] = false;
G2L["92"]["BorderSizePixel"] = 0;
G2L["92"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["92"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["92"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["92"]["Name"] = [[Editor]];
G2L["92"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget
G2L["93"] = Host.New("Frame", G2L["92"]);
G2L["93"]["BorderSizePixel"] = 0;
G2L["93"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["93"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["93"]["Size"] = UDim2.new(0.93061, 0, 0.61842, 0);
G2L["93"]["Position"] = UDim2.new(0.5, 0, 0.6309, 0);
G2L["93"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["93"]["Name"] = [[EditorWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.UICorner
G2L["94"] = Host.New("UICorner", G2L["93"]);
G2L["94"]["CornerRadius"] = UDim.new(0.09, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.CanvasGroup
G2L["95"] = Host.New("CanvasGroup", G2L["93"]);
G2L["95"]["ZIndex"] = 2;
G2L["95"]["BorderSizePixel"] = 0;
G2L["95"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["95"]["Size"] = UDim2.new(0.93114, 0, 0.81827, 0);
G2L["95"]["Position"] = UDim2.new(0.02999, 0, 0.08837, 0);
G2L["95"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.CanvasGroup.UIGradient
G2L["96"] = Host.New("UIGradient", G2L["95"]);
G2L["96"]["Rotation"] = -90;
G2L["96"]["Transparency"] = NumberSequence.new(0, 0);
G2L["96"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.CodeContainer
G2L["97"] = Host.New("ScrollingFrame", G2L["93"]);
G2L["97"]["Active"] = true;
G2L["97"]["ZIndex"] = 0;
G2L["97"]["BorderSizePixel"] = 0;
G2L["97"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["97"]["Name"] = [[CodeContainer]];
G2L["97"]["Size"] = UDim2.new(0.93024, 0, 0.81788, 0);
G2L["97"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["97"]["Position"] = UDim2.new(0.031, 0, 0.083, 0);
G2L["97"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["97"]["ScrollBarThickness"] = 0;
G2L["97"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.CodeContainer.Editor
G2L["98"] = Host.New("TextBox", G2L["97"]);
G2L["98"]["Name"] = [[Editor]];
G2L["98"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["98"]["PlaceholderColor3"] = Color3.fromRGB(214, 215, 217);
G2L["98"]["BorderSizePixel"] = 0;
G2L["98"]["TextWrapped"] = true;
G2L["98"]["TextSize"] = 17;
G2L["98"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["98"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["98"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 8);
G2L["98"]["RichText"] = true;
G2L["98"]["Font"] = Enum.Font.RobotoMono;
G2L["98"]["MultiLine"] = true;
G2L["98"]["ClearTextOnFocus"] = false;
G2L["98"]["PlaceholderText"] = [[-- Write your Lua here]];
G2L["98"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["98"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["98"]["Text"] = [[-- Write your Lua here]];
G2L["98"]["BackgroundTransparency"] = 1;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.CodeContainer.Editor.UICorner
G2L["99"] = Host.New("UICorner", G2L["98"]);
G2L["99"]["CornerRadius"] = UDim.new(0, 24);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.RunButton
G2L["9a"] = Host.New("TextButton", G2L["93"]);
G2L["9a"]["BorderSizePixel"] = 0;
G2L["9a"]["TextSize"] = 14;
G2L["9a"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9a"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["9a"]["Font"] = Enum.Font.SourceSans;
G2L["9a"]["ZIndex"] = 2;
G2L["9a"]["Size"] = UDim2.new(0.05697, 0, 0.14827, 0);
G2L["9a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9a"]["Text"] = [[]];
G2L["9a"]["Name"] = [[RunButton]];
G2L["9a"]["Position"] = UDim2.new(0.906, 0, 0.753, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.RunButton.ImageLabel
G2L["9b"] = Host.New("ImageLabel", G2L["9a"]);
G2L["9b"]["BorderSizePixel"] = 0;
G2L["9b"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["9b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9b"]["Image"] = [[rbxassetid://110351064802458]];
G2L["9b"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["9b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9b"]["BackgroundTransparency"] = 1;
G2L["9b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.RunButton.UICorner
G2L["9c"] = Host.New("UICorner", G2L["9a"]);
G2L["9c"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.PasteButton
G2L["9d"] = Host.New("TextButton", G2L["93"]);
G2L["9d"]["BorderSizePixel"] = 0;
G2L["9d"]["TextSize"] = 14;
G2L["9d"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9d"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["9d"]["Font"] = Enum.Font.SourceSans;
G2L["9d"]["ZIndex"] = 2;
G2L["9d"]["Size"] = UDim2.new(0.05697, 0, 0.14827, 0);
G2L["9d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9d"]["Text"] = [[]];
G2L["9d"]["Name"] = [[PasteButton]];
G2L["9d"]["Position"] = UDim2.new(0.831, 0, 0.753, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.PasteButton.UICorner
G2L["9e"] = Host.New("UICorner", G2L["9d"]);
G2L["9e"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.PasteButton.ImageLabel
G2L["9f"] = Host.New("ImageLabel", G2L["9d"]);
G2L["9f"]["BorderSizePixel"] = 0;
G2L["9f"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["9f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["9f"]["Image"] = [[rbxassetid://129221218163002]];
G2L["9f"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["9f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9f"]["BackgroundTransparency"] = 1;
G2L["9f"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.ClearButton
G2L["a0"] = Host.New("TextButton", G2L["93"]);
G2L["a0"]["BorderSizePixel"] = 0;
G2L["a0"]["TextSize"] = 14;
G2L["a0"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a0"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["a0"]["Font"] = Enum.Font.SourceSans;
G2L["a0"]["ZIndex"] = 2;
G2L["a0"]["Size"] = UDim2.new(0.05697, 0, 0.14827, 0);
G2L["a0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a0"]["Text"] = [[]];
G2L["a0"]["Name"] = [[ClearButton]];
G2L["a0"]["Position"] = UDim2.new(0.756, 0, 0.753, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.ClearButton.LocalScript
G2L["a1"] = Host.New("LocalScript", G2L["a0"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.ClearButton.UICorner
G2L["a2"] = Host.New("UICorner", G2L["a0"]);
G2L["a2"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.ClearButton.ImageLabel
G2L["a3"] = Host.New("ImageLabel", G2L["a0"]);
G2L["a3"]["BorderSizePixel"] = 0;
G2L["a3"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["a3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["a3"]["Image"] = [[rbxassetid://122155168026518]];
G2L["a3"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["a3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a3"]["BackgroundTransparency"] = 1;
G2L["a3"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.FavoriteButton
G2L["a4"] = Host.New("TextButton", G2L["93"]);
G2L["a4"]["BorderSizePixel"] = 0;
G2L["a4"]["TextSize"] = 14;
G2L["a4"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a4"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["a4"]["Font"] = Enum.Font.SourceSans;
G2L["a4"]["ZIndex"] = 4;
G2L["a4"]["Size"] = UDim2.new(0.05697, 0, 0.14827, 0);
G2L["a4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a4"]["Text"] = [[]];
G2L["a4"]["Name"] = [[FavoriteButton]];
G2L["a4"]["Visible"] = false;
G2L["a4"]["Position"] = UDim2.new(0.03444, 0, 0.753, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.FavoriteButton.ImageLabel
G2L["a5"] = Host.New("ImageLabel", G2L["a4"]);
G2L["a5"]["BorderSizePixel"] = 0;
G2L["a5"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["a5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["a5"]["Image"] = [[rbxassetid://82062242798816]];
G2L["a5"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["a5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a5"]["BackgroundTransparency"] = 1;
G2L["a5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.FavoriteButton.UICorner
G2L["a6"] = Host.New("UICorner", G2L["a4"]);
G2L["a6"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget
G2L["a7"] = Host.New("Frame", G2L["92"]);
G2L["a7"]["BorderSizePixel"] = 0;
G2L["a7"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["a7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["a7"]["Size"] = UDim2.new(0.93081, 0, 0.21, 0);
G2L["a7"]["Position"] = UDim2.new(0.4999, 0, 0.16395, 0);
G2L["a7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a7"]["Name"] = [[TabWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.LocalScript
G2L["a8"] = Host.New("LocalScript", G2L["a7"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.UICorner
G2L["a9"] = Host.New("UICorner", G2L["a7"]);
G2L["a9"]["CornerRadius"] = UDim.new(0.26, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.SyntaxButton
G2L["aa"] = Host.New("TextButton", G2L["a7"]);
G2L["aa"]["BorderSizePixel"] = 0;
G2L["aa"]["TextSize"] = 14;
G2L["aa"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["aa"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["aa"]["Font"] = Enum.Font.SourceSans;
G2L["aa"]["Size"] = UDim2.new(0.05684, 0, 0.4389, 0);
G2L["aa"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["aa"]["Text"] = [[]];
G2L["aa"]["Name"] = [[SyntaxButton]];
G2L["aa"]["Position"] = UDim2.new(0.90652, 0, 0.27676, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.SyntaxButton.LocalScript
G2L["ab"] = Host.New("LocalScript", G2L["aa"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.SyntaxButton.ImageLabel
G2L["ac"] = Host.New("ImageLabel", G2L["aa"]);
G2L["ac"]["BorderSizePixel"] = 0;
G2L["ac"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["ac"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ac"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["ac"]["Image"] = [[rbxassetid://97365901109082]];
G2L["ac"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["ac"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ac"]["BackgroundTransparency"] = 1;
G2L["ac"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.SyntaxButton.UICorner
G2L["ad"] = Host.New("UICorner", G2L["aa"]);
G2L["ad"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CloudButton
G2L["ae"] = Host.New("TextButton", G2L["a7"]);
G2L["ae"]["BorderSizePixel"] = 0;
G2L["ae"]["TextSize"] = 14;
G2L["ae"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ae"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["ae"]["Font"] = Enum.Font.SourceSans;
G2L["ae"]["Size"] = UDim2.new(0.05684, 0, 0.4389, 0);
G2L["ae"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ae"]["Text"] = [[]];
G2L["ae"]["Name"] = [[CloudButton]];
G2L["ae"]["Position"] = UDim2.new(0.83121, 0, 0.27676, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CloudButton.LocalScript
G2L["af"] = Host.New("LocalScript", G2L["ae"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CloudButton.UICorner
G2L["b0"] = Host.New("UICorner", G2L["ae"]);
G2L["b0"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CloudButton.ImageLabel
G2L["b1"] = Host.New("ImageLabel", G2L["ae"]);
G2L["b1"]["BorderSizePixel"] = 0;
G2L["b1"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["b1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b1"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b1"]["Image"] = [[rbxassetid://86667806868715]];
G2L["b1"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["b1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b1"]["BackgroundTransparency"] = 1;
G2L["b1"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs
G2L["b2"] = Host.New("ScrollingFrame", G2L["a7"]);
G2L["b2"]["Active"] = true;
G2L["b2"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["b2"]["BorderSizePixel"] = 0;
G2L["b2"]["CanvasSize"] = UDim2.new(2, 0, 1, 0);
G2L["b2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b2"]["Name"] = [[ScrollingTabs]];
G2L["b2"]["Size"] = UDim2.new(0.76377, 0, 0.42944, 0);
G2L["b2"]["Position"] = UDim2.new(0.035, 0, 0.27676, 0);
G2L["b2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b2"]["ScrollBarThickness"] = 0;
G2L["b2"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Switch
G2L["b3"] = Host.New("LocalScript", G2L["b2"]);
G2L["b3"]["Name"] = [[Switch]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Tab1
G2L["b4"] = Host.New("TextButton", G2L["b2"]);
G2L["b4"]["BorderSizePixel"] = 0;
G2L["b4"]["TextSize"] = 14;
G2L["b4"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b4"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["b4"]["Font"] = Enum.Font.SourceSans;
G2L["b4"]["Size"] = UDim2.new(0.066, 0, 0.44, 0);
G2L["b4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b4"]["Text"] = [[]];
G2L["b4"]["Name"] = [[Tab1]];
G2L["b4"]["Visible"] = false;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Tab1.UICorner
G2L["b5"] = Host.New("UICorner", G2L["b4"]);
G2L["b5"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Tab1.TextLabel
G2L["b6"] = Host.New("TextLabel", G2L["b4"]);
G2L["b6"]["TextWrapped"] = true;
G2L["b6"]["BorderSizePixel"] = 0;
G2L["b6"]["TextSize"] = 14;
G2L["b6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["b6"]["TextScaled"] = true;
G2L["b6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b6"]["Font"] = Enum.Font.GothamSemibold;
G2L["b6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b6"]["BackgroundTransparency"] = 1;
G2L["b6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b6"]["Size"] = UDim2.new(0.40917, 0, 0.37081, 0);
G2L["b6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b6"]["Text"] = [[Tab 1]];
G2L["b6"]["Position"] = UDim2.new(0.35334, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Tab1.Indicator
G2L["b7"] = Host.New("Frame", G2L["b4"]);
G2L["b7"]["ZIndex"] = 2;
G2L["b7"]["BorderSizePixel"] = 0;
G2L["b7"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["b7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b7"]["Size"] = UDim2.new(0.192, 0, 0.25, 0);
G2L["b7"]["Position"] = UDim2.new(0.78, 0, 1.022, 0);
G2L["b7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b7"]["Name"] = [[Indicator]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Tab1.Indicator.UICorner
G2L["b8"] = Host.New("UICorner", G2L["b7"]);
G2L["b8"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Tab1.DeleteButton
G2L["b9"] = Host.New("ImageButton", G2L["b4"]);
G2L["b9"]["BorderSizePixel"] = 0;
G2L["b9"]["BackgroundTransparency"] = 1;
G2L["b9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["b9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["b9"]["Image"] = [[rbxassetid://78391259860999]];
G2L["b9"]["Size"] = UDim2.new(0.198, 0, 0.462, 0);
G2L["b9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["b9"]["Name"] = [[DeleteButton]];
G2L["b9"]["Position"] = UDim2.new(0.79, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.UIListLayout
G2L["ba"] = Host.New("UIListLayout", G2L["b2"]);
G2L["ba"]["Wraps"] = true;
G2L["ba"]["Padding"] = UDim.new(0.015, 0);
G2L["ba"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["ba"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.AddButton
G2L["bb"] = Host.New("TextButton", G2L["b2"]);
G2L["bb"]["BorderSizePixel"] = 0;
G2L["bb"]["TextSize"] = 14;
G2L["bb"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bb"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["bb"]["Font"] = Enum.Font.SourceSans;
G2L["bb"]["ZIndex"] = 3;
G2L["bb"]["Size"] = UDim2.new(0.028, 0, 0.439, 0);
G2L["bb"]["LayoutOrder"] = 67;
G2L["bb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bb"]["Text"] = [[]];
G2L["bb"]["Name"] = [[AddButton]];
G2L["bb"]["Position"] = UDim2.new(0.31971, 0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.AddButton.Add Tab
G2L["bc"] = Host.New("LocalScript", G2L["bb"]);
G2L["bc"]["Name"] = [[Add Tab]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.AddButton.UICorner
G2L["bd"] = Host.New("UICorner", G2L["bb"]);
G2L["bd"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.AddButton.ImageLabel
G2L["be"] = Host.New("ImageLabel", G2L["bb"]);
G2L["be"]["BorderSizePixel"] = 0;
G2L["be"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["be"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["be"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["be"]["Image"] = [[rbxassetid://112267782049166]];
G2L["be"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["be"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["be"]["BackgroundTransparency"] = 1;
G2L["be"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Template_Tab
G2L["bf"] = Host.New("TextButton", G2L["b2"]);
G2L["bf"]["BorderSizePixel"] = 0;
G2L["bf"]["TextSize"] = 14;
G2L["bf"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bf"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["bf"]["Font"] = Enum.Font.SourceSans;
G2L["bf"]["Size"] = UDim2.new(0.066, 0, 0.44, 0);
G2L["bf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["bf"]["Text"] = [[]];
G2L["bf"]["Name"] = [[Template_Tab]];
G2L["bf"]["Visible"] = false;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Template_Tab.UICorner
G2L["c0"] = Host.New("UICorner", G2L["bf"]);
G2L["c0"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Template_Tab.TextLabel
G2L["c1"] = Host.New("TextLabel", G2L["bf"]);
G2L["c1"]["TextWrapped"] = true;
G2L["c1"]["BorderSizePixel"] = 0;
G2L["c1"]["TextSize"] = 14;
G2L["c1"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["c1"]["TextScaled"] = true;
G2L["c1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c1"]["Font"] = Enum.Font.GothamSemibold;
G2L["c1"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c1"]["BackgroundTransparency"] = 1;
G2L["c1"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["c1"]["Size"] = UDim2.new(0.40917, 0, 0.37081, 0);
G2L["c1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c1"]["Text"] = [[Tab 1]];
G2L["c1"]["Position"] = UDim2.new(0.35334, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Template_Tab.Indicator
G2L["c2"] = Host.New("Frame", G2L["bf"]);
G2L["c2"]["ZIndex"] = 2;
G2L["c2"]["BorderSizePixel"] = 0;
G2L["c2"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["c2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["c2"]["Size"] = UDim2.new(0.192, 0, 0.25, 0);
G2L["c2"]["Position"] = UDim2.new(0.78, 0, 1.022, 0);
G2L["c2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c2"]["Name"] = [[Indicator]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Template_Tab.Indicator.UICorner
G2L["c3"] = Host.New("UICorner", G2L["c2"]);
G2L["c3"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Template_Tab.DeleteButton
G2L["c4"] = Host.New("ImageButton", G2L["bf"]);
G2L["c4"]["BorderSizePixel"] = 0;
G2L["c4"]["BackgroundTransparency"] = 1;
G2L["c4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["c4"]["Image"] = [[rbxassetid://78391259860999]];
G2L["c4"]["Size"] = UDim2.new(0.198, 0, 0.462, 0);
G2L["c4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c4"]["Name"] = [[DeleteButton]];
G2L["c4"]["Position"] = UDim2.new(0.79, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CanvasGroup
G2L["c5"] = Host.New("CanvasGroup", G2L["a7"]);
G2L["c5"]["Visible"] = false;
G2L["c5"]["ZIndex"] = 2;
G2L["c5"]["BorderSizePixel"] = 0;
G2L["c5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c5"]["Size"] = UDim2.new(0.63194, 0, 0.44, 0);
G2L["c5"]["Position"] = UDim2.new(0.03464, 0, 0.27676, 0);
G2L["c5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c5"]["BackgroundTransparency"] = 0.5;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CanvasGroup.UIGradient
G2L["c6"] = Host.New("UIGradient", G2L["c5"]);
G2L["c6"]["Rotation"] = -180;
G2L["c6"]["Transparency"] = NumberSequence.new(0, 0);
G2L["c6"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction
G2L["c7"] = Host.New("Frame", G2L["92"]);
G2L["c7"]["Visible"] = false;
G2L["c7"]["ZIndex"] = 2;
G2L["c7"]["BorderSizePixel"] = 0;
G2L["c7"]["BackgroundColor3"] = Color3.fromRGB(22, 24, 27);
G2L["c7"]["Size"] = UDim2.new(1.19013, 0, 1.1322, 0);
G2L["c7"]["Position"] = UDim2.new(0, 0, -0.00072, 0);
G2L["c7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c7"]["Name"] = [[ButtonFunction]];
G2L["c7"]["BackgroundTransparency"] = 0.5;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.UICorner
G2L["c8"] = Host.New("UICorner", G2L["c7"]);
G2L["c8"]["CornerRadius"] = UDim.new(0.06, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget
G2L["c9"] = Host.New("Frame", G2L["c7"]);
G2L["c9"]["BorderSizePixel"] = 0;
G2L["c9"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["c9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["c9"]["Size"] = UDim2.new(0.78194, 0, 0.61652, 0);
G2L["c9"]["Position"] = UDim2.new(0.42, 0, 0.575, 0);
G2L["c9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c9"]["Name"] = [[SearchWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.UICorner
G2L["ca"] = Host.New("UICorner", G2L["c9"]);
G2L["ca"]["CornerRadius"] = UDim.new(0.09, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.RunButton
G2L["cb"] = Host.New("TextButton", G2L["c9"]);
G2L["cb"]["BorderSizePixel"] = 0;
G2L["cb"]["TextSize"] = 14;
G2L["cb"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["cb"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["cb"]["Font"] = Enum.Font.SourceSans;
G2L["cb"]["ZIndex"] = 3;
G2L["cb"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["cb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["cb"]["Text"] = [[]];
G2L["cb"]["Name"] = [[RunButton]];
G2L["cb"]["Visible"] = false;
G2L["cb"]["Position"] = UDim2.new(0.90722, 0, 0.79175, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.RunButton.ImageLabel
G2L["cc"] = Host.New("ImageLabel", G2L["cb"]);
G2L["cc"]["BorderSizePixel"] = 0;
G2L["cc"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["cc"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["cc"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["cc"]["Image"] = [[rbxassetid://86332328738313]];
G2L["cc"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["cc"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["cc"]["BackgroundTransparency"] = 1;
G2L["cc"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.RunButton.UICorner
G2L["cd"] = Host.New("UICorner", G2L["cb"]);
G2L["cd"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.CloseButton
G2L["ce"] = Host.New("TextButton", G2L["c9"]);
G2L["ce"]["BorderSizePixel"] = 0;
G2L["ce"]["TextSize"] = 14;
G2L["ce"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ce"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["ce"]["Font"] = Enum.Font.SourceSans;
G2L["ce"]["ZIndex"] = 3;
G2L["ce"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["ce"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ce"]["Text"] = [[]];
G2L["ce"]["Name"] = [[CloseButton]];
G2L["ce"]["Position"] = UDim2.new(0.907, 0, 0.792, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.CloseButton.UICorner
G2L["cf"] = Host.New("UICorner", G2L["ce"]);
G2L["cf"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.CloseButton.ImageLabel
G2L["d0"] = Host.New("ImageLabel", G2L["ce"]);
G2L["d0"]["BorderSizePixel"] = 0;
G2L["d0"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["d0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d0"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["d0"]["Image"] = [[rbxassetid://103740833279681]];
G2L["d0"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["d0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d0"]["BackgroundTransparency"] = 1;
G2L["d0"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FavoriteButton
G2L["d1"] = Host.New("TextButton", G2L["c9"]);
G2L["d1"]["BorderSizePixel"] = 0;
G2L["d1"]["TextSize"] = 14;
G2L["d1"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d1"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["d1"]["Font"] = Enum.Font.SourceSans;
G2L["d1"]["ZIndex"] = 3;
G2L["d1"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["d1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d1"]["Text"] = [[]];
G2L["d1"]["Name"] = [[FavoriteButton]];
G2L["d1"]["Visible"] = false;
G2L["d1"]["Position"] = UDim2.new(0.03566, 0, 0.79175, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FavoriteButton.ImageLabel
G2L["d2"] = Host.New("ImageLabel", G2L["d1"]);
G2L["d2"]["BorderSizePixel"] = 0;
G2L["d2"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["d2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["d2"]["Image"] = [[rbxassetid://82062242798816]];
G2L["d2"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["d2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d2"]["BackgroundTransparency"] = 1;
G2L["d2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FavoriteButton.UICorner
G2L["d3"] = Host.New("UICorner", G2L["d1"]);
G2L["d3"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.Frame
G2L["d4"] = Host.New("Frame", G2L["c9"]);
G2L["d4"]["BorderSizePixel"] = 0;
G2L["d4"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["d4"]["Size"] = UDim2.new(1, 0, 0.34933, 0);
G2L["d4"]["Position"] = UDim2.new(0, 0, 0.83554, 0);
G2L["d4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.searchtext
G2L["d5"] = Host.New("Frame", G2L["c9"]);
G2L["d5"]["ZIndex"] = 3;
G2L["d5"]["BorderSizePixel"] = 0;
G2L["d5"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["d5"]["Size"] = UDim2.new(0.85319, 0, 0.13158, 0);
G2L["d5"]["Position"] = UDim2.new(0.036, 0, 0.08259, 0);
G2L["d5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d5"]["Name"] = [[searchtext]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.searchtext.UICorner
G2L["d6"] = Host.New("UICorner", G2L["d5"]);
G2L["d6"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.searchtext.ImageLabel
G2L["d7"] = Host.New("ImageLabel", G2L["d5"]);
G2L["d7"]["BorderSizePixel"] = 0;
G2L["d7"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["d7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d7"]["ImageColor3"] = Color3.fromRGB(133, 139, 175);
G2L["d7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["d7"]["Image"] = [[rbxassetid://70982225992034]];
G2L["d7"]["Size"] = UDim2.new(0.03232, 0, 0.48624, 0);
G2L["d7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d7"]["BackgroundTransparency"] = 1;
G2L["d7"]["Position"] = UDim2.new(0.03245, 0, 0.48523, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.searchtext.ScrollingFrame
G2L["d8"] = Host.New("ScrollingFrame", G2L["d5"]);
G2L["d8"]["Active"] = true;
G2L["d8"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["d8"]["BorderSizePixel"] = 0;
G2L["d8"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["d8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d8"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["d8"]["Size"] = UDim2.new(0.91781, 0, 0.468, 0);
G2L["d8"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d8"]["Position"] = UDim2.new(0.5244, 0, 0.498, 0);
G2L["d8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d8"]["ScrollBarThickness"] = 0;
G2L["d8"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.searchtext.ScrollingFrame.TextBox
G2L["d9"] = Host.New("TextBox", G2L["d8"]);
G2L["d9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["d9"]["PlaceholderColor3"] = Color3.fromRGB(133, 139, 175);
G2L["d9"]["BorderSizePixel"] = 0;
G2L["d9"]["TextWrapped"] = true;
G2L["d9"]["TextSize"] = 14;
G2L["d9"]["TextColor3"] = Color3.fromRGB(133, 139, 175);
G2L["d9"]["TextScaled"] = true;
G2L["d9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d9"]["Font"] = Enum.Font.GothamSemibold;
G2L["d9"]["ClearTextOnFocus"] = false;
G2L["d9"]["PlaceholderText"] = [[Search for Scripts..]];
G2L["d9"]["Size"] = UDim2.new(1.42278, 0, 0.468, 0);
G2L["d9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d9"]["Text"] = [[]];
G2L["d9"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton
G2L["da"] = Host.New("TextButton", G2L["c9"]);
G2L["da"]["BorderSizePixel"] = 0;
G2L["da"]["TextSize"] = 14;
G2L["da"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["da"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["da"]["Font"] = Enum.Font.SourceSans;
G2L["da"]["ZIndex"] = 3;
G2L["da"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["da"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["da"]["Text"] = [[]];
G2L["da"]["Name"] = [[FilterButton]];
G2L["da"]["Position"] = UDim2.new(0.90722, 0, 0.08259, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.LocalScript
G2L["db"] = Host.New("LocalScript", G2L["da"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.ImageLabel
G2L["dc"] = Host.New("ImageLabel", G2L["da"]);
G2L["dc"]["BorderSizePixel"] = 0;
G2L["dc"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["dc"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["dc"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["dc"]["Image"] = [[rbxassetid://126639883525354]];
G2L["dc"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["dc"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["dc"]["BackgroundTransparency"] = 1;
G2L["dc"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.UICorner
G2L["dd"] = Host.New("UICorner", G2L["da"]);
G2L["dd"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter
G2L["de"] = Host.New("Frame", G2L["da"]);
G2L["de"]["Visible"] = false;
G2L["de"]["ZIndex"] = 3;
G2L["de"]["BorderSizePixel"] = 0;
G2L["de"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["de"]["Size"] = UDim2.new(3.0143, 0, 1.44972, 0);
G2L["de"]["Position"] = UDim2.new(-2.0143, 0, 1.47188, 0);
G2L["de"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["de"]["Name"] = [[Filter]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.CanvasGroup
G2L["df"] = Host.New("CanvasGroup", G2L["de"]);
G2L["df"]["ZIndex"] = 2;
G2L["df"]["BorderSizePixel"] = 0;
G2L["df"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["df"]["Size"] = UDim2.new(1, 0, 0.59697, 0);
G2L["df"]["Position"] = UDim2.new(0, 0, 0.41, 0);
G2L["df"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.CanvasGroup.UIGradient
G2L["e0"] = Host.New("UIGradient", G2L["df"]);
G2L["e0"]["Rotation"] = -90;
G2L["e0"]["Transparency"] = NumberSequence.new(0, 0);
G2L["e0"]["Color"] = ColorSequence.new(Color3.fromRGB(58, 61, 77), Color3.fromRGB(58, 61, 77));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.CanvasGroup.UICorner
G2L["e1"] = Host.New("UICorner", G2L["df"]);
G2L["e1"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame
G2L["e2"] = Host.New("ScrollingFrame", G2L["de"]);
G2L["e2"]["Active"] = true;
G2L["e2"]["BorderSizePixel"] = 0;
G2L["e2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e2"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["e2"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e2"]["ScrollBarThickness"] = 0;
G2L["e2"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UIListLayout
G2L["e3"] = Host.New("UIListLayout", G2L["e2"]);
G2L["e3"]["Padding"] = UDim.new(-0.04, 0);
G2L["e3"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle
G2L["e4"] = Host.New("TextButton", G2L["e2"]);
G2L["e4"]["BorderSizePixel"] = 0;
G2L["e4"]["TextSize"] = 14;
G2L["e4"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e4"]["Font"] = Enum.Font.SourceSans;
G2L["e4"]["BackgroundTransparency"] = 0.999;
G2L["e4"]["Size"] = UDim2.new(1, 0, 0.5, 0);
G2L["e4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e4"]["Text"] = [[]];
G2L["e4"]["Name"] = [[UniversalToggle]];
G2L["e4"]["Position"] = UDim2.new(-0.13048, 0, 0.16819, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.TextLabel
G2L["e5"] = Host.New("TextLabel", G2L["e4"]);
G2L["e5"]["TextWrapped"] = true;
G2L["e5"]["BorderSizePixel"] = 0;
G2L["e5"]["TextSize"] = 14;
G2L["e5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["e5"]["TextScaled"] = true;
G2L["e5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e5"]["Font"] = Enum.Font.GothamMedium;
G2L["e5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e5"]["BackgroundTransparency"] = 1;
G2L["e5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["e5"]["Size"] = UDim2.new(0.47505, 0, 0.34459, 0);
G2L["e5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e5"]["Text"] = [[Universal]];
G2L["e5"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.EnableLabel
G2L["e6"] = Host.New("ImageLabel", G2L["e4"]);
G2L["e6"]["BorderSizePixel"] = 0;
G2L["e6"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["e6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["e6"]["Image"] = [[rbxassetid://114505038667653]];
G2L["e6"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["e6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e6"]["BackgroundTransparency"] = 1;
G2L["e6"]["Name"] = [[EnableLabel]];
G2L["e6"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color
G2L["e7"] = Host.New("Frame", G2L["e4"]);
G2L["e7"]["ZIndex"] = 0;
G2L["e7"]["BorderSizePixel"] = 0;
G2L["e7"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["e7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["e7"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["e7"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["e7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e7"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color.UICorner
G2L["e8"] = Host.New("UICorner", G2L["e7"]);
G2L["e8"]["CornerRadius"] = UDim.new(0.22, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.DisableLabel
G2L["e9"] = Host.New("ImageLabel", G2L["e4"]);
G2L["e9"]["BorderSizePixel"] = 0;
G2L["e9"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["e9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["e9"]["Image"] = [[rbxassetid://139300301612224]];
G2L["e9"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["e9"]["Visible"] = false;
G2L["e9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e9"]["BackgroundTransparency"] = 1;
G2L["e9"]["Name"] = [[DisableLabel]];
G2L["e9"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle
G2L["ea"] = Host.New("TextButton", G2L["e2"]);
G2L["ea"]["BorderSizePixel"] = 0;
G2L["ea"]["TextSize"] = 14;
G2L["ea"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ea"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ea"]["Font"] = Enum.Font.SourceSans;
G2L["ea"]["BackgroundTransparency"] = 0.999;
G2L["ea"]["Size"] = UDim2.new(1, 0, 0.5, 0);
G2L["ea"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ea"]["Text"] = [[]];
G2L["ea"]["Name"] = [[UniversalToggle]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.TextLabel
G2L["eb"] = Host.New("TextLabel", G2L["ea"]);
G2L["eb"]["TextWrapped"] = true;
G2L["eb"]["BorderSizePixel"] = 0;
G2L["eb"]["TextSize"] = 14;
G2L["eb"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["eb"]["TextScaled"] = true;
G2L["eb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["eb"]["Font"] = Enum.Font.GothamMedium;
G2L["eb"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["eb"]["BackgroundTransparency"] = 1;
G2L["eb"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["eb"]["Size"] = UDim2.new(0.47505, 0, 0.34459, 0);
G2L["eb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["eb"]["Text"] = [[Unverified]];
G2L["eb"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.DisableLabel
G2L["ec"] = Host.New("ImageLabel", G2L["ea"]);
G2L["ec"]["BorderSizePixel"] = 0;
G2L["ec"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["ec"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ec"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["ec"]["Image"] = [[rbxassetid://139300301612224]];
G2L["ec"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["ec"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ec"]["BackgroundTransparency"] = 1;
G2L["ec"]["Name"] = [[DisableLabel]];
G2L["ec"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color
G2L["ed"] = Host.New("Frame", G2L["ea"]);
G2L["ed"]["ZIndex"] = 0;
G2L["ed"]["BorderSizePixel"] = 0;
G2L["ed"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["ed"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["ed"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["ed"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["ed"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ed"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color.UICorner
G2L["ee"] = Host.New("UICorner", G2L["ed"]);
G2L["ee"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.EnableLabel
G2L["ef"] = Host.New("ImageLabel", G2L["ea"]);
G2L["ef"]["BorderSizePixel"] = 0;
G2L["ef"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["ef"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ef"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["ef"]["Image"] = [[rbxassetid://114505038667653]];
G2L["ef"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["ef"]["Visible"] = false;
G2L["ef"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ef"]["BackgroundTransparency"] = 1;
G2L["ef"]["Name"] = [[EnableLabel]];
G2L["ef"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.Filter.UICorner
G2L["f0"] = Host.New("UICorner", G2L["de"]);
G2L["f0"]["CornerRadius"] = UDim.new(0.22, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.CanvasGroup
G2L["f1"] = Host.New("CanvasGroup", G2L["c9"]);
G2L["f1"]["ZIndex"] = 2;
G2L["f1"]["BorderSizePixel"] = 0;
G2L["f1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f1"]["Size"] = UDim2.new(0.92819, 0, 0.28834, 0);
G2L["f1"]["Position"] = UDim2.new(0.036, 0, 0.63499, 0);
G2L["f1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.CanvasGroup.UIGradient
G2L["f2"] = Host.New("UIGradient", G2L["f1"]);
G2L["f2"]["Rotation"] = -90;
G2L["f2"]["Transparency"] = NumberSequence.new(0, 1);
G2L["f2"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame
G2L["f3"] = Host.New("ScrollingFrame", G2L["c9"]);
G2L["f3"]["Active"] = true;
G2L["f3"]["BorderSizePixel"] = 0;
G2L["f3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f3"]["Size"] = UDim2.new(0.92819, 0, 0.64422, 0);
G2L["f3"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f3"]["Position"] = UDim2.new(0.036, 0, 0.27911, 0);
G2L["f3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f3"]["ScrollBarThickness"] = 0;
G2L["f3"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.UIListLayout
G2L["f4"] = Host.New("UIListLayout", G2L["f3"]);
G2L["f4"]["Wraps"] = true;
G2L["f4"]["Padding"] = UDim.new(0.034, 0);
G2L["f4"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["f4"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate
G2L["f5"] = Host.New("TextButton", G2L["f3"]);
G2L["f5"]["BorderSizePixel"] = 0;
G2L["f5"]["TextSize"] = 14;
G2L["f5"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f5"]["Font"] = Enum.Font.SourceSans;
G2L["f5"]["BackgroundTransparency"] = 0.999;
G2L["f5"]["Size"] = UDim2.new(0.31, 0, 0.22, 0);
G2L["f5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f5"]["Text"] = [[]];
G2L["f5"]["Name"] = [[MTemplate]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template
G2L["f6"] = Host.New("ImageLabel", G2L["f5"]);
G2L["f6"]["BorderSizePixel"] = 0;
G2L["f6"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["f6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["f6"]["Image"] = [[https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=168556275&fmt=png&wd=420&ht=420]];
G2L["f6"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["f6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f6"]["Name"] = [[Template]];
G2L["f6"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.UICorner
G2L["f7"] = Host.New("UICorner", G2L["f6"]);
G2L["f7"]["CornerRadius"] = UDim.new(0.09, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.NameHolder
G2L["f8"] = Host.New("ScrollingFrame", G2L["f6"]);
G2L["f8"]["Active"] = true;
G2L["f8"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["f8"]["ZIndex"] = 3;
G2L["f8"]["BorderSizePixel"] = 0;
G2L["f8"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["f8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f8"]["Name"] = [[NameHolder]];
G2L["f8"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["f8"]["Size"] = UDim2.new(0.4845, 0, 0.21666, 0);
G2L["f8"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f8"]["Position"] = UDim2.new(0.3213, 0, 0.22021, 0);
G2L["f8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f8"]["ScrollBarThickness"] = 0;
G2L["f8"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.NameHolder.Name
G2L["f9"] = Host.New("TextLabel", G2L["f8"]);
G2L["f9"]["TextWrapped"] = true;
G2L["f9"]["BorderSizePixel"] = 0;
G2L["f9"]["TextSize"] = 14;
G2L["f9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["f9"]["TextTransparency"] = 0.08;
G2L["f9"]["TextScaled"] = true;
G2L["f9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f9"]["Font"] = Enum.Font.GothamSemibold;
G2L["f9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["f9"]["BackgroundTransparency"] = 1;
G2L["f9"]["Size"] = UDim2.new(0.3, 0, 0.18, 0);
G2L["f9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f9"]["Text"] = [[Fish It! ??]];
G2L["f9"]["Name"] = [[Name]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.FavoriteButton
G2L["fa"] = Host.New("TextButton", G2L["f6"]);
G2L["fa"]["BorderSizePixel"] = 0;
G2L["fa"]["TextSize"] = 14;
G2L["fa"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["fa"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["fa"]["Font"] = Enum.Font.SourceSans;
G2L["fa"]["ZIndex"] = 3;
G2L["fa"]["Size"] = UDim2.new(0.14295, 0, 0.21666, 0);
G2L["fa"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["fa"]["Text"] = [[]];
G2L["fa"]["Name"] = [[FavoriteButton]];
G2L["fa"]["Visible"] = false;
G2L["fa"]["Position"] = UDim2.new(0.60331, 0, 0.70182, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.FavoriteButton.FavoriteLabel
G2L["fb"] = Host.New("ImageLabel", G2L["fa"]);
G2L["fb"]["BorderSizePixel"] = 0;
G2L["fb"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["fb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["fb"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["fb"]["Image"] = [[rbxassetid://82062242798816]];
G2L["fb"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["fb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["fb"]["BackgroundTransparency"] = 1;
G2L["fb"]["Name"] = [[FavoriteLabel]];
G2L["fb"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.FavoriteButton.UICorner
G2L["fc"] = Host.New("UICorner", G2L["fa"]);
G2L["fc"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.FavoriteButton.FavoritedLabel
G2L["fd"] = Host.New("ImageLabel", G2L["fa"]);
G2L["fd"]["ZIndex"] = 2;
G2L["fd"]["BorderSizePixel"] = 0;
G2L["fd"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["fd"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["fd"]["ImageColor3"] = Color3.fromRGB(131, 137, 173);
G2L["fd"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["fd"]["Image"] = [[rbxassetid://82062242798816]];
G2L["fd"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["fd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["fd"]["BackgroundTransparency"] = 1;
G2L["fd"]["Name"] = [[FavoritedLabel]];
G2L["fd"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.viewssec
G2L["fe"] = Host.New("TextButton", G2L["f6"]);
G2L["fe"]["BorderSizePixel"] = 0;
G2L["fe"]["TextSize"] = 14;
G2L["fe"]["AutoButtonColor"] = false;
G2L["fe"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["fe"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["fe"]["Font"] = Enum.Font.SourceSans;
G2L["fe"]["ZIndex"] = 3;
G2L["fe"]["Size"] = UDim2.new(0.33724, 0, 0.21666, 0);
G2L["fe"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["fe"]["Text"] = [[]];
G2L["fe"]["Name"] = [[viewssec]];
G2L["fe"]["Position"] = UDim2.new(0.60331, 0, 0.09199, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.viewssec.ImageLabel
G2L["ff"] = Host.New("ImageLabel", G2L["fe"]);
G2L["ff"]["BorderSizePixel"] = 0;
G2L["ff"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["ff"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["ff"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["ff"]["Image"] = [[rbxassetid://72895179323779]];
G2L["ff"]["Size"] = UDim2.new(0.21194, 0, 0.5, 0);
G2L["ff"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["ff"]["BackgroundTransparency"] = 1;
G2L["ff"]["Position"] = UDim2.new(0.21194, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.viewssec.UICorner
G2L["100"] = Host.New("UICorner", G2L["fe"]);
G2L["100"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.viewssec.TextHolder
G2L["101"] = Host.New("ScrollingFrame", G2L["fe"]);
G2L["101"]["Active"] = true;
G2L["101"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["101"]["BorderSizePixel"] = 0;
G2L["101"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["101"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["101"]["Name"] = [[TextHolder]];
G2L["101"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["101"]["Size"] = UDim2.new(0.41081, 0, 0.5, 0);
G2L["101"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["101"]["Position"] = UDim2.new(0.625, 0, 0.5, 0);
G2L["101"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["101"]["ScrollBarThickness"] = 0;
G2L["101"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.viewssec.TextHolder.views
G2L["102"] = Host.New("TextLabel", G2L["101"]);
G2L["102"]["TextWrapped"] = true;
G2L["102"]["BorderSizePixel"] = 0;
G2L["102"]["TextSize"] = 14;
G2L["102"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["102"]["TextScaled"] = true;
G2L["102"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["102"]["Font"] = Enum.Font.GothamSemibold;
G2L["102"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["102"]["BackgroundTransparency"] = 1;
G2L["102"]["Size"] = UDim2.new(0.252, 0, 0.5, 0);
G2L["102"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["102"]["Text"] = [[67K]];
G2L["102"]["Name"] = [[views]];
G2L["102"]["Position"] = UDim2.new(0, 0, -0.01, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.RunButton
G2L["103"] = Host.New("TextButton", G2L["f6"]);
G2L["103"]["BorderSizePixel"] = 0;
G2L["103"]["TextSize"] = 14;
G2L["103"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["103"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["103"]["Font"] = Enum.Font.SourceSans;
G2L["103"]["ZIndex"] = 3;
G2L["103"]["Size"] = UDim2.new(0.14295, 0, 0.21666, 0);
G2L["103"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["103"]["Text"] = [[]];
G2L["103"]["Name"] = [[RunButton]];
G2L["103"]["Position"] = UDim2.new(0.80192, 0, 0.70182, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.RunButton.ImageLabel
G2L["104"] = Host.New("ImageLabel", G2L["103"]);
G2L["104"]["BorderSizePixel"] = 0;
G2L["104"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["104"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["104"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["104"]["Image"] = [[rbxassetid://110351064802458]];
G2L["104"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["104"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["104"]["BackgroundTransparency"] = 1;
G2L["104"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.RunButton.UICorner
G2L["105"] = Host.New("UICorner", G2L["103"]);
G2L["105"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.CanvasGroup
G2L["106"] = Host.New("CanvasGroup", G2L["f6"]);
G2L["106"]["ZIndex"] = 2;
G2L["106"]["BorderSizePixel"] = 0;
G2L["106"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["106"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["106"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["106"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["106"]["BackgroundTransparency"] = 0.5;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.ScrollingFrame.MTemplate.Template.CanvasGroup.UIGradient
G2L["107"] = Host.New("UIGradient", G2L["106"]);
G2L["107"]["Rotation"] = 90;
G2L["107"]["Transparency"] = NumberSequence.new(0, 1);
G2L["107"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.DragBar
G2L["108"] = Host.New("ImageButton", G2L["c9"]);
G2L["108"]["BorderSizePixel"] = 0;
G2L["108"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["108"]["BackgroundTransparency"] = 1;
G2L["108"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["108"]["ImageColor3"] = Color3.fromRGB(58, 61, 77);
G2L["108"]["Image"] = [[rbxassetid://115117166091877]];
G2L["108"]["Size"] = UDim2.new(0.06798, 0, 0.15004, 0);
G2L["108"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["108"]["Name"] = [[DragBar]];
G2L["108"]["Position"] = UDim2.new(0.46146, 0, -0.03706, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.ImageLabel
G2L["109"] = Host.New("ImageLabel", G2L["56"]);
G2L["109"]["BorderSizePixel"] = 0;
G2L["109"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["109"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["109"]["Image"] = [[rbxassetid://90351074153681]];
G2L["109"]["Size"] = UDim2.new(0.82638, 0, 0.5007, 0);
G2L["109"]["Visible"] = false;
G2L["109"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["109"]["BackgroundTransparency"] = 1;
G2L["109"]["Position"] = UDim2.new(0.18716, 0, -0.21661, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.ImageLabel.UICorner
G2L["10a"] = Host.New("UICorner", G2L["109"]);
G2L["10a"]["CornerRadius"] = UDim.new(0.1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings
G2L["10b"] = Host.New("Frame", G2L["56"]);
G2L["10b"]["Visible"] = false;
G2L["10b"]["BorderSizePixel"] = 0;
G2L["10b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["10b"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["10b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10b"]["Name"] = [[Settings]];
G2L["10b"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow
G2L["10c"] = Host.New("Frame", G2L["10b"]);
G2L["10c"]["Visible"] = false;
G2L["10c"]["Active"] = true;
G2L["10c"]["ZIndex"] = 5;
G2L["10c"]["BorderSizePixel"] = 0;
G2L["10c"]["BackgroundColor3"] = Color3.fromRGB(22, 24, 27);
G2L["10c"]["Size"] = UDim2.new(1.19013, 0, 1.1322, 0);
G2L["10c"]["Position"] = UDim2.new(0, 0, -0.00072, 0);
G2L["10c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10c"]["Name"] = [[InWindow]];
G2L["10c"]["BackgroundTransparency"] = 0.5;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.UICorner
G2L["10d"] = Host.New("UICorner", G2L["10c"]);
G2L["10d"]["CornerRadius"] = UDim.new(0.06, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget
G2L["10e"] = Host.New("Frame", G2L["10c"]);
G2L["10e"]["ZIndex"] = 5;
G2L["10e"]["BorderSizePixel"] = 0;
G2L["10e"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["10e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["10e"]["Size"] = UDim2.new(0.78194, 0, 0.61652, 0);
G2L["10e"]["Position"] = UDim2.new(0.42, 0, 0.575, 0);
G2L["10e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10e"]["Name"] = [[SearchWidget]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.UICorner
G2L["10f"] = Host.New("UICorner", G2L["10e"]);
G2L["10f"]["CornerRadius"] = UDim.new(0.09, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.RunButton
G2L["110"] = Host.New("TextButton", G2L["10e"]);
G2L["110"]["BorderSizePixel"] = 0;
G2L["110"]["TextSize"] = 14;
G2L["110"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["110"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["110"]["Font"] = Enum.Font.SourceSans;
G2L["110"]["ZIndex"] = 3;
G2L["110"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["110"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["110"]["Text"] = [[]];
G2L["110"]["Name"] = [[RunButton]];
G2L["110"]["Position"] = UDim2.new(0.90722, 0, 0.79175, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.RunButton.ImageLabel
G2L["111"] = Host.New("ImageLabel", G2L["110"]);
G2L["111"]["BorderSizePixel"] = 0;
G2L["111"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["111"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["111"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["111"]["Image"] = [[rbxassetid://86332328738313]];
G2L["111"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["111"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["111"]["BackgroundTransparency"] = 1;
G2L["111"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.RunButton.UICorner
G2L["112"] = Host.New("UICorner", G2L["110"]);
G2L["112"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.CloseButton
G2L["113"] = Host.New("TextButton", G2L["10e"]);
G2L["113"]["BorderSizePixel"] = 0;
G2L["113"]["TextSize"] = 14;
G2L["113"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["113"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["113"]["Font"] = Enum.Font.SourceSans;
G2L["113"]["ZIndex"] = 3;
G2L["113"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["113"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["113"]["Text"] = [[]];
G2L["113"]["Name"] = [[CloseButton]];
G2L["113"]["Position"] = UDim2.new(0.83222, 0, 0.79175, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.CloseButton.UICorner
G2L["114"] = Host.New("UICorner", G2L["113"]);
G2L["114"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.CloseButton.ImageLabel
G2L["115"] = Host.New("ImageLabel", G2L["113"]);
G2L["115"]["BorderSizePixel"] = 0;
G2L["115"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["115"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["115"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["115"]["Image"] = [[rbxassetid://89281427981411]];
G2L["115"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["115"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["115"]["BackgroundTransparency"] = 1;
G2L["115"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FavoriteButton
G2L["116"] = Host.New("TextButton", G2L["10e"]);
G2L["116"]["BorderSizePixel"] = 0;
G2L["116"]["TextSize"] = 14;
G2L["116"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["116"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["116"]["Font"] = Enum.Font.SourceSans;
G2L["116"]["ZIndex"] = 3;
G2L["116"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["116"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["116"]["Text"] = [[]];
G2L["116"]["Name"] = [[FavoriteButton]];
G2L["116"]["Position"] = UDim2.new(0.03566, 0, 0.79175, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FavoriteButton.ImageLabel
G2L["117"] = Host.New("ImageLabel", G2L["116"]);
G2L["117"]["BorderSizePixel"] = 0;
G2L["117"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["117"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["117"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["117"]["Image"] = [[rbxassetid://82062242798816]];
G2L["117"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["117"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["117"]["BackgroundTransparency"] = 1;
G2L["117"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FavoriteButton.UICorner
G2L["118"] = Host.New("UICorner", G2L["116"]);
G2L["118"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.Frame
G2L["119"] = Host.New("Frame", G2L["10e"]);
G2L["119"]["BorderSizePixel"] = 0;
G2L["119"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["119"]["Size"] = UDim2.new(1, 0, 0.34933, 0);
G2L["119"]["Position"] = UDim2.new(0, 0, 0.83554, 0);
G2L["119"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.Frame
G2L["11a"] = Host.New("Frame", G2L["10e"]);
G2L["11a"]["ZIndex"] = 3;
G2L["11a"]["BorderSizePixel"] = 0;
G2L["11a"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["11a"]["Size"] = UDim2.new(0.85319, 0, 0.13158, 0);
G2L["11a"]["Position"] = UDim2.new(0.036, 0, 0.08259, 0);
G2L["11a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.Frame.UICorner
G2L["11b"] = Host.New("UICorner", G2L["11a"]);
G2L["11b"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.Frame.ImageLabel
G2L["11c"] = Host.New("ImageLabel", G2L["11a"]);
G2L["11c"]["BorderSizePixel"] = 0;
G2L["11c"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["11c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11c"]["ImageColor3"] = Color3.fromRGB(133, 139, 175);
G2L["11c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["11c"]["Image"] = [[rbxassetid://70982225992034]];
G2L["11c"]["Size"] = UDim2.new(0.03232, 0, 0.48624, 0);
G2L["11c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11c"]["BackgroundTransparency"] = 1;
G2L["11c"]["Position"] = UDim2.new(0.03245, 0, 0.48523, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.Frame.ScrollingFrame
G2L["11d"] = Host.New("ScrollingFrame", G2L["11a"]);
G2L["11d"]["Active"] = true;
G2L["11d"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["11d"]["BorderSizePixel"] = 0;
G2L["11d"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["11d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["11d"]["Size"] = UDim2.new(0.91781, 0, 0.468, 0);
G2L["11d"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11d"]["Position"] = UDim2.new(0.5244, 0, 0.498, 0);
G2L["11d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11d"]["ScrollBarThickness"] = 0;
G2L["11d"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.Frame.ScrollingFrame.TextBox
G2L["11e"] = Host.New("TextBox", G2L["11d"]);
G2L["11e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["11e"]["PlaceholderColor3"] = Color3.fromRGB(133, 139, 175);
G2L["11e"]["BorderSizePixel"] = 0;
G2L["11e"]["TextWrapped"] = true;
G2L["11e"]["TextSize"] = 14;
G2L["11e"]["TextColor3"] = Color3.fromRGB(133, 139, 175);
G2L["11e"]["TextScaled"] = true;
G2L["11e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["11e"]["Font"] = Enum.Font.GothamSemibold;
G2L["11e"]["PlaceholderText"] = [[Search for Extensions..]];
G2L["11e"]["Size"] = UDim2.new(1.42278, 0, 0.468, 0);
G2L["11e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11e"]["Text"] = [[]];
G2L["11e"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton
G2L["11f"] = Host.New("TextButton", G2L["10e"]);
G2L["11f"]["BorderSizePixel"] = 0;
G2L["11f"]["TextSize"] = 14;
G2L["11f"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11f"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["11f"]["Font"] = Enum.Font.SourceSans;
G2L["11f"]["ZIndex"] = 3;
G2L["11f"]["Size"] = UDim2.new(0.05697, 0, 0.13158, 0);
G2L["11f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["11f"]["Text"] = [[]];
G2L["11f"]["Name"] = [[FilterButton]];
G2L["11f"]["Position"] = UDim2.new(0.90722, 0, 0.08259, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.ImageLabel
G2L["120"] = Host.New("ImageLabel", G2L["11f"]);
G2L["120"]["BorderSizePixel"] = 0;
G2L["120"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["120"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["120"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["120"]["Image"] = [[rbxassetid://126639883525354]];
G2L["120"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["120"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["120"]["BackgroundTransparency"] = 1;
G2L["120"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.UICorner
G2L["121"] = Host.New("UICorner", G2L["11f"]);
G2L["121"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter
G2L["122"] = Host.New("Frame", G2L["11f"]);
G2L["122"]["Visible"] = false;
G2L["122"]["ZIndex"] = 3;
G2L["122"]["BorderSizePixel"] = 0;
G2L["122"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["122"]["Size"] = UDim2.new(3.0143, 0, 1.44972, 0);
G2L["122"]["Position"] = UDim2.new(-2.0143, 0, 1.47188, 0);
G2L["122"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["122"]["Name"] = [[Filter]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.CanvasGroup
G2L["123"] = Host.New("CanvasGroup", G2L["122"]);
G2L["123"]["ZIndex"] = 2;
G2L["123"]["BorderSizePixel"] = 0;
G2L["123"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["123"]["Size"] = UDim2.new(1, 0, 0.59697, 0);
G2L["123"]["Position"] = UDim2.new(0, 0, 0.41, 0);
G2L["123"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.CanvasGroup.UIGradient
G2L["124"] = Host.New("UIGradient", G2L["123"]);
G2L["124"]["Rotation"] = -90;
G2L["124"]["Transparency"] = NumberSequence.new(0, 0);
G2L["124"]["Color"] = ColorSequence.new(Color3.fromRGB(58, 61, 77), Color3.fromRGB(58, 61, 77));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.CanvasGroup.UICorner
G2L["125"] = Host.New("UICorner", G2L["123"]);
G2L["125"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame
G2L["126"] = Host.New("ScrollingFrame", G2L["122"]);
G2L["126"]["Active"] = true;
G2L["126"]["BorderSizePixel"] = 0;
G2L["126"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["126"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["126"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["126"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["126"]["ScrollBarThickness"] = 0;
G2L["126"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UIListLayout
G2L["127"] = Host.New("UIListLayout", G2L["126"]);
G2L["127"]["Padding"] = UDim.new(-0.04, 0);
G2L["127"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle
G2L["128"] = Host.New("TextButton", G2L["126"]);
G2L["128"]["BorderSizePixel"] = 0;
G2L["128"]["TextSize"] = 14;
G2L["128"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["128"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["128"]["Font"] = Enum.Font.SourceSans;
G2L["128"]["BackgroundTransparency"] = 0.999;
G2L["128"]["Size"] = UDim2.new(1, 0, 0.5, 0);
G2L["128"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["128"]["Text"] = [[]];
G2L["128"]["Name"] = [[UniversalToggle]];
G2L["128"]["Position"] = UDim2.new(-0.13048, 0, 0.16819, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.TextLabel
G2L["129"] = Host.New("TextLabel", G2L["128"]);
G2L["129"]["TextWrapped"] = true;
G2L["129"]["BorderSizePixel"] = 0;
G2L["129"]["TextSize"] = 14;
G2L["129"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["129"]["TextScaled"] = true;
G2L["129"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["129"]["Font"] = Enum.Font.GothamMedium;
G2L["129"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["129"]["BackgroundTransparency"] = 1;
G2L["129"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["129"]["Size"] = UDim2.new(0.47505, 0, 0.34459, 0);
G2L["129"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["129"]["Text"] = [[Universal]];
G2L["129"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.EnableLabel
G2L["12a"] = Host.New("ImageLabel", G2L["128"]);
G2L["12a"]["BorderSizePixel"] = 0;
G2L["12a"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["12a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["12a"]["Image"] = [[rbxassetid://114505038667653]];
G2L["12a"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["12a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12a"]["BackgroundTransparency"] = 1;
G2L["12a"]["Name"] = [[EnableLabel]];
G2L["12a"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color
G2L["12b"] = Host.New("Frame", G2L["128"]);
G2L["12b"]["ZIndex"] = 0;
G2L["12b"]["BorderSizePixel"] = 0;
G2L["12b"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["12b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["12b"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["12b"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["12b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12b"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color.UICorner
G2L["12c"] = Host.New("UICorner", G2L["12b"]);
G2L["12c"]["CornerRadius"] = UDim.new(0.22, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.DisableLabel
G2L["12d"] = Host.New("ImageLabel", G2L["128"]);
G2L["12d"]["BorderSizePixel"] = 0;
G2L["12d"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["12d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["12d"]["Image"] = [[rbxassetid://139300301612224]];
G2L["12d"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["12d"]["Visible"] = false;
G2L["12d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12d"]["BackgroundTransparency"] = 1;
G2L["12d"]["Name"] = [[DisableLabel]];
G2L["12d"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle
G2L["12e"] = Host.New("TextButton", G2L["126"]);
G2L["12e"]["BorderSizePixel"] = 0;
G2L["12e"]["TextSize"] = 14;
G2L["12e"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12e"]["Font"] = Enum.Font.SourceSans;
G2L["12e"]["BackgroundTransparency"] = 0.999;
G2L["12e"]["Size"] = UDim2.new(1, 0, 0.5, 0);
G2L["12e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12e"]["Text"] = [[]];
G2L["12e"]["Name"] = [[UniversalToggle]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.TextLabel
G2L["12f"] = Host.New("TextLabel", G2L["12e"]);
G2L["12f"]["TextWrapped"] = true;
G2L["12f"]["BorderSizePixel"] = 0;
G2L["12f"]["TextSize"] = 14;
G2L["12f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["12f"]["TextScaled"] = true;
G2L["12f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12f"]["Font"] = Enum.Font.GothamMedium;
G2L["12f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12f"]["BackgroundTransparency"] = 1;
G2L["12f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["12f"]["Size"] = UDim2.new(0.47505, 0, 0.34459, 0);
G2L["12f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12f"]["Text"] = [[Unverified]];
G2L["12f"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.DisableLabel
G2L["130"] = Host.New("ImageLabel", G2L["12e"]);
G2L["130"]["BorderSizePixel"] = 0;
G2L["130"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["130"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["130"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["130"]["Image"] = [[rbxassetid://139300301612224]];
G2L["130"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["130"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["130"]["BackgroundTransparency"] = 1;
G2L["130"]["Name"] = [[DisableLabel]];
G2L["130"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color
G2L["131"] = Host.New("Frame", G2L["12e"]);
G2L["131"]["ZIndex"] = 0;
G2L["131"]["BorderSizePixel"] = 0;
G2L["131"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["131"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["131"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["131"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["131"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["131"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.Color.UICorner
G2L["132"] = Host.New("UICorner", G2L["131"]);
G2L["132"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.ScrollingFrame.UniversalToggle.EnableLabel
G2L["133"] = Host.New("ImageLabel", G2L["12e"]);
G2L["133"]["BorderSizePixel"] = 0;
G2L["133"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["133"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["133"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["133"]["Image"] = [[rbxassetid://114505038667653]];
G2L["133"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["133"]["Visible"] = false;
G2L["133"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["133"]["BackgroundTransparency"] = 1;
G2L["133"]["Name"] = [[EnableLabel]];
G2L["133"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.FilterButton.Filter.UICorner
G2L["134"] = Host.New("UICorner", G2L["122"]);
G2L["134"]["CornerRadius"] = UDim.new(0.22, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.CanvasGroup
G2L["135"] = Host.New("CanvasGroup", G2L["10e"]);
G2L["135"]["ZIndex"] = 2;
G2L["135"]["BorderSizePixel"] = 0;
G2L["135"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["135"]["Size"] = UDim2.new(0.92819, 0, 0.28834, 0);
G2L["135"]["Position"] = UDim2.new(0.036, 0, 0.63499, 0);
G2L["135"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.CanvasGroup.UIGradient
G2L["136"] = Host.New("UIGradient", G2L["135"]);
G2L["136"]["Rotation"] = -90;
G2L["136"]["Transparency"] = NumberSequence.new(0, 1);
G2L["136"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame
G2L["137"] = Host.New("ScrollingFrame", G2L["10e"]);
G2L["137"]["Active"] = true;
G2L["137"]["BorderSizePixel"] = 0;
G2L["137"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["137"]["Size"] = UDim2.new(0.92819, 0, 0.64422, 0);
G2L["137"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["137"]["Position"] = UDim2.new(0.036, 0, 0.27911, 0);
G2L["137"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["137"]["ScrollBarThickness"] = 0;
G2L["137"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.UIListLayout
G2L["138"] = Host.New("UIListLayout", G2L["137"]);
G2L["138"]["Wraps"] = true;
G2L["138"]["Padding"] = UDim.new(0.034, 0);
G2L["138"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
G2L["138"]["FillDirection"] = Enum.FillDirection.Horizontal;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template
G2L["139"] = Host.New("TextButton", G2L["137"]);
G2L["139"]["BorderSizePixel"] = 0;
G2L["139"]["TextSize"] = 14;
G2L["139"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["139"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["139"]["Font"] = Enum.Font.SourceSans;
G2L["139"]["BackgroundTransparency"] = 0.999;
G2L["139"]["Size"] = UDim2.new(0.31, 0, 0.22, 0);
G2L["139"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["139"]["Text"] = [[]];
G2L["139"]["Name"] = [[Template]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content
G2L["13a"] = Host.New("ImageLabel", G2L["139"]);
G2L["13a"]["BorderSizePixel"] = 0;
G2L["13a"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["13a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["13a"]["Image"] = [[rbxassetid://88673009618862]];
G2L["13a"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["13a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13a"]["Name"] = [[Content]];
G2L["13a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallCount
G2L["13b"] = Host.New("TextButton", G2L["13a"]);
G2L["13b"]["BorderSizePixel"] = 0;
G2L["13b"]["TextSize"] = 14;
G2L["13b"]["AutoButtonColor"] = false;
G2L["13b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13b"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["13b"]["Font"] = Enum.Font.SourceSans;
G2L["13b"]["ZIndex"] = 3;
G2L["13b"]["Size"] = UDim2.new(0.33724, 0, 0.21666, 0);
G2L["13b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13b"]["Text"] = [[]];
G2L["13b"]["Name"] = [[InstallCount]];
G2L["13b"]["Position"] = UDim2.new(0.60331, 0, 0.09199, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallCount.ImageLabel
G2L["13c"] = Host.New("ImageLabel", G2L["13b"]);
G2L["13c"]["BorderSizePixel"] = 0;
G2L["13c"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["13c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["13c"]["Image"] = [[rbxassetid://90628935525596]];
G2L["13c"]["Size"] = UDim2.new(0.21194, 0, 0.5, 0);
G2L["13c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13c"]["BackgroundTransparency"] = 1;
G2L["13c"]["Position"] = UDim2.new(0.21194, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallCount.UICorner
G2L["13d"] = Host.New("UICorner", G2L["13b"]);
G2L["13d"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallCount.TextHolder
G2L["13e"] = Host.New("ScrollingFrame", G2L["13b"]);
G2L["13e"]["Active"] = true;
G2L["13e"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["13e"]["BorderSizePixel"] = 0;
G2L["13e"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["13e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13e"]["Name"] = [[TextHolder]];
G2L["13e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["13e"]["Size"] = UDim2.new(0.41081, 0, 0.5, 0);
G2L["13e"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13e"]["Position"] = UDim2.new(0.625, 0, 0.5, 0);
G2L["13e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13e"]["ScrollBarThickness"] = 0;
G2L["13e"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallCount.TextHolder.TextLabel
G2L["13f"] = Host.New("TextLabel", G2L["13e"]);
G2L["13f"]["TextWrapped"] = true;
G2L["13f"]["BorderSizePixel"] = 0;
G2L["13f"]["TextSize"] = 14;
G2L["13f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["13f"]["TextScaled"] = true;
G2L["13f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13f"]["Font"] = Enum.Font.GothamSemibold;
G2L["13f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["13f"]["BackgroundTransparency"] = 1;
G2L["13f"]["Size"] = UDim2.new(0.252, 0, 0.5, 0);
G2L["13f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["13f"]["Text"] = [[67K]];
G2L["13f"]["Position"] = UDim2.new(0, 0, -0.01, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallButton
G2L["140"] = Host.New("TextButton", G2L["13a"]);
G2L["140"]["BorderSizePixel"] = 0;
G2L["140"]["TextSize"] = 14;
G2L["140"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["140"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["140"]["Font"] = Enum.Font.SourceSans;
G2L["140"]["ZIndex"] = 3;
G2L["140"]["Size"] = UDim2.new(0.14295, 0, 0.21666, 0);
G2L["140"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["140"]["Text"] = [[]];
G2L["140"]["Name"] = [[InstallButton]];
G2L["140"]["Position"] = UDim2.new(0.80192, 0, 0.70182, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallButton.ImageLabel
G2L["141"] = Host.New("ImageLabel", G2L["140"]);
G2L["141"]["BorderSizePixel"] = 0;
G2L["141"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["141"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["141"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["141"]["Image"] = [[rbxassetid://93740886316076]];
G2L["141"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["141"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["141"]["BackgroundTransparency"] = 1;
G2L["141"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.InstallButton.UICorner
G2L["142"] = Host.New("UICorner", G2L["140"]);
G2L["142"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.UninstallButton
G2L["143"] = Host.New("TextButton", G2L["13a"]);
G2L["143"]["BorderSizePixel"] = 0;
G2L["143"]["TextSize"] = 14;
G2L["143"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["143"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["143"]["Font"] = Enum.Font.SourceSans;
G2L["143"]["ZIndex"] = 3;
G2L["143"]["Size"] = UDim2.new(0.14295, 0, 0.21666, 0);
G2L["143"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["143"]["Text"] = [[]];
G2L["143"]["Name"] = [[UninstallButton]];
G2L["143"]["Position"] = UDim2.new(0.60331, 0, 0.70182, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.UninstallButton.UICorner
G2L["144"] = Host.New("UICorner", G2L["143"]);
G2L["144"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.UninstallButton.FavoritedLabel
G2L["145"] = Host.New("ImageLabel", G2L["143"]);
G2L["145"]["ZIndex"] = 2;
G2L["145"]["BorderSizePixel"] = 0;
G2L["145"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["145"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["145"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["145"]["Image"] = [[rbxassetid://140381837548337]];
G2L["145"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["145"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["145"]["BackgroundTransparency"] = 1;
G2L["145"]["Name"] = [[FavoritedLabel]];
G2L["145"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.TextHolder
G2L["146"] = Host.New("ScrollingFrame", G2L["13a"]);
G2L["146"]["Active"] = true;
G2L["146"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["146"]["ZIndex"] = 3;
G2L["146"]["BorderSizePixel"] = 0;
G2L["146"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["146"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["146"]["Name"] = [[TextHolder]];
G2L["146"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["146"]["Size"] = UDim2.new(0.4845, 0, 0.21666, 0);
G2L["146"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["146"]["Position"] = UDim2.new(0.3213, 0, 0.22021, 0);
G2L["146"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["146"]["ScrollBarThickness"] = 0;
G2L["146"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.TextHolder.TextLabel
G2L["147"] = Host.New("TextLabel", G2L["146"]);
G2L["147"]["TextWrapped"] = true;
G2L["147"]["BorderSizePixel"] = 0;
G2L["147"]["TextSize"] = 14;
G2L["147"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["147"]["TextTransparency"] = 0.08;
G2L["147"]["TextScaled"] = true;
G2L["147"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["147"]["Font"] = Enum.Font.GothamSemibold;
G2L["147"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["147"]["BackgroundTransparency"] = 1;
G2L["147"]["Size"] = UDim2.new(0.3, 0, 0.18, 0);
G2L["147"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["147"]["Text"] = [[[?????] Syntax]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.CanvasGroup
G2L["148"] = Host.New("CanvasGroup", G2L["13a"]);
G2L["148"]["ZIndex"] = 2;
G2L["148"]["BorderSizePixel"] = 0;
G2L["148"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["148"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["148"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["148"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["148"]["BackgroundTransparency"] = 0.5;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.CanvasGroup.UIGradient
G2L["149"] = Host.New("UIGradient", G2L["148"]);
G2L["149"]["Rotation"] = 90;
G2L["149"]["Transparency"] = NumberSequence.new(0, 1);
G2L["149"]["Color"] = ColorSequence.new(Color3.fromRGB(21, 23, 27), Color3.fromRGB(21, 23, 27));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.ScrollingFrame.Template.Content.UICorner
G2L["14a"] = Host.New("UICorner", G2L["13a"]);
G2L["14a"]["CornerRadius"] = UDim.new(0.09, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.InWindow.SearchWidget.DragBar
G2L["14b"] = Host.New("ImageButton", G2L["10e"]);
G2L["14b"]["BorderSizePixel"] = 0;
G2L["14b"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["14b"]["BackgroundTransparency"] = 1;
G2L["14b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["14b"]["ImageColor3"] = Color3.fromRGB(58, 61, 77);
G2L["14b"]["Image"] = [[rbxassetid://115117166091877]];
G2L["14b"]["Size"] = UDim2.new(0.06798, 0, 0.15004, 0);
G2L["14b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["14b"]["Name"] = [[DragBar]];
G2L["14b"]["Position"] = UDim2.new(0.46146, 0, -0.03706, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar
G2L["14c"] = Host.New("Frame", G2L["10b"]);
G2L["14c"]["BorderSizePixel"] = 0;
G2L["14c"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["14c"]["Size"] = UDim2.new(0.93061, 0, 0.20714, 0);
G2L["14c"]["Position"] = UDim2.new(0.035, 0, 0.064, 0);
G2L["14c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["14c"]["Name"] = [[SearchBar]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.UICorner
G2L["14d"] = Host.New("UICorner", G2L["14c"]);
G2L["14d"]["CornerRadius"] = UDim.new(0.24, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.Frame
G2L["14e"] = Host.New("Frame", G2L["14c"]);
G2L["14e"]["ZIndex"] = 3;
G2L["14e"]["BorderSizePixel"] = 0;
G2L["14e"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["14e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["14e"]["Size"] = UDim2.new(0.92984, 0, 0.44466, 0);
G2L["14e"]["Position"] = UDim2.new(0.49973, 0, 0.5, 0);
G2L["14e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.Frame.UICorner
G2L["14f"] = Host.New("UICorner", G2L["14e"]);
G2L["14f"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.Frame.ImageLabel
G2L["150"] = Host.New("ImageLabel", G2L["14e"]);
G2L["150"]["BorderSizePixel"] = 0;
G2L["150"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["150"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["150"]["ImageColor3"] = Color3.fromRGB(133, 139, 175);
G2L["150"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["150"]["Image"] = [[rbxassetid://70982225992034]];
G2L["150"]["Size"] = UDim2.new(0.03232, 0, 0.48624, 0);
G2L["150"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["150"]["BackgroundTransparency"] = 1;
G2L["150"]["Position"] = UDim2.new(0.03245, 0, 0.48523, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.Frame.ScrollingFrame
G2L["151"] = Host.New("ScrollingFrame", G2L["14e"]);
G2L["151"]["Active"] = true;
G2L["151"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["151"]["BorderSizePixel"] = 0;
G2L["151"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["151"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["151"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["151"]["Size"] = UDim2.new(0.91781, 0, 0.468, 0);
G2L["151"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["151"]["Position"] = UDim2.new(0.5244, 0, 0.498, 0);
G2L["151"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["151"]["ScrollBarThickness"] = 0;
G2L["151"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.Frame.ScrollingFrame.TextBox
G2L["152"] = Host.New("TextBox", G2L["151"]);
G2L["152"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["152"]["PlaceholderColor3"] = Color3.fromRGB(133, 139, 175);
G2L["152"]["BorderSizePixel"] = 0;
G2L["152"]["TextWrapped"] = true;
G2L["152"]["TextSize"] = 14;
G2L["152"]["TextColor3"] = Color3.fromRGB(133, 139, 175);
G2L["152"]["TextScaled"] = true;
G2L["152"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["152"]["Font"] = Enum.Font.GothamSemibold;
G2L["152"]["PlaceholderText"] = [[Search for Settings..]];
G2L["152"]["Size"] = UDim2.new(1.42278, 0, 0.468, 0);
G2L["152"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["152"]["Text"] = [[]];
G2L["152"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.ExtensionButton
G2L["153"] = Host.New("TextButton", G2L["14c"]);
G2L["153"]["BorderSizePixel"] = 0;
G2L["153"]["TextSize"] = 14;
G2L["153"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["153"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["153"]["Font"] = Enum.Font.SourceSans;
G2L["153"]["ZIndex"] = 2;
G2L["153"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["153"]["Size"] = UDim2.new(0.057, 0, 0.44466, 0);
G2L["153"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["153"]["Text"] = [[]];
G2L["153"]["Name"] = [[ExtensionButton]];
G2L["153"]["Visible"] = false;
G2L["153"]["Position"] = UDim2.new(0.936, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.ExtensionButton.LocalScript
G2L["154"] = Host.New("LocalScript", G2L["153"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.ExtensionButton.ImageLabel
G2L["155"] = Host.New("ImageLabel", G2L["153"]);
G2L["155"]["BorderSizePixel"] = 0;
G2L["155"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["155"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["155"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["155"]["Image"] = [[rbxassetid://138611041897734]];
G2L["155"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["155"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["155"]["BackgroundTransparency"] = 1;
G2L["155"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.ExtensionButton.UICorner
G2L["156"] = Host.New("UICorner", G2L["153"]);
G2L["156"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame
G2L["157"] = Host.New("ScrollingFrame", G2L["10b"]);
G2L["157"]["Active"] = true;
G2L["157"]["BorderSizePixel"] = 0;
G2L["157"]["CanvasSize"] = UDim2.new(0, 0, 6, 0);
G2L["157"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["157"]["Size"] = UDim2.new(0.93075, 0, 0.609, 0);
G2L["157"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["157"]["Position"] = UDim2.new(0.035, 0, 0.3298, 0);
G2L["157"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["157"]["ScrollBarThickness"] = 0;
G2L["157"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS
G2L["158"] = Host.New("Frame", G2L["157"]);
G2L["158"]["BorderSizePixel"] = 0;
G2L["158"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["158"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["158"]["Position"] = UDim2.new(0, 0, -0, 0);
G2L["158"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["158"]["Name"] = [[UnlockFPS]];
G2L["158"]["LayoutOrder"] = 2;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.UICorner
G2L["159"] = Host.New("UICorner", G2L["158"]);
G2L["159"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.TextLabel
G2L["15a"] = Host.New("TextLabel", G2L["158"]);
G2L["15a"]["TextWrapped"] = true;
G2L["15a"]["BorderSizePixel"] = 0;
G2L["15a"]["TextSize"] = 14;
G2L["15a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["15a"]["TextScaled"] = true;
G2L["15a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15a"]["Font"] = Enum.Font.GothamBold;
G2L["15a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15a"]["BackgroundTransparency"] = 1;
G2L["15a"]["Size"] = UDim2.new(0.19309, 0, 0.19409, 0);
G2L["15a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["15a"]["Text"] = [[Unlock FPS,]];
G2L["15a"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.TextLabel
G2L["15b"] = Host.New("TextLabel", G2L["158"]);
G2L["15b"]["TextWrapped"] = true;
G2L["15b"]["BorderSizePixel"] = 0;
G2L["15b"]["TextSize"] = 14;
G2L["15b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["15b"]["TextScaled"] = true;
G2L["15b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15b"]["Font"] = Enum.Font.GothamMedium;
G2L["15b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15b"]["BackgroundTransparency"] = 1;
G2L["15b"]["RichText"] = true;
G2L["15b"]["Size"] = UDim2.new(0.21697, 0, 0.16304, 0);
G2L["15b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["15b"]["Text"] = [[Unlocks Roblox's <font color="rgb(105, 143, 243)">FPS Cap</font>,]];
G2L["15b"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton
G2L["15c"] = Host.New("TextButton", G2L["158"]);
G2L["15c"]["BorderSizePixel"] = 0;
G2L["15c"]["TextSize"] = 14;
G2L["15c"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["15c"]["BackgroundColor3"] = Color3.fromRGB(86, 115, 194);
G2L["15c"]["Font"] = Enum.Font.SourceSans;
G2L["15c"]["ZIndex"] = 2;
G2L["15c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["15c"]["Size"] = UDim2.new(0.09064, 0, 0.44466, 0);
G2L["15c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["15c"]["Text"] = [[]];
G2L["15c"]["Name"] = [[ToggleButton]];
G2L["15c"]["Position"] = UDim2.new(0.91918, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.LocalScript
G2L["15d"] = Host.New("LocalScript", G2L["15c"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.UICorner
G2L["15e"] = Host.New("UICorner", G2L["15c"]);
G2L["15e"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Enabled
G2L["15f"] = Host.New("ImageLabel", G2L["15c"]);
G2L["15f"]["ZIndex"] = 2;
G2L["15f"]["BorderSizePixel"] = 0;
G2L["15f"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["15f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15f"]["Image"] = [[rbxassetid://105334603868078]];
G2L["15f"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["15f"]["Visible"] = false;
G2L["15f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["15f"]["Name"] = [[Enabled]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Enabled.UIGradient
G2L["160"] = Host.New("UIGradient", G2L["15f"]);
G2L["160"]["Rotation"] = -50;
G2L["160"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["160"]["Color"] = ColorSequence.new(Color3.fromRGB(106, 144, 244), Color3.fromRGB(106, 144, 244));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Enabled.UICorner
G2L["161"] = Host.New("UICorner", G2L["15f"]);
G2L["161"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Disabled
G2L["162"] = Host.New("ImageLabel", G2L["15c"]);
G2L["162"]["BorderSizePixel"] = 0;
G2L["162"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["162"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["162"]["Image"] = [[rbxassetid://105334603868078]];
G2L["162"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["162"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["162"]["Name"] = [[Disabled]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Disabled.UIGradient
G2L["163"] = Host.New("UIGradient", G2L["162"]);
G2L["163"]["Rotation"] = -50;
G2L["163"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["163"]["Color"] = ColorSequence.new(Color3.fromRGB(51, 54, 68), Color3.fromRGB(51, 54, 68));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Disabled.UICorner
G2L["164"] = Host.New("UICorner", G2L["162"]);
G2L["164"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Frame
G2L["165"] = Host.New("Frame", G2L["15c"]);
G2L["165"]["ZIndex"] = 3;
G2L["165"]["BorderSizePixel"] = 0;
G2L["165"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["165"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["165"]["Size"] = UDim2.new(0.38475, 0, 0.61267, 0);
G2L["165"]["Position"] = UDim2.new(0.3, 0, 0.5, 0);
G2L["165"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.Frame.UICorner
G2L["166"] = Host.New("UICorner", G2L["165"]);
G2L["166"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger
G2L["167"] = Host.New("Frame", G2L["157"]);
G2L["167"]["Visible"] = false;
G2L["167"]["BorderSizePixel"] = 0;
G2L["167"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["167"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["167"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["167"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["167"]["Name"] = [[HiddenUITrigger]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.UICorner
G2L["168"] = Host.New("UICorner", G2L["167"]);
G2L["168"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.TextLabel
G2L["169"] = Host.New("TextLabel", G2L["167"]);
G2L["169"]["TextWrapped"] = true;
G2L["169"]["BorderSizePixel"] = 0;
G2L["169"]["TextSize"] = 14;
G2L["169"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["169"]["TextScaled"] = true;
G2L["169"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["169"]["Font"] = Enum.Font.GothamBold;
G2L["169"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["169"]["BackgroundTransparency"] = 1;
G2L["169"]["Size"] = UDim2.new(0.21697, 0, 0.19409, 0);
G2L["169"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["169"]["Text"] = [[Hidden UI Trigger,]];
G2L["169"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.TextLabel
G2L["16a"] = Host.New("TextLabel", G2L["167"]);
G2L["16a"]["TextWrapped"] = true;
G2L["16a"]["BorderSizePixel"] = 0;
G2L["16a"]["TextSize"] = 14;
G2L["16a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["16a"]["TextScaled"] = true;
G2L["16a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16a"]["Font"] = Enum.Font.GothamMedium;
G2L["16a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16a"]["BackgroundTransparency"] = 1;
G2L["16a"]["RichText"] = true;
G2L["16a"]["Size"] = UDim2.new(0.23541, 0, 0.16304, 0);
G2L["16a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16a"]["Text"] = [[Hidden Invisible UI <font color="rgb(105, 143, 243)">Trigger</font>,]];
G2L["16a"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton
G2L["16b"] = Host.New("TextButton", G2L["167"]);
G2L["16b"]["BorderSizePixel"] = 0;
G2L["16b"]["TextSize"] = 14;
G2L["16b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16b"]["BackgroundColor3"] = Color3.fromRGB(86, 115, 194);
G2L["16b"]["Font"] = Enum.Font.SourceSans;
G2L["16b"]["ZIndex"] = 2;
G2L["16b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["16b"]["Size"] = UDim2.new(0.09064, 0, 0.44466, 0);
G2L["16b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16b"]["Text"] = [[]];
G2L["16b"]["Name"] = [[ToggleButton]];
G2L["16b"]["Position"] = UDim2.new(0.91918, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.LocalScript
G2L["16c"] = Host.New("LocalScript", G2L["16b"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.UICorner
G2L["16d"] = Host.New("UICorner", G2L["16b"]);
G2L["16d"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Frame
G2L["16e"] = Host.New("Frame", G2L["16b"]);
G2L["16e"]["ZIndex"] = 3;
G2L["16e"]["BorderSizePixel"] = 0;
G2L["16e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["16e"]["Size"] = UDim2.new(0.38475, 0, 0.61267, 0);
G2L["16e"]["Position"] = UDim2.new(0.69, 0, 0.5, 0);
G2L["16e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Frame.UICorner
G2L["16f"] = Host.New("UICorner", G2L["16e"]);
G2L["16f"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Enabled
G2L["170"] = Host.New("ImageLabel", G2L["16b"]);
G2L["170"]["ZIndex"] = 2;
G2L["170"]["BorderSizePixel"] = 0;
G2L["170"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["170"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["170"]["Image"] = [[rbxassetid://105334603868078]];
G2L["170"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["170"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["170"]["Name"] = [[Enabled]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Enabled.UIGradient
G2L["171"] = Host.New("UIGradient", G2L["170"]);
G2L["171"]["Rotation"] = -50;
G2L["171"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["171"]["Color"] = ColorSequence.new(Color3.fromRGB(106, 144, 244), Color3.fromRGB(106, 144, 244));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Enabled.UICorner
G2L["172"] = Host.New("UICorner", G2L["170"]);
G2L["172"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Disabled
G2L["173"] = Host.New("ImageLabel", G2L["16b"]);
G2L["173"]["BorderSizePixel"] = 0;
G2L["173"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["173"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["173"]["Image"] = [[rbxassetid://105334603868078]];
G2L["173"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["173"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["173"]["Name"] = [[Disabled]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Disabled.UIGradient
G2L["174"] = Host.New("UIGradient", G2L["173"]);
G2L["174"]["Rotation"] = -50;
G2L["174"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["174"]["Color"] = ColorSequence.new(Color3.fromRGB(244, 244, 244), Color3.fromRGB(244, 244, 244));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.Disabled.UICorner
G2L["175"] = Host.New("UICorner", G2L["173"]);
G2L["175"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UIListLayout
G2L["176"] = Host.New("UIListLayout", G2L["157"]);
G2L["176"]["Padding"] = UDim.new(0.008, 0);
G2L["176"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI
G2L["177"] = Host.New("Frame", G2L["157"]);
G2L["177"]["Visible"] = false;
G2L["177"]["ZIndex"] = 2;
G2L["177"]["BorderSizePixel"] = 0;
G2L["177"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["177"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["177"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["177"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["177"]["Name"] = [[ChooseUI]];
G2L["177"]["LayoutOrder"] = 3;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.UICorner
G2L["178"] = Host.New("UICorner", G2L["177"]);
G2L["178"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.TextLabel
G2L["179"] = Host.New("TextLabel", G2L["177"]);
G2L["179"]["TextWrapped"] = true;
G2L["179"]["BorderSizePixel"] = 0;
G2L["179"]["TextSize"] = 14;
G2L["179"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["179"]["TextScaled"] = true;
G2L["179"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["179"]["Font"] = Enum.Font.GothamBold;
G2L["179"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["179"]["BackgroundTransparency"] = 1;
G2L["179"]["Size"] = UDim2.new(0.19309, 0, 0.19409, 0);
G2L["179"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["179"]["Text"] = [[Choose UI,]];
G2L["179"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.TextLabel
G2L["17a"] = Host.New("TextLabel", G2L["177"]);
G2L["17a"]["TextWrapped"] = true;
G2L["17a"]["BorderSizePixel"] = 0;
G2L["17a"]["TextSize"] = 14;
G2L["17a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["17a"]["TextScaled"] = true;
G2L["17a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17a"]["Font"] = Enum.Font.GothamMedium;
G2L["17a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17a"]["BackgroundTransparency"] = 1;
G2L["17a"]["RichText"] = true;
G2L["17a"]["Size"] = UDim2.new(0.21697, 0, 0.16304, 0);
G2L["17a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17a"]["Text"] = [[Select Between <font color="rgb(105, 143, 243)">V3 & V4</font>,]];
G2L["17a"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton
G2L["17b"] = Host.New("TextButton", G2L["177"]);
G2L["17b"]["BorderSizePixel"] = 0;
G2L["17b"]["TextSize"] = 14;
G2L["17b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17b"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["17b"]["Font"] = Enum.Font.SourceSans;
G2L["17b"]["ZIndex"] = 2;
G2L["17b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["17b"]["Size"] = UDim2.new(0.13915, 0, 0.44466, 0);
G2L["17b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17b"]["Text"] = [[]];
G2L["17b"]["Name"] = [[DropDownButton]];
G2L["17b"]["Position"] = UDim2.new(0.89493, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.ImageLabel
G2L["17c"] = Host.New("ImageLabel", G2L["17b"]);
G2L["17c"]["BorderSizePixel"] = 0;
G2L["17c"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["17c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["17c"]["Image"] = [[rbxassetid://103867995087995]];
G2L["17c"]["Size"] = UDim2.new(0.19921, 0, 0.5, 0);
G2L["17c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17c"]["BackgroundTransparency"] = 1;
G2L["17c"]["Rotation"] = -180;
G2L["17c"]["Position"] = UDim2.new(0.2, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.UICorner
G2L["17d"] = Host.New("UICorner", G2L["17b"]);
G2L["17d"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.TextHolder
G2L["17e"] = Host.New("ScrollingFrame", G2L["17b"]);
G2L["17e"]["Active"] = true;
G2L["17e"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["17e"]["ZIndex"] = 3;
G2L["17e"]["BorderSizePixel"] = 0;
G2L["17e"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["17e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17e"]["Name"] = [[TextHolder]];
G2L["17e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["17e"]["Size"] = UDim2.new(0.46923, 0, 0.38317, 0);
G2L["17e"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17e"]["Position"] = UDim2.new(0.7, 0, 0.5, 0);
G2L["17e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17e"]["ScrollBarThickness"] = 0;
G2L["17e"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.TextHolder.TextLabel
G2L["17f"] = Host.New("TextLabel", G2L["17e"]);
G2L["17f"]["TextWrapped"] = true;
G2L["17f"]["BorderSizePixel"] = 0;
G2L["17f"]["TextSize"] = 14;
G2L["17f"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["17f"]["TextTransparency"] = 0.08;
G2L["17f"]["TextScaled"] = true;
G2L["17f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17f"]["Font"] = Enum.Font.GothamSemibold;
G2L["17f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["17f"]["BackgroundTransparency"] = 1;
G2L["17f"]["Size"] = UDim2.new(0.1, 0, 0.4, 0);
G2L["17f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["17f"]["Text"] = [[V4]];
G2L["17f"]["Position"] = UDim2.new(-0.06, 0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown
G2L["180"] = Host.New("Frame", G2L["17b"]);
G2L["180"]["Visible"] = false;
G2L["180"]["ZIndex"] = 5;
G2L["180"]["BorderSizePixel"] = 0;
G2L["180"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["180"]["Size"] = UDim2.new(1.226, 0, 1.42, 0);
G2L["180"]["Position"] = UDim2.new(-0.23301, 0, 1.03584, 0);
G2L["180"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["180"]["Name"] = [[DropDown]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.CanvasGroup
G2L["181"] = Host.New("CanvasGroup", G2L["180"]);
G2L["181"]["ZIndex"] = 2;
G2L["181"]["BorderSizePixel"] = 0;
G2L["181"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["181"]["Size"] = UDim2.new(1, 0, 0.59697, 0);
G2L["181"]["Position"] = UDim2.new(0, 0, 0.41, 0);
G2L["181"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.CanvasGroup.UIGradient
G2L["182"] = Host.New("UIGradient", G2L["181"]);
G2L["182"]["Rotation"] = -90;
G2L["182"]["Transparency"] = NumberSequence.new(0, 1);
G2L["182"]["Color"] = ColorSequence.new(Color3.fromRGB(58, 61, 77), Color3.fromRGB(58, 61, 77));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.CanvasGroup.UICorner
G2L["183"] = Host.New("UICorner", G2L["181"]);
G2L["183"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame
G2L["184"] = Host.New("ScrollingFrame", G2L["180"]);
G2L["184"]["Active"] = true;
G2L["184"]["BorderSizePixel"] = 0;
G2L["184"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["184"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["184"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["184"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["184"]["ScrollBarThickness"] = 0;
G2L["184"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.UIListLayout
G2L["185"] = Host.New("UIListLayout", G2L["184"]);
G2L["185"]["Padding"] = UDim.new(0, -21);
G2L["185"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V3
G2L["186"] = Host.New("TextButton", G2L["184"]);
G2L["186"]["BorderSizePixel"] = 0;
G2L["186"]["TextSize"] = 14;
G2L["186"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["186"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["186"]["Font"] = Enum.Font.SourceSans;
G2L["186"]["BackgroundTransparency"] = 0.999;
G2L["186"]["Size"] = UDim2.new(1, 0, 0.5, 0);
G2L["186"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["186"]["Text"] = [[]];
G2L["186"]["Name"] = [[V3]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V3.TextLabel
G2L["187"] = Host.New("TextLabel", G2L["186"]);
G2L["187"]["TextWrapped"] = true;
G2L["187"]["BorderSizePixel"] = 0;
G2L["187"]["TextSize"] = 14;
G2L["187"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["187"]["TextScaled"] = true;
G2L["187"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["187"]["Font"] = Enum.Font.GothamMedium;
G2L["187"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["187"]["BackgroundTransparency"] = 1;
G2L["187"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["187"]["Size"] = UDim2.new(0.47505, 0, 0.34459, 0);
G2L["187"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["187"]["Text"] = [[Version 3]];
G2L["187"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V3.DisableLabel
G2L["188"] = Host.New("ImageLabel", G2L["186"]);
G2L["188"]["BorderSizePixel"] = 0;
G2L["188"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["188"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["188"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["188"]["Image"] = [[rbxassetid://139300301612224]];
G2L["188"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["188"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["188"]["BackgroundTransparency"] = 1;
G2L["188"]["Name"] = [[DisableLabel]];
G2L["188"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V3.Color
G2L["189"] = Host.New("Frame", G2L["186"]);
G2L["189"]["ZIndex"] = 0;
G2L["189"]["BorderSizePixel"] = 0;
G2L["189"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["189"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["189"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["189"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["189"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["189"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V3.Color.UICorner
G2L["18a"] = Host.New("UICorner", G2L["189"]);
G2L["18a"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V4
G2L["18b"] = Host.New("TextButton", G2L["184"]);
G2L["18b"]["BorderSizePixel"] = 0;
G2L["18b"]["TextSize"] = 14;
G2L["18b"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18b"]["Font"] = Enum.Font.SourceSans;
G2L["18b"]["BackgroundTransparency"] = 0.999;
G2L["18b"]["Size"] = UDim2.new(1, 0, 0.5, 0);
G2L["18b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18b"]["Text"] = [[]];
G2L["18b"]["Name"] = [[V4]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V4.TextLabel
G2L["18c"] = Host.New("TextLabel", G2L["18b"]);
G2L["18c"]["TextWrapped"] = true;
G2L["18c"]["BorderSizePixel"] = 0;
G2L["18c"]["TextSize"] = 14;
G2L["18c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["18c"]["TextScaled"] = true;
G2L["18c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18c"]["Font"] = Enum.Font.GothamMedium;
G2L["18c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18c"]["BackgroundTransparency"] = 1;
G2L["18c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["18c"]["Size"] = UDim2.new(0.47505, 0, 0.34459, 0);
G2L["18c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18c"]["Text"] = [[Version 4]];
G2L["18c"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V4.DisableLabel
G2L["18d"] = Host.New("ImageLabel", G2L["18b"]);
G2L["18d"]["BorderSizePixel"] = 0;
G2L["18d"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["18d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["18d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["18d"]["Image"] = [[rbxassetid://139300301612224]];
G2L["18d"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["18d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18d"]["BackgroundTransparency"] = 1;
G2L["18d"]["Name"] = [[DisableLabel]];
G2L["18d"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V4.Color
G2L["18e"] = Host.New("Frame", G2L["18b"]);
G2L["18e"]["ZIndex"] = 0;
G2L["18e"]["BorderSizePixel"] = 0;
G2L["18e"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["18e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["18e"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["18e"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["18e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["18e"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.ScrollingFrame.V4.Color.UICorner
G2L["18f"] = Host.New("UICorner", G2L["18e"]);
G2L["18f"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.ChooseUI.DropDownButton.DropDown.UICorner
G2L["190"] = Host.New("UICorner", G2L["180"]);
G2L["190"]["CornerRadius"] = UDim.new(0.22, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed
G2L["191"] = Host.New("Frame", G2L["157"]);
G2L["191"]["Visible"] = false;
G2L["191"]["ZIndex"] = 2;
G2L["191"]["BorderSizePixel"] = 0;
G2L["191"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["191"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["191"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["191"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["191"]["Name"] = [[WalkSpeed]];
G2L["191"]["LayoutOrder"] = 4;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.UICorner
G2L["192"] = Host.New("UICorner", G2L["191"]);
G2L["192"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.TextLabel
G2L["193"] = Host.New("TextLabel", G2L["191"]);
G2L["193"]["TextWrapped"] = true;
G2L["193"]["BorderSizePixel"] = 0;
G2L["193"]["TextSize"] = 14;
G2L["193"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["193"]["TextScaled"] = true;
G2L["193"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["193"]["Font"] = Enum.Font.GothamBold;
G2L["193"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["193"]["BackgroundTransparency"] = 1;
G2L["193"]["Size"] = UDim2.new(0.19309, 0, 0.19409, 0);
G2L["193"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["193"]["Text"] = [[Walkspeed,]];
G2L["193"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.TextLabel
G2L["194"] = Host.New("TextLabel", G2L["191"]);
G2L["194"]["TextWrapped"] = true;
G2L["194"]["BorderSizePixel"] = 0;
G2L["194"]["TextSize"] = 14;
G2L["194"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["194"]["TextScaled"] = true;
G2L["194"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["194"]["Font"] = Enum.Font.GothamMedium;
G2L["194"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["194"]["BackgroundTransparency"] = 1;
G2L["194"]["RichText"] = true;
G2L["194"]["Size"] = UDim2.new(0.23541, 0, 0.16304, 0);
G2L["194"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["194"]["Text"] = [[Modify Client's Walk <font color="rgb(105, 143, 243)">Speed</font>,]];
G2L["194"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.Bar
G2L["195"] = Host.New("Frame", G2L["191"]);
G2L["195"]["BorderSizePixel"] = 0;
G2L["195"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["195"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["195"]["Size"] = UDim2.new(0.47934, 0, 0.06472, 0);
G2L["195"]["Position"] = UDim2.new(0.71034, 0, 0.5, 0);
G2L["195"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["195"]["Name"] = [[Bar]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.Bar.UICorner
G2L["196"] = Host.New("UICorner", G2L["195"]);
G2L["196"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.Bar.FillLine
G2L["197"] = Host.New("Frame", G2L["195"]);
G2L["197"]["BorderSizePixel"] = 0;
G2L["197"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["197"]["Size"] = UDim2.new(0.63908, 0, 1, 0);
G2L["197"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["197"]["Name"] = [[FillLine]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.Bar.FillLine.UICorner
G2L["198"] = Host.New("UICorner", G2L["197"]);
G2L["198"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.Bar.FillLine.Drag
G2L["199"] = Host.New("TextButton", G2L["197"]);
G2L["199"]["BorderSizePixel"] = 0;
G2L["199"]["TextSize"] = 14;
G2L["199"]["AutoButtonColor"] = false;
G2L["199"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["199"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["199"]["Font"] = Enum.Font.SourceSans;
G2L["199"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["199"]["Size"] = UDim2.new(0.01246, 0, 0.01856, 0);
G2L["199"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["199"]["Text"] = [[]];
G2L["199"]["Name"] = [[Drag]];
G2L["199"]["Position"] = UDim2.new(0.99975, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.WalkSpeed.Bar.FillLine.Drag.UICorner
G2L["19a"] = Host.New("UICorner", G2L["199"]);
G2L["19a"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower
G2L["19b"] = Host.New("Frame", G2L["157"]);
G2L["19b"]["Visible"] = false;
G2L["19b"]["ZIndex"] = 2;
G2L["19b"]["BorderSizePixel"] = 0;
G2L["19b"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["19b"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["19b"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["19b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["19b"]["Name"] = [[JumpPower]];
G2L["19b"]["LayoutOrder"] = 5;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.UICorner
G2L["19c"] = Host.New("UICorner", G2L["19b"]);
G2L["19c"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.TextLabel
G2L["19d"] = Host.New("TextLabel", G2L["19b"]);
G2L["19d"]["TextWrapped"] = true;
G2L["19d"]["BorderSizePixel"] = 0;
G2L["19d"]["TextSize"] = 14;
G2L["19d"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["19d"]["TextScaled"] = true;
G2L["19d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["19d"]["Font"] = Enum.Font.GothamBold;
G2L["19d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["19d"]["BackgroundTransparency"] = 1;
G2L["19d"]["Size"] = UDim2.new(0.19309, 0, 0.19409, 0);
G2L["19d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["19d"]["Text"] = [[Jump Power,]];
G2L["19d"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.TextLabel
G2L["19e"] = Host.New("TextLabel", G2L["19b"]);
G2L["19e"]["TextWrapped"] = true;
G2L["19e"]["BorderSizePixel"] = 0;
G2L["19e"]["TextSize"] = 14;
G2L["19e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["19e"]["TextScaled"] = true;
G2L["19e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["19e"]["Font"] = Enum.Font.GothamMedium;
G2L["19e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["19e"]["BackgroundTransparency"] = 1;
G2L["19e"]["RichText"] = true;
G2L["19e"]["Size"] = UDim2.new(0.23541, 0, 0.16304, 0);
G2L["19e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["19e"]["Text"] = [[Modify Client's <font color="rgb(105, 143, 243)">Jump Power</font>,]];
G2L["19e"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.Bar
G2L["19f"] = Host.New("Frame", G2L["19b"]);
G2L["19f"]["BorderSizePixel"] = 0;
G2L["19f"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["19f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["19f"]["Size"] = UDim2.new(0.47934, 0, 0.06472, 0);
G2L["19f"]["Position"] = UDim2.new(0.71034, 0, 0.5, 0);
G2L["19f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["19f"]["Name"] = [[Bar]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.Bar.UICorner
G2L["1a0"] = Host.New("UICorner", G2L["19f"]);
G2L["1a0"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.Bar.FillLine
G2L["1a1"] = Host.New("Frame", G2L["19f"]);
G2L["1a1"]["BorderSizePixel"] = 0;
G2L["1a1"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["1a1"]["Size"] = UDim2.new(0.53481, 0, 1, 0);
G2L["1a1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a1"]["Name"] = [[FillLine]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.Bar.FillLine.UICorner
G2L["1a2"] = Host.New("UICorner", G2L["1a1"]);
G2L["1a2"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.Bar.FillLine.Drag
G2L["1a3"] = Host.New("TextButton", G2L["1a1"]);
G2L["1a3"]["BorderSizePixel"] = 0;
G2L["1a3"]["TextSize"] = 14;
G2L["1a3"]["AutoButtonColor"] = false;
G2L["1a3"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a3"]["BackgroundColor3"] = Color3.fromRGB(105, 143, 242);
G2L["1a3"]["Font"] = Enum.Font.SourceSans;
G2L["1a3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1a3"]["Size"] = UDim2.new(0.01246, 0, 0.01856, 0);
G2L["1a3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a3"]["Text"] = [[]];
G2L["1a3"]["Name"] = [[Drag]];
G2L["1a3"]["Position"] = UDim2.new(0.99975, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.JumpPower.Bar.FillLine.Drag.UICorner
G2L["1a4"] = Host.New("UICorner", G2L["1a3"]);
G2L["1a4"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget
G2L["1a5"] = Host.New("Frame", G2L["157"]);
G2L["1a5"]["Visible"] = false;
G2L["1a5"]["ZIndex"] = 2;
G2L["1a5"]["BorderSizePixel"] = 0;
G2L["1a5"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["1a5"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["1a5"]["Position"] = UDim2.new(0, 0, 0, 0);
G2L["1a5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a5"]["Name"] = [[SettingWidget]];
G2L["1a5"]["LayoutOrder"] = 1;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.UICorner
G2L["1a6"] = Host.New("UICorner", G2L["1a5"]);
G2L["1a6"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.TextLabel
G2L["1a7"] = Host.New("TextLabel", G2L["1a5"]);
G2L["1a7"]["TextWrapped"] = true;
G2L["1a7"]["BorderSizePixel"] = 0;
G2L["1a7"]["TextSize"] = 14;
G2L["1a7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1a7"]["TextScaled"] = true;
G2L["1a7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a7"]["Font"] = Enum.Font.GothamBold;
G2L["1a7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a7"]["BackgroundTransparency"] = 1;
G2L["1a7"]["Size"] = UDim2.new(0.19309, 0, 0.19409, 0);
G2L["1a7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a7"]["Text"] = [[Colorize UI,]];
G2L["1a7"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.TextLabel
G2L["1a8"] = Host.New("TextLabel", G2L["1a5"]);
G2L["1a8"]["TextWrapped"] = true;
G2L["1a8"]["BorderSizePixel"] = 0;
G2L["1a8"]["TextSize"] = 14;
G2L["1a8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1a8"]["TextScaled"] = true;
G2L["1a8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a8"]["Font"] = Enum.Font.GothamMedium;
G2L["1a8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a8"]["BackgroundTransparency"] = 1;
G2L["1a8"]["RichText"] = true;
G2L["1a8"]["Size"] = UDim2.new(0.21697, 0, 0.16304, 0);
G2L["1a8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a8"]["Text"] = [[Select Between <font color="rgb(105, 143, 243)">Colors</font>,]];
G2L["1a8"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton
G2L["1a9"] = Host.New("TextButton", G2L["1a5"]);
G2L["1a9"]["BorderSizePixel"] = 0;
G2L["1a9"]["TextSize"] = 14;
G2L["1a9"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a9"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["1a9"]["Font"] = Enum.Font.SourceSans;
G2L["1a9"]["ZIndex"] = 2;
G2L["1a9"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1a9"]["Size"] = UDim2.new(0.13915, 0, 0.44466, 0);
G2L["1a9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a9"]["Text"] = [[]];
G2L["1a9"]["Name"] = [[DropDownButton]];
G2L["1a9"]["Position"] = UDim2.new(0.89493, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.LocalScript
G2L["1aa"] = Host.New("LocalScript", G2L["1a9"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.ImageLabel
G2L["1ab"] = Host.New("ImageLabel", G2L["1a9"]);
G2L["1ab"]["BorderSizePixel"] = 0;
G2L["1ab"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1ab"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ab"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1ab"]["Image"] = [[rbxassetid://103867995087995]];
G2L["1ab"]["Size"] = UDim2.new(0.19921, 0, 0.5, 0);
G2L["1ab"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ab"]["BackgroundTransparency"] = 1;
G2L["1ab"]["Rotation"] = -180;
G2L["1ab"]["Position"] = UDim2.new(0.2, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.UICorner
G2L["1ac"] = Host.New("UICorner", G2L["1a9"]);
G2L["1ac"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.TextHolder
G2L["1ad"] = Host.New("ScrollingFrame", G2L["1a9"]);
G2L["1ad"]["Active"] = true;
G2L["1ad"]["ScrollingDirection"] = Enum.ScrollingDirection.X;
G2L["1ad"]["ZIndex"] = 3;
G2L["1ad"]["BorderSizePixel"] = 0;
G2L["1ad"]["CanvasSize"] = UDim2.new(10, 0, 1, 0);
G2L["1ad"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ad"]["Name"] = [[TextHolder]];
G2L["1ad"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1ad"]["Size"] = UDim2.new(0.46923, 0, 0.38317, 0);
G2L["1ad"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ad"]["Position"] = UDim2.new(0.68, 0, 0.5, 0);
G2L["1ad"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ad"]["ScrollBarThickness"] = 0;
G2L["1ad"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.TextHolder.TextLabel
G2L["1ae"] = Host.New("TextLabel", G2L["1ad"]);
G2L["1ae"]["TextWrapped"] = true;
G2L["1ae"]["BorderSizePixel"] = 0;
G2L["1ae"]["TextSize"] = 14;
G2L["1ae"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["1ae"]["TextTransparency"] = 0.08;
G2L["1ae"]["TextScaled"] = true;
G2L["1ae"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ae"]["Font"] = Enum.Font.GothamSemibold;
G2L["1ae"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ae"]["BackgroundTransparency"] = 1;
G2L["1ae"]["Size"] = UDim2.new(0.1, 0, 0.4, 0);
G2L["1ae"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ae"]["Text"] = [[BLUE]];
G2L["1ae"]["Position"] = UDim2.new(-0.06, 0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown
G2L["1af"] = Host.New("Frame", G2L["1a9"]);
G2L["1af"]["Visible"] = false;
G2L["1af"]["ZIndex"] = 5;
G2L["1af"]["BorderSizePixel"] = 0;
G2L["1af"]["BackgroundColor3"] = Color3.fromRGB(58, 61, 77);
G2L["1af"]["Size"] = UDim2.new(1.226, 0, 1.42, 0);
G2L["1af"]["Position"] = UDim2.new(-0.23301, 0, 1.03584, 0);
G2L["1af"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1af"]["Name"] = [[DropDown]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.CanvasGroup
G2L["1b0"] = Host.New("CanvasGroup", G2L["1af"]);
G2L["1b0"]["ZIndex"] = 2;
G2L["1b0"]["BorderSizePixel"] = 0;
G2L["1b0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b0"]["Size"] = UDim2.new(1, 0, 0.59697, 0);
G2L["1b0"]["Position"] = UDim2.new(0, 0, 0.41, 0);
G2L["1b0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.CanvasGroup.UIGradient
G2L["1b1"] = Host.New("UIGradient", G2L["1b0"]);
G2L["1b1"]["Rotation"] = -90;
G2L["1b1"]["Transparency"] = NumberSequence.new(0, 1);
G2L["1b1"]["Color"] = ColorSequence.new(Color3.fromRGB(58, 61, 77), Color3.fromRGB(58, 61, 77));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.CanvasGroup.UICorner
G2L["1b2"] = Host.New("UICorner", G2L["1b0"]);
G2L["1b2"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame
G2L["1b3"] = Host.New("ScrollingFrame", G2L["1af"]);
G2L["1b3"]["Active"] = true;
G2L["1b3"]["BorderSizePixel"] = 0;
G2L["1b3"]["CanvasSize"] = UDim2.new(0, 0, 6, 0);
G2L["1b3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b3"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["1b3"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b3"]["ScrollBarThickness"] = 0;
G2L["1b3"]["BackgroundTransparency"] = 0.999;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.UIListLayout
G2L["1b4"] = Host.New("UIListLayout", G2L["1b3"]);
G2L["1b4"]["Padding"] = UDim.new(-0.04, 0);
G2L["1b4"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Blue
G2L["1b5"] = Host.New("TextButton", G2L["1b3"]);
G2L["1b5"]["BorderSizePixel"] = 0;
G2L["1b5"]["TextSize"] = 14;
G2L["1b5"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b5"]["Font"] = Enum.Font.SourceSans;
G2L["1b5"]["BackgroundTransparency"] = 0.999;
G2L["1b5"]["Size"] = UDim2.new(1, 0, 0.167, 0);
G2L["1b5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b5"]["Text"] = [[]];
G2L["1b5"]["Name"] = [[Blue]];
G2L["1b5"]["Position"] = UDim2.new(0, 0, 0.71772, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Blue.TextLabel
G2L["1b6"] = Host.New("TextLabel", G2L["1b5"]);
G2L["1b6"]["TextWrapped"] = true;
G2L["1b6"]["BorderSizePixel"] = 0;
G2L["1b6"]["TextSize"] = 14;
G2L["1b6"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1b6"]["TextScaled"] = true;
G2L["1b6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b6"]["Font"] = Enum.Font.GothamMedium;
G2L["1b6"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b6"]["BackgroundTransparency"] = 1;
G2L["1b6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1b6"]["Size"] = UDim2.new(0.47505, 0, 0.26185, 0);
G2L["1b6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b6"]["Text"] = [[BLUE]];
G2L["1b6"]["Position"] = UDim2.new(0.598, 0, 0.489, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Blue.DisableLabel
G2L["1b7"] = Host.New("ImageLabel", G2L["1b5"]);
G2L["1b7"]["BorderSizePixel"] = 0;
G2L["1b7"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1b7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1b7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1b7"]["Image"] = [[rbxassetid://139300301612224]];
G2L["1b7"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["1b7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b7"]["BackgroundTransparency"] = 1;
G2L["1b7"]["Name"] = [[DisableLabel]];
G2L["1b7"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Blue.Color
G2L["1b8"] = Host.New("Frame", G2L["1b5"]);
G2L["1b8"]["ZIndex"] = 0;
G2L["1b8"]["BorderSizePixel"] = 0;
G2L["1b8"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["1b8"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1b8"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["1b8"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1b8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1b8"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Blue.Color.UICorner
G2L["1b9"] = Host.New("UICorner", G2L["1b8"]);
G2L["1b9"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Red
G2L["1ba"] = Host.New("TextButton", G2L["1b3"]);
G2L["1ba"]["BorderSizePixel"] = 0;
G2L["1ba"]["TextSize"] = 14;
G2L["1ba"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ba"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ba"]["Font"] = Enum.Font.SourceSans;
G2L["1ba"]["BackgroundTransparency"] = 0.999;
G2L["1ba"]["Size"] = UDim2.new(1, 0, 0.167, 0);
G2L["1ba"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ba"]["Text"] = [[]];
G2L["1ba"]["Name"] = [[Red]];
G2L["1ba"]["Position"] = UDim2.new(0, 0, 0.93397, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Red.TextLabel
G2L["1bb"] = Host.New("TextLabel", G2L["1ba"]);
G2L["1bb"]["TextWrapped"] = true;
G2L["1bb"]["BorderSizePixel"] = 0;
G2L["1bb"]["TextSize"] = 14;
G2L["1bb"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1bb"]["TextScaled"] = true;
G2L["1bb"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1bb"]["Font"] = Enum.Font.GothamMedium;
G2L["1bb"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1bb"]["BackgroundTransparency"] = 1;
G2L["1bb"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1bb"]["Size"] = UDim2.new(0.475, 0, 0.262, 0);
G2L["1bb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1bb"]["Text"] = [[RED]];
G2L["1bb"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Red.DisableLabel
G2L["1bc"] = Host.New("ImageLabel", G2L["1ba"]);
G2L["1bc"]["BorderSizePixel"] = 0;
G2L["1bc"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1bc"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1bc"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1bc"]["Image"] = [[rbxassetid://139300301612224]];
G2L["1bc"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["1bc"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1bc"]["BackgroundTransparency"] = 1;
G2L["1bc"]["Name"] = [[DisableLabel]];
G2L["1bc"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Red.Color
G2L["1bd"] = Host.New("Frame", G2L["1ba"]);
G2L["1bd"]["ZIndex"] = 0;
G2L["1bd"]["BorderSizePixel"] = 0;
G2L["1bd"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["1bd"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1bd"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["1bd"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1bd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1bd"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Red.Color.UICorner
G2L["1be"] = Host.New("UICorner", G2L["1bd"]);
G2L["1be"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Pink
G2L["1bf"] = Host.New("TextButton", G2L["1b3"]);
G2L["1bf"]["BorderSizePixel"] = 0;
G2L["1bf"]["TextSize"] = 14;
G2L["1bf"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1bf"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1bf"]["Font"] = Enum.Font.SourceSans;
G2L["1bf"]["BackgroundTransparency"] = 0.999;
G2L["1bf"]["Size"] = UDim2.new(1, 0, 0.167, 0);
G2L["1bf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1bf"]["Text"] = [[]];
G2L["1bf"]["Name"] = [[Pink]];
G2L["1bf"]["Position"] = UDim2.new(0, 0, 1.15023, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Pink.TextLabel
G2L["1c0"] = Host.New("TextLabel", G2L["1bf"]);
G2L["1c0"]["TextWrapped"] = true;
G2L["1c0"]["BorderSizePixel"] = 0;
G2L["1c0"]["TextSize"] = 14;
G2L["1c0"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1c0"]["TextScaled"] = true;
G2L["1c0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c0"]["Font"] = Enum.Font.GothamMedium;
G2L["1c0"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c0"]["BackgroundTransparency"] = 1;
G2L["1c0"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c0"]["Size"] = UDim2.new(0.475, 0, 0.262, 0);
G2L["1c0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c0"]["Text"] = [[PINK]];
G2L["1c0"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Pink.DisableLabel
G2L["1c1"] = Host.New("ImageLabel", G2L["1bf"]);
G2L["1c1"]["BorderSizePixel"] = 0;
G2L["1c1"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1c1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c1"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c1"]["Image"] = [[rbxassetid://139300301612224]];
G2L["1c1"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["1c1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c1"]["BackgroundTransparency"] = 1;
G2L["1c1"]["Name"] = [[DisableLabel]];
G2L["1c1"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Pink.Color
G2L["1c2"] = Host.New("Frame", G2L["1bf"]);
G2L["1c2"]["ZIndex"] = 0;
G2L["1c2"]["BorderSizePixel"] = 0;
G2L["1c2"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["1c2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c2"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["1c2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1c2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c2"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Pink.Color.UICorner
G2L["1c3"] = Host.New("UICorner", G2L["1c2"]);
G2L["1c3"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Green
G2L["1c4"] = Host.New("TextButton", G2L["1b3"]);
G2L["1c4"]["BorderSizePixel"] = 0;
G2L["1c4"]["TextSize"] = 14;
G2L["1c4"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c4"]["Font"] = Enum.Font.SourceSans;
G2L["1c4"]["BackgroundTransparency"] = 0.999;
G2L["1c4"]["Size"] = UDim2.new(1, 0, 0.167, 0);
G2L["1c4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c4"]["Text"] = [[]];
G2L["1c4"]["Name"] = [[Green]];
G2L["1c4"]["Position"] = UDim2.new(0, 0, 1.15023, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Green.TextLabel
G2L["1c5"] = Host.New("TextLabel", G2L["1c4"]);
G2L["1c5"]["TextWrapped"] = true;
G2L["1c5"]["BorderSizePixel"] = 0;
G2L["1c5"]["TextSize"] = 14;
G2L["1c5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1c5"]["TextScaled"] = true;
G2L["1c5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c5"]["Font"] = Enum.Font.GothamMedium;
G2L["1c5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c5"]["BackgroundTransparency"] = 1;
G2L["1c5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c5"]["Size"] = UDim2.new(0.475, 0, 0.262, 0);
G2L["1c5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c5"]["Text"] = [[GREEN]];
G2L["1c5"]["Position"] = UDim2.new(0.59848, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Green.DisableLabel
G2L["1c6"] = Host.New("ImageLabel", G2L["1c4"]);
G2L["1c6"]["BorderSizePixel"] = 0;
G2L["1c6"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1c6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1c6"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c6"]["Image"] = [[rbxassetid://139300301612224]];
G2L["1c6"]["Size"] = UDim2.new(0.13454, 0, 0.39351, 0);
G2L["1c6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c6"]["BackgroundTransparency"] = 1;
G2L["1c6"]["Name"] = [[DisableLabel]];
G2L["1c6"]["Position"] = UDim2.new(0.23037, 0, 0.48856, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Green.Color
G2L["1c7"] = Host.New("Frame", G2L["1c4"]);
G2L["1c7"]["ZIndex"] = 0;
G2L["1c7"]["BorderSizePixel"] = 0;
G2L["1c7"]["BackgroundColor3"] = Color3.fromRGB(34, 33, 39);
G2L["1c7"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1c7"]["Size"] = UDim2.new(0.8, 0, 0.58, 0);
G2L["1c7"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1c7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1c7"]["Name"] = [[Color]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.ScrollingFrame.Green.Color.UICorner
G2L["1c8"] = Host.New("UICorner", G2L["1c7"]);
G2L["1c8"]["CornerRadius"] = UDim.new(0.2, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.DropDown.UICorner
G2L["1c9"] = Host.New("UICorner", G2L["1af"]);
G2L["1c9"]["CornerRadius"] = UDim.new(0.22, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.select1
G2L["1ca"] = Host.New("CanvasGroup", G2L["1a9"]);
G2L["1ca"]["Visible"] = false;
G2L["1ca"]["ZIndex"] = 3;
G2L["1ca"]["BorderSizePixel"] = 0;
G2L["1ca"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["1ca"]["Size"] = UDim2.new(1, 0, 0, 0);
G2L["1ca"]["Position"] = UDim2.new(0, 0, 1.1, 0);
G2L["1ca"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ca"]["Name"] = [[select1]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.select1.UICorner
G2L["1cb"] = Host.New("UICorner", G2L["1ca"]);
G2L["1cb"]["CornerRadius"] = UDim.new(0.12, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.select1.UIListLayout
G2L["1cc"] = Host.New("UIListLayout", G2L["1ca"]);
G2L["1cc"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
G2L["1cc"]["Padding"] = UDim.new(0.18, 0);
G2L["1cc"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
G2L["1cc"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.select1.blue
G2L["1cd"] = Host.New("TextButton", G2L["1ca"]);
G2L["1cd"]["TextWrapped"] = true;
G2L["1cd"]["BorderSizePixel"] = 0;
G2L["1cd"]["TextSize"] = 14;
G2L["1cd"]["TextScaled"] = true;
G2L["1cd"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1cd"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["1cd"]["Font"] = Enum.Font.Gotham;
G2L["1cd"]["BackgroundTransparency"] = 1;
G2L["1cd"]["Size"] = UDim2.new(0.9, 0, 0.15, 0);
G2L["1cd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1cd"]["Text"] = [[Blue]];
G2L["1cd"]["Name"] = [[blue]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.select1.green
G2L["1ce"] = Host.New("TextButton", G2L["1ca"]);
G2L["1ce"]["TextWrapped"] = true;
G2L["1ce"]["BorderSizePixel"] = 0;
G2L["1ce"]["TextSize"] = 14;
G2L["1ce"]["TextScaled"] = true;
G2L["1ce"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ce"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["1ce"]["Font"] = Enum.Font.Gotham;
G2L["1ce"]["BackgroundTransparency"] = 1;
G2L["1ce"]["Size"] = UDim2.new(0.9, 0, 0.15, 0);
G2L["1ce"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ce"]["Text"] = [[Green]];
G2L["1ce"]["Name"] = [[green]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.select1.pink
G2L["1cf"] = Host.New("TextButton", G2L["1ca"]);
G2L["1cf"]["TextWrapped"] = true;
G2L["1cf"]["BorderSizePixel"] = 0;
G2L["1cf"]["TextSize"] = 14;
G2L["1cf"]["TextScaled"] = true;
G2L["1cf"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1cf"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["1cf"]["Font"] = Enum.Font.Gotham;
G2L["1cf"]["BackgroundTransparency"] = 1;
G2L["1cf"]["Size"] = UDim2.new(0.9, 0, 0.15, 0);
G2L["1cf"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1cf"]["Text"] = [[Pink]];
G2L["1cf"]["Name"] = [[pink]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu
G2L["1d0"] = Host.New("Frame", G2L["157"]);
G2L["1d0"]["BorderSizePixel"] = 0;
G2L["1d0"]["BackgroundColor3"] = Color3.fromRGB(21, 23, 27);
G2L["1d0"]["Size"] = UDim2.new(1, 0, 0.035, 0);
G2L["1d0"]["Position"] = UDim2.new(0, 0, 0.01329, 0);
G2L["1d0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d0"]["Name"] = [[Enable AutoExcu]];
G2L["1d0"]["LayoutOrder"] = 2;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.UICorner
G2L["1d1"] = Host.New("UICorner", G2L["1d0"]);
G2L["1d1"]["CornerRadius"] = UDim.new(0.25, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.TextLabel
G2L["1d2"] = Host.New("TextLabel", G2L["1d0"]);
G2L["1d2"]["TextWrapped"] = true;
G2L["1d2"]["BorderSizePixel"] = 0;
G2L["1d2"]["TextSize"] = 14;
G2L["1d2"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1d2"]["TextScaled"] = true;
G2L["1d2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d2"]["Font"] = Enum.Font.GothamBold;
G2L["1d2"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d2"]["BackgroundTransparency"] = 1;
G2L["1d2"]["Size"] = UDim2.new(0.19309, 0, 0.19409, 0);
G2L["1d2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d2"]["Text"] = [[Enable Auto Execute,]];
G2L["1d2"]["Position"] = UDim2.new(0.03, 0, 0.237, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.TextLabel
G2L["1d3"] = Host.New("TextLabel", G2L["1d0"]);
G2L["1d3"]["TextWrapped"] = true;
G2L["1d3"]["BorderSizePixel"] = 0;
G2L["1d3"]["TextSize"] = 14;
G2L["1d3"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1d3"]["TextScaled"] = true;
G2L["1d3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d3"]["Font"] = Enum.Font.GothamMedium;
G2L["1d3"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d3"]["BackgroundTransparency"] = 1;
G2L["1d3"]["RichText"] = true;
G2L["1d3"]["Size"] = UDim2.new(0.21697, 0, 0.16304, 0);
G2L["1d3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d3"]["Text"] = [[<font color="rgb(105, 143, 243)">Executes</font> scripts on start,]];
G2L["1d3"]["Position"] = UDim2.new(0.03, 0, 0.533, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton
G2L["1d4"] = Host.New("TextButton", G2L["1d0"]);
G2L["1d4"]["BorderSizePixel"] = 0;
G2L["1d4"]["TextSize"] = 14;
G2L["1d4"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d4"]["BackgroundColor3"] = Color3.fromRGB(86, 115, 194);
G2L["1d4"]["Font"] = Enum.Font.SourceSans;
G2L["1d4"]["ZIndex"] = 2;
G2L["1d4"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1d4"]["Size"] = UDim2.new(0.09064, 0, 0.44466, 0);
G2L["1d4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d4"]["Text"] = [[]];
G2L["1d4"]["Name"] = [[ToggleButton]];
G2L["1d4"]["Position"] = UDim2.new(0.91918, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.LocalScript
G2L["1d5"] = Host.New("LocalScript", G2L["1d4"]);



-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.UICorner
G2L["1d6"] = Host.New("UICorner", G2L["1d4"]);
G2L["1d6"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Enabled
G2L["1d7"] = Host.New("ImageLabel", G2L["1d4"]);
G2L["1d7"]["ZIndex"] = 2;
G2L["1d7"]["BorderSizePixel"] = 0;
G2L["1d7"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["1d7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1d7"]["Image"] = [[rbxassetid://105334603868078]];
G2L["1d7"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["1d7"]["Visible"] = false;
G2L["1d7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1d7"]["Name"] = [[Enabled]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Enabled.UIGradient
G2L["1d8"] = Host.New("UIGradient", G2L["1d7"]);
G2L["1d8"]["Rotation"] = -50;
G2L["1d8"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["1d8"]["Color"] = ColorSequence.new(Color3.fromRGB(106, 144, 244), Color3.fromRGB(106, 144, 244));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Enabled.UICorner
G2L["1d9"] = Host.New("UICorner", G2L["1d7"]);
G2L["1d9"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Disabled
G2L["1da"] = Host.New("ImageLabel", G2L["1d4"]);
G2L["1da"]["BorderSizePixel"] = 0;
G2L["1da"]["ScaleType"] = Enum.ScaleType.Crop;
G2L["1da"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1da"]["Image"] = [[rbxassetid://105334603868078]];
G2L["1da"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["1da"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1da"]["Name"] = [[Disabled]];


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Disabled.UIGradient
G2L["1db"] = Host.New("UIGradient", G2L["1da"]);
G2L["1db"]["Rotation"] = -50;
G2L["1db"]["Transparency"] = NumberSequence.new(0.35, 0.35);
G2L["1db"]["Color"] = ColorSequence.new(Color3.fromRGB(51, 54, 68), Color3.fromRGB(51, 54, 68));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Disabled.UICorner
G2L["1dc"] = Host.New("UICorner", G2L["1da"]);
G2L["1dc"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Frame
G2L["1dd"] = Host.New("Frame", G2L["1d4"]);
G2L["1dd"]["ZIndex"] = 3;
G2L["1dd"]["BorderSizePixel"] = 0;
G2L["1dd"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1dd"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1dd"]["Size"] = UDim2.new(0.38475, 0, 0.61267, 0);
G2L["1dd"]["Position"] = UDim2.new(0.3, 0, 0.5, 0);
G2L["1dd"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.Frame.UICorner
G2L["1de"] = Host.New("UICorner", G2L["1dd"]);
G2L["1de"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.CanvasGroup
G2L["1df"] = Host.New("CanvasGroup", G2L["10b"]);
G2L["1df"]["ZIndex"] = 2;
G2L["1df"]["BorderSizePixel"] = 0;
G2L["1df"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1df"]["Size"] = UDim2.new(0.93061, 0, 0.47263, 0);
G2L["1df"]["Position"] = UDim2.new(0.035, 0, 0.52101, 0);
G2L["1df"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.CanvasGroup.UIGradient
G2L["1e0"] = Host.New("UIGradient", G2L["1df"]);
G2L["1e0"]["Rotation"] = -90;
G2L["1e0"]["Transparency"] = NumberSequence.new(0, 1);
G2L["1e0"]["Color"] = ColorSequence.new(Color3.fromRGB(32, 34, 43), Color3.fromRGB(32, 34, 43));


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton
G2L["1e1"] = Host.New("TextButton", G2L["10b"]);
G2L["1e1"]["BorderSizePixel"] = 0;
G2L["1e1"]["TextSize"] = 14;
G2L["1e1"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e1"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e1"]["Font"] = Enum.Font.SourceSans;
G2L["1e1"]["ZIndex"] = 5;
G2L["1e1"]["BackgroundTransparency"] = 0.6;
G2L["1e1"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["1e1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e1"]["Text"] = [[]];
G2L["1e1"]["Visible"] = false;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup
G2L["1e2"] = Host.New("CanvasGroup", G2L["1e1"]);
G2L["1e2"]["BorderSizePixel"] = 0;
G2L["1e2"]["BackgroundColor3"] = Color3.fromRGB(22, 24, 27);
G2L["1e2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1e2"]["Size"] = UDim2.new(0.5, 0, 0.7, 0);
G2L["1e2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1e2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e2"]["BackgroundTransparency"] = 0.05;


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.UICorner
G2L["1e3"] = Host.New("UICorner", G2L["1e2"]);
G2L["1e3"]["CornerRadius"] = UDim.new(0.05, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.TextLabel
G2L["1e4"] = Host.New("TextLabel", G2L["1e2"]);
G2L["1e4"]["TextWrapped"] = true;
G2L["1e4"]["BorderSizePixel"] = 0;
G2L["1e4"]["TextSize"] = 14;
G2L["1e4"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1e4"]["TextScaled"] = true;
G2L["1e4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e4"]["Font"] = Enum.Font.GothamBold;
G2L["1e4"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e4"]["BackgroundTransparency"] = 1;
G2L["1e4"]["Size"] = UDim2.new(0.6, 0, 0.05, 0);
G2L["1e4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e4"]["Text"] = [[Colorize UI]];
G2L["1e4"]["Position"] = UDim2.new(0.06352, 0, 0.06498, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Blue
G2L["1e5"] = Host.New("TextButton", G2L["1e2"]);
G2L["1e5"]["TextWrapped"] = true;
G2L["1e5"]["BorderSizePixel"] = 0;
G2L["1e5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1e5"]["TextSize"] = 14;
G2L["1e5"]["TextScaled"] = true;
G2L["1e5"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e5"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["1e5"]["Font"] = Enum.Font.SourceSans;
G2L["1e5"]["Size"] = UDim2.new(0.88316, 0, 0.1, 0);
G2L["1e5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e5"]["Text"] = [[]];
G2L["1e5"]["Name"] = [[Blue]];
G2L["1e5"]["Position"] = UDim2.new(0.06406, 0, 0.23977, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Blue.UICorner
G2L["1e6"] = Host.New("UICorner", G2L["1e5"]);
G2L["1e6"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Blue.TextLabel
G2L["1e7"] = Host.New("TextLabel", G2L["1e5"]);
G2L["1e7"]["TextWrapped"] = true;
G2L["1e7"]["BorderSizePixel"] = 0;
G2L["1e7"]["TextSize"] = 14;
G2L["1e7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1e7"]["TextScaled"] = true;
G2L["1e7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e7"]["Font"] = Enum.Font.GothamSemibold;
G2L["1e7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e7"]["BackgroundTransparency"] = 1;
G2L["1e7"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["1e7"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1e7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e7"]["Text"] = [[Blue]];
G2L["1e7"]["Position"] = UDim2.new(0.05, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Green
G2L["1e8"] = Host.New("TextButton", G2L["1e2"]);
G2L["1e8"]["TextWrapped"] = true;
G2L["1e8"]["BorderSizePixel"] = 0;
G2L["1e8"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1e8"]["TextSize"] = 14;
G2L["1e8"]["TextScaled"] = true;
G2L["1e8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e8"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["1e8"]["Font"] = Enum.Font.SourceSans;
G2L["1e8"]["Size"] = UDim2.new(0.88316, 0, 0.1, 0);
G2L["1e8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1e8"]["Text"] = [[]];
G2L["1e8"]["Name"] = [[Green]];
G2L["1e8"]["Position"] = UDim2.new(0.064, 0, 0.393, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Green.UICorner
G2L["1e9"] = Host.New("UICorner", G2L["1e8"]);
G2L["1e9"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Green.TextLabel
G2L["1ea"] = Host.New("TextLabel", G2L["1e8"]);
G2L["1ea"]["TextWrapped"] = true;
G2L["1ea"]["BorderSizePixel"] = 0;
G2L["1ea"]["TextSize"] = 14;
G2L["1ea"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1ea"]["TextScaled"] = true;
G2L["1ea"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ea"]["Font"] = Enum.Font.GothamSemibold;
G2L["1ea"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ea"]["BackgroundTransparency"] = 1;
G2L["1ea"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["1ea"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1ea"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ea"]["Text"] = [[Green]];
G2L["1ea"]["Position"] = UDim2.new(0.05, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Red
G2L["1eb"] = Host.New("TextButton", G2L["1e2"]);
G2L["1eb"]["TextWrapped"] = true;
G2L["1eb"]["BorderSizePixel"] = 0;
G2L["1eb"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1eb"]["TextSize"] = 14;
G2L["1eb"]["TextScaled"] = true;
G2L["1eb"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1eb"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["1eb"]["Font"] = Enum.Font.SourceSans;
G2L["1eb"]["Size"] = UDim2.new(0.88316, 0, 0.1, 0);
G2L["1eb"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1eb"]["Text"] = [[]];
G2L["1eb"]["Name"] = [[Red]];
G2L["1eb"]["Position"] = UDim2.new(0.06406, 0, 0.55766, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Red.UICorner
G2L["1ec"] = Host.New("UICorner", G2L["1eb"]);
G2L["1ec"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Red.TextLabel
G2L["1ed"] = Host.New("TextLabel", G2L["1eb"]);
G2L["1ed"]["TextWrapped"] = true;
G2L["1ed"]["BorderSizePixel"] = 0;
G2L["1ed"]["TextSize"] = 14;
G2L["1ed"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1ed"]["TextScaled"] = true;
G2L["1ed"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ed"]["Font"] = Enum.Font.GothamSemibold;
G2L["1ed"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ed"]["BackgroundTransparency"] = 1;
G2L["1ed"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["1ed"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1ed"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ed"]["Text"] = [[Red]];
G2L["1ed"]["Position"] = UDim2.new(0.05, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Pink
G2L["1ee"] = Host.New("TextButton", G2L["1e2"]);
G2L["1ee"]["TextWrapped"] = true;
G2L["1ee"]["BorderSizePixel"] = 0;
G2L["1ee"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1ee"]["TextSize"] = 14;
G2L["1ee"]["TextScaled"] = true;
G2L["1ee"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1ee"]["BackgroundColor3"] = Color3.fromRGB(51, 54, 68);
G2L["1ee"]["Font"] = Enum.Font.SourceSans;
G2L["1ee"]["Size"] = UDim2.new(0.88316, 0, 0.1, 0);
G2L["1ee"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1ee"]["Text"] = [[]];
G2L["1ee"]["Name"] = [[Pink]];
G2L["1ee"]["Position"] = UDim2.new(0.064, 0, 0.709, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Pink.UICorner
G2L["1ef"] = Host.New("UICorner", G2L["1ee"]);
G2L["1ef"]["CornerRadius"] = UDim.new(0.3, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.Pink.TextLabel
G2L["1f0"] = Host.New("TextLabel", G2L["1ee"]);
G2L["1f0"]["TextWrapped"] = true;
G2L["1f0"]["BorderSizePixel"] = 0;
G2L["1f0"]["TextSize"] = 14;
G2L["1f0"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["1f0"]["TextScaled"] = true;
G2L["1f0"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1f0"]["Font"] = Enum.Font.GothamSemibold;
G2L["1f0"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1f0"]["BackgroundTransparency"] = 1;
G2L["1f0"]["AnchorPoint"] = Vector2.new(0, 0.5);
G2L["1f0"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
G2L["1f0"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1f0"]["Text"] = [[Pink]];
G2L["1f0"]["Position"] = UDim2.new(0.05, 0, 0.5, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.TextButton.CanvasGroup.ImageButton
G2L["1f1"] = Host.New("ImageButton", G2L["1e2"]);
G2L["1f1"]["BorderSizePixel"] = 0;
G2L["1f1"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["1f1"]["ImageTransparency"] = 0.2;
G2L["1f1"]["BackgroundTransparency"] = 1;
G2L["1f1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1f1"]["AnchorPoint"] = Vector2.new(1, 0);
G2L["1f1"]["Image"] = [[rbxassetid://78391259860999]];
G2L["1f1"]["Size"] = UDim2.new(0.05, 0, 0.1, 0);
G2L["1f1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1f1"]["Position"] = UDim2.new(0.94781, 0, 0.03772, 0);


-- StarterGui.! | Hex - Minimal.OpenUI.ImageLabel
G2L["1f2"] = Host.New("ImageLabel", G2L["7"]);
G2L["1f2"]["ZIndex"] = 2;
G2L["1f2"]["BorderSizePixel"] = 0;
G2L["1f2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1f2"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1f2"]["Image"] = [[rbxassetid://76793970636872]];
G2L["1f2"]["Size"] = UDim2.new(0.64243, 0, 0.64243, 0);
G2L["1f2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1f2"]["BackgroundTransparency"] = 1;
G2L["1f2"]["Rotation"] = 45;
G2L["1f2"]["Position"] = UDim2.new(0.48, 0, 0.54, 0);


-- StarterGui.! | Hex - Minimal.LocalScript
local function C_2()
local script = G2L["2"];
	local button = script.Parent:WaitForChild("OpenUI")
	local close = button["! | Hex - Main"]:WaitForChild("SideBar"):WaitForChild("CloseButton")
	local glow=button.Parent:WaitForChild("pulse_glow")
	local btnposition=button.Parent.btnposition
	local gui = button["! | Hex - Main"]
	local uistroke = button:FindFirstChild("UIStrokeOuter")
	-- print(close.Parent.Parent.Name)
	local ts = game:GetService("TweenService")
	local expo=TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local expo2=TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local fade = TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local move = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
	local resize = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	
	local closedSize = UDim2.new(0, 46, 0, 45)
	local openedSize = UDim2.new(1, 0, 1, 0)
	
	local opened = false
	local savedPos = button.Position
	local origTrans = gui.BackgroundTransparency
	
	button.Size = closedSize
	button.Draggable = true
	gui.Visible = false
	gui.BackgroundTransparency = 1
	
	do
		button.MouseButton1Down:Connect(function()
			if opened==false then
				ts:Create(button,expo,{Size=UDim2.new(0, 37,0, 37)}):Play()
			end
		end)
		button.MouseLeave:Connect(function()
			if opened==false then
				ts:Create(button,expo,{Size=closedSize}):Play()
			end
		end)
	end
	
	local function open()
		glow.Visible=true
		btnposition.Position=button.Position
		glow.Position=button.Position
		glow.Size=UDim2.new(0)
		gui.GroupTransparency = 1
		--if opened then return end
		opened = true
	
		task.spawn(function()
			task.wait(0.16)
			ts:Create(button, expo, {ImageTransparency = 1}):Play()
		end)
	
		ts:Create(button.ImageLabel,expo,{ImageTransparency=1}):Play()
		ts:Create(button.UICorner,expo,{CornerRadius=UDim.new(0, 0)}):Play()
		button.Draggable = false
		gui.Visible = true
		gui.BackgroundTransparency = 1
		ts:Create(glow,expo2,{Size=UDim2.new(3,0,3)}):Play()
		ts:Create(gui, fade, {BackgroundTransparency = origTrans}):Play()
		ts:Create(button, move, {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0)}):Play()
		task.wait(0.1)
		ts:Create(button, resize, {Size = openedSize}):Play()
		task.wait(0.2)
		ts:Create(gui,resize,{GroupTransparency = 0}):Play()
	end
	button.MouseButton1Click:Connect(function()
		--if not opened then open() end
		if button.ImageLabel.ImageTransparency==0 then
			open()
		end
	end)
	
	
end;
task.spawn(C_2);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Menu.MiniPopup.FavoriteButton.LocalScript
local function C_2c()
local script = G2L["2c"];
	local btn = script.Parent
	local ts = game:GetService("TweenService")
	
	local offColor = Color3.fromRGB(55, 58, 73)
	local onColor = Color3.fromRGB(104, 142, 241)
	
	local tInfo = TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	
	local hoverTween = ts:Create(btn, tInfo, { BackgroundColor3 = onColor })
	local leaveTween = ts:Create(btn, tInfo, { BackgroundColor3 = offColor })
	
	btn.MouseEnter:Connect(function()
		hoverTween:Play()
	end)
	
	btn.MouseLeave:Connect(function()
		leaveTween:Play()
	end)
	
end;
task.spawn(C_2c);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.LocalScript
local function C_38()
local script = G2L["38"];
	local homeBtn = script.Parent.HomeButton.Frame
	local editorBtn = script.Parent.EditorButton.Frame
	local settingsBtn = script.Parent.SettingsButton.Frame
	local ind = script.Parent.Indicator
	local ts = game:GetService("TweenService")
	
	local homePage = script.Parent.Parent.Window:FindFirstChild("Home")
	local editorPage = script.Parent.Parent.Window:FindFirstChild("Editor")
	local settingsPage = script.Parent.Parent.Window:FindFirstChild("Settings")
	
	local dullBg = Color3.fromRGB(33, 32, 38)
	local dullIcon = Color3.fromRGB(132, 138, 174)
	local brightBg = Color3.fromRGB(104, 142, 241)
	local brightIcon = Color3.fromRGB(255, 255, 255)
	
	local icon = "ImageLabel"
	
	local fill = ind:FindFirstChild("Fill")
	if fill then
		fill.AnchorPoint = Vector2.new(0.5, 0.5)
		fill.Position = UDim2.new(0.5, 0, 0.5, 0)
		fill.Size = UDim2.new(1, 0, 1, 0)
	end
	
	local btnTween = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local iconTween = TweenInfo.new(0.24, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local posTweenFast = TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local posTweenSettle = TweenInfo.new(0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
	
	local function squash()
		if not fill then return end
		ts:Create(fill, TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 0.48, 0)
		}):Play()
	end
	
	local function unsquash()
		if not fill then return end
		local up = ts:Create(fill, TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 1.06, 0)
		})
		local settle = ts:Create(fill, TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 1, 0)
		})
		up:Play()
		up.Completed:Once(function()
			settle:Play()
		end)
	end
	
	local function resetButtons(active)
		for _, btn in ipairs({ homeBtn, editorBtn, settingsBtn }) do
			ts:Create(btn, btnTween, {
				BackgroundColor3 = btn == active and brightBg or dullBg
			}):Play()
	
			ts:Create(btn[icon], iconTween, {
				ImageColor3 = btn == active and brightIcon or dullIcon
			}):Play()
		end
	end
	
	local lastY = ind.Position.Y.Scale
	
	local function moveIndicator(targetPos)
		squash()
		task.delay(0.2, unsquash)
	
		task.wait()
	
		if math.abs(targetPos.Y.Scale - lastY) >= 0.001 then
			local dir = targetPos.Y.Scale > lastY and 1 or -1
			local overshoot = targetPos + UDim2.new(0, 0, 0.02 * dir, 0)
	
			local t1 = ts:Create(ind, posTweenFast, { Position = overshoot })
			local t2 = ts:Create(ind, posTweenSettle, { Position = targetPos })
	
			t1:Play()
			t1.Completed:Once(function()
				t2:Play()
			end)
		end
	
		lastY = targetPos.Y.Scale
	end
	
	homeBtn.BackgroundColor3 = brightBg
	homeBtn[icon].ImageColor3 = brightIcon
	editorBtn.BackgroundColor3 = dullBg
	editorBtn[icon].ImageColor3 = dullIcon
	settingsBtn.BackgroundColor3 = dullBg
	settingsBtn[icon].ImageColor3 = dullIcon
	
	homeBtn.MouseButton1Click:Connect(function()
		moveIndicator(UDim2.new(-0.065, 0, 0.285, 0))
		resetButtons(homeBtn)
	end)
	
	editorBtn.MouseButton1Click:Connect(function()
		moveIndicator(UDim2.new(-0.065, 0, 0.43, 0))
		resetButtons(editorBtn)
	end)
	
	settingsBtn.MouseButton1Click:Connect(function()
		moveIndicator(UDim2.new(-0.065, 0, 0.575, 0))
		resetButtons(settingsBtn)
	end)
	
end;
task.spawn(C_38);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.PageScript
local function C_39()
local script = G2L["39"];
	local ts = game:GetService("TweenService")
	
	local homeBtn = script.Parent.HomeButton:FindFirstChild("Frame")
	local editorBtn = script.Parent.EditorButton:FindFirstChild("Frame")
	local settingsBtn = script.Parent.SettingsButton:FindFirstChild("Frame")
	
	local window = script.Parent.Parent.Window
	local homePage = window:FindFirstChild("Home")
	local editorPage = window:FindFirstChild("Editor")
	local settingsPage = window:FindFirstChild("Settings")
	
	local pages = { homePage, editorPage, settingsPage }
	
	local originalState = {}
	local activeTweens = {}
	local switching = false
	
	local function cacheGui(gui)
		for _, obj in ipairs(gui:GetDescendants()) do
			if obj:IsA("GuiObject") then
				originalState[obj] = {
					Position = obj.Position,
					BackgroundTransparency = obj.BackgroundTransparency,
					TextTransparency = (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.TextTransparency or nil,
					ImageTransparency = (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and obj.ImageTransparency or nil
				}
			end
		end
	
		if gui:IsA("GuiObject") and not originalState[gui] then
			originalState[gui] = {
				Position = gui.Position,
				BackgroundTransparency = gui.BackgroundTransparency,
				TextTransparency = (gui:IsA("TextLabel") or gui:IsA("TextButton")) and gui.TextTransparency or nil,
				ImageTransparency = (gui:IsA("ImageLabel") or gui:IsA("ImageButton")) and gui.ImageTransparency or nil
			}
		end
	end
	
	for _, page in ipairs(pages) do
		cacheGui(page)
	end
	
	local function resetGui(obj)
		local state = originalState[obj]
		if not state then return end
	
		obj.Position = state.Position
		obj.BackgroundTransparency = state.BackgroundTransparency
	
		if state.TextTransparency ~= nil then
			obj.TextTransparency = state.TextTransparency
		end
		if state.ImageTransparency ~= nil then
			obj.ImageTransparency = state.ImageTransparency
		end
	end
	
	local function cancelTweens(obj)
		if activeTweens[obj] then
			for _, tween in ipairs(activeTweens[obj]) do
				tween:Cancel()
			end
		end
		activeTweens[obj] = {}
	end
	
	local tweenInfo = TweenInfo.new(
		0.45,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	)
	
	local function animateObject(obj, delayTime, page)
		cancelTweens(obj)
		resetGui(obj)
	
		obj.Position = obj.Position + UDim2.fromScale(0, 0.096)
	
		if page ~= editorPage then
			obj.BackgroundTransparency = 1
	
			if obj:IsA("TextLabel") or obj:IsA("TextButton") then
				obj.TextTransparency = 1
			end
			if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
				obj.ImageTransparency = 1
			end
		end
	
		task.delay(delayTime, function()
			local state = originalState[obj]
			if not state then return end
	
			local goal = {
				Position = state.Position
			}
	
			if page ~= editorPage then
				goal.BackgroundTransparency = state.BackgroundTransparency
	
				if state.TextTransparency ~= nil then
					goal.TextTransparency = state.TextTransparency
				end
				if state.ImageTransparency ~= nil then
					goal.ImageTransparency = state.ImageTransparency
				end
			end
	
			local tween = ts:Create(obj, tweenInfo, goal)
			activeTweens[obj] = { tween }
			tween:Play()
		end)
	end
	
	local function switchPage(targetPage)
		if switching then return end
		switching = true
	
		for _, page in ipairs(pages) do
			if page == targetPage then
				page.Visible = true
	
				local animTargets = {}
	
				if page == settingsPage then
					local scroll = page:FindFirstChildWhichIsA("ScrollingFrame")
	
					if scroll then
						for _, child in ipairs(scroll:GetChildren()) do
							if child:IsA("GuiObject") then
								table.insert(animTargets, child)
							end
						end
	
						table.sort(animTargets, function(a, b)
							return a.LayoutOrder < b.LayoutOrder
						end)
					end
	
					for _, child in ipairs(page:GetChildren()) do
						if child:IsA("GuiObject") and child ~= scroll then
							table.insert(animTargets, child)
						end
					end
				else
					table.insert(animTargets, page)
	
					for _, obj in ipairs(page:GetDescendants()) do
						if obj:IsA("GuiObject") then
							table.insert(animTargets, obj)
						end
					end
				end
	
				for i, obj in ipairs(animTargets) do
					animateObject(obj, (i - 1) * 0.03, page)
				end
			else
				page.Visible = false
			end
		end
	
		task.delay(0.5, function()
			switching = false
		end)
	end
	
	homeBtn.MouseButton1Click:Connect(function()
		switchPage(homePage)
	end)
	
	editorBtn.MouseButton1Click:Connect(function()
		switchPage(editorPage)
	end)
	
	settingsBtn.MouseButton1Click:Connect(function()
		switchPage(settingsPage)
	end)
end;
task.spawn(C_39);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.HomeButton.Frame.Tween
local function C_44()
local script = G2L["44"];
	local btn = script.Parent
	local TS = game:GetService("TweenService")
	
	local origSize = btn.Size
	local hoverScl = 1.1
	local clickScl = 0.9
	local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	
	local function makeTween(scl)
		local newSize = UDim2.new(
			origSize.X.Scale * scl,
			origSize.X.Offset * scl,
			origSize.Y.Scale * scl,
			origSize.Y.Offset * scl
		)
		return TS:Create(btn, tInfo, {Size = newSize})
	end
	
	btn.MouseEnter:Connect(function()
		makeTween(hoverScl):Play()
	end)
	
	btn.MouseLeave:Connect(function()
		makeTween(1):Play()
	end)
	
	btn.MouseButton1Click:Connect(function()
		local shrink = makeTween(clickScl)
		local reset = makeTween(1)
		shrink:Play()
		shrink.Completed:Connect(function()
			reset:Play()
		end)
	end)
end;
task.spawn(C_44);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.CloseButton.Frame.Tween
local function C_49()
local script = G2L["49"];
	local btn = script.Parent
	local TS = game:GetService("TweenService")
	
	local origSize = btn.Size
	local hoverScl = 1.1
	local clickScl = 0.9
	local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	
	local function makeTween(scl)
		local newSize = UDim2.new(
			origSize.X.Scale * scl,
			origSize.X.Offset * scl,
			origSize.Y.Scale * scl,
			origSize.Y.Offset * scl
		)
		return TS:Create(btn, tInfo, {Size = newSize})
	end
	
	btn.MouseEnter:Connect(function()
		makeTween(hoverScl):Play()
	end)
	
	btn.MouseLeave:Connect(function()
		makeTween(1):Play()
	end)
	
	
	local opbtn=script.Parent.Parent.Parent.Parent.Parent
	local gui=script.Parent.Parent.Parent.Parent
	local btnposition=opbtn.Parent.btnposition
	local glow=opbtn.Parent.pulse_glow
	local expo=TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local fade = TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	local move = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
	local resize = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	
	btn.MouseButton1Click:Connect(function()
		local shrink = makeTween(clickScl)
		local reset = makeTween(1)
		shrink:Play()
		shrink.Completed:Connect(function()
			reset:Play()
		end)
		glow.Size=UDim2.new(0)
		glow.Visible=false
		TS:Create(gui, fade, {GroupTransparency = 1}):Play()
		TS:Create(opbtn, expo, {Size=UDim2.new(0, 46,0, 45)}):Play()
		gui.Visible = false
		TS:Create(opbtn, expo, {AnchorPoint = Vector2.new(0, 0), Position = btnposition.Position}):Play()
		TS:Create(opbtn.ImageLabel,expo,{ImageTransparency=0}):Play()
		TS:Create(opbtn, expo, {ImageTransparency = 0}):Play()TS:Create(opbtn,expo,{ImageTransparency=0}):Play()
		TS:Create(opbtn.UICorner,expo,{CornerRadius=UDim.new(0.3)}):Play()
		opbtn.Draggable=true
	end)
end;
task.spawn(C_49);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.EditorButton.Frame.Tween
local function C_4e()
local script = G2L["4e"];
	local btn = script.Parent
	local TS = game:GetService("TweenService")
	
	local origSize = btn.Size
	local hoverScl = 1.1
	local clickScl = 0.9
	local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	
	local function makeTween(scl)
		local newSize = UDim2.new(
			origSize.X.Scale * scl,
			origSize.X.Offset * scl,
			origSize.Y.Scale * scl,
			origSize.Y.Offset * scl
		)
		return TS:Create(btn, tInfo, {Size = newSize})
	end
	
	btn.MouseEnter:Connect(function()
		makeTween(hoverScl):Play()
	end)
	
	btn.MouseLeave:Connect(function()
		makeTween(1):Play()
	end)
	
	btn.MouseButton1Click:Connect(function()
		local shrink = makeTween(clickScl)
		local reset = makeTween(1)
		shrink:Play()
		shrink.Completed:Connect(function()
			reset:Play()
		end)
	end)
end;
task.spawn(C_4e);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.SideBar.SettingsButton.Frame.Tween
local function C_53()
local script = G2L["53"];
	local btn = script.Parent
	local TS = game:GetService("TweenService")
	
	local origSize = btn.Size
	local hoverScl = 1.1
	local clickScl = 0.9
	local tInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	
	local function makeTween(scl)
		local newSize = UDim2.new(
			origSize.X.Scale * scl,
			origSize.X.Offset * scl,
			origSize.Y.Scale * scl,
			origSize.Y.Offset * scl
		)
		return TS:Create(btn, tInfo, {Size = newSize})
	end
	
	btn.MouseEnter:Connect(function()
		makeTween(hoverScl):Play()
	end)
	
	btn.MouseLeave:Connect(function()
		makeTween(1):Play()
	end)
	
	btn.MouseButton1Click:Connect(function()
		local shrink = makeTween(clickScl)
		local reset = makeTween(1)
		shrink:Play()
		shrink.Completed:Connect(function()
			reset:Play()
		end)
	end)
end;
task.spawn(C_53);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.RunButton.LocalScript
local function C_67()
local script = G2L["67"];
	local button = script.Parent
	local label = button.Parent.CodeContainer.TextLabel
	
	button.MouseButton1Click:Connect(function()
		runCode(label.Text)
	end)
	
end;
task.spawn(C_67);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.QuickWidgets.PasteButton.LocalScript
local function C_6b()
local script = G2L["6b"];
	local button = script.Parent
	local label = button.Parent.CodeContainer.TextLabel
	
	button.MouseButton1Click:Connect(function()
		local clip = getclipboard()
		if clip and clip ~= "" then
			label.Text = clip
		end
	end)
	
end;
task.spawn(C_6b);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.JoinButton.LocalScript
local function C_7c()
local script = G2L["7c"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		setclipboard("https://discord.gg/fluxus")
	end)
	
	
end;
task.spawn(C_7c);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Home.InviteWidget.NextButton.LocalScript
local function C_80()
local script = G2L["80"];
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		setclipboard("https://discord.gg/fluxus")
	end)
	
	
end;
task.spawn(C_80);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.EditorWidget.ClearButton.LocalScript
local function C_a1()
local script = G2L["a1"];
	
end;
task.spawn(C_a1);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.LocalScript
local function C_a8()
local script = G2L["a8"];
	
	local Widget = script.Parent
	local Editor = Widget.Parent.EditorWidget.CodeContainer.Editor
	local RunButton = Widget.Parent.EditorWidget.RunButton
	local PasteButton = Widget.Parent.EditorWidget.PasteButton
	local ClearButton = Widget.Parent.EditorWidget.ClearButton
	local TabsFrame = Widget.ScrollingTabs
	local TabTemplate = TabsFrame.Tab1
	local AddButton = TabsFrame.AddButton
	
	local ActiveTabName = nil
	local Tabs = {}
	local TabOrder = {}
	
	local function SaveActiveTab()
		if not ActiveTabName then return end
		writefile("scripts/"..ActiveTabName..".txt", Editor.Text)
	end
	
	local function SetActiveIndicator(tabName)
		for n,t in pairs(Tabs) do
			if t and t:FindFirstChild("Indicator") then
				t.Indicator.Visible = (n == tabName)
			end
		end
	end
	
	local function LoadTab(tabName)
		if ActiveTabName then SaveActiveTab() end
	
		ActiveTabName = tabName
		SetActiveIndicator(tabName)
	
		local path = "scripts/"..tabName..".txt"
	
		if isfile(path) then
			Editor.Text = readfile(path)
		else
			Editor.Text = ""
			writefile(path,"")
		end
	end
	
	local function FixVisuals(tab)
		tab.Rotation = 0
	
		if tab:FindFirstChild("TextLabel") then
			tab.TextLabel.Rotation = 0
			tab.TextLabel.TextXAlignment = Enum.TextXAlignment.Center
			tab.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
		end
	end
	
	local function CreateTab(tabName)
		if Tabs[tabName] then return end
	
		local tab = TabTemplate:Clone()
		tab.Name = tabName
		tab.Visible = true
	
		FixVisuals(tab)
	
		tab.TextLabel.Text = tabName
	
		if tab:FindFirstChild("Indicator") then
			tab.Indicator.Visible = false
		end
	
		AddButton.Parent = nil
		tab.Parent = TabsFrame
		AddButton.Parent = TabsFrame
	
		tab.MouseButton1Click:Connect(function()
			LoadTab(tabName)
		end)
	
		tab.DeleteButton.MouseButton1Click:Connect(function()
			local index
	
			for i,name in ipairs(TabOrder) do
				if name == tabName then index = i break end
			end
	
			if index then table.remove(TabOrder,index) end
	
			Tabs[tabName] = nil
			tab:Destroy()
	
			local path = "scripts/"..tabName..".txt"
			if isfile(path) then delfile(path) end
	
			if #TabOrder > 0 then
				LoadTab(TabOrder[math.max((index or 1)-1,1)])
			else
				ActiveTabName = nil
				Editor.Text = ""
			end
		end)
	
		Tabs[tabName] = tab
		TabOrder[#TabOrder+1] = tabName
	
	
		if #TabOrder == 1 then
			task.defer(function()
				LoadTab(tabName)
			end)
		end
	end
	
	local foundAny = false
	
	for _,path in ipairs(listfiles("scripts")) do
		local name = path:match("([^/]+)%.txt$")
		if name then
			CreateTab(name)
			foundAny = true
		end
	end
	
	if not foundAny then
		writefile("scripts/Tab 1.txt","")
		CreateTab("Tab 1")
	end
	
	task.defer(function()
		if #TabOrder > 0 then LoadTab(TabOrder[1]) end
	end)
	
	AddButton.MouseButton1Click:Connect(function()
		SaveActiveTab()
	
		local newName = "Tab "..tostring(#TabOrder+1)
	
		writefile("scripts/"..newName..".txt","")
		CreateTab(newName)
		LoadTab(newName) -- this now properly updates indicator
	end)
	
	Editor.FocusLost:Connect(function()
		SaveActiveTab()
	end)
	
	ClearButton.MouseButton1Click:Connect(function()
		Editor.Text = ""
		SaveActiveTab()
	end)
	
	PasteButton.MouseButton1Click:Connect(function()
		if getclipboard then
			Editor.Text = getclipboard()
			SaveActiveTab()
		end
	end)
	
	RunButton.MouseButton1Click:Connect(function()
		SaveActiveTab()
		runCode(Editor.Text)
	end)
	
end;
task.spawn(C_a8);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.SyntaxButton.LocalScript
local function C_ab()
local script = G2L["ab"];
	local syntaxBtn = script.Parent
	local codeBox = script.Parent.Parent.Parent.EditorWidget.CodeContainer.Editor
	local scrollingFrame = codeBox.Parent
	
	local HighlightLabel = scrollingFrame:FindFirstChild("HighlightLabel")
	if not HighlightLabel then
		HighlightLabel = Host.New("TextLabel")
		HighlightLabel.Name = "HighlightLabel"
		HighlightLabel.Parent = scrollingFrame
		HighlightLabel.BackgroundTransparency = 1
		HighlightLabel.RichText = true
		HighlightLabel.ZIndex = codeBox.ZIndex + 1
		HighlightLabel.Text = ""
		HighlightLabel.TextScaled = false
		HighlightLabel.TextWrapped = true
		HighlightLabel.LineHeight = 1
	end
	
	local syntaxOn = false
	
	local colors = {
		Keyword = "#569CD6",
		Global = "#9CDCFE",
		String = "#CE9178",
		Comment = "#6A9955",
		Number = "#B5CEA8",
		Symbol = "#D4D4D4",
		Method = "#DCDCAA",
	}
	
	local keywords = {"local","function","end","if","then","else","elseif","return","while","do","for","in","break","nil","true","false","repeat","until","and","or","not","self","export","type","continue","typeof"}
	
	local globals = {"game","workspace","script","Instance","new","Vector3","CFrame","Color3","Enum","print","warn","wait","require","UDim2","math","table","coroutine","os","debug","getgenv","getrenv","syn","bit32","utf8","DateTime","task","string","number","boolean","any","void","thread","Ray","Region3","Region3int16","TweenService","PathfindingService","Players","Lighting","ReplicatedStorage","Debris","RunService","HttpService","UserInputService","TweenInfo","Random","Vector2","BrickColor"}
	
	local function UpdateEditor()
		local text = codeBox.Text or ""
	
		HighlightLabel.Size = codeBox.Size
		HighlightLabel.Position = codeBox.Position
		HighlightLabel.Font = codeBox.Font
		HighlightLabel.TextSize = codeBox.TextSize
		HighlightLabel.TextXAlignment = codeBox.TextXAlignment
		HighlightLabel.TextYAlignment = codeBox.TextYAlignment
		HighlightLabel.TextColor3 = codeBox.TextColor3
	
		if not syntaxOn then
			HighlightLabel.Text = text
			return
		end
	
		local cleanText = text:gsub("&","&amp;"):gsub("<","&lt;"):gsub(">","&gt;")
	
		local replacements = {}
		local repIndex = 0
	
		local function addPlaceholder(color,content)
			repIndex += 1
			local key = "_P"..repIndex.."_"
			replacements[key] = "<font color='"..colors[color].."'>"..content.."</font>"
			return key
		end
	
		cleanText = cleanText:gsub("(%-%-[^\n]*)",function(c)return addPlaceholder("Comment",c)end)
		cleanText = cleanText:gsub("(\".-\")",function(s)return addPlaceholder("String",s)end)
		cleanText = cleanText:gsub("('.-')",function(s)return addPlaceholder("String",s)end)
		cleanText = cleanText:gsub("(%[%[.-%]%])",function(s)return addPlaceholder("String",s)end)
	
		cleanText = cleanText:gsub("([^%w_])(%d+%.?%d*)","%1<font color='"..colors.Number.."'>%2</font>")
	
		for _,kw in keywords do
			cleanText = cleanText:gsub("([^%w_])("..kw..")([^%w_])","%1<font color='"..colors.Keyword.."'>%2</font>%3")
		end
	
		for _,gb in globals do
			cleanText = cleanText:gsub("([^%w_])("..gb..")([^%w_])","%1<font color='"..colors.Global.."'>%2</font>%3")
		end
	
		cleanText = cleanText:gsub("(:)(%w+)","<font color='"..colors.Symbol.."'>%1</font><font color='"..colors.Method.."'>%2</font>")
	
		for k,v in pairs(replacements) do
			cleanText = cleanText:gsub(k,v)
		end
	
		HighlightLabel.Text = cleanText .. " "
	end
	
	syntaxBtn.MouseButton1Click:Connect(function()
		syntaxOn = not syntaxOn
		UpdateEditor()
	end)
	
	codeBox:GetPropertyChangedSignal("Text"):Connect(UpdateEditor)
	codeBox:GetPropertyChangedSignal("Font"):Connect(UpdateEditor)
	codeBox:GetPropertyChangedSignal("TextSize"):Connect(UpdateEditor)
	
	scrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(UpdateEditor)
	
	UpdateEditor()
end;
task.spawn(C_ab);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.CloudButton.LocalScript
local function C_af()
local script = G2L["af"];
	local TweenService = game:GetService("TweenService")
	
	local button = script.Parent
	local inWindow = button.Parent.Parent:FindFirstChild("ButtonFunction")
	if not inWindow then return end
	
	local searchWidget = inWindow:FindFirstChild("SearchWidget")
	if not searchWidget then return end
	
	local closeButton = searchWidget:FindFirstChild("CloseButton")
	
	local openPos = UDim2.new(0.42, 0, 0.575, 0)
	local closedPos = UDim2.new(0.42, 0, 1, 0)
	
	local bgIn = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local bgOut = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
	
	local openTween = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local closeTween = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
	
	local function openUI()
		inWindow.Visible = true
		inWindow.BackgroundTransparency = 1
		searchWidget.Position = closedPos
	
		TweenService:Create(
			inWindow,
			bgIn,
			{BackgroundTransparency = 0.5}
		):Play()
	
		TweenService:Create(
			searchWidget,
			openTween,
			{Position = openPos}
		):Play()
	end
	
	local function closeUI()
		TweenService:Create(
			inWindow,
			bgOut,
			{BackgroundTransparency = 1}
		):Play()
	
		local t = TweenService:Create(
			searchWidget,
			closeTween,
			{Position = closedPos}
		)
		t:Play()
		t.Completed:Wait()
	
		inWindow.Visible = false
	end
	
	button.MouseButton1Click:Connect(openUI)
	
	if closeButton then
		closeButton.MouseButton1Click:Connect(closeUI)
	end
	
	local dragBar = searchWidget:FindFirstChild("DragBar")
	if dragBar then
		dragBar.MouseButton1Click:Connect(closeUI)
	end
end;
task.spawn(C_af);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.Switch
local function C_b3()
local script = G2L["b3"];
	
end;
task.spawn(C_b3);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.TabWidget.ScrollingTabs.AddButton.Add Tab
local function C_bc()
local script = G2L["bc"];
	
end;
task.spawn(C_bc);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Editor.ButtonFunction.SearchWidget.FilterButton.LocalScript
local function C_db()
local script = G2L["db"];
	local httpservice = game:GetService("HttpService")
	
	local filterbutton = script.Parent
	local searchtextbox = filterbutton.Parent.searchtext.ScrollingFrame.TextBox
	local resultsframe = filterbutton.Parent.ScrollingFrame
	local template = resultsframe:FindFirstChild("MTemplate")
	
	if not template then
		warn("mtemplate not found")
		return
	end
	
	template.Visible = false
	
	-- executor-safe request
	local request = (syn and syn.request) or http_request or request
	
	-- state
	local activequery = 0
	local runconnections = {}
	
	local function shortennumber(n)
		if n >= 1e6 then
			return string.format("%.1fm", n / 1e6)
		elseif n >= 1e3 then
			return string.format("%.1fk", n / 1e3)
		end
		return tostring(n)
	end
	
	local function clearresults()
		for _, v in ipairs(resultsframe:GetChildren()) do
			if v:IsA("TextButton") and v.Name == "Result" then
				if runconnections[v] then
					runconnections[v]:Disconnect()
					runconnections[v] = nil
				end
				v:Destroy()
			end
		end
	end
	
	local function startapi()
		local query = searchtextbox.Text
		if query == "" then return end
	
		activequery += 1
		local qid = activequery
	
		clearresults()
	
		local url = "https://scriptblox.com/api/script/search?q=" .. httpservice:UrlEncode(query)
	
		local success, response = pcall(function()
			local res = request({
				Url = url,
				Method = "GET"
			})
			return httpservice:JSONDecode(res.Body)
		end)
	
		if not success or not response or not response.result or not response.result.scripts then
			warn("scriptblox api failed")
			return
		end
	
		for _, scriptdata in ipairs(response.result.scripts) do
			if qid ~= activequery then return end
			if scriptdata.isPatched then continue end
	
			local clone = template:Clone()
			clone.Name = "Result"
			clone.Visible = true
			clone.Parent = resultsframe
	
			local ui = clone:FindFirstChild("Template")
			if not ui then
				clone:Destroy()
				continue
			end
	
			local namelabel = ui:FindFirstChild("NameHolder") and ui.NameHolder:FindFirstChild("Name")
			if namelabel then
				namelabel.Text = scriptdata.title or "unknown"
			end
	
			local viewslabel =
				ui:FindFirstChild("viewssec")
				and ui.viewssec:FindFirstChild("TextHolder")
				and ui.viewssec.TextHolder:FindFirstChild("views")
	
			if viewslabel then
				viewslabel.Text = shortennumber(scriptdata.views or 0)
			end
	
			local imagelabel = clone:FindFirstChildWhichIsA("ImageLabel", true)
			if imagelabel then
				if scriptdata.isUniversal then
					imagelabel.Image = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=168556275&fmt=png&wd=420&ht=420"
				elseif scriptdata.game and scriptdata.game.gameId then
					imagelabel.Image =
						"https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid="
						.. tostring(scriptdata.game.gameId)
						.. "&fmt=png&wd=420&ht=420"
				else
					imagelabel.Image = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid=168556275&fmt=png&wd=420&ht=420"
				end
			end
	
			local runbtn = ui:FindFirstChild("RunButton")
			if runbtn and scriptdata.script then
				if runconnections[clone] then
					runconnections[clone]:Disconnect()
				end
	
				runconnections[clone] = runbtn.MouseButton1Click:Connect(function()
					task.spawn(function()
						local fn = loadstring(scriptdata.script)
						if fn then
							fn()
						end
					end)
				end)
			end
	
			task.wait(0.05)
		end
	end
	
	filterbutton.MouseButton1Click:Connect(startapi)
	
end;
task.spawn(C_db);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.SearchBar.ExtensionButton.LocalScript
local function C_154()
local script = G2L["154"];
	local TweenService = game:GetService("TweenService")
	
	local button = script.Parent
	local inWindow = button.Parent.Parent:FindFirstChild("InWindow")
	if not inWindow then return end
	
	local searchWidget = inWindow:FindFirstChild("SearchWidget")
	if not searchWidget then return end
	
	local closeButton = searchWidget:FindFirstChild("CloseButton")
	
	local openPos = UDim2.new(0.42, 0, 0.575, 0)
	local closedPos = UDim2.new(0.42, 0, 1, 0)
	
	local bgIn = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local bgOut = TweenInfo.new(0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
	
	local openTween = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local closeTween = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
	
	local function openUI()
		inWindow.Visible = true
		inWindow.BackgroundTransparency = 1
		searchWidget.Position = closedPos
	
		TweenService:Create(
			inWindow,
			bgIn,
			{BackgroundTransparency = 0.5}
		):Play()
	
		TweenService:Create(
			searchWidget,
			openTween,
			{Position = openPos}
		):Play()
	end
	
	local function closeUI()
		TweenService:Create(
			inWindow,
			bgOut,
			{BackgroundTransparency = 1}
		):Play()
	
		local t = TweenService:Create(
			searchWidget,
			closeTween,
			{Position = closedPos}
		)
		t:Play()
		t.Completed:Wait()
	
		inWindow.Visible = false
	end
	
	button.MouseButton1Click:Connect(openUI)
	
	if closeButton then
		closeButton.MouseButton1Click:Connect(closeUI)
	end
	
	local dragBar = searchWidget:FindFirstChild("DragBar")
	if dragBar then
		dragBar.MouseButton1Click:Connect(closeUI)
	end
	
end;
task.spawn(C_154);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.UnlockFPS.ToggleButton.LocalScript
local function C_15d()
local script = G2L["15d"];
	local toggle = script.Parent
	local circalthingy = toggle.Frame
	local enabledIndicator = toggle.Enabled
	
	local disabledPos = UDim2.new(0.3, 0, 0.5, 0)
	local enabledPos = UDim2.new(0.69, 0, 0.5, 0)
	
	local TS = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	local isEnabled = false
	circalthingy.Position = disabledPos
	enabledIndicator.Visible = false
	
	local function setFPS(enabled)
		if typeof(setfpscap) == "function" then
			if enabled then
				setfpscap(0)
			else
				setfpscap(60)
			end
		end
	end
	
	local function toggleState()
		isEnabled = not isEnabled
	
		local targetPos = isEnabled and enabledPos or disabledPos
		TS:Create(circalthingy, tweenInfo, { Position = targetPos }):Play()
	
		enabledIndicator.Visible = isEnabled
		setFPS(isEnabled)
	end
	
	toggle.MouseButton1Click:Connect(toggleState)
	
	
	
	
end;
task.spawn(C_15d);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.HiddenUITrigger.ToggleButton.LocalScript
local function C_16c()
local script = G2L["16c"];
	local toggle = script.Parent
	local circalthingy = toggle.Frame
	local disabled = toggle.Disabled
	local enabled = toggle.Enabled
	
end;
task.spawn(C_16c);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.SettingWidget.DropDownButton.LocalScript
local function C_1aa()
local script = G2L["1aa"];
	local button = script.Parent
	local textbox = script.Parent.TextHolder.TextLabel
	local select = script.Parent.select1
	local blue = select.blue
	local green = select.green
	local pink=select.pink
	
	local theme='blue'
	local ts = game:GetService("TweenService")
	local expo=TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
	
	select.GroupTransparency=0
	select.Visible=false
	
	button.MouseButton1Click:Connect(function()
		if select.Visible==false then
			select.Visible=true
			ts:Create(select,expo,{GroupTransparency=0}):Play()
			ts:Create(select,expo,{Size=UDim2.new(1,0,3)}):Play()
		end
	end)
	local function close()
		ts:Create(select,expo,{GroupTransparency=1}):Play()
		ts:Create(select,expo,{Size=UDim2.new(1,0,1)}):Play()
		wait(0.2)
		if select.GroupTransparency==1 then
			select.Visible=false
		end
	end
	blue.MouseButton1Click:Connect(function()
		theme='blue'
		textbox.Text='Blue'
		close()
	end)
	green.MouseButton1Click:Connect(function()
		theme='green'
		textbox.Text='Green'
		close()
	end)
	pink.MouseButton1Click:Connect(function()
		theme='pink'
		textbox.Text='Pink'
		close()
	end)
end;
task.spawn(C_1aa);
-- StarterGui.! | Hex - Minimal.OpenUI.! | Hex - Main.Window.Settings.ScrollingFrame.Enable AutoExcu.ToggleButton.LocalScript
local function C_1d5()
local script = G2L["1d5"];
	local toggle = script.Parent
	local circalthingy = toggle.Frame
	local enabledIndicator = toggle:FindFirstChild("Enabled")
	
	local disabledPos = UDim2.new(0.3, 0, 0.5, 0)
	local enabledPos = UDim2.new(0.69, 0, 0.5, 0)
	
	local TS = game:GetService("TweenService")
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	local saveFile = "autoexec_state.txt"
	local isEnabled = false
	
	if isfile(saveFile) then
		local data = readfile(saveFile)
		isEnabled = (data == "true")
	end
	
	local function runAutoExec()
		local files = listfiles("autoexec")
	
		for _, file in ipairs(files) do
				local code = readfile(file)
	
				local func, err = loadstring(code)
				if func then
					local success, runtimeErr = pcall(func)
					if not success then
						warn("AutoExec runtime error:", file, runtimeErr)
					end
				else
					warn("AutoExec compile error:", file, err)
			end
		end
	end
	
	local function updateUI()
		local targetPos = isEnabled and enabledPos or disabledPos
		TS:Create(circalthingy, tweenInfo, {Position = targetPos}):Play()
	
		if enabledIndicator then
			enabledIndicator.Visible = isEnabled
		end
	end
	
	local function toggleState()
		isEnabled = not isEnabled
		writefile(saveFile, tostring(isEnabled))
	
		updateUI()
	
		if isEnabled then
			runAutoExec()
		end
	end
	
	toggle.MouseButton1Click:Connect(toggleState)
	
	updateUI()
	
	if isEnabled then
		task.defer(runAutoExec)
	end
end;
task.spawn(C_1d5);

return G2L["1"];
