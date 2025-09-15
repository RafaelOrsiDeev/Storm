--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerUtils = ReplicatedStorage.PlayerUtils


--- {Interfaces} ---
local IMultipliers = require(PlayerUtils.Multipliers.IMultipliers)


local Types = {}

export type IVariables = {
    Multipliers: IMultipliers.Type,
}

export type IFunctions = {
    Init: (self: typeof(Types)) -> (),
    GetModule: (self: typeof(Types), Folder: Folder, Path: string) -> ModuleScript?,
    GetModuleFromPath: (self: typeof(Types), Folder: Folder, TableParam: {string}) -> ModuleScript?,
}

export type StormTypes = {
    
} & IFunctions & IVariables

return Types
