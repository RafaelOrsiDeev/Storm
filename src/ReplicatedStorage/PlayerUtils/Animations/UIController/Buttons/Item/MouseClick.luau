--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Requires} ---
local Validate = require(Packages.Validate)
local TweenModule = require(Core.Storm.Services.Tween)



local module = {}

function module:Load(Button)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    TweenModule:TweenCallback(Button:WaitForChild("Frame"):WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 0.9}, function()
        TweenModule:TweenTo(Button:WaitForChild("Frame"):WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 1})
    end)
end

return module