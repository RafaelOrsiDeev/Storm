--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages
local Maid = require(Packages.Maid)

local module = {}

export type Type = {
	Tags: {[any]: any},
	Data: {[any]: any},
	Id: number,
	Token: string,
	Parent: Type?,
	Children: {[Type]: boolean?},
	BoundInstance: Instance?,
	OnServerEvent: {Connect: (self: any, listener: (Player, ...any) -> ()) -> ({Disconnect: (self: any) -> ()})},
	OnSet: {Connect: (self: any, listener: (Path: {string | number}, Value: number | string) -> ()) -> {Disconnect: (self: any) -> ()}},
	Maid: typeof(Maid),

	Set: (self: any, path: {string}, value: any) -> (),
	SetValues: (self: any, path: {string}, values: {[string]: any}) -> (),
	TableInsert: (self: any, path: {string}, value: any, index: number?) -> (number),
	TableRemove: (self: any, path: {string}, index: number) -> (any),
	Write: (self: any, function_name: string, ...any) -> (...any),
	FireClient: (self: any, player: Player, ...any) -> (),
	FireAllClients: (self: any, ...any) -> (),
	UFireClient: (self: any, player: Player, ...any) -> (),
	UFireAllClients: (self: any, ...any) -> (),
	SetParent: (self: any, new_parent: Type) -> (),
	BindToInstance: (self: any, instance: Instance) -> (),
	Replicate: (self: any) -> (),
	DontReplicate: (self: any) -> (),
	Subscribe: (self: any, player: Player) -> (),
	Unsubscribe: (self: any, player: Player) -> (),
	Identify: (self: any) -> (string),
	IsActive: (self: any) -> (boolean),
	Destroy: (self: any) -> (),
}

return module