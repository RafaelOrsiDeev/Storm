--- {Variables} ---
local RemoteEvent: RemoteEvent = game:GetService("ReplicatedStorage").Remotes.Event
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Folders} ---
local StormFolder = game:GetService("ServerScriptService").Core.Storm

--- {Requires} ---
local Validate = require(Packages.Validate)
local PlayerModule = require(StormFolder.Services.Player)
local Storm = require(StormFolder)

local module = {}

function module:Fire(Player: Player, TableParam: {string}, ...)
    local Success = Validate:Params({{Player, "Instance"}, {TableParam, "table"}})
    if not Success then return end

    RemoteEvent:FireClient(Player, TableParam, ...)
end

function module:FireAll(TableParam: {string}, ...)
    local Success = Validate:Params({{TableParam, "table"}})
    if not Success then return end

    RemoteEvent:FireAllClients(TableParam, ...)
end

function module:Server(TableParam: {string}, ...)
    local Success = Validate:Params({{TableParam, "table"}})
    if not Success then return end
    local Path = table.concat(TableParam, ".")

    local Function = require(Storm:GetModuleFromPath(StormFolder, Path))
    if not Function or typeof(Function) ~= "function" then return end

    Function(...)

end

RemoteEvent.OnServerEvent:Connect(function(Player: Player, Path: {string}, ...)
    local Success = Validate:Params({{Player, "Instance"}, {Path, "table"}})
    if not Success then return end
    
    local FunctionTable = Storm:GetModuleFromPath(StormFolder, Path)
    if not FunctionTable and typeof(FunctionTable) ~= "table" and not FunctionTable.Function and typeof(FunctionTable.Function) ~= "function" and not FunctionTable.Client then return end
    
    if FunctionTable.Cooldown.Cache == nil then 
        FunctionTable.Cooldown.Cache = {}
    end

    if FunctionTable.Cooldown.Cache[Player.UserId] then return end

    if FunctionTable.Cooldown.Time > 0 then
        FunctionTable.Cooldown.Cache[Player.UserId] = true
        task.delay(FunctionTable.Cooldown.Time, function()
            FunctionTable.Cooldown.Cache[Player.UserId] = nil
        end)
    end

    local PlayerObj = PlayerModule.GetPlayer(Player)
    FunctionTable.Function(PlayerObj, ...)

end)


return module