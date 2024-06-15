local actions = {}

local sp = loadstring(game:HttpGet('https://raw.githubusercontent.com/grayzcale/simplepath/main/src/SimplePath.lua', true))()
local player = game.Players.LocalPlayer

local char
local hum
local path

function getVariables()
	char = player.Character
	hum = char.Humanoid
	path = sp.new(char)
end

--actions
player.CharacterAdded:Connect(function()
	getVariables()
end)

function actions.reset()
	getVariables()
	hum.Health = 0
end

function actions.emote(emote)
	getVariables()
	hum:PlayEmote(emote)
end

function actions.jump()
	getVariables()
	hum:ChangeState(Enum.HumanoidStateType.Jumping)
end

function actions.walkto(pos)
	getVariables()
	path:Run(pos)
	
	path.Blocked:Connect(function()
		path:Run(pos)
	end)
end

function actions.followplayer(player)
	getVariables()
	local target = game.Players:FindFirstChild(player)
	local targetroot = target.Character.HumanoidRootPart

	path:Run(targetroot)

	path.Blocked:Connect(function()
		path:Run(targetroot)
	end)
end

	
return actions