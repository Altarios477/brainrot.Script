local Players = game:GetService("Players") local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) gui.ResetOnSpawn = false

local main = Instance.new("ScrollingFrame", gui) main.Size = UDim2.new(0, 230, 0, 310) main.Position = UDim2.new(0, 20, 0.3, 0) main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) main.ScrollBarThickness = 6 main.BorderSizePixel = 0 main.CanvasSize = UDim2.new(0, 0, 0, 900) main.AutomaticCanvasSize = Enum.AutomaticSize.Y main.Active = true gui.Name = "🧠 SAB Script UI 🧠"

local function createButton(text, y, callback) local b = Instance.new("TextButton", main) b.Size = UDim2.new(1, -20, 0, 32) b.Position = UDim2.new(0, 10, 0, y) b.Text = text b.BackgroundColor3 = Color3.fromRGB(45, 45, 45) b.TextColor3 = Color3.new(1, 1, 1) b.Font = Enum.Font.SourceSansBold b.TextScaled = true b.BorderSizePixel = 0 b.MouseButton1Click:Connect(callback) return b end

-- Placeholder example buttons (will be replaced with full set) local y = 0 createButton("⬆ ТП вверх", y, function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then root.CFrame += Vector3.new(0, 240, 0) end end) y += 35 createButton("⬇ ТП вниз", y, function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then local rayParams = RaycastParams.new() rayParams.FilterDescendantsInstances = {LocalPlayer.Character} rayParams.FilterType = Enum.RaycastFilterType.Blacklist local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams) if result then root.CFrame = CFrame.new(result.Position + Vector3.new(0, 5, 0)) end end end) y += 35 createButton("🟩 ТП Y=15", y, function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then local pos = root.Position root.CFrame = CFrame.new(pos.X, 15, pos.Z) end end) y += 35

-- Add more buttons below like ESP, Noclip, etc. using same pattern -- Each should increase y by 35 and call createButton("[название]", y, callback)

-- Hide/Show GUI toggle local toggleBtn = Instance.new("TextButton", gui) toggleBtn.Size = UDim2.new(0, 130, 0, 30) toggleBtn.Position = UDim2.new(0, 10, 0, 10) toggleBtn.Text = "📂 Открыть меню" toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) toggleBtn.TextColor3 = Color3.new(1,1,1) toggleBtn.Font = Enum.Font.SourceSansBold toggleBtn.TextScaled = true

toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible toggleBtn.Text = main.Visible and "📂 Скрыть меню" or "📂 Открыть меню" end)
