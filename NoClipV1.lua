--// NoClipV1 by JimboJjos

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local noclip = false
local originalCollision = {}

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "NoClipV1"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Кнопка открытия
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.fromOffset(40, 40)
openButton.Position = UDim2.fromOffset(15, 150)
openButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
openButton.BorderSizePixel = 0
openButton.Text = "N"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 18
openButton.Font = Enum.Font.GothamBold
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 9)
openCorner.Parent = openButton

-- Основное окно
local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.fromOffset(290, 125)
frame.Position = UDim2.fromOffset(60, 145)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(65, 65, 75)
frameStroke.Thickness = 1
frameStroke.Parent = frame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 35)
title.Position = UDim2.fromOffset(12, 5)
title.BackgroundTransparency = 1
title.Text = "NoClipV1 by JimboJjos"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(30, 30)
closeButton.Position = UDim2.new(1, -38, 0, 7)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(180, 180, 180)
closeButton.TextSize = 22
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame

-- Кнопка NoClip
local toggle = Instance.new("TextButton")
toggle.Name = "NoClipToggle"
toggle.Size = UDim2.new(1, -24, 0, 52)
toggle.Position = UDim2.fromOffset(12, 58)
toggle.BackgroundColor3 = Color3.fromRGB(160, 45, 45)
toggle.BorderSizePixel = 0
toggle.Text = "NoClip: OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.TextSize = 16
toggle.Font = Enum.Font.GothamBold
toggle.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggle

--==================================================
-- Состояние кнопки
--==================================================

local function updateButton()
	if noclip then
		toggle.Text = "NoClip: ON"
		toggle.BackgroundColor3 = Color3.fromRGB(45, 175, 75)
	else
		toggle.Text = "NoClip: OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(160, 45, 45)
	end
end

--==================================================
-- Включение
--==================================================

local function enableNoclip()
	noclip = true

	local character = player.Character
	if not character then
		updateButton()
		return
	end

	originalCollision = {}

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			originalCollision[part] = part.CanCollide
			part.CanCollide = false
		end
	end

	updateButton()
end

--==================================================
-- Выключение
--==================================================

local function disableNoclip()
	noclip = false

	local character = player.Character

	if character then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				if originalCollision[part] ~= nil then
					part.CanCollide = originalCollision[part]
				else
					part.CanCollide = true
				end
			end
		end
	end

	originalCollision = {}

	updateButton()
end

--==================================================
-- Кнопки GUI
--==================================================

toggle.MouseButton1Click:Connect(function()
	if noclip then
		disableNoclip()
	else
		enableNoclip()
	end
end)

openButton.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

--==================================================
-- NoClip
--==================================================

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

--==================================================
-- Респавн
--==================================================

player.CharacterAdded:Connect(function(character)

	originalCollision = {}

	character:WaitForChild("HumanoidRootPart")

	if noclip then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				originalCollision[part] = part.CanCollide
				part.CanCollide = false
			end
		end
	end
end)

updateButton()
