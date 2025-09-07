--- {Requires} ---
local Idata = require(game:GetService("ReplicatedStorage").Types.IData)
local IReplica = require(game:GetService("ServerScriptService").Core.Types.IReplica)

--- {Interfaces} ---
type Idata = Idata.Type

local module = {}

export type Type = {
    Data: Idata,
    Player: Player,
    Replica: IReplica.ReplicaType,
}


return module
