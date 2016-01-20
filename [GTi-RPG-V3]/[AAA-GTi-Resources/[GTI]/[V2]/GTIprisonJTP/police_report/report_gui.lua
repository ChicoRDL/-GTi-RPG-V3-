----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 11 Mar 2015
-- Resource: GTIprison/report_gui.lua
-- Version: 2.0
----------------------------------------->>

reportGUI = {button = {}, staticimage = {}, scrollpane = {}, label = {}, label2 = {}}
local sX, sY = guiGetScreenSize()
local wX, wY = 347, 400
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2)
-- Static Image
reportGUI.staticimage[1] = guiCreateStaticImage(sX+128, sY-3, 128, 128, "files/SAPD_logo.png", false)
-- Scrollpane
reportGUI.scrollpane[1] = guiCreateScrollPane(sX+22, sY+151, 342, 106, false)
	-- Label (Crimes)
	reportGUI.label[11] = guiCreateLabel(3, 3, 316, 15, "1337 Counts of Trespassing over Forbidden Airspace", false, reportGUI.scrollpane[1])
	guiLabelSetColor(reportGUI.label[11], 0, 0, 0)
	guiLabelSetHorizontalAlign(reportGUI.label[11], "center", false)
	reportGUI.label[12] = guiCreateLabel(2, 2, 316, 15, "1337 Counts of Trespassing over Forbidden Airspace", false, reportGUI.scrollpane[1])
	guiLabelSetHorizontalAlign(reportGUI.label[12], "center", false)
-- Label Shadows
reportGUI.label2[3] = guiCreateLabel(sX+4+1, sY+265+1, 185, 15, "Total Time Wanted:", false)
guiLabelSetColor(reportGUI.label2[3], 0, 0, 0)
guiSetFont(reportGUI.label2[3], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label2[3], "right", false)
reportGUI.label2[4] = guiCreateLabel(sX+4+1, sY+290+1, 185, 15, "Total Wanted Level Achieved:", false)
guiLabelSetColor(reportGUI.label2[4], 0, 0, 0)
guiSetFont(reportGUI.label2[4], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label2[4], "right", false)
reportGUI.label2[5] = guiCreateLabel(sX+4+1, sY+315+1, 185, 15, "Total Arrest Value:", false)
guiLabelSetColor(reportGUI.label2[5], 0, 0, 0)
guiSetFont(reportGUI.label2[5], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label2[5], "right", false)
reportGUI.label2[6] = guiCreateLabel(sX+4+1, sY+340+1, 185, 15, "Prison Sentence:", false)
guiLabelSetColor(reportGUI.label2[6], 0, 0, 0)
guiSetFont(reportGUI.label2[6], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label2[6], "right", false)
reportGUI.label2[7] = guiCreateLabel(sX+198+1, sY+265+1, 185, 15, "24 hours, 00 minutes", false)
guiLabelSetColor(reportGUI.label2[7], 0, 0, 0)
guiSetFont(reportGUI.label2[7], "clear-normal")
reportGUI.label2[8] = guiCreateLabel(sX+198+1, sY+290+1, 185, 15, "1,337.6 stars", false)
guiLabelSetColor(reportGUI.label2[8], 0, 0, 0)
guiSetFont(reportGUI.label2[8], "clear-normal")
reportGUI.label2[9] = guiCreateLabel(sX+198+1, sY+315+1, 185, 15, "$65,535", false)
guiLabelSetColor(reportGUI.label2[9], 0, 0, 0)
guiSetFont(reportGUI.label2[9], "clear-normal")
reportGUI.label2[10] = guiCreateLabel(sX+198+1, sY+340+1, 185, 15, "24 hours, 00 minutes", false)
guiLabelSetColor(reportGUI.label2[10], 0, 0, 0)
guiSetFont(reportGUI.label2[10], "clear-normal")
-- Labels
reportGUI.label[3] = guiCreateLabel(sX+4, sY+265, 185, 15, "Total Time Wanted:", false)
guiSetFont(reportGUI.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label[3], "right", false)
reportGUI.label[4] = guiCreateLabel(sX+4, sY+290, 185, 15, "Total Wanted Level Achieved:", false)
guiSetFont(reportGUI.label[4], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label[4], "right", false)
reportGUI.label[5] = guiCreateLabel(sX+4, sY+315, 185, 15, "Total Arrest Value:", false)
guiSetFont(reportGUI.label[5], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label[5], "right", false)
reportGUI.label[6] = guiCreateLabel(sX+4, sY+340, 185, 15, "Prison Sentence:", false)
guiSetFont(reportGUI.label[6], "default-bold-small")
guiLabelSetHorizontalAlign(reportGUI.label[6], "right", false)
reportGUI.label[7] = guiCreateLabel(sX+198, sY+265, 185, 15, "24 hours, 00 minutes", false)
guiSetFont(reportGUI.label[7], "clear-normal")
reportGUI.label[8] = guiCreateLabel(sX+198, sY+290, 185, 15, "1,337.6 stars", false)
guiSetFont(reportGUI.label[8], "clear-normal")
reportGUI.label[9] = guiCreateLabel(sX+198, sY+315, 185, 15, "$65,535", false)
guiSetFont(reportGUI.label[9], "clear-normal")
reportGUI.label[10] = guiCreateLabel(sX+198, sY+340, 185, 15, "24 hours, 00 minutes", false)
guiSetFont(reportGUI.label[10], "clear-normal")
-- Button
reportGUI.button[1] = guiCreateButton(sX+119, sY+367, 150, 29, "CLOSE", false)
guiSetProperty(reportGUI.button[1], "NormalTextColour", "FFAAAAAA")

function policeReport()
	dxDrawText("Police Report", sX+179 - 1, sY+103 - 1, sX+210 - 1, sY+132 - 1, tocolor(0, 0, 0, 255), 2.50, "diploma", "center", "center", false, false, true, false, false)
	dxDrawText("Police Report", sX+179 + 1, sY+103 - 1, sX+210 + 1, sY+132 - 1, tocolor(0, 0, 0, 255), 2.50, "diploma", "center", "center", false, false, true, false, false)
	dxDrawText("Police Report", sX+179 - 1, sY+103 + 1, sX+210 - 1, sY+132 + 1, tocolor(0, 0, 0, 255), 2.50, "diploma", "center", "center", false, false, true, false, false)
	dxDrawText("Police Report", sX+179 + 1, sY+103 + 1, sX+210 + 1, sY+132 + 1, tocolor(0, 0, 0, 255), 2.50, "diploma", "center", "center", false, false, true, false, false)
	dxDrawText("Police Report", sX+179, sY+103, sX+210, sY+132, tocolor(255, 255, 255, 255), 2.50, "diploma", "center", "center", false, false, true, false, false)
	dxDrawRectangle(sX+20, sY+149, 347, 112, tocolor(0, 0, 0, 150), false)
end

-- Toggle Report GUI
--------------------->>

function setReportGUIVisible(bool)
	if (bool) then
		addEventHandler("onClientRender", root, policeReport)
		for k,v in pairs(reportGUI) do
			for _,v in pairs(reportGUI[k]) do
				guiSetVisible(v, true)
			end
		end
	else
		removeEventHandler("onClientRender", root, policeReport)
		for k,v in pairs(reportGUI) do
			for _,v in pairs(reportGUI[k]) do
				guiSetVisible(v, false)
			end
		end
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	setReportGUIVisible(false)
end)
