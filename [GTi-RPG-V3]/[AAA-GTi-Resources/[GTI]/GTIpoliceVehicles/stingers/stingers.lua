----------------------------------------->>
-- GTI: Grand Theft International
-- Author: ZoLo, [RcF]Ghost (MTA)
-- Date: 07 Sept 2009
-- Resource: GTIpoliceVehicles/stinger.lua
-- Version: 1.0
----------------------------------------->>

function getPositionFromElementAtOffset(element,x,y,z)
	if not x or not y or not z then      
		return x, y, z   
	end        
	local matrix = getElementMatrix ( element )
	local offX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
	local offY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
	local offZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
	return offX, offY, offZ
end

function getVehicleWheelPosition(vehicle, wheel)
	if (not isElement(vehicle)) then return false end
	local x, y, z = 0, 0, 0
	local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(vehicle)
	if wheel == 1 then
		x, y, z = getPositionFromElementAtOffset(vehicle, minX, maxY, minZ)
	elseif wheel == 2 then
		x, y, z = getPositionFromElementAtOffset(vehicle, minX, -maxY, minZ)		
	elseif wheel == 3 then
		x, y, z = getPositionFromElementAtOffset(vehicle, maxX, maxY, minZ)
	elseif wheel == 4 then
		x, y, z = getPositionFromElementAtOffset(vehicle, maxX, -maxY, minZ)
	end	 
	return x, y, z
end

addEventHandler("onClientRender", root, function()
	if (not isPedInVehicle(localPlayer)) then return end
	if ((getElementData(localPlayer, "wanted") or 0) == 0) then return end
	
	vehicle = getPedOccupiedVehicle(localPlayer)
	g_Stingers = getElementsByType("object", resourceRoot)
	
	local wx1, wy1, wz1 = getVehicleWheelPosition(vehicle,1)
	local wx2, wy2, wz2 = getVehicleWheelPosition(vehicle,2)
	local wx3, wy3, wz3 = getVehicleWheelPosition(vehicle,3)
	local wx4, wy4, wz4 = getVehicleWheelPosition(vehicle,4)
	
	if (not wx1) then return end
	
	-- for visual debug wheel positions
	--dxDrawLine3D(wx1, wy1, wz1, wx2, wy2, wz2, tocolor(0,255,0))
	--dxDrawLine3D(wx3, wy3, wz3, wx4, wy4, wz4, tocolor(0,255,0))
	
	for k, v in ipairs(g_Stingers) do
		if (getElementData(v,"isStinger")) then
			local vx, vy, vz = getElementPosition(v)
			if getDistanceBetweenPoints3D(wx1, wy1, wz1, vx, vy, vz) <= 2.0 then
				setVehicleWheelStates(vehicle, 1, -1, -1, -1)	
			end
			if getDistanceBetweenPoints3D(wx2, wy2, wz2, vx, vy, vz) <= 2.0 then
				setVehicleWheelStates(vehicle, -1, 1, -1, -1)	
			end
			if getDistanceBetweenPoints3D(wx3, wy3, wz3, vx, vy, vz) <= 2.0 then
				setVehicleWheelStates(vehicle, -1, -1, 1, -1)	
			end
			if getDistanceBetweenPoints3D(wx4, wy4, wz4, vx, vy, vz) <= 2.0 then
				setVehicleWheelStates(vehicle, -1, -1, -1, 1)	
			end		
		end										
	end
end)
