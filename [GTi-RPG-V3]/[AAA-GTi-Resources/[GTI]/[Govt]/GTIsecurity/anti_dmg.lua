
-- Anti Damage

t = {
	["Government"] = true,
}

a = {
	["Criminals"] = true,
	["Law Enforcement"] = true,
}

addEventHandler( "onClientVehicleDamage", root,
	function()
		if getVehicleController( source) then
			local player = getVehicleController( source)
			if getElementType( player) == "player" then
				local team = getTeamName( getPlayerTeam( player))
				if t[team] then
					local occupants = getVehicleOccupants( source)
					--if #occupants == 1 then
						--cancelEvent( true)
					--else
						for seat, occupant in ipairs ( occupants) do
							if occupant and getElementType( occupant) == "player" then
								local teams = getTeamName( getPlayerTeam( occupant))
								if not a[teams] then
									cancelEvent( true)
								end
							end
						end
					--end
				end
			end
		end
	end
)
