--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FolderToLoad = {
    script.Services, script.Classes,
}

--- {Requires} ---
local Multipliers = require(ReplicatedStorage.PlayerUtils.Multipliers)
local Types = require(game:GetService("ServerStorage").Types)


local Storm = {
    Classes = {},
    Services = {},
    Multipliers = Multipliers,
}

Storm.Shared = ReplicatedStorage.Shared
Storm.Packages = ReplicatedStorage.Packages

--- {Functions} ---

function Storm:Init()
    for _, Folder in FolderToLoad do
        for _, File in Folder:GetChildren() do
            if not File:IsA("ModuleScript") or File.Name == "I" .. Folder.Name then continue end

            task.spawn(function()
                local success, Module = pcall(require, File)
                if not success then return end

                Storm[Folder.Name][File.Name] = Module
            end)
        end
    end
end

return Storm :: Types.StormTypes