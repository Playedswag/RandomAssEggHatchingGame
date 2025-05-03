task.wait(3)

local ServerStorage = game:GetService("ServerStorage")
local ModuleFolder = ServerStorage:WaitForChild("Modules")
local PetsManageModule = require(ModuleFolder:WaitForChild("PetsManageModule"))
local Players = game:GetService("Players")

local player = Players:GetPlayerByUserId(521809119)

PetsManageModule.AddPet(player, "1")
for i = 1, 8 do
	PetsManageModule.AddPet(player, i)
end
