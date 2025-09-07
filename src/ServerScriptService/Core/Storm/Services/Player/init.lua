--- {Variables} ---
local Services = game:GetService("ServerScriptService").Core.Storm.Services
local PlayerUtils = game:GetService("ReplicatedStorage").PlayerUtils

--- {Requires} ---
local ReplicaService = require(Services.Replica)
local Controller = require(script.Controller)

--- {Interfaces} ---
local IData = require(PlayerUtils.Shared.TemplateData.IData)
local IReplica = require(Services.Replica.IReplica)
local IPlayer = require(script.IPlayer)

--- {Variables} ---
local Storage: {[Player]: IPlayer.PlayerType} = {}

local module = {}

--- {Functions} ---

function module._GetReplica(Player: Player): IReplica.Type
    local Profile = ReplicaService.GetProfile(Player)
    
    local DataReplica = ReplicaService.CreateReplica("PlayerData", Profile)
    
    return DataReplica
end

function module.GetPlayer(Player: Player): IPlayer.PlayerType
    return Storage[Player]
end

function module._New(Player: Player): IPlayer.PlayerType
    local self = setmetatable({}, {__index = Controller})
    
    self.Replica = module._GetReplica(Player)
    self.Data = (self.Replica.Data :: IData.Type)
    self.Player = Player

    Storage[Player] = self
    return self
end

function module._LoadFunctions(Player: IPlayer.PlayerType)

end

for _, Player in game:GetService("Players"):GetPlayers() do
    if Storage[Player] then continue end
    local PlayerObj = module._New(Player)

    module._LoadFunctions(PlayerObj)
end

game:GetService("Players").PlayerAdded:Connect(function(Player: Player)
    local PlayerObj = module._New(Player)

    module._LoadFunctions(PlayerObj)
end)



return module
