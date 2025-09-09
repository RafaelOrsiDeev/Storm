--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core
local Animation = ReplicatedStorage.PlayerUtils.Animations.UIController

--- {Requires} ---
local Validate = require(Packages.Validate)
local TweenModule = require(Core.Storm.Services.Tween)
local FrameExitAnimation = require(Animation.Frames.CenterFrames.FrameExit)


local module = {}

function module:Load(Button: TextButton | ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    TweenModule:PulseOnce(Button:WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 0.9}, 0)

    FrameExitAnimation:CloseAll()
end

return module