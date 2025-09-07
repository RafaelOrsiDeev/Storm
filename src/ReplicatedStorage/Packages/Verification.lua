local module = {}
 

function module.ValidateParams(Tables: { { [number]: any } }): (boolean, string?)
    for _, table in Tables do

        local Param, Type = table[1], table[2]

        if Param == nil then
            return false, string.format("%s is nil", tostring(Param))
        end

        if typeof(Param) ~= Type then
            return false, string.format("%s is not %s", tostring(Param), tostring(Type))
        end

    end

    return true
end

return module