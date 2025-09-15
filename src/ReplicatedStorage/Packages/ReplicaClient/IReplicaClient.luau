--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

local Maid = require(Packages.Maid)
local Signal = require(Packages.Signal)

local module = {}


export type Type = {
	Tags: {[any]: any},
	Data: {[any]: any},
	Id: number,
	Token: string,
	Parent: Type?,
	Children: {[Type]: boolean?},
	BoundInstance: Instance?,
	OnClientEvent: {Connect: (self: any, listener: (...any) -> ()) -> ({Disconnect: (self: any) -> ()})},
	Maid: typeof(Maid),

	OnSet: (self: any, path: {}, listener: () -> ()) -> (Signal.Connection),
	OnWrite: (self: any, function_name: string, listener: (...any) -> ()) -> (Signal.Connection),
	OnChange: (self: any, listener: (action: "Set" | "SetValues" | "TableInsert" | "TableRemove", path: {any}, param1: any, param2: any?) -> ()) -> (Signal.Connection),
	GetChild: (self: any, token: string) -> (Type?),
	FireServer: (self: any, ...any) -> (),
	UFireServer: (self: any, ...any) -> (),
	Identify: (self: any) -> (string),
	IsActive: (self: any) -> (boolean),
}

return module
