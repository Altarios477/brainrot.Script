local Players = game:GetService("Players") local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local LocalPlayer = Players.LocalPlayer local Workspace = game:GetService("Workspace")

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) gui.ResetOnSpawn = false

local main = Instance.new("ScrollingFrame", gui) main.Size = UDim2.new(0, 230, 0, 310) main.Position = UDim2.new(0, 20, 0.3, 0) main.BackgroundColor3 = Color3.fromRGB(25, 25, 25) main.ScrollBarThickness = 6 main.BorderSizePixel = 0 main.CanvasSize = UDim2.new(0, 0, 0, 1000) main.AutomaticCanvasSize = Enum.AutomaticSize.Y main.Active = true gui.Name = "🧠 SAB Script UI 🧠"

local y = 0 local function createButton(text, callback) local b = Instance.new("TextButton", main) b.Size = UDim2.new(1, -20, 0, 32) b.Position = UDim2.new(0, 10, 0, y) b.Text = text b.BackgroundColor3 = Color3.fromRGB(45, 45, 45) b.TextColor3 = Color3.new(1, 1, 1) b.Font = Enum.Font.SourceSansBold b.TextScaled = true b.BorderSizePixel = 0 b.MouseButton1Click:Connect(callback) y += 35 end

-- TP createButton("⬆ ТП вверх", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then root.CFrame += Vector3.new(0, 240, 0) end end)

createButton("⬇ ТП вниз", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then local rayParams = RaycastParams.new() rayParams.FilterDescendantsInstances = {LocalPlayer.Character} rayParams.FilterType = Enum.RaycastFilterType.Blacklist local result = workspace:Raycast(root.Position, Vector3.new(0, -1000, 0), rayParams) if result then root.CFrame = CFrame.new(result.Position + Vector3.new(0, 5, 0)) end end end)

createButton("🟩 ТП Y=15", function() local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if root then local pos = root.Position root.CFrame = CFrame.new(pos.X, 15, pos.Z) end end)

-- ESP игроков createButton("👤 ESP Игроки", function() for _, player in pairs(Players:GetPlayers()) do if player ~= LocalPlayer then player.CharacterAdded:Connect(function(char) local root = char:WaitForChild("HumanoidRootPart", 5) if root and not root:FindFirstChild("ESP") then local gui = Instance.new("BillboardGui", root) gui.Name = "ESP" gui.AlwaysOnTop = true gui.Size = UDim2.new(0, 110, 0, 35) gui.StudsOffset = Vector3.new(0, 2.5, 0)

local label = Instance.new("TextLabel", gui)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(1, 0.4, 0.4)
                label.TextStrokeTransparency = 0.3
                label.TextScaled = true
                label.Font = Enum.Font.SourceSansBold

                RunService.RenderStepped:Connect(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                        label.Text = player.Name .. " [" .. dist .. "м]"
                    end
                end)
            end
        end)
    end
end

end)

-- ESP таймеры createButton("⏱ ESP Таймеры", function() for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("TextLabel") or obj:IsA("TextBox") then if string.find(obj.Text, "%d+s") then local parent = obj:FindFirstAncestorWhichIsA("BasePart") or obj:FindFirstAncestorOfClass("Model") if parent and not parent:FindFirstChild("TimerESP") then local gui = Instance.new("BillboardGui", parent) gui.Name = "TimerESP" gui.AlwaysOnTop = true gui.Size = UDim2.new(0, 120, 0, 30) gui.StudsOffset = Vector3.new(0, 4, 0)

local label = Instance.new("TextLabel", gui)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.new(0.4, 1, 0.4)
                label.TextScaled = true
                label.Font = Enum.Font.SourceSansBold

                RunService.RenderStepped:Connect(function()
                    if obj.Text and obj:IsDescendantOf(workspace) then
                        label.Text = obj.Text
                    end
                end)
            end
        end
    end
end

end)

-- Остальные функции (Noclip, Speed, Aura и т.п.) будут добавлены следом по этой структуре

-- GUI Toggle local toggleBtn = Instance.new("TextButton", gui) toggleBtn.Size = UDim2.new(0, 130, 0, 30) toggleBtn.Position = UDim2.new(0, 10, 0, 10) toggleBtn.Text = "📂 Открыть меню" toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) toggleBtn.TextColor3 = Color3.new(1,1,1) toggleBtn.Font = Enum.Font.SourceSansBold toggleBtn.TextScaled = true

toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible toggleBtn.Text = main.Visible and "📂 Скрыть меню" or "📂 Открыть меню" end)

