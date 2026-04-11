game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "ESP launched",
	Text = "Find those peeps!",
	Duration = 3
})

local thisAtt
local alive = true
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	task.wait(1)
	alive = true
	
	thisAtt = Instance.new("Attachment")
	thisAtt.Parent = char.HumanoidRootPart

	char.Humanoid.Died:Connect(function()
		alive = false
	end)
end)

while task.wait(2) do
	if not alive then task.wait(1) continue end
  
	for _,v in pairs(game.Players:GetChildren()) do
		if v == game.Players.LocalPlayer then continue end
		if not v.Character then continue end
		if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
		local oldAtt =  v.Character.HumanoidRootPart:FindFirstChild("ESP_ATT")
		if oldAtt then oldAtt:Destroy() end

		local teamColor = v.TeamColor.Color

		local gui = Instance.new("BillboardGui")
		gui.Adornee = v.Character.Torso or v.Character.HumanoidRootPart
		gui.Size = UDim2.new(4, 0, 6, 0)
		gui.AlwaysOnTop = true
		gui.LightInfluence = 0
		gui.Parent = v.Character.Head
		
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundTransparency = 1
		frame.Parent = gui
		task.spawn(function()
			local healthFrame = Instance.new("Frame")
			healthFrame.Parent = gui
			healthFrame.BackgroundTransparency = 0.5
			healthFrame.BackgroundColor3 = Color3.new(1,0,0)
			
			while task.wait() do
				if not healthFrame then return end
				if not (v.Character and v.Character:FindFirstChildOfClass("Humanoid")) then continue end
				
				healthFrame.Size = UDim2.new(1,0,v.Character.Humanoid.Health/v.Character.Humanoid.MaxHealth,0)
				healthFrame.Position = UDim2.new(0,0,1-(v.Character.Humanoid.Health/v.Character.Humanoid.MaxHealth),0)
			end
		end)
		
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Parent = frame
		stroke.Color = teamColor

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Text = v.Name.." ("..v.UserId..")"
		nameLabel.Parent = gui
		nameLabel.Size = UDim2.new(1,0,0.1,0)
		nameLabel.Position = UDim2.new(0,0,1,0)
		nameLabel.BackgroundTransparency = 1
		nameLabel.BorderSizePixel = 0
		nameLabel.TextScaled = true
		nameLabel.TextColor = teamColor
    
		local espAtt = Instance.new("Attachment")
		espAtt.Name = "ESP_ATT"
		espAtt.Parent = v.Character.HumanoidRootPart
    
		local espBeam = Instance.new("Beam")
		espBeam.Parent = v.Character
		espBeam.Color = ColorSequence.new(teamColor)
		
		espBeam.Width0 = 0.1
		espBeam.Width1 = 0.1
		espBeam.Attachment0 = thisAtt
		espBeam.Attachment1 = espAtt
		
		espBeam.FaceCamera = true
	end
end
