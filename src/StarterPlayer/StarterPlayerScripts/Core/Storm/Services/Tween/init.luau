--- {Variables} ---
local Packages = game:GetService("ReplicatedStorage").Packages
local TweenService = game:GetService("TweenService")

--- {Requires} ---
local Validate = require(Packages.Validate)

local module = {}
module._States = {}

function module:TweenPlay(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any })
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}})
    if not Success then return end

    local Tween = TweenService:Create(Object, TweenInfo, Properties)
    Tween:Play()
    return Tween
end

function module:TweenTo(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any })
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}})
    if not Success then return end

    local State = self._States[Object] or {}
    self._States[Object] = State

    if State._ActiveTween then
        State._ActiveTween:Cancel()
    end

    local Tween = self:TweenPlay(Object, TweenInfo, Properties)
    State._ActiveTween = Tween

    Tween.Completed:Once(function()
        State._ActiveTween = nil
    end)

    return Tween
end

function module:TweenToggle(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any })
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}})
    if not Success then return end

    local State = self._States[Object] or {}
    self._States[Object] = State

    if State._ActiveTween then
        State._ActiveTween:Cancel()
    end

    local TweenProperties = {}
    for Property, Value in pairs(Properties) do
        if State[Property] == nil then
            State[Property] = Object[Property]
        end
        TweenProperties[Property] = State._Toggled and State[Property] or Value
    end

    State._Toggled = not State._Toggled

    local Tween = self:TweenPlay(Object, TweenInfo, TweenProperties)
    State._ActiveTween = Tween

    Tween.Completed:Once(function()
        State._ActiveTween = nil
    end)

    return Tween
end

function module:TweenCallback(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any }, Callback: (() -> ())?)
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}, {Callback, "function"}})
    if not Success then return end

    local Tween = self:TweenTo(Object, TweenInfo, Properties)

    Tween.Completed:Once(Callback)


    return Tween
end

function module:PulseOnce(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any }, DelayTime: number)
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}, {DelayTime, "number"}})
    if not Success then return end

    local Original = {}
    for Property, _ in pairs(Properties) do
        Original[Property] = Object[Property]
    end


    local Tween = self:TweenTo(Object, TweenInfo, Properties)

    Tween.Completed:Once(function()
        task.delay(DelayTime, function()
            self:TweenTo(Object, TweenInfo, Original)
        end)
    end)

    return Tween
end


function module:TweenMultiple(ObjectsParam: { Instance }, TweenInfo: TweenInfo, Properties: { [any]: any })
    local Success = Validate:Params({{ObjectsParam, "table"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}})
    if not Success then return end

    for _, Object in ObjectsParam do
        self:TweenTo(Object, TweenInfo, Properties)
    end
end




return module
