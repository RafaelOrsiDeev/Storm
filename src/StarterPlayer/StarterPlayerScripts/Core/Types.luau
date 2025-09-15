-- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = ReplicatedStorage.PlayerUtils
local Packages = ReplicatedStorage.Packages

--- {Interfaces} ---
local IMultipliers = require(PlayerUtils.Multipliers.IMultipliers)
local IData = require(PlayerUtils.Shared.TemplateData.IData)
local IReplica = require(Packages.ReplicaClient.IReplicaClient)


local Types = {}

export type IFunctions = {
    Init: (self: StormTypes) -> (),
    GetModule: (self: StormTypes, Folder: Folder, Path: string) -> ModuleScript?,
}

export type IVariables = {
    Player: Player,
    PlayerGui: PlayerGui,
}


export type StormTypes = {
    CenterFrames: { [string]: ImageLabel },
    Multipliers: IMultipliers.Type,
    Data: IData.Type,
    PlayerReplica: IReplica.Type,
} & IFunctions & IVariables

return Types
