local module = {}

--- {Variables} ---
local PlayerUtils = game:GetService("ReplicatedStorage").PlayerUtils

--- {Interfaces} ---
local IData = require(PlayerUtils.Shared.TemplateData.IData)

export type Type = {
    PlayerData: IData.Type,
}

return module