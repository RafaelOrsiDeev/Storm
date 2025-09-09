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

-- Callback ao terminar
function module:Callback(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any }, Callback: (() -> ())?)
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}, {Callback, "function"}})
    if not Success then return end

    local Tween = self:TweenTo(Object, TweenInfo, Properties)

    if Tween and Callback then
        Tween.Completed:Once(Callback)
    end

    return Tween
end

-- PulseOnce (anima -> espera -> volta)
function module:PulseOnce(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any }, DelayTime: number)
    local Success = Validate:Params({{Object, "Instance"}, {TweenInfo, "TweenInfo"}, {Properties, "table"}, {DelayTime, "number"}})
    if not Success then return end

    if not Object then return end

    local State = self._States[Object] or {}
    self._States[Object] = State

    if State._ActiveTween then
        State._ActiveTween:Cancel()
    end

    local Original = {}
    for Property, _ in pairs(Properties) do
        Original[Property] = Object[Property]
    end

    local Tween = self:TweenPlay(Object, TweenInfo, Properties)
    State._ActiveTween = Tween

    Tween.Completed:Once(function()
        task.delay(DelayTime, function()
            -- só volta se nenhum outro tween rodou no meio tempo
            if State._ActiveTween == Tween then
                local BackTween = self:TweenPlay(Object, TweenInfo, Original)
                State._ActiveTween = BackTween
                BackTween.Completed:Once(function()
                    if State._ActiveTween == BackTween then
                        State._ActiveTween = nil
                    end
                end)
            end
        end)
    end)

    return Tween
end

return module
