medicOccuption = {
	["Paramedic"] = true,
}

medicSkins = { 
	[274] = true,
	[275] = true,
	[276] = true,
}

validWeapons = {
	[41] = true,
}

lastattacker = {}

addEventHandler( "onClientPlayerDamage", localPlayer,
	function( attacker, weapon, bodypart, loss)
		if attacker then
			if (attacker ~= localPlayer and getElementType( attacker) == "player" and medicOccuption[getElementData( attacker, "job")]) and medicSkins [ getElementModel ( attacker ) ] then
				cancelEvent(true)
				if (validWeapons[weapon]) then
					if (not isTimer( pause)) then
						local health = getElementHealth( localPlayer)
						if (health < math.ceil(exports.GTIutil:getPedMaxHealth(localPlayer))) then
							triggerServerEvent( "onPlayerMedicHeal", localPlayer, attacker)
							pause = setTimer( function() end, 500, 1)
						end
					end
				end
			end
		end
	end
)
