local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25
local serials = {}
local tempTable = {}
addEvent("GTIBettingStoreRob.rob", true)
addEventHandler("GTIBettingStoreRob.rob", root, function(tablec)
	tempTable[client] = tablec
	for i,v in ipairs(tempTable[client]) do
		local serial = getPlayerSerial(v)
		if not isElement(v) or (getPlayerIdleTime(v) > 300000) or (exports.GTIemployment:getPlayerJob(v,true) ~= "Criminal") or serials[serial] then
			table.remove(tempTable[client],i)
		end
	end
	if (#tempTable[client]) < 3 then--3
		exports.GTIhud:dm("There isn't enough criminals to rob.", client, 200, 10, 0 )
		tempTable[client] = nil
		return false
	end
	local name = getPlayerName(client)
	for i,v in ipairs(tempTable[client]) do
		if isElement(v) then
			local serial = getPlayerSerial(v)
			if not serials[serial] then
				exports.GTIpoliceWanted:chargePlayer(v, 24)
				serials[serial] = true
				setTimer(function(serial)
				serials[serial] = nil
				end, 360000, 1, serial)
				triggerClientEvent(v,"GTIBettingStoreRob.start",resourceRoot,name)
			end
		end
	end
    exports.GTIanims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
	tempTable[client] = nil
end)

addEvent ("GTIBettingStoreRob.pay", true )
addEventHandler ("GTIBettingStoreRob.pay", root,
    function()
		local pay = math.random(985*LOWER_BOUND, 985*UPPER_BOUND)
        exports.GTIcriminals:givePlayerTaskMoney(client, "Store Robbery", pay)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 293, "Store Robbery")
	end
)

addEvent ("GTIBettingStoreRob.store", true )
addEventHandler ("GTIBettingStoreRob.store", root,
    function()
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Store Robbery", 1)
	end
)