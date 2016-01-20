function startAlarm( alarm_loc, dim)
	if alarm_loc then
		local adata = split( alarm_loc, ",")
		local x, y, z = adata[1], adata[2], adata[3]

		local sound = playSound3D( "alarm.mp3", x, y, z)
		setSoundMaxDistance(sound, 200)
		setElementDimension(sound, dim)
	else
		playSound( "alarm.mp3")
	end
end
addEvent( "GTIcnr.startAlarm", true)
addEventHandler( "GTIcnr.startAlarm", root, startAlarm)

-- Cancel CnR Damage

function cancelDamage(attacker, wep, part, loss)
    if (getElementDimension(source) == 801 or getElementDimension(source) == 5) then
		-- Cancel Criminal to Criminal
        if (exports.GTIUtil:isPlayerInTeam(source, "Criminals") and exports.GTIUtil:isPlayerInTeam(attacker, "Criminals")) then
            cancelEvent(true)
		-- Cancel Police to Police
        elseif (exports.GTIUtil:isPlayerInTeam(attacker, "Law Enforcement") and exports.GTIUtil:isPlayerInTeam(source, "Law Enforcement")) then
            cancelEvent(true)
		-- Cancel Criminal to Medic
        elseif (exports.GTIUtil:isPlayerInTeam(source, "Criminals") and exports.GTIUtil:isPlayerInTeam(attacker, "Emergency Services")) then
            cancelEvent(true)
		-- Cancel Police to Medic
        elseif (exports.GTIUtil:isPlayerInTeam(attacker, "Law Enforcement") and exports.GTIUtil:isPlayerInTeam(source, "Emergency Services")) then
            cancelEvent(true)
		-- Cancel Medic to Police
        elseif (exports.GTIUtil:isPlayerInTeam(source, "Emergency Services") and exports.GTIUtil:isPlayerInTeam(attacker, "Law Enforcement")) then
            cancelEvent(true)
		-- Cancel Medic to Criminals
        elseif (exports.GTIUtil:isPlayerInTeam(attacker, "Emergency Services") and exports.GTIUtil:isPlayerInTeam(source, "Criminals")) then
            cancelEvent(true)
        end
    end
end
addEventHandler("onClientPlayerDamage", root, cancelDamage)
