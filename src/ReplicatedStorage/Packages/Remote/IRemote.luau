local module = {}

export type Type = {
    New: (name: string, is_unreliable: boolean?) -> RemoteEvent,
    FireServer: (self: Type, ...any) -> (),
    FireClient: (self: Type, ...any) -> (),
    FireAllClients: (self: Type, ...any) -> (),
}

return module