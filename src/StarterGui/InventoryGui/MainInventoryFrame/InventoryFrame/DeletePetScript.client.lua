local rs = game:GetService("ReplicatedStorage")
local remotes = rs:WaitForChild("Remotes")
local ClientAcessRemote = remotes:WaitForChild("ClientAcessRemote")
local ConfirmFrame = script.Parent.Parent:WaitForChild("ConfirmationFrame")
local DeleteRemote = remotes:WaitForChild("DeletePetRemote")
local player = game:GetService("Players").LocalPlayer 
local interupted = false

script.Parent.ChildAdded:Connect(function(child)
	if child.Name == "PetVPF" then
		local DeleteButton = child:FindFirstChild("DeleteButton")
		if DeleteButton then
			DeleteButton.MouseButton1Down:Connect(function ()
				if not interupted then
					interupted = true
					local UID = DeleteButton.Parent.UniqueID.Value
					ConfirmFrame.Visible = true

					ConfirmFrame.NoButton.MouseButton1Down:Connect(function ()
						ConfirmFrame.Visible = false
						interupted = false
						return
					end)

					ConfirmFrame.YesButton.MouseButton1Down:Connect(function ()
						DeleteRemote:FireServer(UID)
						ConfirmFrame.Visible = false
						interupted = false
					end)
				end
				
				
				
				
				end)
			end
		end
	end)