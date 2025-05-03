task.wait(1)

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ModulesFolder = ServerStorage:WaitForChild("Modules")
local DataStoreModule = require(ModulesFolder:WaitForChild("DataStoreModule"))
local DefaultData = require(script.Parent.Parent:WaitForChild("DataHandle"):WaitForChild("DefaultData"))
local DataTable = require(ModulesFolder:WaitForChild("DataTable"))


local Player = Players:GetPlayerByUserId(521809119)


DataTable.AddPlayerToData(Player, DefaultData)
