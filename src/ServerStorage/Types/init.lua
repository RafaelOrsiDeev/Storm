--- {Interfaces} ---
local IClasses = require(script.Classes)
local IServices = require(script.Services)
local IShared = require(script.Shared)
local Attributes = require(script.Attributes)


local Types = {}
export type StormTypes = {
    Services: IServices.Type,
    Classes: IClasses.Type,
    Shared: IShared.Type,
    Attributes: Attributes.Type,
    Init: (self: typeof(Types)) -> (),
}

return Types
