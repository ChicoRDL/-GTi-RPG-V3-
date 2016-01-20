local Chats = { "Support", "Main", "Team", "Local", "Group", "Adverts", "AR", "ES", "PT", "NL", "TN", "TR", "EY", "FR", "Join/Quit", "Brief" }
local chatSystem = {}
local eTable = {}

addEventHandler("onClientResourceStart", resourceRoot,
function()
panel = guiCreateWindow(10, 39, 776, 526, "GTI Chat Panel", false)
guiWindowSetSizable(panel, false)
guiSetVisible(panel, false)
guiSetAlpha(panel, 0.86)
cTab = guiCreateTabPanel(9, 27, 757, 492, false, panel)

local screenW,screenH = guiGetScreenSize()
local windowW,windowH=guiGetSize(panel,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(panel,x,y,false)

    for k,v in ipairs ( Chats ) do
        local chat = v
        newTab = guiCreateTab(tostring(v),cTab)
        chatSystem[chat] = { }
        chatSystem[chat][1] = guiCreateGridList(10, 10, 737, 418, false, newTab)
        guiGridListSetSortingEnabled ( chatSystem[chat][1], false )
        chatSystem[chat][3] = guiGridListAddColumn(chatSystem[chat][1], "Time", 0.12)
        chatSystem[chat][4] = guiGridListAddColumn(chatSystem[chat][1], "Message", 0.83)
        addEventHandler( "onClientGUIDoubleClick", chatSystem[chat][1], copyRow, false )
        if (chat ~= "Join/Quit" and chat ~= "Brief")  then
            chatSystem[chat][2] = guiCreateEdit(70, 432, 556, 24, "", false, newTab)
            chatSystem[chat][5] = guiCreateCheckBox(630, 432, 117, 24, "Show in Chatbox", false, false, newTab)
            chatSystem[chat][6] = guiCreateLabel(9, 432, 61, 24, "Message:", false, newTab)
            guiLabelSetHorizontalAlign(chatSystem[chat][6], "center", false)
            guiLabelSetVerticalAlign(chatSystem[chat][6], "center")
            guiLabelSetColor(chatSystem[chat][6], 221, 241, 7)
            guiSetFont(chatSystem[chat][6], "default-bold-small")
            manageEdit(chatSystem[chat][2])
            checkBox(chatSystem[chat][5])
        elseif (chat == "Join/Quit") then
            chatSystem[chat][5] = guiCreateCheckBox(610, 432, 130, 30, "Show in Kill message", false, false, newTab)
            checkBox(chatSystem[chat][5])
        end
    end
    loadXML()
end
)

function showGui(thePlayer)
    if (not exports.GTIaccounts:isPlayerLoggedIn()) then return end
    local x = not guiGetVisible(panel)
    guiSetVisible(panel, x)
    showCursor(x)
end
bindKey ( "F1", "down", showGui )

function outputGridlist(chatName, message)
    triggerEvent("GTIchat.addChatRow", resourceRoot, chatName, message)
    return true
end

addEvent( "GTIchat.addChatRow", true )
addEventHandler("GTIchat.addChatRow", root,
function ( theRoom, msg, govMem )
local time    = getRealTime()
local hours   = time.hour
local minutes = time.minute
local seconds = time.second
local message = string.gsub ( msg, '#%x%x%x%x%x%x', '' )

if seconds <= 9 then seconds = "0"..seconds end
if minutes <= 9 then minutes = "0"..minutes end
if hours <= 9 then hours = "0"..hours end

    if ( chatSystem[theRoom] ) then
        row = guiGridListAddRow ( chatSystem[theRoom][1] )
        if govMem then
            guiGridListSetItemText ( chatSystem[theRoom][1], row, 1, "["..hours..":"..minutes..":"..seconds.."]", false, false )
            guiGridListSetItemColor( chatSystem[theRoom][1], row, 1, 153, 102, 204)
            guiGridListSetItemText ( chatSystem[theRoom][1], row, 2, message, false, false )
            guiGridListSetItemColor( chatSystem[theRoom][1], row, 2, 153, 102, 204)
        else
            guiGridListSetItemText ( chatSystem[theRoom][1], row, 1, "["..hours..":"..minutes..":"..seconds.."]", false, false )
            guiGridListSetItemText ( chatSystem[theRoom][1], row, 2, message, false, false )
        end
        guiGridListSetVerticalScrollPosition(  chatSystem[theRoom][1], 100 )
        --[[if (isElement(chatSystem[theRoom][5])) then
            if (guiCheckBoxGetSelected(chatSystem[theRoom][5])) then
             --   outputChatBox(message, 255, 255, 255, true)
            end
        end]]
    end
end
)

function copyRow( )
local tab = guiGetSelectedTab(cTab)
local tabName = guiGetText(tab)
local selectedRow = guiGridListGetSelectedItem( chatSystem[tabName][1] )
local rowTime = guiGridListGetItemText( chatSystem[tabName][1], selectedRow, 1, false, false )
local rowMessage = guiGridListGetItemText( chatSystem[tabName][1], selectedRow, 2, false, false )
local copy = setClipboard( rowTime.." "..rowMessage )
    if copy then
        outputChatBox( "* Clipboard text set to: " .. rowMessage, 0, 255, 0 )
    end
end

function check(key,press)
    if ( key == "enter" or key =="num_enter" ) and press then
        if spec then
            local tab = guiGetSelectedTab(cTab)
            local tabName = guiGetText(tab)
            local edit = chatSystem[tabName][2]

                if withEdit ~= false then
                    editText = guiGetText(edit)
                else
                    editText = text
                end

            if ( editText ~= "" ) then
                if ( guiGetVisible(panel) == true ) then
                    triggerServerEvent("GTIchat.onChat",localPlayer,tabName,editText)
                    guiSetText(edit,"")
                end
            end

        end
    end
end

function manageEdit(edit)
    addEventHandler("onClientGUIChanged",root,function()
        if source == edit then
            local text = guiGetText(edit)
            if text and text ~= "" then
                if not spec then
                    spec = true
                    addEventHandler("onClientKey",root,check )
                end
            else
                if spec then
                    spec = false
                    removeEventHandler("onClientKey",root,check )
                end
            end
        end
    end )
end

function checkBox(box)
    if not ( box ) then return end
    addEventHandler("onClientGUIClick",root,function()
        if ( source == box ) then
            local selected = guiCheckBoxGetSelected(source)
            local room = guiGetText( guiGetSelectedTab(cTab) )
            if ( selected ) then
                eTable[room] = true
                setElementData(localPlayer,"GTIchat.marked"..string.upper(room),true)
            else
                eTable[room] = false
                setElementData(localPlayer,"GTIchat.marked"..string.upper(room),false)
            end
        end
    end )
end

function setChatEnabled (chat, state)
    if ( chat and isElement(chatSystem[chat][5]) ) then
        if ( state == true ) then
            guiCheckBoxSetSelected(chatSystem[chat][5], true)
            setElementData(localPlayer,"GTIchat.marked"..string.upper(chat),true)
            eTable[chat] = true
        else
            guiCheckBoxSetSelected(chatSystem[chat][5], false)
            setElementData(localPlayer,"GTIchat.marked"..string.upper(chat),false)
            eTable[chat] = false
        end
    end
end
addEvent("GTIchat.setChatEnabled", true)
addEventHandler("GTIchat.setChatEnabled", root, setChatEnabled)

addEventHandler ( "onClientResourceStop", resourceRoot, function ( )
    local file = xmlCreateFile('@Chat.xml', 'Chats')
    for i, v in pairs ( Chats ) do
        local child = xmlCreateChild(file, 'chat')
        xmlNodeSetAttribute(child, 'name', v)
        xmlNodeSetAttribute(child, 'enabled', isset(eTable[v]))
    end
    xmlSaveFile(file)
    xmlUnloadFile(file)
end )

function loadXML()
    setTimer ( function ( )
        local file = xmlLoadFile("@Chat.xml", "Chats")
        if ( file ) then
            for i, v in ipairs(xmlNodeGetChildren(file)) do
                local name = tostring ( xmlNodeGetAttribute(v, 'name' ))
                local enabled = toboolean ( xmlNodeGetAttribute(v, 'enabled'))
                if (name) then
                    setChatEnabled(name, enabled)
                end
            end
        end
    end, 500, 1 )
end

function toboolean ( input )
    local input = string.lower ( tostring ( input ) )
    if ( input == 'true' ) then
        return true
    elseif ( input == 'false' ) then
        return false
    else return false end
end

function isset ( value )
    if ( value == true ) then
        return "true"
    else
        return "false"
    end
end

addEventHandler("onClientResourceStart",resourceRoot,
    function()
    for index,value in ipairs(Chats) do
        setElementData(localPlayer,"GTIchat.marked"..string.upper(value),false)
    end
        setChatEnabled("Main",true)
        setChatEnabled("Team",true)
        setChatEnabled("Local",true)
        setChatEnabled("Adverts",true)
        setChatEnabled("Group",true)
        setChatEnabled("Support",true)
        setChatEnabled("Join/Quit",true)
    end
)
