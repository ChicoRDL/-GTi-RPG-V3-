----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 13 Mar 2015
-- Resource: GTIhud/drawMissionEvent.lua
-- Version: 1.0
----------------------------------------->>

local missTimer 	-- Mission Timer (7 sec)
local missType		-- Type of Text to Render (1==Mission Passed, 2==Mission Failed)
local missType2		-- Secondary Text

-- Draw Mission Event
---------------------->>

function drawMissionEvent(textA, textB, sound)
	if (isTimer(missTimer)) then return end
	
		-- Determine Text
	if (textA == true) then
		missType = 1
	elseif (textA == false) then
		missType = 2
	else
		missType = textA
	end
		
		-- Is Secondary Text?
	if (type(textB) == "string") then
		missType2 = textB
	end
	
		-- Play Sound
	if (textA ~= false and textB == 1 or sound == 1) then
		playSound("audio/story_miss_complete.mp3")
	elseif (textA ~= false and textB == 2 or sound == 2) then
		playSound("audio/side_miss_complete.mp3")
	end
	
	missTimer = setTimer(function() 
		missTimer = nil; missType = nil; missType2 = nil;
		removeEventHandler("onClientRender", root, renderMissionEvent)
	end, 7000, 1)
	addEventHandler("onClientRender", root, renderMissionEvent)
end
addEvent("GTIhud.drawMissionEvent", true)
addEventHandler("GTIhud.drawMissionEvent", root, drawMissionEvent)

-- Render Mission Event
------------------------>>

function renderMissionEvent()
	local text = ""
	local r,g,b,a
	if (missType == 1) then
		text = "mission passed"
		r,g,b = 157, 114, 25
	elseif (missType == 2) then
		text = "mission failed"
		r,g,b = 190,36,41
	else
		text = missType
		r,g,b = 157, 114, 25
	end
	
	local timeLeft = getTimerDetails(missTimer)
	if (timeLeft > 6000) then
		timeLeft = math.abs(timeLeft - 7000)
		a = (timeLeft/1000) * 255
	elseif (timeLeft < 1000) then
		a = (timeLeft/1000) * 255
	else
		a = 255
	end
	
	local yoff = 0
	if (missType2) then
		yoff = 37
	end
	
	local x,y = guiGetScreenSize()
	local x,y = x/2, y/2
	dxDrawText(text, x+3, y+3-yoff, x+3, y+3-yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
	dxDrawText(text, x-3, y+3-yoff, x-3, y+3-yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
	dxDrawText(text, x+3, y-3-yoff, x+3, y-3-yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
	dxDrawText(text, x-3, y-3-yoff, x-3, y-3-yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
	dxDrawText(text, x, y-yoff, x, y-yoff, tocolor(r,g,b,a), 3, "pricedown", "center", "center")
	if (missType2) then
		dxDrawText(missType2, x+3, y+3+yoff, x+3, y+3+yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
		dxDrawText(missType2, x-3, y+3+yoff, x-3, y+3+yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
		dxDrawText(missType2, x+3, y-3+yoff, x+3, y-3+yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
		dxDrawText(missType2, x-3, y-3+yoff, x-3, y-3+yoff, tocolor(0,0,0,a), 3, "pricedown", "center", "center")
		dxDrawText(missType2, x, y+yoff, x, y+yoff, tocolor(255,255,255,a), 3, "pricedown", "center", "center")
	end
end
	