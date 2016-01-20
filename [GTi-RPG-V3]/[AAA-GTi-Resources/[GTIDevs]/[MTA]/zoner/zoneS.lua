addEvent('zone:saveZoneFile', true)
addEventHandler('zone:saveZoneFile', root,
function(script)
	local file = fileOpen('zone.txt', false)
	if not file then
		file = fileCreate('zone.txt')
	end
	fileWrite(file, script)
	fileClose(file)
	outputChatBox('Zone file saved!', source, 0, 240, 0, false)
end)