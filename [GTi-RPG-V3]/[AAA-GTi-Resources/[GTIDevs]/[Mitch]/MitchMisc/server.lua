local MIN_GANGSTER_DISTANCE = 125
local MIN_SWAT_DISTANCE = 125

function isPlayerNearGangster ( player )
	local x1, y1, z1 = getElementPosition ( player )
	for k, gangster in ipairs ( getElementsByType ( "player" ) ) do
		local x2, y2, z2 = getElementPosition ( gangster )
		if ( getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= MIN_GANGSTER_DISTANCE ) then
			if exports.GTIgroups:arePlayersInSameGroup(player, gangster) then return false end
			if ( exports.GTIgangTerritories:isGangster ( gangster ) ) then return true end
		end
	end
	return false
end

function isPlayerNearSWAT ( player )
	local x1, y1, z1 = getElementPosition ( player )
	for k, SWAT in ipairs ( getElementsByType ( "player" ) ) do
		local x2, y2, z2 = getElementPosition ( SWAT )
		if ( getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= MIN_SWAT_DISTANCE ) then
			if exports.GTIgroups:arePlayersInSameGroup(player, SWAT) then return false end
			if ( exports.GTIgangTerritories:isSWAT ( SWAT ) ) then return true end
		end
	end
	return false
end