_G.autoCollectLootBags = false
_G.autoCollectOrbs = false

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Pet Simulator X", "Serpent")

local MainTab = Window:NewTab("Main")

local MainSection = MainTab:NewSection("Main")

local TeleportTab = Window:NewTab("Teleports")

local TeleportSection = TeleportTab:NewSection("Teleports")

local EggsTab = Window:NewTab("Eggs")

local EggsSection = EggsTab:NewSection("Eggs")

local LocalPlayerTab = Window:NewTab("LocalPlayer")

local LocalPlayerSection = LocalPlayerTab:NewSection("LocalPlayer")

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))

getgenv().teleportArea = ""

    for i,v in pairs(getgc(true)) do
        if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
            v.OpenEgg = function()
            return
        end
    end
end

MainSection:NewToggle("Unlock Some Gamepass", "gives some gamepasses!", function(state)
    if state then
        local gmppath = require(game:GetService("ReplicatedStorage").Framework.Modules.Client["5 | Gamepasses"])
        gmppath.Owns = function() return true end
    else
        local gmppath = require(game:GetService("ReplicatedStorage").Framework.Modules.Client["5 | Gamepasses"])
        gmppath.Owns = function() return false end
    end
end)

MainSection:NewToggle("Unlock Collect Orbs", "auto collects orbs!", function(state)
    if state then
        _G.autoCollectOrbs = true
        while true do wait()
            if _G.autoCollectOrbs == true then
                for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
                    workspace.__THINGS.__REMOTES["claim orbs"]:FireServer({{v.Name}}) 
                end
            end
        end
    else
        _G.autoCollectOrbs = false
    end
end)

MainSection:NewToggle("Unlock Collect Lootbags", "auto collects lootbags!", function(state)
    if state then
        _G.autoCollectLootBags = true
        while true do wait()
            if _G.autoCollectLootBags == true then
                for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                    v.CFrame = game:GetService("Players").LocalPlayer.Character.Head.CFrame
                end
            end
        end
    else
        _G.autoCollectLootBags = false
    end
end)

TeleportSection:NewDropdown("Secret Area", "select secret area!", {"Pog", "Dominus"}, function(currentOption)
    getgenv().teleportArea = currentOption
end)

TeleportSection:NewButton("Teleport", "Teleports to secret area!", function()
    if getgenv().teleportArea == "Pog" then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__MAP"].Eggs["Pog-Secret"].PLATFORM.SectionName.CFrame
    else
        if getgenv().teleportArea == "Dominus" then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__MAP"].Eggs.Secret.PLATFORM.SectionName.CFrame
        end
    end
end)

LocalPlayerSection:NewButton("Rejoin", "rejoins the server!", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
end)

LocalPlayerSection:NewSlider("Walkspeed", "changes your walkspeed!", 150, 16, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

LocalPlayerSection:NewButton("Use Triple Coins", "uses triple coins(boost)!", function()
    local args = {
	    [1] = "Triple Coins"
    }
    workspace.__THINGS.__REMOTES["activate boost"]:FireServer(args)
end)

LocalPlayerSection:NewButton("Use Super Lucky", "uses super lucky(boost)!", function()
    local args1 = {
	    [1] = "Super Lucky"
    }
    workspace.__THINGS.__REMOTES["activate boost"]:FireServer(args1)
end)

LocalPlayerSection:NewButton("Use Ultra Lucky", "uses ultra lucky(boost)!", function()
    local args2 = {
	    [1] = "Ultra Lucky"
    }
    workspace.__THINGS.__REMOTES["activate boost"]:FireServer(args2)
end)

wait(1)

v1.Message.New("Thanks for using this script! Welcome " .. game:GetService("Players").LocalPlayer.DisplayName .. "!")
