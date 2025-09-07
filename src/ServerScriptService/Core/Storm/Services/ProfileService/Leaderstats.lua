--- {Interfaces} ---
local IReplica = require(script.Parent.Parent.Replica.IReplica)
local IProfile = require(script.Parent.IProfile)

--- {Requires} ---
local ReplicaService = require(game:GetService("ServerStorage").Packages.ReplicaServer) :: IReplica.ReplicaModule

--- {Variables} ---


local module = {}

function module.CreatedLeaderstats(Player: Player, Profile: IProfile.ProfileType)
    local Leaderstats = Instance.new("Folder")
    Leaderstats.Name = "leaderstats"
    Leaderstats.Parent = Player
    
    local Power = Instance.new("IntValue")
    Power.Name = "Power"
    Power.Value = Profile.Data.Power
    Power.Parent = Leaderstats

    ReplicaService.OnSet:Connect(function(Path, Value)
        if Path[1] == "Power" then
            Power.Value = Value
        end
    end)
end

return module