local function applySoftNoclip()
    local char = game.Players.LocalPlayer.Character
    if not char then return end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Velocity = Vector3.new(0, 0, 0)
            v.RotVelocity = Vector3.new(0, 0, 0)
            v.CanCollide = false
        end
    end
end

game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled then
        applySoftNoclip()
    end
end)
