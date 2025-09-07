-- {Variables} ---
local Core = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts").Core

-- {Requires} ---
local ICall = require(Core.Storm.Services.Call.ICall)
local IServerManager = require(Core.Storm.Services.ServerManager.IServerManager)
local ITween = require(Core.Storm.Services.Tween.ITween)
local IUIController = require(Core.Storm.Services.UIController.IUIController)

local module = {}

export type Type = {
    Call: ICall.Type,
    ServerManager: IServerManager.Type,
    Tween: ITween.Type,
    UIController: IUIController.Type,
}


return module