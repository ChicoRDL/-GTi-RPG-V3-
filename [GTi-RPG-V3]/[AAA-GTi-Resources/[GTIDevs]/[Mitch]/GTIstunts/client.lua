----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local sx, sy = guiGetScreenSize ( )
local px, py = 1920, 1080
local x, y   = ( sx / px ), ( sy /py )

if sx <= 1024 and sy <= 768 then
    textRender = 1.50
    smallText = 0.50
else
    textRender = 2.00
    smallText = 1.00
end

local dxActive = false
local stunt = false

local notAllowedVehicles = {
---==========Aircraft===========---
    [592] = true, -- Andromada
    [577] = true, -- AT-400
    [511] = true, -- Beagle
    [548] = true, -- Cargobob
    [512] = true, -- Cropduster
    [593] = true, -- Dodo
    [425] = true, -- Hunter
    [520] = true, -- Hydra
    [417] = true, -- Leviathan
    [487] = true, -- Maverick
    [553] = true, -- Nevada
    [488] = true, -- News Chopper
    [563] = true, -- Raindance
    [476] = true, -- Rustler
    [447] = true, -- Seasparrow
    [519] = true, -- Shamal
    [460] = true, -- Skimmer
    [469] = true, -- Sparrow
    [513] = true, -- Stuntplane
---============Bikes=============---
    [509] = true, -- Bike
    [481] = true, -- BMX
    [510] = true, -- Mountain Bike
---============Boats=============---
    [472] = true, -- Coastguard
    [473] = true, -- Dinghy
    [493] = true, -- Jetmax
    [595] = true, -- Launch
    [484] = true, -- Marquis
    [430] = true, -- Predator
    [453] = true, -- Reefer
    [452] = true, -- Speeder
    [446] = true, -- Squalo
    [454] = true, -- Tropic
---===========Government Vehicles============---
    [497] = true, -- Police Maverick
---==========Trains and Railroad Cars===========---
    [449] = true, -- Tram
    [537] = true, -- Freight
    [538] = true, -- Brown Streak
    [570] = true, -- Brown Streak Carriage
    [569] = true, -- Flat Freight
    [590] = true, -- Box Freight
---=================RC Vehicles==================---
    [441] = true, -- RC Bandit
    [464] = true, -- RC Baron
    [501] = true, -- RC Goblin
    [465] = true, -- RC Raider
    [564] = true, -- RC Tiger
}


local colshapes = {
    {2150.266, -1562.087, 20.051, 4, 2000, 0, -8000, 0},
    {1308.343, -2488.525, 20.234, 4, 1500, 0, 0, 0},
    {1962.360, -1971.262, 23.184, 3, 1000, 0, 0, 0},
    {1173.772, -1630.010, 31.033, 4, 1500, 0, 12000, 0},
    {2278.055, -1333.574, 32.805, 4, 1000, 0, 12000, 0},
    {2356.166, -2189.614, 25.934, 4, 1500, 0, 6000, 0},
    {2791.185, -1567.753, 23.075, 4, 2500, 0, 0, 0},
    {2459.608, -2593.401, 21.440, 4, 1000, 0, 12000, 0},
    {1580.245, -2388.882, 28.115, 4, 2000, 0, 12000, 0},
    {682.012, -1856.815, 15.390, 3, 1000, 0, 0, 0},
    {-1318.803, -674.317, 46.777, 5, 2000, 0, -2000, 0},
    {-1613.643, -556.008, 21.260, 3, 2500, 0, 0, 0},
    {-1873.858, 220.788, 57.124, 4, 2000, 0, 0, 0},
    {-1543.656, 698.728, 139.273, 2, 1000, 0, 2000, 0},
    {-1614.661, 1110.506, 49.765, 4, 2000, 0, 0, 0},
    {-1943.943, 796.174, 65.809, 3, 2000, 0, 0, 0},
    {-2461.012, 721.156, 45.332, 3, 2000, 0, 0, 0},
    {-2602.034, 612.794, 37.253, 4, 3500, 0, 14000, 0},
    {-2582.685, 1286.682, 42.457, 4, 3500, 0, 12000, 0},
    {-2105.640, 135.970, 39.274, 1, 2000, 0, 0, 0},
    {-1703.693, 43.561, 24.001, 3, 2000, 0, 1500, 0},
    {-1729.524, 66.690, 18.747, 3, 3000, 0, 0, 0},
    {-1766.715, -94.902, 20.042, 4, 2000, 0, -3000, 0},
    {-714.529, 2030.501, 14.753, 1, 2000, 0, 0, 0},
    {-714.454, 2039.850, 35.049, 1, 2000, 0, 0, 0},
	{-2071.843, -1874.612, 325.567, 6, 4000, -2000, 0, 12000},
}

local stuntBlips = {}
local money = {}
local rx = {}
local ry = {}
local rz = {}

function toggleStuntBlip( )
    if ( stuntBlips[localPlayer] ) then
        for i, blips in ipairs ( stuntBlips[localPlayer] ) do
            if (isElement(blips)) then
                destroyElement(blips)
            end
        end
        stuntBlips[localPlayer] = nil
    else
        for i, stuntTableData in ipairs ( colshapes ) do
            local x = stuntTableData[1]
            local y = stuntTableData[2]
            local z = stuntTableData[3]
            local r = stuntTableData[4]
			local stuntRing = createMarker ( x, y, z, "ring", r, 255, 0, 0, 150 )
			rx[stuntRing] = stuntTableData[6]
			ry[stuntRing] = stuntTableData[7]
			rz[stuntRing] = stuntTableData[8]
            local stuntBlip = createBlip ( x, y, z, 0, 3, 255, 0, 0, 255, 0, 1000 )
			setMarkerTarget ( stuntRing, rx[stuntRing], ry[stuntRing], rz[stuntRing] )
            
            
            if not ( stuntBlips[localPlayer] ) then stuntBlips[localPlayer] = {} end
            table.insert( stuntBlips[localPlayer], stuntBlip )
            table.insert( stuntBlips[localPlayer], stuntRing )
        end     
    end
end
addEvent ("GTIuserpanel_markStunts", true )
addEventHandler ("GTIuserpanel_markStunts", root, toggleStuntBlip )
addCommandHandler ("markstunts", toggleStuntBlip)

function createShapes ( )
    for i,v in ipairs ( colshapes ) do
        local x = v[1]
        local y = v[2]
        local z = v[3]
        local r = v[4]
		colshape = createColSphere ( x, y, z, r )
        money[colshape] = v[5]
        addEventHandler ("onClientColShapeHit", colshape, stuntCompleted )
    end
end
addEventHandler ("onClientResourceStart", resourceRoot, createShapes )

addEvent ("GTIstunts_LoadStunts", true )
addEventHandler ("GTIstunts_LoadStunts", root, function ( cStunts ) setElementData ( source, "stunts", cStunts, false ) end )

function drawText ( )
    dxDrawRectangle ( x*0, y*300, x*1920, y*150, tocolor ( 0, 0, 0, 150 ) )
    dxDrawText ( "Stunt Jump Completed", x*100, y*250, x*1920, y*500, tocolor ( 255, 255, 255 ), textRender, "bankgothic", "center", "center", false, false, true, false, false )
    dxDrawText ( "Stunt Jumps Completed: "..cStunts, x*100, y*250, x*1920, y*600, tocolor ( 255, 255, 255 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
end

function stuntCompleted ( player )
    if player == localPlayer and isPedInVehicle ( localPlayer ) and dxActive == false and getPedOccupiedVehicleSeat ( localPlayer ) == 0 then
    if stunt == true then return end
        local vehicle = getPedOccupiedVehicle ( localPlayer )
        if ( notAllowedVehicles [ getElementModel ( vehicle ) ] ) then return end
        outputDebugString ("Reward $"..money[source])
        
        cStunts = getElementData ( localPlayer, "stunts" ) or 1
        setElementData ( localPlayer, "stunts", cStunts + 1, false )
        addEventHandler ("onClientRender", root, drawText )
        triggerServerEvent ("GTIstunts_addStuntCompleted", localPlayer, money[source] )
        stunt = true
        dxActive = true
		exports.GTIhud:drawNote("StuntsCoolDown", "Stunts: Cool-down active", 100, 255, 0 )
        setTimer ( test, 7500, 1 )
        setTimer ( stuntFalse, 60000, 1 )
    end
end

function test ( )
    removeEventHandler ("onClientRender", root, drawText )
	triggerServerEvent ("GTIstunts_resetHealth", localPlayer )
    dxActive = false
end

function stuntFalse ( )
    stunt = false
	exports.GTIhud:drawNote("StuntsCoolDown", "", 100, 100, 0 )
end