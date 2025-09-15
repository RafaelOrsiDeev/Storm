--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Requires} ---
local Validate = require(Packages.Validate)
local TweenModule = require(Core.Storm.Services.Tween)


local module = {}

function module:Load(Button: TextButton | ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end
    
    TweenModule:TweenTo(Button:WaitForChild("Frame"):WaitForChild("UIScale"), TweenInfo.new(0.1), {Scale = 1.07})
end

return module