--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

--- {Requires} ---
local Storm = require(script.Parent.Parent)
local ReplicaService = require(ReplicatedStorage.Packages.ReplicaClient)
local Validate = require(Packages.Validate)
local Handlers = require(script.Handlers)

--- {Interfaces} ---
local IReplica = require(Packages.ReplicaClient.IReplicaClient)

local module = {}


local function ChangeData(Replica: IReplica.Type)
   local Success = Validate:Params({{Replica, "table"}})
   if not Success then return end

   Replica:OnChange(function(_, Path, _, _)
      Handlers:ChangeData(Path)
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

return module