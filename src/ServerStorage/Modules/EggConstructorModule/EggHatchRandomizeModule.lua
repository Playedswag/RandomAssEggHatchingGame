local ServerStorage = game:GetService("ServerStorage")
local Events = ServerStorage:WaitForChild("Events")
local HatchEggEvent = Events:WaitForChild("HatchEggEvent")
local Modules = ServerStorage:WaitForChild("Modules")
local PetsManageModule = require(Modules:WaitForChild("PetsManageModule"))
local PetsManageModuleParent = Modules:WaitForChild("PetsManageModule")


local PetPossibilityTable = require(PetsManageModuleParent:WaitForChild("PetPossibility"))
local PetsTable = require(PetsManageModuleParent:WaitForChild("PetsTable"))
local DataTable = require(Modules:WaitForChild("DataTable"))


local function getChances(Pets)
	local BuildPetPossibilityTable = {}
	local index = 0
	
	for key, Raritys in pairs(Pets) do
		if PetPossibilityTable.possibilities[Raritys.Rarity] then
			if Raritys.Rarity then	
				local Rarity = Raritys.Rarity
				
				local entry = {
					Rarity = Raritys.Rarity,
					ID = Raritys.ID,
					PetPossibility = PetPossibilityTable.possibilities[Rarity].possibility
				}

				table.insert(BuildPetPossibilityTable, entry)

			end
		end
	end
	
	if BuildPetPossibilityTable then
		return BuildPetPossibilityTable
	else
		warn("Error building PetPossibility Table!")
	end
end

local function getPets (PetIDs)
	
	local Pets = {}
	
	for key, IDs in ipairs(PetIDs) do
		for key2, PetID in pairs(PetsTable.Pets) do
			if PetID.ID == IDs then
				table.insert(Pets, PetID)
			end
		end
	end
	
	return Pets
end

local function Roll(Possibilities)
	local RandomNumber = math.random(1, 5000)
	local Results = {}
	local SmallestPossibility = 5001
	local ResultRarity = nil
	local RarityFinal = {}
	

	for _, Possibility in Possibilities do
		
		local PetPossibility = Possibility.PetPossibility
		
		if PetPossibility >= RandomNumber then
			if PetPossibility < SmallestPossibility then
				SmallestPossibility = PetPossibility
				ResultRarity = Possibility.Rarity
			end
		end
	end
	

	for _, Result in Possibilities do
		if Result.Rarity == ResultRarity then
			table.insert(RarityFinal, Result)
			
		end
	end
	

	
	if RarityFinal then
		local FinalRandom = math.random(1, #RarityFinal)

		local Result = RarityFinal[FinalRandom]
		return Result
	else
		warn("Error couldnt Pick Possiblity !!!!")
	end
	
	
	
	
	
end

local function AddPet(player, Result)
	local PlayerData = DataTable.GetPlayerData(player)
	local blockedSetting = PlayerData.Settings.possibilityBlocked
	
	
	if blockedSetting then
		if blockedSetting[Result.Rarity] then
			if blockedSetting[Result.Rarity].blocked == false then
				
				PetsManageModule.AddPet(player, Result.ID)
				return "sucess"
			elseif blockedSetting[Result.Rarity].blocked == true then
				return "sucess"
			end
		end
	else
		warn("Error couldnt fetch player blockedsettings for player: ", player)
		PetsManageModule.AddPet(player, Result.ID)
		return "sucess"
	end
	
end

local function InitializeHatch(player, EggID, PetIDs, Type)
	local Pets = getPets(PetIDs)
	local Possibilites = getChances(Pets)
	local Result = Roll(Possibilites)
	local Sucess = AddPet(player, Result)
	
	if not Sucess then
		wait("Error in Adding Pet for player: ", player)
	end
	
	return "finished"
end

local function RandomizeMain(player, EggID, PetIDs, Type)
	if Type == "Single" then
		InitializeHatch(player, EggID, PetIDs, Type)
		
	elseif Type == "Triple" then
		local finished = InitializeHatch(player, EggID, PetIDs, Type)
		
		if finished then
			for i = 1,2 do
				InitializeHatch(player, EggID, PetIDs, Type)
			end
		end
	elseif Type == "Auto" then
		return InitializeHatch(player, EggID, PetIDs, Type)
	end
	
end


return {
	OpenRandomEgg = function (player, EggID, PetIDs, Type)
		return RandomizeMain(player, EggID, PetIDs, Type)
	end
}