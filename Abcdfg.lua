local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 120)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Parent = ScreenGui

local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local UpButton = Instance.new("TextButton")
UpButton.Size = UDim2.new(0, 180, 0, 40)
UpButton.Position = UDim2.new(0, 10, 0, 10)
UpButton.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
UpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpButton.Text = "TP UP"
UpButton.Font = Enum.Font.Gotham
UpButton.TextSize = 14
UpButton.Parent = MainFrame

local DownButton = Instance.new("TextButton")
DownButton.Size = UDim2.new(0, 180, 0, 40)
DownButton.Position = UDim2.new(0, 10, 0, 60)
DownButton.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
DownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DownButton.Text = "TP DOWN"
DownButton.Font = Enum.Font.Gotham
DownButton.TextSize = 14
DownButton.Parent = MainFrame

UpButton.MouseButton1Click:Connect(function()
    local currentPos = humanoidRootPart.Position
    local randomHeight = math.random(150, 200)
    humanoidRootPart.CFrame = CFrame.new(currentPos + Vector3.new(0, randomHeight, 0))
end)

DownButton.MouseButton1Click:Connect(function()
    local currentPos = humanoidRootPart.Position
    humanoidRootPart.CFrame = CFrame.new(currentPos - Vector3.new(0, 150, 0))
end)
