--- {Variables} ---
local Core = game:GetService("ServerScriptService").Core
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = ReplicatedStorage.PlayerUtils


--- {Interfaces} ---
local IClasses = require(Core.Storm.Classes.IClasses)
local IServices = require(Core.Storm.Services.IServices)
local IShared = require(PlayerUtils.Shared.IShared)
local IMultipliers = require(PlayerUtils.Multipliers.IMultipliers)
local IPackages = require(ReplicatedStorage.Packages.IPackages)


local Types = {}

export type IVariables = {
    Multipliers: IMultipliers.Type,
    Shared: IShared.Type,
    Packages: IPackages.Type,
}

export type IFunctions = {
    Init: (self: typeof(Types)) -> (),
}

export type StormTypes = {
    Services: IServices.Type,
    Classes: IClasses.Type,
    
} & IFunctions & IVariables

return Types
