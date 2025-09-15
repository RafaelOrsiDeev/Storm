--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage.Remotes.Event

--- {Folders} ---
local Packages = ReplicatedStorage.Packages
local StormFolder = game:GetService("Players").LocalPlayer.PlayerScripts.Core.Storm

--- {Requires} ---
local Validate = require(Packages.Validate)
local Storm = require(StormFolder)

local module = {}

function module:Fire(TableParam: {string}, ...)
    local Success = Validate:Params({{TableParam, "table"}})
    if not Success then return end

    RemoteEvent:FireServer(TableParam, ...)
end

function module:Client(TableParam: {string}, ...)
    local Success = Validate:Params({{TableParam, "table"}})
    if not Success then return end

    local Module = Storm[TableParam[1]][TableParam[2]]
    if not Module then return end

    local Function = Module[TableParam[3]]
    if not Function and typeof(Function) ~= "function" then return end

    Function(...)
end

RemoteEvent.OnClientEvent:Connect(function(TableParam: {string}, ...)
    local Success = Validate:Params({{TableParam, "table"}})
    if not Success then return end

    local Service = Storm[TableParam[1]]
    if not Service then return end
    local Module = Service[TableParam[2]]
    if not Module then return end

    local Function = Module[TableParam[3]]
    if not Function and typeof(Function) ~= "function" then return end

    Function(...)

end)

return module