local module = {}

export type Type = {
    Create: (self: Type, Rarity: string, Paths: {Instance}) -> (),
}

return module