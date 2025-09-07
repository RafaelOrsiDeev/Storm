--- {Requires} ---

--- {Interfaces} ---
local IProfile = require(game:GetService("ReplicatedStorage").Types.IProfile)

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
end

return module