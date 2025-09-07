--- {Requires} ---
local ReplicaService = require(game:GetService("ServerStorage").Packages.ReplicaServer)
local Profiles = require(game:GetService("ServerStorage").ProfilesData)

--- {Interfaces} ---
local IProfile = require(game:GetService("ReplicatedStorage").Types.IProfile)

--- {Variables} ---

local module = {}

function module.CreateReplica(TokenName: string, Player: Player)
    local TOKEN = ReplicaService.Token(TokenName)
    local Profile = (Profiles[Player] :: IProfile.ProfileType)

    local Replica = ReplicaService.New({
        Token = TOKEN,
        Data = Profile.Data
    })

    repeat task.wait() until ReplicaService.ReadyPlayers[Player]
    Replica:Subscribe(Player)

    return Replica
end



return module