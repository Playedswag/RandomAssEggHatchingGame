local ServerStorage = game:GetService("ServerStorage")
local Modules = ServerStorage:WaitForChild("Modules")
local RS = game:GetService("ReplicatedStorage")
local Remotes = RS:WaitForChild("Remotes")
local ClientAcessRemote = Remotes:WaitForChild("ClientAcessRemote")
local DataTable = require(Modules:WaitForChild("DataTable"))

ClientAcessRemote.OnServerInvoke = function(player, clienttable)
	local playerdata = DataTable.GetPlayerData(player)
	
	if typeof(clienttable) == "table" then --write function
		for key, data in clienttable do
			
		end
	elseif typeof(clienttable) == "string" then -- read function
		
		return DataTable.GetPlayerData(player)
	else
		return
	end
end
