--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Folders} ---
local Animation = ReplicatedStorage.PlayerUtils.Animations.UIController
local FramesFolder = Animation.Frames.CenterFrames
local ScriptsFolder = Core.Storm.Scripts


--- {Requires} ---
local Storm = require(Core.Storm)
local Validate = require(Packages.Validate)
local TweenModule = require(Core.Storm.Services.Tween)
local ShowHudAnimation = require(Animation.Frames.Hud.Show)


local module = {}

function module:Load(Button: TextButton | ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    local Tween = TweenModule:PulseOnce(Button:WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 0.9}, 0)
    Tween.Completed:Wait()
    ShowHudAnimation:Load()

    local Frame = Storm.CenterFrames[Button.Name]
    local FrameEntryAnimation = require(FramesFolder[Frame:GetAttribute("FrameType")].FrameEntry)

    FrameEntryAnimation.Open(Frame)

    local ScriptModule = require(Storm:GetModule(ScriptsFolder, Button.Name))
    if not ScriptModule then return end
    
    if ScriptModule.Open and typeof(ScriptModule.Open) == "function" then 
        ScriptModule.Open()
    end

end

return module