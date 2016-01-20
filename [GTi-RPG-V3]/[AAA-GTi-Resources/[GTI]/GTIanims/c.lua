--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~
-- Resource: GTIanims/c.lua ~
-- Description: Ped Animation ~
-- Data: #Animations
--<--------------------------------->--

GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}
Timer = {}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(576, 199, 343, 330, "GTI Animations", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetVisible (GUIEditor.window[1], false)
        GUIEditor.gridlist[1] = guiCreateGridList(9, 22, 156, 275, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "Category", 0.9)
		guiGridListSetSortingEnabled(GUIEditor.gridlist[1],false)
        GUIEditor.gridlist[2] = guiCreateGridList(175, 22, 156, 275, false, GUIEditor.window[1])
        animsC = guiGridListAddColumn(GUIEditor.gridlist[2], "Animations", 0.9)
		guiGridListSetSortingEnabled(GUIEditor.gridlist[2],false)
        GUIEditor.button[1] = guiCreateButton(9, 301, 93, 19, "Start", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[2] = guiCreateButton(125, 301, 93, 19, "Stop", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[3] = guiCreateButton(238, 301, 93, 19, "Close", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFAAAAAA")  
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(GUIEditor.window[1], false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetPosition(GUIEditor.window[1], x, y, false) 
    end
)

antiSpam = {}

addEventHandler ( "onClientGUIClick", root, function ( )
    if ( source == GUIEditor.gridlist[1] ) then
        if ( guiGridListGetSelectedItem ( source ) ~= -1 ) then
            if not isTimer(antiSpam[source]) then
                antiSpam[source] = setTimer(function(source) antiSpam[source] = nil end, 700, 1, source)
                guiGridListClear ( GUIEditor.gridlist[2] )
                local groupname = guiGridListGetItemText ( source, guiGridListGetSelectedItem ( source ), 1 )
                getAnims(groupname)
            end
        end
        
    elseif ( source == GUIEditor.button[1] ) then
        
        if ( guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ) ~= -1 ) then
            if ( guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ) ~= -1 ) then
                local anim = guiGridListGetItemData ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
                setAnimation(anim[1], anim[2])
                bindKey("jump","down",stopAnim)
            end
        end
    
    elseif ( source == GUIEditor.button[2] ) then
        stopAnim()
         elseif ( source == GUIEditor.button[3] ) then
            guiSetVisible ( GUIEditor.window[1], false )
            showCursor ( false )
    end
end )
function stopAnim ()
    local jAnims = getElementData(localPlayer, "GTIanims.setAnim")
    if ( jAnims == true ) or not getPedAnimation(localPlayer) then return end
    triggerServerEvent ( "GTIanims.onSetAnim", localPlayer, false )
    unbindKey("jump","down",stopAnim)
end
addCommandHandler("stopanim", stopAnim)
addEventHandler ( "onClientGUIDoubleClick", root, function ( )
    if ( source == GUIEditor.gridlist[2] ) then
        if ( guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ) ~= -1 ) then
            local anim = guiGridListGetItemData ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
            setAnimation(anim[1], anim[2])
            bindKey("jump","down",stopAnim)
        end
    end
end)
function setAnimation(block,anim)
    local arrested = getElementData(localPlayer, "isPlayerArrested")
    if ( getElementData(localPlayer, "GTIanims.setAnim") == false ) then 
    if (arrested == true) then 
        exports.GTIhud:dm("You can't use an animation while arrested!", 255, 0, 0)
        return 
    end
    if isPedInVehicle ( localPlayer ) then
        exports.GTIhud:dm("You can NOT use the animations while in vehicle.", 255, 0, 0)
        return 
    end
    triggerServerEvent ( "GTIanims.onSetAnim", localPlayer, true, block, anim )
end
end
function setCat( groupName )
    local row = guiGridListAddRow ( GUIEditor.gridlist[1] )
    guiGridListSetItemText ( GUIEditor.gridlist[1], row, 1, groupName, false, false )
end

function setAnim( block,anim,name )
    if isPedInVehicle(localPlayer) then return end
    local row = guiGridListAddRow ( GUIEditor.gridlist[2] )
    guiGridListSetItemText ( GUIEditor.gridlist[2], row, 1, name, false, false )
    guiGridListSetItemData( GUIEditor.gridlist[2], row, 1, {block,anim})
end 

function showGui ()
    guiGridListClear ( GUIEditor.gridlist[1] )
    guiGridListClear ( GUIEditor.gridlist[2] )
        local status = not guiGetVisible(GUIEditor.window[1])
        guiSetVisible(GUIEditor.window[1], status)
        showCursor(status)
        getCategories()
end
addCommandHandler("animations", showGui)
addEvent ("GTIuserpanel_animations", true )
addEventHandler ("GTIuserpanel_animations", root, showGui )

function setJobAnimation (ped, block, anim, time, loop, update, inter, freeze)
        if ( ped and block ) then
            if isTimer(Timer[ped]) then killTimer(Timer[ped]) end
            setElementData(ped, "GTIanims.setAnim", true)
            setPedAnimation(ped, block, anim, time, loop, update, inter, freeze)
            if not (loop or freeze) and not ( anim == "crry_prtial" ) then
                Timer[ped] = setTimer(function(ped)
                setElementData(ped, "GTIanims.setAnim", false)
                end,time,1,ped)
            elseif loop or freeze or ( anim == "crry_prtial" ) then
                Timer[ped] = setTimer(function(ped)
                setElementData(ped, "GTIanims.setAnim", false)
                end,120000,1,ped) --as we dont know the time then...2mins
            end

    else
        if isTimer(Timer[ped]) then killTimer(Timer[ped]) end
        setPedAnimation(ped, false)
        setElementData(ped, "GTIanims.setAnim", false)
        end
    end