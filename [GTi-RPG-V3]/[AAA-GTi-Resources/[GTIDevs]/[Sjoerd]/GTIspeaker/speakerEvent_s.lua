blips = { }
marker = { }
function addEventBlip(source)
    if (exports.GTIutil:isPlayerInTeam(source, "Government")) then
    if (isElementAttached ( speakers [source])) then
        exports.GTIhud:dm("To use this, your speaker shouldn't be attached to a vehicle.", source, 255, 0, 0)
    return end
    if (isElement(blips [ source ])) then return end
    local x, y, z = getElementPosition(speakers [ source ])
    blips [ source ] = createBlip(x, y, z, 49, 2)
    exports.GTIhud:dm("You succesfully created an event blip.", source, 255, 0, 0)
    end
end
addCommandHandler("speakerblip", addEventBlip)


function delEventBlip(source)
    if (exports.GTIutil:isPlayerInTeam(source, "Government")) then
    if (isElement(blips [ source ])) then
        destroyElement(blips [ source])
        exports.GTIhud:dm("You succesfully deleted your event blip.", source, 255, 0, 0)
    end
    end
end
addCommandHandler("delblip", delEventBlip)




function addMarker(source, b, r, g, b)
    if (exports.GTIutil:isPlayerInTeam(source, "Government")) then
    if (isElementAttached ( speakers [source])) then
        exports.GTIhud:dm("To use this, your speaker shouldn't be attached to a vehicle.", source, 255, 0, 0)
    return end
    if (isElement(marker [ source ])) then return end
    local x, y, z = getElementPosition(speakers [ source ])
    marker [ source ] = createMarker(x, y, z, "checkpoint", 2, r or 255, g or 100, b or 50)
    exports.GTIhud:dm("You succesfully created a marker.", source, 255, 0, 0)
    end
end
addCommandHandler("speakermarker", addMarker)


function delMarker(source)
    if (exports.GTIutil:isPlayerInTeam(source, "Government")) then
    if ( isElement(marker [ source ])) then
        destroyElement(marker [ source ])
        exports.GTIhud:dm("You succesfully deleted your marker.", source, 255, 0, 0)
        end
    end
end
addCommandHandler("delmarker", delMarker)


function placeBlip(test)
    local x, y, z = getElementPosition(source)
    blips [ source ] = createBlip(x, y, z, 49, 2)
end
addEvent("GTIspeaker.placeBlip", true)
addEventHandler("GTIspeaker.placeBlip", root, placeBlip)