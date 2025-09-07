--- {Requires} ---
local Storm = require(script.Parent.Parent)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicaService = require(ReplicatedStorage.Packages.ReplicaClient)

--- {Interfaces} ---
local IReplica = require(ReplicatedStorage.Packages.ReplicaClient.IReplica)

local module = {}


local function ChangeData(Replica: IReplica.Type)
   Replica:OnChange(function(_, Path, _, _)
      
   end)
end

function module.Init()
   ReplicaService.RequestData()
   
   ReplicaService.OnNew("PlayerData", function(Replica)
      Storm.Data = Replica.Data
      Storm.PlayerReplica = Replica
      ChangeData(Replica)
   end)
end

module.Init()

return module