-- {Interfaces} ---
local ICall = require(game:GetService("ServerScriptService").Core.Storm.Services.Call.ICall)
local IPlayer = require(game:GetService("ServerScriptService").Core.Storm.Services.Player.IPlayer)

local module = {}

export type Type = {
    Call: ICall.Type,
    Player: IPlayer.Type,
}

return module