loadstring([[
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

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 160, 0, 180)
main.Position = UDim2.new(0, 50, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local function addButton(text, y, callback)
    local b = Instance.new("TextButton", main)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextScaled = true
    b.MouseButton1Click:Connect(callback)
end

addButton("ТП вверх", 0, up)
addButton("ТП вниз", 0.35, toY15)

local hideBtn = Instance.new("TextButton", main)
hideBtn.Size = UDim2.new(1, -20, 0, 30)
hideBtn.Position = UDim2.new(0, 10, 0, 0.75)
hideBtn.Text = "Скрыть"
hideBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function()
            task.wait(1)
            local head = plr.Character:WaitForChild("Head", 5)
            if head and not head:FindFirstChild("ESP") then
                local esp = Instance.new("BillboardGui", head)
                esp.Name = "ESP"
                esp.Size = UDim2.new(0,100,0,40)
                esp.Adornee = head
                esp.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", esp)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.new(1, 0, 0)
                txt.TextStrokeTransparency = 0.5
                txt.Font = Enum.Font.SourceSansBold
                txt.TextScaled = true
                RunService.RenderStepped:Connect(function()
                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude)
                        txt.Text = plr.Name.." ["..dist.."м]"
                    end
                end)
            end
        end)
    end
end
]])()
