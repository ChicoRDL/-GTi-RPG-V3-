local info = {}
local savePosition = {}
local warped = {}
local openedRep = {}

function toggleGUI(thePlayer)
    if (getAccountName(getPlayerAccount(thePlayer)) == "RedBand") then
        triggerClientEvent(thePlayer, "GTIsup.toggleGUI", thePlayer )
    end
end    
--addCommandHandler("support", toggleGUI)

function sendTicket(msg, category)
    if (msg == "" and category == "") then return end
    local name = getPlayerName(client)
    table.insert(info,{name, msg, category, client})
    for i, v in ipairs(getElementsByType("player")) do
        if ( exports.GTIutil:isPlayerInACLGroup(v, "Admin1", "Admin2", "Admin3", "Admin4", "Admin5", "Dev5", "Dev4", "Dev3", "Dev1" ) ) then
            outputChatBox("A new support ticket has arrived, check /viewtickets ("..category..")", v, 0, 185, 0)
            
        end    
    end    
end
addEvent("GTIsupTicket.sendTicket", true)
addEventHandler("GTIsupTicket.sendTicket", root, sendTicket)

function getTickets(player)
    if exports.GTIutil:isPlayerInACLGroup( player, "Admin1", "Admin2", "Admin3", "Admin4", "Admin5", "Dev5", "Dev4", "Dev3", "Dev1" ) then
        triggerClientEvent(player,"GTIsupTicket.getTickets",resourceRoot,info, #info)
    end
end
addCommandHandler("viewtickets", getTickets)

function isOpened(player, name, row, col)
    if (openedRep[player]) then
        triggerClientEvent("GTIsupTicket.openTicket", client, client, true, name)
    else    
        triggerClientEvent("GTIsupTicket.openTicket", client, client, false, name)
        openedRep[player] = true    
    end
end
addEvent("GTIsupTicket.checkReport", true)
addEventHandler("GTIsupTicket.checkReport", root, isOpened)

function notifyPlayer(open, ticket, contact, close)
    if (not open and not ticket) then return end
    local by = getPlayerName(open)
    if (contact) then
        outputChatBox(by.." will contact you!", ticket, 125, 125, 0)
        return
    end    
    if (close) then
        outputChatBox(by.." has closed your ticket, someone else will help you as soon as possible!", ticket, 125, 125, 0) 
        openedRep[ticket] = nil
        return
    end    
    outputChatBox("Your ticket has been opened by "..by.."! He will contact you as soon as possible.", ticket, 125, 125, 0)

end
addEvent("GTIsupTicket.notifyPlayer", true)
addEventHandler("GTIsupTicket.notifyPlayer", root, notifyPlayer)


--[[function warpToPlayer(opener, player)
    if (not player) then return end
    fadeCamera(opener, false)
    setTimer(function(opener, player)
        warpPlayerTo(opener, player)
        fadeCamera(opener, true)
    end, 1100, 1, opener, player)
end
addEvent("GTIsupTicket.warp", true)        
addEventHandler("GTIsupTicket.warp", root, warpToPlayer)

function warpPlayerTo(player, warpTo)
    if (not isElement(player) or not isElement(warpTo)) then return false end
    if (player == warpTo) then
        exports.GTIhud:dm("Error: You cannot warp to yourself", player, 255, 25, 25)
        return
    end

    if (isPedInVehicle(player)) then
        removePedFromVehicle(player)
    end

    -- Warp Player Into Vehicle -->>
    local px,py,pz = getElementPosition(player)
    local pint = getElementInterior(player)
    local pdim = getElementDimension(player)
    savePosition[player] = {px, py, pz, pint, pdim}
                
    if (isPedInVehicle(warpTo)) then
        local vehicle = getPedOccupiedVehicle(warpTo)
        for seat=1,getVehicleMaxPassengers(vehicle) do
            if (not getVehicleOccupant(vehicle, seat)) then
                setElementInterior(player, getElementInterior(warpTo))
                setElementDimension(player, getElementDimension(warpTo))
                warpPedIntoVehicle(player, vehicle, seat)

                outputChatBox("ADMIN: You have warped into "..getPlayerName(warpTo).."'s "..getVehicleName(vehicle), player, 255, 25, 25)
                exports.GTIlogs:outputAdminLog("WARP: "..getPlayerName(player).." has warped into "..getPlayerName(warpTo).."'s "..getVehicleName(vehicle).." (Support)", player)
                warped[player] = true
                return true
            end
        end
    end

    -- Warp Player Near Player -->>
   
    local x,y,z = getElementPosition(warpTo)
    local _,_,rot = getElementRotation(warpTo)
    local x,y = getPointFromDistanceRotation(x, y, 1, rot)
    setElementPosition(player, x, y, z+1)
    setElementRotation(player, 0, 0, rot)
    setElementInterior(player, getElementInterior(warpTo))
    setElementDimension(player, getElementDimension(warpTo))
    warped[player] = true
    
    outputChatBox("ADMIN: You have been warped to "..getPlayerName(warpTo).." by "..getPlayerName(player), player, 255, 25, 25)
    exports.GTIlogs:outputAdminLog("WARP: "..getPlayerName(player).." has been warped to "..getPlayerName(warpTo).." by "..getPlayerName(player).." (Support)", player)
    return true
end

function warpBack(player)
    if (warped[player]) then
        if (savePosition[player]) then
            local px,py,pz = savePosition[player][1],savePosition[player][2],savePosition[player][3]
            local pint = savePosition[player][4]
            local pdim = savePosition[player][5]
            if (pint >= 1) then
                setElementInterior(b, pint, px, py, pz)
                setElementDimension(b, pdim)
            else
                setElementPosition(b, px, py, pz)
                setElementDimension(b, pdim)
            end
        end
        if (warped[player]) then warped[player] = nil end
        if (savePosition[player]) then savePosition[player] = nil end
    end
end
addCommandHandler("warpback", warpBack)  
]]

function delete(closed, plr, resolved)
    for i,v in pairs(info) do 
        if v[1] == plr then
            table.remove(info,i)
            break
        end
    end
    local player = getPlayerFromName(plr)
    if player then
        if resolved then
            outputChatBox("Your ticket has been set to resolved by "..getPlayerName(closed)..".",player,0,255,0)
        else
            outputChatBox("Your ticket has been closed by "..getPlayerName(closed)..".",player,0,255,0)
        end
    end
    if (openedRep[player]) then
        openedRep[player] = nil
    end    
    triggerClientEvent("GTIsupTicket.reset", player, player)
end
addEvent( "GTIsupTicket.delete", true)
addEventHandler( "GTIsupTicket.delete", root, delete)  
                

-- Utilities
------------->>
--[[
function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x+dx, y+dy;
end]]
