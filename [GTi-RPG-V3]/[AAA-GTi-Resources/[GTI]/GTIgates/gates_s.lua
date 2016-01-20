colData = {}

function getGateSetting( theGate, theSetting)
	if colData[theGate] then
		return colData[theGate][theSetting]
	else
		return false
	end
end

function performGateMovement( theGate, X, Y, Z, moveType, theElement, checkSettings)
	if checkSettings then
		local vehicleEntry = getGateSetting( theGate, "vehAllowed")
		if isPedInVehicle( theElement) then
			if vehicleEntry == true or vehicleEntry == "true" then
				moveObject( theGate, 1000, X, Y, Z, 0, 0, 0, moveType)
			end
		else
			moveObject( theGate, 1000, X, Y, Z, 0, 0, 0, moveType)
		end
	else
		moveObject( theGate, 1000, X, Y, Z, 0, 0, 0, moveType)
	end
end

addEventHandler( "onResourceStart", resourceRoot,
	function()
		gates = exports.GTIgatesTable:getGatesTable()
		for index, gate in ipairs (gates) do
			local x, y, z = gate.pos[1], gate.pos[2], gate.pos[3]
			local moveX, moveY, moveZ = gate.move[1], gate.move[2], gate.move[3]
			local rotX, rotY, rotZ = gate.rot[1], gate.rot[2], gate.rot[3]
			local id, size = gate.model, gate.size
			local int, dim = gate.world[1], gate.world[2]
			local fX, fY, fZ = gate.forceCenter[1], gate.forceCenter[2], gate.forceCenter[3]
			local team, job = gate.lock[1], gate.lock[2]
			local settings = gate.settings
			--
			if gate.animation[1] and gate.animation[2] then
				start, leave = gate.animation[1], gate.animation[2]
			else
				start, leave = "Linear", "Linear"
			end
			if gate.res then
				if gate.res.team then
					team = gate.res.team[1]
				end
			end
			if gate.res then
				if gate.res.job then
					job = gate.res.job[1]
				end
			end
			local gate = createObject( id, x, y, z, rotX, rotY, rotZ)
			--
			if fX ~= 0 then
				col = createColSphere( fX, fY, fZ+.025, size)
			else
				col = createColSphere( x, y, z+.025, size)
			end
			setElementInterior( gate, int)
			setElementDimension( gate, dim)
			setElementInterior( col, int)
			setElementDimension( col, dim)
			-->> Take Down Gate Settings
			if not colData[gate] then
				colData[gate] = {}
			end
			if #settings > 1 then
				for i, gateSetting in pairs ( settings) do
					local setData = split( gateSetting, ";")
					local settingName = setData[1]
					local settingValue = setData[2]
					colData[gate][settingName] = settingValue
				end
			else
				local setData = split( settings[1], ";")
				local settingName = setData[1]
				local settingValue = setData[2]
				colData[gate][settingName] = settingValue
			end
			--
            addEventHandler("onColShapeHit", col,
                function( hitElement)
					if (not isElement(hitElement) or getElementType(hitElement) ~= "player") then return end
					if team and team ~= "" then
					if (not team == "Group") then
						local hitTeam = getPlayerTeam( hitElement)
						if not hitTeam then return end
						local teamName = getTeamName( hitTeam)
					else
						if ( tonumber(job) == exports.GTIgroups:getPlayerGroup(hitElement) ) then
							return	performGateMovement( gate, moveX, moveY, moveZ, start, hitElement, true)
						else
							return
						end
					end						
						if team == teamName then
							if job and job ~= "" then
								local jobName = getElementData( hitElement, "Occupation") or getElementData( hitElement, "job")
								if job == jobName then
									performGateMovement( gate, moveX, moveY, moveZ, start, hitElement, true)
								end
							else
								performGateMovement( gate, moveX, moveY, moveZ, start, hitElement, true)
							end
						end
					elseif job and job ~= "" then
						local jobName = getElementData( hitElement, "Occupation") or getElementData( hitElement, "job")
						if job == jobName then
							performGateMovement( gate, moveX, moveY, moveZ, start, hitElement, true)
						end
					else
						performGateMovement( gate, moveX, moveY, moveZ, start, hitElement, true)
                    end
                end
            )
			--
            addEventHandler("onColShapeLeave", col,
                function( leaveElement)
					performGateMovement( gate, x, y, z, leave, leaveElement, false)
					--[[
					if team and team ~= "" then
						local leaveTeam = getPlayerTeam( leaveElement)
						if not leaveTeam then return end
						local teamName = getTeamName( leaveTeam)
						if team == teamName then
							if job and job ~= "" then
								local jobName = getElementData( leaveElement, "job")
								if job == jobName then
									moveObject( gate, 1000, x, y, z, 0, 0, 0, leave)
								end
							else
								moveObject( gate, 1000, x, y, z, 0, 0, 0, leave)
							end
						end
					elseif job and job ~= "" then
						local jobName = getElementData( leaveElement, "job")
						if job == jobName then
							moveObject( gate, 1000, moveX, moveY, moveZ, 0, 0, 0, start)
						end
					else
						moveObject( gate, 1000, x, y, z, 0, 0, 0, leave)
                    end
					--]]
                end
            )
		end
	end
)
