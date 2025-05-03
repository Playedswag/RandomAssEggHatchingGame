local InventoryGui = script.Parent.Parent.Parent.InventoryGui
local UIS = game:GetService("UserInputService")

local function ToggleGui  ()
	if InventoryGui.Enabled == true then
		InventoryGui.Enabled = false
		script.Parent.Text = "Open Inventory"
	else
		InventoryGui.Enabled = true
		script.Parent.Text = "Close Inventory"
	end
end

script.Parent.MouseButton1Down:Connect(function ()
	ToggleGui()
end)

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.B then
		ToggleGui()
	end
end)


