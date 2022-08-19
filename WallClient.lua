local button = script.Parent
local wall = game:GetService('ReplicatedStorage').Wall
local UserInputService = game:GetService("UserInputService")
local AddBasePartRemote = game:GetService("ReplicatedStorage"):WaitForChild("AddBasePart")
local angle = 90
local inUse = false
local moveConnection
local clickConnection
local GridStuds = 2

function snapToGrid(x)
	return math.round(x/GridStuds)*GridStuds
end

function displayGrid()
	local texture = Instance.new("Texture")
	texture.StudsPerTileU = GridStuds
	texture.StudsPerTileV = GridStuds
	texture.Texture = "rbxassetid://2600521419"
	texture.Face = Enum.NormalId.Top
	texture.Name = "GridTexture"
	texture.Parent = game.Workspace.Baseplate
end

function calculateYPos(targetPos, targetSize)
	local wallSize = wall.Size.Y
	local YPosition = (targetPos + targetSize * 0.5) + wallSize * 0.5
	return YPosition
	
end

function handleClick()
	if not inUse then
		inUse = true
		local displayWall = wall:Clone()
		displayWall.Transparency = .4
		displayWall.CanCollide = false
		displayWall.Name = "displayWall"
		displayWall.Parent = game.Workspace
		local player = game.Players.LocalPlayer
		local mouse = player:GetMouse()
		mouse.TargetFilter = displayWall
		local ts = game:GetService("TweenService")
		displayGrid()
		moveConnection = mouse.Move:Connect(function()
			local newPosition = mouse.Hit.Position + Vector3.new(0, wall.Size.Y + game.Workspace.Baseplate.Position.Y, 0)
			local PosX = snapToGrid(mouse.Hit.X)
			local PosY = calculateYPos(mouse.Target.Position.Y, mouse.Target.Size.Y)
			local PosZ = snapToGrid(mouse.Hit.Z)
			displayWall.Position = Vector3.new(PosX,PosY,PosZ)
		end)
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if input.KeyCode == Enum.KeyCode.R then
				displayWall.CFrame = displayWall.CFrame * CFrame.Angles(0, math.rad(angle), 0)
			end
		end)
		clickConnection = mouse.Button1Down:Connect(function()
			
			AddBasePartRemote:FireServer(displayWall.CFrame, "Wall")
		end)
	else
		inUse = false
		local player = game.Players.LocalPlayer
		local mouse = player:GetMouse()
		moveConnection:Disconnect()
		clickConnection:Disconnect()
		game.Workspace:FindFirstChild("displayWall"):Destroy()
		game.Workspace.Baseplate:FindFirstChild("GridTexture"):Destroy()
	end
	
end

button.Activated:Connect(handleClick)
