--- {Requires} ---
local ProfileStore = require(game:GetService("ServerStorage").Packages.ProfileStore)
local Profiles = require(game:GetService("ServerStorage").ProfilesData)
local Leaderstats = require(script.Leaderstats)
local Storm = require(script.Parent.Parent)

-- {Interfaces} ---
local IData = require(game:GetService("ReplicatedStorage").Types.IData)

--- {Variables} ---

local DataTemplate = (Storm.Shared.PlayerData :: IData.Type)
local PlayerStore = ProfileStore.New("RafaelDev_Official", DataTemplate)
local PlayersIssues: {[Player]: number} = {}
local Players = game:GetService("Players")

local module = {}

local function DestroyProfile(Player: Player)
    local ProfileData = Profiles[Player]
    if ProfileData then
        ProfileData:EndSession()
        Profiles[Player] = nil
    end
end

local function HandleProfileError(player, message)
    if not PlayersIssues[player] then
        PlayersIssues[player] = 1
    else
        PlayersIssues[player] += 1
    end

    warn(message)

    if PlayersIssues[player] >= 5 then
        player:Kick("[Storm] Couldn't save your data multiple times. Rejoin please!")
    end
end

local function LoadProfile(Player: Player)
    local profile = PlayerStore:StartSessionAsync("P_"..Player.UserId, {
        Cancel = function() return Player.Parent ~= Players end
    })

    if not profile then
        Player:Kick("Error in starting profile session")
        return
    end

    profile:AddUserId(Player.UserId)
    profile:Reconcile()
    profile.Player = Player

    profile.OnSessionEnd:Connect(function()
        DestroyProfile(Player)
        Player:Kick("Profile session ended. Please rejoin.")
    end)

    if Player.Parent == Players then
        Profiles[Player] = profile

        Leaderstats.CreatedLeaderstats(Player, profile)
    else
        profile:EndSession()
    end
end

local function PlayerRemoving(player: Player)
    local profileData = Profiles[player]
    if profileData then
        profileData:EndSession()
    end
end

for _, player in Players:GetPlayers() do
    task.spawn(LoadProfile, player)
end

Players.PlayerAdded:Connect(LoadProfile)
Players.PlayerRemoving:Connect(PlayerRemoving)

function module.GetProfile(Player: Player)
    repeat task.wait() 
        until Profiles[Player]
        
    return Profiles[Player]
end

ProfileStore.OnError:Connect(function(message, _, key)
    local playerId = string.gsub(key, "P_", "")
    local player = Players:GetPlayerByUserId(tonumber(playerId))
    if not player then return end
    HandleProfileError(player, ("DataStore error (PlayerUID:%d, Key:%s): %s"):format(playerId, key, message))
end)

ProfileStore.OnOverwrite:Connect(function(_, key)
    local playerId = string.gsub(key, "P_", "")
    local player = Players:GetPlayerByUserId(tonumber(playerId))
    if not player then return end
    HandleProfileError(player, ("DataStore overwrite (PlayerUID:%d, Key:%s)"):format(playerId, key))
end)


return module