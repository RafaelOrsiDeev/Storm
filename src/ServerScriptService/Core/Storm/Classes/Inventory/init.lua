--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Validate = require(Packages.Validate)


local module = {}
module.__index = module

function module.New(Name: string, DataKey: string)
    local Success = Validate:Params({{Name, "string"}, {DataKey, "string"}})
    if not Success then return end

    local self = setmetatable({}, module)
    self.Name = Name
    self.DataKey = DataKey
    
    return self
end


return module