-- {Interfaces} ---
local IData = require(game:GetService("ReplicatedStorage").Types.IData)

local module = {}

export type Type = {
    PlayerData: IData.Type,
}

return module