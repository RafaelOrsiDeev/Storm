--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages
local ScriptsFolder = game:GetService("Players").LocalPlayer.PlayerScripts.Core.Storm.Scripts

--- {Requires} ---
local PetsModule = require(ScriptsFolder.Inventory.Pets)


--- {Requires} ---
local Validate = require(Packages.Validate)

local module = {}

function module:ChangeData(PathParam: {string | number})
    local Success = Validate:Params({{PathParam, "table"}})
    if not Success then return end
    
    if PathParam[1] == "Pets" then
        PetsModule.AddItemTopUpdate(tostring(PathParam[2]))
    end
end


return module