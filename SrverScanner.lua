local rares = {"tralalelo","tralala","lavaka","meduza","grammarmaram","dingdingdoon","oblivion","skeleton","glitch","unknown"}

local function found()
	for _,p in ipairs(game.Players:GetPlayers()) do
		if p.Character and p.Character:FindFirstChild("Head") then
			local gui = p.Character.Head:FindFirstChildWhichIsA("BillboardGui")
			if gui and gui:FindFirstChild("TextLabel") then
				local txt = gui.TextLabel.Text
				for _,r in ipairs(rares) do
					if string.find(string.lower(txt), r) then
						return true
					end
				end
			end
		end
	end
	return false
end

if found() then
	warn("💎 Найден редкий брейнрот!")
	return
end

local Http = game:GetService("HttpService")
local TP = game:GetService("TeleportService")
local id = game.PlaceId
local jobId = game.JobId
local servers = {}

local function fetch()
	local cursor = ""
	repeat
		local url = "https://games.roblox.com/v1/games/"..id.."/servers/Public?sortOrder=Desc&limit=100" .. (cursor ~= "" and "&cursor="..cursor or "")
		local suc, res = pcall(function()
			return Http:JSONDecode(game:HttpGet(url))
		end)
		if suc and res and res.data then
			for _, v in pairs(res.data) do
				if v.playing > 3 and v.id ~= jobId then
					table.insert(servers, v.id)
				end
			end
			cursor = res.nextPageCursor or ""
		else
			break
		end
	until cursor == nil or cursor == ""
end

fetch()

queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/Altarios477/brainrot.Script/main/ServerScanner.lua"))()')

if #servers > 0 then
	local target = servers[math.random(1,#servers)]
	TP:TeleportToPlaceInstance(id, target, game.Players.LocalPlayer)
end
