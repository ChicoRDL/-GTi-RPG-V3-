--[[
local lawCCR = {}
local lawCount = 0
local criminalsCCR = {}
local crimCountCCR = 0
local wanted = {}
local medicCountCCR = 0
local medics = {}
local preStarted = false
local started = false
local escapeccr = false
local enterLaw = false
local maxOccupantsPerSide = 20
local colCirclePlr = {}
local cpStart = false
local ccrReward = 0
local crimReward = 0

local CCRcolCircle = createColCircle(2180.625, 1677.329, 100)
local ccrmarker1 = createMarker(2141.969, 1629.289, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker2 = createMarker(2141.969, 1633.318, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker3 = createMarker(2141.969, 1637.168, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker4 = createMarker(2141.969, 1641.137, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker5 = createMarker(2146.538, 1629.289, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker6 = createMarker(2146.538, 1633.318, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker7 = createMarker(2146.538, 1637.168, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
local ccrmarker8 = createMarker(2146.538, 1641.137, 992.576, "cylinder", 1.5, 255, 255, 255, 150)
--]]

--local lawEnterCCR = createMarker(2196.717, 1677.168, 13.367, "arrow", 1.5, 255, 0, 0, 150)
--local LeaveCCR = createMarker(2233.958, 1714.684, 1013.383, "arrow", 1.5, 255, 0, 0, 150)
--local crimEnterCCR = createMarker(2298.084, 1571.333, 12.047, "arrow", 1.5, 255, 0, 0, 150)
--local crimLeaveCCR = createMarker(2204.400, 1551.517, 1009.722, "arrow", 1.5, 255, 0, 0, 150)

function createStuff()
    escaGate = createObject(11416, 2149.8999, 1601.29998, 1006.5, 0, 0, 0)
	copBlock = createObject( 8378, 2235.800, 1657.500, 1009.299, 0, 0, 0)
	setObjectScale( copBlock, 0.2)
    block = createObject(11416, 2149.936, 1604.687, 1002.968, 0, 0, 270)
    block2 = createObject(11416, 2160.432, 1603.581, 1000.97, 0, 0, 0)
    block3 = createObject(9093, 2145.799, 1604.634, 1006.263, 0, 0, 90)
    block4 = createObject(9093, 2150.096, 1602.881, 1001.97, 0, 0, 0)
    block5 = createObject(9093, 2176.559, 1609.1, 1000.577, 0, 0, 90)
    --[[
    setElementDimension(LeaveCCR, 801)
    setElementInterior(LeaveCCR, 1)
    setElementDimension(crimLeaveCCR, 801)
    setElementInterior(crimLeaveCCR, 1)
    --]]
	setElementInterior( copBlock, 1)
	setElementDimension( copBlock, 801)
    setElementDimension(escaGate, 801)
    setElementInterior(escaGate, 1)
    setElementDimension(block, 801)
    setElementInterior(block, 1)
    setElementDimension(block2, 801)
    setElementInterior(block2, 1)
    setElementDimension(block3, 801)
    setElementInterior(block3, 1)
    setElementDimension(block4, 801)
    setElementInterior(block4, 1)
    setElementDimension(block5, 801)
    setElementInterior(block5, 1)
    --[[ markers:
    setElementDimension(ccrmarker1, 801)
    setElementInterior(ccrmarker1, 1)
    setElementDimension(ccrmarker2, 801)
    setElementInterior(ccrmarker2, 1)
    setElementDimension(ccrmarker3, 801)
    setElementInterior(ccrmarker3, 1)
    setElementDimension(ccrmarker4, 801)
    setElementInterior(ccrmarker4, 1)
    setElementDimension(ccrmarker5, 801)
    setElementInterior(ccrmarker5, 1)
    setElementDimension(ccrmarker6, 801)
    setElementInterior(ccrmarker6, 1)
    setElementDimension(ccrmarker7, 801)
    setElementInterior(ccrmarker7, 1)
    setElementDimension(ccrmarker8, 801)
    setElementInterior(ccrmarker8, 1)

    setElementData(ccrmarker1, "Done", "No")
    setElementData(ccrmarker2, "Done", "No")
    setElementData(ccrmarker3, "Done", "No")
    setElementData(ccrmarker4, "Done", "No")
    setElementData(ccrmarker5, "Done", "No")
    setElementData(ccrmarker6, "Done", "No")
    setElementData(ccrmarker7, "Done", "No")
    setElementData(ccrmarker8, "Done", "No")
    --]]
end
addEventHandler("onResourceStart", resourceRoot, createStuff)

function startCCR2()
    moveObject(block5, 1000, 2176.559, 1609.1, 1003.577)
	moveObject( copBlock, 1000, 2235.800, 1657.500, 1020.099)
    started = true
end
addEventHandler("onCnREventStart", root, startCCR2)



local received_col = {}
local plrs = {}
local inUse = {
	plr = {}
}

function isInJail()
	triggerClientEvent( "GTIccr.closeSafeGUI", source, source)
end

addEventHandler( "onCnRPointEnter", root,
    function( hitElement, matchingDimension)
        if isElement( hitElement) and matchingDimension then
            if not inUse[source] then
				if not received_col[source] then
					inUse[source] = hitElement
					inUse.plr[hitElement] = source
					removeEventHandler("onPlayerJailed", hitElement, isInJail)
					addEventHandler( "onPlayerJailed", hitElement, isInJail)
					triggerClientEvent( "GTIccr.openCracker", hitElement, hitElement)
				end
            end
        end
    end
)

addEventHandler( "onCnRPointLeave", root,
    function( hitElement, matching)
		if received_col[source] ~= true then
            inUse[source] = false
			if inUse.plr[hitElement] and inUse.plr[hitElement] == source then
				inUse.plr[hitElement] = false
			end
        end
    end
)

function markerCracked( player)
	if isElement( player) and getElementType( player) == "player" then
		if inUse.plr[player] then
			local colTaken = inUse.plr[player]
			received_col[colTaken] = true
			inUse[colTaken] = false
			triggerEvent( "onCnRPointCapture", colTaken, player)
			if getElementData( colTaken, "pointData") == "gateOpener" then
				moveObject(block3, 1000, 2145.799, 1604.634, 1009.563)
			end
		end
	end
	--[[
    if number then
        if received_col[number] then
            local col = received_col[number]
            setElementData( col, "Done", "Ja")
            --local money = math.random(2500, 10000)
            --crimReward = crimReward + money
            triggerEvent( "onCnRPointCapture", col, player)
        end
    end
	--]]
end
addEvent("GTIccr.safeCracked", true)
addEventHandler("GTIccr.safeCracked", root, markerCracked)


function enableCracker(marker)
    --[[
    if (marker == 1) then
        inUse[source] = false
    elseif (marker == 2) then
        inUse2 = false
    elseif (marker == 3) then
        inUse3 = false
    elseif (marker == 4) then
        inUse4 = false
    elseif (marker == 5) then
        inUse5 = false
    elseif (marker == 6) then
        inUse6 = false
    elseif (marker == 7) then
        inUse7 = false
    elseif (marker == 8) then
        inUse8 = false
    end
    --]]
end
addEvent("GTIccr.enableCracker", true)
addEventHandler("GTIccr.enableCracker", root, enableCracker)

--[[
function resetStuff()
    setElementData(ccrmarker1, "Done", "No")
    setElementData(ccrmarker2, "Done", "No")
    setElementData(ccrmarker3, "Done", "No")
    setElementData(ccrmarker4, "Done", "No")
    setElementData(ccrmarker5, "Done", "No")
    setElementData(ccrmarker6, "Done", "No")
    setElementData(ccrmarker7, "Done", "No")
    setElementData(ccrmarker8, "Done", "No")
    setMarkerColor(ccrmarker1, 255, 255, 255, 150)
    setMarkerColor(ccrmarker2, 255, 255, 255, 150)
    setMarkerColor(ccrmarker3, 255, 255, 255, 150)
    lawCCR = {}
    lawCount = 0
    criminalsCCR = {}
    crimCountCCR = 0
    wanted = {}
    medicCountCCR = 0
    medics = {}
    preStarted = false
    started = false
    escapeccr = false
    enterLaw = false
    colCirclePlr = {}
    cpStart = false
    ccrReward = 0
    crimReward = 0
    if (isTimer(escapeTimer)) then
        killTimer(escapeTimer)
    end
    if (isTimer(escapeMinTimer)) then
        killTimer(escapeMinTimer)
    end
    if (isTimer(escapeChech)) then
        killTimer(escapeChech)
    end
end
--]]
