------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

EMwindow = nil
EMbuttons = {}
EMlabels = {}
EMedits = {}
EMcheckboxes = {}
EMgrid = nil
EMgridList = {}
lastAction = nil
canPlayerBeInEvent = false
curAction = nil
curAction2 = nil
gridCategories = {
    [1] = "-Player Controls:",
    [2] = "-Vehicle Controls:",
    [3] = "-Enviroment Control:",
    [4] = "-Utilities:",
}

EMgridControls = {
    [1] = {{"   Freeze players", "Freeze Players"}, {"   Unfreeze players", "Unfreeze Players"}, "TogglePlayerFreeze", 1},
    [2] = {{"   Freeze vehicles", "Freeze Vehicles"}, {"   Unfreeze vehicles", "Unfreeze Vehicles"}, "ToggleVehicleFreeze", 2},
    [3] = {{"   Lock vehicles", "Lock Vehicles"}, {"   Unlock vehicles", "Unlock Vehicles"}, "ToggleVehicleLock", 2},
    [4] = {{"   Disable falling from bike", "Disable"}, {"   Enable falling from bike", "Enable"}, "ToggleFallingFromBike", 2},
    [5] = {{"   Disable shooting", "Disable Shooting"}, {"   Enable Shooting", "Enable Shooting"}, "ToggleShooting", 1},
    [6] = {{"   Roadblocks", "Open RB GUI"}, function() executeCommandHandler("rb") end, 4},
    [7] = {{"   Disable player damage", "Disable Damage"}, {"   Enable player damage", "Enable Damage"}, "TogglePlayerDamage", 1},
    [8] = {{"   Disable vehicle damage", "Disable Damage"}, {"   Enable vehicle damage", "Enable Damage"}, "ToggleVehicleDamage", 2},
    [9] = {{"   Fix event vehicles", "Fix Vehicles"}, "FixEventVehicles", 2},
    [10] = {{"   Enable car flying", "Enable"}, {"   Disable car flying", "Disable"}, "ToggleVehicleFlying", 2},
    [11] = {{"   Give players jetpack", "Give Jetpack"}, {"   Take players jetpack", "Take Jetpack"}, "GivePlayersJetpack", 1},
    [12] = {{"   Destroy Spawner/Cars", "Destroy"}, function() triggerServerEvent("GTIevents.DelVehStuff", localPlayer) end, 4},
    [13] = {{"   Enable ramps for cars", "Enable"}, {"   Disable ramps for cars", "Disable"}, "ToggleVehicleRampSpawning", 2},
    [14] = {{"   Disable 'Quit Job'", "Disable"}, {"   Enable 'Quit Job'", "Enable"}, "ToggleQuitJob", 1},
    [15] = {{"   Disable 'End Shift'", "Disable"}, {"   Enable 'End Shift'", "Enable"}, "ToggleEndShift", 1},
    [16] = {{"   Warp event players to me", "Warp"}, "WarpEventPlayersToEM", 1},
    [17] = {{"   Disable vehicle leaving", "Disable"}, {"   Enable vehicle leaving", "Enable"}, "ToggleVehicleLeaving", 2},
    [18] = {{"   Disable collisions", "Disable Collisions"}, {"   Enable collisions", "Enable Collisions"}, "ToggleCollisions", 2},
    [19] = {{"   Set everyone off-duty", "Set"}, {"   Set everyone on-duty", "Set"}, "TogglePlayerWorking", 1},
    [20] = {{"   Load/Save Event", "Open Window"}, function() triggerServerEvent("GTIevents.GetEvents", root) end, 4},
    [21] = {{"   Disable Weapons", "Disable Weapons"}, {"   Enable Weapons", "Enable Weapons"}, "ToggleWeapons", 1},
    [22] = {{"   Disable hijacking", "Disable"}, {"   Enable hijacking", "Enable"}, "ToggleVehicleHijacking", 2},
    [23] = {{"   Disable Team Killing", "Disable Team Killing"}, {"   Enable Team Killing", "Enable Team Killing"}, "ToggleTeamKilling", 1},
    [24] = {{"   Change Weather", "Change Weather"}, "ChangeWeather", 3, {{9999999, "Weather ID (http://wiki.multitheftauto.com/wiki/Weather)", 0}}},
    [25] = {{"   Change Wave Height", "Change Wave Height"}, "ChangeWaveHeight", 3, {{100, "0-100", 0}}},
    [26] = {{"   Change Water Level", "Change Water Level"}, "ChangeWaterlevel", 3, {{100, "WIP", -100}}},
    [27] = {{"   Element Explorer", "Open Window"}, function() triggerServerEvent("GTIevents.GetElements", root) end, 4},
}

EMplayergridcontrols = {
    [1] = {{"Freeze player", "Freeze Player"}, {"Unfreeze player", "Unfreeze Player"}, "FreezePlayer"},
    [2] = {{"Kick player from event", "Kick Player"}, nil, "KickPlayer"},
    [3] = {{"Give Cash", "Give Cash"}, nil, "GiveCash", {{50000, "Amount"}, {"", "Reason"}}},
    [4] = {{"Give access to /eventjetpack", "Give Access"}, nil, "ToggleEventJetpack"},
    [5] = {{"Give Jetpack", "Give Jetpack"}, {"Remove Jetpack", "Remove Jetpack"}, "ToggleJetpack"},
    [6] = {{"Set Health", "Set Health"}, nil, "SetHealth", {{200, "HP Amount"}}},
    [7] = {{"Set Armor", "Set Armor"}, nil, "SetArmor", {{100, "Armor Amount"}}},
    [8] = {{"Resend Client Features", "Resend"}, nil, "ResendCF"},
}

EMgridClearCategories = {}
EMplayersgridClearCategories = {}
resX, resY = guiGetScreenSize()

addEvent("showEMW", true)
addEventHandler( "showEMW", localPlayer,
function(vipAmount, config, isEventStarted, total)
    if (not EMwindow) then
        EMwindow = guiCreateWindow((resX/2) - 370, (resY/2) - 135, 771, 271, "Events Manager Panel", false)
        guiWindowSetSizable(EMwindow, false)
        guiSetAlpha(EMwindow, 1.00)

        EMlabels[1] = guiCreateLabel(206, 47, 61, 16, "Warp limit:", false, EMwindow)
        EMlabels[2] = guiCreateLabel(206, 23, 71, 15, "Soon: 1", false, EMwindow)
        EMlabels[3] = guiCreateLabel(284, 23, 118, 15, "Warps used: 0/0", false, EMwindow)
        guiLabelSetColor(EMlabels[2], 0, 255, 0)
        guiLabelSetColor(EMlabels[3], 0, 255, 0)

        EMedits[1] = guiCreateEdit(271, 44, 76, 20, "30", false, EMwindow)
        EMedits[2] = guiCreateEdit(207, 145, 198, 18, "", false, EMwindow)
        EMedits[3] = guiCreateEdit(434, 28, 157, 23, "", false, EMwindow)
        EMedits[4] = guiCreateEdit(597, 212, 81, 18, "input 1", false, EMwindow)
        EMedits[5] = guiCreateEdit(680, 212, 81, 18, "input 2", false, EMwindow)
        EMedits[6] = guiCreateEdit(9, 212, 95, 18, "input 1", false, EMwindow)
        EMedits[7] = guiCreateEdit(106, 212, 95, 18, "input 2", false, EMwindow)

        EMcheckboxes[1] = guiCreateCheckBox(208, 68, 159, 15, "Soon", false, false, EMwindow)
        EMcheckboxes[2] = guiCreateCheckBox(208, 87, 159, 15, "Freeze upon warping", false, false, EMwindow)
        EMcheckboxes[3] = guiCreateCheckBox(208, 106, 159, 15, "Allow multiple warps", false, false, EMwindow)
        EMcheckboxes[4] = guiCreateCheckBox(208, 125, 193, 15, "Allow/Disallow specific team/job", false, false, EMwindow)

        EMgrid = guiCreateGridList(9, 24, 193, 207, false, EMwindow)
        playerSearchGrid = guiCreateGridList(434, 54, 157, 207, false, EMwindow) 
        playerActionsGrid = guiCreateGridList(597, 29, 165, 181, false, EMwindow)
        guiGridListSetSelectionMode(playerSearchGrid, 1)
        guiGridListSetSortingEnabled(EMgrid, false)
        guiGridListAddColumn(playerActionsGrid, "Player Controls", 2)
        guiGridListAddColumn(playerSearchGrid, "Players in event dimension", 0.9)
        guiGridListAddColumn(EMgrid, "Event Controls", 1)
        guiGridListSetSortingEnabled(playerSearchGrid, false)
        guiGridListSetSortingEnabled(playerActionsGrid, false)

        EMbuttons[1] = guiCreateButton(204, 173, 102, 42, "Start Event", false, EMwindow)
        EMbuttons[2] = guiCreateButton(308, 173, 102, 42, "Stop Event", false, EMwindow)
        EMbuttons[3] = guiCreateButton(308, 222, 101, 40, "Close Window", false, EMwindow)
        EMbuttons[4] = guiCreateButton(204, 222, 102, 40, "Dimension Warp", false, EMwindow)
        EMbuttons[5] = guiCreateButton(9, 234, 193, 28, "No action selected", false, EMwindow)
        EMbuttons[6] = guiCreateButton(412, 26, 18, 236, ">>", false, EMwindow)
        EMbuttons[7] = guiCreateButton(596, 212, 166, 49, "No action selected", false, EMwindow)
        guiSetEnabled(EMbuttons[5], false)
        guiSetEnabled(EMbuttons[7], false)
        guiSetEnabled(EMedits[2], false)
        
        addEventHandler ("onClientGUIClick", EMbuttons[1], startEvent, false)
        addEventHandler ("onClientGUIClick", EMbuttons[2], stopEvent, false)
        addEventHandler ("onClientGUIClick", EMbuttons[3], hideEMwindow, false)
        addEventHandler ("onClientGUIClick", EMbuttons[4], function() triggerServerEvent("eventDim", localPlayer) end, false)
        addEventHandler ("onClientGUIClick", EMbuttons[5], onActionClick, false)
        addEventHandler ("onClientGUIClick", EMbuttons[6], resizeWindow, false)
        addEventHandler ("onClientGUIClick", EMedits[4], onPlayerControlsEditClick, false)
        addEventHandler ("onClientGUIClick", EMedits[5], onPlayerControlsEditClick, false)
        addEventHandler ("onClientGUIClick", EMedits[6], onEMGridEditClick, false)
        addEventHandler ("onClientGUIClick", EMedits[7], onEMGridEditClick, false)
        addEventHandler ("onClientGUIClick", EMcheckboxes[4], onTeamCheckBoxClick, false)
        addEventHandler ("onClientGUIClick", EMgrid, onGridClick, false)
        addEventHandler ("onClientGUIClick", playerSearchGrid, onPlayersGridListClick, false)
        addEventHandler ("onClientGUIClick", playerActionsGrid, onPlayerControlsGridListClick, false)
        addEventHandler ("onClientGUIClick", EMbuttons[7], onPlayerAction, false)
        addEventHandler ("onClientGUIDoubleClick", EMgrid, onActionClick, false)
        addEventHandler ("onClientGUIChanged", EMedits[1], onClientGUIChanged, false)
        addEventHandler ("onClientGUIChanged", EMedits[4], onEditChange, false)
        addEventHandler ("onClientGUIChanged", EMedits[3], onPlayerSearch, false)
        addEventHandler ("onClientGUIChanged", EMedits[5], onEditChange, false)
        addEventHandler ("onClientGUIChanged", EMedits[6], onEditChange2, false)
        addEventHandler ("onClientGUIChanged", EMedits[7], onEditChange2, false)
        guiSetSize(EMwindow, 439, 271, false)
        guiSetPosition(EMwindow, (resX/2) - 220, (resY/2) - 135, false)
        guiSetVisible(EMedits[4], false)
        guiSetVisible(EMedits[5], false)
        guiSetVisible(EMedits[6], false)
        guiSetVisible(EMedits[7], false)
        processPlayerControls()
    else
        guiSetVisible(EMwindow, true)
    end
    processList(config)
    guiSetText(EMlabels[2], "Soon: "..vipAmount)
    guiSetText(EMlabels[3], "Warps used: "..total[1].."/"..total[2])
    showCursor(true)
    if (isEventStarted) then
        guiSetEnabled(EMbuttons[2], true)
        guiSetText(EMbuttons[1], "Add "..guiGetText(EMedits[1]).." more warps")
    else
        guiSetEnabled(EMbuttons[2], false)
        guiSetText(EMbuttons[1], "Start Event")
    end
end)

function resizeWindow()
    local gpx, gpy = guiGetPosition(EMwindow, false)
    local gsx, gsy = guiGetSize(EMwindow, false)
    if (guiGetText(source) == ">>") then -- Expand GUI
        guiSetText(source, "<<")
        guiSetSize(EMwindow, 771, 271, false)
        guiSetPosition(EMwindow, gpx - (771 - gsx) * 0.5 , gpy, false)
    else
        guiSetText(source, ">>")
        guiSetSize(EMwindow, 439, 271, false)
        guiSetPosition(EMwindow, gpx - (439 - gsx) * 0.5, gpy, false)
    end
end

function processList(config)
    for k,v in ipairs(config) do
        if (v == true) then
            if (type(EMgridControls[k][2]) == "table") then
                EMgridClearCategories[k] = {EMgridControls[k][2], EMgridControls[k][3], EMgridControls[k][4], EMgridControls[k][5]}
            else
                EMgridClearCategories[k] = {EMgridControls[k][1], EMgridControls[k][2], EMgridControls[k][3], EMgridControls[k][4]}
            end
        else
            if (type(EMgridControls[k][2]) == "table") then
                EMgridClearCategories[k] = {EMgridControls[k][1], EMgridControls[k][3], EMgridControls[k][4], EMgridControls[k][5]}
            else
                EMgridClearCategories[k] = {EMgridControls[k][1], EMgridControls[k][2], EMgridControls[k][3], EMgridControls[k][4]}
            end
        end
    end
    local rowCount = guiGridListGetRowCount(EMgrid)
    for k,v in ipairs(gridCategories) do
        if (rowCount < 1) then
            guiGridListSetItemText(EMgrid, guiGridListAddRow(EMgrid), 1, v, false, false)
        end
        for key,val in ipairs(EMgridClearCategories) do
            if (k == val[3]) then
                if (rowCount < 1) then
                    local row = guiGridListAddRow(EMgrid)
                    guiGridListSetItemText(EMgrid, row, 1, val[1][1], false, false)
                    guiGridListSetItemColor(EMgrid, row, 1, 180, 180, 180)
                else
                    local text
                    if (type(EMgridControls[key][2]) == "table" and EMgridControls[key][1][1] == val[1][1]) then
                        text = EMgridControls[key][2][1]
                    else
                        text = EMgridControls[key][1][1]
                    end
                    local rowIndex = getGridListRowIndexFromText(EMgrid, text, 1)
                    if (rowIndex) then
                        guiGridListSetItemText(EMgrid, rowIndex, 1, val[1][1], false, false)
                    end
                end
            end
        end
    end
    local selectedItem = guiGridListGetSelectedItem(EMgrid, lastItem)
    local text = guiGridListGetItemText(EMgrid, selectedItem, 1)
    local index = getTableIndex(text)
    if (index) then
        guiSetText(EMbuttons[5], EMgridClearCategories[index][1][2])
    end
end
addEvent("GTIevents.RefreshCData", true)
addEventHandler("GTIevents.RefreshCData", root, processList)

function controlsEditCheck(index)
    if (not index) or (index < 1) then
        guiSetVisible(EMedits[6], false)
        guiSetVisible(EMedits[7], false)
        guiSetSize(EMgrid, 193, 207, false)
        return
    end
    local infoTable = EMgridClearCategories[index][4]
    if (infoTable) then
        if (infoTable[2]) then -- 2 edits
            guiSetVisible(EMedits[6], true)
            guiSetVisible(EMedits[7], true)
            guiSetSize(EMedits[6], 95, 18, false)
            guiSetText(EMedits[6], infoTable[1][2])
            guiSetText(EMedits[7], infoTable[2][2])
        elseif (infoTable[1]) then -- 1 edit
            guiSetVisible(EMedits[6], true)
            guiSetVisible(EMedits[7], false)
            guiSetSize(EMedits[6], 192, 18, false)
            guiSetText(EMedits[6], infoTable[1][2])
        end
        guiSetSize(EMgrid, 193, 187, false)
    else -- no edits, resize everything
        guiSetVisible(EMedits[6], false)
        guiSetVisible(EMedits[7], false)
        guiSetSize(EMgrid, 193, 207, false)
    end
end

function getGridListRowIndexFromText(gridlist, text, column, useData)
    for i=0, guiGridListGetRowCount(gridlist) do
        if (useData) then
            if (string.find(guiGridListGetItemData(gridlist, i, column), text)) then
                return i
            end
        else
            if (guiGridListGetItemText(gridlist, i, column) == text) then
                return i
            end
        end
    end
end

function getGridListItem(gridList, column, useData, multiple)
    if (multiple) then
        local tableToReturn = {}
        local selectedItems = guiGridListGetSelectedItems(gridList)
        if (useData) then
            for k,v in ipairs(selectedItems) do
                table.insert(tableToReturn, guiGridListGetItemData(gridList, v.row, column))
            end
        else
            for k,v in ipairs(selectedItems) do
                table.insert(tableToReturn, guiGridListGetItemText(gridList, v.row, column))
            end
        end
        return tableToReturn
    else
        local selectedItem = guiGridListGetSelectedItem(gridList)
        if (useData) then
            return guiGridListGetItemData(gridList, selectedItem, column)
        else
            return guiGridListGetItemText(gridList, selectedItem, column)
        end
    end
end

function processPlayerControls()
    for k,v in ipairs(EMplayergridcontrols) do
        local row = guiGridListAddRow(playerActionsGrid)
        guiGridListSetItemText(playerActionsGrid, row, 1, v[1][1], false, false)
        guiGridListSetItemColor(playerActionsGrid, row, 1, 180, 180, 180)
    end
end

function getTableIndex(text)
    for k,v in ipairs(gridCategories) do
        if (v == text) then
            return
        end
    end
    for k,v in ipairs(EMgridClearCategories) do
        if (v[1][1] == text) or (v[1][2] == text) then
            return k
        end
    end
end

function onActionClick()
    local text = guiGridListGetItemText(EMgrid, guiGridListGetSelectedItem(EMgrid))
    local index = getTableIndex(text)
    if (index) then
        local func = EMgridClearCategories[index][2]
        if (type(func) == "string") then
            triggerServerEvent("GTIevents.Action", root, func, index, guiGetText(EMedits[6]), guiGetText(EMedits[7]))
        elseif (type(func) == "function") then
            func()
        end
    end
end

function onGridClick()
    local text = guiGridListGetItemText(EMgrid, guiGridListGetSelectedItem(EMgrid), 1)
    local index = getTableIndex(text)
    if (index) then
        guiSetText(EMbuttons[5], EMgridClearCategories[index][1][2])
        guiSetEnabled(EMbuttons[5], true)
        curAction2 = index
    else
        guiSetText(EMbuttons[5], "No action selected")
        guiSetEnabled(EMbuttons[5], false)
    end
    controlsEditCheck(index)
end

function hideEMwindow()
    guiSetVisible(EMwindow, false)
    handleCursorVisibility()
    if (saveStuf[1]) then
        guiSetVisible(saveStuf[1], false)
    end
end

function startEvent()
    local limit = guiGetText(EMedits[1])
    if (limit ~= "" and getTeamName(getPlayerTeam(localPlayer)) == "Government") then
        local teamJobs
        local forbidTeams = {}
        local allowedTeams = {}
        local count = 0
        local forbid
        local tableToSend
        if (guiCheckBoxGetSelected(EMcheckboxes[4])) then
            teamJobs = split(guiGetText(EMedits[2]), ",")
            if (teamJobs) then
                for k,v in ipairs(teamJobs) do
                    if (string.find(v, "-")) then count = count + 1 end
                end
            end
            tableToSend = teamJobs
            if (count == 0) or (count == #teamJobs) then
                if (count == #teamJobs) then
                    forbid = true
                    tableToSend = {}
                    for k,v in ipairs(teamJobs) do
                        tableToSend[k] = split(v, "-")[1]
                    end
                else
                    forbid = false
                end
            else
                exports.GTIhud:dm("You can forbid/only allow job/teams at the same time", 255, 0, 0)
                return
            end
        end 
        if (guiGetText(source) == "Start Event") then
            triggerServerEvent("GTIevents.PreCreateEvent", root, limit, guiCheckBoxGetSelected(EMcheckboxes[3]), guiCheckBoxGetSelected(EMcheckboxes[1]), guiCheckBoxGetSelected(EMcheckboxes[2]), tableToSend, forbid)
            hideEMwindow()
        else
            if (tonumber(guiGetText(EMedits[1]))) then
                triggerServerEvent("GTIevents.AddWarps", root, limit, guiCheckBoxGetSelected(EMcheckboxes[3]), guiCheckBoxGetSelected(EMcheckboxes[2]), tableToSend, forbid)
                hideEMwindow()
            end
        end
    end
end

function onPlayersGridListClick()
    local currentAction = guiGridListGetSelectedItem(playerActionsGrid) + 1
    local selectedItems = getGridListItem(playerSearchGrid, 1, true, true)
    if (#selectedItems == 1) then
        local player = getPlayerFromName(selectedItems[1])
        if (player) then
            if (isElementFrozen(player)) then
                guiGridListSetItemText(playerActionsGrid, 0, 1, EMplayergridcontrols[1][2][1], false, false)
            else
                guiGridListSetItemText(playerActionsGrid, 0, 1, EMplayergridcontrols[1][1][1], false, false)
            end
            if (doesPedHaveJetPack(player)) then
                guiGridListSetItemText(playerActionsGrid, 4, 1, EMplayergridcontrols[5][2][1], false, false)
            else
                guiGridListSetItemText(playerActionsGrid, 4, 1, EMplayergridcontrols[5][1][1], false, false)
            end
        else
            guiSetText(EMbuttons[7], "Error getting player's data")
            guiSetEnabled(EMbuttons[7], false)
            return
        end
    end
    if (currentAction >= 1) then
        if (#selectedItems > 0) then
                editsCheck()
                return
        else
            guiSetText(EMbuttons[7], "No Player(s) Selected")
        end
    else
        guiSetText(EMbuttons[7], "No action selected")
    end
    guiSetEnabled(EMbuttons[7], false)
    guiSetPosition(EMbuttons[7], 596, 212, false)
    guiSetSize(EMbuttons[7], 166, 49, false)
    guiSetVisible(EMedits[4], false)
    guiSetVisible(EMedits[5], false)
end

function onPlayerControlsGridListClick()
    local currentAction = guiGridListGetSelectedItem(playerActionsGrid) + 1
    local players = getGridListItem(playerSearchGrid, 1, true, true)
    curAction = currentAction
    if (currentAction >= 1) then
        local selectedItems = getGridListItem(playerSearchGrid, 1, true, true)
        if (#selectedItems > 0) then
            editsCheck()
            return
        else
            guiSetText(EMbuttons[7], "No Player(s) Selected")
        end
    else
        guiSetText(EMbuttons[7], "No action selected")
    end
    guiSetEnabled(EMbuttons[7], false)
    guiSetPosition(EMbuttons[7], 596, 212, false)
    guiSetSize(EMbuttons[7], 166, 49, false)
    guiSetVisible(EMedits[4], false)
    guiSetVisible(EMedits[5], false)
end

function editsCheck()
    local currentAction = guiGridListGetSelectedItem(playerActionsGrid) + 1
    local players = getGridListItem(playerSearchGrid, 1, true, true)
    guiSetEnabled(EMbuttons[7], true)
    if (currentAction == 1) then
        if (#players > 1) then
            guiSetText(EMbuttons[7], "Not available for multiple players")
            guiSetEnabled(EMbuttons[7], false)
        else
            local player = getPlayerFromName(players[1])
            if (player) then
                if (isElementFrozen(player)) then
                    guiSetText(EMbuttons[7], EMplayergridcontrols[1][2][2])
                else
                    guiSetText(EMbuttons[7], EMplayergridcontrols[1][1][2])
                end
            else
                guiSetText(EMbuttons[7], "Error getting player's data")
                guiSetEnabled(EMbuttons[7], false)
            end
        end
    elseif (currentAction == 5) then
        if (#players > 1) then
            guiSetText(EMbuttons[7], "Not available for multiple players")
            guiSetEnabled(EMbuttons[7], false)
        else
            local player = getPlayerFromName(players[1])
            if (player) then
                if (doesPedHaveJetPack(player)) then
                    guiSetText(EMbuttons[7], EMplayergridcontrols[5][2][2])
                else
                    guiSetText(EMbuttons[7], EMplayergridcontrols[5][1][2])
                end
            else
                guiSetText(EMbuttons[7], "Error getting player's data")
                guiSetEnabled(EMbuttons[7], false)
            end
        end
    else
        guiSetText(EMbuttons[7], EMplayergridcontrols[currentAction][1][2])
    end
    if (EMplayergridcontrols[currentAction][4]) then
        if (EMplayergridcontrols[currentAction][4][2]) then
            guiSetPosition(EMbuttons[7], 596, 231, false)
            guiSetSize(EMbuttons[7], 166, 30, false)
            guiSetSize(EMedits[4], 81, 18, false)
            guiSetVisible(EMedits[4], true)
            guiSetVisible(EMedits[5], true)
            if (currentAction ~= lastAction) then
                guiSetText(EMedits[4], EMplayergridcontrols[currentAction][4][1][2])
                guiSetText(EMedits[5], EMplayergridcontrols[currentAction][4][2][2])
                lastValidText1 = ""
                lastValidText2 = ""
            end
        else
            guiSetPosition(EMbuttons[7], 596, 231, false)
            guiSetSize(EMbuttons[7], 166, 30, false)
            guiSetSize(EMedits[4], 166, 18, false)
            guiSetVisible(EMedits[4], true)
            guiSetVisible(EMedits[5], false)
            if (currentAction ~= lastAction) then
                guiSetText(EMedits[4], EMplayergridcontrols[currentAction][4][1][2])
                lastValidText1 = ""
                lastValidText2 = ""
            end
        end
    else
        guiSetPosition(EMbuttons[7], 596, 212, false)
        guiSetSize(EMbuttons[7], 166, 49, false)
        guiSetVisible(EMedits[4], false)
        guiSetVisible(EMedits[5], false)
    end
    lastAction = currentAction
end

lastValidText1 = ""
lastValidText2 = ""
isOnEditChangeEnabled = true
function onEditChange()
    if (isOnEditChangeEnabled) then
        if (EMplayergridcontrols[curAction][4]) then
            if (source == EMedits[4]) then
                if (EMplayergridcontrols[curAction][4][1][1] and EMplayergridcontrols[curAction][4][1][1] ~= "") then
                    local number = EMplayergridcontrols[curAction][4][1][1]
                    local text = tonumber(guiGetText(source))
                    if (text) or (guiGetText(source) == "") then
                        if (guiGetText(source) == "") or (text <= number and text >= 1) then
                            lastValidText1 = text
                        else
                            if (lastValidText1) then
                                guiSetText(source, lastValidText1)
                            else
                                guiSetText(source, "")
                            end
                        end
                    else
                        if (lastValidText1) then
                            guiSetText(source, lastValidText1)
                        else
                            guiSetText(source, "")
                        end
                    end
                end
            elseif (source == EMedits[5]) then
                if (EMplayergridcontrols[curAction][4][2][1] and EMplayergridcontrols[curAction][4][2][1] ~= "") then
                    local number = EMplayergridcontrols[curAction][4][2][1]
                    local text = tonumber(guiGetText(source))
                    if (text) or (guiGetText(source) == "") then
                        if (guiGetText(source) == "") or (text <= number and text >= 1) then
                            lastValidText2 = text
                        else
                            if (lastValidText2) then
                                guiSetText(source, lastValidText2)
                            else
                                guiSetText(source, "")
                            end
                        end
                    else
                        if (lastValidText2) then
                            guiSetText(source, lastValidText2)
                        else
                            guiSetText(source, "")
                        end
                    end
                end
            end
        end
    end
end

function onEditChange2()
    if (isOnEditChangeEnabled) then
        if (EMgridClearCategories[curAction2][4]) then
            if (source == EMedits[6]) then
                if (EMgridClearCategories[curAction2][4][1][1] and EMgridClearCategories[curAction2][4][1][1] ~= "") then
                    local number = EMgridClearCategories[curAction2][4][1][1]
                    local text = tonumber(guiGetText(source))
                    if (text) or (guiGetText(source) == "") then
                        if (guiGetText(source) == "") or (text <= number and text >= EMgridClearCategories[curAction2][4][1][3]) then
                            lastValidText1 = text
                        else
                            if (lastValidText1) then
                                guiSetText(source, lastValidText1)
                            else
                                guiSetText(source, "")
                            end
                        end
                    else
                        if (lastValidText1) then
                            guiSetText(source, lastValidText1)
                        else
                            guiSetText(source, "")
                        end
                    end
                end
            elseif (source == EMedits[7]) then
                if (EMgridClearCategories[curAction2][4][2][1] and EMgridClearCategories[curAction2][4][2][1] ~= "") then
                    local number = EMgridClearCategories[curAction2][4][2][1]
                    local text = tonumber(guiGetText(source))
                    if (text) or (guiGetText(source) == "") then
                        if (guiGetText(source) == "") or (text <= number and text >= EMgridClearCategories[curAction2][4][2][3]) then
                            lastValidText2 = text
                        else
                            if (lastValidText2) then
                                guiSetText(source, lastValidText2)
                            else
                                guiSetText(source, "")
                            end
                        end
                    else
                        if (lastValidText2) then
                            guiSetText(source, lastValidText2)
                        else
                            guiSetText(source, "")
                        end
                    end
                end
            end
        end
    end
end

function onPlayerControlsEditClick()
    if (EMplayergridcontrols[curAction][4]) then
        local text = guiGetText(source)
        if (source == EMedits[4]) then
            if (text == EMplayergridcontrols[curAction][4][1][2]) then
                guiSetText(source, "")
            end
        else
            if (text == EMplayergridcontrols[curAction][4][2][2]) then
                guiSetText(source, "")
            end
        end
    end
end

function onEMGridEditClick()
    if (EMgridClearCategories[curAction2][4]) then
        local text = guiGetText(source)
        if (source == EMedits[6]) then
            if (text == EMgridClearCategories[curAction2][4][1][2]) then
                guiSetText(source, "")
            end
        else
            if (text == EMgridClearCategories[curAction2][4][2][2]) then
                guiSetText(source, "")
            end
        end
    end
end

function onClientGUIChanged()
    if (guiGetText(EMbuttons[1]) ~= "Start Event") then
        if (tonumber(guiGetText(EMedits[1]))) then
            guiSetEnabled(EMbuttons[1], true)
            guiSetText(EMbuttons[1], "Add "..guiGetText(EMedits[1]).." more warps")
        else
            guiSetEnabled(EMbuttons[1], false)
            guiSetText(EMbuttons[1], "Insert a valid number")
        end
    end
end

function stopEvent()
    if (limit ~= "" and getTeamName(getPlayerTeam(localPlayer)) == "Government") then
        triggerServerEvent("GTIevents.StopEvent", root)
        hideEMwindow()
    end
end

function onTeamCheckBoxClick()
    if (guiCheckBoxGetSelected(EMcheckboxes[4])) then
        guiSetEnabled(EMedits[2], true)
    else
        guiSetEnabled(EMedits[2], false)
    end
end

function toggleClientFeature(config, edf)
    if (config) then
        if (config[1]) then
            setPedCanBeKnockedOffBike(localPlayer, false)
        else
            setPedCanBeKnockedOffBike(localPlayer, true)
        end
        if (config[2]) then
            addEventHandler("onClientPlayerDamage", root, onPlayerDamage)
        else
            removeEventHandler("onClientPlayerDamage", root, onPlayerDamage)
        end
        if (config[3]) then
            setWorldSpecialPropertyEnabled("aircars", true)
        else
            setWorldSpecialPropertyEnabled("aircars", false)
        end
        if (config[4]) then
            disableCollisions()
        else
            enableCollisions()
        end
        if (config[5]) then
            enabledWep()
            setPedWeaponSlot(localPlayer, 0)
        else
            disableWep()
        end
        if (config[6]) then
            addEventHandler("onClientPlayerDamage", root, onPlayerDamage2)
        else
            removeEventHandler("onClientPlayerDamage", root, onPlayerDamage2)
        end
        canPlayerBeInEvent = true
    end
    if (edf) then
        applyEventDimFeatures(edf)
    end
end
addEvent("GTIevents.ToggleClientFeature", true)
addEventHandler("GTIevents.ToggleClientFeature", root, toggleClientFeature)

function applyEventDimFeatures(config)
    if (config and getElementDimension(localPlayer) == 336) then
        eventDimFeatures = config
        if (config[1]) then
            setWeather(config[1])
        end
        if (config[2]) then
            setWaveHeight(config[2])
        end
    end
end
addEvent("GTIevents.SendEventDimFeature", true)
addEventHandler("GTIevents.SendEventDimFeature", root, applyEventDimFeatures)

function removeEventDimFeatures(config)
    eventDimFeatures = nil
    if (config[1]) then
        setWeather(config[1])
    end
    if (config[2]) then
        setWaveHeight(config[2])
    end
end
addEvent("GTIevents.RemoveEventDimFeatures", true)
addEventHandler("GTIevents.RemoveEventDimFeatures", root, removeEventDimFeatures)

function EDFCheck()
    local dim = getElementDimension(localPlayer)
    if (dim == 336) then
        if (not eventDimFeatures) then
            triggerServerEvent("GTIevents.GetEventDimFeatures", root)
        end
    else
        if (eventDimFeatures) then
            triggerServerEvent("GTIevents.GetNormalFeaturesState", root)
        end
    end
end
setTimer(EDFCheck, 3000, 0)

function onClientVehicleStartEnter(ePlayer)
    if (ePlayer == localplayer) then
        if (getVehicleOccupant(source, 0)) then
            cancelEvent()
        end
    end
end

function onPlayerDamage()
    cancelEvent("Event")
end

function onPlayerDamage2(attacker)
    if (isElement(attacker) and getElementType(attacker) == "player") then
        local team1 = getPlayerTeam(source)
        local team2 = getPlayerTeam(attacker)
        if (team1 == team2) then
            cancelEvent("Event Team Killing disabled")
        end
    end
end

function command_em()
    triggerServerEvent("EMcheck", root)
end
addCommandHandler("em", command_em)

function enableCollisions()
    for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
        for i,veh in ipairs(getElementsByType("vehicle")) do
            setElementCollidableWith(v, veh, true)
        end
    end
end

function disableCollisions()
    for k,v in ipairs(getElementsByType("vehicle")) do
        for i,veh in ipairs(getElementsByType("vehicle")) do
            setElementCollidableWith(v, veh, false)
        end
    end
end

function weaponSwitch()
    setPedWeaponSlot(localPlayer, 0)
end

function enabledWep()
    addEventHandler("onClientPlayerWeaponSwitch", root, weaponSwitch)
end

function disableWep()
    removeEventHandler("onClientPlayerWeaponSwitch", root, weaponSwitch)
end

function checkPossibleExploit()
    if (canPlayerBeInEvent) then
        if (getElementDimension(localPlayer) ~= 336) then
            canPlayerBeInEvent = false
            setWorldSpecialPropertyEnabled("aircars", false)
            removeEventHandler("onClientPlayerDamage", root, onPlayerDamage)
            setPedCanBeKnockedOffBike(localPlayer, true)
            disableCollisions()
            disableWep()
        end
    end
end
setTimer(checkPossibleExploit, 5000, 0)

function onPlayerSearch()
    local text = guiGetText(source)
    if (text ~= "") then
        updatePlayersGridList(text)
    end 
end

function updatePlayersGridList(text)
    if (playerSearchGrid and guiGetVisible(EMwindow) and guiGetText(EMbuttons[6]) == "<<" and (guiGetText(EMedits[3]) == "" or text)) then
        for k,v in ipairs(getPlayersInEventDimension()) do
            local pname = getPlayerName(v)
            if (not isTextInGridList(playerSearchGrid, pname) and getElementHealth(v) > 0) then
                if (not text) or (text and string.find(string.upper(pname), string.upper(text))) then
                    local row = guiGridListAddRow(playerSearchGrid)
                    if (getElementData(v, "e")) then
                        guiGridListSetItemText(playerSearchGrid, row, 1, "+ "..pname, false, false)
                    else
                        guiGridListSetItemText(playerSearchGrid, row, 1, pname, false, false)
                    end
                    guiGridListSetItemData(playerSearchGrid, row, 1, pname)
                    local r, g, b = getPlayerNametagColor(v)
                    guiGridListSetItemColor(playerSearchGrid, row, 1, r, g, b)
                end
            end
        end
        for i=0, guiGridListGetRowCount(playerSearchGrid) do
            local name = guiGridListGetItemData(playerSearchGrid, i, 1)
            if (name) then
                local player = getPlayerFromName(name)
                if (text) then
                    if (text and not string.find(string.upper(name), string.upper(text))) then
                        guiGridListRemoveRow(playerSearchGrid, i)
                        player = nil
                    end
                end
                if (player) then
                    if (getElementDimension(player) ~= 336) or (getElementHealth(player) == 0) then
                        guiGridListRemoveRow(playerSearchGrid, i)
                    else
                        local pText = guiGridListGetItemText(playerSearchGrid, i, 1)
                        if (string.find(pText, "+ ")) then
                            if (not getElementData(player, "e")) then
                                guiGridListSetItemText(playerSearchGrid, i, 1, name, false, false)
                            end
                        else
                            if (getElementData(player, "e")) then
                                guiGridListSetItemText(playerSearchGrid, i, 1, "+ "..name, false, false)
                            end
                        end
                        local r, g, b = getPlayerNametagColor(player)
                        guiGridListSetItemColor(playerSearchGrid, i, 1, r, g, b)
                    end
                else
                    guiGridListRemoveRow(playerSearchGrid, i)
                end
            else
                guiGridListRemoveRow(playerSearchGrid, i)
            end
        end
        local selectedItems = getGridListItem(playerSearchGrid, 1, true, true)
        local currentAction = guiGridListGetSelectedItem(playerActionsGrid) + 1
        if (#selectedItems == 1) then
            if (currentAction == 1) or (currentAction == 5) then
                local player = getPlayerFromName(selectedItems[1])
                if (player) then
                    if (currentAction == 1) then
                        if (isElementFrozen(player)) then
                            guiGridListSetItemText(playerActionsGrid, 0, 1, EMplayergridcontrols[1][2][1], false, false)
                            guiSetText(EMbuttons[7], EMplayergridcontrols[1][2][2])
                        else
                            guiGridListSetItemText(playerActionsGrid, 0, 1, EMplayergridcontrols[1][1][1], false, false)
                            guiSetText(EMbuttons[7], EMplayergridcontrols[1][1][2])
                        end
                    else
                        if (doesPedHaveJetPack(player)) then
                            guiGridListSetItemText(playerActionsGrid, 4, 1, EMplayergridcontrols[5][2][1], false, false)
                            guiSetText(EMbuttons[7], EMplayergridcontrols[5][2][2])
                        else
                            guiGridListSetItemText(playerActionsGrid, 4, 1, EMplayergridcontrols[5][1][1], false, false)
                            guiSetText(EMbuttons[7], EMplayergridcontrols[5][1][2])
                        end
                    end
                end
            end
        end
    end
end
setTimer(updatePlayersGridList, 500, 0)

function onPlayerAction()
    local currentAction = guiGridListGetSelectedItem(playerActionsGrid) + 1
    local players = getGridListItem(playerSearchGrid, 1, true, true)
    local text1 = guiGetText(EMedits[4])
    local text2 = guiGetText(EMedits[5])
    if (EMplayergridcontrols[currentAction][4]) then
        if (EMplayergridcontrols[currentAction][4][1]) then
            if (text1 == "") or (text1 == EMplayergridcontrols[currentAction][4][1][2]) then return end
        end
        if (EMplayergridcontrols[currentAction][4][2]) then
            if (text1 == "") or (text1 == EMplayergridcontrols[currentAction][4][2][2]) then return end
        end
    end
    if (currentAction > 0 and #players > 0) then
        local action = EMplayergridcontrols[currentAction][3]
        local tableOfPlayers = {}
        for k,v in ipairs(players) do
            local player = getPlayerFromName(v)
            if (player) then
                table.insert(tableOfPlayers, player)
            end
        end 
        if (type(action) == "string") then
            triggerServerEvent("GTIevents.SingleAction", root, action, tableOfPlayers, text1, text2)
        elseif (type(action) == "function") then
            action(tableOfPlayers)
        end
    end
end

function isTextInGridList(gridlist, text)
    for i=0, guiGridListGetRowCount(gridlist) do
        local t = guiGridListGetItemData(gridlist, i, 1)
        if (t) then
            if (t == text) then
                return true
            end
        end
    end
    return false
end

mtaGuiSetText = guiSetText
function guiSetText(gui, text)
    isOnEditChangeEnabled = false
    mtaGuiSetText(gui, text)
    isOnEditChangeEnabled = true
end

function handleCursorVisibility()
    for k, v in ipairs(getElementsByType("gui-window", resourceRoot)) do
        if (guiGetVisible(v)) then
            return
        end
    end
    showCursor(false)
end

function getPlayersInEventDimension()
    local dim = 336
    local dimTable = {}
    for i, players in ipairs (getElementsByType("player")) do
        local dimension = getElementDimension(players)
        if dimension == dim then
            table.insert(dimTable, players)
        end
    end
    if (#dimTable == 0) then return false
    else return dimTable 
    end
end

txd = engineLoadTXD("pickups/nitro.txd")
engineImportTXD(txd, 1313)
dff = engineLoadDFF("pickups/nitro.dff", 1313)
engineReplaceModel(dff, 1313)

txd2 = engineLoadTXD("pickups/repair.txd")
engineImportTXD(txd2, 954)
dff2 = engineLoadDFF("pickups/repair.dff", 954)
engineReplaceModel(dff2, 954)

txd3 = engineLoadTXD("pickups/vehiclechange.txd")
engineImportTXD(txd3, 1314)
dff2 = engineLoadDFF("pickups/vehiclechange.dff", 1314)
engineReplaceModel(dff2, 1314)