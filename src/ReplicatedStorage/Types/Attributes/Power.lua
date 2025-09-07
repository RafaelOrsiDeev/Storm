--- {Requires} ---
local DataTypes = require(script.Parent.Parent.IData)

--- {Interfaces} ---
type Idata = DataTypes.Type

local module = {}

function module.GetPower(Data: Idata): number
    local Power = 0

    return Power
end

return module