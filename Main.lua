-- ⚪ Zein Corte Loading Screen (2 Minutes) - KRNL ONLY

local executor = identifyexecutor and string.lower(identifyexecutor()) or ""

if executor:find("delta") then
	local player = game.Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	-- Clear old screen if needed
	if playerGui:FindFirstChild("ZeinWarningScreen") then
		playerGui:FindFirstChild("ZeinWarningScreen"):Destroy()
	end

	local warningGui = Instance.new("ScreenGui")
	warningGui.Name = "ZeinWarningScreen"
	warningGui.ResetOnSpawn = false
	warningGui.Parent = playerGui

	local warningFrame = Instance.new("Frame")
	warningFrame.Size = UDim2.new(0.5, 0, 0.2, 0)
	warningFrame.Position = UDim2.new(0.25, 0, 0.4, 0)
	warningFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	warningFrame.BorderSizePixel = 0
	warningFrame.Parent = warningGui

	local warningText = Instance.new("TextLabel")
	warningText.Size = UDim2.new(1, -20, 1, -20)
	warningText.Position = UDim2.new(0, 10, 0, 10)
	warningText.BackgroundTransparency = 1
	warningText.TextColor3 = Color3.fromRGB(255, 75, 75)
	warningText.TextScaled = true
	warningText.Font = Enum.Font.GothamBold
	warningText.Text = "⚠️ Delta executor is not supported.\nPlease use KRNL to run this script."
	warningText.TextWrapped = true
	warningText.Parent = warningFrame

	wait(6)
	warningGui:Destroy()
	return
end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove existing screen if any
if playerGui:FindFirstChild("ZeinLoadingScreen") then
	playerGui:FindFirstChild("ZeinLoadingScreen"):Destroy()
end

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZeinLoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.1, 0)
frame.Position = UDim2.new(0.3, 0, 0.45, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
loadingBar.BorderSizePixel = 0
loadingBar.Parent = frame

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.Position = UDim2.new(0, 0, 0, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "Loading... 0%"
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.TextScaled = true
percentLabel.Font = Enum.Font.GothamSemibold
percentLabel.Parent = frame

-- Progress Loop
spawn(function()
	for i = 1, 100 do
		loadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentLabel.Text = "Loading... " .. i .. "%"
		wait(1.2) -- Total 120 seconds
	end
	wait(0.5)
	screenGui:Destroy()
end)
