local ServerStorage = game:GetService("ServerStorage")
local Events = ServerStorage:WaitForChild("Events")
local HatchEggEvent = Events:WaitForChild("HatchEggEvent")

local function InitPrompts(Egg, EggID, PetIds)
	local Prompts = Egg:WaitForChild("Prompts")
	
	local SinglePrompt = Prompts:FindFirstChild("SinglePrompt")
	local TriplePrompt = Prompts:FindFirstChild("TriplePrompt")
	local AutoPrompt = Prompts:FindFirstChild("AutoPrompt")
	
	if SinglePrompt then
		SinglePrompt.Style = Enum.ProximityPromptStyle.Custom
		
		SinglePrompt.Triggered:Connect(function(player)
			
			HatchEggEvent:Fire(player, EggID, PetIds, "Single")
		end)
	end
	
	if TriplePrompt then
		TriplePrompt.Style = Enum.ProximityPromptStyle.Custom
		TriplePrompt.Triggered:Connect(function(player)
			print("ran")
			HatchEggEvent:Fire(player, EggID, PetIds, "Triple")
		end)
	end
	
	if AutoPrompt then
		AutoPrompt.Style = Enum.ProximityPromptStyle.Custom
		
		AutoPrompt.Triggered:Connect(function(player)
			
			HatchEggEvent:Fire(player, EggID, PetIds, "Auto")
		end)
	end
end

local function getPetIds (Egg)
	
	local PetsIds = {}
	local PetsFolder = Egg:FindFirstChild("Pets")
	
	if not PetsFolder then
		warn("ERROR! following Egg does not contain valid PetsFolder: ", Egg)
	else
		for _, Pet in ipairs(PetsFolder:GetChildren()) do
			if Pet:IsA("IntValue") then
				table.insert(PetsIds, Pet.Value)
			else
				warn("ERROR! following Egg contains a non PetID instance ", Egg)
			end
		end
		
		return PetsIds
	end
	
end

local function getEggID(Egg)
	local EggID = Egg:FindFirstChild("EggID")
	if not Egg then
		warn("ERROR! following Egg does not contain a EggID: ", Egg)
	else
		return EggID.Value
	end
	
end

local function EggConstructMain (Egg)
	local EggID = getEggID(Egg)
	local PetIds = getPetIds(Egg)
	InitPrompts(Egg, EggID, PetIds)
	
end


return{
	ConstructEgg = function(Egg)
		EggConstructMain(Egg)
	end
}