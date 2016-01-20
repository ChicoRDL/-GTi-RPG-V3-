----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: hospitalHP.lua
-- Version: 1.0
----------------------------------------->>

local coords = {
{1376.080, 716.382, 0.135}, -- GHoST
{1111.306, -325.838, 72.992}, -- TriForce
{2550.640, 617.452, 15.286}, -- Q7
{1958.463, -1280.316, 12.643}, -- CIA
}

function pickups ( )
    for i, tableData in ipairs ( coords ) do
	   local x = tableData[1]
	   local y = tableData[2]
	   local z = tableData[3]
       ArmorMarker = createPickup ( x, y, z+1, 1, 100 )
	   addEventHandler ("onClientPickupHit", ArmorMarker, drawArmorNote )
	end
end
addEventHandler ("onClientResourceStart", resourceRoot, pickups )

function drawArmorNote ( player )
    if ( player == localPlayer and not isPedInVehicle ( localPlayer ) ) then
	local armor = math.floor( getPedArmor ( localPlayer ) )
	local price = 2500 - ( armor * 25 )
	local armorthToBuy = math.floor ( 100 - armor )
        exports.GTIhud:drawNote ("armorHP", "Press [Z] To Buy "..armorthToBuy.." Armor for $"..exports.GTIutil:tocomma(price), 0, 204, 204 )
        bindKey ("Z", "down", armorth )
    end    
end    

function unbindKKey ( player )
    if ( player == localPlayer ) then
        unbindKey ("Z", "down", armorth )
        exports.GTIhud:drawNote ("armorHP", "", 0, 204, 204 )
    end    
end
addEventHandler("onClientPickupLeave", root, unbindKKey)

function armorth ( ) 	
	triggerServerEvent ("GTIarmor.armor", localPlayer )
	--triggerServerEvent ("GTIhospitalHP_payOutMedics", localPlayer )
end