--- {Variables} ---
local Core = game:GetService("ServerScriptService").Core


-- {Interfaces} ---
local ICall = require(Core.Storm.Services.Call.ICall)
local IPlayer = require(Core.Storm.Services.Player.IPlayer)
local IProfile = require(Core.Storm.Services.ProfileService.IProfile)
local IReplica = require(Core.Storm.Services.Replica.IReplica)

local module = {}

export type Type = {
    Call: ICall.Type,
    Player: IPlayer.Type,
    Profile: IProfile.Type,
    Replica: IReplica.Type,
}

return module