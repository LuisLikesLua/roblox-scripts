game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ESP launched",
    Text = "Find those scavs!",
    Duration = 3
})

local guis = {}

while task.wait(2) do
    for _, gui in pairs(guis) do
        if gui then gui:Destroy() end
    end

    for _, model in pairs(workspace.activeHostiles:GetChildren()) do
        local hum = model:FindFirstChild("Humanoid")
        if not hum then continue end

        local head = model:FindFirstChild("Head")
        if not head then continue end

        local gui = Instance.new("BillboardGui")
        gui.Size = UDim2.new(4, 0, 6, 0)
        gui.AlwaysOnTop = true
        gui.LightInfluence = 0
        gui.Adornee = head
        gui.Parent = head
        table.insert(guis, gui)

		local weapon = model:FindFirstChildOfClass("Model")
		local weaponLabel = Instance.new("TextLabel")
		weaponLabel.Parent = gui
		weaponLabel.Size = UDim2.new(1,0,0.1,0)
		weaponLabel.Position = UDim2.new(0,0,1.1,0)
		weaponLabel.TextScaled = true
		weaponLabel.Text = weapon.Name
		
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = gui

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

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 2
        stroke.Color = Color3.new(0.2, 0.2, 0.2)
        stroke.Parent = frame
    end
end
