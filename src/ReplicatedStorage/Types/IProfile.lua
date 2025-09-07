--- {Interfaces} ---
local IData = require(game:GetService("ReplicatedStorage").Types.IData)

local module = {}


-- Tipagem de Signal simplificada
export type Signal = {
    Fire: (self: any, ...any) -> (),
    Connect: (self: any, listener: (...any) -> ()) -> {Disconnect: (self: any) -> ()},
}

-- Tipagem de Profile
export type ProfileType = {
    Player: Player,
    Data: IData.Type,
    IsActive: boolean,
    Released: boolean,
    
    -- Eventos
    OnChanged: Signal,
    OnRelease: Signal,

    -- Métodos
    Update: (self: ProfileType, path: {string}, value: any) -> (),
    UpdateValues: (self: ProfileType, path: {string}, values: {[string]: any}) -> (),
    Release: (self: ProfileType) -> (),
}

-- Tipagem do ProfileStore
export type ProfileStoreModule = {
    StoreName: string,
    Profiles: {[Player]: ProfileType},

    -- Métodos
    LoadProfile: (self: ProfileStoreModule, player: Player) -> ProfileType?,
    GetProfile: (self: ProfileStoreModule, player: Player) -> ProfileType?,
    ReleaseProfile: (self: ProfileStoreModule, player: Player) -> (),
    SaveProfile: (self: ProfileStoreModule, player: Player) -> (),
    
    -- Eventos globais
    ProfileLoaded: Signal,
    ProfileReleased: Signal,
}

return module
