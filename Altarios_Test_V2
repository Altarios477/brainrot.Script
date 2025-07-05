local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Altarios_Script"

local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0, 120, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 100)
toggle.Text = "Меню"
toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggle.TextColor3 = Color3.new(1, 1, 1)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 10, 0, 140)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = true

toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

local y = 0
local function CreateToggle(text, callback)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, -10, 0, 30)
	b.Position = UDim2.new(0, 5, 0, y)
	b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Text = "⛔ " .. text
	local s = false
	b.MouseButton1Click:Connect(function()
		s = not s
		b.Text = (s and "✅ " or "⛔ ") .. text
		callback(s)
	end)
	y = y + 35
end

local nc
CreateToggle("Noclip", function(s)
	if s then
		nc = RunService.Stepped:Connect(function()
			for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = false end
			end
		end)
	else if nc then nc:Disconnect() end end
end)

CreateToggle("TP вверх", function(s)
	if s then
		local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if r then r.CFrame = r.CFrame + Vector3.new(0, 25, 0) end
	end
end)

local espEnabled = false
local function createESP(p)
	if p == LocalPlayer then return end
	local c = p.Character or p.CharacterAdded:Wait()
	local h = c:WaitForChild("Head")
	if h:FindFirstChild("AltariosESP") then return end
	local e = Instance.new("BillboardGui", h)
	e.Name = "AltariosESP"
	e.Adornee = h
	e.Size = UDim2.new(0, 100, 0, 40)
	e.StudsOffset = Vector3.new(0, 2, 0)
	e.AlwaysOnTop = true
	local l = Instance.new("TextLabel", e)
	l.Size = UDim2.new(1, 0, 1, 0)
	l.Text = p.Name
	l.TextColor3 = Color3.fromRGB(255, 50, 50)
	l.TextStrokeTransparency = 0.4
	l.BackgroundTransparency = 1
	l.TextScaled = true
	l.Font = Enum.Font.SourceSansBold
end

local function enableESP()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then createESP(p) end
	end
	Players.PlayerAdded:Connect(function(p)
		p.CharacterAdded:Connect(function()
			wait(1)
			if espEnabled then createESP(p) end
		end)
	end)
end

local function disableESP()
	for _, p in pairs(Players:GetPlayers()) do
		local c = p.Character
		if c and c:FindFirstChild("Head") then
			local e = c.Head:FindFirstChild("AltariosESP")
			if e then e:Destroy() end
		end
	end
end

CreateToggle("ESP на игроков", function(s)
	espEnabled = s
	if s then enableESP() else disableESP() end
end)

local baseTimers = {}
local conn

local function addBaseTimer(b)
	if b:FindFirstChild("BasePart") and b:FindFirstChild("OpenTime") and not b:FindFirstChild("TimerGui") then
		local g = Instance.new("BillboardGui", b)
		g.Name = "TimerGui"
		g.Adornee = b.BasePart
		g.Size = UDim2.new(0, 120, 0, 30)
		g.StudsOffset = Vector3.new(0, 4, 0)
		g.AlwaysOnTop = true
		local l = Instance.new("TextLabel", g)
		l.Size = UDim2.new(1, 0, 1, 0)
		l.BackgroundTransparency = 1
		l.TextColor3 = Color3.fromRGB(255, 255, 0)
		l.TextStrokeTransparency = 0.3
		l.Font = Enum.Font.SourceSansBold
		l.TextScaled = true
		l.Text = "..."
		table.insert(baseTimers, {base = b, label = l})
	end
end

CreateToggle("Таймеры баз", function(s)
	if s then
		for _, o in pairs(Workspace:GetChildren()) do
			if o:IsA("Model") and o:FindFirstChild("BasePart") and o:FindFirstChild("OpenTime") then
				addBaseTimer(o)
			end
		end
		conn = RunService.RenderStepped:Connect(function()
			for _, t in pairs(baseTimers) do
				if t.base:FindFirstChild("OpenTime") then
					local left = math.floor(t.base.OpenTime.Value - tick())
					t.label.Text = left > 0 and ("Откроется через: " .. left .. "с") or "Открыта!"
				end
			end
		end)
	else
		for _, t in pairs(baseTimers) do
			if t.label and t.label.Parent then t.label.Parent:Destroy() end
		end
		baseTimers = {}
		if conn then conn:Disconnect() end
	end
end)
