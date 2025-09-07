--- {Requires} ---
local Verification = require(game:GetService("ReplicatedStorage").Packages.Verification)
local RemoteEvent: RemoteEvent = game:GetService("ReplicatedStorage").Remotes.Event
local Storm = require(script.Parent.Parent)

local module = {}

function module:Fire(TableParam: {string}, ...)
    local successValidate, ErrorMesage = Verification.ValidateParams({ {TableParam, "table"},})
    if not successValidate then 
        warn(ErrorMesage)
        return 
    end

    RemoteEvent:FireServer(TableParam, ...)
end

function module:Client(TableParam: {string}, ...)
    local successValidate, ErrorMesage = Verification.ValidateParams({ {TableParam, "table"},})
    if not successValidate then 
        warn(ErrorMesage)
        return 
    end

    local Module = Storm[TableParam[1]][TableParam[2]]
    if not Module then return end

    local Function = Module[TableParam[3]]
    if not Function and typeof(Function) ~= "function" then return end

    Function(...)
end

RemoteEvent.OnClientEvent:Connect(function(TableParam: {string}, ...)
    local successValidate, ErrorMesage = Verification.ValidateParams({ {TableParam, "table"},})
    if not successValidate then 
        warn(ErrorMesage)
        return 
    end

    local Service = Storm[TableParam[1]]
    if not Service then return end
    local Module = Service[TableParam[2]]
    if not Module then return end

    local Function = Module[TableParam[3]]
    if not Function and typeof(Function) ~= "function" then return end

    Function(...)

end)

return module