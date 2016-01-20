positions = {}
rmarkers = {}
rblips = {}
mType = ""
mSize = 0
currentMarkerIndex = 0
rType = 0

function raceMarkerHit(hitElement, sameDim)
    if (hitElement == localPlayer and sameDim) then
        if (currentMarkerIndex < #positions) then
            currentMarkerIndex = currentMarkerIndex + 1
            if (rType == 1) then
                showNextMarker()
            end
        else
            triggerServerEvent("GTIeventsys.SetRaceWinner", root)
        end
        destroyElement(source)
    end
end

function showNextMarker()
    if (rType == 1) then
        local marker = createMarker(positions[currentMarkerIndex][1], positions[currentMarkerIndex][2], positions[currentMarkerIndex][3], mType, mSize, 0, 0, 255, 120)
        setElementDimension(marker, 802)
        addEventHandler("onClientMarkerHit", marker, raceMarkerHit)
        if (currentMarkerIndex < #positions) then
            local blip = createBlipAttachedTo(marker,  0, 2, 0, 0, 255)
            setMarkerTarget(marker, positions[currentMarkerIndex + 1][1], positions[currentMarkerIndex + 1][2], positions[currentMarkerIndex + 1][3])
            addEventHandler("onClientElementDestroy", marker, function() destroyElement(blip) end)
        elseif (currentMarkerIndex == #positions) then
            local blip = createBlipAttachedTo(marker, 53)
            if (mType == "checkpoint") then
                setMarkerIcon(marker, "finish")
            else
                setMarkerTarget(marker, positions[currentMarkerIndex - 1][1], positions[currentMarkerIndex - 1][2], positions[currentMarkerIndex - 1][3])
            end
            addEventHandler("onClientElementDestroy", marker, function() destroyElement(blip) end)
        end
    elseif (rType == 2) then
        for k,v in ipairs(positions) do
            local marker = createMarker(v[1], v[2], v[3], mType, mSize, 0, 0, 255, 120)
            setElementDimension(marker, 802)
            setMarkerColor(marker, 0, 255, 0, 255)
            addEventHandler("onClientMarkerHit", marker, raceMarkerHit)
            local blip = createBlipAttachedTo(marker,  0, 2, 0, 255, 0)
            addEventHandler("onClientElementDestroy", marker, function() destroyElement(blip) end)
        end
    end
end

function addRaceStuff(pos, markerType, markerSize, raceType)
    mType = markerType
    mSize = markerSize
    rType = raceType
    destroyRaceStuff()
    positions = pos
    currentMarkerIndex = 1
    showNextMarker()
end
addEvent("GTIeventsys.CreateRaceStuff", true)
addEventHandler("GTIeventsys.CreateRaceStuff", root, addRaceStuff)

function destroyRaceStuff()
    for k,v in ipairs(getElementsByType("marker", resourceRoot)) do
        destroyElement(v)
    end
    for k,v in ipairs(getElementsByType("bllip", resourceRoot)) do
        destroyElement(v)
    end
    rmarkers = {}
    rblips = {}
end
addEvent("GTIeventsys.DestroyRaceStuff", true)
addEventHandler("GTIeventsys.DestroyRaceStuff", root, destroyRaceStuff)

function updateBlipColors(total)
    local n = 255 / total
    for k,v in ipairs(rblips) do
        setBlipColor(v, 255 - (n*k), 255 - (n*k), 255, 255)
    end
end

function updateMarkers(pos, markerType, markerSize)
    mType = markerType
    mSize = markerSize
    destroyRaceStuff()
    local n = 255 / #pos
    for k,v in ipairs(pos) do
        rmarkers[k] = createMarker(pos[k][1], pos[k][2], pos[k][3], markerType, markerSize, 0, 0, 255, 120)
        setElementDimension(rmarkers[k], 802)
        rblips[k] = createBlipAttachedTo(rmarkers[k],  0, 2, 255 - (n*k), 255 - (n*k), 255)
        addEventHandler("onClientElementDestroy", rmarkers[k], function() destroyElement(rblips[k]) end)
        if (k < #pos) then
            setMarkerTarget(rmarkers[k], pos[k + 1][1], pos[k + 1][2], pos[k + 1][3])
        elseif (k == #pos) then
            if (mType == "checkpoint") then
                setMarkerIcon(rmarkers[k], "finish")
            else
                setMarkerTarget(rmarkers[k], pos[k - 1][1], pos[k - 1][2], pos[k - 1][3])
            end
        end
    end
end
addEvent("GTIeventsys.UpdateMarkers", true)
addEventHandler("GTIeventsys.UpdateMarkers", root, updateMarkers)

function addCheck(pos, markerType, markerSize)
    mType = markerType
    mSize = markerSize
    rmarkers[pos[1]] = createMarker(pos[2], pos[3], pos[4], markerType, markerSize, 0, 0, 255, 120)
    setElementDimension(rmarkers[pos[1]], 802)
    rblips[pos[1]] = createBlipAttachedTo(rmarkers[pos[1]], 0, 2)
    if (mType == "checkpoint") then
        setMarkerIcon(rmarkers[pos[1]], "finish")
    else
        if (pos[1] > 1) then 
            local x, y, z = getElementPosition(rmarkers[pos[1] - 1])
            setMarkerTarget(rmarkers[pos[1]], x, y, z)
        end
    end
    if (pos[1] > 1) then
        setMarkerIcon(rmarkers[pos[1] - 1], "none")
        setMarkerTarget(rmarkers[pos[1] - 1], pos[2], pos[3], pos[4])
    end
    addEventHandler("onClientElementDestroy", rmarkers[pos[1]], function() destroyElement(rblips[pos[1]]) end)
    updateBlipColors(#rmarkers)
end
addEvent("GTIeventsys.AddCheck", true)
addEventHandler("GTIeventsys.AddCheck", root, addCheck)

function delCheck()
    destroyElement(rmarkers[#rmarkers])
    rmarkers[#rmarkers] = nil
    setMarkerIcon(rmarkers[#rmarkers], "finish")
end
addEvent("GTIeventsys.DelPrevCheck", true)
addEventHandler("GTIeventsys.DelPrevCheck", root, delCheck)
--test
