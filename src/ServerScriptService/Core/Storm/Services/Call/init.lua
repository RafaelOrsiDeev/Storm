--- {Variables} ---
local RemoteEvent: RemoteEvent = game:GetService("ReplicatedStorage").Remotes.Event
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Storm = require(script.Parent.Parent)
local Validate = require(Packages.Validate)

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

    local Module = Storm[TableParam[1]][TableParam[2]]
    if not Module then return end

    local Function = Module[TableParam[3]]
    if not Function or typeof(Function) ~= "function" then return end

    Function(...)

end

RemoteEvent.OnServerEvent:Connect(function(Player: Player, TableParam: {string}, ...)
    local Success = Validate:Params({{Player, "Instance"}, {TableParam, "table"}})
    if not Success then return end


    local Module = Storm[TableParam[1]][TableParam[2]]
    if not Module then return end

    local FunctionTable = Module[TableParam[3]]
    if not FunctionTable and typeof(FunctionTable) ~= "table" and not FunctionTable.Function and typeof(FunctionTable.Function) ~= "function" and not FunctionTable.Client then return end
    
    if not FunctionTable.Cooldown.Cache then 
        FunctionTable.Cooldown.Cache = {}
    end

    if FunctionTable.Cooldown.Cache[Player.UserId] then return end

    if FunctionTable.Cooldown.Time > 0 then
        FunctionTable.Cooldown.Cache[Player.UserId] = true
        task.delay(FunctionTable.Cooldown.Time, function()
            FunctionTable.Cooldown.Cache[Player.UserId] = nil
        end)
    end

    local PlayerObj = Storm.Services.Player.GetPlayer(Player)

    FunctionTable.Function(PlayerObj, ...)


end)


return module