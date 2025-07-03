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

-- Новый Noclip (все части тела без CanCollide)
RunService.Stepped:Connect(function()
    if noclipEnabled and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end
end)

-- Обновлённый поиск Brainrot объектов
local function getClosestBrainrot()
    local char = lp.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local closest, dist = nil, math.huge

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():match("brain") then
            local d = (obj.Position - hrp.Position).Magnitude
            if d < dist then
                closest = obj
                dist = d
            end
        end
    end

    return closest
end

-- Плавный TP (Tween)
local function smoothTP(targetPos)
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - targetPos).Magnitude
    local tween = TweenService:Create(hrp, TweenInfo.new(dist / 70, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
    })
    tween:Play()
    tween.Completed:Wait()
end

-- Цикл автоТП
task.spawn(function()
    while task.wait(1.5) do
        if autoTPEnabled then
            pcall(function()
                local obj = getClosestBrainrot()
                if obj then
                    smoothTP(obj.Position)
                end
            end)
        end
    end
end)
