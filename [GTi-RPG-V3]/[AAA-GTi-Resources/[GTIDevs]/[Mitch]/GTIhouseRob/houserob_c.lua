----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: houserob_c.lua
-- Version: 1.0
----------------------------------------->>

local isRobbing = false
local isDelivery = false
local hasObject = false
local disableDestroyMarker = false
local vehicleMarker = false
local totalItems = 0

allowedCars = {
    [482] = true, -- Burrito
}

-- Robmarker1 robmarker2 robmarker3 blip int int int dim dim dim 
local locations = { 
{2370.442, -1126.096, 1049.875, 2360.898, -1131.233, 1049.875, 2374.059, -1127.963, 1049.883, 2447.882, 689.791, 10.461, 8, 8, 8, 4, 4, 4 },
{2310.448, -1207.699, 1048.023, 2307.045, -1207.950, 1048.023, 2313.202, -1210.383, 1048.023, 2818.912, 2140.272, 13.661, 6, 6, 6, 2, 2, 2 },
{348.462, 303.010, 998.148, 348.491, 309.382, 998.148, 346.076, 303.947, 998.148, 2037.220, 2722.144, 10.299, 6, 6, 6, 0, 0, 0 },
{2369.725, -1132.595, 1049.875, 2360.750, -1131.200, 1049.875, 2367.748, -1124.088, 1049.875, 1407.938, 1897.168, 10.461, 8, 8, 8, 5, 5, 5 },
{383.893, 170.517, 1007.383, 375.027, 176.341, 1007.383, 381.327, 177.253, 1007.383, 2412.600, 1123.810, 9.820, 3, 3, 3, 0, 0, 0 },
{2371.232, -1122.280, 1049.875, 2373.884, -1122.316, 1049.875, 2373.374, -1131.295, 1049.875, 928.954, 2006.552, 10.461, 8, 8, 8, 6, 6, 6 },
}

function bind_key ( player, seat )
    if ( player == localPlayer and isRobbing == false and ( getElementModel ( source ) == 482 ) and seat == 0 ) then
        --local job = exports.GTIemployment:getPlayerJob ( true )
        if ( exports.AresMisc:isAbleToCrime ( localPlayer ) ) then
		    bindKey ("N", "down", startRobbery )
	        exports.GTIhud:drawNote("GTIhouseRob_StartNote", "Press [N] To start House Robbery", 200, 0, 0, 15000)
		end
	end
end
addEventHandler ("onClientVehicleEnter", root, bind_key )

function unbind_key ( player )
    if ( player == localPlayer and ( getElementModel ( source ) == 482 ) ) then
        --local job = exports.GTIemployment:getPlayerJob ( true )
        if ( exports.AresMisc:isAbleToCrime ( localPlayer ) ) then
		    unbindKey ("N", "down", startRobbery )
	        exports.GTIhud:drawNote("GTIhouseRob_StartNote", "", 200, 0, 0, 0)
		end
	end
end
addEventHandler ("onClientVehicleExit", root, unbind_key )

function startRobbery ( player, seat )
    if isRobbing == true then return end
    loc = math.random ( #locations )
    isRobbing = true
    robMarker1 = createMarker ( locations[loc][1], locations[loc][2], locations[loc][3], "cylinder", 0.7, 255, 0, 0, 75 )
    robMarker2 = createMarker ( locations[loc][4], locations[loc][5], locations[loc][6], "cylinder", 0.7, 255, 0, 0, 75 )
    robMarker3 = createMarker ( locations[loc][7], locations[loc][8], locations[loc][9], "cylinder", 0.7, 255, 0, 0, 75 )
    setElementInterior ( robMarker1, locations[loc][13] )
    setElementInterior ( robMarker2, locations[loc][14] )
    setElementInterior ( robMarker3, locations[loc][15] )
    setElementDimension ( robMarker1, locations[loc][16] )
    setElementDimension ( robMarker2, locations[loc][17] )
    setElementDimension ( robMarker3, locations[loc][18] )
    zone = getZoneName ( locations[loc][10], locations[loc][11], locations[loc][12] )
    startBlip = createBlip ( locations[loc][10], locations[loc][11], locations[loc][12], 32 )
    exports.GTIhud:dm ( "Rob the house at " ..zone, 200, 0, 0 )
    addEventHandler ("onClientMarkerHit", robMarker1, stealItem )
    addEventHandler ("onClientMarkerHit", robMarker2, stealItem )
    addEventHandler ("onClientMarkerHit", robMarker3, stealItem )
    addEventHandler ("onClientMarkerHit", robMarker1, destroyMarker1 )
    addEventHandler ("onClientMarkerHit", robMarker2, destroyMarker2 )
    addEventHandler ("onClientMarkerHit", robMarker3, destroyMarker3 )
    addEventHandler ("onClientMarkerHit", robMarker1, disableDestroyMarkers )
    addEventHandler ("onClientMarkerHit", robMarker2, disableDestroyMarkers )
    addEventHandler ("onClientMarkerHit", robMarker3, disableDestroyMarkers )
	exports.GTIhud:drawNote("GTIhouseRob_StartNote", "", 200, 0, 0, 0)
	setElementData(localPlayer, "GTIhouseRob.isPlayerRobbing", true)
	unbindKey ("N", "down", startRobbery )
end

function wantedLevel ( player )
    if ( player == localPlayer and totalItems == 3 ) then
        triggerServerEvent ("GTIhouseRob.WantedLevel", localPlayer, localPlayer )
    end
end
addEventHandler ("onClientVehicleEnter", root, wantedLevel )

function stealItem ( hitPlayer )
    if ( hasObject == true ) then
        exports.GTIhud:dm ( "Deliver your stolen item to the Burrito first before stealing another item!", 200, 0, 0 )
        return
    end
    if ( hitPlayer == localPlayer ) then
        if ( hitPlayer ) then
            local x, y, z = getElementPosition ( hitPlayer )
            object = createObject ( 1429, x, y, z, 0, 360, 0, true ) -- random object?
			setElementDimension ( object, getElementDimension ( localPlayer ) )
			setElementInterior ( object, getElementInterior ( localPlayer ) )
            attachElements ( object, hitPlayer, 0, 0.5, 0.58 )
            toggleControl ( "fire", false )
            toggleControl ( "jump", false )
            toggleControl ( "sprint", false )
            toggleControl ( "aim_weapon", false )
            toggleControl ( "next_weapon", false )
            toggleControl ( "previous_weapon", false )
			triggerServerEvent ("GTIhouseRob_Anim", localPlayer )
            hasObject = true
            toggleControl ( "enter_exit", false )
            toggleControl ( "enter_passenger", false )
        end
    end
end

function updateObject ()
	if ( hasObject == false ) then return end
    setElementDimension ( object, getElementDimension ( localPlayer ) )
	setElementInterior ( object, getElementInterior ( localPlayer ) )
end
addEventHandler ("onClientPlayerChangeInterior", localPlayer, updateObject )

function disableDestroyMarkers ( player )
    if ( player == localPlayer ) then
        disableDestroyMarker = true
    end
end

function destroyMarker1 ( hitPlayer )
    if ( disableDestroyMarker == true ) then return end
    if ( hasObject == true ) then 
        if ( hitPlayer == localPlayer ) then
            destroyElement ( robMarker1 )
            destroyElement ( startBlip )
            return 
        end
    end
 end
 
function destroyMarker2 ( hitPlayer )
    if ( disableDestroyMarker == true ) then return end
    if ( hasObject == true ) then
        if ( hitPlayer == localPlayer ) then
            destroyElement ( robMarker2 )
            return 
        end
    end
end

function destroyMarker3 ( hitPlayer )
    if ( disableDestroyMarker == true ) then return end
    if ( hasObject == true ) then
        if ( hitPlayer == localPlayer ) then
            destroyElement ( robMarker3 )
            return 
        end
    end
end

function boxvilleMarker ( veh )
	if ( not hasObject ) then return end
	if ( vehicleMarker == true ) then return end
	    vehicleMarker = true
        local id = getElementModel ( veh )
        if ( id == 482 ) then
            local x, y, z = getElementPosition ( veh )
            storeMarker = createMarker ( x, y, z, "cylinder", 1, 200, 0, 0, 150 )
            attachElements ( storeMarker, veh, 0, -3.3, -1.2 )
            addEventHandler ("onClientMarkerHit", storeMarker, storeItems )
        end
    end
addEvent ("GTIhouseRob.boxvilleMarker", true )
addEventHandler ("GTIhouseRob.boxvilleMarker", root, boxvilleMarker )

function storeItems ( hitPlayer, veh )
    if ( hitPlayer == localPlayer ) then
        totalItems = totalItems + 1
		triggerServerEvent("GTIhouseRob.unfreeze",resourceRoot)
        exports.GTIhud:drawStat ("stolenItems", "Stolen Goods", totalItems.."/3", 200, 0, 0, 45000 )
		exports.GTIanims:setJobAnimation(localPlayer, "CARRY", "putdwn", 2500, false, true, false, false)
        hasObject = false
        disableDestroyMarker = false
		vehicleMarker = false
        toggleControl ( "fire", true )
        toggleControl ( "jump", true )
        toggleControl ( "sprint", true )
        toggleControl ( "aim_weapon", true )
        toggleControl ( "next_weapon", true )
        toggleControl ( "previous_weapon", true )
        toggleControl ( "enter_exit", true)
        toggleControl ( "enter_passenger", true)
        destroyElement ( object )
        destroyElement ( storeMarker )
    end
end

function deliverStolenItems ( player )
    if ( player == localPlayer ) then
	if ( isDelivery == true ) then return end
        removeEventHandler ("onClientVehicleEnter", root, startRobbery )
        if ( totalItems == 3 ) then
            deMarker = createMarker ( 1303.322, 1342.647, 9.820, "cylinder", 4, 200, 0, 0, 150 )
            deBlip = createBlipAttachedTo ( deMarker, 51 )
            exports.GTIhud:dm ( "Deliver your stolen goods to LV Airport, be aware of cops!", 200, 0, 0 )
			isDelivery = true
            addEventHandler ("onClientMarkerHit", deMarker, finishRobbery )
            addEventHandler ("onClientMarkerHit", deMarker, startRobbery )
        end
    end         
end
addEventHandler ("onClientVehicleEnter", root, deliverStolenItems )

function finishRobbery ( player )
    local veh = getPedOccupiedVehicle ( player )
    if ( player == localPlayer and isPedInVehicle ( localPlayer ) ) then
        totalItems = 0
        destroyElement ( deMarker )
		destroyElement ( deBlip )
        setElementFrozen ( veh, true )
        setTimer ( unfreezeVeh, 3000, 1 )
		setElementData(localPlayer, "GTIhouseRob.isPlayerRobbing", false)
        isRobbing = false
        isDelivery = false
    end
end

function unfreezeVeh ( )
    local veh = getPedOccupiedVehicle ( localPlayer )
    setElementFrozen ( veh, false )
	triggerServerEvent ("GTIhouseRob.payThePlayer", localPlayer )
end

function cancelMission ( )
	    exports.GTIhud:drawStat ("stolenItems", "", "", 200, 0, 0, 0 )
	    if isElement ( robMarker1 ) then
		    destroyElement ( robMarker1 )
	    end
	    if isElement ( robMarker2 ) then
		    destroyElement ( robMarker2 )
	    end
	    if isElement ( robMarker3 ) then
		    destroyElement ( robMarker3 )
	    end
		if isElement ( startBlip ) then
		    destroyElement ( startBlip )
	    end
	    if isElement ( object ) then
            destroyElement ( object )
        end 
        if isElement ( storeMarker ) then
            destroyElement ( storeMarker )
	    end
		if isElement ( deMarker ) then
		    destroyElement ( deMarker )
		end
		if isElement ( deBlip ) then
		    destroyElement ( deBlip )
		end
            toggleControl ( "fire", true )
            toggleControl ( "jump", true )
            toggleControl ( "sprint", true )
            toggleControl ( "aim_weapon", true )
            toggleControl ( "next_weapon", true )
            toggleControl ( "previous_weapon", true )
            toggleControl ( "enter_exit", true)
            toggleControl ( "enter_passenger", true)
			setElementData(localPlayer, "GTIhouseRob.isPlayerRobbing", false)
	        totalItems = 0
	        isRobbing = false
            hasObject = false
            disableDestroyMarker = false
			vehicleMarker = false
			isDelivery = false
end
addEventHandler ("onClientPlayerQuitJob", root, cancelMission )
addEventHandler ("onClientPlayerWasted", localPlayer, cancelMission )
addEventHandler ("onClientResourceStop", resourceRoot, cancelMission )
addEvent("GTIhouseRob.cancelRob", true)
addEventHandler ("GTIhouseRob.cancelRob", root, cancelMission)

-- Export exports.GTIhouseRob.isPlayerRobbing ( player )
function isPlayerRobbing(player)
    local isRobbing = getElementData(player, "GTIhouseRob.isPlayerRobbing")
    if (isRobbing == true) then
        return true
	else
        return false
    end    
end

function cmd ()
    dim = getElementDimension ( localPlayer )
	int = getElementInterior ( localPlayer )
	outputDebugString ("Int: "..int.." Dim: "..dim)
end
addCommandHandler ("abc", cmd )