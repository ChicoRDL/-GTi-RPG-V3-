local headshotWeaps = {[33] = true, [34] = true}
function setHeadshotsEnabled(attacker, weapon, bodypart)
	if (not headshotWeaps[weapon]) then return end

	local x1,y1 = getElementPosition(source)
	local x2,y2 = getElementPosition(attacker)
	local distance = getDistanceBetweenPoints2D(x1,y1, x2,y2)
	if (distance < 105) then return end

	if (bodypart == 9) then
		killPed(source, attacker, weapon, bodypart)
		exports.GTIstats:modifyStatData ( getPlayerAccount ( attacker ), "headshot_kills", 1 )
		setPedHeadless(source, true)
	end
end
addEventHandler("onPlayerDamage", root, setHeadshotsEnabled)

function returnHeadOnSpawn()
	setPedHeadless(source, false)
end
addEventHandler("onPlayerSpawn", root, returnHeadOnSpawn)