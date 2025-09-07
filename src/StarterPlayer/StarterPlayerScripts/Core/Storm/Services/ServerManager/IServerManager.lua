--- {Requires} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local module = {}

local IData = require(ReplicatedStorage.Types.IData)

export type Profiles = { [Player]: {Replica: typeof(require(ReplicatedStorage.Packages.ReplicaClient)), Profile: typeof(require(ServerScriptService.ProfileService.ProfileStore))} }

export type Type = {
    GetData: () -> IData.Type,
}

return module