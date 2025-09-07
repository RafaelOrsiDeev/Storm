--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- {Requires} ---
local IReplica = require(ReplicatedStorage.Packages.ReplicaServer.IReplicaServer)
local IData = require(ReplicatedStorage.PlayerUtils.Shared.TemplateData.IData)


local module = {}

export type ControllerType = typeof(require(script.Parent.Controller))

export type PlayerType = {
    Player: Player,
    Replica: IReplica.Type,
    Data: IData.Type,
} & ControllerType

export type Type = {
    GetPlayer: (Player: Player) -> PlayerType,
}

return module