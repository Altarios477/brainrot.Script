local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui) Main.Size = UDim2.new(0, 500, 0, 340) Main.Position = UDim2.new(0.5, -250, 0.4, 0) Main.BackgroundColor3 = Color3.fromRGB(20, 20, 40) Main.BorderSizePixel = 0 Main.Active = true Main.Draggable = true

local TabButtons = Instance.new("Frame", Main) TabButtons.Size = UDim2.new(1, 0, 0, 30) TabButtons.BackgroundTransparency = 1

local Tabs = {"Visual", "Misc", "Global"} local CurrentTab = "Visual" local ButtonFrames = {}

for i, tab in ipairs(Tabs) do local btn = Instance.new("TextButton", TabButtons) btn.Size = UDim2.new(0, 160, 0, 30) btn.Position = UDim2.new(0, (i - 1) * 160, 0, 0) btn.Text = tab btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.SourceSansBold btn.TextScaled = true btn.BorderSizePixel = 0

local frame = Instance.new("ScrollingFrame", Main)
frame.Size = UDim2.new(1, 0, 1, -30)
frame.Position = UDim2.new(0, 0, 0, 30)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
frame.BorderSizePixel = 0
frame.Visible = tab == CurrentTab
frame.ScrollBarThickness = 6
frame.CanvasSize = UDim2.new(0, 0, 0, 1000)
frame.AutomaticCanvasSize = Enum.AutomaticSize.Y

ButtonFrames[tab] = frame

btn.MouseButton1Click:Connect(function()
    for _, f in pairs(ButtonFrames) do f.Visible = false end
    frame.Visible = true
    CurrentTab = tab
end)

end

local function AddButton(tab, text, callback) local frame = ButtonFrames[tab] if not frame then return end

local count = #frame:GetChildren() - 1
local row = math.floor(count / 4)
local col = count % 4

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

-- Example Functions AddButton("Visual", "ESP👀", function() print("ESP") end)

AddButton("Visual", "Noclip🚪", function() print("Noclip") end)

AddButton("Misc", "Speed⚡", function() print("Speed") end)

AddButton("Misc", "AntiAFK💤", function() print("AntiAFK") end)

AddButton("Global", "TP⬆", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then root.CFrame = root.CFrame + Vector3.new(0, 240, 0) end end)

AddButton("Global", "TP⬇", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then local rayParams = RaycastParams.new() rayParams.FilterDescendantsInstances = {LocalPlayer.Character} rayParams.FilterType = Enum.RaycastFilterType.Blacklist local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams) if result then root.CFrame = CFrame.new(result.Position + Vector3.new(0, 5, 0)) end end end)

AddButton("Global", "TP Y=15📍", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then local pos = root.Position root.CFrame = CFrame.new(pos.X, 15, pos.Z) end end)

AddButton("Visual", "Таймеры⏱", function() for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("TextLabel") or obj:IsA("TextBox") then if string.find(obj.Text, "%d+s") then local parent = obj:FindFirstAncestorWhichIsA("BasePart") or obj:FindFirstAncestorOfClass("Model") if parent and not parent:FindFirstChild("TimerESP") then local gui = Instance.new("BillboardGui", parent) gui.Name = "TimerESP" gui.AlwaysOnTop = true gui.Size = UDim2.new(0, 120, 0, 30) gui.StudsOffset = Vector3.new(0, 4, 0) local label = Instance.new("TextLabel", gui) label.Size = UDim2.new(1, 0, 1, 0) label.BackgroundTransparency = 1 label.TextColor3 = Color3.new(0.4, 1, 0.4) label.TextScaled = true label.Font = Enum.Font.SourceSansBold RunService.RenderStepped:Connect(function() if obj.Text and obj:IsDescendantOf(workspace) then label.Text = obj.Text end end) end end end end end)

