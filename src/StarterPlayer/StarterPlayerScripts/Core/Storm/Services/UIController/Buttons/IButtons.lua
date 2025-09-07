local module = {}

export type ModuleType = {
    Init: (Button: TextButton | ImageButton) -> (),
}

export type ClassType = {
    Hud: ModuleType,
    Close: ModuleType,
}

export type Type = {
    New: (Button: Frame) -> (),
    Class: ClassType,
}

return module