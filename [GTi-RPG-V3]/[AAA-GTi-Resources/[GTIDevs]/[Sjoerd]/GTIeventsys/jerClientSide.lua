eventCommands = {
"Freeze Event Players",
"Disable Weapons",
"Disable Weapon Fire",
"Create Health Pickup",
"Create Armour Pickup",
"Destroy Health Pickup",
"Destroy Armor Pickup",
"Return Players",
"Freeze Event Vehicles",
"Lock Event Vehicles",
"Enable Vehicle Damage Proof",
"Enable Vehicle Collision",
"Destroy Event Vehicles",
"Fix Event Vehicles",
}

playerControls = {
"Freeze Player",
"Unfreeze Player",
"Kick Player",
"Give Jetpack",
"Remove Jetpack",
"Give Money",
}

---====================================================================================================================---
        eventWindow = guiCreateWindow(110, 92, 575, 393, "Event System", false)
        guiWindowSetSizable(eventWindow, false)
        tabpanel = guiCreateTabPanel(10, 25, 556, 360, false, eventWindow)
        maintab = guiCreateTab("Main", tabpanel)
        label = guiCreateLabel(9, 5, 93, 15, "Create an Event:", false, maintab)
        guiLabelSetColor(label, 0, 255, 255)
        guiCreateLabel(9, 10, 108, 15, "_____________", false, maintab)
         labell = guiCreateLabel(144, 15.5, 24, 16, "Title", false, maintab)
        guiSetFont(labell, "default-bold-small")
        titlefield = guiCreateEdit(107, 31, 113, 25, "", false, maintab)
        guiSetProperty(titlefield, "NormalTextColour", "FFFF0000")
        guiEditSetMaxLength(titlefield, 30)
        labelll = guiCreateLabel(271, 14, 26, 13, "Limit", false, maintab)
        guiSetFont(labelll, "default-bold-small")
        warpEdit = guiCreateEdit(229, 31, 113, 25, "", false, maintab)
        guiSetProperty(warpEdit, "ValidationString", "^[0-9]*$")
        guiSetProperty(warpEdit, "NormalTextColour", "FFFF0000")
        guiEditSetMaxLength(warpEdit, 2)
        freezeCheck = guiCreateCheckBox(350, 24, 125, 15, "Freeze on warping!", true, false, maintab)
        guiSetFont(freezeCheck, "default-bold-small")
        teamEdit = guiCreateEdit(349, 71, 113, 25, "", false, maintab)
        guiSetProperty(teamEdit, "NormalTextColour", "FFFF0000")
        guiEditSetReadOnly(teamEdit, true)
        teamCheck = guiCreateCheckBox(350, 46, 162, 20, "Warps for specific team!", false, false, maintab)
        guiSetFont(teamCheck, "default-bold-small")
        stopEvent = guiCreateButton(244, 61, 88, 30, "Stop Event!", false, maintab)
        guiSetFont(stopEvent, "clear-normal")
        guiSetProperty(stopEvent, "NormalTextColour", "FFAAAAAA")
        startEvent = guiCreateButton(122, 61, 88, 30, "Start Event!", false, maintab)
        guiSetFont(startEvent, "clear-normal")
        guiSetProperty(startEvent, "NormalTextColour", "FFAAAAAA")
        labellll = guiCreateLabel(12, 96, 92, 15, "Send a Message:", false, maintab)
        guiLabelSetColor(labellll, 0, 255, 255)
        wrapUsed = guiCreateLabel(27, 37, 57, 19, "(Used: N/A)", false, maintab)
        guiSetFont(wrapUsed, "default-small")
        guiCreateLabel(10, 101, 92, 15, "______________", false, maintab)
        labelllll = guiCreateLabel(238, 120, 49, 15, "Message", false, maintab)
        guiSetFont(labelllll, "default-bold-small")
        messageField = guiCreateEdit(102, 135, 324, 48, "", false, maintab)
    guiEditSetReadOnly(messageField, true)
        guiSetProperty(messageField, "NormalTextColour", "FF006300")
        guiEditSetMaxLength(messageField, 55)
        sendMessage = guiCreateButton(432, 141, 68, 37, "Send out!", false, maintab)
        guiSetProperty(sendMessage, "NormalTextColour", "FFAAAAAA")
        rootCheck = guiCreateCheckBox(10, 135, 84, 19, "Everyone(root)", false, false, maintab)
        guiSetFont(rootCheck, "default-small")
        participantsCheck = guiCreateCheckBox(10, 164, 68, 19, "Participants", false, false, maintab)
        guiSetFont(participantsCheck, "default-small")
        diemlabel = guiCreateLabel(11, 199, 81, 15, "Set Dimension: (Event dim: 802)", false, maintab)
        guiLabelSetColor(diemlabel, 0, 255, 255)
        guiCreateLabel(11, 204, 81, 15, "______________", false, maintab)
        ralabel = guiCreateLabel(131, 211, 63, 17, "Dimens. ID", false, maintab)
        guiSetFont(ralabel, "default-bold-small")
        dimensField = guiCreateEdit(102, 228, 120, 28, "", false, maintab)
        guiSetProperty(dimensField, "NormalTextColour", "FF000CB7")
        guiEditSetMaxLength(dimensField, 5)
        setDimens = guiCreateButton(121, 261, 81, 37, "Set!", false, maintab)
        guiSetProperty(setDimens, "NormalTextColour", "FFAAAAAA")
        eventClose = guiCreateLabel(510, 310, 40, 15, "Close!", false, maintab)
        guiSetFont(eventClose, "clear-normal")
        commandstab = guiCreateTab("Commands", tabpanel)
        dd = guiCreateLabel(10, 5, 145, 15, "Create a Vehicle Spawner:", false, commandstab)
        guiLabelSetColor(dd, 0, 255, 255)
        eventVehCombo = guiCreateComboBox(10, 30, 145, 141, "", false, commandstab)
        guiSetFont(eventVehCombo, "clear-normal")
        guiSetProperty(eventVehCombo, "NormalEditTextColour", "FF00FF00")
        guiComboBoxAddItem(eventVehCombo, "")
        guiCreateLabel(10, 10, 145, 15, "______________________", false, commandstab)
        eventVehButton = guiCreateButton(10, 58, 145, 35, "Create Vehicle Marker", false, commandstab)
        guiSetProperty(eventVehButton, "NormalTextColour", "FFAAAAAA")
        eventDestButton = guiCreateButton(10, 99, 145, 35, "Destroy Vehicle Marker", false, commandstab)
        guiSetProperty(eventDestButton, "NormalTextColour", "FFAAAAAA")
        bliplabel = guiCreateLabel(10, 140, 72, 15, "Create a Blip:", false, commandstab)
        guiLabelSetColor(bliplabel, 0, 255, 255)
        guiCreateLabel(10, 145, 72, 16, "____________", false, commandstab)
        posX = guiCreateEdit(20, 161, 135, 30, "", false, commandstab)
        guiEditSetReadOnly(posX, true)
        posY = guiCreateEdit(20, 191, 135, 30, "", false, commandstab)
        guiEditSetReadOnly(posY, true)
        posZ = guiCreateEdit(20, 221, 135, 30, "", false, commandstab)
        guiEditSetReadOnly(posZ, true)
        xlabel = guiCreateLabel(5, 171, 15, 18, "(X):", false, commandstab)
        guiSetFont(xlabel, "default-small")
        ylabel = guiCreateLabel(5, 199, 17, 20, "(Y):", false, commandstab)
        guiSetFont(ylabel, "default-small")
        zlabel = guiCreateLabel(5, 229, 15, 17, "(Z):", false, commandstab)
        guiSetFont(zlabel, "default-small")
        coordsCheck = guiCreateCheckBox(2, 281, 126, 23, "Create using Coordinates", false, false, commandstab)
        guiSetFont(coordsCheck, "default-small")
        currentposCheck = guiCreateCheckBox(2, 304, 124, 21, "Create using current pos", false, false, commandstab)
        guiSetFont(currentposCheck, "default-small")
        blipID = guiCreateEdit(20, 252, 106, 27, "", false, commandstab)
        guiEditSetMaxLength(blipID, 2)
    guiEditSetReadOnly(blipID, true)
        idLabel = guiCreateLabel(5, 261, 17, 18, "ID:", false, commandstab)
        guiSetFont(idLabel, "default-small")
        guiLabelSetColor(idLabel, 255, 0, 0)
        createBlipbtn = guiCreateButton(128, 255, 98, 34, "Create Blip!", false, commandstab)
        guiSetProperty(createBlipbtn, "NormalTextColour", "FFAAAAAA")
        removeBlipbtn = guiCreateButton(128, 294, 98, 34, "Remove Blip!", false, commandstab)
        guiSetProperty(removeBlipbtn, "NormalTextColour", "FFAAAAAA")
        accclabel = guiCreateLabel(232, 5, 138, 17, "Take an action on Event:", false, commandstab)
        guiLabelSetColor(accclabel, 0, 255, 255)
        guiCreateLabel(232, 7, 138, 15, "______________________________", false, commandstab)
        --infobtn = guiCreateLabel(434, 318, 122, 14, "Click here to get information!", false, commandstab)
        --guiSetFont(infobtn, "default-small")
        eventMainGrid = guiCreateGridList(232, 24, 196, 302, false, commandstab)
    guiGridListSetSortingEnabled(eventMainGrid, false)
        eventMainColumn = guiGridListAddColumn(eventMainGrid, "Commands:", 0.9)
        eventCommand = guiCreateButton(430, 108, 122, 86, "No action was selected!", false, commandstab)
        guiSetProperty(eventCommand, "NormalTextColour", "FFAAAAAA")
        playerstab = guiCreateTab("Participants", tabpanel)
        eventPlayerGrid = guiCreateGridList(10, 29, 208, 268, false, playerstab)
    guiGridListSetSortingEnabled(eventPlayerGrid, false)
        eventPlayerColumn = guiGridListAddColumn(eventPlayerGrid, "Available Players:", 0.9)
        eventPlayerSearch = guiCreateEdit(34, 302, 161, 24, "Search...", false, playerstab)
        guiEditSetMaxLength(eventPlayerSearch, 22)
        aplabel = guiCreateLabel(10, 6, 92, 15, "Available Players:", false, playerstab)
        guiLabelSetColor(aplabel, 0, 255, 255)
        guiCreateLabel(10, 10, 92, 15, "_______________", false, playerstab)
        acctlabel = guiCreateLabel(254, 7, 148, 17, "Take an action on a Player:", false, playerstab)
        guiLabelSetColor(acctlabel, 0, 255, 255)
        guiCreateLabel(254, 10, 148, 14, "_______________________", false, playerstab)
        eventPlayerConGrid = guiCreateGridList(253, 29, 175, 265, false, playerstab)
    guiGridListSetSortingEnabled(eventPlayerConGrid, false)
        eventPlayerCont = guiGridListAddColumn(eventPlayerConGrid, "Available Actions:", 0.9)
        monylabel = guiCreateLabel(433, 143, 109, 15, "Amount of Money", false, playerstab)
        guiSetFont(monylabel, "clear-normal")
        moneyField = guiCreateEdit(430, 158, 122, 35, "", false, playerstab)
        guiSetProperty(moneyField, "NormalTextColour", "FFB100B1")
        guiEditSetMaxLength(moneyField, 6)
        eventPlayerCommand = guiCreateButton(268, 300, 141, 26, "No action was selected!", false, playerstab)
        guiSetProperty(eventPlayerCommand, "NormalTextColour", "FFAAAAAA")
    guiSetVisible(eventWindow, false)


    
local added = false

addEvent("openEventPanel",true)
function openEventPanel(thePlayer)  
    if (guiGetVisible(eventWindow)) then  
        guiSetVisible(eventWindow, false)
        showCursor(false)
        guiSetText(titlefield, "")
        guiSetText(warpEdit, "")
        guiSetText(dimensField, "")
        guiSetText(blipID, "")
        guiSetText(posX, "")
        guiSetText(posY, "")
        guiSetText(posZ, "")
        guiSetText(eventPlayerSearch, "Search...")
        guiSetText(moneyField, "")
    else
        guiSetVisible(eventWindow, true)
        showCursor(true)
        guiSetEnabled(startEvent, false)
        guiSetEnabled(sendMessage, false)
        guiSetEnabled(setDimens, false)
        --guiSetEnabled(eventVehButton, false)
        --guiSetEnabled(createBlipbtn, false)
        --guiSetEnabled(eventPlayerCommand, false)
        --guiSetEnabled(eventCommand, false)
        local vehicleNames = {}
        for i = 400, 609 do
            if ( getVehicleNameFromModel ( i ) ~= "" ) then
                table.insert( vehicleNames, { model = i, name = getVehicleNameFromModel ( i ) } )
            end
        end
        
        table.sort( vehicleNames, function(a, b) return a.name < b.name end )
        for _,info in ipairs(vehicleNames) do
            guiComboBoxAddItem( eventVehCombo, info.name )
        end
        if (added == true) then return end
        for index, eventCommands in ipairs ( eventCommands ) do 
            guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, eventCommands, false, false )
            added = true
        end
        for index, playerControls in ipairs ( playerControls ) do 
            guiGridListSetItemText ( eventPlayerConGrid, guiGridListAddRow ( eventPlayerConGrid ), eventPlayerCont, playerControls, false, false )
        end
    end
end
addEventHandler( "openEventPanel", root, openEventPanel )

--[[function addStuff()
    
end
addEventHandler("onClientPlayerJoin", resourceRoot, addStuff)]]--

function disappeardaPanel()
    guiSetVisible(eventWindow, false)
    showCursor(false)
    guiSetText(titlefield, "")
    guiSetText(warpEdit, "")
    guiSetText(dimensField, "")
    guiSetText(blipID, "")
    guiSetText(posX, "")
    guiSetText(posY, "")
    guiSetText(posZ, "")
    guiSetText(eventPlayerSearch, "Search...")
    guiSetText(moneyField, "")
end
addEventHandler("onClientGUIClick", eventClose, disappeardaPanel, false)

--[[addEventHandler("onClientGUIClick", root,
function ()
    if (source == infobtn) then
        guiSetVisible(GUIEditor.window[1], true)
        showCursor(true)
        guiBringToFront(GUIEditor.window[1])
        addEventHandler("onClientRender", root, drawDxText)
        guiSetAlpha(eventWindow, 0.2)
    elseif (source == iconwindowclosebtn) then
        guiSetVisible(GUIEditor.window[1], false)
        removeEventHandler("onClientRender", root, drawDxText)
        guiSetAlpha(eventWindow, 1)
    end
end
)]]--
---================================================ LOADING EVENT PLAYERS ====================================================================---
local rows = {}

addEvent("loadEventPlayers",true)
function loadEventPlayers( eventPlayers )
    eventPlr = getPlayerName ( eventPlayers )
    rows[eventPlayers] = guiGridListAddRow ( eventPlayerGrid )
    guiGridListSetItemText ( eventPlayerGrid, rows[eventPlayers], eventPlayerColumn, eventPlr, false, false )
end
addEventHandler( "loadEventPlayers", resourceRoot, loadEventPlayers )

--[[local cleared = false
function refrehEventPlayers(eventPlayers)
    if (not cleared) then
        guiGridListClear(eventPlayerGrid)
        cleared = true
        setTimer(disableClear, 1500, 1)
    end
    eventPlr = getPlayerName ( eventPlayers )
    
    setTimer ( function(eventPlr)
    local row = guiGridListAddRow(eventPlayerGrid)
    guiGridListSetItemText(eventPlayerGrid, row, eventPlayerColumn, eventPlr, false, false)
    end, 50, 1, eventPlr )
end
addEvent("GTIeventsys.refrehEventPlayers", true)
addEventHandler("GTIeventsys.refrehEventPlayers", root, refrehEventPlayers)]]--

function disableClear()
    cleared = false
end
    
addEvent("removeEventPlayers",true)
function removeEventPlayers( eventPlayer )
    outputDebugString(guiGridListGetItemText(eventPlayerGrid, rows[eventPlayer], 1))
    guiGridListRemoveRow ( eventPlayerGrid, rows[eventPlayer])
    rows[eventPlayer] = nil
end
addEventHandler( "removeEventPlayers", resourceRoot, removeEventPlayers )
---================================================ EVENT ACTIONS ====================================================================---   

function eventAction()
    local theAction = guiGridListGetItemText(eventMainGrid, guiGridListGetSelectedItem(eventMainGrid), 1)
    if ( theAction == "Freeze Event Players" ) then
        triggerServerEvent("eventFeezePlayers",localPlayer)
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Unfreeze Event Players", false, false )
    elseif ( theAction == "Unfreeze Event Players" ) then
        triggerServerEvent("eventUnfreezePlayers",localPlayer)
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Freeze Event Players", false, false )
    elseif ( theAction == "Enable Weapons") then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Disable Weapons", false, false )
        enabledWep()
    elseif ( theAction == "Disable Weapons" ) then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Enable Weapons", false, false )
        disableWep()
    elseif ( theAction == "Disable Weapon Fire" ) then 
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Enable Weapon Fire", false, false )
        triggerServerEvent("GTIeventsys.toggleShoot",localPlayer, true)
    elseif ( theAction == "Enable Weapon Fire" ) then 
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Disable Weapon Fire", false, false )
        triggerServerEvent("GTIeventsys.toggleShoot",localPlayer, false)       
    elseif ( theAction == "Freeze Event Vehicles" ) then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Unfreeze Event Vehicles", false, false )
        triggerServerEvent("eventFreezeVehicle",localPlayer)
    elseif ( theAction == "Unfreeze Event Vehicles" ) then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Freeze Event Vehicles", false, false )
        triggerServerEvent("eventUnfreezeVehicles",localPlayer)
    elseif ( theAction == "Lock Event Vehicles" ) then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Unlock Event Vehicles", false, false )
        triggerServerEvent("eventLockVehicles",localPlayer)
    elseif ( theAction == "Unlock Event Vehicles") then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Lock Event Vehicles", false, false )
        triggerServerEvent("eventUnlockVehicles",localPlayer)
    elseif ( theAction == "Enable Vehicle Damage Proof" ) then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Disable Vehicle Damage proof", false, false )
        triggerServerEvent("eventEnableDamageProof",localPlayer)
    elseif ( theAction == "Disable Vehicle Damage proof" ) then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Enable Vehicle Damage Proof", false, false )
        triggerServerEvent("eventDisableDamageProof",localPlayer)
    elseif ( theAction == "Fix Event Vehicles" ) then
        triggerServerEvent("eventFixVehicles",localPlayer)
    elseif ( theAction == "Enable Vehicle Collision") then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Disable Vehicle Collision", false, false )
        triggerServerEvent("eventEnableCollision",localPlayer)
    elseif ( theAction == "Disable Vehicle Collision") then
        guiGridListRemoveRow ( eventMainGrid, guiGridListGetSelectedItem (eventMainGrid, 1) )
        guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Enable Vehicle Collision", false, false )
        triggerServerEvent("eventDisableCollision",localPlayer)
    elseif ( theAction == "Destroy Event Vehicles" ) then
        triggerServerEvent("destroyVehicles",localPlayer)
    elseif ( theAction == "Create Health Pickup" ) then
        triggerServerEvent("createHealth",localPlayer)
    elseif ( theAction == "Create Armour Pickup" ) then
        triggerServerEvent("createArmourPickup",localPlayer)
    elseif ( theAction == "Destroy Health Pickup" ) then
        triggerServerEvent("destroyHealth",localPlayer)
    elseif ( theAction == "Destroy Armor Pickup" ) then
        triggerServerEvent("destroyArmor",localPlayer)    
    elseif ( theAction =="Return Players" ) then
        triggerServerEvent("returnPlayers",localPlayer)
    end
end
addEventHandler("onClientGUIClick", eventCommand, eventAction, false)

function playerAction()
    local thePlrAction = guiGridListGetItemText( eventPlayerConGrid, guiGridListGetSelectedItem(eventPlayerConGrid), 1 )
    local eventSelectedPlr1 = guiGridListGetItemText(eventPlayerGrid, guiGridListGetSelectedItem(eventPlayerGrid), 1)
    local eventSelectedPlr = getPlayerFromName( eventSelectedPlr1 )
    amountOfMoney = guiGetText( moneyField )
    if ( thePlrAction == "Freeze Player" ) then 
        triggerServerEvent("eventFeezeevPlayer", localPlayer, eventSelectedPlr)
    elseif ( thePlrAction == "Unfreeze Player" ) then
        triggerServerEvent("eventUnfreezeevPlayer", localPlayer, eventSelectedPlr)
    elseif ( thePlrAction == "Kick Player" ) then 
        triggerServerEvent("eventKickPlayer", localPlayer, eventSelectedPlr)
    elseif ( thePlrAction == "Give Jetpack" ) then   
        triggerServerEvent("eventGiveJetpack", localPlayer, eventSelectedPlr)
    elseif ( thePlrAction == "Remove Jetpack" ) then
        triggerServerEvent("eventRemoveJetpack", localPlayer, eventSelectedPlr)
    elseif ( thePlrAction == "Give Money" ) then
        triggerServerEvent("eventGiveCash", localPlayer, eventSelectedPlr, amountOfMoney)
    end
end
addEventHandler("onClientGUIClick", eventPlayerCommand, playerAction, false)
---============================================== EVENT WARP ======================================================================---

function startEventWarp()
    local warpLimit = guiGetText( warpEdit )
    local freezeOnWarp = guiCheckBoxGetSelected( freezeCheck )
    local teamEvent = guiCheckBoxGetSelected( teamCheck )
    local eventTitle = guiGetText( titlefield )
    local team = guiGetText( teamEdit )
    guiSetText( wrapUsed, "(Used: 0/"..warpLimit..")" )
    if (warpLimit ~= "" ) then
        triggerServerEvent("createEvent", localPlayer, warpLimit, freezeOnWarp, teamEvent, eventTitle, team)
    end 
end
addEventHandler("onClientGUIClick", startEvent, startEventWarp, false)

function stopEventWarp()
    guiSetText( wrapUsed, "(Used: N/A)" )
    triggerServerEvent("stopEvent", localPlayer)
end
addEventHandler("onClientGUIClick", stopEvent, stopEventWarp, false)

addEvent( "eventWarpUsed", true)
function eventWarpUsed( plrWraped, warpLimit )
    guiSetText( wrapUsed, "(Used: "..plrWraped.."/"..warpLimit..")" )
end
addEventHandler("eventWarpUsed", root, eventWarpUsed)

addEvent("onFreezeOnWarp", true)
function onFreezeOnWarp()
    guiGridListRemoveRow ( eventMainGrid, "Freeze Event Players" )
    guiGridListSetItemText ( eventMainGrid, guiGridListAddRow ( eventMainGrid ), eventMainColumn, "Unfreeze Event Players", false, false )
end
addEventHandler("onFreezeOnWarp", root, onFreezeOnWarp)
---================================================== EVENT PLAYERS WEAPON SWITCHING ==================================================================---

function weaponSwitch()
    triggerServerEvent("weaponSwitch",localPlayer)
end

function disableWep()
    triggerServerEvent("weaponSwitch",localPlayer)
    addEventHandler("onClientPlayerWeaponSwitch", root, weaponSwitch)
end

function enabledWep()
    removeEventHandler("onClientPlayerWeaponSwitch", root, weaponSwitch)
end
---================================================  EVENT VEHICLES ====================================================================---

function createVeh()
    eventVeh = guiComboBoxGetItemText( eventVehCombo, guiComboBoxGetSelected( eventVehCombo ))
    triggerServerEvent("createVeh", localPlayer, eventVeh)
end
addEventHandler("onClientGUIClick", eventVehButton, createVeh, false)

function destroyVehMarker()
    triggerServerEvent("destroyVehicleMarkers",localPlayer)
end
addEventHandler("onClientGUIClick", eventDestButton, destroyVehMarker, false)
---=================================================  EVENT VEHICLE DAMAGE ===================================================================---

addEvent( "eventEnableDamageProof", true)
function eventEnableDamageProof(eventVeh)
    setVehicleDamageProof(eventVeh, true)
end
addEventHandler("eventEnableDamageProof", root, eventEnableDamageProof)

addEvent( "eventDisableDamageProof", true)
function eventDisableDamageProof(eventVeh)
    setVehicleDamageProof(eventVeh, false)
end
addEventHandler("eventDisableDamageProof", root, eventDisableDamageProof)

---=================================================== EVENT VEHICLE COLISION=================================================================---

addEvent("enableCollisions", true)
function enableCollisions(eventVeh)
    for i, veh in ipairs(getElementsByType("vehicle")) do
        setElementCollidableWith( veh, eventVeh, false)     
    end
end
addEventHandler("enableCollisions", root, enableCollisions)

addEvent("disableCollisions", true)
function disableCollisions(eventVeh)
    for i, veh in ipairs(getElementsByType("vehicle")) do
        setElementCollidableWith(veh, eventVeh, true)
    end
end
addEventHandler("disableCollisions", root, disableCollisions)

function Exar()
    local theAction = guiGridListGetItemText(eventMainGrid, guiGridListGetSelectedItem(eventMainGrid), 1)  
    guiSetText(eventCommand, theAction )
end
addEventHandler("onClientGUIClick", eventMainGrid, Exar, false)

function Exarr()
    local thePlrAction = guiGridListGetItemText(eventPlayerConGrid, guiGridListGetSelectedItem(eventPlayerConGrid), 1)
    guiSetText( eventPlayerCommand, thePlrAction )
end
addEventHandler("onClientGUIClick", eventPlayerConGrid, Exarr, false)

addEventHandler( "onClientMouseEnter", resourceRoot,
    function()
        if (source == eventClose) then
            guiLabelSetColor( source, 255, 0, 0)
        elseif (source == infobtn) then
            guiLabelSetColor( source, 255, 128, 0)
        elseif (source == iconwindowclosebtn) then
            guiLabelSetColor( source, 255, 128, 0)
        end
    end
)

addEventHandler( "onClientMouseLeave", resourceRoot,
    function()
        if (source == eventClose) then
            guiLabelSetColor( source, 255, 255, 255)
        elseif (source == infobtn) then
            guiLabelSetColor( source, 255, 255, 255)
        elseif (source == iconwindowclosebtn) then
            guiLabelSetColor( source, 255, 255, 255)
        end
    end
)

function restricitng ()
    local titleText = guiGetText(titlefield)
    local limitText = guiGetText(warpEdit)
    local dimensText = guiGetText(dimensField)
    local messageText = guiGetText(messageField)
    local posxText = guiGetText(posX)
    local posyText = guiGetText(posY)
    local poszText = guiGetText(posZ)
    local blipText = guiGetText(blipID)
    if (string.len(titleText) == 0) or (string.len(limitText) == 0) then
        guiSetEnabled(startEvent, false)
    else
        guiSetEnabled(startEvent, true)
    end
    if (string.len(dimensText) == 0) then
        guiSetEnabled(setDimens, false)
    else
        guiSetEnabled(setDimens, true)
    end
    if (string.len(messageText) == 0) then
        guiSetEnabled(sendMessage, false)
    else
        guiSetEnabled(sendMessage, true)
    end
end
addEventHandler("onClientGUIChanged", resourceRoot, restricitng)

addEventHandler( "onClientGUIClick", resourceRoot,
function ()
    if ( source == rootCheck) then
        if guiCheckBoxGetSelected(source) then
            guiCheckBoxSetSelected(participantsCheck, false)
        end
    elseif (source == participantsCheck) then
        if guiCheckBoxGetSelected(source) then
            guiCheckBoxSetSelected(rootCheck, false)
        end
    elseif (source == coordsCheck) then
        if guiCheckBoxGetSelected(source) then
            guiCheckBoxSetSelected(currentposCheck, false)
        end
    elseif (source == currentposCheck) then
        if guiCheckBoxGetSelected(source) then
            guiCheckBoxSetSelected(coordsCheck, false)
        end
    end
end
)

addEventHandler( "onClientGUIClick", resourceRoot,
function ()
    if ( source == coordsCheck) then
        if guiCheckBoxGetSelected(source) then
            guiEditSetReadOnly(blipID, false)
            guiEditSetReadOnly(posZ, false)
            guiEditSetReadOnly(posY, false)
            guiEditSetReadOnly(posX, false)
        else
            guiEditSetReadOnly(blipID, true)
            guiEditSetReadOnly(posZ, true)
            guiEditSetReadOnly(posY, true)
            guiEditSetReadOnly(posX, true)
            guiSetText(blipID, "")
            guiSetText(posZ, "")
            guiSetText(posY, "")
            guiSetText(posX, "")
        end
    elseif (source == currentposCheck) then
        if guiCheckBoxGetSelected(source) then
            guiEditSetReadOnly(blipID, false)
            guiEditSetReadOnly(posZ, true)
            guiEditSetReadOnly(posY, true)
            guiEditSetReadOnly(posX, true)
        else
            guiEditSetReadOnly(blipID, true)
            guiSetText(blipID, "")
            guiSetText(posZ, "")
            guiSetText(posY, "")
            guiSetText(posX, "")
        end
    elseif (source == rootCheck) then
        if guiCheckBoxGetSelected(source) then
            guiEditSetReadOnly(messageField, false)
        else
            guiEditSetReadOnly(messageField, true)
            guiSetText(messageField, "")
        end
    elseif (source == teamCheck) then
        if guiCheckBoxGetSelected(source) then
            guiEditSetReadOnly(teamEdit, false)
        else
            guiEditSetReadOnly(teamEdit, true)
            guiSetText(teamEdit, "")
        end
    elseif (source == participantsCheck) then
        if guiCheckBoxGetSelected(source) then
            guiEditSetReadOnly(messageField, false)
        else
            guiEditSetReadOnly(messageField, true)
            guiSetText(messageField, "")
        end
    end
end
)

function setDimension ()
    dimensID = guiGetText(dimensField)
    triggerServerEvent("setTheDamnDimension", localPlayer, dimensID)
end
addEventHandler("onClientGUIClick", setDimens, setDimension, false)

function createDaBlip ()
    IDofBlip = guiGetText(blipID)
    triggerServerEvent("createTheDamnBlip", localPlayer, IDofBlip)
end
addEventHandler("onClientGUIClick", createBlipbtn, createDaBlip, false)

function deleteDaBlip ()
    IDofBlip = guiGetText(blipID)
    triggerServerEvent("deleteTheDamnBlip", localPlayer, IDofBlip)
end
addEventHandler("onClientGUIClick", removeBlipbtn, deleteDaBlip, false)

addEventHandler( "onClientGUIClick", sendMessage,
function ()
    TheMessage = guiGetText(messageField)
    if (source == sendMessage) then
        if ( guiCheckBoxGetSelected(rootCheck) ) then
            triggerServerEvent("sendRootMessage", localPlayer, TheMessage)
        elseif ( guiCheckBoxGetSelected(participantsCheck) ) then
            triggerServerEvent("sendPartMessage", localPlayer, TheMessage)
        end
    end
end
)

function drawDxText ()
    dxDrawLine(314, 77, 314, 560, tocolor(255, 255, 255, 255), 1, true)
        dxDrawLine(394, 77, 394, 560, tocolor(255, 255, 255, 255), 1, true)
        dxDrawLine(474, 77, 474, 560, tocolor(255, 255, 255, 255), 1, true)
        dxDrawLine(559, 77, 559, 560, tocolor(255, 255, 255, 255), 1, true)
end

local Messages = { }
showTime = 2000
shSp = 10

function sMessage( text, r, g, b )
    local x, y, z = getPedBonePosition( localPlayer, 4 )
    local sx, sy = getScreenFromWorldPosition( x, y, z+0.5 )
    local sM = { text = text, r = r, g = g, b = b, a = 0, 
        visibleTick = false, fadingIn = true, fadingOut = false, startY = sy }
    table.insert( Messages, sM )
end
addEvent( "sendMessage", true )
addEventHandler( "sendMessage", root, sMessage)

local resX,resY = guiGetScreenSize()
function showM()
    local offsetY = dxGetFontHeight( 1.5, "pricedown" ) * #Messages
    for k,v in pairs( Messages ) do
        if (getElementDimension(localPlayer) == 802) then
            if ( v.fadingIn ) then
                if ( v.a < 255 )then
                    if ( v.a+shSp > 255 ) then
                        v.a = 255
                    else
                        v.a = v.a+shSp
                    end
                else 
                    v.fadingIn = false
                    v.visibleTick = getTickCount()
                end
            end
            if ( not v.fadingOut ) then
                if ( not v.fadingIn and ( getTickCount() - v.visibleTick ) >= showTime ) then
                    v.fadingOut = true
                end
            else
                if ( v.a-shSp < 0 ) then
                    v.a = 0
                    v.startY = 0
                else
                    v.a = v.a-shSp
                    v.startY = (v.startY or 0) - shSp
                end
            end
            if ( v.fadingOut and v.a <= 0 ) then
                table.remove( Messages, k )
                return
            end
            local Width = dxGetTextWidth( v.text, 1.5, "pricedown" )
            if (v.startY) then
                dxDrawText( v.text, resX/2-( Width/2 ), v.startY-( offsetY-k*dxGetFontHeight( 1.5, "pricedown" ) ), resX, resY, tocolor( 0, 0, 0, v.a ), 1.5, "pricedown", "left", "top", false, true )
                dxDrawText( v.text, resX/2-( Width/2 )-3, v.startY-( offsetY-k*dxGetFontHeight( 1.5, "pricedown" ) )+2, resX, resY, tocolor( v.r, v.g, v.b, v.a ), 1.5, "pricedown", "left", "top", false, true )
            end
        end    
    end
end
addEventHandler( "onClientRender", root, showM )

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



   
