local ServerStorage = game:GetService("ServerStorage")
local ModuleFolder = ServerStorage:WaitForChild("Modules")
local AssignVPFModule = require(ModuleFolder:WaitForChild("PetsManageModule"):WaitForChild("AssignVPFModule"))
local DataTable = require(ModuleFolder:WaitForChild("DataTable"))

local function LoadPlayerVPF (player)
	task.wait(2)
	local PlayerData = DataTable.GetPlayerData(player)
	local Pets = PlayerData.Storage.Pets

	for _, petData in pairs(Pets) do
		if petData.ID then
			if petData.UniqueID then
				local UID = petData.UniqueID
				AssignVPFModule.AddPetVPF(player, petData.ID, UID)
			end
		else
			print("not found")
		end
	end
end

return {
	LoadPlayerVPF = function (player)
		LoadPlayerVPF(player)
	end
}