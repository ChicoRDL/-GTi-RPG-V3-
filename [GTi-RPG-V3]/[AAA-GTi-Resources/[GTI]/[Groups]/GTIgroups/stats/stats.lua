----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 30 Jun 2014
-- Resource: GTIgroupPanel/Stats/stats.lua
-- Version: 1.0
----------------------------------------->>

prog_info = {}	-- Table of Progress Bar Information

local font_lvl = "bankgothic"
local font_xp = "clear"

local red, green, blue = 255, 100, 100

addEventHandler("onClientResourceStart", resourceRoot, function()
	font_lvl = dxCreateFont("files/Cambria.ttf", 30, true)
	font_xp = dxCreateFont("files/Calibri.ttf", 30)
end)

-- Stats Tab Info
------------------>>

function getStatsTabInfo()
	if (#prog_info ~= 0) then return end
		-- Clear Default Data
	for i=19,43,2 do
		if (i ~= 35) then
			guiSetText(groupPanel.label[i], "...")
		end
	end
	guiSetText(groupPanel.label[100], "...")
	prog_info = {}
	triggerServerEvent("GTIgroupPanel.getStatsTabInfo", resourceRoot)
end
addEventHandler("onClientGUITabSwitched", groupPanel.tab[3], getStatsTabInfo)

function setStatsTabInfo(stats, prog_stats, col)
	for i,v in pairs(stats) do
		guiSetText(groupPanel.label[i], v)
	end
	red, green, blue = col[1], col[2], col[3]
	for i=18,42,2 do
		if (i ~= 34) then
			guiLabelSetColor(groupPanel.label[i], col[1], col[2], col[3])
		end
	end
	guiLabelSetColor(groupPanel.label[100], col[1], col[2], col[3])
	prog_info = prog_stats
end
addEvent("GTIgroupPanel.setStatsTabInfo", true)
addEventHandler("GTIgroupPanel.setStatsTabInfo", root, setStatsTabInfo)

-- Render Experience
--------------------->>

function renderDisplays()
	if (not guiGetVisible(groupPanel.window[1])) then return end
	if (guiGetSelectedTab(groupPanel.tabpanel[1]) ~= groupPanel.tab[3] or #prog_info == 0) then return end

	-- Level
	local wX,wY = guiGetPosition(groupPanel.window[1], false)
	dxDrawText(prog_info[1], wX+126, wY+50, wX+126, wY+50, tocolor(red,green,blue,255), 1, font_lvl, "left", "top", false, false, true)
	-- Experience
	local exper = exports.GTIutil:tocomma(prog_info[2])
	dxDrawText(exper, wX+335, wY+52, wX+335, wY+52, tocolor(red,green,blue,255), 1, font_xp, "left", "top", false, false, true)
	-- Progress Bar
	local dX,dY,dW,dH = wX+21,wY+115,643,40
	dxDrawRectangle(dX, dY, dW, dH, tocolor(0,0,0,200), true)
	local dX,dY,dW,dH = wX+26,wY+120,633,30
	dxDrawRectangle(dX, dY, dW, dH, tocolor(red*(1/3),green*(1/3),blue*(1/3),200), true)
	if (prog_info[3] > 1) then prog_info[3] = 1 end
	dxDrawRectangle(dX, dY, prog_info[3]*dW, dH, tocolor(red,green,blue,255), true)
		-- Progress Bar Label
	local dX,dY,dW,dH = wX+343,wY+135,wX+343,wY+135
	local textDisplay = prog_info[5].."/"..prog_info[4]
	dxDrawText(textDisplay, dX+1, dY, dW+1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX, dY+1, dW, dH+1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX-1, dY, dW-1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX, dY-1, dW, dH-1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX, dY, dW, dH, tocolor(255,255,255,255), 1, "default", "center", "center", false, false, true)
end
addEventHandler("onClientRender", root, renderDisplays)