local module = {}

local IPlayer = require(game:GetService("ServerScriptService").Core.Types.IPlayer)
local IReplica = require(game:GetService("ServerScriptService").Core.Types.IReplica)
local IData = require(game:GetService("ReplicatedStorage").Types.IData)


export type Type = {
    Player: Player,
    Replica: IReplica.ReplicaType,
    Data: IData.Type,
    GetPlayer: (Player: Player) -> IPlayer.Type,
}

return module