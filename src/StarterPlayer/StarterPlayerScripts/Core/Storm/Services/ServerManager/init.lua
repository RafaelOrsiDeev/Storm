--- {Requires} ---
local Storm = require(script.Parent.Parent)
local ReplicaService = require(game:GetService("ReplicatedStorage").Packages.ReplicaClient)

--- {Interfaces} ---
local IReplica = require(game:GetService("StarterPlayer").StarterPlayerScripts.Core.Types.IReplica)

local module = {}


local function ChangeData(Replica: IReplica.ReplicaClient)
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