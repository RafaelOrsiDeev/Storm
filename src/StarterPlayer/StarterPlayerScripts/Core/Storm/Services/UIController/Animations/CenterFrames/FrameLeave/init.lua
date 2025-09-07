--- {Variables} ---
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Requires} ---
local TweenModule = require(Core.Storm.Services.Tween)
local Storm = require(Core.Storm)
local HudAnimations = require(script.Parent.Parent.Hud.Manager)

local module = {}

local function SetupCreate(Frame: ImageLabel)
    local Overlay = Storm.CenterFrames["Overlay"]
    Overlay.Visible = false

    local Banner = Frame:WaitForChild("Main"):WaitForChild("Banner")
    
    return Banner
end


function module:CloseAll()
    for _, child in Storm.CenterFrames do
        if not child.Visible or child.Name == "Overlay" then continue end

        local Banner = SetupCreate(child)

        TweenModule:TweenTo(Banner, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(-0.5, 0.5)
        })

        local Tween = TweenModule:TweenTo(child, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.1), {
            Position = UDim2.fromScale(0.5, 1.5)
        })

        Tween.Completed:Wait()
        HudAnimations:HudVisible()
    end 
end


return module