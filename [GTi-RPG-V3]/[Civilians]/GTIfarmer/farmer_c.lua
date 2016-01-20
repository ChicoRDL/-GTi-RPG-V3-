farmerZone1 = createColCuboid( -1215.461, -1220.327, 128.218, 96.551, 67.739, 13.490)

farmerZones = {farmerZone1}

antiPromSpam = false
dxEnabled = false

local zonelines = {
    -- Zone 1
    { -1118.849, -1220.407, 128.218, -1118.889, -1152.502, 128.218},
    { -1118.889, -1152.502, 128.218, -1215.464, -1152.502, 128.218},
    { -1215.464, -1152.502, 128.218, -1215.462, -1220.328, 128.218},
    { -1118.849, -1220.407, 128.218, -1215.462, -1220.328, 128.218},
}

local farmingRadars = {
    { -1215.461, -1220.327, 96.551, 67.739},
}

    setTimer (
        function ( )
            for _,v in ipairs ( farmingRadars ) do
                local lx,ly, sx, sy = unpack ( v )
                createRadarArea( lx, ly, sx, sy, 255, 200, 0, 100)
            end
        end, 1000, 1
    )

function createFarmerGUI()
    --Misc
    local occ = getElementData( localPlayer, "job")
    setElementData(localPlayer, "drawHarvestLeft", false)
    if occ == "Farmer" then
        if not dxEnabled then
            addEventHandler ( "onClientPreRender", root, createDXViewer, false)
            dxEnabled = true
        end
        triggerServerEvent("checkFarmerSeeds",root,localPlayer)
    else
        if dxEnabled then
            removeEventHandler ( "onClientPreRender", root, createDXViewer, false)
            dxEnabled = false
        end
    end
end
addEventHandler("onClientResourceStart",resourceRoot,createFarmerGUI)

------------------------------------------------------------------------------------------------------------------------------------------------------
offset = 10
offsetT = 20
resText = 1
plantdivision = {
    ["Bail Farmer"] = 856,
    ["Weed Farmer"] = 3409,
}
--plantobject = 856
plantobject = 1305

--[[
if sW < rX or sH < rY then
    resText = 1.00
elseif sW >= rX or sH >= rY then
    resText = 1.00
end
--]]

currentSeeds = 0
theSeeds = "0"

currentPlanted = 0
thePlanted = "0"

currentHarvest = 0
plantsToHarvest = "0"

function createDXViewer()
    --->> Line Drawer
    for index, line in ipairs ( zonelines) do
        if not doesPedHaveJetPack( localPlayer) then
            dxDrawLine3D( line[1], line[2], line[3], line[4], line[5], line[6], tocolor( 255, 255, 0, 255), 20, false)
        end
    end
	dxDrawRectangle(1367, 557, 191, 57, tocolor(0, 0, 0, 200), false) -- Backdrop
    --->> Seed Viewer
    if (not isPlayerMapVisible()) then
        if theSeeds ~= nil then
            local seedCBar = theSeeds/10000

			dxDrawRectangle(1370, 560, seedCBar*185, 24, tocolor(56, 124, 181, 200), false)
			dxDrawText( theSeeds.."/10000 Seeds", 1371, 560, 1556, 585, tocolor(0, 0, 0, 255), 1.15, "default-bold", "center", "center", false, false, false, false, false)
			dxDrawText( theSeeds.."/10000 Seeds", 1370, 559, 1555, 584, tocolor(118, 169, 212, 200), 1.15, "default-bold", "center", "center", false, false, false, false, false)
        end
        --->> Harvest Viewer
        if not getElementData(localPlayer, "drawHarvestLeft") then
            if thePlanted ~= nil then
                local curPl = seedsPlanted[localPlayer] or 0
                --->> Seeds Planted
                local seedBar = thePlanted/50

				dxDrawRectangle(1370, 587, seedBar*185, 24, tocolor(183, 173, 55, 200), false)
				dxDrawText( thePlanted.."/50 Seeds Planted", 1371, 587, 1556, 612, tocolor(0, 0, 0, 255), 1.15, "default-bold", "center", "center", false, false, false, false, false)
				dxDrawText( thePlanted.."/50 Seeds Planted", 1370, 586, 1555, 611, tocolor(212, 204, 112, 200), 1.15, "default-bold", "center", "center", false, false, false, false, false)
            end
        end
    end
end

function setSeeds(seeds)
    currentSeeds = math.floor(seeds or 0)
    if currentSeeds <= 0 then currentSeeds = 0 end
    theSeeds = tostring(currentSeeds)
end
addEvent("placeSeeds",true)
addEventHandler("placeSeeds",root,setSeeds)

function fixFarmerLogin()
    if getElementData( localPlayer, "job") == "Farmer" then
        currentPlanted = 0
        thePlanted = "0"
        if not dxEnabled then
            addEventHandler( "onClientPreRender", root, createDXViewer)
            dxEnabled = true
        end
    else
        if dxEnabled then
            removeEventHandler( "onClientPreRender", root, createDXViewer)
            dxEnabled = false
        end
    end
end
addEvent("fixFarmerLogin", true)
addEventHandler("fixFarmerLogin",root,fixFarmerLogin)

-- ^ Fixes #4170?..


-------------------------------------------------------------------------------------------------------------------------------------------------

function getDivision( theDivision)
    local object = plantdivision[tostring(theDivision)]
    plantobject = tonumber(object)
end
addEvent( "setDivisionObject", true)
addEventHandler( "setDivisionObject", root, getDivision)

--------------------------

function aToR( X, Y, sX, sY, bxb, byb)
    local sW, sH = guiGetScreenSize()
    local xd = X/rX or X
    local yd = Y/rY or Y
    local xsd = sX/rX or sX
    local ysd = sY/rY or sY
    return xd*sW, yd*sH, xsd*sW, ysd*sH
end
--
function plants2Harvest(amount)
    currentHarvest = math.floor(amount or 0)
    if currentHarvest <= 0 then currentHarvest = 0 end
    if currentHarvest >= currentPlanted then currentHarvest = currentPlanted end
    plantsToHarvest = tostring(currentHarvest)
end
addEvent("harvestPlants",true)
addEventHandler("harvestPlants",root,plants2Harvest)

---------------------

--Seeds

function giveSeeds( amount, cost)
    if amount then
        triggerServerEvent("giveTheSeeds", localPlayer, amount, cost)
    end
end

function takeSeeds( amount)
    if amount then
        triggerServerEvent("takeTheSeeds", localPlayer, amount)
    end
end
--------------------

function onJobQuit( job )
    if ( job == "Farmer" ) then
		seedsPlanted = {}
		spawnedPlants = {}
		pickedUp = 0
		plantsCount = 0
		scale = 0.05
		totalPickedUp = 0

        for i, colshape in ipairs ( getElementsByType( "colshape")) do
            if spawnedPlants[colshape] then
                local data = spawnedPlants[colshape]
                if ( type ( data ) == "table" ) then
                    destroyElement( colshape)
                    destroyElement( data.blip)
                    destroyElement( data.object)
                    if isTimer( plantTimers["1"..tostring( data.object)]) then
                        killTimer( plantTimers["1"..tostring( data.object)])
                    end
                    if isTimer( plantTimers["2"..tostring( data.object)]) then
                        killTimer( plantTimers["2"..tostring( data.object)])
                    end
                end
            end
        end

		plantTimers = {}
		noPlantCheck = {}

		uiExit()
		--[[for i, vehicle in ipairs ( getElementsByType( "vehicle")) do
			setElementCollidableWith( localPlayer, vehicle, true)
			setElementCollidableWith( vehicle, localPlayer, true)
		end ]]
	end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)
