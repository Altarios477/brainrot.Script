local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local d = 240

function up()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame += Vector3.new(0, d, 0)
    end
end

function toY15()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local pos = root.Position
        root.CFrame = CFrame.new(pos.X, 15, pos.Z)
    end
end

function down()
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams)
        if result then
            root.CFrame = CFrame.new(result.Position + Vector3.new(0, 5, 0))
        else
            root.CFrame = CFrame.new(root.Position.X, 5, root.Position.Z)
        end
    end
end

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 200, 0, 250)
main.Position = UDim2.new(0, 50, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local function addButton(text, y, callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(1, -20, 0, 45)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextScaled = true
    b.MouseButton1Click:Connect(callback)
end

addButton("ТП вверх", 10, up)
addButton("ТП вниз", 65, down)
addButton("ТП на Y = 15", 120, toY15)

local hideBtn = Instance.new("TextButton", main)
hideBtn.Size = UDim2.new(1, -20, 0, 30)
hideBtn.Position = UDim2.new(0, 10, 0, 180)
hideBtn.Text = "Скрыть"
hideBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hideBtn.TextColor3 = Color3.new(1,1,1)
hideBtn.Font = Enum.Font.SourceSans
hideBtn.TextScaled = true

local showBtn = Instance.new("TextButton", gui)
showBtn.Size = UDim2.new(0, 120, 0, 30)
showBtn.Position = UDim2.new(0, 10, 0, 10)
showBtn.Text = "Открыть"
showBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
showBtn.TextColor3 = Color3.new(1,1,1)
showBtn.Font = Enum.Font.SourceSans
showBtn.TextScaled = true
showBtn.Visible = false

hideBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	showBtn.Visible = true
end)

showBtn.MouseButton1Click:Connect(function()
	main.Visible = true
	showBtn.Visible = false
end)

-- ESP на игроков
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(char)
            local head = char:WaitForChild("Head", 5)
            if head and not head:FindFirstChild("ESP") then
                local gui = Instance.new("BillboardGui", head)
                gui.Name = "ESP"
                gui.AlwaysOnTop = true
                gui.Size = UDim2.new(0, 100, 0, 35)
                gui.StudsOffset = Vector3.new(0, 1.8, 0)

                local label = Instance.new("TextLabel", gui)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(1, 0.3, 0.3)
                label.TextStrokeTransparency = 0.4
                label.TextScaled = true
                label.Font = Enum.Font.SourceSansBold

                RunService.RenderStepped:Connect(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor(
                            (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        )
                        label.Text = player.Name .. " [" .. dist .. "м]"
                    end
                end)
            end
        end)
    end
end

-- ESP на базы (заготовка — можешь подставить нужные объекты)
local baseList = {
    workspace:FindFirstChild("RedBase"),
    workspace:FindFirstChild("GreenBase"),
    workspace:FindFirstChild("BlueBase")
}

for _, base in pairs(baseList) do
    if base and base:IsA("BasePart") then
        local gui = Instance.new("BillboardGui", base)
        gui.Name = "BaseESP"
        gui.AlwaysOnTop = true
        gui.Size = UDim2.new(0, 140, 0, 35)
        gui.StudsOffset = Vector3.new(0, 4, 0)

        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(0.3, 1, 0.3)
        label.TextStrokeTransparency = 0.3
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold

        RunService.RenderStepped:Connect(function()
            local timerObj = base:FindFirstChild("Timer")
            if timerObj and timerObj:IsA("NumberValue") then
                local time = math.floor(timerObj.Value)
                if time > 0 then
                    label.Text = "Откроется через " .. time .. "с"
                else
                    label.Text = "ОТКРЫТО"
                end
            else
                label.Text = "БАЗА"
            end
        end)
    end
end
