-- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = ReplicatedStorage.PlayerUtils
local Core = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts").Core

--- {Interfaces} ---
local IServices = require(Core.Storm.Services.IServices)
local IShared = require(PlayerUtils.Shared.IShared)
local IPackages = require(ReplicatedStorage.Packages.IPackages)
local IMultipliers = require(PlayerUtils.Multipliers.IMultipliers)
local IData = require(PlayerUtils.Shared.TemplateData.IData)
local IReplica = require(ReplicatedStorage.Packages.ReplicaClient.IReplica)



local Types = {}

export type IFunctions = {
    Init: (self: StormTypes) -> (),
}

export type IVariables = {
    Player: Player,
    PlayerGui: PlayerGui,
    Shared: IShared.Type,
    Packages: IPackages.Type,
}


export type StormTypes = {
    Services: IServices.Type,
    CenterFrames: { [string]: Frame | ImageLabel },
    Multipliers: IMultipliers.Type,
    Data: IData.Type,
    PlayerReplica: IReplica.Type,
} & IFunctions & IVariables

return Types
