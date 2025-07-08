local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui) main.Size = UDim2.new(0, 500, 0, 340) main.Position = UDim2.new(0.5, -250, 0.4, 0) main.BackgroundColor3 = Color3.fromRGB(20, 20, 40) main.BorderSizePixel = 0 main.Active = true main.Draggable = true

local tabs = Instance.new("Frame", main) tabs.Size = UDim2.new(1, 0, 0, 30) tabs.BackgroundTransparency = 1

local tabNames = {"Visual", "Misc", "Global"} local currentTab = "Visual" local tabFrames = {}

for i, name in ipairs(tabNames) do local btn = Instance.new("TextButton", tabs) btn.Size = UDim2.new(0, 160, 0, 30) btn.Position = UDim2.new(0, (i - 1) * 160, 0, 0) btn.Text = name btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.SourceSansBold btn.TextScaled = true btn.BorderSizePixel = 0

local frame = Instance.new("ScrollingFrame", main)
frame.Size = UDim2.new(1, 0, 1, -30)
frame.Position = UDim2.new(0, 0, 0, 30)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
frame.BorderSizePixel = 0
frame.Visible = name == currentTab
frame.ScrollBarThickness = 6
frame.CanvasSize = UDim2.new(0, 0, 0, 1000)
frame.AutomaticCanvasSize = Enum.AutomaticSize.Y

tabFrames[name] = frame

btn.MouseButton1Click:Connect(function()
    for _, f in pairs(tabFrames) do f.Visible = false end
    frame.Visible = true
    currentTab = name
end)

end

local function addButton(tab, text, callback) local frame = tabFrames[tab] if not frame then return end local count = #frame:GetChildren() - 1 local row = math.floor(count / 4) local col = count % 4

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0, 115, 0, 45)
btn.Position = UDim2.new(0, 10 + col * 120, 0, 10 + row * 50)
btn.Text = text
btn.BackgroundColor3 = Color3.fromRGB(50, 50, 90)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.SourceSansBold
btn.TextScaled = true
btn.BorderSizePixel = 0
btn.MouseButton1Click:Connect(callback)

end

addButton("Visual", "ESP👀", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then local function esp(char) local hrp = char:WaitForChild("HumanoidRootPart", 5) if hrp and not hrp:FindFirstChild("ESP") then local b = Instance.new("BillboardGui", hrp) b.Name = "ESP" b.AlwaysOnTop = true b.Size = UDim2.new(0, 110, 0, 35) b.StudsOffset = Vector3.new(0, 2.5, 0) local t = Instance.new("TextLabel", b) t.Size = UDim2.new(1, 0, 1, 0) t.BackgroundTransparency = 1 t.TextColor3 = Color3.new(1, 0.4, 0.4) t.TextScaled = true t.Font = Enum.Font.SourceSansBold RunService.RenderStepped:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then local d = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude) t.Text = p.Name .. " [" .. d .. "м]" end end) end end if p.Character then esp(p.Character) end p.CharacterAdded:Connect(esp) end end end)

addButton("Visual", "Таймеры⏱", function() for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("TextLabel") or o:IsA("TextBox") then if string.find(o.Text, "%d+s") then local p = o:FindFirstAncestorWhichIsA("BasePart") or o:FindFirstAncestorOfClass("Model") if p and not p:FindFirstChild("TimerESP") then local g = Instance.new("BillboardGui", p) g.Name = "TimerESP" g.AlwaysOnTop = true g.Size = UDim2.new(0, 120, 0, 30) g.StudsOffset = Vector3.new(0, 4, 0) local l = Instance.new("TextLabel", g) l.Size = UDim2.new(1, 0, 1, 0) l.BackgroundTransparency = 1 l.TextColor3 = Color3.new(0.4, 1, 0.4) l.TextScaled = true l.Font = Enum.Font.SourceSansBold RunService.RenderStepped:Connect(function() if o.Text and o:IsDescendantOf(workspace) then l.Text = o.Text end end) end end end end end)

addButton("Misc", "Noclip🚪", function() for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end)

addButton("Misc", "Speed⚡", function() LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 80 end)

addButton("Global", "TP⬆", function() local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then r.CFrame += Vector3.new(0, 240, 0) end end)

addButton("Global", "TP⬇", function() local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then local rp = RaycastParams.new() rp.FilterDescendantsInstances = {LocalPlayer.Character} rp.FilterType = Enum.RaycastFilterType.Blacklist local res = workspace:Raycast(r.Position, Vector3.new(0, -1000, 0), rp) if res then r.CFrame = CFrame.new(res.Position + Vector3.new(0, 5, 0)) end end end)

addButton("Global", "TP Y=15📍", function() local r = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then r.CFrame = CFrame.new(r.Position.X, 15, r.Position.Z) end end)

