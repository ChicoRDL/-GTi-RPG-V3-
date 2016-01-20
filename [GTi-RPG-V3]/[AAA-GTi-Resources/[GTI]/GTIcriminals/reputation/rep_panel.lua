----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 01 Mar 2014
-- Resource: GTIcriminals/panel.lua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Show Panel
-------------->>

local pInfo = {}
function showPanel(ranks)
	for i=16,20 do
		guiSetText(crimRepGUI.label[i], "")
	end
	guiSetText(crimRepGUI.label[8], "")
	guiSetText(crimRepGUI.label[15], "Select a Task from the List")
	
	guiGridListClear(crimRepGUI.gridlist[1])
	for i,task in ipairs(ranks["ranks"]) do
		local row = guiGridListAddRow(crimRepGUI.gridlist[1])
		guiGridListSetItemText(crimRepGUI.gridlist[1], row, 1, task, false, false)
	end
	
	pInfo[1] = ranks["level"]
	pInfo[2] = ranks["rep"]
	pInfo[3] = (ranks["rep"]-ranks["repReqCur"])/(ranks["repReq"]-ranks["repReqCur"])
	pInfo[4] = exports.GTIutil:tocomma(ranks["repReq"])
	pInfo[5] = exports.GTIutil:tocomma(ranks["rep"])
	
	guiSetVisible(crimRepGUI.window[1], true)
	showCursor(true)
end
addEvent("GTIcriminals.showPanel", true)
addEventHandler("GTIcriminals.showPanel", root, showPanel)

function togglePanel()
	if (not exports.GTIutil:isPlayerInTeam(localPlayer, "Criminals")) then return end
	if (exports.GTIgangTerritories:isGangster(localPlayer)) then return end
	if (not guiGetVisible(crimRepGUI.window[1])) then
		triggerServerEvent("GTIcriminals.callPanelInfo", localPlayer)
	else
		guiSetVisible(crimRepGUI.window[1], false)
		showCursor(false)
	end
end
bindKey("F5", "up", togglePanel)

addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, function(job)
	if (job ~= "Criminal") then return end
	guiSetVisible(crimRepGUI.window[1], false)
	showCursor(false)
end)

-- View Task Info
------------------>>

function callTaskInfo(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(crimRepGUI.gridlist[1])
	if (not row or row == -1) then return end
	local task = guiGridListGetItemText(crimRepGUI.gridlist[1], row, 1)
	triggerServerEvent("GTIcriminals.viewTaskInfo", resourceRoot, task)
end
addEventHandler("onClientGUIClick", crimRepGUI.gridlist[1], callTaskInfo, false)

function viewTaskInfo(taskTbl)
	guiSetText(crimRepGUI.label[8], "Task Level "..taskTbl["level"])
	guiSetText(crimRepGUI.label[15], taskTbl["name"])
	guiSetText(crimRepGUI.label[16], taskTbl["rank"])
	guiSetText(crimRepGUI.label[17], taskTbl["prog"].." "..taskTbl["unit"])
	guiSetText(crimRepGUI.label[18], taskTbl["promo"].." "..taskTbl["unit"])
	guiSetText(crimRepGUI.label[19], exports.GTIutil:tocomma(taskTbl["exp"]).." Respect Points")
	guiSetText(crimRepGUI.label[20], "$"..exports.GTIutil:tocomma(taskTbl["money"]))
end
addEvent("GTIcriminals.viewTaskInfo", true)
addEventHandler("GTIcriminals.viewTaskInfo", root, viewTaskInfo)

-- Render Functions
-------------------->>

function renderDisplays()
	if (not guiGetVisible(crimRepGUI.window[1])) then return end
	
	-- Level
	local wX,wY = guiGetPosition(crimRepGUI.window[1], false)
	dxDrawText(pInfo[1], wX+96, wY+46-30, wX+96, wY+46-30, tocolor(255,25,25,255), 2, "bankgothic", "left", "top", false, false, true)
	-- Experience
	local exper = exports.GTIutil:tocomma(pInfo[2])
	dxDrawText(exper, wX+280-10, wY+52-30, wX+280-10, wY+52-30, tocolor(255,25,25,255), 3.25, "clear", "left", "top", false, false, true)
	-- Progress Bar
	local dX,dY,dW,dH = wX+13,wY+115-35,525-1,34
	dxDrawRectangle(dX, dY, dW, dH, tocolor(0,0,0,200), true)
	local dX,dY,dW,dH = wX+18,wY+120-35,515-1,24
	dxDrawRectangle(dX, dY, dW, dH, tocolor(88,12,12,200), true)
	dxDrawRectangle(dX, dY, pInfo[3]*dW, dH, tocolor(175,25,25,255), true)
	
	local dX,dY,dW,dH = wX+13,wY+115-35,wX+13+525-1,wY+115-35+34
	local textDisplay = pInfo[5].."/"..pInfo[4]
	dxDrawText(textDisplay, dX+1, dY, dW+1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX, dY+1, dW, dH+1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX-1, dY, dW-1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX, dY-1, dW, dH-1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
	dxDrawText(textDisplay, dX, dY, dW, dH, tocolor(255,255,255,255), 1, "default", "center", "center", false, false, true)
end
addEventHandler("onClientRender", root, renderDisplays)
