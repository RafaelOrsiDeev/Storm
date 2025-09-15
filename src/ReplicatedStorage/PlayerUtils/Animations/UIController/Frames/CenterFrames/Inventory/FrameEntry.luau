--- {Variables} ---
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core
local Packages = game:GetService("ReplicatedStorage").Packages
local HudAnimations = require(script.Parent.Parent.Parent.Hud.Hide)

--- {Requires} ---
local TweenModule = require(Core.Storm.Services.Tween)
local Storm = require(Core.Storm)
local Validate = require(Packages.Validate)

--- {Class Definition} ---
local FrameController = {}
FrameController.__index = FrameController

--- {Constructor} ---
function FrameController.new(Frame: ImageLabel)
    local Success = Validate:Params({{Frame, "Instance"}})
    if not Success then return end

    local self = setmetatable({}, FrameController)

    local Content = Frame:WaitForChild("Content")
    
    self.Frame = Frame
    self.Banner = Frame:WaitForChild("Main"):WaitForChild("Banner")
    self.Banner.Position = UDim2.fromScale(-1.5, 0.5)
    self.Buttons = {}
    self.SellButton = Content:WaitForChild("Top"):WaitForChild("Sell")
    self.SellButton.Size = UDim2.fromScale(0, 0)
    self.Search = Content:WaitForChild("Top"):WaitForChild("Search")
    self.Search.Size = UDim2.fromScale(0, 0)
    
    return self
end

--- {Instance Methods} ---

function FrameController:HideOtherFrames()
    for _, child in Storm.CenterFrames do
        if child.Name == self.Frame.Name or not child.Visible or child.Name == "Overlay" then 
            continue 
        end

        local tween = TweenModule:TweenPlay(child, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 1.5)
        })
        
        tween.Completed:Once(function()
            child.Visible = false
        end)
    end
end

function FrameController:SetupFrame()
    HudAnimations:Load()
    self.Frame.Position = UDim2.fromScale(0.5, 1.5)
    self.Frame.Visible = true
    
    local Overlay = Storm.CenterFrames["Overlay"]
    Overlay.Visible = true
    
    local ButtonsContainer = self.Frame:WaitForChild("Content"):WaitForChild("Buttons")
    self.Buttons = {}
    for _, Button in ButtonsContainer:GetChildren() do
        if Button:IsA("ImageButton") or Button:IsA("TextButton") then
            Button.UIScale.Scale = 0
            self.Buttons[Button] = Button:WaitForChild("UIScale")
        end
    end
end

function FrameController:PlayTweens()
    local InventoryTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.1)
    
    TweenModule:TweenTo(self.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.5)
    })

    TweenModule:TweenTo(self.Banner, InventoryTweenInfo, {
        Position = UDim2.fromScale(0.5, 0.5)
    })

    TweenModule:TweenMultiple(self.Buttons, InventoryTweenInfo, {
        Scale = 1
    })

    
    TweenModule:TweenTo(self.SellButton, InventoryTweenInfo, {
        Size = UDim2.fromScale(0.059, 0.915)
    })
    TweenModule:TweenTo(self.Search, InventoryTweenInfo, {
        Size = UDim2.fromScale(0.48, 0.843)
    })
end

function FrameController.Open(Frame: ImageLabel)
    local self = FrameController.new(Frame)
    self:HideOtherFrames()
    self:SetupFrame()
    self:PlayTweens()
end

--- {Module Return} ---
return FrameController
