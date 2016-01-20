----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Jack Johnson (Jack)
-- Date: 07 May 2015
-- Resource: GTIgovt/invis.slua
-- Version: 1.0
----------------------------------------->>

local invisTable = {}

function invis(player)
	if not isAllowed(player) then return end
	local alpha = getElementAlpha(player)
	if invisTable[player] then
		setElementAlpha(player,255)
		outputChatBox("You're visible. No more creepin' for you ;(",player,255,0,0)
		setPlayerNametagShowing(player,true)
		invisTable[player] = nil
	else
		setElementAlpha(player,0)
		outputChatBox("You've gone incognito. Let's creep on people ;)",player,0,255,0)
		setPlayerNametagShowing(player,false)
		invisTable[player] = true
	end
end
addCommandHandler("invis",invis)

function isAllowed(player)
	if not player or not isElement(player) then return end
	
	if not isAdmin(player) then return false end
	if not isDeveloper(player) then return false end
	
	return true --We're allowed.
end