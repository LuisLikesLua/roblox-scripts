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


local atts = {}
local beams = {}
local highs = {}

while task.wait(2) do
	if not alive then task.wait(1) continue end
	
	for _,v in pairs(atts) do
		v:Destroy()
	end
  
	for _,v in pairs(beams) do
		v:Destroy()
	end

	for _,v in pairs(highs) do
		v:Destroy()
	end
  
	for _,v in pairs(game.Players:GetChildren()) do
		if v == game.Players.LocalPlayer then continue end
		if not v.Character then continue end
		if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
		if v.Character.HumanoidRootPart:FindFirstChild("ESP_ATT") then continue end

		-- local teamColor = v.TeamColor.Color
		local teamColor = v.Character.Torso.Color

		local newHigh = Instance.new("Highlight")
		newHigh.FillTransparency = 1
		newHigh.OutlineColor = teamColor
		newHigh.Parent = v.Character
		table.insert(highs, newHigh)
    
		local espAtt = Instance.new("Attachment")
		espAtt.Name = "ESP_ATT"
		espAtt.Parent = v.Character.HumanoidRootPart
		table.insert(atts, espAtt)
    
		local espBeam = Instance.new("Beam")
		espBeam.Parent = v.Character
		espBeam.Color = ColorSequence.new(teamColor)
		
		espBeam.Width0 = 0.2
		espBeam.Width1 = 0.2
		espBeam.Attachment0 = thisAtt
		espBeam.Attachment1 = espAtt
		
		espBeam.FaceCamera = true
		table.insert(beams, espBeam)
	end
end
