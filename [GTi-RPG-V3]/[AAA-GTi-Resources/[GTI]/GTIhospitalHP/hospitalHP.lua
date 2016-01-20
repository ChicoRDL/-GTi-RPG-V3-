----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: hospitalHP.lua
-- Version: 1.0
----------------------------------------->>

local coords = {
{ 1164.534, -1320.798, 15.386 },
{ 2025.027, -1405.141, 17.208 },
{ 1252.321, 329.847, 19.758 },
{ -2205.684, -2289.708, 30.625 },
{ -2648.433, 635.640, 14.453 },
{ -1520.341, 2521.139, 55.866 },
{ -245.705, 2605.942, 62.858 },
{ -320.564, 1054.952, 19.742 },
{ 1624.337, 1817.905, 10.820 },
{ 1082.817, 3087.143, 26.645 },
{ 1955.258, -1280.291, 13.631 }, -- CIA
{ 1375.855, 721.101, 1.135 }, -- GHoST
{ 1104.535, -326.237, 73.992 }, -- TriForce
{2557.628, 612.374, 16.286}, -- Q7
}

function pickups ( )
    for i, tableData in ipairs ( coords ) do
	   local x = tableData[1]
	   local y = tableData[2]
	   local z = tableData[3]
       hpMarker1 = createPickup ( x, y, z, 0, 100 )
	   addEventHandler ("onClientPickupHit", hpMarker1, drawHealNote )
	end
end
addEventHandler ("onClientResourceStart", resourceRoot, pickups )

function drawHealNote ( player )
    if ( player == localPlayer and not isPedInVehicle ( localPlayer ) ) then
	local heal = math.floor( getElementHealth ( localPlayer ) )
	local price = 2000 - ( heal * 20 )
	local healthToBuy = math.floor ( 100 - heal )
        exports.GTIhud:drawNote ("healHP", "Press [Z] To heal "..healthToBuy.."HP for $"..exports.GTIutil:tocomma(price), 0, 204, 204 )
        bindKey ("Z", "down", health )
    end    
end    

function unbindKKey ( player )
    if ( player == localPlayer ) then
        unbindKey ("Z", "down", health )
        exports.GTIhud:drawNote ("healHP", "", 0, 204, 204 )
    end    
end
addEventHandler("onClientPickupLeave", root, unbindKKey)
addEvent ("GTIhospitalHP_cancel", true )
addEventHandler ("GTIhospitalHP_cancel", root, unbindKKey )

function health ( ) 	
	triggerServerEvent ("GTIhospitalHP.heal", localPlayer )
	--triggerServerEvent ("GTIhospitalHP_payOutMedics", localPlayer )
end
