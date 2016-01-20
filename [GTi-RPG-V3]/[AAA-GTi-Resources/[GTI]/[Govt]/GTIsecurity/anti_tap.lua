frozen = false
tag = false
lagX, lagY, lagZ = 0, 0, 0
count = 0
lastByte = 0

ping = {}

function lagFreezePlayer(theElement, theState, setPos)
	if theState then
		--count = count + 1
		if not frozen then
			frozen = true
			tag = true
			setElementFrozen(theElement, true)
			toggleAllControls(false)
		end
		if setPos then
			setElementPosition(theElement, lagX, lagY, lagZ)
		end
	else
		if frozen then
			frozen = false
			tag = false
			count = 0
			setElementFrozen(theElement, false)
			toggleAllControls(true)
		end
	end
end

teams = {
	['Criminals'] = true,
	['Law Enforcement'] = true,
}

setTimer(
	function()
		-- Packet Loss [Anti Tapper]
		--for i, localPlayer in ipairs (getElementsByType("player")) do
			local loss = getNetworkStats(localPlayer)["packetlossLastSecond"]
			local resend = getNetworkStats(localPlayer)["messagesInResendBuffer"]
			local bSent = getNetworkStats(localPlayer)["bytesSent"]
			local x, y, z = getElementPosition(localPlayer)

			local team = getPlayerTeam(localPlayer)
			local name = getTeamName(team)
			--local z = z + 0.5
			lagX, lagY, lagZ = x, y, z
			if loss > 50 and resend > 0 then
				if teams[name] then
					lagFreezePlayer(localPlayer, true, true)
				end
			--elseif lastByte == bSent then
				--lagFreezePlayer(localPlayer, true, true)
			else
				lagFreezePlayer(localPlayer, false)
			end
			lastByte = bSent
		--end
	end, 500, 0
)

setTimer(
	function()
		if frozen then
			count = count + 1
			if not tap then
				exports.GTIhud:drawNote("antitap", "Packet Loss Detected ["..count.."]", 255, 25, 25)
				--outputDebugString("Packet Loss Detected [Count: "..count.."]")
			end
		else
			exports.GTIhud:drawNote("antitap", "", 255, 25, 25, 1)
		end
	end, 1000, 0
)
