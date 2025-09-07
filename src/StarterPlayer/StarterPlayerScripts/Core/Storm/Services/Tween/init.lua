local TweenService = game:GetService("TweenService")

local module = {}
module._States = {}

function module:TweenPlay(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any })
    local Tween = TweenService:Create(Object, TweenInfo, Properties)
    Tween:Play()
    return Tween
end

-- Tween direto (sem toggle)
function module:TweenTo(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any })
    if not Object then return end

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

-- Tween com alternância (toggle)
function module:TweenToggle(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any })
    if not Object then return end

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
    local Tween = self:TweenTo(Object, TweenInfo, Properties)

    if Tween and Callback then
        Tween.Completed:Once(Callback)
    end

    return Tween
end

-- PulseOnce (anima -> espera -> volta)
function module:PulseOnce(Object: Instance, TweenInfo: TweenInfo, Properties: { [any]: any }, DelayTime: number)
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
