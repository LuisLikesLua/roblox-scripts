game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "ESP launched",
	Text = "Find those scavs!",
	Duration = 3
})

local guis = {}

while task.wait(2) do
	for _,v in pairs(guis) do
		v:Destroy()
	end
  
	for _,v in pairs(workspace:GetDescendants()) do
		if not v:IsA("Humanoid") then continue end
		if game.Players:GetPlayerFromCharacter(v.Parent) then continue end

		local gui = Instance.new("BillboardGui")
		gui.Size = UDim2.new(4, 0, 6, 0)
		gui.AlwaysOnTop = true
		gui.LightInfluence = 0
		gui.Parent = v.Parent
		table.insert(guis, gui)
		
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
				if not v.Parent then continue end
				
				healthFrame.Size = UDim2.new(1,0,v.Health/v.MaxHealth,0)
				healthFrame.Position = UDim2.new(0,0,1-(v.Health/v.MaxHealth),0)
			end
		end)
		
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Parent = frame
		stroke.Color = teamColor
	end
end
