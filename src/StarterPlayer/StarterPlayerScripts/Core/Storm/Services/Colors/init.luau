---{Variable}--
local ReplicatedStorage = game:GetService("ReplicatedStorage")

---{Folders}---
local ColorsFolder = ReplicatedStorage.Colors


local module = {}

function module:Create(Rarity: string, Paths: {Instance})
    for _, Path in Paths do
        local Color = ColorsFolder:FindFirstChild(Rarity):Clone()
        if not Color then return end

        for _, Child in Path:GetChildren() do
            if Child:IsA("UIGradient") then  
                Child:Destroy()
            end
            Color.Parent = Path
        end
    end
end


return module