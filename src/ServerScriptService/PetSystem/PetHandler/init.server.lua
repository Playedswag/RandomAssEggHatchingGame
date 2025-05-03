local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ServerStorage = game:GetService("ServerStorage")
local ModuleFolder = ServerStorage:WaitForChild("Modules")
local DeletePetRemote = Remotes:WaitForChild("DeletePetRemote")
local players = game:GetService("Players")
local LoadPlayerVPFModule = require(script:WaitForChild("LoadPlayerVPFModule"))
local PetsManageModule = require(ModuleFolder:WaitForChild("PetsManageModule"))

players.PlayerAdded:Connect(function(player)
	LoadPlayerVPFModule.LoadPlayerVPF(player)
end)

DeletePetRemote.OnServerEvent:Connect(function(player:Player, UID)
	if UID then
		PetsManageModule.DeletePet(player, UID)
	else
		warn("error removing pet with UID: ", UID)
	end
end)
