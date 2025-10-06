local p=game.Players.LocalPlayer
local rs=game:GetService("RunService")
local tw=game:GetService("TweenService")
local g=Instance.new("ScreenGui",game.CoreGui)
g.Name="Altarios_Script"
local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,200,0,140)
f.Position=UDim2.new(0,20,0,100)
f.BackgroundColor3=Color3.fromRGB(25,25,25)
local function b(t,y,c)
	local k=Instance.new("TextButton",f)
	k.Size=UDim2.new(1,0,0,40)
	k.Position=UDim2.new(0,0,0,y)
	k.Text=t
	k.TextColor3=Color3.new(1,1,1)
	k.BackgroundColor3=Color3.fromRGB(50,50,50)
	k.Font=Enum.Font.SourceSans
	k.TextSize=18
	k.MouseButton1Click:Connect(c)
	return k
end

local n=false
local nb=b("🚪 Noclip: OFF",0,function()
	n=not n
	nb.Text="🚪 Noclip: "..(n and "ON" or "OFF")
end)

b("⬆️ TP ВВЕРХ",45,function()
	local h=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if h then
		tw:Create(h,TweenInfo.new(1.5),{CFrame=h.CFrame+Vector3.new(0,1600,0)}):Play()
	end
end)

b("⬇️ TP ВНИЗ",90,function()
	local h=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if h then
		tw:Create(h,TweenInfo.new(1.5),{CFrame=h.CFrame-Vector3.new(0,1600,0)}):Play()
	end
end)

b("❌ Закрыть",135,function()
	g:Destroy()
end)

rs.Stepped:Connect(function()
	if n and p.Character then
		for _,v in pairs(p.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end
end)
