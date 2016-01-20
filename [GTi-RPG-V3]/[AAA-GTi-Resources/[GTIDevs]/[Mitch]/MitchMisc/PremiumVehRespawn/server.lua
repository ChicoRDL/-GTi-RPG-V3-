local callVehicleInfoOcc = {}	-- Records of instances of callVehicleInfo
local vehStatRunning = {}		-- Records of instances of callVehicleStatInfo

function callVehicleInfo()
	if not (exports.GTIpremium:isPremium(client, "veh_recover")) then exports.GTIhud:dm("This is a premium feature, buy it in the token store!", client, 255, 0, 0) return end
	if (callVehicleInfoOcc[client]) then return end
	callVehicleInfoOcc[client] = true
	
	local account = getPlayerAccount(client)
		
		-- Player Owned Vehicle Info
	local vehData = exports.GTIvehicles:getAllVehicleOwnerData(account) or {}
	local vehTable = {}
	for vehKey,vehID in pairs(vehData) do
		local int = string.gsub(vehKey, "vehicle", "")
		local int = tonumber(int)
		if (int) then
			vehTable[int] = {}
			vehTable[int][1] = exports.GTIvehicles:getVehicleData(vehID, "vehicleID")
			vehTable[int][2] = exports.GTIvehicles:getVehicleData(vehID, "health")
			if (exports.GTIvehicles:isVehicleSpawned(vehID)) then
				vehTable[int][4] = true
				vehicle = exports.GTIvehicles:getVehicleByID(vehID)
				vehTable[int][2] = getElementHealth(vehicle)
			end
			vehTable[int][5] = vehID
		end
	end
	
	triggerClientEvent(client, "MitchMisc.returnVehicleInfo", client, vehTable)
	callVehicleInfoOcc[client] = nil
end
addEvent("MitchMisc.callVehicleInfo", true)
addEventHandler("MitchMisc.callVehicleInfo", root, callVehicleInfo)

local spawnVehRunning = {}

function spawnPlayerVehicle(slot, row)
	if (spawnVehRunning[client]) then return end
	local vehID = exports.GTIvehicles:getVehicleIDFromSlot(client, slot)
	exports.GTIvehicles:spawnPlayerVehicle(client, slot)
	local vehicle = exports.GTIvehicles:getVehicleByID(vehID)
	local x, y, z = getElementPosition ( client )
	setElementPosition ( vehicle, x, y, z )
	warpPedIntoVehicle ( client, vehicle )
	spawnVehRunning[client] = true
	triggerClientEvent(client, "MitchMisc.returnVehicleThatIsSpawned", client, row, 2)
	spawnVehRunning[client] = nil
end
addEvent("MitchMisc.spawnPlayerVehicle", true)
addEventHandler("MitchMisc.spawnPlayerVehicle", root, spawnPlayerVehicle)
