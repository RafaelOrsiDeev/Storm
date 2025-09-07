--- {Requires} ---
local Idata = require(game:GetService("ReplicatedStorage").Types.IData)

--- {Interfaces} ---
type Idata = Idata.Type

local module = {}

export type Type = {
    Data: Idata,
    Player: Player,
}


return module
