function makeSure()
    for i,v in pairs(game:GetService("Workspace").Boards:GetChildren()) do
        if v.Player1.Value == game:GetService("Players").LocalPlayer or v.Player2.Value == game:GetService("Players").LocalPlayer then
            return true
        end
    end
    return nil
end

repeat wait() until makeSure() == true

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("Pop It Trading", "Serpent")

local MainTab = Window:NewTab("Main")

local MainSection = MainTab:NewSection("Main")

function getArea()
    for i,v in pairs(game:GetService("Workspace").Boards:GetChildren()) do
        if v.Player1.Value == game:GetService("Players").LocalPlayer or v.Player2.Value == game:GetService("Players").LocalPlayer then
            return v 
        end
    end
    return nil
end

local Area = getArea()

local p = false

MainSection:NewKeybind("Scam Keybind", "change the keybind to scam people!", Enum.KeyCode.Q, function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = Area.Controls.Close.Pad.CFrame + Vector3.new(0,2,0)
    wait(0.2)
    p = false
    spawn(function()
    	repeat
	game:GetService("ReplicatedStorage").RemoteEvents.Jumped:FireServer()
	wait()
	until p == true
    end)
    wait(0.24)
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = Area.Controls.Done.Pad.CFrame + Vector3.new(0,2,0)
    wait(0.1)
    p = true
end)

game:GetService("RunService").RenderStepped:Connect(function()
    Area = getArea()
end)
