--- {Variables} ---
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core

--- {Requires} ---
local TweenModule = require(Core.Storm.Services.Tween)
local Storm = require(Core.Storm)
local HudAnimations = require(script.Parent.Parent.Hud.Manager)

local module = {}

local function SetupCreate(Frame: ImageLabel)
    HudAnimations:HudHide()
    Frame.Position = UDim2.fromScale(0.5, 1.5)
    Frame.Visible = true
    
    local Overlay = Storm.CenterFrames["Overlay"]
    Overlay.Visible = true

    local Banner = Frame:WaitForChild("Main"):WaitForChild("Banner")
    Banner.Position = UDim2.fromScale(-0.5, 0.5)

    return Banner
end

function module:Open(Frame: ImageLabel)
    for _, child in Storm.CenterFrames do
        if child.Name == Frame.Name or not child.Visible or child.Name == "Overlay" then continue end

        local Tween = TweenModule:TweenTo(child, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 1.5)
        })

        Tween.Completed:Once(function()
            child.Visible = false
        end)
    end 

    local Banner = SetupCreate(Frame)

    local Tween = TweenModule:TweenTo(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.5)
    })
    Tween.Completed:Wait()

    

    TweenModule:TweenTo(Banner, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.5)
    })
end


return module