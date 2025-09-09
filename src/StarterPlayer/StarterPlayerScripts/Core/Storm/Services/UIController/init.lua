--- {Requires} ---
local Storm = require(script.Parent.Parent)
local CenterFramesModule = require(script.CenterFrames)
local ButtonsModule = require(script.Buttons)


--- {Variables} ---
local MainFolder = Storm.PlayerGui:WaitForChild("MainUI") :: ScreenGui
local CollectionService = game:GetService("CollectionService")



local module = {}
module.__index = module


local function FilterChildren(Child)
    if CollectionService:HasTag(Child, "CenterFrames") then
        CenterFramesModule:Save(Child)
    end

    if CollectionService:HasTag(Child, "Button") then
        ButtonsModule.New(Child)
    end
end

function module.Init()
    for _, Child in MainFolder:GetDescendants() do
        FilterChildren(Child)
    end 
end


module.Init()

return module