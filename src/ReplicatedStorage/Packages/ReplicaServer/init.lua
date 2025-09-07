--- {Requires} ---
local ReplicaService = require(script.Lib)
local Signal = require(game:GetService("ReplicatedStorage").Packages.Signal)


local OnSet = Signal.New()
ReplicaService.OnSet = OnSet

local OldSet = ReplicaService.Set

function ReplicaService:Set(path: {string | number}, value: string | number)
    OldSet(self, path, value)
    
    OnSet:Fire(path, value)
end


return ReplicaService