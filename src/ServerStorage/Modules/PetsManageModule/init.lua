local ServerStorage = game:GetService("ServerStorage")
local ModuleFolder = ServerStorage:WaitForChild("Modules")
local DataTable = require(ModuleFolder:WaitForChild("DataTable"))
local PetsTable = require(script:WaitForChild("PetsTable"))
local HttpService = game:GetService("HttpService")
local AssignVPFModule = require(script:WaitForChild("AssignVPFModule"))


local function generateUID ()
	local UID = HttpService:GenerateGUID(true)
	return UID
end

local function AddToTable (ResultPet, Pets, player)
	
	local ID = ResultPet.ID
	local PetCopy = table.clone(ResultPet)
	local UID = generateUID()

	PetCopy.UniqueID = UID

	table.insert(Pets, PetCopy)
	
	print(Pets)
	
	AssignVPFModule.AddPetVPF(player, ID, UID)

end


local function ProcessPetInput(Player: Player, Pet)

	
	local PlayerData = DataTable.GetPlayerData(Player)
	local Pets = PlayerData.Storage.Pets
	
	if typeof(Pet) == "string" then
		
		if PetsTable.Pets[Pet] then
			local ResultPet = PetsTable.Pets[Pet]
			AddToTable(ResultPet, Pets, Player)
		end
		
	elseif typeof(Pet) == "number" then
		
		for v, index in PetsTable.Pets do
			if index.ID == Pet then	
				AddToTable(index, Pets, Player)
			end
		end
		
	else
		warn("Invalid Pet")
	end
	
end

local function ProcessDeleteInput(Player, UID)
	
	local PlayerData = DataTable.GetPlayerData(Player)
	local PetsStored = PlayerData.Storage.Pets
	
	for _, pets in pairs(PetsStored) do
		if pets.UniqueID == UID then
			local petindex = table.find(PetsStored, pets)
			table.remove(PetsStored, petindex)
			AssignVPFModule.RemovePetVPF(Player, UID)
		end
	end

	
end






return {
	AddPet = function(Player, Pet)
		ProcessPetInput(Player, Pet)
	end,
	
	DeletePet = function(Player, UniqueID)
		ProcessDeleteInput(Player, UniqueID)
	end,
}