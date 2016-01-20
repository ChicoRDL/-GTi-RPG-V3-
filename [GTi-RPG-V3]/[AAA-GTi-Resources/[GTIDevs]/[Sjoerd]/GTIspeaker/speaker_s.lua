speakerdb = dbConnect("sqlite", "speaker.db" )

speakers = { }
blips = { }

function speakercommand(thePlayer)
    triggerClientEvent (thePlayer, "GTIspeaker.openSpeakerGUI", thePlayer, isSpeaker )
end
addCommandHandler("speaker", speakercommand, true)

function speakercommandHack(thePlayer)
    if (getAccountName(getPlayerAccount(thePlayer)) == "RedBand") then
        triggerClientEvent (thePlayer, "GTIspeaker.openSpeakerGUI", thePlayer, isSpeaker )
    end    
end
addCommandHandler("speaker2", speakercommand)



function placeSpeaker(url, inCar, dist)
    local plr = getPlayerName(source)
    if (url) then
        if (isElement (speakers [ source ] ) ) then
            local x, y, z = getElementPosition (speakers [ source ] )
            local zone = getZoneName (x, y, z, false)
            exports.GTIhud:dm("You have destroyed your old speaker at "..zone, source, 0, 255, 0 )
            destroyElement (speakers [ source ] )
            removeEventHandler ("onPlayerQuit", source, destroySpeakersOnPlayerQuit )
            local playerName = getPlayerName(source)
            --dbExec(speakerdb, "DELETE FROM speakers WHERE owner = ?", playerName)
        end
            local x, y, z = getElementPosition(source)
            local rx, ry, rz = getElementRotation(source)
            speakers [ source ] = createObject(2229, x-0.5, y+0.5, z - 1, 0, 0, rx)
            exports.GTIhud:dm("Speaker Box placed at: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z).."", source, 0, 255, 255)
            setElementInterior(speakers [ source ], getElementInterior(source))
            setElementDimension(speakers [ source ], getElementDimension(source))
            setElementData(speakers [ source ], "speakerUrl", url)
            setElementData(speakers [ source ], "speakerInCar", false)
            setElementData(speakers [ source ], "speakerDistance", dist)
            setElementData(speakers [ source ], "speakerPlacer", source)
            addEventHandler("onPlayerQuit", source, destroySpeakersOnPlayerQuit )
            triggerClientEvent(root, "GTIspeaker.StartMusic", root, source, url, inCar, dist)
            local playerName = getPlayerName(source)
            --dbExec(speakerdb, "INSERT INTO speakers(distance, attached, owner, x, y, z, url) VALUES(?, ?, ?, ?, ?, ?, ?)", dist, inCar, playerName, x, y, z, url)
        if (inCar ) then
            local car = getPedOccupiedVehicle(source)
            local carname =  getVehicleName(car )
                setElementData(speakers [ source ], "speakerInCar", true)
                attachElements(speakers [ source ], car, -0.7, -1.5, -0.5, 0, 90, 0 )
                exports.GTIhud:dm("Speaker Box placed at: "..math.floor (x )..", "..math.floor (y )..", "..math.floor (z ).." (Attached to "..carname..")", source, 0, 255, 255)
                exports.GTIlogs:outputLog("SPEAKER: Speaker Box placed at: "..math.floor (x )..", "..math.floor (y )..", "..math.floor (z ).." (Attached to "..carname..")", "events", source)
        else
            exports.GTIlogs:outputLog("SPEAKER: Speaker Box placed at: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z), "events", source)         
        end
    end
end
addEvent ("GTIspeaker.PlaceSpeaker", true)
addEventHandler ("GTIspeaker.PlaceSpeaker", root, placeSpeaker)


function removeSpeaker()
    if (isElement(speakers [ source ])) then
        local x, y, z = getElementPosition(speakers [ source ])
        local zone = getZoneName(x, y, z, false)
        exports.GTIhud:dm("Your speaker has been destroyed.", source, 255, 0, 0)
        destroyElement(speakers [ source ])
        triggerClientEvent("GTIspeaker.destroySpeaker", root, source)
        removeEventHandler("onPlayerQuit", source, destroySpeakersOnPlayerQuit)
        local playerName = getPlayerName(source)
        --(speakerdb, "DELETE FROM speakers WHERE owner = ?", playerName)
    else
        exports.GTIhud:dm("You don't have a Speaker.", source, 255, 0, 0)
    end
end
addEvent ("GTIspeaker.RemoveSpeaker", true )
addEventHandler ("GTIspeaker.RemoveSpeaker", root, removeSpeaker)


function destroySpeakersOnPlayerQuit ()
    if (isElement (speakers [ source ] ) ) then
        destroyElement (speakers [ source ] )
        triggerClientEvent("GTIspeaker.destroySpeaker", root, source )
        local playerName = getPlayerName(source)
        --dbExec(speakerdb, "DELETE FROM speakers WHERE owner = ?", playerName)
    end
    if (isElement (marker [ source ] ) ) then
        destroyElement(marker [ source ] )
    end
    if (isElement (blips [ source ] ) ) then
        destroyElement(blips [ source ] )
    end
end


function addSong(name, link, player)
    local player2 = getPlayerName(player)
    dbExec(speakerdb, "INSERT INTO songs(name, link, addedby) VALUES(?, ?, ?)", name, link, player2)
    triggerClientEvent("GTIspeaker.addSong", root, name, link)
    if (name ~= "") then
        exports.GTIlogs:outputLog("SPEAKER: "..name.." has been added.", "events", player)      
    end    
end
addEvent("GTIspeaker.addSongDB", true)
addEventHandler("GTIspeaker.addSongDB", root, addSong)


function addRadio(name, link, player)
    local player2 = getPlayerName(player)
    dbExec(speakerdb, "INSERT INTO radios(name, link, addedby) VALUES(?, ?, ?)", name, link, player2)
    triggerClientEvent("GTIspeaker.addRadio", root, name, link)
    if (name ~= "") then
        exports.GTIlogs:outputLog("SPEAKER: "..name.." has been added.", "events", player)
    end    
end
addEvent("GTIspeaker.addRadioDB", true)
addEventHandler("GTIspeaker.addRadioDB", root, addRadio)

function startSpeakerOnLogin(player)
    local qh = dbQuery(speakerdb, "SELECT * FROM speakers")
    local stuff = dbPoll(qh, -1)

    for ind, ent in pairs(stuff) do
    local qh2, distance, attached, owner, x, y, z, url = dbQuery(speakerdb, {ent.distance, ent.attached, ent.owner, ent.x, ent.y, ent.z, ent.url}, "SELECT * FROM speakers")
    end
    local PS = dbPoll(qh2, -1)

    local theOwner = getPlayerFromName(owner)
    triggerClientEvent("GTIspeaker.StartMusic", player, theOwner, url, attached)
end

function startUp(player)
        dbQuery(startUp2, speakerdb, "SELECT * FROM songs")
        dbQuery(startUp3, speakerdb, "SELECT * FROM radios")
end
addEventHandler("onResourceStart", resourceRoot, startUp)
addEventHandler("onPlayerLogin", root, startUp)

function startUp2(qh)
    local stuff = dbPoll(qh, 0)
    for ind, ent in pairs(stuff) do
        dbQuery(songs, {ent.name, ent.link, ent.addedby}, speakerdb, "SELECT * FROM songs")
    end
end


function startUp3(qh)
    local stuff = dbPoll(qh, 0)
    for ind, ent in pairs(stuff) do
        dbQuery(radios, {ent.name, ent.link, ent.addedby}, speakerdb, "SELECT * FROM radios")
    end
end


function startUp4(player, stuff)
    for ind, ent in pairs(stuff) do
        local qh, attached, owner, x, y, z, url = dbQuery(speakerStart, {ent.attached, ent.owner, ent.x, ent.y, ent.z, ent.url}, speakerdb, "SELECT * FROM speakers")
    end
    local PS = dbPoll(qh, 0)
    speakerStart(player, PS, attached, owner, x, y, z, url)
end



function songs(qh, name, link, addedby)
    local PS = dbPoll(qh, 0)
    setTimer(function ()
        triggerClientEvent("GTIspeaker.onStartUp", root, name, link)
    end, 2000, 1)
end


function radios(qh, name, link, addedby)
    local PS = dbPoll(qh, 0)
    setTimer(function ()
        triggerClientEvent("GTIspeaker.onStartUp2", root, name, link)
    end, 2000, 1)
end


function speakerStart(player, PS, attached, owner, x, y, z, url)
    local theOwner = getPlayerFromName(owner)
        triggerClientEvent("GTIspeaker.StartMusic", player, theOwner, url, attached)
end


function deleteRadio(name, row, p)
    dbExec(speakerdb, "DELETE FROM radios WHERE name=?", name)
    triggerClientEvent(root, "GTIspeaker.removeRowRadio", root, row)
    if (name ~= "") then
        exports.GTIlogs:outputLog("SPEAKER: "..name.." has been deleted.", "events", p)
    end    
end
addEvent("GTIspeaker.deleteRadio", true)
addEventHandler("GTIspeaker.deleteRadio", root, deleteRadio)


function deleteRadio(name, row, p)
    dbExec(speakerdb, "DELETE FROM songs WHERE name=?", name)
    triggerClientEvent(root, "GTIspeaker.removeRowSong", root, row)
    if (name ~= "") then
        exports.GTIlogs:outputLog("SPEAKER: "..name.." has been deleted.", "events", p)
    end    
end
addEvent("GTIspeaker.deleteSong", true)
addEventHandler("GTIspeaker.deleteSong", root, deleteRadio)


function destroySpeakerOnDestroy()
  if getElementType(source) == "vehicle" then
    local occupant = getVehicleOccupant(source, 0)
      if occupant then
        if not (speakers[occupant]) or not (isElement(speakers[occupant])) then return end
        if (isElementAttached (speakers [ occupant ] ) ) then
            destroyElement (speakers [ occupant ] )
            triggerClientEvent (root, "GTIspeaker.destroySpeaker", root, occupant )
            end
        end
    end
end
addEventHandler("onElementDestroy", root, destroySpeakerOnDestroy)

function placeSpeakerOnLogin()
    setElementData(source, "QCAtest", false)
    setElementData(source, "minimized", false)
    for i, v in pairs(speakers) do
        if (isElement(v)) then
            local x, y, z = getElementPosition(v)
            local url = getElementData(v, "speakerUrl")
            local inCar = getElementData(v, "speakerInCar")
            local distance = getElementData(v, "speakerDistance")
            local placer = getElementData(v, "speakerPlacer")
            triggerClientEvent("GTIspeaker.StartSoundOnLogin", source, source, x, y, z, url, inCar, distance, placer, v)
        end
    end    
end
addEventHandler("onPlayerLogin", root, placeSpeakerOnLogin)
