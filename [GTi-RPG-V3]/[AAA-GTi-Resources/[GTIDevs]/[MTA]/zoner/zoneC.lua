local rendering = false
local pos

addCommandHandler('createzone',
function()
	rendering = true
	pos = {getElementPosition(localPlayer)}
	if rendering then removeEventHandler('onClientPreRender', root, renderZoneCreation) end
	addEventHandler('onClientPreRender', root, renderZoneCreation)
	outputChatBox('== Zone Creation Commands ==', 255, 200, 0, false)
	outputChatBox('/showcol : Toggle zone preview', 255, 200, 0, false)
	outputChatBox('/savezone : Saves the zone', 255, 200, 0, false)
	outputChatBox('/destroyzone : Destroys the zone', 255, 200, 0, false)
	outputChatBox('==========================', 255, 200, 0, false)
end)

addCommandHandler('savezone',
function()
	if not rendering then outputChatBox('Create a zone first!', 240, 0, 0, false) return end
	removeEventHandler('onClientPreRender', root, renderZoneCreation)
	showZoneOutputGUI()
end)

addCommandHandler('destroyzone',
function()
	if not rendering then outputChatBox('Create a zone first!', 240, 0, 0, false) return end
	rendering = false
	if isElement(zone) then destroyElement(zone) end
	removeEventHandler('onClientPreRender', root, renderZoneCreation)
end)

function renderZoneCreation()
	x, y, z = unpack(pos)
	local cx, cy, cz = getElementPosition(localPlayer)
	w, d, h = cx-x, cy-y, cz-z+1.9
	if isElement(zone) then destroyElement(zone) end
	zone = createColCuboid(x, y, z-1, w, d, h)
end

local zone = {}
function showZoneOutputGUI()
	if zone['window'] then destroyElement(zone['window']) zone['window'] = nil end
	zone['window'] = guiCreateWindow(398,157,540,483,"Zone Creation :: Output",false)
	--zone['memo'] = guiCreateMemo(10,25,520,371,[[	{ "]]..getZoneName( x, y, z)..[[", ]]..string.format('%.3f', x)..[[, ]]..string.format('%.3f', y)..[[, ]]..string.format('%.3f', w)..[[, ]]..string.format('%.3f', d)..[[},]],false,zone['window'])
	zone['memo'] = guiCreateMemo(10,25,520,371,[[	{ "]]..string.format('%.3f', x)..[[, ]]..string.format('%.3f', y)..[[, ]]..string.format('%.3f', z)..[[, ]]..string.format('%.3f', w)..[[, ]]..string.format('%.3f', d)..[[, ]]..string.format('%.3f', h)..[[},]],false,zone['window'])
	--zone['save'] = guiCreateButton(10,406,255,28,'Save to file zone.txt',false,zone['window'])
	zone['copy'] = guiCreateButton(275,406,255,28,'Copy to clipboard',false,zone['window'])
	zone['refresh'] = guiCreateButton(10,444,255,28,'Refresh',false,zone['window'])
	zone['close'] = guiCreateButton(275,444,255,28,'Close',false,zone['window'])
	guiMemoSetReadOnly(zone['memo'],true)
	guiWindowSetSizable(zone['window'],false)
	guiSetAlpha(zone['window'],0.759)
	centerWindow(zone['window'])
	addEventHandler('onClientGUIClick', zone['window'], handleZoneButton)
	showCursor(true)
end

function handleZoneButton(button, state)
	if button == 'left' and state == 'up' then
		if source == zone['save'] then
			triggerServerEvent('zone:saveZoneFile', localPlayer, guiGetText(zone['memo']))
		elseif source == zone['copy'] then
			setClipboard(guiGetText(zone['memo']))
			outputChatBox('Copied to clipboard!', 0, 240, 0, false)
		elseif source == zone['refresh'] then
			if isTimer(refreshTimer) then return end
			refreshTimer = setTimer(showZoneOutputGUI, 350, 1)
			guiSetText(zone['memo'], "")
		elseif source == zone['close'] then
			destroyElement(zone['window'])
			zone['window'] = nil
			showCursor(false)
		end
	end
end

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

setDevelopmentMode(true)
