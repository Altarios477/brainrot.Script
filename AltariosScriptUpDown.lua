local uis = game:GetService("UserInputService")
local p = game:GetService("Players").LocalPlayer
local c = p.Character or p.CharacterAdded:Wait()
local hrp = c:WaitForChild("HumanoidRootPart")
local on = false

-- GUI
local s = Instance.new("ScreenGui", p:WaitForChild("PlayerGui"))
s.Name = "Altarios_GUI"

local f = Instance.new("Frame", s)
f.Size = UDim2.new(0, 200, 0, 100)
f.Position = UDim2.new(0.5, -100, 0.5, -50)
f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
f.Visible = true

local b = Instance.new("TextButton", f)
b.Size = UDim2.new(1, -20, 0, 40)
b.Position = UDim2.new(0, 10, 0, 10)
b.Text = "TP Height: OFF"
b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
b.TextColor3 = Color3.new(1,1,1)
b.Font = Enum.Font.SourceSansBold
b.TextSize = 18

b.MouseButton1Click:Connect(function()
	on = not on
	hrp.Anchored = on
	if on then
		hrp.CFrame = CFrame.new(hrp.Position.X, 1000, hrp.Position.Z)
		b.Text = "TP Height: ON"
	else
		b.Text = "TP Height: OFF"
	end
end)

-- Меню ON/OFF по RightShift
uis.InputBegan:Connect(function(i, g)
	if g then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		f.Visible = not f.Visible
	end
end)
