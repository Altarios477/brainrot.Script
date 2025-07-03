local mt = getrawmetatable(game)
setreadonly(mt, false)

local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or tostring(self):lower():find("kick") then
        return nil
    end
    return old(self, ...)
end)

for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        local name = tostring(v.Name):lower()
        if name:find("kick") or name:find("ban") or name:find("anticheat") then
            v:Destroy()
        end
    end
end

for _, v in pairs(game.Players.LocalPlayer:GetDescendants()) do
    if v:IsA("Script") or v:IsA("LocalScript") then
        if tostring(v.Name):lower():find("anticheat") then
            v:Destroy()
        end
    end
end

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Altarios_Script"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 160, 0, 100)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1, 0, 0, 40)
btn.Position = UDim2.new(0, 0, 0, 30)
btn.Text = "Noclip: OFF"
btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.SourceSans
btn.TextSize = 18

local state = false
local noclipConn

btn.MouseButton1Click:Connect(function()
	state = not state
	btn.Text = "Noclip: " .. (state and "ON" or "OFF")
	if state then
		noclipConn = game:GetService("RunService").Stepped:Connect(function()
			for _,v in pairs((plr.Character or plr.CharacterAdded:Wait()):GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end)
	else
		if noclipConn then
			noclipConn:Disconnect()
		end
	end
end)
