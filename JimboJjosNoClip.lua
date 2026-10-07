--// NoClipV1 by JimboJjos

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local noclip = false

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NoClipV1"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Маленькая кнопка открытия
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.fromOffset(35, 35)
openButton.Position = UDim2.fromOffset(15, 150)
openButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
openButton.Text = "N"
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.TextSize = 18
openButton.Font = Enum.Font.GothamBold
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = openButton

-- Основное окно
local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.fromOffset(220, 105)
frame.Position = UDim2.fromOffset(55, 145)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(65, 65, 75)
stroke.Thickness = 1
stroke.Parent = frame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.fromOffset(10, 5)
title.BackgroundTransparency = 1
title.Text = "NoClipV1 by JimboJjos"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(25, 25)
closeButton.Position = UDim2.new(1, -32, 0, 8)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(180, 180, 180)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame

-- Кнопка NoClip
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -20, 0, 45)
toggle.Position = UDim2.fromOffset(10, 50)
toggle.BackgroundColor3 = Color3.fromRGB(150, 45, 45)
toggle.Text = "NoClip: OFF"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 15
toggle.Font = Enum.Font.GothamBold
toggle.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 7)
toggleCorner.Parent = toggle

local function updateButton()
	if noclip then
		toggle.Text = "NoClip: ON"
		toggle.BackgroundColor3 = Color3.fromRGB(45, 170, 75)
	else
		toggle.Text = "NoClip: OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(150, 45, 45)
	end
end

toggle.MouseButton1Click:Connect(function()
	noclip = not noclip
	updateButton()
end)

openButton.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

RunService.Stepped:Connect(function()
	if not noclip then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
end)

player.CharacterAdded:Connect(function(character)
	character:WaitForChild("HumanoidRootPart")

	if noclip then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

updateButton()
