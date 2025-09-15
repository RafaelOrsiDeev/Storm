--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Interfaces} ---
local IReplicaServer = require(Packages.ReplicaServer.IReplicaServer)


local module = {}


export type Type = {
    CreateReplica: (TokenName: string, Player: Player) -> IReplicaServer.Type,
    GetReplica: (TokenName: string) -> IReplicaServer.Type?,
}

return module
