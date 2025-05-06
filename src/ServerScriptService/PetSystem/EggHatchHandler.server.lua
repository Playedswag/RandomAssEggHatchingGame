local ServerStorage = game:GetService("ServerStorage")
local Events = ServerStorage:WaitForChild("Events")
local HatchEggEvent = Events:WaitForChild("HatchEggEvent")
local Modules = ServerStorage:WaitForChild("Modules")
local EggConstructorModule = require(Modules:WaitForChild("EggConstructorModule"))
local EggConstructorModuleParent = Modules:WaitForChild("EggConstructorModule")
local EggHatchRandomizeModule = require(EggConstructorModuleParent:WaitForChild("EggHatchRandomizeModule"))

local AutoActive = {}

task.wait(2)

EggConstructorModule.ConstructEgg(workspace.EggV1)

local function Auto(player:Player, EggID:number, PetIDs, Type:string)
	
	local finished = EggHatchRandomizeModule.OpenRandomEgg(player, EggID, PetIDs, Type)
	
	if finished == "finished" and AutoActive[player] == true then
		task.wait(1)
		Auto(player, EggID, PetIDs, Type)
	end
end

local function checkAuto(player:Player, EggID:number, PetIDs, Type:string)
	
	if not AutoActive[player] then
		AutoActive[player] = true
		Auto(player, EggID, PetIDs, Type)
	else
		AutoActive[player] = false
	end
end


HatchEggEvent.Event:Connect(function(player:Player, EggID:number, PetIDs, Type:string)
	
	if Type == "Auto" then
		checkAuto(player, EggID, PetIDs, Type)
	elseif Type == "Single" then
		EggHatchRandomizeModule.OpenRandomEgg(player, EggID, PetIDs, Type)
	elseif Type == "Triple" then
		EggHatchRandomizeModule.OpenRandomEgg(player, EggID, PetIDs, Type)
	else
		warn("Error invalid prompt Type for player: " , player)
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	AutoActive[player] = nil
end)