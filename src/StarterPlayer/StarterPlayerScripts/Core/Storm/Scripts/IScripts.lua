--- {Variables} ---
local Script = script.Parent

--- {Interfaces} ---
local IDataManager = require(Script.DataManager.IDataManager)


local module = {}

export type Type = {
    DataManager: IDataManager.Type
}

return module