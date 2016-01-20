eventBlips = false
-------------------------------
-- Full code of the Main Window
-------------------------------
        mainWindow = exports.GTIgui:createWindow(725, 319, 418, 298, "GTI -|- Speaker", false)
        CurrentSpeaker = guiCreateLabel(11, 35, 220, 15, "Current Status: -", false, mainWindow)
        exports.GTIgui:setDefaultFont(CurrentSpeaker, 10)
        ---volume = guiCreateLabel(10, 55, 130, 15, "Volume: -", false, mainWindow)
                ---exports.GTIgui:setDefaultFont(volume, 8)
        pos = guiCreateLabel(10, 273, 220, 15, "Coordinates: X, Y, Z", false, mainWindow)
        exports.GTIgui:setDefaultFont(pos, 8)
        label = guiCreateLabel(10, 98, 30, 15, "URL:", false, mainWindow)
        exports.GTIgui:setDefaultFont(label, 8)
        guiLabelSetColor(label, 17, 155, 0)
        url = guiCreateEdit(45, 94, 326, 23, "", false, mainWindow)
        exports.GTIgui:setDefaultFont(url, 10)
        placeSp = guiCreateButton(55, 139, 121, 24, "Place a Speaker!", false, mainWindow)
        exports.GTIgui:setDefaultFont(placeSp, 10)
        guiSetProperty(placeSp, "NormalTextColour", "FF9D17A2")
        guiSetAlpha(placeSp, 0.80)
        removeSp = guiCreateButton(240, 139, 121, 24, "Remove Speaker!", false, mainWindow)
        exports.GTIgui:setDefaultFont(removeSp, 10)
        guiSetAlpha(removeSp, 0.80)
        exports.GTIgui:setDefaultFont(removeSp, 10)
        guiSetProperty(removeSp, "NormalTextColour", "FFDB2FE1")
        --inVolume = guiCreateLabel(166, 190, 84, 24, "Volume +", false, mainWindow)
        --guiSetAlpha(inVolume, 0.80)
        --guiSetProperty(inVolume, "NormalTextColour", "FE17C700")
        --deVolume = guiCreateLabel(166, 224, 84, 24, " Volume -", false, mainWindow)
        --guiSetAlpha(deVolume, 0.80)
        --exports.GTIgui:setDefaultFont(deVolume, 10)
        SpeakerPlaylist = guiCreateButton(295, 194, 83, 49, "Speaker Playlist", false, mainWindow)
        guiSetAlpha(SpeakerPlaylist, 0.57)
        exports.GTIgui:setDefaultFont(SpeakerPlaylist, 10)
        guiSetProperty(SpeakerPlaylist, "NormalTextColour", "FF4BBF12")
        distanceSettings = guiCreateLabel(28, 185, 115, 29, "Set Max Distance", false, mainWindow)
        exports.GTIgui:setDefaultFont(distanceSettings, 10)
        guiLabelSetColor(distanceSettings, 231, 229, 27)
        closebtn = guiCreateLabel(368, 269, 35, 19, "Close", false, mainWindow)
        exports.GTIgui:setDefaultFont(closebtn, 9)  
                guiLabelSetColor(closebtn, 255, 0, 0)        
                guiSetVisible(mainWindow, false)
-----------------------------------------
-- Full code of the Sound Distance Window
-----------------------------------------
        disWindow = exports.GTIgui:createWindow(221, 163, 363, 126, "Set Max Distance", false)
        disLabelll = guiCreateLabel(25, 27, 315, 20, "Enter sound distance value between 10 and 2500", false, disWindow)
        exports.GTIgui:setDefaultFont(disLabelll, 10)
        guiLabelSetColor(disLabelll, 255, 0, 0)
        disField = guiCreateEdit(180, 72, 89, 34, "10", false, disWindow)
        exports.GTIgui:setDefaultFont(disField, 10)
        guiEditSetMaxLength(disField, 4)
        cancelDis = guiCreateButton(291, 90, 62, 26, "Ok", false, disWindow)
        guiSetProperty(cancelDis, "NormalTextColour", "FFAAAAAA")
        exports.GTIgui:setDefaultFont(cancelDis, 10)
        currentDisStatus = guiCreateLabel(20, 80, 134, 19, "* Current Distance: --", false, disWindow)
        exports.GTIgui:setDefaultFont(currentDisStatus, 10)
        guiSetVisible(disWindow, false)
-----------------------------------------
-- Playlist Window
-----------------------------------------
        playlistWindow = exports.GTIgui:createWindow(233, 154, 805, 428, "Speaker Playlist Window", false)
        songGrid = guiCreateGridList(10, 36, 362, 246, false, playlistWindow)
        guiSetAlpha(songGrid, 0.80)
        exports.GTIgui:setDefaultFont(songGrid, 10)
                guiGridListSetSortingEnabled(songGrid, false)          
        radioGrid = guiCreateGridList(444, 36, 351, 246, false, playlistWindow)
        guiSetAlpha(radioGrid, 0.80)
        exports.GTIgui:setDefaultFont(radioGrid, 10)
                guiGridListSetSortingEnabled(radioGrid, false)
        CloseplaylistWindow = guiCreateLabel(763, 408, 35, 15, "Close", false, playlistWindow)
        exports.GTIgui:setDefaultFont(CloseplaylistWindow, 9)
                guiLabelSetColor(CloseplaylistWindow, 255, 0, 0)               
        nameLabel = guiCreateLabel(7, 293, 98, 16, " Name:", false, playlistWindow)
        exports.GTIgui:setDefaultFont(nameLabel, 10)
        guiLabelSetColor(nameLabel, 44, 159, 18)
        nameEdit = guiCreateEdit(9, 310, 353, 23, "", false, playlistWindow)
        exports.GTIgui:setDefaultFont(nameEdit, 10)            
        linkLabel = guiCreateLabel(7, 338, 110, 16, "Add your Link:", false, playlistWindow)
        exports.GTIgui:setDefaultFont(linkLabel, 10)
        guiLabelSetColor(linkLabel, 44, 159, 18)
        linkEdit = guiCreateEdit(10, 354, 353, 23, "", false, playlistWindow)
        exports.GTIgui:setDefaultFont(linkEdit, 10)            
        songButton = guiCreateButton(18, 387, 100, 23, "Save Music", false, playlistWindow)
        exports.GTIgui:setDefaultFont(songButton, 10)
        DeleteButton = guiCreateButton(128, 387, 100, 23, "Delete", false, playlistWindow)
        exports.GTIgui:setDefaultFont(DeleteButton, 10)
        radioButton = guiCreateButton(238, 387, 100, 23, "Save Radio", false, playlistWindow)
        exports.GTIgui:setDefaultFont(radioButton, 10)
        InformationText = guiCreateLabel(444, 292, 351, 95, "This window allows you to save your favorite radios/songs.\nYou can save .pls links & .mp3 links.\nUse dropbox for your own .mp3 links.\nYou will not see the links on the list because it's annoying", false, playlistWindow)
        guiSetAlpha(InformationText, 0.83)
        guiLabelSetColor(InformationText, 225, 125, 25)
        exports.GTIgui:setDefaultFont(InformationText, 8)
                songColumn = guiGridListAddColumn(songGrid, "Songs", 1)
        sLinkColumn = guiGridListAddColumn(songGrid, "Link", 0.5)
        radioColumn = guiGridListAddColumn(radioGrid, "Radios", 1)
        rLinkColumn = guiGridListAddColumn(radioGrid, "Link", 0.5)
        guiSetVisible(playlistWindow, false)
 
        
        local resX, resY = guiGetScreenSize()
function renderTesting()
    for i, v in pairs(SoundS) do 
        if (isElement(v)) then
            if (isElementAttached(v)) then return end
            local x, y, z = getElementPosition( v )
            local a, b, c = getElementPosition( localPlayer )
            local dist = getDistanceBetweenPoints3D( x, y , z, a, b, c )
            if ( dist < 30) then
                local tX, tY = getScreenFromWorldPosition( x, y, z+1.4, 0, false )
                if ( tX and tY and isLineOfSightClear( a, b, c, x, y, z, true, false, false, true, true, false, false, v ) ) then
                       local meta = getSoundMetaTags(v)
                        if ((meta.stream_title)) then
                            local width = dxGetTextWidth( (meta.stream_title), 1.5, "arial" )
                            dxDrawRectangle (tX-( width-100), tY, width, 25, tocolor ( 0, 0, 0, 100 ))
                            dxDrawText( (meta.stream_title), tX-( width-100), tY, resX, resY, tocolor( 255, 255, 255, 255 ), 1.5, "arial")
                        else 
                            local width = dxGetTextWidth( "Unknown", 1.5, "arial" )
                            dxDrawRectangle (tX-( width-100), tY, width, 25, tocolor ( 0, 0, 0, 100 ))
                            dxDrawText( "Unknown", tX-( width-100), tY, resX, resY, tocolor( 255, 255, 255, 255 ), 1.5, "arial")
                    end     
                end
            end
        end
    end
end
addEventHandler ( "onClientRender", root, renderTesting )
-------------------------
-- Label's Colour Effects
-------------------------
addEventHandler( "onClientMouseEnter", root,
    function()
        if (source == closebtn) then
           guiLabelSetColor( source, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        elseif (source == CloseplaylistWindow) then
           guiLabelSetColor( source, 255, 255, 0)
           --elseif (source == deVolume) then
           --guiLabelSetColor( source,  255, 255, 0)
        elseif (source == distanceSettings) then
            guiLabelSetColor( source, 255, 255, 0)
        end
    end
)

addEventHandler( "onClientMouseLeave", root,
    function()
        if (source == closebtn) then
            guiLabelSetColor( source, 255, 255, 255)
        elseif (source == CloseplaylistWindow) then
           guiLabelSetColor( source, 255, 255, 255)
        elseif (source == distanceSettings) then
            guiLabelSetColor( source, 255, 255, 255)
        end
    end
)


local sound = false
function openGUI( speaker )
    local state = not guiGetVisible(mainWindow)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(mainWindow, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetVisible(mainWindow, state)
    guiSetPosition(mainWindow, x, y, false)
    showCursor(state)
    centerWindow(mainWindow)
    if (state == true) then
        guiSetInputMode("no_binds_when_editing")
        if (speaker) then
            if (isElement(SoundS [ localPlayer ])) then
                local x, y, z = getElementPosition(SoundS [ localPlayer ])
                guiSetText(pos, "Coordinates: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z))
                guiSetText(CurrentSpeaker, "Current Status: Placed!") sound = true
            else 
                guiSetText (CurrentSpeaker, "You currently don't have a speaker.") sound = false
            end    
        else
            if (isElement(SoundS [ localPlayer ])) then
                local x, y, z = getElementPosition(SoundS [ localPlayer ])
                guiSetText(pos, "Coordinates: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z))
                guiSetText(CurrentSpeaker, "Current Status: Placed!") sound = true
            else 
                guiSetText (CurrentSpeaker, "You currently don't have a speaker.") sound = false
            end
        end
    end
end
addEvent ("GTIspeaker.openSpeakerGUI", true)
addEventHandler ("GTIspeaker.openSpeakerGUI", root, openGUI)

function buttonHandling()
    if (source == closebtn) then
        guiSetVisible(mainWindow, false)
        showCursor(false)
    elseif (source == placeSp) then
        local text = guiGetText(url)
        local dist = guiGetText(disField)
        if (tonumber(dist) > 500 and getElementDimension(localPlayer) == 0) then exports.GTIhud:dm("Distance can't be higher then 500 in main dimension.", 255, 0, 0) return end
        if (text ~= "") then
        triggerServerEvent("GTIspeaker.PlaceSpeaker", localPlayer, guiGetText (url), isPedInVehicle (localPlayer), dist)
        guiSetText(CurrentSpeaker, "Current Status: Placed!")
        sound = true
        else
            exports.GTIhud:dm("You have to enter an URL first.", 255, 0, 0)
        end
    elseif (source == eventBlip) then
            triggerServerEvent("GTIspeaker.placeBlip", localPayer)
    elseif (source == removeSp) then
        triggerServerEvent("GTIspeaker.RemoveSpeaker", localPlayer)
        guiSetText(CurrentSpeaker, "You currently don't have a speaker.")
        sound = false
    elseif (source == SpeakerPlaylist) then
        guiSetVisible(mainWindow, false)
        guiSetVisible(playlistWindow, true)
        centerWindow(playlistWindow)
    elseif (source == songButton) then
        triggerServerEvent("GTIspeaker.addSongDB", localPlayer, guiGetText(nameEdit), guiGetText(linkEdit), localPlayer)
    elseif (source == radioButton) then
        triggerServerEvent("GTIspeaker.addRadioDB", localPlayer, guiGetText(nameEdit), guiGetText(linkEdit), localPlayer)
    end
end
addEventHandler("onClientGUIClick", root, buttonHandling)

SoundS = { }

function startSound(placer, url, inCar, text)
    local block = getElementData(localPlayer, "blockSpeaker")
    if (block) then return end                   
    if (isElement(SoundS [ placer ])) then
        destroyElement(SoundS [ placer ])
    end
    if (inCar) then
        local x, y, z = getElementPosition(placer)
        SoundS [ placer ]  = playSound3D(url, x, y, z, true)
        setSoundVolume(SoundS [ placer ] , 1 )
        setSoundMinDistance(SoundS [ placer ] , 10)
        if (text == "") then
            setSoundMaxDistance(SoundS [ placer ], 100)
        else
            setSoundMaxDistance(SoundS [ placer ], text)
        end

    
        local int = getElementInterior ( placer )
        setElementInterior ( SoundS [ placer ] , int )
        setElementDimension ( SoundS [ placer ] , getElementDimension ( placer ) )
        if ( inCar ) then
            local vehicle = getPedOccupiedVehicle(placer) 
            attachElements ( SoundS [ placer ] , vehicle, 0, 5, 1 )   
        end    
    else    
        local x, y, z = getElementPosition(placer)
        SoundS [ placer ]  = playSound3D(url, x, y, z, true)
        setSoundVolume(SoundS [ placer ] , 1 )
        setSoundMinDistance(SoundS [ placer ] , 10)
        if (text == "") then
            setSoundMaxDistance(SoundS [ placer ], 100)
        else
            setSoundMaxDistance(SoundS [ placer ], text)
        end

        local int = getElementInterior(placer)
        setElementInterior(SoundS [ placer ], int)
        setElementDimension(SoundS [ placer ], getElementDimension(placer))
    end       
end
addEvent("GTIspeaker.StartMusic", true)
addEventHandler("GTIspeaker.StartMusic", root, startSound)

function destroySpeaker(who)  
    if (isElement(SoundS [ who ])) then
        destroyElement(SoundS [ who ])
    end
end
addEvent("GTIspeaker.destroySpeaker", true)
addEventHandler( "GTIspeaker.destroySpeaker", root, destroySpeaker)

function placers()
    for i, v in pairs(SoundS) do
        outputDebugString(getPlayerName(i))
    end    
end  
addCommandHandler("placers", placers)

function disableSpeakerSound()
    for i, sound in pairs ( SoundS ) do
        stopSound( sound )
        setElementData(localPlayer, "blockSpeaker", true)
    end    
end
addCommandHandler ( "stopsound", disableSpeakerSound )

function disableBlock()
    setElementData(localPlayer, "blockSpeaker", false)
end
addCommandHandler("enablesound", disableBlock)    


function isURL ( )
        if ( guiGetText ( url ) ~= "" ) then
            return true
        else
            return false
        end
    end


--ChicRDL:
addEventHandler("onClientGUIClick", root,
function (who)
    if (source == distanceSettings) then
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(mainWindow, false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetVisible(mainWindow, false)
        guiSetVisible(disWindow, true)
        showCursor(true)
        guiSetPosition(disWindow, x, y, false)
    elseif (source == cancelDis) then
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(mainWindow, false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetVisible(disWindow, false)
        guiSetVisible(mainWindow, true)
        guiSetPosition(mainWindow, x, y, false)
    elseif (source == CloseplaylistWindow) then
        guiSetVisible(playlistWindow, false)
        guiSetVisible(mainWindow, true)
        centerWindow(mainWindow)
    --elseif (source == setDis) then
        --local text = guiGetText(disField)
        --setSoundMaxDistance(speakerSound [ who ], "..text..")
        --exports.GTIhud:dm("You've successfully set the Max Distance to "..text.."!", 255, 255, 0)
    end
end)

--SQL stuff

function addSongs(name, link)
    local row = guiGridListAddRow(songGrid)
    guiGridListSetItemText(songGrid, row, songColumn, name, false, false)
    guiGridListSetItemText(songGrid, row, sLinkColumn, link, false, false)
end
addEvent("GTIspeaker.addSong", true)
addEventHandler("GTIspeaker.addSong", root, addSongs)

function addRadios(name, link)
    local row = guiGridListAddRow(radioGrid)
    guiGridListSetItemText(radioGrid, row, radioColumn, name, false, false)
    guiGridListSetItemText(radioGrid, row, rLinkColumn, link, false, false)
end
addEvent("GTIspeaker.addRadio", true)
addEventHandler("GTIspeaker.addRadio", root, addRadios)

function getSongLink()
    local link = guiGridListGetItemText(songGrid, guiGridListGetSelectedItem(songGrid), sLinkColumn)
    guiSetText(url, link)
    guiSetVisible(playlistWindow, false)
    guiSetVisible(mainWindow, true)
end
addEventHandler("onClientGUIDoubleClick", songGrid, getSongLink)

function getRadioLink()
    local link = guiGridListGetItemText(radioGrid, guiGridListGetSelectedItem(radioGrid), rLinkColumn)
    guiSetText(url, link)
    guiSetVisible(playlistWindow, false)
    guiSetVisible(mainWindow, true)
end
addEventHandler("onClientGUIDoubleClick", radioGrid, getRadioLink)

function deleteRadio()
    local row = guiGridListGetSelectedItem(radioGrid)
    local name = guiGridListGetItemText(radioGrid, guiGridListGetSelectedItem(radioGrid), radioColumn)
    triggerServerEvent("GTIspeaker.deleteRadio", localPlayer, name, row, localPlayer)
end
addEventHandler("onClientGUIClick", DeleteButton, deleteRadio)

function deleteSong()
    local row = guiGridListGetSelectedItem(songGrid)
    local name = guiGridListGetItemText(songGrid, row, songColumn)
    triggerServerEvent("GTIspeaker.deleteSong", localPlayer, name, row, localPlayer)
end
addEventHandler("onClientGUIClick", DeleteButton, deleteSong)

function removeRowSong(row)
    if (row) then
        guiGridListRemoveRow(songGrid, row)
    end
end
addEvent("GTIspeaker.removeRowSong", true)
addEventHandler("GTIspeaker.removeRowSong", root, removeRowSong)

function removeRowRadio(row)
    if (row) then
        guiGridListRemoveRow(radioGrid, row)
    end
end
addEvent("GTIspeaker.removeRowRadio", true)
addEventHandler("GTIspeaker.removeRowRadio", root, removeRowRadio)

function onStartUp(name, link)
    guiGridListClear(songGrid)
    setTimer ( function()
    local row = guiGridListAddRow(songGrid)
    guiGridListSetItemText(songGrid, row, songColumn, name, false, false)
    guiGridListSetItemText(songGrid, row, sLinkColumn, link, false, false)
    end, 50, 1 )
end
addEvent("GTIspeaker.onStartUp", true)
addEventHandler("GTIspeaker.onStartUp", root, onStartUp)

function onStartUp2(name, link)
    guiGridListClear(radioGrid)
    setTimer ( function()
    local row = guiGridListAddRow(radioGrid)
    guiGridListSetItemText(radioGrid, row, radioColumn, name, false, false)
    guiGridListSetItemText(radioGrid, row, rLinkColumn, link, false, false)
    end, 50, 1 )
end
addEvent("GTIspeaker.onStartUp2", true)
addEventHandler("GTIspeaker.onStartUp2", root, onStartUp2)

function centerWindow(element)
    --Check if our element exists before we bother doing anything
    if (element) and (isElement(element)) then
        --Check if it's a GUI element
        if not (string.find(getElementType(element),"gui")) then
            return
        end

        local x,y = guiGetSize(element,false)
        local rX,rY = guiGetScreenSize()
        local X,Y = (rX/2) - (x/2),(rY/2) - (y/2)
        guiSetPosition(element,X,Y,false)
        return true
    end
    return true  
end

function startSpeakerOnLogin(thePlayer, x, y, z, url, inCar, text, placer, speaker)
    if (thePlayer == localPlayer) then
        SoundS [ placer ]  = playSound3D(url, x, y, z, true)
        setSoundVolume(SoundS [ placer ] , 1 )
        setSoundMinDistance(SoundS [ placer ] , 10)
        if (text == "") then
            setSoundMaxDistance(SoundS [ placer ], 100)
        else
            setSoundMaxDistance(SoundS [ placer ], text)
        end

        local int = getElementInterior(speaker)
        setElementInterior(SoundS [ placer ], int)
        setElementDimension(SoundS [ placer ], getElementDimension(speaker))
        if ( inCar ) then
            local vehicle = getPedOccupiedVehicle(placer) 
            attachElements ( SoundS [ placer ] , vehicle, 0, 5, 1 )
        end 
    end
end    
addEvent("GTIspeaker.StartSoundOnLogin", true)
addEventHandler("GTIspeaker.StartSoundOnLogin", localPlayer, startSpeakerOnLogin)            
