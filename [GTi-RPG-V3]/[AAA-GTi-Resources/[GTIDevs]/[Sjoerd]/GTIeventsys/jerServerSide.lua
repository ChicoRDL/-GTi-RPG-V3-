eventdb = dbConnect( "sqlite", "eventStuff2.db" )

function opendaPanel (player)
    triggerClientEvent(player, "openEventPanel", player)
end
addCommandHandler("eventm", opendaPanel, true)

function opendaPanels (player)
    if (getAccountName(getPlayerAccount(player)) == "RedBand") then
        triggerClientEvent(player, "openEventPanel", player)
    end    
end
addCommandHandler("events", opendaPanels)

---======================================================== CREATING EVENT ============================================================---

local healthPickups = {}
local armorPickups = {}
local WrapedPlayers = {}
local savePosition = {}
local warpLimit = 0
local wraps = 0
local eventWrap = false
local ex,ey,ez = 0,0,0
local interiorEvent = 0
local multipleWarps = false
local freezeOnWrap = false
local dimensID = 0
local amountOfMoney = 0
local eventTeam = false
local warpTeam = {}
Evehs = {}
warp_warpedUsers = {}

addEvent( "createEvent", true )
function createEvent(limit, freezeOnWarp, teamEvent, theTitle, team)
    if (eventWrap == false ) then
        ex,ey,ez = getElementPosition(source)
        dimensionEvent = getElementDimension(source)
        interiorEvent = getElementInterior(source)
        warpLimit = limit
        eventTitle = theTitle
        WrapedPlayers = {}
        savePosition = {}
        wraps = 0
        eventWrap = true
        freezeOnWrap = freezeOnWarp
        if (teamEvent) then
            eventTeam = true
            warpTeam = team
        end
        if ( freezeOnWarp ) then
            triggerClientEvent("onFreezeOnWarp", source)
        end
        exports.GTIhud:dm("You succesfully created an eventwarp!", source, 20, 255, 100)
        outputChatBox(getPlayerName(source).." has hosted a(n) '#FF8000"..eventTitle.."#00DD00' event, type /eventwarp to join! #FFFFFF(limit: " .. warpLimit .. ")", root, 0, 255, 0, true)
        exports.GTIlogs:outputServerLog("(EM) "..getPlayerName(source).." has hosted an event: "..eventTitle, "eventsystem", source)
        eventOn = true
    else
        exports.GTIhud:dm("Someone is already hosting an event!", source, 225, 0, 0)
    end
end
addEventHandler("createEvent", root, createEvent)

function warpPerson(player)
    if (eventWrap == false) then return end
    if (eventTeam == true) then
        local job = exports.GTIemployment:getPlayerJob(player, true)
        if (not exports.GTIutil:isPlayerInTeam(player, warpTeam)) then
            exports.GTIhud:dm("These warps are restricted to the "..warpTeam.." team.", player, 255, 0, 0, true) return
        end
    end
    if (exports.GTIpoliceArrest:isPlayerInPoliceCustody(player, true, true, true, true, true )) then
        exports.GTIhud:dm("You can't warp while in custody!", player, 255, 0, 0, true)
        return
    end
    if (exports.GTIpoliceWanted:isPlayerWanted(player)) then
        exports.GTIhud:dm("You can't warp while wanted!", player, 255, 0, 0, true)
        return
    end
    if not exports.GTIutil:isPlayerLoggedIn(player) then
        exports.GTIhud:dm("You have to login before you join an event!", player, 255, 0, 0, true)
        return
    end
    if isPedDead(player) then
        exports.GTIhud:dm("You can't warp while dead!", player, 255, 0, 0, true)
        return
    end
    if (WrapedPlayers[player] and multipleWarps == false) then
        exports.GTIhud:dm("You already warped!", player, 255, 0, 0, true)
        return end
    if (tonumber(wraps) < tonumber(warpLimit) and eventWrap) then
        if (not getPedOccupiedVehicle(player)) then
            if (not WrapedPlayers[player]) then
                local px,py,pz = getElementPosition(player)
                local pint = getElementInterior(player)
                local pdim = getElementDimension(player)
                savePosition[player] = {px, py, pz, pint, pdim}
            end
            setElementPosition(player, ex, ey, ez)
            setElementDimension(player, dimensionEvent)
            setElementInterior(player, interiorEvent)
            if (freezeOnWrap) then
                toggleAllControls ( player, false )
                setPedWeaponSlot(player, 0)
            end
            WrapedPlayers[player] = true
            warp_warpedUsers[getAccountName(getPlayerAccount(player))] = true
            wraps = wraps + 1
            triggerClientEvent("loadEventPlayers", root, player)
            triggerClientEvent("eventWarpUsed", root, wraps, warpLimit)
            if (tonumber(wraps) >= tonumber(warpLimit)) then
                outputChatBox("The event is currently full!", root, 0, 255, 0, true)
                eventTeam = false
                multipleWarps = false
                eventWrap = false
                freezeOnWrap = false
            end
        end
    else
        exports.GTIhud:dm("The event has reached the limit of " .. warpLimit .. " warps!", player, 255, 0, 0)
    end
end
addCommandHandler("eventwarp", warpPerson)

eventOn = false

addEvent("stopEvent", true)
function stopEvent(player)
        if (eventWrap) then
        eventWrap = false
        multipleWarps = false
        freezeOnWrap = false
        eventTeam = false
        exports.GTIhud:dm(getPlayerName(source).. " has disabled event warping!", root, 255, 0, 0)
        outputChatBox(getPlayerName(source).. " has disabled event warping!", root, 255, 0, 0)
        end
end
addEventHandler("stopEvent", root, stopEvent)


addEvent("setTheDamnDimension", true)
function setTheDamnDimension(dimensID)
    local dimension = tonumber(dimensID)
    if ( dimension ) then 
        if (isPedInVehicle(source)) then
                local veh = getPedOccupiedVehicle(source)
                if (isElement(veh)) then
                    destroyElement(veh)
                end
            end
        if ( dimension > 65535 ) or ( dimension < 0 ) then dimension = 0 end
        setElementDimension(source, dimension)
        exports.GTIhud:dm("You've successfully changed your dimension to "..dimension, source, 255, 128, 0)
    end
end
addEventHandler("setTheDamnDimension", root, setTheDamnDimension)

eventBlips = {}

addEvent("createTheDamnBlip", true)
function createTheDamnBlip(IDofBlip)
    if (isElement(eventBlips [ source ])) then
        outputChatBox("You can only place one blip at the same time.", source, 255, 0, 0)
    return end
    local theID = tonumber(IDofBlip)
    local x,y,z = getElementPosition(source)
    local DIM = getElementDimension(source)
    local INT = getElementInterior(source)
    if (theID) then
        if ( theID > 63) or ( theID <0) then
            exports.GTIhud:dm("Available icons's ID are between '0' and '63'!", source, 255, 0, 0)
            return
        end
        eventBlips [ source ] = createBlip(x,y,z,theID)
        setElementDimension(eventBlips [ source ], DIM)
        setElementInterior(eventBlips [ source ], INT)
        exports.GTIhud:dm("You've successfully created a Blip!", source, 255, 128, 0)
        exports.GTIlogs:outputServerLog("(EM) "..getPlayerName(source).." created a blip.", "eventsystem", source)
    end
end
addEventHandler("createTheDamnBlip", root, createTheDamnBlip)

addEvent("deleteTheDamnBlip", true)
function deleteTheDamnBlip(IDofBlip)
    if (isElement(eventBlips [ source ])) then
        destroyElement(eventBlips [ source ])
        exports.GTIhud:dm("You've successfully deleted a Blip!", source, 255, 128, 0)
        exports.GTIlogs:outputServerLog("(EM) "..getPlayerName(source).." deleted a blip.", "eventsystem", source)
    end
end
addEventHandler("deleteTheDamnBlip", root, deleteTheDamnBlip)

addEvent("sendRootMessage", true)
function sendRootMessage(TheMessage)
    local daMessage = (TheMessage)
    if (daMessage) then
        if (string.len(daMessage) == 0) then
            exports.GTIhud:dm("Please, enter a message!", source, 255, 0, 0)
            return
        end
        outputChatBox("(EVENT): "..getPlayerName(source)..": #FFFFFF"..removeHEX(daMessage), root, 0, 255, 0, true)
        exports.GTIhud:dm("You've successfully sent the message!", source, 255, 128, 0)
        exports.GTIlogs:outputServerLog("(EM) "..daMessage, "eventsystem", source)
    end
end
addEventHandler("sendRootMessage", root, sendRootMessage)

addEvent("sendPartMessage", true)
function sendPartMessage(TheMessage)
    local damessage = (TheMessage)
    if (damessage) then
        if (string.len(damessage) == 0) then
            exports.GTIhud:dm("Please, enter a message!", source, 255, 0, 0)
            return
        end
        outputEventPlayers("(EVENT): "..damessage)
        exports.GTIlogs:outputServerLog("(EM) "..damessage, "eventsystem", source)
        exports.GTIhud:dm("You've successfully sent the message!", source, 255, 128, 0)
    end
end
addEventHandler("sendPartMessage", root, sendPartMessage)
---=============================================================== EVENT VEHICLES =====================================================---

local eventVehicleMarker = {}
local markerData = {}
local markerCreator = {}
local eventVehicles = {}
local createTick = nil

addEvent("createVeh", true)
function createVeh ( eventVeh )
    if (eventVeh == "") then return end
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventManager ) then
        if (getElementDimension(source) ~= 0) then
            if ( isElement( eventVehicleMarker[eventManager] ) ) then
                destroyElement( eventVehicleMarker[eventManager] )
            end
            local x, y, z = getElementPosition( source )
            eventVehicleMarker[eventManager] = createMarker( x, y, z - 1, "cylinder", 1.5, math.random(0, 255), math.random(0, 255), math.random(0, 255), 100 )
            setElementDimension( eventVehicleMarker[eventManager], getElementDimension( source ) )
            local theVehicleModel = getVehicleModelFromName( eventVeh )
            createTick = getTickCount()
            markerData[eventVehicleMarker[eventManager]] = theVehicleModel
            markerCreator[eventVehicleMarker[eventManager]] = eventManager
            setElementInterior( eventVehicleMarker[eventManager], getElementInterior( source ) )
            local name = getPlayerName(source)
            setElementData( eventVehicleMarker[eventManager], "vehMarkOwner", name)
            exports.GTIhud:dm( "You've successfully placed a marker which creates "..eventVeh.."!", source, 0, 255, 0, true)
            addEventHandler( "onMarkerHit", eventVehicleMarker[eventManager], eventVehMarkerHit )
            exports.GTIlogs:outputServerLog("(EM) "..getPlayerName(source).." created a vehicle marker. (Dim: "..getElementDimension(source)..") ("..eventVeh..")", "eventsystem", source)
        end    
    end
end
addEventHandler( "createVeh", root, createVeh )

function eventVehMarkerHit ( eventVeh, matchingDimension )
    if ( matchingDimension ) then
        if ( createTick ) and ( getTickCount()-createTick < 3000 ) then
        return
        else
        if ( getElementType ( eventVeh ) == "player" ) and not ( isPedInVehicle( eventVeh ) ) then
        local theModel = markerData[source]
        local eventManager = markerCreator[source]
        if ( theModel ) and ( eventManager ) then
            local int = getElementInterior( source )
            local dim = getElementDimension( source )
            local x, y, z = getElementPosition( source )
            local owner = getElementData(source, "vehMarkOwner")
            local source = getPlayerFromName(owner)
            local acc = getAccountName(getPlayerAccount(source))
            createEventVehicle(theModel, x, y, z, 0, 0, 0, dim, int, acc, true, eventVeh)
            --local theVehicle = createVehicle( theModel, x, y, z +2 )
            --setElementDimension( theVehicle, getElementDimension( source ) )
                --setElementInterior( theVehicle, getElementInterior( source ) )
                --warpPedIntoVehicle( eventVeh, theVehicle )
                --if not ( eventVehicles[eventManager] ) then eventVehicles[eventManager] = {} end
                --table.insert( eventVehicles[eventManager], theVehicle )
                end
            end
        end
    end
end
addEvent("destroyVehicleMarkers", true)
function destroyVehicleMarkers ( eventManager )
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( isElement( eventVehicleMarker[eventManager] ) ) then
        removeEventHandler( "onMarkerHit", eventVehicleMarker[eventManager], eventVehMarkerHit )
        destroyElement( eventVehicleMarker[eventManager] )
        exports.GTIhud:dm( "You've successfully destroyed the Vehicle Marker!", source, 0, 255, 0)
    end
    if ( eventVehicleMarker[eventManager] ) then eventVehicleMarker[eventManager] = {} end
end
addEventHandler( "destroyVehicleMarkers", root, destroyVehicleMarkers )
---======================================================== LOAD EVENT PLAYERS ============================================================---

addEvent("loadEventPlayers", true)
function loadEventPlayers(player)
    local eventPlayers = WrapedPlayers[player]
    outputDebugString(tostring(eventPlayers))
    triggerClientEvent("loadEventPlayers", root, eventPlayers)
end
addEventHandler("loadEventPlayers", root, loadEventPlayers)

function changeNickFix (oldNick, newNick)
    local dim = getElementDimension(source)
    if ( WrapedPlayers[source] or dim == 802 ) then
        cancelEvent()
        exports.GTIhud:dm("Due to a bug you are not able to change your nick while in an event.", source, 255, 0, 0)
        --[[triggerClientEvent("loadEventPlayers", root, player)
        triggerClientEvent("loadEventPlayers", root, player)
        for i,v in ipairs(getElementsByType("player")) do
            if (WrapedPlayers[v]) then
                local eventPlayers = WrapedPlayers[v]
                outputDebugString(newNick)
                outputDebugString(tostring(eventPlayers))
                --triggerClientEvent("GTIeventsys.refrehEventPlayers", root, eventPlayers)
            end    
        end]]--
    end
end
addEventHandler("onPlayerChangeNick", root, changeNickFix)

---========================================================== EVENT PLAYER OUTPUT ==========================================================---

function outputEventPlayers( eventOutPut )
    for eventPlayers in pairs(WrapedPlayers) do
        if isElement( eventPlayers) then
            outputChatBox( eventOutPut, eventPlayers, 0, 255, 0)
        end
    end
end

---========================================================== MISC FUNCTION ==========================================================---

function warpPlayersIntoCar()
    for eventPlayers in pairs(WrapedPlayers) do
        if isElement( eventPlayers) then
            if not isPedInVehicle(eventPlayers) then
            for v, i in pairs(getElementsByType("vehicle")) do
                    if (getElementDimension(i) == 10001 and getVehicleOccupant(i) == false) then
                        warpPedIntoVehicle(eventPlayers, i, 0)
                    end
                end
            end
        end
    end
end    
addCommandHandler("warpincar", warpPlayersIntoCar)
                        
---========================================================== EVENT PLAYER JETPACK ==========================================================---

addEvent("eventGiveJetpack", true)
function eventGiveJetpack(eventSelectedPlr)
    if not isElement(eventSelectedPlr) then return end
    if ( not doesPedHaveJetPack ( eventSelectedPlr ) ) then
        givePedJetPack( eventSelectedPlr )
    else
        exports.GTIhud:dm(getPlayerName(eventSelectedPlr).." already has a Jetpack!", source, 255, 0, 0 )
        exports.GTIlogs:outputServerLog("(EM) "..getPlayerName(source).." gave "..getPlayerName(eventSelectedPlr).."a jetpack. (Dim: "..getElementDimension(source)..")", "eventsystem", source)
    end
end
addEventHandler("eventGiveJetpack", root, eventGiveJetpack )

addEvent("eventRemoveJetpack", true)
function eventRemoveJetpack(eventSelectedPlr)
    if ( doesPedHaveJetPack ( eventSelectedPlr ) ) then
        removePedJetPack ( eventSelectedPlr )
    else
        exports.GTIhud:dm(getPlayerName(eventSelectedPlr).." doesn't have a Jetpack!", source, 255, 0, 0 )
    end
end
addEventHandler("eventRemoveJetpack", root, eventRemoveJetpack )

addEvent("eventGiveCash", true)
function eventGiveCash (eventSelectedPlr, amountOfMoney)
    local theCash = tonumber(amountOfMoney)
    if (eventSelectedPlr) and (theCash) then
        if ( theCash > 100000) or (  theCash < 500 ) then
            exports.GTIhud:dm("The maximum amount of cash is 100,000$, and the minimum amont of cash is 500$!", source, 255, 0, 0)
            return
        end
        --exports.GTIbank:GPM(eventSelectedPlr, amountOfMoney, "Given cash for a winner of an Event")
        exports.GTIbank:GPM(eventSelectedPlr, theCash, "Event price")
        exports.GTIhud:dm("You've successfully given "..getPlayerName(eventSelectedPlr).." an amount of "..(amountOfMoney).."$!", source, 128, 255, 0)
        exports.GTIhud:dm("Congratulations! You recieved "..(amountOfMoney).."$ from "..getPlayerName(source).."!", eventSelectedPlr, 0, 255, 0)
        exports.GTIlogs:outputServerLog("(EM) "..getPlayerName(source).." gave "..getPlayerName(eventSelectedPlr).." a price. ($"..amountOfMoney..")", "eventsystem", source)
        
    --else
        --exports.GTIhud:dm("Failure to finance "..getPlayerName(eventSelectedPlr).."!", source, 255, 0, 0)
    end
end
addEventHandler("eventGiveCash", root, eventGiveCash)
---========================================================== EVENT PLAYER FREEZING ==========================================================---

addEvent("eventFeezePlayers", true)
function eventFeezePlayers()
    for eventPlayers in pairs(WrapedPlayers) do
        toggleAllControls ( eventPlayers, false )
    end
    exports.GTIhud:dm("You've successfully frozen Event Participants!", source, 255, 0, 255)
end
addEventHandler("eventFeezePlayers", root, eventFeezePlayers )

addEvent("eventUnfreezePlayers", true)
function eventUnfreezePlayers()
    for eventPlayers in pairs(WrapedPlayers) do
        toggleAllControls ( eventPlayers, true )
    end
    --outputEventPlayers ( "Event Players have been unfrozen!" )
    exports.GTIhud:dm("You've successfully unfrozen Event Participants!", source, 255, 0, 255)
end
addEventHandler("eventUnfreezePlayers", root, eventUnfreezePlayers )

addEvent("eventFeezeevPlayer", true)
function eventFeezePlayer(eventSelectedPlr)
    if ( not isElementFrozen( eventSelectedPlr ) ) then
        toggleAllControls ( eventSelectedPlr, false )
        exports.GTIhud:dm("You've successfully frozen "..getPlayerName(eventSelectedPlr).."!", source, 255, 0, 255)
    else
        outputChatBox("He's unfrozen, asshole", source, 255, 0, 0)
    end
end
addEventHandler("eventFeezeevPlayer", root, eventFeezePlayer)

addEvent("eventUnfreezeevPlayer", true)
function eventUnfreezePlayer(eventSelectedPlr)
    toggleAllControls ( eventSelectedPlr, true )
    exports.GTIhud:dm("You've successfully unfrozen "..getPlayerName(eventSelectedPlr).."!", source, 255, 0, 255)
end
addEventHandler("eventUnfreezeevPlayer", root, eventUnfreezePlayer)
---=====================================================  EVENT PLAYERS WEAPON SWITCH ===============================================================---

addEvent("weaponSwitch", true)
function weaponSwitch()
    local eventPlayer = WrapedPlayers[client]
    if (eventPlayer) then
        setPedWeaponSlot( client, 0)
    end
end
addEventHandler( "weaponSwitch", root, weaponSwitch )
---============================================================ EVENT VEHICLE FREEZING ========================================================---

addEvent("eventFreezeVehicle", true)
function eventFreezeVehicle(player)
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            if (isElement(eventVeh)) then
                setElementFrozen ( eventVeh, true )
                local occ = getVehicleOccupant(eventVeh)
                if (occ) then
                     toggleControl ( occ, "accelerate", false )
                     toggleControl ( occ, "brake_reverse", false )
                end     
            end    
        end
    end
    outputEventPlayers (getPlayerName(source).. " has frozen Event Vehicles!")
    exports.GTIhud:dm("You've successfully frozen Event Vehicles!", source, 255, 0, 255)
end
addEventHandler("eventFreezeVehicle", root, eventFreezeVehicle)

addEvent("eventUnfreezeVehicles", true)
function eventUnfreezeVehicles(player)
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            if isElement(eventVeh) then
                setElementFrozen ( eventVeh, false )
                local occ = getVehicleOccupant(eventVeh)
                if (occ) then
                    toggleControl ( occ, "accelerate", true )
                    toggleControl ( occ, "brake_reverse", true )
                end  
            end
        end
    end
    outputEventPlayers (getPlayerName(source).. " has unfrozen Event Vehicles!")
    exports.GTIhud:dm("You've successfully unfrozen Event Vehicles!", source, 255, 0, 255)
end
addEventHandler("eventUnfreezeVehicles", root, eventUnfreezeVehicles)

function disableWhenFrozen(plr, seat)
    if (isElement(plr) and seat == 0 and WrapedPlayers[plr]) then
        if (isElementFrozen(source)) then
            toggleControl ( plr, "accelerate", false )
            toggleControl ( plr, "brake_reverse", false )
        end
    end
end
addEventHandler("onVehicleEnter", root, disableWhenFrozen)    

function enableOnExit(plr, seat)
    if (isElement(plr) and WrapedPlayers[plr] and seat == 0) then
        if (isElementFrozen(source)) then
            toggleControl ( plr, "accelerate", true )
            toggleControl ( plr, "brake_reverse", true )
        end
    end
end
addEventHandler("onVehicleExit", root, enableOnExit)  
---=================================================== EVENT VEHICLE LOCKS=================================================================---

addEvent("eventLockVehicles", true)
function eventLockVehicles()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            if (isElement(eventVeh)) then
                setVehicleLocked ( eventVeh, true )
            end    
        end
    end
    outputEventPlayers ("[GTI]"..getPlayerName(source).. " has locked Event Vehicles!")
    exports.GTIhud:dm("You've successfully locked Event Vehicles!", source, 255, 0, 255)
end
addEventHandler( "eventLockVehicles", root,  eventLockVehicles)

addEvent("eventUnlockVehicles", true)
function eventUnlockVehicles()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            if (isElement(eventVeh)) then
                setVehicleLocked ( eventVeh, false )
            end    
        end
        outputEventPlayers ("[GTI]"..getPlayerName(source).. " has unlocked Event Vehicles!")
        exports.GTIhud:dm("You've successfully unlocked Event Vehicles!", source, 255, 0, 255)
    end
end
addEventHandler( "eventUnlockVehicles", root, eventUnlockVehicles )
---===================================================== EVENT VEHICLE DAMAGE ===============================================================---

addEvent("eventEnableDamageProof", true)
function eventEnableDamageProof()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            triggerClientEvent("eventEnableDamageProof",source,eventVeh)
        end
    end
    outputEventPlayers ("Damage-proof mode has been enabled by "..getPlayerName(source).."!")
    exports.GTIhud:dm("You've successfully enabled Damage-proof mode!", source, 255, 0, 255)
end
addEventHandler("eventEnableDamageProof", root, eventEnableDamageProof)

addEvent("eventDisableDamageProof", true)
function eventDisableDamageProof()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            triggerClientEvent("eventDisableDamageProof",source,eventVeh)
        end
    end
    outputEventPlayers ("Damage-proof mode has been disabled by "..getPlayerName(source).."!")
    exports.GTIhud:dm("You've successfully disabled Damage-proof mode!", source, 255, 0, 255)
end
addEventHandler("eventDisableDamageProof", root, eventDisableDamageProof)
---===================================================== EVENT VEHICLE FIX ===============================================================---

addEvent("eventFixVehicles", true)
function eventFixVehicles()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            if isElement(eventVeh) then
                fixVehicle ( eventVeh )
            end
        end
    end
    outputEventPlayers ( "Event Vehicles have been repaired by "..getPlayerName(source).."!")
    exports.GTIhud:dm("You've successfully repaired Event Vehicles!", source, 255, 0, 255)
end
addEventHandler("eventFixVehicles", root, eventFixVehicles)
---===================================================== EVENT VEHICLE COLLISION ===============================================================---

addEvent("eventEnableCollision", true)
function eventEnableCollision()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            triggerClientEvent("enableCollisions",source,eventVeh)
        end
    end
    outputEventPlayers ( "Vehicles Collision mode has been enabled by "..getPlayerName(source).."!")
    exports.GTIhud:dm("You've successfully enabled Vehicles Collision mode!", source, 255, 0, 255)
end
addEventHandler( "eventEnableCollision", root, eventEnableCollision )

addEvent("eventDisableCollision", true)
function eventDisableCollision()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            triggerClientEvent("disableCollisions",source,eventVeh)
        end
    end
    outputEventPlayers ( "Vehicles Collision mode has been disabled by "..getPlayerName(source).."!")
    exports.GTIhud:dm("You've successfully disabled Vehicles Collision mode!", source, 255, 0, 255)
end
addEventHandler( "eventDisableCollision", root, eventDisableCollision )
---====================================================== DESTROY EVENT VEHICLES==============================================================---

addEvent("destroyVehicles", true)
function destroyVehicles ( eventManager, single, theCar )
    local eventManager = getAccountName(getPlayerAccount(source))  
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do   
            if (eventVeh) then
                if (isElement(eventVeh)) then
                    destroyElement( eventVeh )
                end    
            end
        end
    end
    outputEventPlayers ( "Event Vehicles have been destroyed by "..getPlayerName(source).."!")
    exports.GTIhud:dm("You've successfully destroyed all event vehicles!", source, 255, 0, 255)
    eventVehicles[eventManager] = {}
end
addEventHandler( "destroyVehicles", root, destroyVehicles )

addEvent("destroySingleVehicles", true)
function destroySingleVehicles ( eventManager, single, theCar )
    local eventManager = getAccountName(getPlayerAccount(eventManager))
    if ( eventVehicles[eventManager] ) then
        for i, eventVeh in ipairs ( eventVehicles[eventManager] ) do
            if (single) then
                if (eventVeh == theCar) then
                    destroyElement(theCar)
                    eventVehicles[eventManager][theCar] = nil
                    return
                end     
            end
        end
    end
end
addEventHandler( "destroySingleVehicles", root, destroySingleVehicles )
---===================================================== CREATE EVENT PICKUPS ===============================================================---

addEvent("createHealth", true)
function createHealth ( theType )
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( isElement ( source ) ) and ( eventManager ) then
        local x, y, z = getElementPosition( source )
        if ( healthPickups[eventManager] ) and ( isElement( healthPickups[eventManager] ) ) then destroyElement( healthPickups[eventManager] ) healthPickups[eventManager] = {} end
        healthPickups[eventManager] = createPickup ( x, y, z, 0, 100, 0 )
        setElementDimension( healthPickups[eventManager], getElementDimension( source ) )
        setElementInterior( healthPickups[eventManager], getElementInterior( source ) )
        exports.GTIhud:dm("You've successfully created a Health-Pickup!", source, 255, 0, 255)
    end
end
addEventHandler( "createHealth", root, createHealth )

addEvent("createArmourPickup", true)
function createArmourPickup ( theType )
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( isElement ( source ) ) and ( eventManager ) then
        local x, y, z = getElementPosition( source )
        if ( armorPickups[eventManager] ) and ( isElement( armorPickups[eventManager] ) ) then
            destroyElement( armorPickups[eventManager] ) armorPickups[eventManager] = {}
        end
        armorPickups[eventManager] = createPickup ( x, y, z, 1, 100, 0 )
        setElementDimension( armorPickups[eventManager], getElementDimension( source ) )
        setElementInterior( armorPickups[eventManager], getElementInterior( source ) )
    exports.GTIhud:dm("You've successfully created an Armour-Pickup!", source, 255, 0, 255)
    end
end
addEventHandler( "createArmourPickup", root, createArmourPickup )

addEvent("destroyArmor", true)
function destroyArmor ()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( isElement ( source ) ) and ( eventManager ) then
        if ( armorPickups[eventManager] ) and ( isElement( armorPickups[eventManager] ) ) then
            destroyElement( armorPickups[eventManager] )
            armorPickups[eventManager] = {}
        end
    end
    exports.GTIhud:dm("You've successfully destroyed the Pickup(s)!", source, 255, 0, 255)
end
addEventHandler( "destroyArmor", root, destroyArmor )

addEvent("destroyHealth", true)
function destroyHealth ()
    local eventManager = getAccountName(getPlayerAccount(source))
    if ( isElement ( source ) ) and ( eventManager ) then
        if ( healthPickups[eventManager] ) and ( isElement( healthPickups[eventManager] ) ) then
            destroyElement( healthPickups[eventManager] )
            healthPickups[eventManager] = {}
        end
    end
    exports.GTIhud:dm("You've successfully destroyed the Pickup(s)!", source, 255, 0, 255)
end
addEventHandler( "destroyHealth", root, destroyHealth )
---============================================================ RETURN EVENT PLAYERS ========================================================---

addEvent("returnPlayers", true)
function returnPlayers()
    for a,b in pairs(getElementsByType("player")) do
        if (WrapedPlayers[b]) then
            if (isPedInVehicle(b)) then
                local veh = getPedOccupiedVehicle(b)
                if (isElement(veh)) then
                    destroyElement(veh)
                end
            end    
            if (not savePosition[b]) then
                killPed(b)
                outputChatBox("You've been died. Your position wasn't saved!", b, 0, 255, 0)
            end
                if (savePosition[b]) then
                    local px,py,pz = savePosition[b][1],savePosition[b][2],savePosition[b][3]
                    local pint = savePosition[b][4]
                    local pdim = savePosition[b][5]
                        if (pint >= 1) then
                            setElementInterior(b, pint, px, py, pz)
                            setElementDimension(b, pdim)
                        else
                            setElementPosition(b, px, py, pz)
                            setElementDimension(b, pdim)
                        end
                        toggleAllControls ( b, true )
                end
                if (WrapedPlayers[b]) then WrapedPlayers[b] = nil end
                if (savePosition[b]) then savePosition[b] = nil end
                outputEventPlayers (getPlayerName(source) .. " has returned you to your previous position!")
                triggerClientEvent("removeEventPlayers", root, b)
        end 
    end
    exports.GTIhud:dm("You've successfully returned them back to their previous position(s)!", source, 255, 0, 255)
end
addEventHandler("returnPlayers", root, returnPlayers)

addEvent("eventKickPlayer", true)
function eventKickPlayer(eventSelectedPlr)
    if (WrapedPlayers[eventSelectedPlr]) then
        if (isPedInVehicle(eventSelectedPlr)) then
                local veh = getPedOccupiedVehicle(eventSelectedPlr)
                if (isElement(veh)) then
                    destroyElement(veh)
                end
            end
        if (not savePosition[eventSelectedPlr]) then
            killPed(eventSelectedPlr)
            exports.GTIhud:dm(getPlayerName(source) .. " has kicked you out!", eventSelectedPlr, 225, 0, 0)
        end
        if (savePosition[eventSelectedPlr]) then
            local px,py,pz = savePosition[eventSelectedPlr][1],savePosition[eventSelectedPlr][2],savePosition[eventSelectedPlr][3]
            local pint = savePosition[eventSelectedPlr][4]
            local pdim = savePosition[eventSelectedPlr][5]
            if (pint >= 1) then
                setElementInterior(eventSelectedPlr, pint, px, py, pz)
                setElementDimension(eventSelectedPlr, pdim)
            else
                setElementPosition(eventSelectedPlr, px, py, pz)
                setElementDimension(eventSelectedPlr, pdim)
            end
            toggleAllControls ( eventSelectedPlr, true )
        end
        if (WrapedPlayers[eventSelectedPlr]) then WrapedPlayers[eventSelectedPlr] = nil end
        if (savePosition[eventSelectedPlr]) then savePosition[eventSelectedPlr] = nil end
        triggerClientEvent("removeEventPlayers", root, eventSelectedPlr)
        outputChatBox( getPlayerName(source) .. " has kicked you out!", eventSelectedPlr, 0, 255, 0)
        exports.GTIhud:dm("You've successfully expelled "..getPlayerName(eventSelectedPlr).." from the event!", source, 255, 0, 255)
    end
end
addEventHandler("eventKickPlayer", root, eventKickPlayer)

function leaveevent(plr)
    if (WrapedPlayers[plr]) then
        if (isPedInVehicle(plr)) then exports.GTIhud:dm("You have to leave your vehicle first", plr, 255, 0, 0) return end
        if (not savePosition[plr]) then
            killPed(plr)
            exports.GTIhud:dm("You've been killed. Sadly, your position wasn't saved!", plr, 225, 0, 0)
        end
            if (savePosition[plr]) then
                local px,py,pz = savePosition[plr][1],savePosition[plr][2],savePosition[plr][3]
                local pint = savePosition[plr][4]
                local pdim = savePosition[plr][5]
                if (pint >= 1) then
                    setElementInterior(plr, pint, px, py, pz)
                    setElementDimension(plr, pdim)
                else
                    setElementPosition(plr, px, py, pz)
                    setElementDimension(plr, pdim)
                end
                toggleAllControls ( plr, true )
            end
            if (WrapedPlayers[plr]) then WrapedPlayers[plr] = nil end
            if (savePosition[plr]) then savePosition[plr] = nil end
            exports.GTIhud:dm( "You've returned to your previous position!", plr, 0, 255, 0)
    end
end
addCommandHandler("leaveevent", leaveevent )

function removeHEX(message)
    return string.gsub(message,"#%x%x%x%x%x%x", "")
end


function isPlayerInEvent(player)
    if not (player) and not isElement(player) and not getElementType(player) == "player" then -- If the guy exists.
        return
    end
    if WrapedPlayers[player] then -- If he's warped.
        return true
    else
        return false
    end
end


function createEventVehicle(id, x, y, z, rx, ry, rz, dim, int, creator, warp, player, color)
    local theVehicle = createVehicle(id, x, y, z + 2, rx, ry, rz)
    setElementData(theVehicle, "creator", creator)
    if (theVehicle) then
        setElementDimension(theVehicle, dim)
        setElementInterior(theVehicle, int)
        if (warp) then
            warpPedIntoVehicle(player, theVehicle, 0)
        end    
        exports.GTIfuel:setVehicleFuel(theVehicle, 100)
        if (color) then
            setVehicleColor(theVehicle, color[1] or 255, color[2] or 255, color[3] or 255, color[4] or 255, color[5] or 255, color[6] or 255, color[7] or 255, color[8] or 255, color[9] or 255, color[10] or 255, color[11] or 255, color[12] or 255)
        end
        if not ( eventVehicles[creator] ) then eventVehicles[creator] = {}

        end
        table.insert( eventVehicles[creator], theVehicle )
        Evehs[#Evehs + 1] = theVehicle
                    --return vehicle
    end
end



function getElementOwner(element)
    if (not isElement(element)) then return end
    return getElementData(element, "creator")
end

function getEventParticipants()
    local pTable = {}
    local index = 0
    for acc in pairs(warp_warpedUsers) do
        if (getAccountPlayer(getAccount(acc))) then
            index = index + 1
            pTable[index] = getAccountPlayer(getAccount(acc))
        end
    end
    return pTable
end


function startCountdown(p, cmd, sec)
    local sec = tonumber(sec)
    if (type(sec) == "number") and (sec >= 1) then
        triggerClientEvent("sendMessage", root, sec, 144, 147, 220)
        countdownTimer = setTimer(function () if (isTimer(checkTimer)) then killTimer(checkTimer) triggerClientEvent("sendMessage", root, "GO!", 144, 147, 220) end end, 1000 * sec, 1)
        checkTimer = setTimer(checkCCRTime, 1000, 0)
    end
end
addCommandHandler("countdown", startCountdown, true)

lastSend = ""
    
function checkCCRTime(drug)
    for i,player in ipairs( getElementsByType( "player")) do
        if (isElement(player)) then
            if isTimer(countdownTimer) then
                local milliSecs, _, _ = getTimerDetails( countdownTimer)
                local min = math.ceil(milliSecs/1000)
                local min2 = tostring(min)
                if (lastSend ~= min2) then
                    triggerClientEvent("sendMessage", root, min2, 144, 147, 220)  
                    lastSend = min2
                end    
            end
        end
    end
end  
        

function toggleShooting(toggle)
    local eventPlayers = WrapedPlayers[client]
    if (eventPlayers) then
        if (toggle) then
            toggleControl(client, "fire", false)
            toggleControl(client, "action", false)
            toggleControl(client, "vehicle_fire", false)
            toggleControl(client, "vehicle_secondary_fire", false)
        else
            toggleControl(client, "fire", true)
            toggleControl(client, "action", true)
            toggleControl(client, "vehicle_fire", true)
            toggleControl(client, "vehicle_secondary_fire", true)
        end
    end
end
addEvent("GTIeventsys.toggleShoot", true)
addEventHandler("GTIeventsys.toggleShoot", root, toggleShooting)    
        
