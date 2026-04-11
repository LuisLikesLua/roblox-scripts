game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "ESP launched",
	Text = "Find those peeps!",
	Duration = 3
})

while task.wait(2) do
	for _,v in pairs(game.Players:GetChildren()) do
		if v == game.Players.LocalPlayer then continue end
		if not v.Character then continue end
		if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
		if v.Character.HumanoidRootPart:FindFirstChild("ESP_ATT") then continue end

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
			healthFrame.BackgroundTransparency = 0.7
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
    
		local espAtt = Instance.new("Attachment")
		espAtt.Name = "ESP_ATT"
		espAtt.Parent = v.Character.HumanoidRootPart
	end
end
