----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 22 Jun 2014
-- Resource: GTIgroupPanel/Admin/admin.lua
-- Version: 1.0
----------------------------------------->>

admin_tab_rendered = nil    -- See if the admin tab has been rendered yet

local newsItems = {}    -- Cache of News Items

-- Admin Tab Info
------------------>>

function getAdminTabInfo()
    if (admin_tab_rendered) then return end
    for i=6,19 do
        guiSetEnabled(groupPanel.button[i], false)
    end
    triggerServerEvent("GTIgroupPanel.getAdminTabInfo", resourceRoot)
end
addEventHandler("onClientGUITabSwitched", groupPanel.tab[5], getAdminTabInfo)

function setAdminTabInfo(perms, col)
    for i,v in pairs(perms) do
        guiSetEnabled(groupPanel.button[i], v)
    end
    guiLabelSetColor(groupPanel.label[52], col[1], col[2], col[3])
    admin_tab_rendered = true
end
addEvent("GTIgroupPanel.setAdminTabInfo", true)
addEventHandler("GTIgroupPanel.setAdminTabInfo", root, setAdminTabInfo)

-- Toggle Panels
---------------->>

function toggleAdminPanels(button, state)
    if (button ~= "left" or state ~= "up") then return end
    
    -- Change Group Information
    ---------------------------->>
    
    if (source == groupPanel.button[7]) then
        local text = guiGetText(groupPanel.memo[1])
        guiSetText(groupInfoGUI.memo[1], text)
        
        guiBringToFront(groupInfoGUI.window[1])
        guiSetVisible(groupInfoGUI.window[1], true)
    return end
    if (source == groupInfoGUI.button[2]) then
        guiSetVisible(groupInfoGUI.window[1], false)
    return end
    
    -- Add/Remove Group Reminders
    ------------------------------>>
    
    if (source == groupPanel.button[8]) then
        triggerServerEvent("GTIgroups.getReminders", resourceRoot)
    return end
    if (source == groupNewsGUI.label[2]) then
        guiSetVisible(groupNewsGUI.window[1], false)
    return end
    
    -- Change Group Name
    --------------------->>
    
    if (source == groupPanel.button[12]) then
        local group = getElementData(localPlayer, "group")
        guiSetText(chgGrpNm_gui.label[2], group or "Unknown")
        guiSetText(chgGrpNm_gui.button[1], "Change (1)")
            -- Color
        local r,g,b = guiLabelGetColor(groupPanel.label[1])
        guiLabelSetColor(chgGrpNm_gui.label[1], r, g, b)
        guiLabelSetColor(chgGrpNm_gui.label[3], r, g, b)
        
        guiBringToFront(chgGrpNm_gui.window[1])
        guiSetVisible(chgGrpNm_gui.window[1], true)
    return end
    if (source == chgGrpNm_gui.button[2]) then
        guiSetVisible(chgGrpNm_gui.window[1], false)
    return end
    
    -- Change Group Color
    ----------------------->>
    
    if (source == groupPanel.button[14]) then
        local r,g,b = guiLabelGetColor(groupPanel.label[1])
        colorPicker.value[1] = r
        colorPicker.value[2] = g
        colorPicker.value[3] = b
        colorPicker.value[4] = 255
        colorPicker.openSelect()
    return end

    -- Friendly Fire
    ----------------->>
    
    if (source == groupPanel.button[15]) then
        triggerServerEvent("GTIgroups.getFriendlyFire", resourceRoot)
    return end
    if (source == friendlyFireGUI.button[2]) then
        guiSetVisible(friendlyFireGUI.window[1], false)
    return end
    
    -- Group Blips
    --------------->>
    
    if (source == groupPanel.button[18]) then
        triggerServerEvent("GTIgroups.getGroupBlips", resourceRoot)
    return end
    if (source == groupBlipsGUI.button[2]) then
        guiSetVisible(groupBlipsGUI.window[1], false)
    return end
    
    -- Delete Group
    ---------------->>
    
    if (source == groupPanel.button[19]) then
        local r,g,b = guiLabelGetColor(groupPanel.label[1])
        local hex = exports.GTIutil:RGBToHex(r, g, b)
        hex = string.gsub(hex, "#", "")
        guiSetProperty(deleteGroupGUI.button[1], "NormalTextColour", "FF"..hex)
        
        guiBringToFront(deleteGroupGUI.window[1])
        guiSetVisible(deleteGroupGUI.window[1], true)
    return end
    if (source == deleteGroupGUI.button[1]) then
        guiSetVisible(deleteGroupGUI.window[1], false)
        guiSetText(deleteGroupGUI.button[2], "Delete (5)")
    return end
    
    -- Job Restriction
    ------------------->>
    if (source == groupPanel.button[20]) then
        guiBringToFront(jobRestrictGUI.window[1])
        guiSetVisible(jobRestrictGUI.window[1], true)
        triggerServerEvent("GTIgroups.retreiveJobs", localPlayer)
    return end
    if (source == jobRestrictGUI.button[1]) then
        guiSetVisible(jobRestrictGUI.window[1], false)
    return end    
end
addEventHandler("onClientGUIClick", resourceRoot, toggleAdminPanels)

-- Update Group Information
---------------------------->>

function changeGroupInformation(button, state)
    if (button ~= "left" or state ~= "up") then return end
    
    local old_text = guiGetText(groupPanel.memo[1])
    local text = guiGetText(groupInfoGUI.memo[1])
    if (old_text == text) then
        exports.GTIhud:dm("GROUP: You didn't make any changes. Click 'Cancel' instead.", 255, 100, 100)
        return
    end
    
    guiSetText(groupPanel.memo[1], text)
    guiSetVisible(groupInfoGUI.window[1], false)
    triggerServerEvent("GTIgroupPanel.changeGroupInformation", resourceRoot, text)
end
addEventHandler("onClientGUIClick", groupInfoGUI.button[1], changeGroupInformation, false)

-- Add/Remove Group Reminders
------------------------------>>

addEvent("GTIgroups.getReminders", true)
addEventHandler("GTIgroups.getReminders", root, function(newsTable)
    newsItems = newsTable
        -- Delete Existing Reminders
    for i,gui in ipairs(groupNewsGUI.edit) do destroyElement(gui) end       groupNewsGUI.edit = {}
    for i,gui in ipairs(groupNewsGUI.checkbox) do destroyElement(gui) end   groupNewsGUI.checkbox = {}
    for i,gui in ipairs(groupNewsGUI.button) do destroyElement(gui) end     groupNewsGUI.button = {}
    
        -- Render New Reminder List
    local eY, cY, bY = 61, 85, 63
    local j = 0
    for i,news in ipairs(newsItems) do
        j = i - 1
        groupNewsGUI.edit[i] = guiCreateEdit(14, eY+(j*45), 256, 22, news[1], false, groupNewsGUI.window[1])
        guiEditSetMaxLength(groupNewsGUI.edit[i], 128)
        groupNewsGUI.checkbox[i] = guiCreateCheckBox(166, cY+(j*45), 104, 15, "Notify on Login", false, false, groupNewsGUI.window[1])
        guiCheckBoxSetSelected(groupNewsGUI.checkbox[i], news[2] == 1)
        groupNewsGUI.button[i] = guiCreateButton(277, bY+(j*45), 57, 18, "Remove", false, groupNewsGUI.window[1])
    end
    
        -- Update Window Size
    if (#newsItems < 5 and #newsItems > 0) then j = j + 1 end
    local sX, sY = guiGetScreenSize()
    local wX, wY = 346, 120+(j*45)
    local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
    guiSetPosition(groupNewsGUI.window[1], sX, sY, false)
    guiSetSize(groupNewsGUI.window[1], wX, wY, false)
    
        -- Add Option to Add Reminder
    if (#newsItems < 5) then
        groupNewsGUI.edit[j+1] = guiCreateEdit(14, eY+(j*45), 256, 22, "", false, groupNewsGUI.window[1])
        guiEditSetMaxLength(groupNewsGUI.edit[j+1], 128)
        groupNewsGUI.checkbox[j+1] = guiCreateCheckBox(166, cY+(j*45), 104, 15, "Notify on Login", false, false, groupNewsGUI.window[1])
        groupNewsGUI.button[j+1] = guiCreateButton(277, bY+(j*45), 57, 18, "Add", false, groupNewsGUI.window[1])
    end
    
        -- Move Save/Close Labels
    guiSetPosition(groupNewsGUI.label[2], 57, 91+(j*45), false)
    guiSetPosition(groupNewsGUI.label[3], 12, 91+(j*45), false)
    
        -- Show the Reminder Window
    guiBringToFront(groupNewsGUI.window[1])
    guiSetVisible(groupNewsGUI.window[1], true)
end)

    -- Update News from Cache -->
addEventHandler("onClientGUIClick", groupNewsGUI.window[1], function(button, state)
    if (button ~= "left" or state ~= "up") then return end
    if (getElementType(source) ~= "gui-button") then return end
    
    local index
    for i,v in ipairs(groupNewsGUI.button) do
        if (source == v) then
            index = i
            break
        end
    end
    
        -- Remove Item from List
    if (source == groupNewsGUI.button[index] and guiGetText(groupNewsGUI.button[index]) == "Remove") then
        table.remove(newsItems, index)
        -- Add Item to List
    elseif (source == groupNewsGUI.button[index] and guiGetText(groupNewsGUI.button[index]) == "Add") then
        local text = guiGetText(groupNewsGUI.edit[index])
        if (text == "") then return end
        table.insert(newsItems, {text, 0})
    end
    
        -- Update All Edit Texts & Check States
    for i,v in ipairs(newsItems) do
        local text = guiGetText(groupNewsGUI.edit[i])
        text = string.gsub(text, "~", "")
        text = string.gsub(text, ";", "")
        local check = guiCheckBoxGetSelected(groupNewsGUI.checkbox[i]) and 1 or 0
        newsItems[i] = {text, check}
    end
    
        -- Remove Empty Edits
    for i,v in ipairs(newsItems) do
        if (newsItems[i][1] == "") then table.remove(newsItems, i) end
    end
    
    triggerEvent("GTIgroups.getReminders", resourceRoot, newsItems)
end)

    -- Save Group Reminders
local remSpam
addEventHandler("onClientGUIClick", groupNewsGUI.label[3], function(button, state)
    if (button ~= "left" or state ~= "up") then return end
    if (remSpam) then return end
    remSpam = true
    setTimer(function() remSpam = nil end, 3000, 1)
    
        -- Update All Edit Texts & Check States
    for i,v in ipairs(newsItems) do
        local text = guiGetText(groupNewsGUI.edit[i])
        text = string.gsub(text, "~", "")
        text = string.gsub(text, ";", "")
        local check = guiCheckBoxGetSelected(groupNewsGUI.checkbox[i]) and 1 or 0
        newsItems[i] = {text, check}
    end
    
        -- Remove Empty Edits
    for i,v in ipairs(newsItems) do
        if (newsItems[i][1] == "") then table.remove(newsItems, i) end
    end
    
    guiSetVisible(groupNewsGUI.window[1], false)
    triggerServerEvent("GTIgroups.setReminders", resourceRoot, newsItems)   
end, false)

function onClientMouseEnterNews()
    local r,g,b = guiLabelGetColor(groupPanel.label[1])
    guiLabelSetColor(source, r, g, b)
end
addEventHandler("onClientMouseEnter", groupNewsGUI.label[2], onClientMouseEnterNews, false)
addEventHandler("onClientMouseEnter", groupNewsGUI.label[3], onClientMouseEnterNews, false)

function onClientMouseLeaveNews()
    guiLabelSetColor(source, 255, 255, 255)
end
addEventHandler("onClientMouseLeave", groupNewsGUI.label[2], onClientMouseLeaveNews, false)
addEventHandler("onClientMouseLeave", groupNewsGUI.label[3], onClientMouseLeaveNews, false)

-- Change Group Name
--------------------->>

function changeGroupName(button, state)
    if (button ~= "left" or state ~= "up") then return end
    local group_name = guiGetText(chgGrpNm_gui.edit[1])
    if (group_name == "") then
        exports.GTIhud:dm("Enter a group name first", 255, 125, 0)
        return
    end
    if (group_name == getElementData(localPlayer, "group")) then
        exports.GTIhud:dm("The group name that you entered is the same as the current name of your group. Change the name.", 255, 125, 0)
        return
    end
    
    if (guiGetText(chgGrpNm_gui.button[1]) == "Change (1)") then
        guiSetText(chgGrpNm_gui.button[1], "Change")
    elseif (guiGetText(chgGrpNm_gui.button[1]) == "Change") then
        triggerServerEvent("GTIgroupPanel.changeGroupName", root, group_name)
        guiSetVisible(chgGrpNm_gui.window[1], false)
        guiSetText(chgGrpNm_gui.button[1], "Change (1)")
    end
end
addEventHandler("onClientGUIClick", chgGrpNm_gui.button[1], changeGroupName, false)

-- Change Group Color
---------------------->>

function changeGroupColor(r, g, b)
    triggerServerEvent("GTIgroupPanel.changeGroupColor", root, r, g, b)
end

-- Toggle Friendly Fire
------------------------>>

addEvent("GTIgroups.getFriendlyFire", true)
addEventHandler("GTIgroups.getFriendlyFire", root, function(state)
    guiCheckBoxSetSelected(friendlyFireGUI.checkbox[1], not state)
    guiBringToFront(friendlyFireGUI.window[1])
    guiSetVisible(friendlyFireGUI.window[1], true)
end)

addEventHandler("onClientGUIClick", friendlyFireGUI.button[1], function(button, state)
    if (button ~= "left" or state ~= "up") then return end
    local state = guiCheckBoxGetSelected(friendlyFireGUI.checkbox[1])
    state = not state
    triggerServerEvent("GTIgroups.setFriendlyFire", resourceRoot, state)
    guiSetVisible(friendlyFireGUI.window[1], false)
end, false)

-- Toggle Group Blips
------------------------>>

addEvent("GTIgroups.getGroupBlips", true)
addEventHandler("GTIgroups.getGroupBlips", root, function(blipID)
    guiCheckBoxSetSelected(groupBlipsGUI.checkbox[1], blipID and true or false)
    guiSetText(groupBlipsGUI.edit[1], blipID or "")
    guiBringToFront(groupBlipsGUI.window[1])
    guiSetVisible(groupBlipsGUI.window[1], true)
end)

addEventHandler("onClientGUIClick", groupBlipsGUI.button[1], function(button, state)
    if (button ~= "left" or state ~= "up") then return end
    
    local state = guiCheckBoxGetSelected(groupBlipsGUI.checkbox[1]) 
    local blipID = tonumber( guiGetText(groupBlipsGUI.edit[1]) )
    if (state and not blipID or blipID < 5 or blipID > 63) then
        exports.GTIhud:dm("Enter a valid blip ID between 5 and 63", 255, 125, 0)
        return
    end
    
    triggerServerEvent("GTIgroups.setGroupBlips", resourceRoot, state, blipID)
    guiSetVisible(groupBlipsGUI.window[1], false)
end, false)

-- Delete Group
---------------->>

function deletePlayerGroup(button, state)
    if (button ~= "left" or state ~= "up") then return end
    local password = guiGetText(deleteGroupGUI.edit[1])
    if (#password == 0) then
        exports.GTIhud:dm("Please enter your user account password.", 255, 125, 0)
        return
    end
    
    if (guiGetText(deleteGroupGUI.button[2]) == "Delete (5)") then
        guiSetText(deleteGroupGUI.button[2], "Delete (4)")
    elseif (guiGetText(deleteGroupGUI.button[2]) == "Delete (4)") then
        guiSetText(deleteGroupGUI.button[2], "Delete (3)")
    elseif (guiGetText(deleteGroupGUI.button[2]) == "Delete (3)") then
        guiSetText(deleteGroupGUI.button[2], "Delete (2)")
    elseif (guiGetText(deleteGroupGUI.button[2]) == "Delete (2)") then
        guiSetText(deleteGroupGUI.button[2], "Delete (1)")
    elseif (guiGetText(deleteGroupGUI.button[2]) == "Delete (1)") then
        guiSetText(deleteGroupGUI.button[2], "Delete")
    elseif (guiGetText(deleteGroupGUI.button[2]) == "Delete") then
        triggerServerEvent("GTIgroupPanel.deletePlayerGroup", resourceRoot, password)
    end
end
addEventHandler("onClientGUIClick", deleteGroupGUI.button[2], deletePlayerGroup, false)

-- Job Restriction
------------------->>

function addJobsToGrid(ranks)
    guiGridListClear(jobRestrictGUI.gridlist[1])
    for i,job in ipairs(ranks["jobList"]) do
        local row = guiGridListAddRow(jobRestrictGUI.gridlist[1])
        guiGridListSetItemText(jobRestrictGUI.gridlist[1], row, 1, job, false, false)
        guiGridListSetItemText(jobRestrictGUI.gridlist[1], row, 2, "Enabled", false, false)
    end
end
addEvent("GTIgroups.addJobsToGrid", true)
addEventHandler("GTIgroups.addJobsToGrid", root, addJobsToGrid)    
