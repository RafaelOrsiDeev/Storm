local module = {}

export type Type = {
    New: (rate : number, is_full_wait : boolean?) -> Type,
    CheckRate: (self: Type, source: any) -> boolean,
    CleanSource: (self: Type, source: any) -> (),
    Cleanup: (self: Type) -> (),
    Destroy: (self: Type) -> (),
}

return module