--- {Variables} ---
local ServerScriptService = game:GetService("ServerScriptService")

--- {Requires} ---
local IReplica = require(ServerScriptService.Core.Storm.Services.Replica.IReplica)
local IData = require(game:GetService("ReplicatedStorage").Types.IData)


local module = {}

export type ControllerType = typeof(require(script.Parent.Controller))

export type PlayerType = {
    Player: Player,
    Replica: IReplica.ReplicaType,
    Data: IData.Type,
} & ControllerType

export type Type = {
    GetPlayer: (Player: Player) -> PlayerType,
}

return module