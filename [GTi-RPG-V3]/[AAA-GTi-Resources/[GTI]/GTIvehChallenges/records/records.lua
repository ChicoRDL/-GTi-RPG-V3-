----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 22 Mar 2015
-- Resource: GTIvehChallenges/records.lua
-- Version: 1.0
----------------------------------------->>

local records	-- Records Table

-- Show Records
---------------->>

addEvent("GTIvehChallenges.showRecords", true)
addEventHandler("GTIvehChallenges.showRecords", root, function(tbl)
	records = tbl
	setTimer(function() records = nil end, 10000, 1)
	addEventHandler("onClientRender", root, renderRecords)
end)

function renderRecords()
	if (not records) then 
		removeEventHandler("onClientRender", root, renderRecords)
	return end
	local sX,sY = guiGetScreenSize()
	local wX,wY = 342, 27+(18*#records)
	local sX,sY = sX*0.05, (sY/2)-(wY/2)
	
	dxDrawRectangle(sX, sY, wX, wY, tocolor(0, 0, 0, 125), false)
	dxDrawText("Name", sX+30, sY+3, sX+30+35, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "arial", "left", "top", false, false, false, false, false)
	dxDrawText("Time", sX+182, sY+3, sX+30+35, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "arial", "left", "top", false, false, false, false, false)
	dxDrawText("Recorded On...", sX+247, sY+3, sX+30+35, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "arial", "left", "top", false, false, false, false, false)
    dxDrawLine(sX+27, sY+21, sX+27+304, sY+21, tocolor(255, 255, 255, 255), 1, false)
	   
	for i,v in ipairs(records) do
		i = i - 1
		dxDrawText((i+1)..".)", sX, sY+26+(i*18), sX+25, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "default", "right", "top", false, false, false, false, false)
		dxDrawText(v[1], sX+30, sY+26+(i*18), sX+30, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
		
		local mins = math.floor(v[2]/60000)
		local sec = string.format("%02d", (v[2]%60000)/1000)
		local ms = v[2]%1000
		dxDrawText(mins..":"..sec.."."..ms, sX+182, sY+26+(i*18), sX+182+59, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "default", "center", "top", false, false, false, false, false)
		
		local dd,mm,yyyy = exports.GTIutil:todate(v[3])
		local mm = exports.GTIutil:getMonthName(mm, 3)
		dxDrawText(dd.." "..mm.." "..yyyy, sX+247, sY+26+(i*18), sX+247+83, sY+3+15, tocolor(255, 255, 255, 255), 1.00, "default", "center", "top", false, false, false, false, false)
	end
end
