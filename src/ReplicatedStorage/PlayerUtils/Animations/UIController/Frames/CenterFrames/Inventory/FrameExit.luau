--- {Variables} ---
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationFolder = ReplicatedStorage.PlayerUtils.Animations.UIController
local Packages = ReplicatedStorage.Packages

--- {Requires} ---
local TweenModule = require(Core.Storm.Services.Tween)
local Storm = require(Core.Storm)
local Validate = require(Packages.Validate)


--- {Variables} ---
local HudAnimations = require(AnimationFolder.Frames.Hud.Show)
local CloseClickModule = require(AnimationFolder.Buttons.Close.MouseClick)

local module = {}
module.__index = module

function module.new(Frame: ImageLabel)
    local Success = Validate:Params({{Frame, "Instance"}})
    if not Success then return end

    local self = setmetatable({}, module)

    local Content = Frame:WaitForChild("Content")
    
    self.Frame = Frame
    self.Banner = Frame:WaitForChild("Main"):WaitForChild("Banner")
    self.Buttons = {}
    
    for _, Button in Content:WaitForChild("Buttons"):GetChildren() do
        if Button:IsA("ImageButton") or Button:IsA("TextButton") then
            table.insert(self.Buttons, Button:WaitForChild("UIScale"))
        end
    end


    self.SellButton = Content:WaitForChild("Top"):WaitForChild("Sell")
    self.Search = Content:WaitForChild("Top"):WaitForChild("Search")

    local Overlay = Storm.CenterFrames["Overlay"]
    Overlay.Visible = false
    
    return self
end


function module.CloseAll()
    for _, child in Storm.CenterFrames do
        if not child.Visible or child.Name == "Overlay" then continue end
        
        local self = module.new(child)
        local InventoryTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

        local Tween = TweenModule:TweenTo(self.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, false, 0.3), {
            Position = UDim2.fromScale(0.5, 1.5)
        })
    
        TweenModule:TweenTo(self.Banner, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
            Position = UDim2.fromScale(-1.5, 0.5)
        })
    
        TweenModule:TweenMultiple(self.Buttons, InventoryTweenInfo, {
            Scale = 0
        })
    
        
        TweenModule:TweenTo(self.SellButton, InventoryTweenInfo, {
            Size = UDim2.fromScale(0, 0)
        })
        TweenModule:TweenTo(self.Search, InventoryTweenInfo, {
            Size = UDim2.fromScale(0, 0)
        })

        Tween.Completed:Wait()

        CloseClickModule.IsAnimationRunning = false
        HudAnimations:Load()
    end 
end


return module