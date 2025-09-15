--- {Variables} ---
local Services = game:GetService("ServerScriptService").Core.Storm.Services
local PlayerUtils = game:GetService("ReplicatedStorage").PlayerUtils
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Multipliers = require(PlayerUtils.Multipliers)

--- {Services} ---
local ReplicaService = require(Services.Replica)
local ProfileService = require(Services.ProfileService)
local Controller = require(script.Controller)
local Validate = require(Packages.Validate)

--- {Interfaces} ---
local IData = require(PlayerUtils.Shared.TemplateData.IData)
local IReplica = require(Services.Replica.IReplica)
local IPlayer = require(script.IPlayer)

--- {Variables} ---
local Storage: {[Player]: IPlayer.PlayerType} = {}

local module = {}

--- {Functions} ---

function module._GetReplica(Player: Player): IReplica.Type?
    local Success = Validate:Params({{Player, "Instance"}})
    if not Success then return end

    local Profile = ProfileService.GetProfile(Player)
    local DataReplica = ReplicaService.CreateReplica("PlayerData", Profile)
    
    return DataReplica
end

function module.GetPlayer(Player: Player): IPlayer.PlayerType?
    local Success = Validate:Params({{Player, "Instance"}})
    if not Success then return end

    return Storage[Player]
end

function module._New(Player: Player): IPlayer.PlayerType?
    local Success = Validate:Params({{Player, "Instance"}})
    if not Success then 
        Player:Kick("Invalid player")
        return
    end

    local self = setmetatable({}, {__index = Controller})
    
    self.Replica = module._GetReplica(Player)
    self.Data = (self.Replica.Data :: IData.Type)
    self.Instance = Player
    self.Multipliers = Multipliers

    Storage[Player] = self
    return self
end

function module._LoadFunctions(Player: IPlayer.PlayerType)
    local Success = Validate:Params({{Player, "table"}})
    if not Success then return end

end

function module.Init()
    for _, Player in game:GetService("Players"):GetPlayers() do
        if Storage[Player] then continue end
    
        local PlayerObj = module._New(Player)
        local Success = Validate:Params({{PlayerObj, "table"}})
        if not Success then return end
    
        module._LoadFunctions(PlayerObj)
    end
    
    game:GetService("Players").PlayerAdded:Connect(function(Player: Player)
        local PlayerObj = module._New(Player)
        local Success = Validate:Params({{PlayerObj, "table"}})
        if not Success then return end
    
        module._LoadFunctions(PlayerObj)
    end)
end



return module
