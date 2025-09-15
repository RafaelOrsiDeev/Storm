--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Storm = require(script.Parent.Parent.Parent)
local Validate = require(Packages.Validate)

local module = {}

function module:Save(Child: ImageLabel)
    local Success = Validate:Params({{Child, "Instance"}})
    if not Success then return end
    
    Child.Visible = false
    Storm.CenterFrames[Child.Name] = Child
end


return module