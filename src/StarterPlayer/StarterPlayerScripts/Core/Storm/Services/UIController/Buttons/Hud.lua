--- {Requires} ---
local ConnectionModule = require(game:GetService("ReplicatedStorage").Packages.ConnectionManager)
local TweenModule = require(script.Parent.Parent.Parent.Tween)
local HudAnimations = require(script.Parent.Parent.Animations.Frames.Hud.Hud)
local Storm = require(script.Parent.Parent.Parent.Parent)
local Validation = require(game:GetService("ReplicatedStorage").Packages.Verification)


--- {Variables} ---
local ConnectionManager = ConnectionModule.new()
local FrameEntryAnimation = require(script.Parent.Parent.Animations.Frames.CenterFrames.FrameEntry)


local module = {}
module.__index = module

function module:_Connection(key: string, Connection: RBXScriptSignal, CallBack: () -> ())
    ConnectionManager:Add(string.format("%s_%s", self.Button.Name, key), Connection:Connect(CallBack))
end

function module:ButtonClick() 
    self:_Connection("Click", self.Button.MouseButton1Click, function()
        local Tween = TweenModule:PulseOnce(self.Button.UIScale, TweenInfo.new(0.1), {Scale = 0.9}, 0)
        Tween.Completed:Wait()

        HudAnimations:HudVisible()

        local Frame = Storm.CenterFrames[self.Button.Name]
        FrameEntryAnimation:Open(Frame)
    end)
end


function module:ButtonHover()
    self:_Connection("Hover", self.Button.MouseEnter, function()
        TweenModule:TweenTo(self.Button.UIScale, TweenInfo.new(0.1), {Scale = 1.1})
    end)
end

function module:ButtonUnhover()
    self:_Connection("UnHover", self.Button.MouseLeave, function()
        TweenModule:TweenTo(self.Button.UIScale, TweenInfo.new(0.1), {Scale = 1})
    end)
end


function module.Init(Button: TextButton | ImageButton)
    local Success, ErrorMessage = Validation.ValidateParams({{Button, "Instance"}})
    if not Success then 
        warn(ErrorMessage)
        return
    end

    local self = setmetatable({}, module)

    self.Button = Button

    self:ButtonClick()
    self:ButtonHover()
    self:ButtonUnhover()

    return self
end
    




return module