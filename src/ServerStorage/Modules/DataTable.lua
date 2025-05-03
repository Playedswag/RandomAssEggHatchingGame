
local DataTable = {}


return {
	AddPlayerToData = function(Player: Player, PlayerData)
		DataTable[Player.UserId] = PlayerData
	end,
	
	GetPlayerData = function(Player)
		return DataTable[Player.UserId]
	end,
	
	GetDataTable = function(Player)
		return DataTable
	end,
}
