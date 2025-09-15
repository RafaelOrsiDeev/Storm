local module = {}

export type Type = {
    Init: (self: Type) -> (),
}

return module