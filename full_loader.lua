-- loader by fluntInLua
-- warning: may be laggy at startup

pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuisLikesLua/roblox-scripts/refs/heads/main/ESP.lua"))() end)
pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/lilmond/roblox_fly_script/refs/heads/main/latest.lua'))() end)
pcall(function() loadstring(game:HttpGet("https://gist.githubusercontent.com/BROgenesis/958c1fee7d8ad100da7f7d020d5d67f3/raw/8dc95caca1b46aa9f4d9dd2433f6be3d9bc69e45/Dex++"))() end)

game.StarterGui:SetCore("SendNotification", {
    Title = "script loader by fluentInLua",
    Text = "t: fly, y: invisibility",
    Icon = "rbxassetid://80299620044974",
    Duration = 5
})
