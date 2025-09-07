--- {Requires} ---
local CollectionService = game:GetService("CollectionService")
local IButtons = require(script.IButtons)


local module = {}
module.__index = module

module.Class = {} :: IButtons.ClassType

for _, Child in script:GetChildren() do
    if not Child:IsA("ModuleScript") then continue end

    module.Class[Child.Name] = require(Child)
end

function module.New(Button: TextButton | ImageButton)
    if not Button:IsA("TextButton") and not Button:IsA("ImageButton") then return end

    for TagName, Class in module.Class do
        if CollectionService:HasTag(Button, TagName) then
            Class.Init(Button)
        end
    end
end



return module