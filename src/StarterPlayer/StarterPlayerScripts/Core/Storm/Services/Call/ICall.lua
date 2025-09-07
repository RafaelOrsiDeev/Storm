local ICall = {}

export type Type = {
    Fire: (TableParam: {string}, ...any) -> (),
    Server: (TableParam: {string}, ...any) -> (),
    ServerSelf: (TableParam: {string}, ...any) -> (),
}

return ICall