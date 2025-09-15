local ICall = {}

export type Type = {
    Fire: (Player: Player, TableParam: {string}, ...any) -> (),
    FireSelf: (Player: Player, TableParam: {string}, ...any) -> (),
    FireAll: (TableParam: {string}, ...any) -> (),
    FireAllSelf: (TableParam: {string}, ...any) -> (),
    Server: (TableParam: {string}, ...any) -> (),
    ServerSelf: (TableParam: {string}, ...any) -> (),
}

return ICall