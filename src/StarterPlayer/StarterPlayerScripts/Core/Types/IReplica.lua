local module = {}

export type SignalConnection = {
    Disconnect: (self: any) -> ()
}

export type SignalType = {
    Fire: (self: any, ...any) -> (),
    Connect: (self: any, listener: (...any) -> ()) -> SignalConnection,
}

export type ReplicaClient = {
    -- Properties
    Tags: {[any]: any},
    Data: {[any]: any},
    Id: number,
    Token: string,
    Parent: ReplicaClient?,
    Children: {[ReplicaClient]: boolean?},
    BoundInstance: Instance?,
    OnClientEvent: SignalType,
    Maid: typeof(require(game.ReplicatedStorage.Packages.ReplicaShared.Maid).New()),

    -- State tracking
    IsReady: boolean,
    OnLocalReady: SignalType,

    -- Event listeners
    OnSet: (self: any, path: {string | number}, listener: (new_value: any, old_value: any) -> ()) -> SignalConnection,
    OnWrite: (self: any, function_name: string, listener: (...any) -> ()) -> SignalConnection,
    OnChange: (self: any, listener: (action: "Set" | "SetValues" | "TableInsert" | "TableRemove", path: {string | number}, param1: any, param2: any?) -> ()) -> SignalConnection,

    -- Methods
    GetChild: (self: any, token: string) -> ReplicaClient?,
    FireServer: (self: any, ...any) -> (),
    UFireServer: (self: any, ...any) -> (),
    Identify: (self: any) -> string,
    IsActive: (self: any) -> boolean,

    -- Client-side mutation methods (via WriteLibs)
    Set: (self: any, path: {string | number}, value: any) -> (),
    SetValues: (self: any, path: {string | number}, values: {[string]: any}) -> (),
    TableInsert: (self: any, path: {string | number}, value: any, index: number?) -> number,
    TableRemove: (self: any, path: {string | number}, index: number) -> any,
    Write: (self: any, function_name: string, ...any) -> (...any),

    -- Static / class methods
    RequestData: () -> (),
    OnNew: (token: string, listener: (replica: ReplicaClient) -> ()) -> SignalConnection,
    FromId: (id: number) -> ReplicaClient?,
    Test: () -> {
        TokenReplicas: {[string]: {[ReplicaClient]: true}},
        Replicas: {[number]: ReplicaClient},
        BindReplicas: {[number]: ReplicaClient},
        BindInstances: {[number]: Instance}
    },
}


return module
