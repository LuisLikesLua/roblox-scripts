-- game:GetService("StarterGui"):SetCore("SendNotification", {
-- 	Title = "ESP launched",
-- 	Text = "Find those scavs!",
-- 	Duration = 3
-- })

-- local guis = {}

-- while task.wait(2) do
-- 	for _,v in pairs(guis) do
-- 		v:Destroy()
-- 	end
  
-- 	for _,v in pairs(workspace.activeHostiles:GetChildren()) do
-- 		if not v:FindFirstChild("Humanoid") then continue end
-- 		if game.Players:GetPlayerFromCharacter(v) then continue end

-- 		local gui = Instance.new("BillboardGui")
-- 		gui.Size = UDim2.new(4, 0, 6, 0)
-- 		gui.AlwaysOnTop = true
-- 		gui.LightInfluence = 0
-- 		gui.Parent = v.Torso
-- 		table.insert(guis, gui)
		
-- 		local frame = Instance.new("Frame")
-- 		frame.Size = UDim2.new(1, 0, 1, 0)
-- 		frame.BackgroundTransparency = 1
-- 		frame.Parent = gui
-- 		task.spawn(function()
-- 			local healthFrame = Instance.new("Frame")
-- 			healthFrame.Parent = gui
-- 			healthFrame.BorderSizePixel = 0
-- 			healthFrame.BackgroundTransparency = 0.5
-- 			healthFrame.BackgroundColor3 = Color3.new(1,0,0)
			
-- 			while task.wait() do
-- 				if not healthFrame then return end
-- 				if not v.Parent then continue end
				
-- 				healthFrame.Size = UDim2.new(1,0,v.Humanoid.Health/v.Humanoid.MaxHealth,0)
-- 				healthFrame.Position = UDim2.new(0,0,1-(v.Humanoid.Health/v.Humanoid.MaxHealth),0)
-- 			end
-- 		end)
		
-- 		local stroke = Instance.new("UIStroke")
-- 		stroke.Thickness = 2
-- 		stroke.Parent = frame
-- 		stroke.Color = Color3.new(0.2,0.2,0.2)
-- 	end
-- end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ESP launched",
    Text = "Find those scavs!",
    Duration = 3
})

local guis = {}

while task.wait(2) do
    
    -- Clear old GUIs
    for _, gui in ipairs(guis) do
        if gui then gui:Destroy() end
    end
    table.clear(guis)

    for _, model in ipairs(workspace.activeHostiles:GetChildren()) do
        local hum = model:FindFirstChild("Humanoid")
        if not hum then continue end

        local head = model:FindFirstChild("Head")
        if not head then continue end

        -- BillboardGui
        local gui = Instance.new("BillboardGui")
        gui.Size = UDim2.new(4, 0, 6, 0)
        gui.AlwaysOnTop = true
        gui.LightInfluence = 0
        gui.Adornee = head
        gui.Parent = head
        table.insert(guis, gui)

        -- Frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = gui

        -- Health bar
        task.spawn(function()
            local healthFrame = Instance.new("Frame")
            healthFrame.Parent = frame
            healthFrame.BorderSizePixel = 0
            healthFrame.BackgroundTransparency = 0.5
            healthFrame.BackgroundColor3 = Color3.new(1, 0, 0)

            while task.wait() do
                if not hum.Parent then
                    healthFrame:Destroy()
                    return
                end

                local ratio = hum.Health / hum.MaxHealth
                healthFrame.Size = UDim2.new(1, 0, ratio, 0)
                healthFrame.Position = UDim2.new(0, 0, 1 - ratio, 0)
            end
        end)

        -- Outline
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = Color3.new(0.2, 0.2, 0.2)
        stroke.Parent = frame
    end
end
