local module = {}

--- {Variables} ---
local Shared = game:GetService("ReplicatedStorage").PlayerUtils.Shared

--- {Interfaces} ---
local IData = require(Shared.TemplateData.IData)

export type Type = {
    TemplateData: IData.Type,
}

return module