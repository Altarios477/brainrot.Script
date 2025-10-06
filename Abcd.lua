local p=game.Players.LocalPlayer
local rs=game:GetService("RunService")
local tw=game:GetService("TweenService")

local g=Instance.new("ScreenGui",game.CoreGui)
g.Name="Altarios_Script"

local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,200,0,160)
f.Position=UDim2.new(0,30,0,150)
f.BackgroundColor3=Color3.fromRGB(25,25,35)
f.Active=true
f.Draggable=true
f.Visible=false

local menu=Instance.new("TextButton",g)
menu.Size=UDim2.new(0,120,0,40)
menu.Position=UDim2.new(0,30,0,100)
menu.Text="🎛 Меню"
menu.TextColor3=Color3.new(1,1,1)
menu.Font=Enum.Font.SourceSansBold
menu.TextSize=20
menu.BackgroundColor3=Color3.fromRGB(45,45,65)
menu.Active=true
menu.Draggable=true

menu.MouseButton1Click:Connect(function()
	f.Visible=not f.Visible
end)

local function b(t,y,c)
	local k=Instance.new("TextButton",f)
	k.Size=UDim2.new(1,0,0,35)
	k.Position=UDim2.new(0,0,0,y)
	k.Text=t
	k.TextColor3=Color3.new(1,1,1)
	k.BackgroundColor3=Color3.fromRGB(40,40,55)
	k.Font=Enum.Font.SourceSansBold
	k.TextSize=18
	k.MouseButton1Click:Connect(c)
	return k
end

local noclip=false
local nb=b("🚪 Noclip: OFF",0,function()
	noclip=not noclip
	nb.Text="🚪 Noclip: "..(noclip and "ON" or "OFF")
end)

b("⬆️ TP ВВЕРХ",40,function()
	local h=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if h then
		tw:Create(h,TweenInfo.new(1),{CFrame=h.CFrame+Vector3.new(0,180,0)}):Play()
	end
end)

b("⬇️ TP ВНИЗ",80,function()
	local h=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
	if h then
		tw:Create(h,TweenInfo.new(1),{CFrame=h.CFrame-Vector3.new(0,180,0)}):Play()
	end
end)

b("❌ Закрыть",120,function()
	g:Destroy()
end)

rs.Stepped:Connect(function()
	if noclip and p.Character then
		for _,v in pairs(p.Character:GetDescendants())do
			if v:IsA("BasePart")then v.CanCollide=false end
		end
	end
end)
