setfpscap(30)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local noclipEnabled = true
local autoTPEnabled = true

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BrainrotGUI"

local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 180, 0, 90)
frame.Position = UDim2.new(0, 10, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Size = UDim2.new(1, 0, 0.5, -2)
noclipBtn.Position = UDim2.new(0, 0, 0, 0)
noclipBtn.Text = "Noclip: ON"
noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noclipBtn.TextColor3 = Color3.new(1, 1, 1)

local tpBtn = Instance.new("TextButton", frame)
tpBtn.Size = UDim2.new(1, 0, 0.5, -2)
tpBtn.Position = UDim2.new(0, 0, 0.5, 2)
tpBtn.Text = "Auto TP: ON"
tpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tpBtn.TextColor3 = Color3.new(1, 1, 1)

noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
end)

tpBtn.MouseButton1Click:Connect(function()
    autoTPEnabled = not autoTPEnabled
    tpBtn.Text = "Auto TP: " .. (autoTPEnabled and "ON" or "OFF")
end)

-- Noclip обход
RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = lp.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(11)
            hum.PlatformStand = false
        end
    end
end)

-- Поиск Brainrot
local function getClosestBrainrot()
    local closest, dist = nil, math.huge
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("brain") then
            local d = (obj.Position - hrp.Position).Magnitude
            if d < dist and d < 150 then
                closest = obj
                dist = d
            end
        end
    end
    return closest
end

-- Телепорт
local function tpTo(pos)
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local distance = (hrp.Position - pos).Magnitude
    local time = math.clamp(distance / 80, 0.3, 2)
    local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))})
    tween:Play()
    tween.Completed:Wait()
end

-- Основной цикл
task.spawn(function()
    while task.wait(2) do
        if autoTPEnabled then
            pcall(function()
                local brain = getClosestBrainrot()
                if brain then
                    tpTo(brain.Position)
                end
            end)
        end
    end
end)
