GUIEditor = {
    gridlist = {},
    window = {},
    edit = {},
    memo = {},
    button = {},
    staticimage = {},
    label = {},
    scrollpane = {}
}
messages = {}
vTable = {}
friends = {}
btn = {}
friendn = {}
notift = {}
local antiTick  = {}
friendscount = 0
function renderAppGUI()
    if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    GTIApp = exports.GTIdroid:getGTIDroidAppButton("Messages")
    addEventHandler("onClientGUIClick", GTIApp, showAppGUI, false)
    --contacts gui
    GUIEditor.window[1] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
    GUIEditor.staticimage[4] = guiCreateStaticImage(0, 0, 270, 36, "images/bckgrnd.png", false, GUIEditor.window[1])
    GUIEditor.staticimage[5] = guiCreateStaticImage(231, 6, 25, 25, "images/friend.png", false, GUIEditor.staticimage[4])
    GUIEditor.staticimage[6] = guiCreateStaticImage(7, 5, 33, 26, "images/msg.png", false, GUIEditor.staticimage[4])
    GUIEditor.label[6] = guiCreateLabel(50, 10, 158, 16, "GTIdroid SMS Application", false, GUIEditor.staticimage[4])
    GUIEditor.scrollpane[1] = guiCreateScrollPane(0, 40, 270, 400, false, GUIEditor.window[1])
    local font_1 = guiCreateFont("images/font1.ttf")
    guiSetFont(GUIEditor.label[6], font_1)
    guiLabelSetColor(GUIEditor.label[6], 195, 248, 255)    
    --add gui
    GUIEditor.window[2] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
    GUIEditor.staticimage[3] = guiCreateStaticImage(0, 0, 270, 40, "images/bckgrnd3.png", false, GUIEditor.window[2])
    GUIEditor.edit[1] = guiCreateEdit(22, 8, 225, 25, "", false, GUIEditor.staticimage[3])    
    GUIEditor.gridlist[1] = guiCreateGridList(0, 41, 271, 339, false, GUIEditor.window[2])    
    column = guiGridListAddColumn( GUIEditor.gridlist[1] , "Players", 0.85 )
    guiSetAlpha(GUIEditor.gridlist[1], 0.9)
    GUIEditor.staticimage[1] = guiCreateStaticImage(0, 380, 270, 50, "images/white.png", false, GUIEditor.window[2])
    guiSetAlpha(GUIEditor.staticimage[1], 0.62)
    GUIEditor.label[1] = guiCreateLabel(120, 17, 40, 16, "Add", false, GUIEditor.staticimage[1])
    local font_0 = guiCreateFont("images/font1.ttf")
    guiSetFont(GUIEditor.label[1], font_0)
    guiLabelSetColor(GUIEditor.label[1], 233, 0, 0)
    --sms gui 
    GUIEditor.window[3] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
    GUIEditor.memo[1] = guiCreateMemo(0, 0, 270, 395, "", false, GUIEditor.window[3])
    guiMemoSetReadOnly(GUIEditor.memo[1], true)
    guiSetFont(GUIEditor.memo[1], "default-bold-small")
    GUIEditor.edit[2] = guiCreateEdit(0, 394, 270, 35, "", false, GUIEditor.window[3])
    guiEditSetMaxLength(GUIEditor.edit[2], 140)
    guiSetInputMode("no_binds_when_editing")
    guiSetVisible(GUIEditor.window[1],false)
    guiSetVisible(GUIEditor.window[2],false)
    guiSetVisible(GUIEditor.window[3],false)
end
addEventHandler("onClientResourceStart", resourceRoot, renderAppGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderAppGUI)
function showAppGUI()
    guiSetVisible(GUIEditor.window[1], true)
    exports.GTIdroid:showMainMenu(false)
    guiSetText( GUIEditor.edit[1],"")
    exports.GTIdroid:playTick()
    getFriends()
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
		getFriends()
        exports.GTIdroid:showMainMenu(false)
        guiSetVisible(GUIEditor.window[3],false)
        guiSetVisible(GUIEditor.window[1],true)
    elseif guiGetVisible(GUIEditor.window[1]) then
        guiSetVisible(GUIEditor.window[1],false)
        exports.GTIdroid:showMainMenu(true)
    elseif guiGetVisible(GUIEditor.window[2]) then
		getFriends()
        guiSetVisible(GUIEditor.window[2],false)
        guiSetVisible(GUIEditor.window[1],true)
        exports.GTIdroid:showMainMenu(false)
    end
end )
function changeColorBack(par)
    local parent = par or getElementParent(source)
    if friends[source] or ( parent and friends[parent] ) then
        for i,v in pairs(friends) do
            if isElement(v[1]) then
                guiSetProperty(v[1], "ImageColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
            end
        end
    elseif ( source == GUIEditor.staticimage[5] ) or ( source == GUIEditor.staticimage[1] ) then
        guiSetProperty(source, "ImageColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
    end
end
addEventHandler("onClientMouseLeave",root,changeColorBack)
function changeColor()
    local parent = getElementParent(source)
    if friends[source] or ( source == GUIEditor.staticimage[5] ) or ( source == GUIEditor.staticimage[1] ) then
        guiSetProperty(source, "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
    elseif ( parent and friends[parent] ) then
        guiSetProperty(parent, "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
    end
end
addEventHandler("onClientMouseEnter",root,changeColor)

function newFriend(player,notif)
	if not friendn[player] then
        friendscount = friendscount+1
        fy = 60*friendscount
        local theFriend = getPlayerFromName(player)
        local fbtn = guiCreateStaticImage(0, fy, 253, 51, "images/bckgrnd3.png", false, GUIEditor.scrollpane[1])
        local font = guiCreateFont("images/font1.ttf")
        local label1 = guiCreateLabel(52, 7, 200, 16, player, false, fbtn)
        guiSetFont(label1, font)
        local label3 = guiCreateStaticImage(232, 5, 19, 19, "images/x.png", false, fbtn)
        btn[label3] = fbtn
        if theFriend then
            local label2 = guiCreateLabel(52, 26, 87, 15, "Status: online", false, fbtn)
            guiSetFont(label2, font)
            guiLabelSetColor(label2, 0, 100, 0)
        else 
            local label2 = guiCreateLabel(52, 26, 87, 15, "Status: offline", false, fbtn)
            guiSetFont(label2, font)
            guiLabelSetColor(label2, 255, 0, 0) 
        end
        if notif then
            notifimg = guiCreateStaticImage(10, 13, 32, 32, "images/notif1.png", false, fbtn)
        else
            notifimg = guiCreateStaticImage(10, 13, 32, 32, "images/notif2.png", false, fbtn)
        end
        if friendscount == 6 then
            guiScrollPaneSetScrollBars(GUIEditor.scrollpane[1],false,true)
        end
        friends[fbtn] = {fbtn,player,notifimg}
		friendn[player] = true
	end
end
function clearList()
    for i,v in pairs(friends) do
        if isElement(v[1]) then destroyElement(v[1]) end
    end
    btn = {}
    friends = {}
	friendn = {}
    friendscount = 0
    guiScrollPaneSetScrollBars(GUIEditor.scrollpane[1],false,false)
end

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
if guiGetVisible(GUIEditor.window[1]) then
getFriends()
end
end
addEventHandler("onClientPlayerJoin",getRootElement(),getPlayers)
addEventHandler("onClientPlayerQuit",getRootElement(),getPlayers)
addEventHandler("onClientPlayerChangeNick",getRootElement(),getPlayers)
addEventHandler("onClientPlayerChangeNick",getRootElement(),function(oldNick,newNick)
    if messages[oldNick] or vTable[oldNick] then
        local msg = messages[oldNick]
		local notif = notift[oldNick]
        messages[newNick] = msg
        vTable[newNick] = msg
        
        if notif then
			notift[newNick] = true
		end
        messages[oldNick] = nil
        vTable[oldNick] = nil
		notift[oldNick] = nil
        getFriends()
    end
end )

function getFriends()
	clearList()
	for i,v in pairs(vTable) do
		newFriend(i,false)
	end
	for i,v in pairs(notift) do
		if v then
			newFriend(i,true)
		end
    end
end
addEventHandler("onClientGUIClick",root,function()
    local parent = getElementParent(source)
    if ( source == GUIEditor.staticimage[5] ) then
        exports.GTIdroid:playTick()
        getPlayers()
        guiSetVisible(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[2], true)
    elseif btn[source] then
        local blc = btn[source]
        local selectedplayer = friends[blc][2]
        messages[selectedplayer] = nil
        vTable[selectedplayer] = nil
        getFriends()
    elseif friends[source] or (parent and friends[parent]) then
        exports.GTIdroid:playTick()
        if parent and friends[parent] then
            selectedplaya = friends[parent][2]
            changeColorBack(parent)
        else
            selectedplaya = friends[source][2] 
        end
        local playe = getPlayerFromName(selectedplaya)
    if (not isElement(playe)) then
        guiSetVisible(GUIEditor.edit[2], false)
        guiSetSize(GUIEditor.memo[1], 270, 430, false)
    else
        guiSetVisible(GUIEditor.edit[2], true)
        guiSetSize(GUIEditor.memo[1], 270, 395, false)
    end 
        guiSetText(GUIEditor.memo[1], messages[selectedplaya])
        guiMemoSetCaretIndex(GUIEditor.memo[1], #messages[selectedplaya])
        lastPlayer = playe
        setNotif(selectedplaya,false)
        guiSetVisible(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[3], true)
        
    elseif ( source == GUIEditor.staticimage[1] ) or ( source == GUIEditor.label[1] ) then 
        exports.GTIdroid:playTick()
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
        local playe = getPlayerFromName(selectedplayer)
        if isElement(playe) and not messages[selectedplayer] then
            newFriend(selectedplayer,false)
            messages[selectedplayer] = " "
            vTable[selectedplayer] = " "
            guiSetVisible(GUIEditor.window[2], false)
            guiSetVisible(GUIEditor.window[1], true)
        end
        
    end
end)
function setNotif(plr,notif)
    for i,v in pairs(friends) do
        if v[2] == plr then
            destroyElement(v[3])
            if notif then
                friends[i][3] = guiCreateStaticImage(10, 13, 32, 32, "images/notif1.png", false, v[1])
				notift[plr] = true
            else
                friends[i][3] = guiCreateStaticImage(10, 13, 32, 32, "images/notif2.png", false, v[1])
				notift[plr] = false
            end
        end
    end
end 
            
function handleDoubleClick()
    if ( source == GUIEditor.gridlist[1] ) and guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ) then
        exports.GTIdroid:playTick()
        local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
        local playe = getPlayerFromName(selectedplayer)
        if isElement(playe) and not messages[selectedplayer] then
            newFriend(selectedplayer,false)
            messages[selectedplayer] = " "
            vTable[selectedplayer] = " "
            guiSetVisible(GUIEditor.window[2], false)
            guiSetVisible(GUIEditor.window[1], true)
            
        end
    end
end
addEventHandler("onClientGUIDoubleClick",root,handleDoubleClick)

addEventHandler("onClientGUIAccepted", root, function(theElement) 
    if ( source == GUIEditor.edit[2] and theElement == GUIEditor.edit[2] ) then
        local msgs = guiGetText(GUIEditor.edit[2])
        local msg = string.gsub(msgs, "%s+"," ")
        local tick = getTickCount()
    if (antiTick[lastPlayer] and tick - antiTick[lastPlayer] < 1000) then
        dm("You need to wait 1 second between each message.", 255, 0, 0)
        return
    end
        if msg == "" or msg == " " then
		return 
	end
        local myName = getPlayerName(localPlayer)
        local name = getPlayerName(lastPlayer)
        if isElement(lastPlayer) and (exports.GTIaccounts:isPlayerLoggedIn(lastPlayer)) then
	    antiTick[lastPlayer] = getTickCount()
            triggerServerEvent("GTIMessagingApp.sendmsg",resourceRoot,msg,lastPlayer)
            guiSetText(GUIEditor.edit[2], "")
            messages[name] = messages[name].."\n\n"..myName..":  "..msg
            vTable[name] = msg
            guiSetText(GUIEditor.memo[1],  messages[name])
            
            guiMemoSetCaretIndex(GUIEditor.memo[1], #messages[name])
        end
    end
end )
-- /re command
addCommandHandler("re", function(cmd, ...) 
local msgs = table.concat({...}, " ")
    if msgs and isElement(lastPlayerR) then
        local tick = getTickCount()
    if (antiTick[lastPlayerR] and tick - antiTick[lastPlayerR] < 1000) then
        dm("You need to wait 1 second between each message.", 255, 0, 0)
        return
    end
        local msg = string.gsub(msgs, "%s+"," ")
        if msg == "" or msg == " " then 
		return 
	end
        antiTick[lastPlayerR] = getTickCount()
        local myName = getPlayerName(localPlayer)
        local name = getPlayerName(lastPlayerR)
        triggerServerEvent("GTIMessagingApp.sendmsg",resourceRoot,msg,lastPlayerR)
        if not messages[name] then 
            messages[name] = messages[name]..myName..":  "..msg
            vTable[name] = msg
        else
            messages[name] = messages[name].."\n\n"..myName..":  "..msg
            vTable[name] = msg
        end
        
        outputChatBox("PM to "..name..": "..msg, 0, 107, 143)
        if guiGetVisible(GUIEditor.window[3]) and lastPlayer == lastPlayerR then
            guiSetText(GUIEditor.memo[1], messages[name])
            guiMemoSetCaretIndex(GUIEditor.memo[1], #messages[name])
        end
    end
end )

addEvent("GTIMessagingApp.recievemsg", true) 
addEventHandler("GTIMessagingApp.recievemsg", root, function(theMSG,sender) 
    local name = getPlayerName(sender)
    local myName = getPlayerName(localPlayer)
    lastPlayerR = sender
    outputChatBox("PM From "..name..": "..theMSG, 36, 143, 0)
        if not messages[name] then
            newFriend(name,true)
            messages[name] = name..":  "..theMSG
            vTable[name] = theMSG
        else
            setNotif(name,true)
            messages[name] = messages[name].."\n\n"..name..":  "..theMSG
            vTable[name] = theMSG
         end
    if guiGetVisible(GUIEditor.window[3]) and lastPlayer == sender then
        setNotif(lastPlayer,false)
        guiSetText(GUIEditor.memo[1], messages[name])
        guiMemoSetCaretIndex(GUIEditor.memo[1], #messages[name])
    end
    
    playSound(":GTIdroid/audio/Tejat.ogg")
end )

-- exports
function newSMS(playe)
	local selectedplaya = getPlayerName(playe)
	if not messages[selectedplaya] then
        newFriend(selectedplaya,false)
        messages[selectedplaya] = " "
		vTable[selectedplaya] = " "
		guiSetText(GUIEditor.memo[1], "")
		lastPlayer = playe
	else
		guiSetText(GUIEditor.memo[1], messages[selectedplaya])
		guiMemoSetCaretIndex(GUIEditor.memo[1], #messages[selectedplaya])
		lastPlayer = playe
		setNotif(selectedplaya,false)
	end
    guiSetVisible(GUIEditor.edit[2], true)
    guiSetSize(GUIEditor.memo[1], 270, 395, false)
	guiSetVisible(GUIEditor.window[1], false)
    guiSetVisible(GUIEditor.window[3], true)
    exports.GTIdroid:showMainMenu(false)
end
-- NicKeLz
---------- >>

addEventHandler ( "onClientResourceStop", resourceRoot, function ( )
    local file = xmlCreateFile ( '@msg.xml', 'Messages' )
    for i, v in pairs( messages ) do
        local child = xmlCreateChild ( file, 'message' )
        xmlNodeSetAttribute(child, 'Name', i)
        xmlNodeSetAttribute(child, 'Msg', tostring(v))
    end
    xmlSaveFile ( file )
    xmlUnloadFile ( file )
end )

addEventHandler ( "onClientResourceStart", resourceRoot, function ( )
if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
    setTimer ( function ( )
        local file = xmlLoadFile ( '@msg.xml', 'Messages' )
        if file then
            for i, v in ipairs( xmlNodeGetChildren( file ) ) do
                local name = tostring( xmlNodeGetAttribute( v, 'Name' ) )
                local Msg = tostring( xmlNodeGetAttribute( v, 'Msg' ) )
                if ( not messages[name] ) then
                    newFriend(name,false)
                    messages[name] = Msg
                    vTable[name] = Msg
                end
            end
        end
    end, 500, 1 )
end )

function dm (text, r, g, b)
	exports.GTIhud:dm(text, r, g, b)
end

