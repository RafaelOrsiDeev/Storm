--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- {Requires} ---
local IReplica = require(ReplicatedStorage.Packages.ReplicaServer.IReplicaServer)
local IData = require(ReplicatedStorage.PlayerUtils.Shared.TemplateData.IData)
local IMultipliers = require(ReplicatedStorage.PlayerUtils.Multipliers.IMultipliers)


local module = {}

export type IControllerType = {
    GetValue: (self: PlayerType, PathParam: {string | number}) -> any ,
    SetValue: (self: PlayerType, PathParam: {string | number}, Value: any) -> (),
    RemoveValue: (self: PlayerType, PathParam: {string | number}) -> (),
}

export type PlayerType = {
    Instance: Player,
    Replica: IReplica.Type,
    Data: IData.Type,
    Multipliers: IMultipliers.Type,
} & IControllerType

export type Type = {
    GetPlayer: (Player: Player) -> PlayerType,
}

return module