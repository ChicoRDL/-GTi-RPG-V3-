----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 24 Jan 2014
-- Resource: GTIhud/drawStat.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local DXStats = {}
local DXStatsSorted = {}

local sX,sY = guiGetScreenSize()
local fontA = "default-bold"
local fontB = "default-bold"

local Z_OFFSET = 35		-- Space between stats
local PROG_WIDTH = 125	-- Progress Bar Width
local PROG_HEIGHT = 25	-- Progress Bar Height
local PROG_BORDER = 4	-- Progress Bar Border Thickness
local ALPHA = 255		-- Shadow Alpha

addEventHandler("onClientResourceStart", resourceRoot, function()
	local font = dxCreateFont("fonts/cambria.ttf", 10)
	if (font) then fontA = font end
	local font = dxCreateFont("fonts/verdana.ttf", 16)
	if (font) then fontB = font end
end)

-- Draw Stats
-------------->>

function drawStat(id, columnA, columnB, r, g, b, timer)
	if (type(id) ~= "string") then return end
	if (not columnA or columnA == "") then
		DXStats[id] = nil
		for i,v in ipairs(DXStatsSorted) do
			if (v == id) then
				table.remove(DXStatsSorted, i)
				break
			end
		end
		return true
	end	
	if (type(columnA) ~= "string" or not tostring(columnB) or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return false end
	if (timer and type(timer) ~= "number") then return false end
	
	local iNotes = #DXStatsSorted
	
	if (not DXStats[id]) then
		table.insert(DXStatsSorted, id)
	end
	
	DXStats[id] = {columnA, columnB, r, g, b}
	if (timer) then
		local tick = getTickCount()+timer
		DXStats[id][6] = tick
	end
	
	if (iNotes == 0) then
		addEventHandler("onClientRender", root, renderDXStat)
	end
	return true
end
addEvent("GTIhud.drawStat", true)
addEventHandler("GTIhud.drawStat", root, drawStat)

-- Draw Progress Bar
--------------------->>

function drawProgressBar(id, text, r, g, b, timer)
	if (type(id) ~= "string") then return end
	if (not text or text == "") then
		DXStats[id] = nil
		for i,v in ipairs(DXStatsSorted) do
			if (v == id) then
				table.remove(DXStatsSorted, i)
				break
			end
		end
		return true
	end	
	if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" or type(timer) ~= "number") then return false end
	
	local iNotes = #DXStatsSorted
	if (not DXStats[id]) then
		table.insert(DXStatsSorted, id)
	end
	
	DXStats[id] = {text, timer, r, g, b, getTickCount()+timer, true}
	
	if (iNotes == 0) then
		addEventHandler("onClientRender", root, renderDXStat)
	end
	return true
end
addEvent("GTIhud.drawProgressBar", true)
addEventHandler("GTIhud.drawProgressBar", root, drawProgressBar)

-- Render Stats
---------------->>

function renderDXStat()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible()) then return end
	if (#DXStatsSorted == 0) then
		removeEventHandler("onClientRender", root, renderDXStat)
	end
	
	local aX,aY = sX*0.95, sY*0.27
	if (getPlayerWantedLevel() > 0) then
		aY = sY*0.32
	end
	
	local xOffset = 0
	for i,id in ipairs(DXStatsSorted) do
		local v = DXStats[id]
		local xOffsetTest = dxGetTextWidth(v[2], 1, fontB)+15
		if (v[7]) then xOffsetTest = PROG_WIDTH + 15 end
		if (xOffset < xOffsetTest) then
			xOffset = xOffsetTest
		end
	end
	
	for i,id in ipairs(DXStatsSorted) do
		local v = DXStats[id]
		if (not v[6] or v[6] > getTickCount()) then
			if (not v[7]) then
				-- Draw Stat
					-- Column B Shadow
				local x,y = aX, aY+( (i-1)*Z_OFFSET)+4
				dxDrawText(v[2], x+1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, fontB, "right", "bottom")
					-- Column B Text
				dxDrawText(v[2], x, y, x, y, tocolor(v[3], v[4], v[5], 255), 1, fontB, "right", "bottom")
			else
					-- Draw Progress Bar
				local x1,y1,x2,y2 = aX - PROG_WIDTH, aY+( (i-1)*Z_OFFSET), PROG_WIDTH, -PROG_HEIGHT
				dxDrawRectangle(x1,y1,x2,y2, tocolor(0, 0, 0, 200))
				dxDrawRectangle(x1+PROG_BORDER,y1-PROG_BORDER,x2-(PROG_BORDER*2),y2+(PROG_BORDER*2), tocolor(v[3]/3, v[4]/3, v[5]/3, 200))
				local progress = (v[2]-(v[6]-getTickCount()))/v[2]
				dxDrawRectangle(x1+PROG_BORDER,y1-PROG_BORDER,(x2-(PROG_BORDER*2))*progress,y2+(PROG_BORDER*2), tocolor(v[3], v[4], v[5], 200))
				
				-- Draw Percentage
				local x2,y2 = x1 + PROG_WIDTH, y1 - PROG_HEIGHT
				progress = math.floor(progress * 100).."%"
				
				dxDrawText(progress, x1-1, y1-1, x2-1, y2-1, tocolor(0, 0, 0, 255), 1, "default", "center", "center")
				dxDrawText(progress, x1+1, y1-1, x2+1, y2-1, tocolor(0, 0, 0, 255), 1, "default", "center", "center")
				dxDrawText(progress, x1-1, y1+1, x2-1, y2+1, tocolor(0, 0, 0, 255), 1, "default", "center", "center")
				dxDrawText(progress, x1+1, y1+1, x2+1, y2+1, tocolor(0, 0, 0, 255), 1, "default", "center", "center")
				dxDrawText(progress, x1, y1, x2, y2, tocolor(255, 255, 255, 255), 1, "default", "center", "center")
			end
			
				-- Column A Shadow
			local x,y = aX-xOffset, aY+( (i-1)*Z_OFFSET)+2
			if (string.gsub(v[1], "%s", "") == string.gsub(v[1], "%W", "")) then v[1] = string.upper(v[1]) end
			dxDrawText(v[1], x+1, y+1, x+1, y+1, tocolor(0, 0, 0, ALPHA), 1, fontA, "right", "bottom")
				-- Column A Text
			dxDrawText(v[1], x, y, x, y, tocolor(v[3], v[4], v[5], 255), 1, fontA, "right", "bottom")
		else
			DXStats[id] = nil
			table.remove(DXStatsSorted, i)
		end
	end
end
