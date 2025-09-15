--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Validate = require(Packages.Validate)

--- {Interfaces} ---
local IPlayer = require(script.Parent.IPlayer)

local module = {}

function module:GetValue(PathParam: {string | number})
    local Success = Validate:Params({{PathParam, "table"}})
    if not Success then return end

    local CurrentValue = self.Data
    for _, Path in PathParam do
        CurrentValue = CurrentValue[Path]
    end

    return CurrentValue
end

function module:SetValue(PathParam: {string | number}, Value: any)
    local Success = Validate:Params({{PathParam, "table"}})
    if not Success then return end
    self = self :: IPlayer.PlayerType

    self.Replica:Set(PathParam, Value)
end

function module:RemoveValue(PathParam: {string | number})
    local Success = Validate:Params({{PathParam, "table"}})
    if not Success then return end
    self = self :: IPlayer.PlayerType

    local Path = table.concat(PathParam, ".")
    self.Data[Path] = nil

    self:SetValue(PathParam, self.Data[Path])
end

return module