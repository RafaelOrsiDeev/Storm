--- {Interfaces} ---
local IClasses = require(script.Classes.Classes)
local IServices = require(script.Classes.Services)
local IShared = require(script.Classes.Shared)


local Types = {}


export type AttributesTypes = {
   Power: typeof(require(game:GetService("ReplicatedStorage").Types.Attributes.Power))
}

export type StormTypes = {
    Services: IServices.Type,
    Classes: IClasses.Type,
    Shared: IShared.Type,
    Attributes: AttributesTypes,
    Init: (self: typeof(Types)) -> (),
}

return Types
