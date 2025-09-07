local module = {}

export type MaidToken = {
	Destroy: (self: MaidToken) -> (),
	Cleanup: (self: MaidToken, ...any) -> (),
}

export type Type = {
	IsActive: (self: Type) -> (boolean),
	Add: (self: Type, object: any) -> MaidToken,
	Cleanup: (...any) -> (),
}

return module