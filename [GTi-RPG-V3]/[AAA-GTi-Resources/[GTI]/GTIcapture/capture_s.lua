local IS_CAR_SPAWNED = false

local locations = {
{2114.471, 1989.784, 10.820},
}

function spawnCar ( )
    if IS_CAR_SPAWNED == true then return end
    local loc = math.random ( #locations )
	car = createVehicle ( 428, locations[loc][1], locations[loc][2], locations[loc][3] )
	local x,y,z = getElementPosition ( car )
    local zone = getZoneName ( x, y, z, false )
	sendmsg("A securicar has been spotted near a bank in "..zone)
	IS_CAR_SPAWNED = true
	for i,player in pairs ( getElementsByType ("player") ) do
	    if exports.GTIutil:isPlayerInTeam(player, "Criminals") or exports.GTIutil:isPlayerInTeam(player, "Law Enforcement") then
	        blip = createBlip (locations[loc][1], locations[loc][2], locations[loc][3], 51 )
		end
	end
end
setTimer ( spawnCar, 5000, 0 )

function sendmsg ( msg )
	for i,player in pairs ( getElementsByType ("player") ) do
		if exports.GTIutil:isPlayerLoggedIn ( player ) and exports.GTIutil:isPlayerInTeam(player, "Criminals") or exports.GTIutil:isPlayerInTeam(player, "Law Enforcement") then
		    local r, g, b = getPlayerNametagColor ( player )
			exports.GTIhud:dm ( msg, player, r, g, b )
		end
	end
end