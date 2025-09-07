--- {Interfaces} ---
local IData = require(game:GetService("ReplicatedStorage").Types.IData)

--- {Variables} ---
local module = {}


export type Signal = {
    Fire: (self: any, ...any) -> (),
    Connect: (self: any, listener: (...any) -> ()) -> {Disconnect: (self: any) -> ()},
}

export type ReplicaTokenType = {
    Name: string
}

export type ReplicaType = {
    Tags: {[any]: any},
    Data: IData.Type,
    Id: number,
    Token: string,
    Parent: ReplicaType?,
    Children: {[ReplicaType]: boolean?},
    BoundInstance: Instance?,
    OnServerEvent: {Connect: (self: any, listener: (Player, ...any) -> ()) -> ({Disconnect: (self: any) -> ()})},
    OnSet: Signal,
    Maid: any,

    Set: (self: any, path: {string}, value: any) -> (),
    SetValues: (self: any, path: {string}, values: {[string]: any}) -> (),
    TableInsert: (self: any, path: {string}, value: any, index: number?) -> (number),
    TableRemove: (self: any, path: {string}, index: number) -> (any),
    Write: (self: any, function_name: string, ...any) -> (...any),
    FireClient: (self: any, player: Player, ...any) -> (),
    FireAllClients: (self: any, ...any) -> (),
    UFireClient: (self: any, player: Player, ...any) -> (),
    UFireAllClients: (self: any, ...any) -> (),
    SetParent: (self: any, new_parent: ReplicaType) -> (),
    BindToInstance: (self: any, instance: Instance) -> (),
    Replicate: (self: any) -> (),
    DontReplicate: (self: any) -> (),
    Subscribe: (self: any, player: Player) -> (),
    Unsubscribe: (self: any, player: Player) -> (),
    Identify: (self: any) -> (string),
    IsActive: (self: any) -> (boolean),
    Destroy: (self: any) -> (),
}

export type ReplicaModule = {
    ReadyPlayers: {[Player]: boolean},
    NewReadyPlayer: Signal,
    RemovingReadyPlayer: Signal,
    
    Token: (name: string) -> ReplicaTokenType,
    New: (params: {Token: ReplicaTokenType, Tags: {}?, Data: {}?, WriteLib: ModuleScript?}) -> ReplicaType,
    FromId: (id: number) -> ReplicaType?,
    Test: () -> {
        Replicas: {[number]: ReplicaType},
        TopReplicas: {[ReplicaType]: boolean},
        ReplicationAllReplicas: {[ReplicaType]: boolean},
        SelectiveSubscriptions: {[Player]: {[ReplicaType]: boolean}}
    },
}


export type Type = {
    CreateReplica: (TokenName: string, Player: Player) -> ReplicaType,
    GetReplica: (TokenName: string) -> ReplicaType?,
}

return module
