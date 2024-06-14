local actions = {}

local sp = loadstring(game:HttpGet('https://raw.githubusercontent.com/grayzcale/simplepath/main/src/SimplePath.lua', true))()
local player = game.Players.LocalPlayer

local path = sp.new(char)

local char
local hum

--actions
player.CharacterAdded:Connect(function()
	char = player.Character
	hum = char.Humanoid
end)

function actions.reset()
	hum.Health = 0
end

function actions.emote(emote)
	hum:PlayEmote(emote)
end

function actions.jump()
	hum:ChangeState(Enum.HumanoidStateType.Jumping)
end

function actions.walkto(pos)
	path = sp.new(char)
	path:Run(pos)
	
	path.Blocked:Connect(function()
		path:Run(pos)
	end)
end

function actions.followplayer(player)
	local target = game.Players:FindFirstChild(player)
	local targetroot = target.Character.HumanoidRootPart

	path:Run(targetroot)

	path.Blocked:Connect(function()
		path:Run(targetroot)
	end)
end

	
return actions