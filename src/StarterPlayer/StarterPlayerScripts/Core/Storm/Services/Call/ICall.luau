local ICall = {}

export type Type = {
    Fire: (self: Type, TableParam: {string}, ...any) -> (),
    Server: (self: Type, TableParam: {string}, ...any) -> (),
    ServerSelf: (self: Type, TableParam: {string}, ...any) -> (),
}

return ICall