local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Storm = require(script.Storm)


if Player.Character then
    Storm:Init()
end

Player.CharacterAdded:Wait()
Storm:Init()
