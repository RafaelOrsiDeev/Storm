--- {Requires} ---
require(script.Parent.ProfileService)
local Storm = require(script.Storm)

workspace:GetAttributeChangedSignal("ProfileLoaded"):Connect(function()
    Storm:Init()
end)