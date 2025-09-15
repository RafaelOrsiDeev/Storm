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

    ReplicaService.OnSet:Connect(function(Path, Value)
        
    end)
end

return module