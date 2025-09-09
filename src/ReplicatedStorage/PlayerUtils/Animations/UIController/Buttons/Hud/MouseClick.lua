--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core
local Animation = ReplicatedStorage.PlayerUtils.Animations.UIController

--- {Requires} ---
local Storm = require(Core.Storm)
local Validate = require(Packages.Validate)
local TweenModule = require(Core.Storm.Services.Tween)
local FrameEntryAnimation = require(Animation.Frames.CenterFrames.FrameEntry)
local ShowHudAnimation = require(Animation.Frames.Hud.Show)


local module = {}

function module:Load(Button: TextButton | ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    local Tween = TweenModule:PulseOnce(Button:WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 0.9}, 0)
    Tween.Completed:Wait()

    ShowHudAnimation:Load()

    local Frame = Storm.CenterFrames[Button.Name]
    FrameEntryAnimation:Open(Frame)
end

return module