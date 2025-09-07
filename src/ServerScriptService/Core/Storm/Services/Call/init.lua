--- {Requires} ---
local Storm = require(script.Parent.Parent)

--- {Variables} ---
local RemoteEvent: RemoteEvent = game:GetService("ReplicatedStorage").Remotes.Event


local module = {}

function module:Fire(Player: Player, SendData: boolean, TableParam: {string}, ...)
    local success, ErrorMesage = Storm.Packages.Verification:ValidateParams({ {Player, "Instance"}, {SendData, "boolean"}, {TableParam, "table"}})
    if not success then 
        warn(ErrorMesage)
        return 
    end

    RemoteEvent:FireClient(Player, TableParam, ...)
end

function module:FireAll(TableParam: {string}, ...)
    local success, ErrorMesage = Storm.Packages.Verification:ValidateParams({{TableParam, "table"}})
    if not success then 
        warn(ErrorMesage)
        return 
    end

    RemoteEvent:FireAllClients(TableParam, ...)
end

function module:Server(TableParam: {string}, ...)
    local success, ErrorMesage = Storm.Packages.Verification:ValidateParams({{TableParam, "table"}})
    if not success then 
        warn(ErrorMesage)
        return 
    end

    local Module = Storm[TableParam[1]][TableParam[2]]
    if not Module then return end

    local Function = Module[TableParam[3]]
    if not Function or typeof(Function) ~= "function" then return end

    Function(...)

end

RemoteEvent.OnServerEvent:Connect(function(Player: Player, TableParam: {string}, ...)
    local successValidate, ErrorMesage = Storm.Packages.Verification:ValidateParams({ {Player, "Instance"}, {TableParam, "table"},})
    if not successValidate then 
        warn(ErrorMesage)
        return 
    end

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