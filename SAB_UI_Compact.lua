-- Services local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local UIS = game:GetService("UserInputService") local RunService = game:GetService("RunService")

-- GUI local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui) main.Size = UDim2.new(0, 270, 0, 300) main.Position = UDim2.new(0.5, -135, 0.4, 0) main.BackgroundColor3 = Color3.fromRGB(25, 25, 45) main.BorderSizePixel = 0 main.Active = true main.Draggable = true main.Name = "SAB_UI" main.ClipsDescendants = true main.AnchorPoint = Vector2.new(0.5, 0)

-- Tabs local tabButtons = {} local tabs = {} local currentTab = nil local tabNames = {"Main", "Visual", "Misc"}

for i, tabName in ipairs(tabNames) do local tabBtn = Instance.new("TextButton", main) tabBtn.Size = UDim2.new(0, 90, 0, 30) tabBtn.Position = UDim2.new(0, (i - 1) * 90, 0, 0) tabBtn.Text = tabName tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80) tabBtn.TextColor3 = Color3.new(1, 1, 1) tabBtn.Font = Enum.Font.SourceSansBold tabBtn.TextScaled = true tabBtn.BorderSizePixel = 0 tabButtons[tabName] = tabBtn

local tabFrame = Instance.new("Frame", main)
tabFrame.Position = UDim2.new(0, 0, 0, 30)
tabFrame.Size = UDim2.new(1, 0, 1, -30)
tabFrame.BackgroundTransparency = 1
tabFrame.Visible = false
tabs[tabName] = tabFrame

end

local function switchTab(name) for tab, frame in pairs(tabs) do frame.Visible = (tab == name) end currentTab = name end

for name, btn in pairs(tabButtons) do btn.MouseButton1Click:Connect(function() switchTab(name) end) end

switchTab("Main")

local function addButton(tabName, text, callback) local tab = tabs[tabName] if not tab then return end local count = #tab:GetChildren() local btn = Instance.new("TextButton", tab) btn.Size = UDim2.new(1, -20, 0, 40) btn.Position = UDim2.new(0, 10, 0, 10 + (count * 45)) btn.BackgroundColor3 = Color3.fromRGB(50, 50, 90) btn.TextColor3 = Color3.new(1,1,1) btn.Font = Enum.Font.SourceSansBold btn.TextScaled = true btn.BorderSizePixel = 0 btn.Text = text btn.MouseButton1Click:Connect(callback) end

-- Main Tab addButton("Main", "🔼 Infinite Jump", function() _G.infjump = true game:GetService("UserInputService").JumpRequest:Connect(function() if _G.infjump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping") end end) end)

addButton("Main", "🚪 Noclip", function() RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end) end)

addButton("Main", "💚 Godmode", function() local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false) char.Humanoid.Health = math.huge end end)

addButton("Main", "🛸 Fly GUI", function() loadstring(game:HttpGet("https://pastebin.com/raw/U27yQRxS"))() end)

-- Visual Tab addButton("Visual", "👀 ESP", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then p.CharacterAdded:Connect(function(c) local head = c:WaitForChild("Head", 5) if head and not head:FindFirstChild("ESP") then local b = Instance.new("BillboardGui", head) b.Name = "ESP" b.AlwaysOnTop = true b.Size = UDim2.new(0, 100, 0, 40) b.StudsOffset = Vector3.new(0, 2, 0) local t = Instance.new("TextLabel", b) t.Size = UDim2.new(1, 0, 1, 0) t.BackgroundTransparency = 1 t.TextColor3 = Color3.new(1, 0.4, 0.4) t.TextScaled = true t.Font = Enum.Font.SourceSansBold RunService.RenderStepped:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then local d = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude) t.Text = p.Name .. " [" .. d .. "м]" end end) end end) end end end)

addButton("Visual", "⏱ Таймеры", function() for _, o in ipairs(workspace:GetDescendants()) do if o:IsA("TextLabel") or o:IsA("TextBox") then if string.find(o.Text, "%d+s") then local p = o:FindFirstAncestorWhichIsA("BasePart") or o:FindFirstAncestorOfClass("Model") if p and not p:FindFirstChild("TimerESP") then local g = Instance.new("BillboardGui", p) g.Name = "TimerESP" g.AlwaysOnTop = true g.Size = UDim2.new(0, 120, 0, 30) g.StudsOffset = Vector3.new(0, 4, 0) local l = Instance.new("TextLabel", g) l.Size = UDim2.new(1, 0, 1, 0) l.BackgroundTransparency = 1 l.TextColor3 = Color3.new(0.4, 1, 0.4) l.TextScaled = true l.Font = Enum.Font.SourceSansBold RunService.RenderStepped:Connect(function() if o.Text and o:IsDescendantOf(workspace) then l.Text = o.Text end end) end end end end end)

addButton("Visual", "🎯 Player Tracker", function() print("Player Tracker enabled") end)

addButton("Visual", "🔦 Highlight Players", function() print("Highlight enabled") end)

-- Misc Tab addButton("Misc", "⚡ SpeedBoost", function() LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 80 end)

addButton("Misc", "💤 Anti-AFK", function() local vu = game:GetService("VirtualUser") LocalPlayer.Idled:Connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(1) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end)

addButton("Misc", "📍 ТП вниз", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then root.CFrame = CFrame.new(root.Position.X, 15, root.Position.Z) end end)

addButton("Misc", "🗑 Удалить Античит", function() for _, obj in ipairs(getnilinstances()) do if obj:IsA("Script") and string.find(obj.Name:lower(), "anti") then obj:Destroy() end end end)
