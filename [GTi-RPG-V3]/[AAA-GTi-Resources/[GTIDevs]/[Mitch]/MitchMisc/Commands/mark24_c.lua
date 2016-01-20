local blipss = {
{1833.191, -1843.100, 12.471},
{1315.682, -898.317, 38.471},
{-1561.899, -2733.909, 47.774},
{2452.904, 2064.314, 9.836},
{2247.829, 2396.553, 9.852},
{2334.470, 74.189, 25.484},
{251.660, -63.474, 0.578},
}


local storeBlips = {}

function togglestoreBlip( )
	outputDebugString("#1")
    if ( storeBlips[localPlayer] ) then
		outputDebugString("#2 - Deleting icons")
        for i, blips in ipairs ( storeBlips[localPlayer] ) do
            if (isElement(blips)) then
                destroyElement(blips)
            end
        end
		storeBlips[localPlayer] = nil
    else
		outputDebugString("#3 - Creating icons")
        for i, atmTableData2 in ipairs ( blipss ) do
            local x = atmTableData2[1]
            local y = atmTableData2[2]
            local z = atmTableData2[3]
            storeBlip = createBlip ( x, y, z, 36, 1, 0, 0, 0, 0, 0, 1000 )
            
            if not ( storeBlips[localPlayer] ) then storeBlips[localPlayer] = {} end
            table.insert( storeBlips[localPlayer], storeBlip )
        end     
    end
end
addCommandHandler ("markstore", togglestoreBlip)
addEvent ("GTIuserpanel_markStores", true )
addEventHandler ("GTIuserpanel_markStores", root, togglestoreBlip )