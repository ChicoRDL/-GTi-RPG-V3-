----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 11 Mar 2015
-- Resource: GTIprison/report.lua
-- Version: 2.0
----------------------------------------->>

addEvent("GTIprison.showPoliceReport", true)
addEventHandler("GTIprison.showPoliceReport", root, function(wT, wTime, wanted, value, sentence)
		-- List of Charges
	local x,y = guiGetSize(reportGUI.label[11], false)
	local y = y * #wT
	wT = table.concat(wT, "\n")
	guiSetSize(reportGUI.label[11], x, y, false)
	guiSetSize(reportGUI.label[12], x, y, false)
	guiSetText(reportGUI.label[11], wT)
	guiSetText(reportGUI.label[12], wT)
		-- Wanted Time
	guiSetText(reportGUI.label[7], wTime)
	guiSetText(reportGUI.label2[7], wTime)
		-- Wanted Level
	guiSetText(reportGUI.label[8], wanted)
	guiSetText(reportGUI.label2[8], wanted)
		-- Value
	guiSetText(reportGUI.label[9], value)
	guiSetText(reportGUI.label2[9], value)
		-- Sentence
	guiSetText(reportGUI.label[10], sentence)
	guiSetText(reportGUI.label2[10], sentence)
	
	setReportGUIVisible(true)
	showCursor(true)
end)

addEventHandler("onClientGUIClick", reportGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	setReportGUIVisible(false)
	showCursor(false)
end, false)
