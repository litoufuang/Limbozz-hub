-- Limbozz Hub GUI for Roblox (using Orion UI Library)
-- Includes: Main (User Info), Menu (Cheats), Info (Links)
-- Features: Kill Aura, NoClip (safe), ESP, Fly, Anti-AFK, etc.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- UI Library loader
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = Library:MakeWindow({
    Name = "Limbozz Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "LimbozzHub"
})

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main"
    Icon = "rbxassetid://103039372212389", -- Replace with your logo asset ID
    PremiumOnly = false
})

MainTab:AddParagraph("👤 Player Info", "Username: " .. LocalPlayer.Name)

-- Menu Tab
local MenuTab = Window:MakeTab({
    Name = "Menu",
    Icon = "rbxassetid://103039372212389",
    PremiumOnly = false
})

-- Toggle Buttons
local killAuraEnabled = false
local noclipEnabled = false

MenuTab:AddToggle({
    Name = "Kill Aura",
    Default = false,
    Callback = function(value)
        killAuraEnabled = value
    end
})

MenuTab:AddToggle({
    Name = "NoClip (không rớt void)",
    Default = false,
    Callback = function(value)
        noclipEnabled = value
    end
})

MenuTab:AddButton({
    Name = "Fly",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/YkPqg3wY"))()
    end
})

MenuTab:AddButton({
    Name = "ESP",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/xHjDHMqK"))()
    end
})

MenuTab:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
})

-- Info Tab
local InfoTab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://103039372212389",
    PremiumOnly = false
})

InfoTab:AddParagraph("📌 Discord", "https://discord.gg/GkH8J5sG9P")
InfoTab:AddParagraph("📺 YouTube", "https://www.youtube.com/@nguyntuansphi")
InfoTab:AddParagraph("🎵 TikTok", "https://www.tiktok.com/@nguyn.tun.phi")

-- Kill Aura Logic
RunService.RenderStepped:Connect(function()
    if killAuraEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                local distance = (Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance <= 10 then
                    player.Character.Humanoid:TakeDamage(10)
                end
            end
        end
    end
end)

-- NoClip Logic (Safe from void)
RunService.Stepped:Connect(function()
    if noclipEnabled and Character then
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
        if Character:FindFirstChild("HumanoidRootPart") and Character.HumanoidRootPart.Position.Y < -100 then
            Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end
    end
end)

-- Ready Message
Library:Notify({Name = "Limbozz Hub", Content = "Loaded successfully!", Time = 5})
local LogoButton = Instance.new("TextButton")
LogoButton.Name = "LogoButton"
LogoButton.Size = UDim2.new(0, 40, 0, 40)
LogoButton.Position = UDim2.new(0, 20, 0, 100)
LogoButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LogoButton.BackgroundTransparency = 0.3
LogoButton.BorderSizePixel = 1
LogoButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
LogoButton.AutoButtonColor = true
LogoButton.Text = ""
LogoButton.Parent = ScreenGui
LogoButton.Visible = false

local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(1, 0, 1, 0)
logoImage.BackgroundTransparency = 1
logoImage.Image = "rbxassetid://103039372212"
logoImage.Parent = LogoButton
