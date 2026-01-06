local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local espEnabled = false
local activeESPHighlights = {} 

local function updatePlayerESP(player)
    if player == LocalPlayer or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        if activeESPHighlights[player.UserId] then
            activeESPHighlights[player.UserId]:Destroy()
            activeESPHighlights[player.UserId] = nil
        end
        return
    end

    local highlight = activeESPHighlights[player.UserId]
    if espEnabled and not highlight then
      
        highlight = Instance.new("Highlight")
        highlight.Name = "Erobit_ESP_" .. player.UserId
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0
        highlight.FillTransparency = 0.5
        activeESPHighlights[player.UserId] = highlight
    elseif not espEnabled and highlight then
        
        highlight:Destroy()
        activeESPHighlights[player.UserId] = nil
        return
    end

    if highlight then
        if espEnabled then
           
            if player.Team == LocalPlayer.Team then
                highlight.FillColor = Color3.fromRGB(0, 0, 255) 
            else
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
            end
            highlight.Parent = player.Character 
        else
            highlight:Destroy() 
            activeESPHighlights[player.UserId] = nil
        end
    end
end


RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        updatePlayerESP(player)
    end
end)


Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        updatePlayerESP(player)
    end)
    updatePlayerESP(player)
end)

Players.PlayerRemoving:Connect(function(player)
    if activeESPHighlights[player.UserId] then
        activeESPHighlights[player.UserId]:Destroy()
        activeESPHighlights[player.UserId] = nil
    end
end)



local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "Erobit_ModMenu"
ScreenGui.ResetOnSpawn = false 

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 150, 0, 80) 
MainFrame.Position = UDim2.new(0.01, 0, 0.2, 0) 
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Draggable = true 

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Text = "EROBIT MODS"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local EspToggleButton = Instance.new("TextButton", MainFrame)
EspToggleButton.Size = UDim2.new(0.9, 0, 0.4, 0)
EspToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
EspToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
EspToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspToggleButton.Text = "ESP: OFF"
EspToggleButton.Font = Enum.Font.SourceSansBold
EspToggleButton.TextSize = 16

local function updateEspButtonText()
    if espEnabled then
        EspToggleButton.Text = "ESP: ON"
        EspToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0) 
    else
        EspToggleButton.Text = "ESP: OFF"
        EspToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) 
    end
end

EspToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateEspButtonText()
    -- Beim Umschalten alle Spieler-ESPs aktualisieren
    for _, player in pairs(Players:GetPlayers()) do
        updatePlayerESP(player)
    end
end)

updateEspButtonText() 
