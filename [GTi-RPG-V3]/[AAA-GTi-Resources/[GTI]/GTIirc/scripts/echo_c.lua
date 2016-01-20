local lastDebug = ""
function sendClientDebug(message, level, file, line)
	lastDebug = message
	if not string.match( lastDebug, message) then
		triggerServerEvent("GTIirc.sendClientDebug", localPlayer, message, level, file, line)
	end
end
addEventHandler("onClientDebugMessage", root, sendClientDebug)
