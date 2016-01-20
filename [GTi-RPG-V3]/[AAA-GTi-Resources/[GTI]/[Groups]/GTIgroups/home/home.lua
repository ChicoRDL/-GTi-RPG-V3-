----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 31 Mar 2014
-- Resource: GTIgroupPanel/panel_home.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local buttonSpam
local renderTimer

-- Show Panel
-------------->>

function showGroupCreatePanel()
	if (not exports.GTIaccounts:isPlayerLoggedIn()) then return end
	if (getElementData(localPlayer, "group")) then return end
	if (guiGetVisible(groupCreate.window[1])) then
		hideGroupCreatePanel("left", "up")
	else
		triggerServerEvent("GTIgroupPanel.getGroupInvites", resourceRoot)
		guiSetVisible(groupCreate.window[1], true)
		showCursor(true)
	end
end
bindKey("F2", "up", showGroupCreatePanel)

-- Show Group Panel
-------------------->>

function toggleGroupPanelHome()
	if (not getElementData(localPlayer, "group")) then return end
	if (guiGetVisible(groupPanel.window[1])) then
		closeGroupPanel()
	else
		if (buttonSpam) then return end
		buttonSpam = true
		setTimer(function() buttonSpam = nil end, 1000, 1)
	
		guiSetText(groupPanel.window[1], "... — GTI Group Panel")
		guiSetText(groupPanel.label[3], "...")
		guiSetText(groupPanel.label[4], "...")
		guiSetText(groupPanel.label[6], "...")
		guiSetText(groupPanel.memo[1], "...")
	
		guiSetSelectedTab(groupPanel.tabpanel[1], groupPanel.tab[1])
		guiSetVisible(groupPanel.window[1], true)
		showCursor(true)
		triggerServerEvent("GTIgroupPanel.showGroupPanelHome", resourceRoot)
	end
end
bindKey("F2", "up", toggleGroupPanelHome)

function showGroupPanelHome(group, col)
		-- Group Info Data
	guiSetText(groupPanel.window[1], group["name"].." — GTI Group Panel")
	
	guiSetText(groupPanel.label[3], group["name"])
	
	local day,mon,year = exports.GTIutil:todate(group["date"])
	local mon = exports.GTIutil:getMonthName(mon)
	guiSetText(groupPanel.label[4], day.." "..mon.." "..year)
	
	guiSetText(groupPanel.memo[1], group["info"])
	addGroupReminders(group["news"])
	
	guiLabelSetColor(groupPanel.label[1], col[1], col[2], col[3])
	guiLabelSetColor(groupPanel.label[2], col[1], col[2], col[3])
	guiLabelSetColor(groupPanel.label[6], col[1], col[2], col[3])
end
addEvent("GTIgroupPanel.showGroupPanelHome", true)
addEventHandler("GTIgroupPanel.showGroupPanelHome", root, showGroupPanelHome)

function closeGroupPanel()
	colorPicker.closeSelect(false)	-- Close Colorpicker
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	for i,gridlist in ipairs(getElementsByType("gui-gridlist", resourceRoot)) do
		guiGridListClear(gridlist)
	end
	killTimer(renderTimer)
	renderTimer = nil
	prog_info = {}									-- Clear Stat Data
	admin_tab_rendered = nil						-- Clear Admin Tab Data
	showCursor(false)
end
addEvent("GTIgroupPanel.closeGroupPanel", true)
addEventHandler("GTIgroupPanel.closeGroupPanel", root, closeGroupPanel)

-- Group Reminders
------------------->>

function addGroupReminders(news)
	local news_text = {}
	for i,v in ipairs(news) do
		table.insert(news_text, v[1])
	end
	news_text = table.concat(news_text, " -|- ")
	if (#news_text > 105) then
		news_text = news_text.." -|- "
	end	
	guiSetText(groupPanel.label[6], news_text)
	guiLabelSetHorizontalAlign(groupPanel.label[6], "left", false)
	renderTimer = setTimer(renderGroupReminders, 150, 0)
end

function renderGroupReminders()
	if (guiGetSelectedTab(groupPanel.tabpanel[1]) ~= groupPanel.tab[1]) then return end
	local text = guiGetText(groupPanel.label[6])
	if (#text <= 105) then return end
	text = string.sub(text, 2)..string.sub(text, 1, 1)
	guiSetText(groupPanel.label[6], text)
end

-- Create Group
---------------->>

function createGroup_(button, state)
	if (button ~= "left" or state ~= "up") then return end
		-- Get Group Name
	local group_name = guiGetText(groupCreate.edit[1])
	if (#group_name == 0) then 
		exports.GTIhud:dm("Enter a group name before trying to create a group.", 255, 100, 100)
		return 
	elseif (#group_name < 5 or #group_name > 40) then
		exports.GTIhud:dm("Your group name must be between 5 and 32 characters long.", 255, 100, 100)
		return 
	end
		-- Create Group
	triggerServerEvent("GTIgroupPanel.groupCreate", resourceRoot, group_name)
		-- Close the Panel
	guiSetVisible(groupCreate.window[1], false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", groupCreate.button[1], createGroup_, false)

-- Hide Group Panel
-------------------->>

function hideGroupCreatePanel(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(groupCreate.window[1], false)
	showCursor(false)
end
addEvent("GTIgroupPanel.hideGroupCreatePanel", true)
addEventHandler("GTIgroupPanel.hideGroupCreatePanel", root, hideGroupCreatePanel)
addEventHandler("onClientGUIClick", groupCreate.label[7], hideGroupCreatePanel, false)

addEventHandler("onClientMouseEnter", groupCreate.label[7], function()
	guiLabelSetColor(source, 255, 100, 100)
end, false)

addEventHandler("onClientMouseLeave", groupCreate.label[7], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

