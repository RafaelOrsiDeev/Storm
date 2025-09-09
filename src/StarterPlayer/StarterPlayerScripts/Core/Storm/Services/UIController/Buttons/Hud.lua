--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Core = game:GetService("Players").LocalPlayer.PlayerScripts.Core
local Animations = ReplicatedStorage.PlayerUtils.Animations.UIController

--- {Requires} ---
local ConnectionModule = require(ReplicatedStorage.Packages.ConnectionManager)
local Validate = require(ReplicatedStorage.Packages.Validate)


--- {Variables} ---
local ConnectionManager = ConnectionModule.new()
local MouseClickAnimation = require(Animations.Buttons.Hud.MouseClick)
local MouseHoverAnimation = require(Animations.Buttons.Hud.MouseHover)
local MouseUnhoverAnimation = require(Animations.Buttons.Hud.MouseUnhover)

local module = {}
module.__index = module

function module:_Connection(key: string, Connection: RBXScriptSignal, CallBack: () -> ())
    ConnectionManager:Add(string.format("%s_%s", self.Button.Name, key), Connection:Connect(CallBack))
end

function module:ButtonClick() 
    self:_Connection("Click", self.Button.MouseButton1Click, function()

        MouseClickAnimation:Load(self.Button)
    end)
end


function module:ButtonHover()
    self:_Connection("Hover", self.Button.MouseEnter, function()

        MouseHoverAnimation:Load(self.Button)
    end)
end

function module:ButtonUnhover()
    self:_Connection("UnHover", self.Button.MouseLeave, function()

        MouseUnhoverAnimation:Load(self.Button)
    end)
end


function module.Init(Button: TextButton | ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    local self = setmetatable({}, module)
    self.Button = Button

    self:ButtonClick()
    self:ButtonHover()
    self:ButtonUnhover()

    return self
end
    




return module