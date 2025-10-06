local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local noclip = false
local tpUp = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Altarios_Script"
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 150)
Frame.Position = UDim2.new(0.5, -110, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Text = "Altarios_Script"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = Frame

local function newButton(name, order, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 30 + (order * 35))
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Text = name .. ": OFF"
    button.Parent = Frame

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)

    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

newButton("Noclip🚪", 0, function(state)
    noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and character and character:FindFirstChild("HumanoidRootPart") then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

newButton("TP вверх📍", 1, function(state)
    tpUp = state
    task.spawn(function()
        while tpUp do
            if character and character:FindFirstChild("HumanoidRootPart") then
                character:FindFirstChild("HumanoidRootPart").CFrame =
                    character:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 10, 0)
            end
            task.wait(0.5)
        end
    end)
end)

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
