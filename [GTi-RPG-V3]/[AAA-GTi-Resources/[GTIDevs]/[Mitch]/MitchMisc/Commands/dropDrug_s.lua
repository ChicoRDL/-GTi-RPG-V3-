local object = {}
local marker = {}

objectTable = {
{ 1575 },
{ 1576 },
{ 1577 },
{ 1578 },
{ 1579 },
{ 1580 }
}

--[[function dropDrugs ( player, cmd, drug, amount )
    local amount = tonumber ( amount )
    --if (type(amount) == "number") and (amount >= 1) then
        if ( isElement ( player ) ) then
            local drugs = tonumber ( exports.GTIdrugs:getPlayerDrugAmount( player, drug ) )
        if ( amount > drugs ) then
            local x, y, z = getElementPosition ( player )
            --local ob = math.random ( #objectTable )
            object [ player ] = createObject ( 1575, x, y+1, z-1, 0, 0, 0, true )
            marker [ player ] = createMarker ( x, y+1, z, "cylinder", 0.7, 0, 0, 0, 0 )
            setElementData(marker [ player ], "markerOwner", player)
            setElementData(marker [ player ], "drug", drug)
            setElementData(marker [ player ], "amount", amount)
            addEventHandler ("onMarkerHit", marker [ player ], pickupDroppedDrugs )
            exports.GTIdrugs:takePlayerDrug( player, drug, amount )
			outputDebugString ( amount )
            exports.GTIhud:dm("You dropped "..drug.." Total Hits: "..amount, player, 200, 0, 0 )
        else
            exports.GTIhud:dm("You do not have enough drugs to drop!", player, 255, 0, 0)
            --end            
        end
    end
end
addCommandHandler ("dropdrug", dropDrugs )

function pickupDroppedDrugs(hitElement)
    if (isElement(hitElement) and getElementType(hitElement) == "player") then
        local owner = getElementData(source, "markerOwner")
        local drug = getElementData(source, "drug")
        local amount = getElementData(source, "amount")
        exports.GTIdrugs:givePlayerDrug( hitElement, drug, amount )
        exports.GTIhud:dm("You have received "..amount.." hit(s) of "..drug.." from "..getPlayerName(owner), hitElement, 200, 0, 0 )
		outputDebugString ( amount )
        if (isElement(source)) then
            destroyElement(source)
            marker [ owner ] = nil
        end
        if (isElement(object [ owner ])) then
            destroyElement(object [ owner ])
            object [ owner ] = nil
        end   
    end
end
    --]]