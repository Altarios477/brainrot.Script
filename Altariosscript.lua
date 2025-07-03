local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local state = { noclip = false }

local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local function addButton(text, y, callback)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, 0, 0, 40)
	b.Position = UDim2.new(0, 0, 0, y)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	b.Font = Enum.Font.SourceSans
	b.TextSize = 18
	b.MouseButton1Click:Connect(callback)
	return b
end

local b1 = addButton("TP UP", 0, function()
	local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local pos = hrp.Position + Vector3.new(0, 150, 0)
		TweenService:Create(hrp, TweenInfo.new(1.2), {CFrame = CFrame.new(pos)}):Play()
	end
end)

local b2 = addButton("TP BASE", 40, function()
	local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local pos = Vector3.new(0, 20, 0)
		TweenService:Create(hrp, TweenInfo.new(1.2), {CFrame = CFrame.new(pos)}):Play()
	end
end)

local b3 = addButton("NOCLIP: OFF", 80, function()
	state.noclip = not state.noclip
	b3.Text = "NOCLIP: " .. (state.noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
	if state.noclip and lp.Character then
		for _, v in pairs(lp.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)
