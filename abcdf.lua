-- Altarios_Script (updated) — paste into executor
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local state = { noclip = false, tpUp = false, tpDown = false }
local STEP_Y = 5        -- how much each micro-step moves (studs)
local STEP_DELAY = 0.08 -- delay between micro-steps (seconds)
local MAX_MOVE = 180    -- total approximate move per activation if used in one go

-- GUI
local screen = Instance.new("ScreenGui", game.CoreGui)
screen.Name = "Altarios_Script"

local menuBtn = Instance.new("TextButton", screen)
menuBtn.Size = UDim2.new(0,120,0,40)
menuBtn.Position = UDim2.new(0,40,0,120)
menuBtn.Text = "Меню"
menuBtn.Font = Enum.Font.SourceSansBold
menuBtn.TextSize = 18
menuBtn.TextColor3 = Color3.new(1,1,1)
menuBtn.BackgroundColor3 = Color3.fromRGB(38,82,255)
menuBtn.Active = true
menuBtn.Draggable = true

local frame = Instance.new("Frame", screen)
frame.Size = UDim2.new(0,220,0,200)
frame.Position = UDim2.new(0,40,0,170)
frame.BackgroundColor3 = Color3.fromRGB(22,26,40)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Altarios_Script"
title.TextColor3 = Color3.fromRGB(140,200,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

local function newButton(text, y, callback)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, -20, 0, 36)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.Font = Enum.Font.SourceSans
	b.TextSize = 16
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(44,48,70)
	b.MouseButton1Click:Connect(callback)
	return b
end

local noclipBtn = newButton("Noclip: OFF", 40, function()
	state.noclip = not state.noclip
	noclipBtn.Text = "Noclip: " .. (state.noclip and "ON" or "OFF")
end)

local tpUpBtn = newButton("TP UP: OFF", 86, function()
	state.tpUp = not state.tpUp
	-- ensure tpDown is off
	if state.tpUp then state.tpDown = false end
	tpUpBtn.Text = "TP UP: " .. (state.tpUp and "ON" or "OFF")
	tpDownBtn.Text = "TP DOWN: " .. (state.tpDown and "ON" or "OFF")
end)

local tpDownBtn = newButton("TP DOWN: OFF", 132, function()
	state.tpDown = not state.tpDown
	if state.tpDown then state.tpUp = false end
	tpDownBtn.Text = "TP DOWN: " .. (state.tpDown and "ON" or "OFF")
	tpUpBtn.Text = "TP UP: " .. (state.tpUp and "ON" or "OFF")
end)

local closeBtn = newButton("Close GUI", 174, function()
	screen:Destroy()
end)

menuBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		frame.Visible = not frame.Visible
	end
end)

-- single controller loop to avoid multiple threads
task.spawn(function()
	while true do
		task.wait(STEP_DELAY)
		-- noclip enforcement
		if state.noclip and lp.Character then
			local ok, char = pcall(function() return lp.Character end)
			if ok and char then
				for _,v in pairs(char:GetDescendants()) do
					if v:IsA("BasePart") then
						pcall(function() v.CanCollide = false end)
					end
				end
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					pcall(function() hum:ChangeState(11) end)
				end
			end
		end

		-- tp up micro-steps (smooth, anti-kick)
		if (state.tpUp or state.tpDown) and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = lp.Character.HumanoidRootPart
			-- determine direction and remaining safe step
			local dir = state.tpUp and 1 or (state.tpDown and -1 or 0)
			if dir ~= 0 then
				-- do small step by tween for server-friendly movement
				local targetPos = hrp.Position + Vector3.new(0, STEP_Y * dir, 0)
				local success, tween = pcall(function()
					return TweenService:Create(hrp, TweenInfo.new(STEP_DELAY*0.9, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
				end)
				if success and tween then
					pcall(function() tween:Play() end)
				else
					-- fallback direct small CFrame set
					pcall(function() hrp.CFrame = hrp.CFrame + Vector3.new(0, STEP_Y * dir, 0) end)
				end
			end
		end
	end
end)
