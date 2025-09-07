local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)

    self._Connections = {}

    return self
end

function module:Add(Key: string, Connection: RBXScriptConnection)
    local Old = self._Connections[Key]
    
    if Old and Old.Connected then
        Old:Disconnect()
    end

    self._Connections[Key] = Connection
    return Connection
end

function module:DisconecAll()
    for _, Connection in self._connections do
        if Connection.Connected then
            Connection:Disconnect()
        end
    end

    self._connections = nil
end

return module