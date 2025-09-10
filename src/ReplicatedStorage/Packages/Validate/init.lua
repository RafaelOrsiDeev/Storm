local module = {}

function module:Params(Tables: { { any } }): boolean
    for _, Table in Tables do
        local Type, RealType = Table[1], Table[2]

        local callerLine = string.match(debug.traceback(), "\n%s*(.-)\n")

        if not Type or not RealType then 
            warn(string.format("[%s] | Invalid Variable for %s: %s", callerLine, Type, typeof(RealType)))
            return false
         end

        if typeof(Type) ~= RealType then 
            print(Type)
            warn(string.format("[%s] | Invalid type for %s: %s", callerLine , typeof(Type), typeof(RealType)))
            return false 
        end
    end

    return true
end

return module