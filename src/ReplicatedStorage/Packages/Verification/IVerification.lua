local module = {}

export type Type = {
    ValidateParams: (self: Type, params: { { [number]: any } }) -> (boolean, string?),
}

return module