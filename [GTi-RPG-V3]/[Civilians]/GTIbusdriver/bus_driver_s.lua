----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 27 Jul 2014
-- Resource: GTIbusdriver/bus_driver.slua
-- Version: 1.0
----------------------------------------->>

local vehIDs = {
	[431] = 1.000,	-- Bus
		-- 142 stops/hour
	[437] = 1.000,	-- Coach
		-- 142 stops/hour
}

local TIME_BTWN_CHAT = 1000	-- How often a person can use the radio
local radioSpam = {}	-- Table of Last Radio Chat

-- Complete Mission
-------------------->>
	
function completeMission()
	local vehicle = getPedOccupiedVehicle(client)
	local vehOffset = vehIDs[getElementModel(vehicle)]
	local pay = exports.GTIemployment:getPlayerJobPayment(client, "Bus Driver")
	local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
	local hrExp = exports.GTIemployment:getHourlyExperience()
	
	local pay = math.ceil( pay * vehOffset )
	local Exp = math.ceil( (pay/hrPay)*hrExp 	* vehOffset )
	local pay = math.ceil( math.random( pay*0.9, pay*1.1 ) )
	
	exports.GTIemployment:modifyPlayerJobProgress(client, "Bus Driver", 1)
	exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Bus Driver")
	exports.GTIemployment:givePlayerJobMoney(client, "Bus Driver", pay)
end
addEvent("GTIbusdriver.completeMission", true)
addEventHandler("GTIbusdriver.completeMission", root, completeMission)

-- Job Radio
------------->>

function busDriverRadio(player, cmd, ...)
	if (exports.GTIemployment:getPlayerJob(player, true) ~= "Bus Driver") then return end
	if (radioSpam[player]) then 
		outputChatBox("You can only use the radio once every second.", player, 255, 25, 25)
	return end
	
	local message = table.concat({...}, " ")
	if (string.gsub(message, "%s", "") == "") then return end
	
	radioSpam[player] = true
	setTimer(function(player) radioSpam[player] = nil end, TIME_BTWN_CHAT, 1, player)
	
	for i,plr in ipairs(getElementsByType("player")) do
		if (exports.GTIemployment:getPlayerJob(plr, true) == "Bus Driver") then
			outputChatBox("* (RADIO): "..getPlayerName(player)..": #FFFFFF"..message..", over.", plr, 255, 175, 0, true)
		end
	end
end
addCommandHandler("r", busDriverRadio)
