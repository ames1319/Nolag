-- 🔃 Slower Loading Screen (1% to 100%) by Zein Corte
-- 👇 CONTINUE with your main script here

-- 🔃 Slower Loading Screen (1% to 100%) by Zein Corte
-- 👇 CONTINUE with your main script here

-- 🔃 Slower Loading Screen (1% to 100%) by Zein Corte
-- 👇 CONTINUE with your main script here

-- Zein GUI v2 with Dark Tech Background

-- 🔃 Slower Loading Screen
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 400, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingFrame.BackgroundTransparency = 0.3
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = screenGui
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local barBackground = Instance.new("Frame", loadingFrame)
barBackground.Size = UDim2.new(1, -40, 0, 30)
barBackground.Position = UDim2.new(0, 20, 0.5, 10)
barBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBackground.BorderSizePixel = 0
Instance.new("UICorner", barBackground).CornerRadius = UDim.new(0, 8)

local barFill = Instance.new("Frame", barBackground)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 203, 0)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 8)

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1, 0, 0, 40)
loadingText.Position = UDim2.new(0, 0, 0.2, -20)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading... 1%"
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold

-- Simulate loading
for i = 1, 100 do
	loadingText.Text = "Loading... " .. i .. "%"
	barFill:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Quad", 0.1, true)
	task.wait(0.1)
end
screenGui:Destroy()

-- 🧩 Main GUI Setup
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "ZeinPetGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0, 20, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- 🆕 Background: Dark Tech Style
local bgImage = Instance.new("ImageLabel", mainFrame)
bgImage.Size = UDim2.new(1, 0, 0, 240)
bgImage.Position = UDim2.new(0, 0, 0, 0)
bgImage.Image = "rbxassetid://11372852158" -- Dark Tech background
bgImage.BackgroundTransparency = 1
bgImage.ZIndex = 0

-- 🖱️ Dragging support for mobile + PC
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos = false

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- 🐣 Pet Table (egg-to-pet)
local petTable = {
	["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
	["Uncommon Egg"] = { "Chicken", "Black Bunny", "Cat", "Deer" },
	["Rare Egg"] = { "Pig", "Monkey", "Rooster", "Orange Tabby", "Spotted Deer" },
	["Legendary Egg"] = { "Cow", "Polar Bear", "Sea Otter", "Turtle", "Silver Monkey" },
	["Mythical Egg"] = { "Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant" },
	["Bug Egg"] = { "Snail", "Caterpillar", "Giant Ant", "Praying Mantis, "Dragon Fly"" },
	["Night Egg"] = { "Frog", "Hedgehog", "Mole", "Echo Frog", "Night Owl" },
	["Bee Egg"] = { "Bee", "Honey Bee", "Bear Bee", "Petal Bee" },
	["Anti Bee Egg"] = { "Wasp", "Moth", "Tarantula Hawk" },
	["Oasis Egg"] = { "Meerkat", "Sand Snake", "Axolotl" },
	["Paradise Egg"] = { "Ostrich", "Peacock", "Capybara" },
	["Dinosaur Egg"] = { "Raptor", "Triceratops", "Stegosaurus" },
	["Primal Egg"] = { "Parasaurolophus", "Iguanodon", "Pachycephalosaurus" },
	["Zen Egg"] = { "Shiba Inu", "Nihonzaru", "Tanuki", "Tanchozuru", "Kappa", "Kitsune" }
}

local Workspace = game:GetService("Workspace")
local player = game.Players.LocalPlayer
local truePetMap, espEnabled, auto = {}, true, false
local zenESPMap = {}

-- 🔘 Button Creator
local function createButton(text, yPos, color)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.8, 0, 0.13, 0)
	btn.Position = UDim2.new(0.1, 0, yPos, 0)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextScaled = true
	return btn
end

-- 👁️ ESP System
local function removeESP(model)
	if model:FindFirstChild("ESPHighlight") then model.ESPHighlight:Destroy() end
	for _, v in pairs(model:GetDescendants()) do
		if v:IsA("BillboardGui") and v.Name == "PetBillboard" then v:Destroy() end
	end
end

local function showESP(model, petName, rolling)
	if model.Name == "Zen Egg" and zenESPMap[model] then return end
	removeESP(model)
	local part = model:FindFirstChildWhichIsA("BasePart", true)
	if not part then return end
	local gui = Instance.new("BillboardGui", model)
	gui.Name = "PetBillboard"
	gui.Size = UDim2.new(0, 200, 0, 30)
	gui.StudsOffset = Vector3.new(0, 4, 0)
	gui.AlwaysOnTop = true
	gui.Adornee = part
	local label = Instance.new("TextLabel", gui)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamSemibold
	label.TextScaled = true
	if rolling then
		for i = 1, 5 do
			label.Text = model.Name .. " | " .. petTable[model.Name][math.random(1, #petTable[model.Name])]
			task.wait(0.08)
		end
	end
	label.Text = model.Name .. " | " .. petName
	local hl = Instance.new("Highlight", model)
	hl.Name = "ESPHighlight"
	hl.FillColor = Color3.fromRGB(255, 200, 0)
	hl.OutlineColor = Color3.new(1, 1, 1)
	hl.FillTransparency = 0.7
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Adornee = model
	if model.Name == "Zen Egg" then zenESPMap[model] = true end
end

-- 🔍 Find eggs near the player (≤ 60 studs)
local function getNearbyEggs()
	local eggs = {}
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return eggs end
	for _, model in pairs(Workspace:GetDescendants()) do
		if model:IsA("Model") and petTable[model.Name] then
			local dist = (model:GetPivot().Position - root.Position).Magnitude
			if dist <= 60 then
				if not truePetMap[model] then
					local pool = petTable[model.Name]
					truePetMap[model] = pool[math.random(#pool)]
				end
				table.insert(eggs, model)
			end
		end
	end
	return eggs
end

-- 🔀 Randomize pets for each egg
local function randomizePets()
	for _, egg in pairs(getNearbyEggs()) do
		local pool = petTable[egg.Name]
		local pet = pool[math.random(#pool)]
		truePetMap[egg] = pet
		if espEnabled then showESP(egg, pet, auto) end
	end
end

------------------------------------------------------------------
-- 🟠 BUTTONS -----------------------------------------------------
------------------------------------------------------------------

-- Randomize once
local randBtn = createButton("Randomize Pets", 0.07, Color3.fromRGB(255, 140, 0))
randBtn.MouseButton1Click:Connect(randomizePets)

-- Toggle ESP
local espBtn = createButton("ESP: ON", 0.21, Color3.fromRGB(60, 60, 60))
espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espBtn.Text = espEnabled and "ESP: ON" or "ESP: OFF"

	if espEnabled then
		zenESPMap = {}
		for _, egg in pairs(getNearbyEggs()) do
			showESP(egg, truePetMap[egg] or "?", false)
		end
	else
		for _, egg in pairs(getNearbyEggs()) do removeESP(egg) end
		zenESPMap = {}
	end
end)

-- Auto‑randomize every 10 s (shows rolling ESP)
local autoBtn = createButton("Auto Random: OFF", 0.35, Color3.fromRGB(0, 170, 80))
autoBtn.MouseButton1Click:Connect(function()
	auto = not auto
	autoBtn.Text = auto and "Auto Random: ON" or "Auto Random: OFF"

	if auto then
		coroutine.wrap(function()
			while auto do
				randomizePets()          -- roll + ESP
				for i = 10, 1, -1 do     -- local cooldown
					if not auto then break end
					randBtn.Text = "Cooldown: " .. i .. "s"
					task.wait(1)
				end
				if auto then randBtn.Text = "Randomize Pets" end
			end
		end)()
	else
		randBtn.Text = "Randomize Pets"
	end
end)

------------------------------------------------------------------
-- 🕒 Cooldown / info label --------------------------------------
------------------------------------------------------------------
local cooldownLabel = Instance.new("TextLabel", mainFrame)
cooldownLabel.Size = UDim2.new(1, -20, 0, 20)
cooldownLabel.Position = UDim2.new(0, 10, 0.55, 0)
cooldownLabel.BackgroundTransparency = 1
cooldownLabel.Text = "Cooldown: Ready"
cooldownLabel.Font = Enum.Font.GothamSemibold
cooldownLabel.TextColor3 = Color3.new(1, 1, 1)
cooldownLabel.TextScaled = true

------------------------------------------------------------------
-- 🧪 Auto Age 50 -------------------------------------------------
------------------------------------------------------------------
local startAgeBtn = createButton("Start Age", 0.62, Color3.fromRGB(0, 170, 0))
Instance.new("UICorner", startAgeBtn).CornerRadius = UDim.new(0, 8)

local agingCooldown = false
startAgeBtn.MouseButton1Click:Connect(function()
	if agingCooldown then return end

	local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
	if not tool then
		cooldownLabel.Text = "No tool equipped."
		return
	end

	local toolName = tool.Name
	local currentAge = tonumber(toolName:match("Age%s*(%d+)"))
	if not currentAge then
		cooldownLabel.Text = "Age not found."
		return
	end

	local prefix = toolName:match("^(.-)%s*%[Age%s*%d+%]") or toolName
	agingCooldown = true
	startAgeBtn.Text = "Aging..."

	for i = currentAge + 1, 50 do
		tool.Name = prefix .. " [Age " .. i .. "]"
		task.wait(0.1)
	end

	startAgeBtn.Text = "Start Age"
	for i = 30, 1, -1 do
		cooldownLabel.Text = "Cooldown: " .. i .. "s"
		task.wait(1)
	end
	cooldownLabel.Text = "Cooldown: Ready"
	agingCooldown = false
end)

------------------------------------------------------------------
-- ❌ Exit Button -----------------------------------------------
------------------------------------------------------------------
local exitButton = Instance.new("TextButton", mainFrame)
exitButton.Size = UDim2.new(0, 24, 0, 24)
exitButton.Position = UDim2.new(1, -28, 0, 2)
exitButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitButton.Text = "X"
exitButton.TextColor3 = Color3.new(1, 1, 1)
exitButton.TextScaled = true
exitButton.Font = Enum.Font.GothamSemibold
exitButton.BorderSizePixel = 0
Instance.new("UICorner", exitButton).CornerRadius = UDim.new(0, 6)
exitButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

------------------------------------------------------------------
-- 🗕 Minimize & Restore GUI --------------------------------------
------------------------------------------------------------------
local minimized = false
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -56, 0, 2)
minimizeButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

-- Minimized GUI icon
local miniFrame = Instance.new("Frame", gui)
miniFrame.Size = UDim2.new(0, 120, 0, 30)
miniFrame.Position = UDim2.new(0, 10, 0.85, 0)
miniFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
miniFrame.Visible = false
Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 8)

local restoreButton = Instance.new("TextButton", miniFrame)
restoreButton.Size = UDim2.new(1, 0, 1, 0)
restoreButton.Text = "Open GUI"
restoreButton.BackgroundTransparency = 1
restoreButton.TextColor3 = Color3.new(1, 1, 1)
restoreButton.TextScaled = true
restoreButton.Font = Enum.Font.GothamSemibold

-- Toggle minimize
minimizeButton.MouseButton1Click:Connect(function()
	if not minimized then
		mainFrame.Visible = false
		miniFrame.Visible = true
		minimized = true
	end
end)

-- Restore GUI
restoreButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	miniFrame.Visible = false
	minimized = false
end)

------------------------------------------------------------------
-- 📝 Footer / Credit --------------------------------------------
------------------------------------------------------------------
local footer = Instance.new("TextLabel", mainFrame)
footer.Size = UDim2.new(1, 0, 0, 18)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.BackgroundTransparency = 1
footer.Text = "credit Zein Corte"
footer.TextColor3 = Color3.fromRGB(200, 200, 200)
footer.Font = Enum.Font.GothamSemibold
footer.TextSize = 10
footer.TextWrapped = true
