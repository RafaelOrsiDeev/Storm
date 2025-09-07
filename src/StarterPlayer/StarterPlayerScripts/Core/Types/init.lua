--- {Requires} ---
local ICall = require(script.Parent.Storm.Services.Call.ICall)
local IData = require(game:GetService("ReplicatedStorage").Types.IData)

--- {Interfaces} ---

local Types = {}

export type ServiceTypes = {
    Call: ICall.Type,
}

export type AttributesTypes = {
   Power: typeof(require(game:GetService("ReplicatedStorage").Types.Attributes.Power))
}

export type StormTypes = {
    Services: ServiceTypes,
    Attributes: AttributesTypes,
    CenterFrames: { [string]: Frame | ImageLabel },
    Init: (self: StormTypes) -> (),
    Player: Player,
    PlayerGui: PlayerGui,
    Data: IData.Type,
    [any]: any
}

return Types
