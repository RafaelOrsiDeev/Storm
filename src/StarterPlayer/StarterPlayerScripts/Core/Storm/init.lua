--- {Requires} ---
local Attributes = require(game:GetService("ReplicatedStorage").Types.Attributes)
local Types = require(game:GetService("StarterPlayer").StarterPlayerScripts.Core.Types)

local Storm = {
    Services = {},
    Attributes = Attributes,
    CenterFrames = {},
    Data = {},
    PlayerReplica = {},
}

--- {Variables} ---
local FolderToLoad = {
    script.Services
}

Storm.Player = game:GetService("Players").LocalPlayer
Storm.PlayerGui = Storm.Player.PlayerGui

--- {Functions} ---

function Storm:Init()
    for _, Folder in FolderToLoad do
        for _, File in Folder:GetChildren() do
            if not File:IsA("ModuleScript") then continue end

            task.spawn(function()
                local Success, Module = pcall(require, File)
                if not Success then return end

                Storm[Folder.Name][File.Name] = Module
            end)
        end
    end
end

return Storm :: Types.StormTypes