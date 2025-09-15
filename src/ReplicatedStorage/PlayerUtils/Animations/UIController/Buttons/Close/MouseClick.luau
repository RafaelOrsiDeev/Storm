--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Folders} ---
local Animation = ReplicatedStorage.PlayerUtils.Animations.UIController
local FramesFolder = Animation.Frames.CenterFrames
local ScriptsFolder = Core.Storm.Scripts


--- {Requires} ---
local Validate = require(Packages.Validate)
local TweenModule = require(Core.Storm.Services.Tween)
local Storm = require(Core.Storm)

local module = {}
module.IsAnimationRunning = false

function module:Load(Button)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    if module.IsAnimationRunning then return end
    module.IsAnimationRunning = true

    TweenModule:PulseOnce(Button:WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 0.9}, 0)


    local ScriptModule = require(Storm:GetModule(ScriptsFolder, Button.Parent.Name))
    if not ScriptModule then return end

    if ScriptModule.Close and typeof(ScriptModule.Close) == "function" then 
        ScriptModule.Close()
    end
    

    local Frame = Storm.CenterFrames[Button.Parent.Name]
    local FrameExitAnimation = require(FramesFolder[Frame:GetAttribute("FrameType")].FrameExit)
    FrameExitAnimation:CloseAll()
end

return module