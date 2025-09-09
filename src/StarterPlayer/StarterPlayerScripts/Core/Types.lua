-- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = ReplicatedStorage.PlayerUtils
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts").Core

--- {Interfaces} ---
local IServices = require(Core.Storm.Services.IServices)
local IScripts = require(Core.Storm.Scripts.IScripts)
local IShared = require(PlayerUtils.Shared.IShared)
local IMultipliers = require(PlayerUtils.Multipliers.IMultipliers)
local IData = require(PlayerUtils.Shared.TemplateData.IData)
local IReplica = require(Packages.ReplicaClient.IReplicaClient)


local Types = {}

export type IFunctions = {
    Init: (self: StormTypes) -> (),
}

export type IVariables = {
    Player: Player,
    PlayerGui: PlayerGui,
    Shared: IShared.Type,
}


export type StormTypes = {
    Services: IServices.Type,
    Scripts: IScripts.Type,
    CenterFrames: { [string]: Frame | ImageLabel },
    Multipliers: IMultipliers.Type,
    Data: IData.Type,
    PlayerReplica: IReplica.Type,
} & IFunctions & IVariables

return Types
