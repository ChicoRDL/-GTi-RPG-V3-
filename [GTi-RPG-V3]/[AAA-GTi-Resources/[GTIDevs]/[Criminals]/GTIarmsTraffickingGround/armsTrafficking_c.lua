----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: armsTrafficking_c.lua
-- Version: 1.0
----------------------------------------->>

isRobbing = false

allowedCars = {
    [568] = true, -- Bandito   
	[495] = true, -- Sandking
	[468] = true, -- Sanchez
}

-- Ground Trafficking
local locations = {
{316.914, 893.261, 19.406},
{-689.079, 937.606, 12.633},
{-1478.000, 1879.467, 31.633},
{-1950.918, 2370.373, 48.492},
{-2185.533, 2784.402, 165.096},
{-1300.109, 2527.489, 86.590},
{-868.122, 2308.661, 159.984},
{-427.841, 2213.623, 41.430},
{825.326, 2688.376, 39.137},
{710.485, 1985.586, 2.502},
{774.109, 1282.927, 22.442},
{578.424, 894.213, -44.492},
{811.923, 369.193, 18.329},
{326.985, 53.640, 2.342},
{211.910, 24.770, 1.571},
{-541.343, -74.510, 61.859},
{-733.689, -99.116, 69.284},
{158.379, 644.839, 0.936},
{-582.142, 630.888, 15.820},
{1089.194, 1074.582, 9.836},
{-454.332, 613.497, 15.761},
{-929.524, 2045.094, 60.388},
{-781.137, 2106.852, 59.383},
{-781.533, 2147.883, 59.383},
{-789.611, 2419.374, 156.076},
{-734.494, 2756.871, 46.227},
{-246.931, 2605.377, 65.327},
{258.148, 2938.349, 0.766}
}

local delivery = {
{-722.480, 1535.999, 39.323},
{-2232.163, 2297.908, 4.402},
{1528.315, 2815.711, 9.820},
{-309.981, 1531.691, 74.359},
{1413.129, 673.111, 9.820},
{405.111, 2539.053, 15.546}
}

function convertSecsToTime(seconds)
		local hours = 0
		local minutes = 0
		local secs = 0
		local theseconds = seconds
		if theseconds >= 60*60 then
			hours = math.floor(theseconds / (60*60))
			theseconds = theseconds - ((60*60)*hours)
		end
		if theseconds >= 60 then
			minutes = math.floor(theseconds / (60))
			theseconds = theseconds - ((60)*minutes)
		end
		if theseconds >= 1 then
			secs = theseconds
		end
		if minutes < 10 then
		minutes = "0"..minutes
		end
		if secs < 10 then
		secs = "0"..secs
		end
	return minutes,secs
end

function startNextMission ( player )
    if ( player == localPlayer and isRobbing == false ) then
	    loc = math.random ( #locations )
	    ammoBox = createObject ( 3800, locations[loc][1], locations[loc][2], locations[loc][3], 0, 0, 0, true )
		ammoMarker = createMarker ( locations[loc][1], locations[loc][2], locations[loc][3], "cylinder", 1, 0, 0, 0 )
		ammoBlip = createBlipAttachedTo ( ammoMarker, 0, 3, 200, 0, 0 )
		ammoTimer = setTimer ( timer, 160000, 1 )
		exports.GTIhud:dm("Pickup the ammo package, you got 2 minutes and 30 seconds + 10 bonus seconds!", 200, 0, 0 )
		addEventHandler ("onClientMarkerHit", ammoMarker, deliverAmmoBox )
		isRobbing = true
		seconds = 160
		timer1 = setTimer ( timerCountDown, 1000, 160 )
	end
end

function startNewMission ( )
    if ( isRobbing == false ) then
	    --local jo = exports.GTIemployment:getPlayerJob ( true )
        if ( exports.AresMisc:isAbleToCrime ( localPlayer )) then
		exports.GTIhud:drawNote('trafBind', '' , 255, 0, 0, 0)
		unbindKey( 'N', 'down', startNewMission)
	        loc = math.random ( #locations )
			ammoBox = createObject ( 3800, locations[loc][1], locations[loc][2], locations[loc][3], 0, 0, 0, true )
			ammoMarker = createMarker ( locations[loc][1], locations[loc][2], locations[loc][3], "cylinder", 1, 0, 0, 0 )
			ammoBlip = createBlipAttachedTo ( ammoMarker, 0, 3, 200, 0, 0 )
			ammoTimer = setTimer ( timer, 150000, 1 )
			exports.GTIhud:dm("Pickup the ammo package, you got 2 minutes and 30 seconds!", 200, 0, 0 )
			addEventHandler ("onClientMarkerHit", ammoMarker, deliverAmmoBox )
			isRobbing = true
			seconds = 150
			timer1 = setTimer ( timerCountDown, 1000, 150 )
		end
	end
end

function startMission ( player, seat )
    if ( allowedCars [getElementModel(source)] and isRobbing == false and player == localPlayer and seat == 0 ) then
	    --local job = exports.GTIemployment:getPlayerJob ( true )
        if ( exports.AresMisc:isAbleToCrime ( player ) and seat == 0 ) then
		exports.GTIhud:drawNote('trafBind', 'Press [N] to start the mission' , 255, 0, 0, 10000)
		bindKey ( 'N','down', startNewMission )
	end
    end
end
addEventHandler ("onClientVehicleEnter", root, startMission )

addEventHandler ("onClientVehicleExit", root, 
	function ( player ) 
		if ( allowedCars [ getElementModel ( source) ] and isRobbing == false and player == localPlayer ) then 
			exports.GTIhud:drawNote('trafBind', '' , 255, 0, 0, 0)
			unbindKey ( 'N', 'down', startNewMission ) 
		end 
	end 
)


function timerCountDown()
	    seconds = seconds - 1
		local mins,secds = convertSecsToTime(seconds)
            if mins == "00" and secds == "00" then --time is up
            exports.GTIhud:drawStat("armstraffic", "Time left", "N/A", 200, 0, 0, 15000)
        else
            exports.GTIhud:drawStat("armstraffic", "Time left", mins..":"..secds, 200, 0, 0)
        end
	end

function timer ( player )
	destroyElement ( ammoBox )
	destroyElement ( ammoMarker )
	destroyElement ( ammoBlip )
	triggerServerEvent ("GTIarmsTrafficking_wantedLevel", localPlayer )
	isRobbing = false
	exports.GTIhud:dm("You failed, the Police noticed you!", 200, 0, 0 )
	exports.GTIhud:drawStat("armstraffic", "", "", 200, 0, 0)
end

function deliverAmmoBox ( player, veh )
    if ( player == localPlayer and not isPedInVehicle ( localPlayer ) ) then
	    if ( isTimer ( ammoTimer ) ) then killTimer ( ammoTimer )
		if ( isTimer ( timer1 ) ) then killTimer ( timer1 )
		    exports.GTIhud:drawStat("armstraffic", "", "", 200, 0, 0)
	        loca = math.random ( #delivery )
		    deliveryMarker = createMarker ( delivery[loca][1], delivery[loca][2], delivery[loca][3], "cylinder", 3, 200, 0, 0, 125 )
			deliveryBlip = createBlipAttachedTo ( deliveryMarker, 51 )
			exports.GTIhud:dm("You got the ammo package, deliver it to your next location", 200, 0, 0 )
			destroyElement ( ammoBox )
		    destroyElement ( ammoMarker )
		    destroyElement ( ammoBlip )
			addEventHandler ("onClientMarkerHit", deliveryMarker, payOut )
			addEventHandler ("onClientMarkerHit", deliveryMarker, startNextMission )
			end
		end
	end
end

function payOut ( player )
    if ( player == localPlayer and isPedInVehicle ( localPlayer ) ) then
	    fadeCamera ( false, 2.5, 0, 0, 0 )
        setTimer ( fadeCamera, 3000, 1, true, 2.5 )
		local veh = getPedOccupiedVehicle ( localPlayer )
		setElementFrozen ( veh, true )
		isRobbing = false
		destroyElement ( deliveryMarker )
		destroyElement ( deliveryBlip )
		setTimer ( unfreezeVeh, 3000, 1 )
		toggleControl ( "enter_exit", false )
		triggerServerEvent ("GTIarmsTrafficking_payOut", localPlayer )
	end
end

function unfreezeVeh ( )
    local veh = getPedOccupiedVehicle ( localPlayer )
    setElementFrozen ( veh, false )
	toggleControl ( "enter_exit", true )
end

function stopMission ( )
    if ( isRobbing == true ) then
		exports.GTIhud:drawStat("armstraffic", "", "", 200, 0, 0)
		isRobbing = false
	    if isElement ( ammoBox ) then
		    destroyElement ( ammoBox )
		end
		if isElement ( ammoMarker ) then
		    destroyElement ( ammoMarker )
		end
		if isElement ( ammoBlip ) then
		    destroyElement ( ammoBlip )
		end
		if isElement ( deliveryMarker ) then
		    destroyElement ( deliveryMarker )
		end
		if isElement ( deliveryBlip ) then
		    destroyElement ( deliveryBlip )
		end
		removeEventHandler ("onClientVehicleEnter", root, startMission )
		--removeEventHandler ("onClientVehicleEnter", root, startNewMission )
		--addEventHandler ("onClientVehicleEnter", root, startNewMission )
		if ( isTimer ( ammoTimer ) ) then killTimer ( ammoTimer )
			if ( isTimer ( timer1 ) ) then killTimer ( timer1 )
			end
		end
	end
end
addEvent ("GTIarmsTrafficking.onVehicleHide", true )
addEventHandler ("GTIarmsTrafficking.onVehicleHide", root, stopMission )

addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
	if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
		return true
	else
		return stopMission ( )
	end
end
)
addEventHandler ("onClientPlayerGetJob", root, 
function ( jobName ) 
	if jobName == "Criminal" then 
		return true
	else
		return stopMission ( )
	end
end
)
addEventHandler ("onClientPlayerWasted", root, stopMission )
