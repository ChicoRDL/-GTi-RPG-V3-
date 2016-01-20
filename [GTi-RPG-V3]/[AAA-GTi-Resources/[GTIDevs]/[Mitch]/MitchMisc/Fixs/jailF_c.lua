colDerShapes = createColCuboid ( 225.661, 1482.973, 18.484, 65, 3, 3 )

addEvent("onClientInteriorExit",true)
addEvent("onClientInteriorEnter",true)

local spawnPosi = {
{257.997, 1433.379, 10.586},
{262.633, 1428.157, 10.586},
{266.224, 1436.412, 10.586}
}

function exploit_fix ( player )
    if ( player == localPlayer ) then
	    loc = math.random ( #spawnPosi )
	    setElementPosition ( localPlayer, spawnPosi[loc][1], spawnPosi[loc][2], spawnPosi[loc][3] )
	end
end
addEventHandler ("onClientColShapeHit", colDerShapes, exploit_fix )

--[[function testEvents ( )
    outputDebugString ("#1 Player Exit Interior")
end
addEventHandler ("onClientInteriorExit", root, testEvents )

function testEvents ( )
    outputDebugString ("#2 Player Enter Interior")
end
addEventHandler ("onClientInteriorEnter", root, testEvents )]]