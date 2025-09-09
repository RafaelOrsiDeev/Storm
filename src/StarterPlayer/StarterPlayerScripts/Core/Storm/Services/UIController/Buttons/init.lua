--- {Variables} ---
local CollectionService = game:GetService("CollectionService")
local Packages = game:GetService("ReplicatedStorage").Packages

--- {Requires} ---
local Validate = require(Packages.Validate)

local module = {}
module.__index = module

module.Class = {}

for _, Child in script:GetChildren() do
    if not Child:IsA("ModuleScript") then continue end

    module.Class[Child.Name] = require(Child)
end

function module.New(Button: TextButton | ImageButton)
    local Success = Validate:Params({{Button, "Instance"}})
    if not Success then return end
    
    if not Button:IsA("TextButton") and not Button:IsA("ImageButton") then return end

    for TagName, Class in module.Class do
        if CollectionService:HasTag(Button, TagName) then
            Class.Init(Button)
        end
    end
end



return module