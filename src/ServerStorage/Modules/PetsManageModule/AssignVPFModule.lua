local ServerStorage = game:GetService("ServerStorage")
local PetsTable = require(script.Parent:WaitForChild("PetsTable"))
local RS = game:GetService("ReplicatedStorage")


local ModuleFolder = ServerStorage:WaitForChild("Modules")
local GuiFolder = RS:WaitForChild("Gui")
local PetsFolder = RS:WaitForChild("Pets")

local PetModel = PetsFolder:WaitForChild("PetModels")
local TextLabelColor = PetsFolder:WaitForChild("RarityColors"):WaitForChild("TextLabelColor")
local VPFColor = PetsFolder:WaitForChild("RarityColors"):WaitForChild("VPFColor")
local BasePetVPF = GuiFolder:WaitForChild("CostumePetVPF"):WaitForChild("BasePetVPF")


local function getModel(pet)
	for _, Model in PetModel:GetChildren() do
		if Model:FindFirstChild("ID") then
			if Model.ID.Value == pet.ID then
				local PetModelClone = Model:Clone()
				
				if PetModelClone:FindFirstChild("CFrameVPF") then
					PetModelClone.CFrame = PetModelClone.CFrameVPF.Value
				else
					warn("Error! model: ", Model, " does not contain a CframeValue!")
				end
				
				return PetModelClone
			end
		else
			warn("Error! model: ", Model, " does not contain a ID!")
		end
	end
end

local function GetRarity(pet)
	return pet.Rarity
end


local function GetVPFColor(pet)
	local Rarity = GetRarity(pet)
	if VPFColor[Rarity] then
		
		local PetVPFColor = VPFColor[Rarity]
		
		return PetVPFColor.Value
	else
		warn("Error Model with ID:", pet, " Does not contain a VPFColor")
	end
end


local function GetTextLabelColor(pet)
	local Rarity = GetRarity(pet)
	if TextLabelColor[Rarity] then

		local PetTextLabelColor = TextLabelColor[Rarity]
		
		return PetTextLabelColor.Value
	else
		warn("Error Model with ID:", pet, " Does not contain a TextLabelColor")
	end
end

local function BuildVPF (Player, ID, UID)
	

	for v, Pet in PetsTable.Pets do
		if Pet.ID then
			if Pet.ID == ID then
				local PetVPF = BasePetVPF:Clone()
				local RarityLabel = PetVPF:WaitForChild("RarityLabel")
				local PlayerGui = Player:WaitForChild("PlayerGui")
				local InventoryGui = PlayerGui:WaitForChild("InventoryGui")
				local InventoryFrame = InventoryGui:WaitForChild("MainInventoryFrame"):WaitForChild("InventoryFrame")

				local CorrectPetModel = getModel(Pet)
				local CorrectVPFColor = GetVPFColor(Pet)
				local CorrectTextLabelColor = GetTextLabelColor(Pet)
				local Rarity = GetRarity(Pet)
				local UniqueIDValue = PetVPF:WaitForChild("UniqueID")
				
				UniqueIDValue.Value = UID
				PetVPF.BackgroundColor3	= CorrectVPFColor
				RarityLabel.TextColor3 = CorrectTextLabelColor
				RarityLabel.Text = Rarity
				CorrectPetModel.Parent = PetVPF
				PetVPF.Parent = InventoryFrame
				PetVPF.Name = "PetVPF"
				
			
			end
		end
	end
	
end

local function RemoveVPF(Player, UID)
	local PlayerGui = Player:WaitForChild("PlayerGui")
	local InventoryGui = PlayerGui:WaitForChild("InventoryGui")
	local InventoryFrame = InventoryGui:WaitForChild("MainInventoryFrame"):WaitForChild("InventoryFrame")
	for _, VPF in pairs(InventoryFrame:GetChildren()) do
		if VPF.Name == "PetVPF" then
			if VPF:FindFirstChild("UniqueID") then
				if VPF.UniqueID.Value == UID then
					VPF:Destroy()
				end
			end
		end
	end
end

return {
	AddPetVPF = function (Player:Player, ID:number, UID)
		BuildVPF(Player, ID, UID)
	end,
	
	RemovePetVPF = function (Player:Player, UID)
		RemoveVPF(Player, UID)
	end,
	
}