local DataStoreService = game:GetService("DataStoreService")
local MainDataStore = DataStoreService:GetDataStore("MainDataStore")

local function SaveData(Player: Player, PlayerData)
	local sucess, err = pcall(function()
		MainDataStore:SetAsync(Player.UserId, PlayerData)
	end)
	
	if sucess then
		print(Player.Name, " data saved")
	else
		print("error")
		warn(err)
	end
end


--Sync PlayerData with Datastore by ID

local function GetData(Player)
	
	local PlayerData
	local sucess, err = pcall(function()
		PlayerData = MainDataStore:GetAsync(Player.UserId)
	end)
	
	if sucess then
		print(Player.Name, " data returned")
	else
		warn(err)
	end
	
	return PlayerData
	
end

--Get PlayerData by ID

return {
	SavePlayerData = function(Player, PlayerData)
		SaveData(Player, PlayerData)
	end,
	
	GetPlayerData = function(Player)
		return GetData(Player)
	end,
}





--Non self made, code by: "https://youtu.be/zVp3pfnmxZo?si=0tUiy1MuluSbXsnh"
