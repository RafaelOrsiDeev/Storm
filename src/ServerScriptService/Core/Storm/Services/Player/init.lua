--- {Requires} ---
local ReplicaService = require(script.Parent.Replica)
local Controller = require(script.Controller)

--- {Interfaces} ---
local IPlayer = require(game:GetService("ServerScriptService").Core.Types.IPlayer)
local IData = require(game:GetService("ReplicatedStorage").Types.IData)
local IReplica = require(game:GetService("ServerScriptService").Core.Types.IReplica)

--- {Variables} ---
local Storage: {[Player]: IPlayer.Type} = {}

local module = {}

--- {Functions} ---

function module._GetReplica(Player: Player): IReplica.ReplicaType
    local DataReplica = ReplicaService.CreateReplica("PlayerData", Player)
    
    return DataReplica
end

function module.GetPlayer(Player: Player): IPlayer.Type
    return Storage[Player]
end

function module._New(Player: Player): IPlayer.Type
    local self = setmetatable({}, {__index = Controller})

    self.Replica = module._GetReplica(Player)
    self.Data = (self.Replica.Data :: IData.Type)
    self.Player = Player


    Storage[Player] = self
    return self
end

function module._LoadFunctions(Player: IPlayer.Type)

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
