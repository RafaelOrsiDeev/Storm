local module = {}

export type JSONAcceptable = { JSONAcceptable } | { [string]: JSONAcceptable } | number | string | boolean | buffer

export type Type<T> = {
	Data: T & JSONAcceptable,
	LastSavedData: T & JSONAcceptable,
	FirstSessionTime: number,
	SessionLoadCount: number,
	Session: {PlaceId: number, JobId: string}?,
	RobloxMetaData: JSONAcceptable,
	UserIds: {number},
	KeyInfo: DataStoreKeyInfo,
	OnSave: {Connect: (self: any, listener: () -> ()) -> ({Disconnect: (self: any) -> ()})},
	OnLastSave: {Connect: (self: any, listener: (reason: "Manual" | "External" | "Shutdown") -> ()) -> ({Disconnect: (self: any) -> ()})},
	OnSessionEnd: {Connect: (self: any, listener: () -> ()) -> ({Disconnect: (self: any) -> ()})},
	OnAfterSave: {Connect: (self: any, listener: (last_saved_data: T & JSONAcceptable) -> ()) -> ({Disconnect: (self: any) -> ()})},
	ProfileStore: JSONAcceptable,
	Key: string,

	IsActive: (self: any) -> (boolean),
	Reconcile: (self: any) -> (),
	EndSession: (self: any) -> (),
	AddUserId: (self: any, user_id: number) -> (),
	RemoveUserId: (self: any, user_id: number) -> (),
	MessageHandler: (self: any, fn: (message: JSONAcceptable, processed: () -> ()) -> ()) -> (),
	Save: (self: any) -> (),
	SetAsync: (self: any) -> (),
}

export type VersionQuery<T> = {
	NextAsync: (self: any) -> (Type<T>?),
}

type ProfileStoreStandard<T> = {
	Name: string,
	StartSessionAsync: (self: any, profile_key: string, params: {Steal: boolean?}) -> (Type<T>?),
	MessageAsync: (self: any, profile_key: string, message: JSONAcceptable) -> (boolean),
	GetAsync: (self: any, profile_key: string, version: string?) -> (Type<T>?),
	VersionQuery: (self: any, profile_key: string, sort_direction: Enum.SortDirection?, min_date: DateTime | number | nil, max_date: DateTime | number | nil) -> (VersionQuery<T>),
	RemoveAsync: (self: any, profile_key: string) -> (boolean),
}

export type ProfileStore<T> = {
	Mock: ProfileStoreStandard<T>,
} & ProfileStoreStandard<T>

type ConstantName = "AUTO_SAVE_PERIOD" | "LOAD_REPEAT_PERIOD" | "FIRST_LOAD_REPEAT" | "SESSION_STEAL"
| "ASSUME_DEAD" | "START_SESSION_TIMEOUT" | "CRITICAL_STATE_ERROR_COUNT" | "CRITICAL_STATE_ERROR_EXPIRE"
| "CRITICAL_STATE_EXPIRE" | "MAX_MESSAGE_QUEUE"

export type ProfileStoreModule = {
	IsClosing: boolean,
	IsCriticalState: boolean,
	OnError: {Connect: (self: any, listener: (message: string, store_name: string, profile_key: string) -> ()) -> ({Disconnect: (self: any) -> ()})},
	OnOverwrite: {Connect: (self: any, listener: (store_name: string, profile_key: string) -> ()) -> ({Disconnect: (self: any) -> ()})},
	OnCriticalToggle: {Connect: (self: any, listener: (is_critical: boolean) -> ()) -> ({Disconnect: (self: any) -> ()})},
	DataStoreState: "NotReady" | "NoInternet" | "NoAccess" | "Access",
	New: <T>(store_name: string, template: (T & JSONAcceptable)?) -> (ProfileStore<T>),
	SetConstant: (name: ConstantName, value: number) -> ()
}

return module