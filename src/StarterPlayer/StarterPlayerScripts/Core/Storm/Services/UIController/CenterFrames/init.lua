--- {Requires} ---
local Storm = require(script.Parent.Parent.Parent)
local Validator = require(game:GetService("ReplicatedStorage").Packages.Verification)

local module = {}

function module:Save(Child: ImageLabel)
    local Success, Error = Validator.ValidateParams({ {Child, "Instance"} })
    if not Success then
        warn(Error)
        return
    end
    
    Child.Visible = false
    Storm.CenterFrames[Child.Name] = Child
end


return module