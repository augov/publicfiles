local actions = {}

local sp = loadstring(game:HttpGet('https://raw.githubusercontent.com/grayzcale/simplepath/main/src/SimplePath.lua', true))()
local player = game.Players.LocalPlayer

local char
local hum
local path

--actions

function getVariables()
	char = player.Character
	hum = char.Humanoid
	path = sp.new(char)
end

player.CharacterAdded:Connect(function()
	getVariables()
end)

function actions.reset()
	getVariables()
	hum.Health = 0
	player.CharacterAdded:Wait()
end

function actions.emote(emote)
	getVariables()
	hum:PlayEmote(emote)
	hum.Animator.AnimationPlayed:Wait()
end

function actions.jump()
	getVariables()
	hum:ChangeState(Enum.HumanoidStateType.Jumping)
	local jumpstate
	wait(1) -- fix this
end

function actions.walkto(x,y,z)
	getVariables()
	path:Run(Vector3.new(char.HumanoidRootPart.Position.X,char.HumanoidRootPart.Position.Y,char.HumanoidRootPart.Position.Z)+Vector3.new(x,y,z))

	local rerun
	rerun = path.Blocked:Connect(function()
		path:Run(Vector3.new(char.HumanoidRootPart.Position.X,char.HumanoidRootPart.Position.Y,char.HumanoidRootPart.Position.Z)+Vector3.new(x,y,z))
	end)
	
	path.Reached:Wait()
	rerun:Disconnect()
end

function actions.followplayer(player)
	getVariables()
	local target = game.Players:FindFirstChild(player)
	local targetroot = target.Character.HumanoidRootPart

	path:Run(targetroot)
	
	local rerun
	rerun = path.Blocked:Connect(function()
		path:Run(targetroot)
	end)
	
	path.Reached:Wait()
	rerun:Disconnect()
end


return actions
