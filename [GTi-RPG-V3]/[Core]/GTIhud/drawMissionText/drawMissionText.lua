----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 08 Dec 2013
-- Resource: GTIhud/drawMissionText.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local X_DEF, Y_DEF = 0.95, 0.95	-- Safezone Offset
local Z_OFF = 28				-- Distance Between Notices
local VEH_OFFSET = 85			-- Vehicle HUD Offset
local DIS_TIME = 8000			-- Time to Display Text
local TRANS_TIME = 500			-- Fade In/Out Time
local ALPHA = 255				-- Shadow Alpha

local DXMissionText = {}
local DXMissionSorted = {}

local sX,sY = guiGetScreenSize()
local sX,sY = sX*X_DEF, sY*Y_DEF
local font = "clear"
local cur_zone	-- Current Zone

addEventHandler("onClientResourceStart", resourceRoot, function()
	font = dxCreateFont("fonts/signpainter.ttf", 18) -- Sign Painter House
end)

-- Draw Mission Text
--------------------->>

function drawMissionText(id, text, r, g, b)
	if (type(id) ~= "string") then return false end
	if (not text or text == "") then
		DXMissionText[id] = nil
		for i,v in ipairs(DXMissionSorted) do
			if (v == id) then
				table.remove(DXMissionSorted, i)
				break
			end
		end
		return true
	end
	
	if (type(text) ~= "string" and type(text) ~= "number") then return false end
	
	local iNotes = #DXMissionSorted
	
		-- Font Bug, "fi" is changed to "ov" and there's nothing you can do about it.
	if (type(text) == "string" and string.find(text, "fi")) then
		text = string.gsub(text, "fi", "f")
	end
	
	if (not DXMissionText[id]) then
		DXMissionText[id] = {text, r or 255, g or 255, b or 255, getTickCount()+DIS_TIME}
			-- Special Ordering Exceptions
		if (id == "location") then
			table.insert(DXMissionSorted, 1, id)
		elseif (id == "veh_name") then
			if (DXMissionText["location"]) then
				table.insert(DXMissionSorted, 2, id)
			else
				table.insert(DXMissionSorted, 1, id)
			end
		else
			table.insert(DXMissionSorted, id)
		end
	else
		DXMissionText[id][1] = text
		DXMissionText[id][2] = r or 255
		DXMissionText[id][3] = g or 255
		DXMissionText[id][4] = b or 255
		DXMissionText[id][5] = getTickCount()+DIS_TIME
	end
	
	if (iNotes == 0) then
		addEventHandler("onClientRender", root, renderDXMissionText)
	end
	return true
end
addEvent("GTIhud.drawMissionText", true)
addEventHandler("GTIhud.drawMissionText", root, drawMissionText)

-- Render Mission Text Notification
------------------------------------>>

function renderDXMissionText()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible()) then return end
	if (#DXMissionSorted == 0) then
		removeEventHandler("onClientRender", root, renderDXMissionText)
	end
	
	for i,id in ipairs(DXMissionSorted) do
		local v = DXMissionText[id]
		if (v[5] > getTickCount()) then
			local shadow = string.gsub(v[1], "#%x%x%x%x%x%x", "")
			local x,y = sX, sY-((i-1)*Z_OFF)
			if (isPedInVehicle(localPlayer)) then y = y - VEH_OFFSET end
			
			local fade = 1.0
			if (getTickCount() < v[5] - (DIS_TIME-TRANS_TIME)) then
				fade = 1 - ( ((v[5]-getTickCount())-(DIS_TIME-TRANS_TIME) ) / TRANS_TIME )
			elseif (getTickCount() > v[5] - TRANS_TIME) then
				fade = ( -(getTickCount()-v[5]) ) / TRANS_TIME
			end
			
			dxDrawText(shadow, x+1, y+1, x+1, y+1, tocolor(0, 0, 0, fade*ALPHA), 1, font, "right", "bottom", false, false, false, false, true)
			dxDrawText(v[1], x, y, x, y, tocolor(v[2], v[3], v[4], fade*255), 1, font, "right", "bottom", false, false, false, true, true)
		else
			DXMissionText[id] = nil
			table.remove(DXMissionSorted, i)
		end
	end
end

function getMissionTextOffset()
	if (#DXMissionSorted == 0) then return 0 end
	return (#DXMissionSorted)*Z_OFF + 10
end

-- Location
------------>>

function renderNewLocation()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	local x,y,z = getElementPosition(localPlayer)
	local zone = getZoneName(x, y, z)
	if (zone == "Unknown") then zone = "San Andreas" end
	
	if (cur_zone == zone) then return end
	
	cur_zone = zone
	drawMissionText("location", zone)
end
addEventHandler("onClientRender", root, renderNewLocation)

-- Vehicle Name
---------------->>

addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(vehicle)
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local name = getVehicleName(vehicle)
	local vtype = getVehicleType(vehicle)
	drawMissionText("veh_name", name..", "..vtype)
end)
