----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 18 Jan 2014
-- Resource: GTIhud/drawNotification.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local DXNotifications = {}
local DXNoteSorted = {}

local sX,sY = guiGetScreenSize()
local aX,aY = (sX*0.95), (sY*0.95)
local font = "clear"

addEventHandler("onClientResourceStart", resourceRoot, function()
	font = dxCreateFont("fonts/verdana.ttf", 12)
end)

local Z_OFFSET = -25	-- Distance between Notifications
local VEH_OFFSET = 85	-- Offset of Vehicle HUD
local ALPHA = 255		-- Shadow Alpha

-- Draw Notification
--------------------->>

function drawNote(id, text, r, g, b, timer)
	if (type(id) ~= "string") then return end
	if (not text or text == "") then
		DXNotifications[id] = nil
		for i,v in ipairs(DXNoteSorted) do
			if (v == id) then
				table.remove(DXNoteSorted, i)
				break
			end
		end
		return true
	end
	
	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (timer and type(timer) ~= "number") then return false end
	if (r > 255 or g > 255 or b > 255) then return false end
	
	local iNotes = #DXNoteSorted
	
	if (not DXNotifications[id]) then
		DXNotifications[id] = {text, r, g, b}
		if (timer) then
			local tick = getTickCount()+timer
			DXNotifications[id][5] = tick
		end
		table.insert(DXNoteSorted, id)
	else
		DXNotifications[id][1] = text
		DXNotifications[id][2] = r
		DXNotifications[id][3] = g
		DXNotifications[id][4] = b
		if (timer) then
			local tick = getTickCount()+timer
			DXNotifications[id][5] = tick
		end
	end
	
	if (iNotes == 0) then
		addEventHandler("onClientRender", root, renderDXNotification)
	end
	playSoundFrontEnd(11)
	return true
end
addEvent("GTIhud.drawNote", true)
addEventHandler("GTIhud.drawNote", root, drawNote)

-- Render Notification
----------------------->>

function renderDXNotification()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible()) then return end
	if (#DXNoteSorted == 0) then
		removeEventHandler("onClientRender", root, renderDXNotification)
	end
	
	for i,id in ipairs(DXNoteSorted) do
		local v = DXNotifications[id]
		if (not v[5] or v[5] > getTickCount()) then
			local shadow = string.gsub(v[1], "#%x%x%x%x%x%x", "")
			local x,y = aX, aY+( (i-1)*Z_OFFSET - getMissionTextOffset())
			if (isPedInVehicle(localPlayer)) then y = y - VEH_OFFSET end
			dxDrawText(shadow, x+1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, font, "right", "bottom", false, false, false, false, true)
			dxDrawText(v[1], x, y, x, y, tocolor(v[2], v[3], v[4], 255), 1, font, "right", "bottom", false, false, false, true, true)
		else
			DXNotifications[id] = nil
			table.remove(DXNoteSorted, i)
		end
	end
end
