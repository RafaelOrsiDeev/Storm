local module = {}

export type Connection = {
	Disconnect: (self: Connection) -> (),
	IsConnected: boolean,
}

export type Type<T...> = {
	Connect: (self: Type<T...>, fn: (T...) -> ()) -> Connection,
	Wait: (self: Type<T...>) -> T...,
	Fire: (self: Type<T...>, T...) -> (),
	FireUntil: (self: Type<T...>, continue_callback: () -> boolean, T...) -> (),
}

return module