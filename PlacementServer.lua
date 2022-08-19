local AddBasePartRemote = game:GetService("ReplicatedStorage"):WaitForChild("AddBasePart")
local wall = game:GetService("ReplicatedStorage").Wall
local stairs = game:GetService("ReplicatedStorage").Stairs

function handleAddPart(player, PartCframe, PartType)
	print("ran Remmote")
	if PartType == "Wall" then
		local NewWall = wall:Clone()
		NewWall.CFrame = PartCframe
		NewWall.Name = player.Name .. "'s Wall"
		NewWall.Parent = game.Workspace
	end
	if PartType == "Stairs" then
		local NewStairs = stairs:Clone()
		NewStairs.CFrame = PartCframe
		NewStairs.Name = player.Name .. "'s Stairs"
		NewStairs.Parent = game.Workspace
	end
end



AddBasePartRemote.OnServerEvent:Connect(handleAddPart)
