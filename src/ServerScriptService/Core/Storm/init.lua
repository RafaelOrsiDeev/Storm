--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FolderToLoad = {
    ReplicatedStorage.Shared, script.Services, script.Classes,
}

--- {Requires} ---
local Attributes = require(ReplicatedStorage.Types.Attributes)
local Types = require(game:GetService("ServerStorage").Types)


local Storm = {
    Classes = {},
    Services = {},
    Shared = {},
    Attributes = Attributes,
}


--- {Functions} ---

function Storm:Init()
    for _, Folder in FolderToLoad do
        for _, File in Folder:GetChildren() do
            if not File:IsA("ModuleScript") then continue end

            task.spawn(function()
                local success, Module = pcall(require, File)
                if not success then return end

                Storm[Folder.Name][File.Name] = Module
            end)
        end
    end
end

return Storm :: Types.StormTypes