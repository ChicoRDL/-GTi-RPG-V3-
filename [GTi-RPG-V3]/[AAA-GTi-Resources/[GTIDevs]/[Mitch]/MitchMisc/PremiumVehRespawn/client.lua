
local lastSpawnedRow = {}

MAX_ALLOWED_VEHICLES = 2

local markerTable = {
    createMarker ( 1624.203, 1847.535, 9.820, "cylinder", 1.5, 200, 70, 50, 100 ), -- LV Hospital
    createMarker ( -305.244, 1035.904, 18.594, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( -1500.660, 2524.692, 54.688, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( 1219.906, 304.160, 18.555, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( 2256.927, -83.753, 25.521, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( -2544.013, 610.898, 13.453, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( -2189.852, -2267.649, 29.625, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( 1178.389, -1339.128, 12.892, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( 2003.283, -1445.879, 12.562, "cylinder", 1.5, 200, 70, 50, 100 ),
    createMarker ( 2673.204, -2541.450, 12.506, "cylinder", 1.5, 200, 70, 50, 100 ),
}

local sX, sY = guiGetScreenSize()
local wX, wY = 309, 500
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- Window
GUI_Window_Vehicles = guiCreateWindow ( sX, sY, wX, wY, "GTI Player Vehicle Spawner - Premium Feature", false )
guiWindowSetSizable ( GUI_Window_Vehicles, false )
guiSetAlpha ( GUI_Window_Vehicles, 0.90 )
guiSetVisible ( GUI_Window_Vehicles, false )
-- Gridlist
GUI_Gridlist_Vehicles = guiCreateGridList ( 10, 20, 290, 400, false, GUI_Window_Vehicles )
guiGridListAddColumn ( GUI_Gridlist_Vehicles, "Vehicle Name", 0.7 )
guiGridListAddColumn ( GUI_Gridlist_Vehicles, "Health", 0.2 )
guiGridListSetSortingEnabled ( GUI_Gridlist_Vehicles, false )
-- Button
GUI_Button_Spawn = guiCreateButton ( 10, 430, 290, 20, "Spawn", false, GUI_Window_Vehicles )
GUI_Button_Close = guiCreateButton ( 10, 460, 290, 20, "Close", false, GUI_Window_Vehicles )

function showTheGui ( player )
    if player == localPlayer and not isPedInVehicle ( localPlayer ) and isPedOnGround ( localPlayer ) then
        guiSetVisible ( GUI_Window_Vehicles, true )
        showCursor ( true, true )
        triggerServerEvent ("MitchMisc.callVehicleInfo", resourceRoot )
    end
end

function hide ( )
    guiSetVisible ( GUI_Window_Vehicles, false )
    showCursor ( false, false )
end

for k,v in ipairs ( markerTable ) do
    addEventHandler ("onClientMarkerHit", v, showTheGui )
    addEventHandler ("onClientMarkerLeave", v, hide )
end

function hideGUI ( )
    if source == GUI_Button_Close then
        guiSetVisible ( GUI_Window_Vehicles, false )
        showCursor ( false, false )
    end
end
addEventHandler ("onClientGUIClick", root, hideGUI )

local vehRowInfo = {}

function returnVehicleInfo(vehTable)
    guiGridListClear(GUI_Gridlist_Vehicles)
    for k,v in pairs(vehTable) do
        local row = guiGridListAddRow(GUI_Gridlist_Vehicles)
        local vehName = getVehicleNameFromModel(v[1])
        local vehName = k..".) "..vehName
        guiGridListSetItemText(GUI_Gridlist_Vehicles, row, 1, vehName, false, false)
        
        local vehHealth = math.floor(v[2]/10).."%"
        guiGridListSetItemText(GUI_Gridlist_Vehicles, row, 2, vehHealth, false, false)
        
        local r = 255 - ((math.floor(v[2]/10) - 30) * 3.64)
        local g = (math.floor(v[2]/10) - 30) * 3.64
        if (r > 255) then r = 255 end   if (r < 0) then r = 0 end
        if (g > 255) then g = 255 end   if (g < 0) then g = 0 end
        guiGridListSetItemColor(GUI_Gridlist_Vehicles, row, 2, r, g, 0)
        
        if (v[4]) then
            guiGridListSetItemColor(GUI_Gridlist_Vehicles, row, 1, 200, 0, 255)
        end
        
        vehRowInfo[row] = k
    end
end
addEvent("MitchMisc.returnVehicleInfo", true)
addEventHandler("MitchMisc.returnVehicleInfo", root, returnVehicleInfo)

function spawnPlayerVehicle( )
    if source == GUI_Button_Spawn then
    local row = guiGridListGetSelectedItem(GUI_Gridlist_Vehicles)
    if (not row or row == -1) then return end       
    local vehID = vehRowInfo[row]
    triggerServerEvent("MitchMisc.spawnPlayerVehicle", localPlayer, vehID, row)
    guiSetVisible ( GUI_Window_Vehicles, false )
    showCursor ( false, false )
    end
end
addEventHandler ("onClientGUIClick", root, spawnPlayerVehicle )

function returnVehicleThatIsSpawned(row, grid)
    table.insert(lastSpawnedRow, {row, grid})
    if (#lastSpawnedRow > MAX_ALLOWED_VEHICLES) then
        --guiGridListSetItemColor(GUI_Gridlist_Vehicles[lastSpawnedRow[1][2]], lastSpawnedRow[1][1], 1, 255, 255, 255)
        table.remove(lastSpawnedRow, 1)
    end
end
addEvent("MitchMisc.returnVehicleThatIsSpawned", true)
addEventHandler("MitchMisc.returnVehicleThatIsSpawned", root, returnVehicleThatIsSpawned)