local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Altarios_Script"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 180)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

local function button(name, y, func)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, 0, 0, 40)
	b.Position = UDim2.new(0, 0, 0, y)
	b.Text = name
	b.TextColor3 = Color3.new(1, 1, 1)
	b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	b.Font = Enum.Font.SourceSans
	b.TextSize = 18
	b.MouseButton1Click:Connect(func)
	return b
end

local noclip = false
local upEnabled = false

local noclipBtn = button("🚪 Noclip: OFF", 0, function()
	noclip = not noclip
	noclipBtn.Text = "🚪 Noclip: " .. (noclip and "ON" or "OFF")
end)

button("⬆️ TP ВВЕРХ", 45, function()
	local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local pos = hrp.Position + Vector3.new(0, 1000, 0)
		TweenService:Create(hrp, TweenInfo.new(1.5), {CFrame = CFrame.new(pos)}):Play()
	end
end)

button("⬇️ TP ВНИЗ", 90, function()
	local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local pos = hrp.Position - Vector3.new(0, 1000, 0)
		TweenService:Create(hrp, TweenInfo.new(1.5), {CFrame = CFrame.new(pos)}):Play()
	end
end)

button("❌ Закрыть GUI", 135, function()
	gui:Destroy()
end)

RunService.Stepped:Connect(function()
	if noclip and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
