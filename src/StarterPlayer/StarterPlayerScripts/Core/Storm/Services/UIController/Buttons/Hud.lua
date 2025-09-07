--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Requires} ---
local Storm = require(Core.Storm)
local ConnectionModule = require(ReplicatedStorage.Packages.ConnectionManager)
local TweenModule = require(Core.Storm.Services.Tween)
local HudAnimations = require(script.Parent.Parent.Animations.Hud.Manager)
local Validation = require(ReplicatedStorage.Packages.Verification)


--- {Variables} ---
local ConnectionManager = ConnectionModule.new()
local FrameEntryAnimation = require(Core.Storm.Services.UIController.Animations.CenterFrames.FrameEntry)


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