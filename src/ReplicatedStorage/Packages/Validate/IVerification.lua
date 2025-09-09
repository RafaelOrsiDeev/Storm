local module = {}

export type Type = {
    Params: (self: Type, params: { { any } }) -> (boolean),
}

return module