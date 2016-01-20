door1 = createObject ( 1569, 252.945, -62.055, 0.570, 0, 0, 0 )
door2 = createObject ( 1569, 255.945, -62.055, 0.570, 0, 0, 180 )
colshape1 = createColSphere ( 254.469, -61.735, 1.570, 2 )

function doorOpen ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    moveObject ( door1, 750, 251.845, -61.755, 0.570 )
	end
end
addEventHandler ("onColShapeHit", colshape1, doorOpen )

function doorOpen1 ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    moveObject ( door2, 750, 257.745, -61.755, 0.570 )
	end
end
addEventHandler ("onColShapeHit", colshape1, doorOpen1 )

function doorClose ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    moveObject ( door1, 750, 252.945, -61.755, 0.570 )
	end
end
addEventHandler ("onColShapeLeave", colshape1, doorClose )

function doorClose1 ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    moveObject ( door2, 750, 255.945, -61.755, 0.570 )
	end
end
addEventHandler ("onColShapeLeave", colshape1, doorClose1 )

gate1 = createObject ( 986, 2497.399, 2777.199, 11.5, 0, 0, 270 )
gate2 = createObject ( 986, 2497.399, 2769.100, 11.5, 0, 0, 90 )
colshape2 = createColSphere ( 2496.855, 2772.836, 10.824, 6 )

function gateOpen ( player )
    if ( isElement(player) and getElementType(player) == "player" ) then
	    moveObject ( gate1, 1500, 2497.399, 2786.000, 11.5 )
	end
end
addEventHandler ("onColShapeHit", colshape2, gateOpen )

function gateOpen1 ( player )
    if ( isElement(player) and getElementType(player) == "player" ) then
	    moveObject ( gate2, 1500, 2497.399, 2758.000, 11.5 )
	end
end
addEventHandler ("onColShapeHit", colshape2, gateOpen1 )

function gateClose ( player )
    if ( isElement(player) and getElementType(player) == "player" ) then
	    moveObject ( gate1, 1500, 2497.399, 2777.199, 11.5 )
	end
end
addEventHandler ("onColShapeLeave", colshape2, gateClose )

function gateClose1 ( player )
    if ( isElement(player) and getElementType(player) == "player" ) then
	    moveObject ( gate2, 1500, 2497.399, 2769.100, 11.5 )
	end
end
addEventHandler ("onColShapeLeave", colshape2, gateClose1 )

removeWorldModel (1533,5,1728.45,-1637.44, 19.2109)
removeWorldModel (1537,5,1725.43,-1637.44, 19.2109)
removeWorldModel (1533,5,1700.13,-1666.41, 19.2109)
removeWorldModel (1537,5,1700.13,-1669.42, 19.2109)