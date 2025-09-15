--- {Variables} ---
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Requires} ---
local Storm = require(Core.Storm)
local TweenModule = require(Core.Storm.Services.Tween)

--- {Variables} ---
local HudFolder = Storm.PlayerGui:WaitForChild("MainUI"):WaitForChild("Hud") :: Folder

local module = {}

function module:Load()
    for _, Child in HudFolder:GetChildren() do
        TweenModule:TweenTo(Child, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = UDim2.fromScale(-0.5, 0.45) })
    end
end

return module