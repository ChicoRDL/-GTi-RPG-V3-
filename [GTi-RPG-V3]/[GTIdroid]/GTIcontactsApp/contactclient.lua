GUIEditor = {
    gridlist = {},
    staticimage = {},
    label = {},
    window = {},
    edit = {},
    radiobutton = {}
}

function renderAppGUI()
    if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    GTIApp = exports.GTIdroid:getGTIDroidAppButton("People")
    addEventHandler("onClientGUIClick", GTIApp, showAppGUI, false)
        local font_0 = guiCreateFont("images/font1.ttf")
    --add gui
        GUIEditor.window[2] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
        GUIEditor.staticimage[3] = guiCreateStaticImage(0, 0, 270, 40, "images/bckgrnd3.png", false, GUIEditor.window[2])
        GUIEditor.edit[1] = guiCreateEdit(22, 8, 225, 25, "", false, GUIEditor.staticimage[3])    
        GUIEditor.gridlist[1] = guiCreateGridList(0, 41, 271, 339, false, GUIEditor.window[2])    
        column = guiGridListAddColumn( GUIEditor.gridlist[1] , "Players", 0.85 )
        GUIEditor.staticimage[1] = guiCreateStaticImage(0, 380, 270, 50, "images/white.png", false, GUIEditor.window[2])
        GUIEditor.label[1] = guiCreateLabel(120, 17, 40, 16, "Add", false, GUIEditor.staticimage[1])
        guiSetAlpha(GUIEditor.staticimage[1], 0.46)
        guiSetFont(GUIEditor.label[1], font_0)
        guiLabelSetColor(GUIEditor.label[1], 0, 0, 0)
        guiSetAlpha(GUIEditor.gridlist[1], 0.9)
        --guiSetVisible(GUIEditor.label[1], false)
    --contacts
        GUIEditor.window[1] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
        
        GUIEditor.staticimage[6] = guiCreateButton(0, 0, 80, 30, "Requests", false, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(0, 14, 266, 15, "", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "right", false)
        GUIEditor.label[4] = guiCreateLabel(135, 396, 15, 30, "|  |  |  |", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "left", true)
        GUIEditor.label[5] = guiCreateLabel(135, 407, 15, 15, "|  |  |  |", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "left", true)
        GUIEditor.radiobutton[1] = guiCreateRadioButton(8, 371, 80, 15, "Friend", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.radiobutton[1], "NormalTextColour", "FF19FF19")
        GUIEditor.radiobutton[2] = guiCreateRadioButton(182, 371, 80, 15, "Blocked", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.radiobutton[2], "NormalTextColour", "FFFF1919")
        GUIEditor.radiobutton[3] = guiCreateRadioButton(99, 371, 80, 15, "Neutral", false, GUIEditor.window[1])
        GUIEditor.gridlist[2] = guiCreateGridList(0, 32, 271, 334, false, GUIEditor.window[1])
        name = guiGridListAddColumn(GUIEditor.gridlist[2], "Contact Name", 0.5)
        lastactive = guiGridListAddColumn(GUIEditor.gridlist[2], "Last Active", 0.35)

        GUIEditor.staticimage[2] = guiCreateStaticImage(0, 392, 137, 36, ":GTIdroid/wallpapers/bkgr_white.png", false, GUIEditor.window[1])
        guiSetAlpha(GUIEditor.staticimage[2], 0.46)

        GUIEditor.label[6] = guiCreateLabel(0, 0, 137, 35, "Add Contact", false, GUIEditor.staticimage[2])
        guiSetFont(GUIEditor.label[6], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[6], 0, 0, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")

        GUIEditor.staticimage[3] = guiCreateStaticImage(137, 392, 133, 36, ":GTIdroid/wallpapers/bkgr_white.png", false, GUIEditor.window[1])
        guiSetAlpha(GUIEditor.staticimage[3], 0.46)

        GUIEditor.label[7] = guiCreateLabel(1, 0, 132, 35, "Remove Contact", false, GUIEditor.staticimage[3])
        guiSetFont(GUIEditor.label[7], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[7], 0, 0, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[7], "center")    
        --requests
        GUIEditor.window[3] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
        
        GUIEditor.label[8] = guiCreateLabel(0, 14, 266, 15, "", false, GUIEditor.window[3])
        guiLabelSetHorizontalAlign(GUIEditor.label[8], "right", false)
        GUIEditor.label[9] = guiCreateLabel(135, 396, 15, 30, "|  |  |  |", false, GUIEditor.window[3])
        guiLabelSetHorizontalAlign(GUIEditor.label[9], "left", true)
        GUIEditor.label[5] = guiCreateLabel(135, 407, 15, 15, "|  |  |  |", false, GUIEditor.window[3])
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "left", true)
        GUIEditor.gridlist[3] = guiCreateGridList(0, 32, 271, 334, false, GUIEditor.window[3])
        guiGridListAddColumn(GUIEditor.gridlist[3], "Name", 0.75)

        GUIEditor.staticimage[4] = guiCreateStaticImage(0, 392, 137, 36, ":GTIdroid/wallpapers/bkgr_white.png", false, GUIEditor.window[3])
        guiSetAlpha(GUIEditor.staticimage[4], 0.46)

        GUIEditor.label[8] = guiCreateLabel(0, 0, 137, 35, "Accept", false, GUIEditor.staticimage[4])
        guiSetFont(GUIEditor.label[8], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[8], 0, 0, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[8], "center")

        GUIEditor.staticimage[5] = guiCreateStaticImage(137, 392, 133, 36, ":GTIdroid/wallpapers/bkgr_white.png", false, GUIEditor.window[3])
        guiSetAlpha(GUIEditor.staticimage[5], 0.46)

        GUIEditor.label[9] = guiCreateLabel(1, 0, 132, 35, "Deny", false, GUIEditor.staticimage[5])
        guiSetFont(GUIEditor.label[9], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[9], 0, 0, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[9], "center")    
        guiGridListSetSortingEnabled(GUIEditor.gridlist[2],false)
        guiGridListSetSortingEnabled(GUIEditor.gridlist[3],false)
        guiSetInputMode("no_binds_when_editing")
        guiSetVisible(GUIEditor.window[1],false)
        guiSetVisible(GUIEditor.window[2],false)
        guiSetVisible(GUIEditor.window[3],false)
end
addEventHandler("onClientResourceStart", resourceRoot, renderAppGUI)

addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderAppGUI)

local contacts = {}
local requests = {}
local requestsp = {}

function showAppGUI()
    if table.empty(contacts) then
        triggerServerEvent("GTIcontactsApp.getContacts",resourceRoot)
    else
        reloadContacts()
    end
    guiSetVisible(GUIEditor.window[1], true)
    exports.GTIdroid:showMainMenu(false, false)
    exports.GTIdroid:playTick()
end

function hideAppGUI()
    guiSetVisible(GUIEditor.window[1],false)
    guiSetVisible(GUIEditor.window[2],false)
    guiSetVisible(GUIEditor.window[3],false)
    exports.GTIdroid:showMainMenu(true)
end
addEvent("onGTIDroidClose", true)
addEventHandler("onGTIDroidClose", root, hideAppGUI)
addEventHandler("onClientResourceStop", resourceRoot, hideAppGUI)

addEvent("onGTIDroidClickBack", true)
addEventHandler("onGTIDroidClickBack", root, function()
    if guiGetVisible(GUIEditor.window[3]) then
	destroyElement(guiRoot)
        exports.GTIdroid:showMainMenu(false)
        guiSetVisible(GUIEditor.window[3],false)
        guiSetVisible(GUIEditor.window[1],true)
    elseif guiGetVisible(GUIEditor.window[1]) then
	destroyElement(guiRoot)
        guiSetVisible(GUIEditor.window[1],false)
        exports.GTIdroid:showMainMenu(true)
    elseif guiGetVisible(GUIEditor.window[2]) then
	destroyElement(guiRoot)
        guiSetVisible(GUIEditor.window[2],false)
        guiSetVisible(GUIEditor.window[1],true)
        exports.GTIdroid:showMainMenu(false)
    end
end )

function changeColorBack(par)
    local parent = getElementParent(source)
    if ( source == GUIEditor.staticimage[2] ) or ( source == GUIEditor.staticimage[3] ) or ( source == GUIEditor.staticimage[1] ) or ( source == GUIEditor.staticimage[4] ) or ( source == GUIEditor.staticimage[5] ) then
        guiSetProperty(source, "ImageColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
    elseif parent and (( parent == GUIEditor.staticimage[2] ) or ( parent == GUIEditor.staticimage[3] ) or ( parent == GUIEditor.staticimage[1] ) or ( parent == GUIEditor.staticimage[5] ) or ( parent == GUIEditor.staticimage[4] )) then
        guiSetProperty(parent, "ImageColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
    end
end
addEventHandler("onClientMouseLeave",root,changeColorBack)

function changeColor()
    local parent = getElementParent(source)
    if ( source == GUIEditor.staticimage[2] ) or ( source == GUIEditor.staticimage[3] ) or ( source == GUIEditor.staticimage[1] ) or ( source == GUIEditor.staticimage[4] ) or ( source == GUIEditor.staticimage[5] ) then
        guiSetProperty(source, "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
    elseif parent and (( parent == GUIEditor.staticimage[2] ) or ( parent == GUIEditor.staticimage[3] ) or ( parent == GUIEditor.staticimage[1] ) or ( parent == GUIEditor.staticimage[5] ) or ( parent == GUIEditor.staticimage[4] )) then
        guiSetProperty(parent, "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
    end
end
addEventHandler("onClientMouseEnter",root,changeColor)

addEventHandler("onClientGUIChanged",root,function()
    if source == GUIEditor.edit[1] then
        guiGridListClear(GUIEditor.gridlist[1])
        for k,v in ipairs ( getElementsByType("player") ) do
                local name = string.lower(getPlayerName(v))
                if name and not (v == localPlayer) then
                        if string.find (name,string.lower(guiGetText(GUIEditor.edit[1])) ) then
                                row = guiGridListAddRow ( GUIEditor.gridlist[1] )
                                guiGridListSetItemText ( GUIEditor.gridlist[1], row, column, getPlayerName ( v ), false, false )
                                end
                        end
                end
        end
end
)

function getPlayers()
    if ( column ) then
        if guiGetText(GUIEditor.edit[1]) ~= "" then return end
        guiGridListClear(GUIEditor.gridlist[1])
        for id, player in ipairs(getElementsByType("player")) do
        if not (player == localPlayer) then
            local row = guiGridListAddRow ( GUIEditor.gridlist[1] )
            guiGridListSetItemText ( GUIEditor.gridlist[1] , row, column, getPlayerName ( player ), false, false )
        end
    end
end
end

function updatePlayerList ( )
	guiGridListClear(GUIEditor.gridlist[1])
	 for id, player in ipairs(getElementsByType("player")) do
        if not (player == localPlayer) then
            local row = guiGridListAddRow ( GUIEditor.gridlist[1] )
            guiGridListSetItemText ( GUIEditor.gridlist[1] , row, column, getPlayerName ( player ), false, false )
		end
	end
end
addEventHandler ("onClientPlayerChangeNick", root, updatePlayerList )

addEventHandler("onClientPlayerChangeNick",root,function(oldNick,newNick)
    if contacts[oldNick] then
        contacts[oldNick][1] = newNick
        local contact = contacts[oldNick]
        contacts[newNick] = contact
        contacts[oldNick] = nil
        reloadContacts()
    end
end )

function handleBtns()
    if isElement(source) then
        parent = getElementParent(source)
    end
    
    if ( source == GUIEditor.staticimage[2] ) or ( source == GUIEditor.label[6] ) then
        exports.GTIdroid:playTick()
        getPlayers()
        guiSetVisible(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[2], true)
        
    elseif ( source == GUIEditor.staticimage[1] ) or ( source == GUIEditor.label[1] ) then 
        exports.GTIdroid:playTick()
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
        local playe = getPlayerFromName(selectedplayer)
        if contacts[selectedplayer] then
            exports.GTIhud:dm("This player is already in your contact list.",255,255,0)
        return end
        
        if isElement(playe) then
            addContact(playe,"Neutral")
            guiSetVisible(GUIEditor.window[2], false)
            guiSetVisible(GUIEditor.window[1], true)
        end
        
    elseif ( source == GUIEditor.radiobutton[1] ) or ( source == GUIEditor.radiobutton[2] ) or ( source == GUIEditor.radiobutton[3] ) then
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
        local status = guiGetText(source)
        if selectedplayer ~= "" and contacts[selectedplayer] and status ~= contacts[selectedplayer][2] then
            if status == "Friend" then
                local plr = getPlayerFromName(selectedplayer)
                if not isElement(plr) then
                    exports.GTIhud:dm("This player isn't online!",0,255,0)
                return end
                if requestsp[selectedplayer] then return end
                triggerServerEvent("GTIcontactsApp.sendRequest",resourceRoot,plr)
                contacts[selectedplayer][2] = "Pending"
                requestsp[selectedplayer] = true
            else
                triggerServerEvent("GTIcontactsApp.changeStatus",resourceRoot,contacts[selectedplayer][3],status)
                contacts[selectedplayer][2] = status
            end
            reloadContacts()
        end
    elseif ( source == GUIEditor.gridlist[2] ) then 
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
        if selectedplayer ~= "" and contacts[selectedplayer] then 
            local status = contacts[selectedplayer][2]
            if requestsp[selectedplayer] then
                guiSetEnabled(GUIEditor.radiobutton[1],false)
                guiSetEnabled(GUIEditor.radiobutton[3],false)
                guiSetEnabled(GUIEditor.radiobutton[2],false)
            else
                guiSetEnabled(GUIEditor.radiobutton[1],true)
                guiSetEnabled(GUIEditor.radiobutton[3],true)
                guiSetEnabled(GUIEditor.radiobutton[2],true)
            end
            if status == "Friend" then
                guiRadioButtonSetSelected(GUIEditor.radiobutton[1],true)
            elseif status == "Neutral" then
                guiRadioButtonSetSelected(GUIEditor.radiobutton[3],true)
            elseif status == "Blocked" then
                guiRadioButtonSetSelected(GUIEditor.radiobutton[2],true)
            end
        end
    elseif ( source == GUIEditor.staticimage[3] ) or ( source == GUIEditor.label[7] ) then
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
        if selectedplayer ~= "" and contacts[selectedplayer] then
            triggerServerEvent("GTIcontactsApp.deleteContact",resourceRoot,contacts[selectedplayer][3])
            contacts[selectedplayer] = nil
            reloadContacts()
        end
    elseif ( source == GUIEditor.staticimage[4] ) or ( source == GUIEditor.label[8] ) then 
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[3], guiGridListGetSelectedItem ( GUIEditor.gridlist[3] ), 1 )
        if selectedplayer ~= "" and requests[selectedplayer] then
            local friendacc = guiGridListGetItemData( GUIEditor.gridlist[3], guiGridListGetSelectedItem ( GUIEditor.gridlist[3] ), 1 )
            triggerServerEvent("GTIcontactsApp.acceptRequest",resourceRoot,friendacc)
            guiGridListRemoveRow( GUIEditor.gridlist[3], guiGridListGetSelectedItem ( GUIEditor.gridlist[3] ), 1 )
            requests[selectedplayer] = nil
            exports.GTIhud:dm(selectedplayer.." is now your friend!",0,255,0)
        end
    elseif ( source == GUIEditor.staticimage[5] ) or ( source == GUIEditor.label[9] ) then 
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[3], guiGridListGetSelectedItem ( GUIEditor.gridlist[3] ), 1 )
        if selectedplayer ~= "" and requests[selectedplayer] then
            guiGridListRemoveRow( GUIEditor.gridlist[3], guiGridListGetSelectedItem ( GUIEditor.gridlist[3] ), 1 )
            requests[selectedplayer] = nil
        end
    elseif ( source == GUIEditor.staticimage[6] ) then
        guiSetVisible(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[3], true)
        guiSetProperty(GUIEditor.staticimage[6],"NormalTextColour", "FFFFFFFF")  
    end
end
addEventHandler("onClientGUIClick",root,handleBtns)

function handleDoubleClick()
    if ( source == GUIEditor.gridlist[2] ) and guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ) then
        exports.GTIdroid:playTick()
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
        local playe = getPlayerFromName(selectedplayer)
        if isElement(playe) then
            hideAppGUI()
            exports.GTImessagingApp:newSMS(playe)
        end
    end
end
addEventHandler("onClientGUIDoubleClick",root,handleDoubleClick)

--
function table.empty( a )
    if type( a ) ~= "table" then
        return false
    end

    return not next( a )
end

function addContact(player,status)
    if player and status then
        triggerServerEvent("GTIcontactsApp.addContact",resourceRoot,player,status)
    end
end

function recieveContacts(Table)
    contacts = {}
    for i,v in ipairs(Table) do
        local contactname = v[1]
        contacts[contactname] = {contactname,v[2],v[3],v[4]}
    end
    reloadContacts()
end
addEvent ( "GTIcontactsApp.recieveContacts", true )
addEventHandler ( "GTIcontactsApp.recieveContacts", root, recieveContacts )
function getRow(city)
    local num = guiGridListGetRowCount (GUIEditor.gridlist[2] )
    for i = 0,num do
        if guiGridListGetItemText ( GUIEditor.gridlist[2] , i, name ) == city then
            return i
        end
    end
    local row = guiGridListAddRow(GUIEditor.gridlist[2])
    guiGridListSetItemText(GUIEditor.gridlist[2], row, name, city, true, false)
        if city == "Friend" then
            guiGridListSetItemColor ( GUIEditor.gridlist[2], row, name, 0, 255, 0 )
        elseif city == "Blocked" then
            guiGridListSetItemColor ( GUIEditor.gridlist[2], row, name, 255, 0, 0 )
        elseif city == "Pending" then
            guiGridListSetItemColor(GUIEditor.gridlist[2],row,name,150,150,0)
        end
    return row
end
function reloadContacts()
    guiGridListClear(GUIEditor.gridlist[2])
    count = 0
    blockedcount = 0
    friendcount = 0
    for i,v in pairs(contacts) do
        local contactname = v[1]
            if requestsp[contactname] and v[2] ~= "Friend" then
                rowindex = getRow("Pending")
            else
                rowindex = getRow(v[2])
                requestsp[contactname] = false
            end
        local row = guiGridListInsertRowAfter(GUIEditor.gridlist[2],rowindex)
        guiGridListSetItemText(GUIEditor.gridlist[2], row, name, contactname, false, false)
        if v[4] ~= nil then
            local d,m,y = exports.GTIutil:todate(v[4])
            local month = exports.GTIutil:getMonthName(m,3)
            guiGridListSetItemText(GUIEditor.gridlist[2], row, lastactive, d.." "..month.." "..y, false, false)
        else
            guiGridListSetItemText(GUIEditor.gridlist[2], row, lastactive, "N/A", false, false)
        end
        local contact = getPlayerFromName(contactname)
        count = count + 1
        if isElement(contact) then
            guiGridListSetItemColor(GUIEditor.gridlist[2],row,name,0,255,0)
        else
            guiGridListSetItemColor(GUIEditor.gridlist[2],row,name,255,0,0)
        end
        if v[2] == "Friend" then
            friendcount = friendcount + 1
        elseif v[2] == "Blocked" then
            blockedcount = blockedcount + 1
        end
    end
    guiSetText(GUIEditor.label[2],count.." Contacts ("..friendcount.." Friends, "..blockedcount.." Blocked)")
end

function recieveRequest(request,acc)
    if requests[request] then return end
    if contacts[request] and contacts[request][2] == "friend" then return end
    local row = guiGridListAddRow(GUIEditor.gridlist[3])
    guiGridListSetItemText(GUIEditor.gridlist[3], row, 1, request, false, false)
    guiGridListSetItemData(GUIEditor.gridlist[3], row, 1, acc)
    requests[request] = true
    exports.GTIhud:dm("You've recieved a friendship request from "..request..". Open contacts app to accept/deny it.",255,255,0)
    guiSetProperty(GUIEditor.staticimage[6],"NormalTextColour", "FFFC0000")  
end
addEvent ( "GTIcontactsApp.recieveRequest", true )
addEventHandler ( "GTIcontactsApp.recieveRequest", root, recieveRequest )

function cancelRequest(request,acc)
    if requestsp[request] then
        contacts[request][2] = "Neutral"
        requestsp[request] = false
        exports.GTIhud:dm("This player doesn't want you as friend.",255,255,0)
        reloadContacts()
    end
end
addEvent ( "GTIcontactsApp.cancelRequest", true )
addEventHandler ( "GTIcontactsApp.cancelRequest", root, cancelRequest )
