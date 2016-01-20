----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 11 Jan 2014
-- Resource: GTIhud/displayMessage.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local DXMessages = {}

local sX,sY = guiGetScreenSize()
local aX,aY,aW,aH = sX*(0.25), (sY*0.95)-20, sX*0.75, sY*0.95
if (sX <= 1280) then
	aX,aY,aW,aH = (sX/2)-(1280/4), (sY*0.95)-20, (sX/2)+(1280/4), sY*0.95
end

local font = "default-bold"

local DISPLAY_TIME = 7500

-- Display Message
------------------->>

function dm(text, r, g, b)
	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (r > 255 or g > 255 or b > 255) then return false end
	
	if (#DXMessages == math.floor((sY*0.2)/20)) then
		table.remove(DXMessages, 1)
	end
	
	local tick = getTickCount()+DISPLAY_TIME
	dxTable = {text, r, g, b, tick}
	table.insert(DXMessages, dxTable)
	
	if (#DXMessages == 1) then
		addEventHandler("onClientRender", root, renderDXMessage)
	end
	playSoundFrontEnd(11)
	outputConsole(text)
	exports.GTIchat:outputGridlist("Brief", text)
	return true
end
addEvent("GTIhud.dm", true)
addEventHandler("GTIhud.dm", root, dm)

-- Render DX Message
--------------------->>

function renderDXMessage()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible()) then return end
	if (#DXMessages == 0) then
		removeEventHandler("onClientRender", root, renderDXMessage)
	end
	
	local toRemove = 0
	for i,v in ipairs(DXMessages) do
		if (v[5] > getTickCount()) then
			dxDrawRectangle(aX, aY-( (i-1) *20), aW-aX, aH-aY, tocolor(0, 0, 0, 200))
			dxDrawText(v[1], aX, aY-( (i-1) *20), aW, aH-( (i-1) *20), tocolor(v[2], v[3], v[4], 255), 1, font, "center", "center", false, false, false, true)
		else
			toRemove = toRemove + 1
		end
	end
	if (toRemove > 0) then
		for i=1,toRemove do
			table.remove(DXMessages, 1)
		end
	end
	local i = #DXMessages-1
	dxDrawLine(aX-1, aY-1-(i*20), aX-1, aH-1, tocolor(0, 0, 0, 255), 2) -- Left
	dxDrawLine(aX-1, aY-(i*20), aW-1, aY-(i*20), tocolor(0, 0, 0, 255), 2) -- Top
	dxDrawLine(aW, aY-1-(i*20), aW, aH, tocolor(0, 0, 0, 255), 2) -- Right
	dxDrawLine(aX-1, aH-1, aW-1, aH-1, tocolor(0, 0, 0, 255), 2) -- Bottom
end
