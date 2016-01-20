--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~
-- Resource: GTImusicApp/Client.lua ~
-- Description: GTIdroid Music App ~
-- Data: #Music
--<--------------------------------->--

local musicList = {}

-- Saving/Loading Type
------------->>

function table.empty( a )
    if type( a ) ~= "table" then
        return false
    end

    return not next( a )
end

function refreshMusicList()
    guiGridListClear( GUIEditor.gridlist[1])
    --
    for i, data in pairs (musicList) do
        local name = data[1]
        local url = data[2]

        local row = guiGridListAddRow( GUIEditor.gridlist[1])
        guiGridListSetItemText ( GUIEditor.gridlist[1], row, 1, name, false, false)
        guiGridListSetItemData ( GUIEditor.gridlist[1], row, 1, url..";"..i)
    end
end

local lastID = 0
function separateURL( currentURL)
if not (currentURL) then return end
    local datsplit = split( currentURL, ";")
    lastID = datsplit[2]
    return datsplit[1], datsplit[2]
end

function isSongOnPlaylist( url)
    if table.empty( musicList) then return false end
    for i, data in pairs (musicList) do
        theURL = separateURL( data[2])
        if string.find( theURL, url) then
            return true
        else
            return false
        end
    end
end

function saveMusicList()
    local mList = {}
    for i,song in pairs(musicList) do
        mList[i] = table.concat(song, ",")
    end
    local songString = table.concat(mList, ";")
    if (songString == "") then songString = nil end
    triggerServerEvent( "GTImusicApp.sendTableOnline", localPlayer, songString)
end

function deleteSong( id)
    local id = tonumber( id)
    for i, data in pairs (musicList) do
        local loggedname = data[1]
        --if string.find( loggedname, name) then
        if id == i then
            table.remove( musicList, i)
        end
        refreshMusicList()
        saveMusicList()
    end
end

function addSong( name, url)
    if table.empty( musicList) then
        table.insert( musicList, { name, url})
        refreshMusicList()
        exports.GTIhud:dm( "You have added '"..name.."' to your playlist.", 225, 255, 25)
    elseif not table.empty( musicList) then
        if not isSongOnPlaylist( url) then
            table.insert( musicList, { name, url})
            refreshMusicList()
            exports.GTIhud:dm( "You have added '"..name.."' to your playlist.", 225, 255, 25)
        else
            exports.GTIhud:dm( "'"..name.."' is already on your playlist.", 225, 25, 25)
        end
    end
    guiSetText( GUIEditor.edit[1], "" )
    guiSetText( GUIEditor.edit[2], "" )
    guiSetVisible( GUIEditor.window[2], false)
    refreshMusicList()
    saveMusicList()
end

-- Recieving Playlist
addEvent( "GTImusicApp.sendPlaylist", true)
addEventHandler( "GTImusicApp.sendPlaylist", root,
    function( theTable)
        musicList = {}
        local mList = {}
        mList = split(theTable, ";")
        for i,song in pairs(mList) do
            song = split(song, ",")
            table.insert( musicList, { song[1], song[2]})
        end
        refreshMusicList()
    end
)

GUIEditor = {
    window = {},
    gridlist = {},
    staticimage = {},
    button = {},
    edit = {},
    scroll = {},
    label = {}
}
function renderAppGUI()
    if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
    
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    GTIApp = exports.GTIdroid:getGTIDroidAppButton("Music")
    addEventHandler("onClientGUIClick", GTIApp, showAppGUI, false)

        GUIEditor.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
        guiSetVisible(GUIEditor.staticimage[1], false)
        GUIEditor.label[1] = guiCreateLabel(2, 38, 43, 19, "Name:", false, GUIEditor.staticimage[1])
        local font_0 = guiCreateFont(":GTIdroid/fonts/Roboto-Bold.ttf")
        guiSetFont(GUIEditor.label[1], font_0)
        guiLabelSetColor(GUIEditor.label[1], 0, 127, 118)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.gridlist[1] = guiCreateGridList(1, 108, 268, 284, false, GUIEditor.staticimage[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "Music Name", 0.9)
        --guiGridListAddColumn(GUIEditor.gridlist[1], "Song Name", 0.5)
        GUIEditor.label[2] = guiCreateLabel(2, 67, 43, 19, "URL:", false, GUIEditor.staticimage[1])
        guiSetFont(GUIEditor.label[2], font_0)
        guiLabelSetColor(GUIEditor.label[2], 0, 127, 118)
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
        --GUIEditor.label[3] = guiCreateLabel(0, 82, 270, 22, "_________________________________________", false, GUIEditor.staticimage[1])
        GUIEditor.scroll[1] = guiCreateScrollBar(0, 90, 270, 20, true, false, GUIEditor.staticimage[1])
        addEventHandler("onClientGUIScroll", GUIEditor.scroll[1], vol)
        guiScrollBarSetScrollPosition ( GUIEditor.scroll[1], 100 )
        GUIEditor.label[4] = guiCreateLabel(55, 38, 215, 19, "Select Your Song", false, GUIEditor.staticimage[1])
        local font_1 = guiCreateFont(":GTIdroid/fonts/Roboto.ttf")
        guiSetFont(GUIEditor.label[4], font_1)
        guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
        GUIEditor.label[5] = guiCreateLabel(55, 67, 215, 19, "-", false, GUIEditor.staticimage[1])
        guiSetFont(GUIEditor.label[5], font_1)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
        GUIEditor.button[1] = guiCreateButton(0, 398, 68, 30, "Play/Stop", false, GUIEditor.staticimage[1])
        guiSetFont(GUIEditor.button[1], font_0)
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF007F76")
        GUIEditor.button[2] = guiCreateButton(68, 398, 68, 30, "Add", false, GUIEditor.staticimage[1])
        guiSetFont(GUIEditor.button[2], font_0)
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF007F76")
        GUIEditor.button[3] = guiCreateButton(136, 398, 68, 30, "Edit", false, GUIEditor.staticimage[1])
        guiSetFont(GUIEditor.button[3], font_0)
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF007F76")
        GUIEditor.button[4] = guiCreateButton(204, 398, 68, 30, "Remove", false, GUIEditor.staticimage[1])
        guiSetFont(GUIEditor.button[4], font_0)
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF007F76")
        GUIEditor.staticimage[3] = guiCreateStaticImage(0, 0, 270, 30, ":GTIdroid/phone/search_bar.png", false, GUIEditor.staticimage[1])
        GUIEditor.window[2] = guiCreateWindow(1071, 332, 254, 165, "Add/Save", false, GTIPhone)
        guiWindowSetSizable(GUIEditor.window[2], false)
        GUIEditor.label[6] = guiCreateLabel(10, 23, 62, 20, "Name:", false, GUIEditor.window[2])
        local font_0 = guiCreateFont(":GTIdroid/fonts/Roboto-Bold.ttf")
        guiSetFont(GUIEditor.label[6], font_0)
        guiLabelSetColor(GUIEditor.label[6], 0, 128, 129)
        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")
        GUIEditor.edit[1] = guiCreateEdit(9, 43, 235, 25, "", false, GUIEditor.window[2])
        GUIEditor.label[7] = guiCreateLabel(10, 78, 62, 20, "URL:", false, GUIEditor.window[2])
        guiSetFont(GUIEditor.label[7], font_0)
        guiLabelSetColor(GUIEditor.label[7], 0, 128, 129)
        guiLabelSetVerticalAlign(GUIEditor.label[7], "center")
        GUIEditor.edit[2] = guiCreateEdit(9, 98, 235, 25, "", false, GUIEditor.window[2])
        GUIEditor.button[5] = guiCreateButton(10, 131, 113, 24, "Add", false, GUIEditor.window[2])
        guiSetFont(GUIEditor.button[5], font_0)
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[6] = guiCreateButton(131, 131, 113, 24, "Cancel", false, GUIEditor.window[2])
        guiSetFont(GUIEditor.button[6], font_0)
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFAAAAAA")
        guiSetVisible(GUIEditor.window[2], false)
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(GUIEditor.window[2], false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetPosition(GUIEditor.window[2], x, y, false)
end
addEventHandler("onClientResourceStart", resourceRoot, renderAppGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderAppGUI)

-- Show/Hide
------------->>

function showAppGUI()
    guiSetVisible(GUIEditor.staticimage[1], true)
    exports.GTIdroid:showMainMenu(false)
    exports.GTIdroid:playTick()
    triggerServerEvent( "GTImusicApp.getPlaylist", localPlayer)
end

function hideAppGUI()
    guiSetVisible(GUIEditor.staticimage[1], false)
    guiSetVisible(GUIEditor.window[2], false)
    exports.GTIdroid:showMainMenu(true)
end
function avoidBugs() --> "Nerox"
    if guiGetVisible(GUIEditor.staticimage[1]) then
    hideAppGUI()
    end
end
addEvent("onGTIDroidClickBack", true)
addEventHandler("onGTIDroidClickBack", root, avoidBugs)
addEvent("onGTIDroidClose", true)
addEventHandler("onGTIDroidClose", root, hideAppGUI)
addEventHandler("onClientResourceStop", resourceRoot, hideAppGUI)

-- Add/Remove/Play/Stop
------------->>

function buttonClick ()
    if ( source == GUIEditor.button[2] ) then -- Add
        exports.GTIdroid:playTick()
        guiSetText( GUIEditor.button[5], "Add" )
       guiSetVisible(GUIEditor.window[2], true)
--
    elseif ( source == GUIEditor.button[6] ) then --Cancel
        exports.GTIdroid:playTick()
        guiSetVisible(GUIEditor.window[2], false)
--
    elseif ( source ==  GUIEditor.button[5] ) then --Add
        exports.GTIdroid:playTick()
        local name = guiGetText( GUIEditor.edit[1] )
        local url  = guiGetText( GUIEditor.edit[2] )
        guiSetVisible( GUIEditor.window[2], true )
            if guiGetText ( GUIEditor.button[5] ) == "Add" then
                if ( name == "" ) then return end
                if ( url == "" ) then return end
                --triggerServerEvent("GTImusicApp.addMusic", localPlayer, name, url)
                addSong( name, url)
            elseif guiGetText ( GUIEditor.button[5] ) == "Save" then
                if ( name == "" ) then return end
                if ( url == "" ) then return end
                --triggerServerEvent("GTImusicApp.updateMusic", localPlayer, name, url)
                local selected = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
                if not ( selected ~= -1 ) then return end
                local which = guiGridListGetItemText ( GUIEditor.gridlist[1], selected, 1 )
                guiSetText( GUIEditor.window[2], "Edit" )
                guiGridListSetItemText ( GUIEditor.gridlist[1], selected, 1, name, false, false)
                guiGridListSetItemData ( GUIEditor.gridlist[1], selected, 1, url..";"..lastID)
                deleteSong( lastID)
                addSong( name, url)
                guiSetText( GUIEditor.edit[1], "" )
                guiSetText( GUIEditor.edit[2], "" )
                guiSetVisible( GUIEditor.window[2], false )
            end
--
    elseif ( source == GUIEditor.button[4] ) then --Remove
        exports.GTIdroid:playTick()
        local rRow      = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
        if not (rRow ~= -1) then return end
        local musicName = guiGridListGetItemText( GUIEditor.gridlist[1], rRow, 1 )
        local url = guiGridListGetItemData( GUIEditor.gridlist[1], rRow, 1 )
        local url, id = separateURL( url)
        deleteSong( id)
--
    elseif ( source == GUIEditor.button[1]  ) then --Play/Stop
        local pRow      = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
        local musicName = guiGridListGetItemText( GUIEditor.gridlist[1], pRow, 1 )
        local URL       = guiGridListGetItemData(GUIEditor.gridlist[1], pRow, 1)
        local URL = separateURL( URL)
            if sound and isElement(music) then
                sound = false
                removeEventHandler ( "onClientSoundStopped", music, playNextSong )
                stopSound( music )
                local veh = getPedOccupiedVehicle(localPlayer)
                if veh and getVehicleController(veh) == localPlayer then 
                    setElementData(veh,"GTImusicApp.Music",{false,false}) 
                    local occupants = getVehicleOccupants(veh) or {}
                    for seat, occupant in pairs(occupants) do
                        if not ( seat == 0 ) and (occupant and getElementType(occupant) == "player") then 
                            triggerServerEvent("GTImusicApp.sendmusic",resourceRoot,occupant,false,false)
                        end
                    end
                end
            else
                if not ( pRow ~= -1 ) then return end
                local Scroll = guiScrollBarGetScrollPosition(GUIEditor.scroll[1])
                Volume = Scroll / 100
                sound = true
                music = playSound( URL, false )
                setSoundVolume(music,Volume)
                lastRow = pRow
                addEventHandler ( "onClientSoundStopped", music, playNextSong )
                lastSong = URL
                lastName = musicName
                exports.GTIhud:dm("Now Playing: "..musicName, 0, 129, 129)
                local veh = getPedOccupiedVehicle(localPlayer)
                if veh and getVehicleController(veh) == localPlayer then 
                    setElementData(veh,"GTImusicApp.Music",{URL,musicName}) 
                    local occupants = getVehicleOccupants(veh) or {}
                    for seat, occupant in pairs(occupants) do
                        if not ( seat == 0 ) and (occupant and getElementType(occupant) == "player") then 
                            triggerServerEvent("GTImusicApp.sendmusic",resourceRoot,occupant,URL,musicName)
                        end
                    end
                end
            end
--
        elseif ( source == GUIEditor.button[3] ) then -- Edit
        local selected = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
        if not ( selected ~= -1 ) then return end
        local songN = guiGridListGetItemText( GUIEditor.gridlist[1], selected, 1 )
        guiSetText( GUIEditor.edit[1], songN )
                data = guiGridListGetItemData(GUIEditor.gridlist[1], selected, 1)
                data = separateURL( data)
                guiSetText( GUIEditor.edit[2], data )
                guiSetVisible( GUIEditor.window[2], true )
                guiSetText( GUIEditor.button[5], "Save" )

        elseif ( source == GUIEditor.gridlist[1] ) then --Click
        local Row = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
        if (Row ~= -1) then
            local Name  = guiGridListGetItemText( GUIEditor.gridlist[1], Row, 1 )
            local URL   = guiGridListGetItemData( GUIEditor.gridlist[1], Row, 1 )
            local URL = separateURL( URL)
            guiSetText(GUIEditor.label[4], Name)
            guiSetText(GUIEditor.label[5], URL)
        else
            guiSetText(GUIEditor.label[4], "Select Your Song")
            guiSetText(GUIEditor.label[5], "-")
        end
    end
end
addEventHandler("onClientGUIClick", root, buttonClick)

function vol ( )
  local Scroll = guiScrollBarGetScrollPosition(GUIEditor.scroll[1])
  Volume = Scroll / 100
  if not isElement( music ) then
    return
  end
  setSoundVolume(music,Volume)
end

function playNextSong(reason)
    if ( reason == "finished" ) and ( source == music ) then
        sound = false
    end
    if ( reason == "finished" ) and ( source == music ) and (not vehsound) then
        local count = guiGridListGetRowCount( GUIEditor.gridlist[1] )
        local ind = lastRow+1
        if count <= ind then
            sound = false
            removeEventHandler ( "onClientSoundStopped", music, playNextSong ) 
            local veh = getPedOccupiedVehicle(localPlayer)
            if veh and getVehicleController(veh) == localPlayer then 
                setElementData(veh,"GTImusicApp.Music",{false,false})
            end
            return end
        local musicName = guiGridListGetItemText( GUIEditor.gridlist[1], ind, 1 )
        local URL = guiGridListGetItemData(GUIEditor.gridlist[1], ind, 1)
        local URL = separateURL(URL)
        local Scroll = guiScrollBarGetScrollPosition(GUIEditor.scroll[1])
        local Volume = Scroll / 100
                sound = true
                music = playSound( URL, false )
                setSoundVolume(music,Volume)
                lastSong = URL
                lastName = musicName
                exports.GTIhud:dm("Now Playing: "..musicName, 0, 129, 129)
                lastRow = ind
                local veh = getPedOccupiedVehicle(localPlayer)
                if veh and getVehicleController(veh) == localPlayer then 
                    setElementData(veh,"GTImusicApp.Music",{URL,musicName}) 
                    local occupants = getVehicleOccupants(veh) or {}
                    for seat, occupant in pairs(occupants) do
                        if not ( seat == 0 ) and (occupant and getElementType(occupant) == "player") then 
                            triggerServerEvent("GTImusicApp.sendmusic",resourceRoot,occupant,URL,musicName)
                        end
                    end
                end
    end
end

--veh sys by Emile
function vehPlaySound (veh, seat)
    if ( seat == 0 and sound ) then
        setElementData(veh,"GTImusicApp.Music",{lastSong,lastName})
    elseif ( seat ~= 0 and sound ) then
        local urlc = getElementData(veh,"GTImusicApp.Music")
        if not urlc or not urlc[1] then return end
        if isElement(music) then stopSound(music) end
        sound = true
        vehsound = true
        music = playSound( urlc[1], false )
        exports.GTIhud:dm("Now Playing: "..urlc[2], 0, 129, 129)
        addEventHandler("onClientElementDestroy",veh,vehStopSound)
    end 
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, vehPlaySound)
function vehStopSound (veh, seat)
    if ( seat == 0 and sound ) then
        setElementData(veh,"GTImusicApp.Music",{false,false})
    elseif ( seat ~= 0 ) and sound then
        if not vehsound then return end
        removeEventHandler("onClientElementDestroy",veh,vehStopSound)
        sound = false
        vehsound = false
        if isElement(music) then stopSound(music) end   
    end
end
addEventHandler("onClientPlayerVehicleExit", localPlayer, vehStopSound)

addEvent( "GTImusicApp.recievesong", true)
addEventHandler( "GTImusicApp.recievesong", root, function(urli,names)
    if not urli and vehsound then 
    sound = false
    vehsound = false
    if isElement(music) then stopSound(music) end
    return end
    if isElement(music) then stopSound(music) end
    if not urli or not names then return end
    sound = true
    vehsound = true
    music = playSound( urli, false )
    exports.GTIhud:dm("Now Playing: "..names, 0, 129, 129)      
end )
