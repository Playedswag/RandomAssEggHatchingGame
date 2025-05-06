local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ModulesFolder = ServerStorage:WaitForChild("Modules")

local DataTable = require(ModulesFolder:WaitForChild("DataTable"))
local DataStoreModule = require(ModulesFolder:WaitForChild("DataStoreModule"))
local DefaultData = require(script:WaitForChild("DefaultData"))

local DataSavedConfirmation = {}

local function MergeNewData(default, saved)
	for key, value in pairs(default) do
		if saved[key] == nil then
			saved[key] = value
		elseif type(value) == "table" and type(saved[key]) == "table" then
			MergeNewData(value, saved[key])
		end
	end
	return saved
end

Players.PlayerAdded:Connect(function(Player)
	local PlayerData = DataStoreModule.GetPlayerData(Player)
	if PlayerData then
		DataTable.AddPlayerToData(Player, PlayerData)
		MergeNewData(DefaultData, PlayerData)
	else
		DataTable.AddPlayerToData(Player, DefaultData)
	end
	
	print(DataTable.GetDataTable())
end)





Players.PlayerRemoving:Connect(function(Player)
	local sucess, err = pcall(function()
		DataStoreModule.SavePlayerData(Player, DataTable.GetPlayerData(Player))
		DataSavedConfirmation[Player.UserId] = true
	end)
	
	if not sucess then
		warn("Failed Saving Player Data [Data Handler]")
		DataSavedConfirmation[Player.UserId] = false
	end
end)

game:BindToClose(function()
	for _, Player in pairs(Players:GetPlayers()) do
		if not DataSavedConfirmation[Player.UserId] then
			DataStoreModule.SavePlayerData(Player, DataTable.GetPlayerData(Player))
		end
	end
end)