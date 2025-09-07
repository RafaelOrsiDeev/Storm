--- {Interfaces} ---
local IReplica = require(script.IReplica)
local IProfile = require(script.Parent.ProfileService.IProfile)

--- {Requires} ---
local ReplicaService  = require(game:GetService("ServerStorage").Packages.ReplicaServer) :: IReplica.ReplicaType


--- {Variables} ---

local module = {}

function module.CreateReplica(TokenName: string, Profile: IProfile.ProfileType): IReplica.ReplicaType?
    local TOKEN = ReplicaService.Token(TokenName)
    if not TOKEN or typeof(TOKEN) ~= "table" then return end

    local Replica = ReplicaService.New({
        Token = TOKEN,
        Data = Profile.Data
    })

    repeat task.wait() until ReplicaService.ReadyPlayers[Profile.Player]
    
    Replica:Subscribe(Profile.Player)

    module[TokenName] = Replica
    return Replica
end

function module.GetReplica(TokenName: string): IReplica.ReplicaTokenType?
    if not module[TokenName] then return end

    return module[TokenName]
end



return module