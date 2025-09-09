--- {Requires} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Interfaces} ---
local IProfileStore = require(Packages.ProfileStore.IProfileStore)

local module = {}


export type Type = {
    GetProfile: (Player: Player) -> IProfileStore.Type<any>,
}

return module
