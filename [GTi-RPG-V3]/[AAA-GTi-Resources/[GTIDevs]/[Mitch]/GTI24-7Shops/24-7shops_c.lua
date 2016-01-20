----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: 24-7shops_c.lua
-- Version: 1.0
----------------------------------------->>

-- Marker X, Y, Z, Dim, Int
local markerTable = {
{-23.544, -55.399, 1003.547, 7, 6},
{-23.544, -55.399, 1003.547, 5, 6 },
{ -23.376, -55.416, 1003.547, 6, 6 },
{ -23.402, -55.321, 1003.547, 3, 6 },
{ -23.349, -55.160, 1003.547, 4, 6 },
{ -27.876, -89.638, 1003.547, 2, 18 },
{ -1558.709, -2729.763, 48.748, 0, 0 },
{ 1316.146, -894.375, 39.578, 0, 0 },
{ 1837.720, -1838.791, 13.595, 0, 0 },
{ 1349.658, -1763.159, 13.550, 0, 0 },
}

-- ItemID - Price
local weapons = {
{2, 200},
{4, 200},
{5, 100},
{6, 100},
{7, 150},
{8, 500},
{10, 200},
{12, 200},
{14, 25},
{15, 200},
{43, 50},
{44, 750},
{45, 750},
{46, 300},
}

function createMarkers ( )
    for i, v in ipairs ( markerTable ) do
	    local x = v[1]
		local y = v[2]
		local z = v[3]
	    shopMarker = createColSphere ( x, y, z, 1 )
		createMarker ( x, y, z-1, "cylinder", 1, 255, 255, 255, 125 )
		setElementDimension ( shopMarker, v[4] )
		setElementInterior ( shopMarker, v[5] )
		addEventHandler ("onClientColShapeHit", shopMarker, showGUI )
		addEventHandler ("onClientColShapeLeave", shopMarker, hideGUI )
	end
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )

function createGUI ( )
        local sWidth, sHeight = guiGetScreenSize ( )
		local Width, Height = 250, 360
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
		buyWindow = guiCreateWindow ( X, Y, Width, Height, "24/7 Shop", false )
		buyGridlist = guiCreateGridList ( 5, 20, 240, 280, false, buyWindow )
		buyButton = guiCreateButton ( 5, 315, 100, 40, "Buy", false, buyWindow )
		CancelButton = guiCreateButton ( 140, 315, 100, 40, "Cancel", false, buyWindow )
		weapColumn = guiGridListAddColumn ( buyGridlist, "Weapon", 0.7 )
        costColumn = guiGridListAddColumn ( buyGridlist, "Price", 0.22 )
		guiGridListSetSelectionMode ( buyGridlist, 0 )
		
		for i,v in ipairs ( weapons ) do
        local itemName = getWeaponNameFromID ( v[1] )
        local row = guiGridListAddRow ( buyGridlist )
        guiGridListSetItemText ( buyGridlist, row, 1, itemName, false, true )
        guiGridListSetItemText ( buyGridlist, row, 2, tostring ( v[2] ), false, true )
        guiSetAlpha ( buyGridlist,1 )
		guiSetVisible ( buyWindow, false )
		guiWindowSetSizable ( buyWindow, false )
	end
end
addEventHandler ("onClientResourceStart", resourceRoot, createGUI )

function showGUI ( player, matchingDimension )
    if ( player == localPlayer and matchingDimension and not isPedInVehicle ( localPlayer ) and isPedOnGround ( localPlayer ) ) then
	    guiSetVisible ( buyWindow, true )
		showCursor ( true, true )
	end
end

function hideGUI ( player )
    if ( player == localPlayer ) then
	    guiSetVisible ( buyWindow, false )
		showCursor ( false, false )
	end
end
addEventHandler ("onClientPlayerWasted", root, hideGUI )

function hideGUI2 ( player )
    if ( source == CancelButton ) then
	    guiSetVisible ( buyWindow, false )
		showCursor ( false, false )
	end
end
addEventHandler ("onClientGUIClick", root, hideGUI2 )

function wepBuy ( button, state, absoluteX, absoluteYe )
  if ( source == buyButton ) then guiSetVisible ( buyWindow, false ) showCursor ( false, false )
    if ( guiGridListGetSelectedItem ( buyGridlist ) ) then
      local itemName = guiGridListGetItemText ( buyGridlist, guiGridListGetSelectedItem ( buyGridlist ), 1 )
      local itemID = getWeaponIDFromName ( itemName )
      local itemCost = guiGridListGetItemText ( buyGridlist, guiGridListGetSelectedItem ( buyGridlist ), 2 )
  	    if itemName and itemID and itemCost then
    		triggerServerEvent ("GTI24/7_ShopgiveWeaponToPlayer", localPlayer, itemID, itemCost, itemName)
	    end
    end
  end
end
addEventHandler ("onClientGUIClick", root, wepBuy )
