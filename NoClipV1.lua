local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local noclip = false
local connection

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NoClipV1"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 110)
frame.Position = UDim2.new(0, 20, 0.5, -55)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "NoClipV1 by JimboJjos"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 50)
button.Position = UDim2.new(0, 10, 0, 48)
button.BackgroundColor3 = Color3.fromRGB(170, 45, 45)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "NoClip: OFF"
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = button

-- Включение/выключение
local function setNoclip(state)
    noclip = state

    if noclip then
        button.Text = "NoClip: ON"
        button.BackgroundColor3 = Color3.fromRGB(45, 170, 70)

        if connection then
            connection:Disconnect()
        end

        connection = RunService.Stepped:Connect(function()
            local character = player.Character

            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        button.Text = "NoClip: OFF"
        button.BackgroundColor3 = Color3.fromRGB(170, 45, 45)

        if connection then
            connection:Disconnect()
            connection = nil
        end

        -- Полностью возвращаем столкновения
        local character = player.Character

        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

button.MouseButton1Click:Connect(function()
    setNoclip(not noclip)
end)

-- После респавна состояние сохраняется
player.CharacterAdded:Connect(function()
    task.wait(0.5)

    if noclip then
        setNoclip(true)
    else
        setNoclip(false)
    end
end)
