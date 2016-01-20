-- NOTE:
-- Do only edit stuff after this point if you know what you're doing!
-- Editing something wrong may break or bug the entire script!

-- Modshop resource by Dennis aka UniOn

createObject (11326, 1994.276, 2041.688, 12.063, 0, 0, 90)
createObject (11326, 2514.873, -1775.783, 14.797, 0, 0, 180)

-- Table with the positions for the modshop markers
local modshopPositions = {
{1041.39, -1018.62, 31.5, 27},      -- Temple, LS
{2412.392, -2471.655, 12.630, 27},      -- Ocean Docks, LS
{1643.7539, -1517.6722, 12.56, 27}, -- Downtown Los Santos, LS
{1431.993, -2439.917, 12.555, 27},  -- LS Airport, LS
{94.862, -2008.983, 0, 27},         -- Santa Maria Beach, LS
{2414.339, 86.644, 25.512, 27},     -- Palomino Creek, LS
{263.860, 9.043, 1.441, 27},        -- Blueberry, LS
{-2723.7060, 217.2689, 2.6133, 27}, -- Ocean Flats, SF
{-2027.204, 124.581, 28.107, 27},   -- Doherty, SF
{-1936.240, 245.037, 33.461, 27},   -- Doherty, SF
{-1598.853, -631.776, 13.148, 27},  -- Easter Bay Airport, SF
{-1561.03, 1247.93, 0.53, 27},      -- SF Boat Shop
{1990.6890, 2056.8046, 9.3844, 27}, -- LV Transfender
{1409.777, 1811.573, 9.82, 27},     -- Las Venturas Airport, LV
{2171.190, 1393.786, 9.991, 27},    -- Royal Casino, LV
}

-- Some tables we need to store data to let the modshop work proper
local moddingMarkers = {}
local moddingVehicle = {}
local vehicleModding = {}

-- Create the markers when the resource starts
addEventHandler("onResourceStart", resourceRoot,
    function ()
        for i=1,#modshopPositions do
            local aMarker = createMarker(modshopPositions[ i ][ 1 ], modshopPositions[ i ][ 2 ], modshopPositions[ i ][ 3 ], "cylinder", 4, 255, 0, 0, 50)
            addEventHandler("onMarkerHit", aMarker, onModshopMarkerHit)
        end

        -- Open garage doors
        setGarageOpen(7, true)
        setGarageOpen(10, true)
        setGarageOpen(15, true)
        setGarageOpen(18, true)
        setGarageOpen(24, true)
        setGarageOpen(33, true)
        setGarageOpen(35, true)
    end
)

-- When a vehicle gets destroyed
function onModshopVehicleDestroy ()
    if (vehicleModding[ source ]) then
        local thePlayer = getVehicleController(source)
        if (thePlayer) and (moddingVehicle[ thePlayer ]) then
            resetModdingShop (thePlayer)
            triggerClientEvent(thePlayer, "onClientStopModdingVehicle", thePlayer)
        end
    end
end

-- Couple events for the destroy function
addEventHandler("onElementDestroy", root, onModshopVehicleDestroy)
addEventHandler("onVehicleExplode", root, onModshopVehicleDestroy)

local isCar = {
	["Automobile"] = true,
	["Monster Truck"] = true,
}

-- Function when the marker got hit
function onModshopMarkerHit (hitElement, matchingDimension)
    if (isElement(hitElement)) and (matchingDimension) and (getElementType(hitElement) == "vehicle") then
        if (getVehicleController(hitElement)) then
			if (exports.GTIturnsignals:isVehicleBlinking(hitElement) and isCar[getVehicleType(hitElement)]) then	
				exports.GTIhud:dm("You can't use the modshop while using the turn lights.", getVehicleController(hitElement), 255, 0, 0)
				return
			end
			local thePlayer = getVehicleController(hitElement)
			if not isElement(thePlayer) then return end
			if (getElementData(hitElement,"owner") ~= getAccountName(getPlayerAccount(thePlayer))) then return end
			moddingMarkers[ thePlayer ] = source
			moddingVehicle[ thePlayer ] = hitElement
			vehicleModding[ hitElement] = hitElement
			setElementFrozen(hitElement, true)
			setVehicleDamageProof(moddingVehicle[ thePlayer ], true)
			local x, y, z = getElementPosition(source)
			setElementPosition(hitElement, x, y, z + 1.65)
			triggerClientEvent(thePlayer, "onClientModdingMarkerHit", thePlayer, hitElement)
			setElementDimension(source, 999)
				if isControlEnabled(thePlayer, "vehicle_fire") then
					addEventHandler("onMarkerLeave", source, 
						function ( hitElement )
							if getElementType ( hitElement ) == "player" then
								toggleControl( hitElement, "vehicle_fire", false)
								toggleControl( hitElement, "vehicle_secondary_fire", false)
							end
						end
					)
				end
        end
    end
end

-- When a player quits while modding
addEventHandler("onPlayerQuit", root,
    function ()
        if (moddingMarkers[ source ]) then
            resetModdingShop (source)
        end
    end
)
addEventHandler("onResourceStop", resourceRoot,
    function ()
        for i,v in pairs(moddingMarkers) do
            resetModdingShop(v)
        end
    end
)

-- When a wants to hijack a player thats modding
addEventHandler("onVehicleStartExit", root,
    function (thePlayer, seat)
        local jacked = getVehicleController(source)
        if (moddingMarkers[ jacked ]) then
            cancelEvent()
        end
    end
)

-- When a player dies
addEventHandler("onPlayerWasted", root,
    function ()
        if (moddingMarkers[ source ]) then
            resetModdingShop (source)
            triggerClientEvent(source, "onClientStopModdingVehicle", source)
        end
    end
)

-- When the players leaves a modding marker
addEvent("onServerModdingShopLeave", true)
addEventHandler("onServerModdingShopLeave", root,
    function ()
        if (moddingMarkers[ source ]) then
            resetModdingShop (source)
        end
    end
)

-- Function that resets the tables and stuff
function resetModdingShop (thePlayer)
    if isElement(moddingVehicle[ thePlayer ]) then
        setElementDimension(moddingMarkers[ thePlayer ], 0)
        setElementFrozen(moddingVehicle[ thePlayer ], false)
        setVehicleDamageProof(moddingVehicle[ thePlayer ], false)
    end
    moddingMarkers[ thePlayer ] = nil
    vehicleModding[ moddingVehicle[ thePlayer ] ] = nil
    moddingVehicle[ thePlayer ] = nil
    triggerClientEvent(thePlayer, "modshop.onClientStopModdingVehicle", thePlayer)
end

-- When the player is done with the modding
addEvent("onServerFinishCarModding", true)
addEventHandler("onServerFinishCarModding", root,
    function (modTable, modPayment, modVehicle, modColors, modPaintjob)
        -- Take the player's money
        local pMoney = getPlayerMoney(source)
        if pMoney >= modPayment then
            if modPayment > 1800 then
                fixVehicle(modVehicle)
            end
            exports.GTIbank:TPM(source, modPayment, "GTImodshop Mod costs")
			exports.GTIstats:modifyPlayerStatData(source, "budget_vehmods", modPayment)
        else
            exports.GTIhud:dm("You don't have enough money. Uninstall some upgrades, or right click the button to exit", source, 255, 255, 0)
        end

        -- Add the upgrades serverside
        for _, upgrade in ipairs (modTable) do
            addVehicleUpgrade(modVehicle, upgrade)
        end

        -- Set the colors and paintjob
        setVehicleColor(modVehicle, modColors[1], modColors[2], modColors[3], modColors[4], modColors[5], modColors[6])
        setVehicleHeadLightColor(modVehicle, modColors[7], modColors[8], modColors[9])
        local headlight = {modColors[7], modColors[8], modColors[9]}
        setVehiclePaintjob(modVehicle, modPaintjob)

        -- Trigger the event
        triggerEvent("onVehicleFinishedModding", modVehicle, modTable, modColors, modPaintjob, modPayment, headlight)
    end
)

addEvent("onVehicleFinishedModding")
addEventHandler("onVehicleFinishedModding", root,
    function(upgrades, colors, paintjob, modPayment,headlight)
        local vehID = getElementData(source, "vehicleID")
        --->> Paint Job Handling
        if paintjob ~= false then
            setVehiclePaintjob(source, paintjob)
            exports.GTIvehicles:setVehicleData(vehID, "paintjob", paintjob)
        end
        --->> Color Handling
        if colors ~= false and type(colors) == "table" then
            setVehicleColor(source, unpack(colors))
            local saveColors = table.concat(colors, ",")..",0,0,0,0,0,0"
            exports.GTIvehicles:setVehicleData(vehID, "color", saveColors)
            local saveheadlight = table.concat(headlight, ",")..",0,0,0,0,0,0"
            exports.GTIvehicles:setVehicleData(vehID, "headlight", saveheadlight)
        end
        --->> Upgrades Handling
        local tempTable = {}
            -- Tabling All Upgrade Slots
        for i = 0, 16 do
            local upgrade = getVehicleUpgradeOnSlot(source, i)
            table.insert(tempTable, { i, upgrade})
        end
            -- Creating 1st String
        for i,upgrade in pairs(tempTable) do
            tempTable[i] = table.concat(upgrade, ",")
        end
            -- Creating 2nd String
        local upgradeString = table.concat(tempTable, ";")
        tempTable = {}
            -- Saving The Upgrades
        exports.GTIvehicles:setVehicleData(vehID, "upgrades", upgradeString)
    end
)

-- Exported function to check if a vehicle is modding
function isVehicleModding(theVehicle)
    if (theVehicle) and (isElement(theVehicle)) then
        if (vehicleModding[ theVehicle ]) then return true else return false end
    else
        return false
    end
end

-- Exported function to check if a player is modding
function isPlayerModding(thePlayer)
    if (thePlayer) and (isElement(thePlayer)) then
        if (moddingVehicle[ thePlayer ]) then return true else return false end
    else
        return false
    end
end
