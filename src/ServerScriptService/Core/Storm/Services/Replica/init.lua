--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Interfaces} ---
local IReplica = require(Packages.ReplicaServer.IReplicaServer)
local IProfile = require(Packages.ProfileStore.IProfileStore)

--- {Requires} ---
local ReplicaService  = require(Packages.ReplicaServer) 
local Validate = require(Packages.Validate)


local module = {}

function module.CreateReplica(TokenName: string, Profile: IProfile.Type<any>): IReplica.Type?
    local SuccessParams = Validate:Params({{TokenName, "string"}, {Profile, "table"}})
    if not SuccessParams then return end

    local TOKEN = ReplicaService.Token(TokenName)
    local SuccessToken = Validate:Params({{TokenName, "string"}, {Profile, "table"}})
    if not SuccessToken then return end

    local Replica = ReplicaService.New({
        Token = TOKEN,
        Data = Profile.Data
    })

    repeat task.wait() until ReplicaService.ReadyPlayers[Profile.Player]
    
    Replica:Subscribe(Profile.Player)

    module[TokenName] = Replica
    return Replica
end

function module.GetReplica(TokenName: string): IReplica.Type?
    local Success = Validate:Params({{TokenName, "string"}})
    if not Success then return end

    if not module[TokenName] then return end

    return module[TokenName]
end



return module