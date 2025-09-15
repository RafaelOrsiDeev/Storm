
--- {Folders} ---
local SharedFolder = game:GetService("ReplicatedStorage").PlayerUtils.Shared

--- {requires} ---

local module = {}

function module:SortItems(action: string, Table: { [any]: any }, Type: string)
	local SortedTable = {}
	for id, item in pairs(Table) do
		table.insert(SortedTable, { Id = id, Info = item })
	end

	table.sort(SortedTable, function(a, b)
		local aEquipped, bEquipped = a.Info.Equipped, b.Info.Equipped
		local aPower = a.Info.Mult["Power"] or 0
		local bPower = b.Info.Mult["Power"] or 0

		if aEquipped ~= bEquipped then
			return aEquipped
		end

		if action == "Power" then
			return aPower > bPower
		end

		return false
	end)

	return SortedTable
end


return module