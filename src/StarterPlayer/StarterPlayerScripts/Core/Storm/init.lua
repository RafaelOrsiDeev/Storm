--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FolderToLoad = {
    ReplicatedStorage.Shared, script.Services,
}
local PlayerUtils = ReplicatedStorage.PlayerUtils

--- {Requires} ---
local Multipliers = require(PlayerUtils.Multipliers)
local Types = require(game:GetService("StarterPlayer").StarterPlayerScripts.Core.Types)

local Storm = {
    Services = {},
    Multipliers = Multipliers,
    CenterFrames = {},
    Data = {},
    PlayerReplica = {},
}


Storm.Player = game:GetService("Players").LocalPlayer
Storm.PlayerGui = Storm.Player.PlayerGui
Storm.Shared = PlayerUtils.Shared
Storm.Packages = ReplicatedStorage.Packages


--- {Functions} ---

function Storm:Init()
    for _, Folder in FolderToLoad do
        for _, File in Folder:GetChildren() do
            if not File:IsA("ModuleScript") or File.Name == "I" .. Folder.Name then continue end

            task.spawn(function()
                local Success, Module = pcall(require, File)
                if not Success then return end

                Storm[Folder.Name][File.Name] = Module
            end)
        end
    end
end

return Storm :: Types.StormTypes