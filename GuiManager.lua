local StarterGui = game:GetService("StarterGui")
local inUse = false

local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local button = script.Parent
local addStairsButton = playerGui.ScreenGui.CreateBase.AddStairs
local addWallButton = playerGui.ScreenGui.CreateBase.AddWall

function handleClick()
	print(inUse)
	if not inUse then
		addStairsButton.Visible = true
		addWallButton.Visible = true
		button.Text = "Finish Base"
		print(addStairsButton.Visible)
		inUse = true
	else
		addStairsButton.Visible = false
		addWallButton.Visible = false
		button.Text = "Create Base"
		print(addStairsButton.Visible)
		inUse = false
	end
end

button.Activated:Connect(handleClick)
