--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Interfaces} ---
local IProfile = require(Packages.ProfileStore.IProfileStore)

--- {Requires} ---
local ReplicaService = require(Packages.ReplicaServer)
local Validate = require(Packages.Validate)


local module = {}

function module.CreatedLeaderstats(Player: Player, Profile: IProfile.Type<any>)
    local Success = Validate:Params({{Player, "Instance"}, {Profile, "table"}})
    if not Success then return end

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