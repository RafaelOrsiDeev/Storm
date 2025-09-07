--- {Variables} ---
local Packages = script.Parent

--- {Interfaces} ---
local IConnectionManager = require(Packages.ConnectionManager.IConnectionManager)
local IFormat = require(Packages.Format.IFormat)
local IMaid = require(Packages.Maid.IMaid)
local IRateLimit = require(Packages.RateLimit.IRateLimit)
local IRemote = require(Packages.Remote.IRemote)
local ISignal = require(Packages.Signal.ISignal)
local IVerification = require(Packages.Verification.IVerification)
local IReplicaClient = require(Packages.ReplicaClient.IReplicaClient)
local IReplicaServer = require(Packages.ReplicaServer.IReplicaServer)
local IProfileStore = require(Packages.ProfileStore.IProfileStore)

local module = {}

export type Type = {
    ConnectionManager:IConnectionManager.Type,
    Format: IFormat.Type,
    Maid: IMaid.Type,
    RateLimit: IRateLimit.Type,
    Remote: IRemote.Type,
    Signal: ISignal.Type<>,
    Verification: IVerification.Type,
    ReplicaClient: IReplicaClient.Type,
    ReplicaServer: IReplicaServer.Type,
    ProfileStore: IProfileStore.Type<any>,
}

return module