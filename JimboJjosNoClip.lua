local originalCollision = {}

local function enableNoclip()
	noclip = true

	local character = player.Character
	if not character then return end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			originalCollision[part] = part.CanCollide
			part.CanCollide = false
		end
	end

	updateButton()
end

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

toggle.MouseButton1Click:Connect(function()
	if noclip then
		disableNoclip()
	else
		enableNoclip()
	end
end)

RunService.Stepped:Connect(function()
	if not noclip then
		return
	end

	local character = player.Character
	if not character then return end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
		end
	end
end)
