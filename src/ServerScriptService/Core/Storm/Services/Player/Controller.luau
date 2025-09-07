local module = {}

function module:GetValue(PathParam: {string | number})
    local Path = table.concat(PathParam, ".")

    return self.Data[Path]
end

return module