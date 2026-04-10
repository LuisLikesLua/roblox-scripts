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
local guis = {}

while task.wait(2) do
	if not alive then task.wait(1) continue end
	
	for _,v in pairs(atts) do
		v:Destroy()
	end
  
	for _,v in pairs(beams) do
		v:Destroy()
	end

	for _,v in pairs(guis) do
		v:Destroy()
	end
  
	for _,v in pairs(game.Players:GetChildren()) do
		if v == game.Players.LocalPlayer then continue end
		if not v.Character then continue end
		if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
		if v.Character.HumanoidRootPart:FindFirstChild("ESP_ATT") then continue end

		local teamColor = v.TeamColor.Color

		local gui = Instance.new("BillboardGui")
		gui.Size = UDim2.new(1, 0, 1, 0)
		gui.AlwaysOnTop = true
		gui.LightInfluence = 0
		gui.Parent = v.Character
		table.insert(guis, gui)
		
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.Parent = gui

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Color = teamColor
    
		local espAtt = Instance.new("Attachment")
		espAtt.Name = "ESP_ATT"
		espAtt.Parent = v.Character.HumanoidRootPart
		table.insert(atts, espAtt)
    
		local espBeam = Instance.new("Beam")
		espBeam.Parent = v.Character
		espBeam.Color = ColorSequence.new(teamColor)
		
		espBeam.Width0 = 0.15
		espBeam.Width1 = 0.1
		espBeam.Attachment0 = thisAtt
		espBeam.Attachment1 = espAtt
		
		espBeam.FaceCamera = true
		table.insert(beams, espBeam)
	end
end
