local module = {}

export type FunctionsType = {
    ConnectionButtons: (self: ClassType) -> (),
}

export type ClassType = {
    TypeName: string,
    Instance: Instance,
    AnimationFolder: Folder,
} & FunctionsType

return module