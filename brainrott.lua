-- TP Script GUI by DeepSeek (Optimized)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Оптимизированное создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TPGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

-- Заголовок с кнопкой закрытия
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "TP Controller v2.0"
Title.Font = Enum.Font.Gotham
Title.TextSize = 14
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 35, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 200)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "☰"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.Visible = false
ToggleButton.Parent = ScreenGui

-- Кнопки телепортации
local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 180, 0, 40)
UpButton.Position = UDim2.new(0, 20, 0, 50)
UpButton.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.Text = "TP UP (+150-200)"
UpButton.Font = Enum.Font.Gotham
UpButton.TextSize = 14
UpButton.Parent = MainFrame

local DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0, 180, 0, 40)
DownButton.Position = UDim2.new(0, 20, 0, 100)
DownButton.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownButton.Text = "TP DOWN (-150)"
DownButton.Font = Enum.Font.Gotham
DownButton.TextSize = 14
DownButton.Parent = MainFrame

-- Оптимизированные функции телепортации
local function teleportUp()
    if humanoidRootPart and humanoidRootPart.Parent then
        local currentPos = humanoidRootPart.Position
        local randomHeight = math.random(150, 200)
        local newPos = currentPos + Vector3.new(0, randomHeight, 0)
        
        -- Используем CFrame для мгновенной телепортации (меньше лагов)
        humanoidRootPart.CFrame = CFrame.new(newPos)
    end
end

local function teleportDown()
    if humanoidRootPart and humanoidRootPart.Parent then
        local currentPos = humanoidRootPart.Position
        local newPos = currentPos - Vector3.new(0, 150, 0)
        
        humanoidRootPart.CFrame = CFrame.new(newPos)
    end
end

-- Функции управления GUI (оптимизированные)
local function hideGUI()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end

local function showGUI()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end

-- Обработчики событий (дебаунс для оптимизации)
local lastClick = 0
local function safeClick(callback)
    local now = tick()
    if now - lastClick > 0.5 then -- Защита от спама
        lastClick = now
        callback()
    end
end

-- Подключение событий
UpButton.MouseButton1Click:Connect(function()
    safeClick(teleportUp)
end)

DownButton.MouseButton1Click:Connect(function()
    safeClick(teleportDown)
end)

CloseButton.MouseButton1Click:Connect(function()
    safeClick(hideGUI)
end)

ToggleButton.MouseButton1Click:Connect(function()
    safeClick(showGUI)
end)

-- Оптимизация: отключаем ненужные обновления
RunService:BindToRenderStep("TPGuiUpdate", Enum.RenderPriority.Last.Value, function()
    -- Минимальные обновления GUI
end)

warn("TP GUI loaded successfully! Use buttons to teleport.")
