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

local Window = Library.CreateLib("Pop It Trading", "Synapse")

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

MainSection:NewKeybind("Scam Keybind", "change the keybind to scam people!", Enum.KeyCode.Q, function()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = Area.Controls.Close.Pad.CFrame + Vector3.new(0,2,0)
    wait(0.2)
    game:GetService("ReplicatedStorage").RemoteEvents.Jumped:FireServer()
    wait(0.24)
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = Area.Controls.Done.Pad.CFrame + Vector3.new(0,2,0)
    wait(0.15)
    game:GetService("ReplicatedStorage").RemoteEvents.Jumped:FireServer()
end)

game:GetService("RunService").RenderStepped:Connect(function()
    Area = getArea()
end)
