--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages
local Storm = require(script.Parent.Parent.Parent)


--- {Requires} ---
local Validate = require(Packages.Validate)

local module = {}

function module:ChangeData(PathParam: {string | number})
    local Success = Validate:Params({{PathParam, "table"}})
    if not Success then return end

    local Path = table.concat(PathParam, ".")

    if Path["1"] == "Power" then
        print("Oi")
    end
end


return module