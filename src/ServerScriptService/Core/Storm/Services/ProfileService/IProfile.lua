--- {Interfaces} ---
local IData = require(game:GetService("ReplicatedStorage").PlayerUtils.Shared.TemplateData.IData)

local module = {}


export type Signal = {
    Fire: (self: any, ...any) -> (),
    Connect: (self: any, listener: (...any) -> ()) -> {Disconnect: (self: any) -> ()},
}

export type ProfileType = {
    Player: Player,
    Data: IData.Type,
    IsActive: boolean,
    Released: boolean,
    
    OnChanged: Signal,
    OnRelease: Signal,

    Update: (self: ProfileType, path: {string}, value: any) -> (),
    UpdateValues: (self: ProfileType, path: {string}, values: {[string]: any}) -> (),
    Release: (self: ProfileType) -> (),
}

export type ProfileStoreModule = {
    StoreName: string,
    Profiles: {[Player]: ProfileType},

    LoadProfile: (self: ProfileStoreModule, player: Player) -> ProfileType?,
    GetProfile: (self: ProfileStoreModule, player: Player) -> ProfileType?,
    ReleaseProfile: (self: ProfileStoreModule, player: Player) -> (),
    SaveProfile: (self: ProfileStoreModule, player: Player) -> (),
    
    ProfileLoaded: Signal,
    ProfileReleased: Signal,
}

export type Type = {
    GetProfile: (Player: Player) -> ProfileType,
}

return module
