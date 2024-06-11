local actions = {}
local player = game.Players.LocalPlayer
local char = player.Character
local hum = char.Humanoid

function actions.reset()
	hum.Health = 0
end

function actions.emote(emote)
	hum:PlayEmote(emote)
end


return actions
