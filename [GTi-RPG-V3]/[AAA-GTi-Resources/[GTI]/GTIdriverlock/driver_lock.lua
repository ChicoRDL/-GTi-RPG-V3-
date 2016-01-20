--------------------------------------------------------------------------------------------------
-- Script name:     Driver Lock (server)
-- Developer:       MrBrutus
-- Project type:    Open source (code.albonius.com)
-- Last edit:       2014-07-25
-- Status:          (working) BETA
--------------------------------------------------------------------------------------------------

-- Global data and pointers
toggleDLock = { }
toggleLock  = { }
vehOwner = { }
sync = true --Disable if any issues come up

function toggleDriverLock(thePlayer, cmd)
    local veh = getPedOccupiedVehicle(thePlayer)
        -- local seat = getPedOccupiedVehicleSeat(thePlayer)
        -- if (seat ~= 0) then return end
        if not (isElement(veh)) then
            if not isPedInVehicle(thePlayer) then
                local acc = getPlayerAccount(thePlayer)
                local accName = getAccountName(acc)
		if ( isGuestAccount(acc) ) then return end

                for i,vehicle in ipairs(getElementsByType("vehicle")) do
                    if getElementData(vehicle,"owner") == accName and exports.GTIutil:getDistanceBetweenElements3D(vehicle,thePlayer) < 20 then --if the player is the owner and near it
                        if (getElementData(vehicle, "hijack")) then return end  -- Hijack Vehicle Block
                        if not toggleLock[vehicle] and cmd == "lock" then
                            toggleLock[vehicle] = true
                            vehOwner[vehicle] = thePlayer
                            setElementData(vehicle,"locked",true,sync)
                            triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "lock", vehicle)
                            exports.GTIhud:dm("Your vehicle has been locked", thePlayer, 255, 200, 0)
                        elseif not toggleDLock[vehicle] and cmd == "dlock" then
                            if (getElementData(vehicle, "hijack")) then return end  -- Hijack Vehicle Block
                            toggleDLock[vehicle] = true
                            vehOwner[vehicle] = thePlayer
                            setElementData(vehicle,"locked",true,sync)
                            triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "lock", vehicle)
                            exports.GTIhud:dm("The driver door has been locked", thePlayer, 255, 200, 0)
                        else 
                            toggleLock[vehicle] = false
                            toggleDLock[vehicle] = false
                            setElementData(vehicle,"locked",false,sync)
                            triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "unlock", vehicle)
                            exports.GTIhud:dm("Your vehicle has been unlocked", thePlayer, 255, 200, 0)
                        end
                    end
                end
            end
        return end
        
        if not veh then return end
        local driver = getVehicleOccupant(veh, 0)
        if not driver then return end
	if driver ~= thePlayer then return end

        local account = getPlayerAccount(driver)
        if not (account) or (isGuestAccount(account)) then return end --ignore lock for those who aren't logged in.
        
        if (getElementData(veh,"owner") ~= getAccountName(account)) then
            return exports.GTIhud:dm("You don't have the keys to lock this vehicle.",driver,255,0,0)
        end
        
        if driver and driver == thePlayer then
            if (getElementData(veh, "hijack")) then return end  -- Hijack Vehicle Block
            if not toggleLock[veh] and cmd == "lock" then
                toggleLock[veh] = true
                vehOwner[veh] = thePlayer
                setElementData(veh,"locked",true,sync)
                triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "lock", veh)
                exports.GTIhud:dm("Your vehicle has been locked", thePlayer, 255, 200, 0)
            elseif not toggleDLock[veh] and cmd == "dlock" then
                toggleDLock[veh] = true
                vehOwner[veh] = thePlayer
                setElementData(veh,"locked",true,sync)
                triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "lock", vehicle)
                exports.GTIhud:dm("The driver door has been locked", thePlayer, 255, 200, 0)
            else
                toggleLock[veh] = false
                toggleDLock[veh] = false
                setElementData(veh,"locked",false,sync)
                triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "unlock", veh)
                exports.GTIhud:dm("Your vehicle has been unlocked", thePlayer, 255, 200, 0)
            end
        end --Ignore the lock if it aint the driver. 
end
addCommandHandler("dlock", toggleDriverLock)
addCommandHandler("lock", toggleDriverLock)
addCommandHandler("unlock", toggleDriverLock)

-- Block access to locked vehicles
function blockDriverLockedVehicle( thePlayer, seat, jacked )
    -- Driver seat door is locked
    if toggleLock[source] and vehOwner[source] ~= thePlayer and not exports.GTIgroups:arePlayersInSameGroup(thePlayer,vehOwner[source]) and not exports.GTIcontactsApp:arePlayersFriend(thePlayer,vehOwner[source]) and not getElementData(source, "rental") then 
        cancelEvent()
        exports.GTIhud:dm("This vehicle is locked, you cannot enter it", thePlayer, 255, 0, 0)
        triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "locked", source)
    elseif toggleDLock[source] and seat == 0 and vehOwner[source] ~= thePlayer then
        cancelEvent()
        exports.GTIhud:dm("The drivers door of this vehicle is locked, use 'G' to enter as passenger", thePlayer, 255, 0, 0)
        triggerClientEvent(thePlayer, "GTIdriverlock.sound", resourceRoot, "locked", source)
    end
end
addEventHandler( "onVehicleStartEnter", getRootElement(), blockDriverLockedVehicle )

 
addEvent("GTIdriverlock.lockVehicle", true)
addEventHandler("GTIdriverlock.lockVehicle", root, function()
    if (getElementType(source) ~= "vehicle") then return end

    local player = exports.GTIvehicles:getVehicleOwner(source)
    toggleLock[source] = true
    vehOwner[source] = player
    setElementData(source, "locked", true, sync)
end
)

-- Script Last Edited by Emile

--------------------------------------------------------------------------------------------------
-- Tested by:       None
-- Written in:      Web Developer Studio 2013 / A.corp Notepad II (store.albonius.com)
-- Copyright: (C)   MrBrutus @ Acorp 2014 
--------------------------------------------------------------------------------------------------
