
-- Hourly Distance: 100,515 meters

addEvent("GTIMariner.getpaid", true)
addEventHandler("GTIMariner.getpaid", root, function(distance, dist)
	local payOffset = exports.GTIemployment:getPlayerJobPayment(client, "Mariner")
	local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
	local hrExp = exports.GTIemployment:getHourlyExperience(client)
	 
	local progress = tonumber(string.format("%.3f", dist/1609))
	local pay = math.ceil( distance*payOffset )
	local Exp = math.ceil( (pay/hrPay)*hrExp )
	 
	exports.GTIemployment:modifyPlayerJobProgress(client, "Mariner", progress)
	exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Mariner")
	exports.GTIemployment:givePlayerJobMoney(client, "Mariner", pay)
end)

function onEnter ( thePlayer, seat, jacked )
    if isElement(source) and ( getElementModel ( source ) == 446 or getElementModel ( source ) == 452 ) 
		and ( (exports.GTIrentals:getPlayerRentalVehicle(thePlayer) == source) or exports.GTIvehicles:getVehicleOwner(source) == thePlayer and seat == 0) then
		triggerClientEvent ( thePlayer, "GTIMariner.getMission", resourceRoot )
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), onEnter )

local vehicle = {}

addEvent ("GTImariner_SpawnBoatOnJob", true )
addEventHandler ("GTImariner_SpawnBoatOnJob", root,
	function ( player )
		if ( isElement(vehicle[client]) ) then return false end
		vehicle[client] = createVehicle ( 452, -1571.275, 1257.130, 1.550, 90, 0, 0 )
		warpPedIntoVehicle ( client, vehicle[client] )
	end
)

addEventHandler ("onVehicleExit", root,
	function ( player )
		if (exports.GTIemployment:getPlayerJob(player, true) ~= "Mariner") then return end
		if isElement ( vehicle[player] ) then
			destroyElement (vehicle[player] )
			vehicle[player] = nil
		end
	end
)