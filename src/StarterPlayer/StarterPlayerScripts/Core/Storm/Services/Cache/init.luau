--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Validate = require(Packages.Validate)

local module = {}

local function autoTable(TargetTable, key)
	local NewTable = {}

	rawset(TargetTable, key, NewTable)
	return NewTable
end

function module.New()
    local self = setmetatable({}, { __index = autoTable })

    return self
end

return module