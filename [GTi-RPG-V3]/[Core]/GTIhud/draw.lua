----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 18 Jan 2014
-- Resource: GTIhud/drawNotification.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

function dm(text, player, r, g, b)
	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (r > 255 or g > 255 or b > 255) then return false end
	if (not player or not isElement(player)) then player = root end
	triggerClientEvent(player, "GTIhud.dm", resourceRoot, text, r, g, b)
	return true
end

function drawMissionText(id, text, player, r, g, b)
	if (type(id) ~= "string") then return false end
	triggerClientEvent(player, "GTIhud.drawMissionText", resourceRoot, id, text, r, g, b, timer)
	return true
end

function drawNote(id, text, player, r, g, b, timer)
	if (type(id) ~= "string") then return false end
	triggerClientEvent(player, "GTIhud.drawNote", resourceRoot, id, text, r, g, b, timer)
	return true
end

function drawProgressBar(id, text, player, r, g, b, timer)
	if (type(id) ~= "string") then return false end
	triggerClientEvent(player, "GTIhud.drawProgressBar", resourceRoot, id, text, r, g, b, timer)
	return true
end

function drawStat(id, columnA, columnB, player, r, g, b, timer)
	if (type(id) ~= "string") then return false end
	triggerClientEvent(player, "GTIhud.drawStat", resourceRoot, id, columnA, columnB, r, g, b, timer)
	return true
end

function drawMissionEvent(player, textA, textB, sound)
	triggerClientEvent(player, "GTIhud.drawMissionEvent", resourceRoot, textA, textB, sound)
	return true
end


function showHud(player)
	triggerClientEvent(player, "GTIhud.showHud", resourceRoot)
	return true
end

setElementData(root, "max_players", getMaxPlayers())
setTimer(function()
	setElementData(root, "max_players", getMaxPlayers())
end, 600000, 0)
