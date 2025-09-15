--- {Variables} ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FolderToLoad = {
    script.Services, script.Scripts,
}

local Packages = ReplicatedStorage.Packages
local FunctionsInit = {}

--- {Requires} ---
local Types = require(game:GetService("ServerScriptService").Core.Types)

--- {Services} ---
local Validate = require(Packages.Validate)


local Storm = {}

--- {Private Functions} ---

local function LoadModule(File: ModuleScript)
    local SuccessParams = Validate:Params({{File, "Instance"}})
    if not SuccessParams then return end

    task.spawn(function()
        local Success, Module = pcall(require, File)
        if not Success then return end

        if Module.Init and typeof(Module.Init) == "function" then
            table.insert(FunctionsInit, Module)
        end
    end)
end

local function LoadFolder(Folder: Folder)
    local SuccessParams = Validate:Params({{Folder, "Instance"}})
    if not SuccessParams then return end

    for _, File in Folder:GetChildren() do
        if File:IsA("ModuleScript") and not File.Name:match("^I" .. Folder.Name) then
            LoadModule(File)

        elseif File:IsA("Folder") then
            LoadFolder(File)
        end
    end
end


--- {Public Functions} ---

function Storm:Init()
    for _, Folder in FolderToLoad do
        LoadFolder(Folder)
    end

    for _, Function in FunctionsInit do
        Function.Init()
    end
end

function Storm:GetModule(Folder: Folder, Path: string): ModuleScript?
    local SuccessParams = Validate:Params({{Folder, "Instance"}, {Path, "string"}})
    if not SuccessParams then return end

    local Result = nil
    for _, File in Folder:GetChildren() do
        if File:IsA("ModuleScript") and File.Name == Path then
            Result = File
            break

        elseif File:IsA("Folder") then
            Storm:GetModule(File, Path)
        end

    end

    return Result
end

function Storm:GetModuleFromPath(Folder: Folder, TableParam: {string}): ModuleScript?
    local SuccessParams = Validate:Params({{Folder, "Instance"}, {TableParam, "table"}})
    if not SuccessParams then return end

    local Current = Folder
    for i, Name in TableParam do
        if i < #TableParam then
            Current = Current:WaitForChild(Name)
        else
            Current = require(Current)[Name]
        end
    end

    return Current
end


return Storm :: Types.StormTypes