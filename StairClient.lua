local button = script.Parent
local stairs = game:GetService('ReplicatedStorage').Stairs
local UserInputService = game:GetService("UserInputService")
local AddBasePartRemote = game:GetService("ReplicatedStorage"):WaitForChild("AddBasePart")
local angle = 90
local moveConnection
local clickConnection

local inUse = false

function handleClick()
	if not inUse then
		inUse = true
		local displayWall = stairs:Clone()
		displayWall.Transparency = .4
		displayWall.CanCollide = false
		displayWall.Name = "displayStairs"
		displayWall.Parent = game.Workspace
		local player = game.Players.LocalPlayer
		local mouse = player:GetMouse()
		mouse.TargetFilter = displayWall
		local ts = game:GetService("TweenService")

		moveConnection = mouse.Move:Connect(function()
			local newPosition = mouse.Hit.Position + Vector3.new(0, 1, 0)
			displayWall.Position = newPosition
		end)
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if input.KeyCode == Enum.KeyCode.R then
				displayWall.CFrame = displayWall.CFrame * CFrame.Angles(0, math.rad(angle), 0)
			end
		end)
		clickConnection = mouse.Button1Down:Connect(function()
			print("ran")
			AddBasePartRemote:FireServer(displayWall.CFrame, "Stairs")
		end)
		
	else
		inUse = false
		local player = game.Players.LocalPlayer
		local mouse = player:GetMouse()
		moveConnection:Disconnect()
		clickConnection:Disconnect()
		game.Workspace:FindFirstChild("displayStairs"):Destroy()
	end

end

button.Activated:Connect(handleClick)
