--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animations = ReplicatedStorage.PlayerUtils.Animations.UIController.Buttons
local Packages = ReplicatedStorage.Packages

--- {Requires} ---
local Validate = require(Packages.Validate)
local ConnectionModule = require(Packages.ConnectionManager)

--- {Interfaces} ---
local IButton = require(script.IButton)

--- {Variables} ---
local ConnectionManager = ConnectionModule.new()

local module = {}
module.__index = module

function module:ConnectionButtons()
    self = self :: IButton.ClassType

    local MouseClickAnimation = require(self.AnimationFolder:WaitForChild("MouseClick"))
    local MouseHoverAnimation = require(self.AnimationFolder:WaitForChild("MouseHover"))
    local MouseUnHoverAnimation = require(self.AnimationFolder:WaitForChild("MouseUnHover"))


    local KeyClick = string.format("%s (%s)_Click_Animation", self.Instance.Name, self.TypeName)
    ConnectionManager:Add(KeyClick, self.Instance.MouseButton1Click:Connect(function()
        MouseClickAnimation:Load(self.Instance)
    end))

    local KeyHover = string.format("%s (%s)_Hover_Animation", self.Instance.Name, self.TypeName)
    ConnectionManager:Add(KeyHover, self.Instance.MouseEnter:Connect(function()
        MouseHoverAnimation:Load(self.Instance)
    end))

    local KeyUnHover = string.format("%s (%s)_UnHover_Animation", self.Instance.Name, self.TypeName)
    ConnectionManager:Add(KeyUnHover, self.Instance.MouseLeave:Connect(function()
        MouseUnHoverAnimation:Load(self.Instance)
    end))
    
end

function module.New(Button: ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end

    local self = setmetatable({}, module)

    self.Instance = Button
    self.TypeName = Button:GetAttribute("ButtonType")
    self.AnimationFolder = Animations:WaitForChild(self.TypeName)

    self:ConnectionButtons()

    return self
end

return module