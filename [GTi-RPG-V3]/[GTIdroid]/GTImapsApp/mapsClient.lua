GUIEditor = {
    gridlist = {},
    window = {},
    button = {},
    edit = {},
    label = {}
}
Blips = {}
function renderAppGUI()
	if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    GTIApp = exports.GTIdroid:getGTIDroidAppButton("Maps")
    addEventHandler("onClientGUIClick", GTIApp, showAppGUI, false)
		local sWidth, sHeight = guiGetScreenSize()
		local Width,Height = 271,118
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
        GUIEditor.window[1] =  guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
        GUIEditor.edit[1] = guiCreateEdit(5, 0, 260, 31, "", false, GUIEditor.window[1])
        GUIEditor.gridlist[1] = guiCreateGridList(5, 71, 261, 310, false, GUIEditor.window[1])
        column = guiGridListAddColumn( GUIEditor.gridlist[1] , "Players", 0.85 )
        GUIEditor.button[1] = guiCreateButton(5, 390, 80, 25, "Mark/Unmark", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(94, 390, 80, 25, "Info", false, GUIEditor.window[1])   
        GUIEditor.button[3] = guiCreateButton(180, 390, 80, 25, "GPS", false, GUIEditor.window[1])   
		button = guiCreateCheckBox(85, 30, 390, 34, "Show direction", false, false, GUIEditor.window[1])
		guiSetVisible(GUIEditor.window[1],false)
		--gps gui 
        GUIEditor.window[3] =  guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
        GUIEditor.gridlist[2] = guiCreateGridList(5, 71, 261, 310, false, GUIEditor.window[3])
		guiGridListSetSortingEnabled ( GUIEditor.gridlist[2], false )
        column2 = guiGridListAddColumn( GUIEditor.gridlist[2] , "", 0.85 )
        GUIEditor.button[5] = guiCreateButton(7, 390, 120, 25, "Mark/Unmark", false, GUIEditor.window[3])
        GUIEditor.button[6] = guiCreateButton(140, 390, 120, 25, "Mark players", false, GUIEditor.window[3])   
        GUIEditor.label[5] = guiCreateLabel(10, 15, 390, 34, "", false, GUIEditor.window[3])
        GUIEditor.label[6] = guiCreateLabel(10, 35, 390, 34, "", false, GUIEditor.window[3])
		guiLabelSetColor(GUIEditor.label[5],255,255,0)
		guiLabelSetColor(GUIEditor.label[6],255,255,0)
		guiSetVisible(GUIEditor.window[3],false)
		--info gui
		GUIEditor.window[2] = guiCreateWindow(X, Y, Width, Height, "", false)
        guiWindowSetSizable(GUIEditor.window[2], false)
        GUIEditor.label[1] = guiCreateLabel(10, 35, 390, 34, "", false, GUIEditor.window[2])
        GUIEditor.label[2] = guiCreateLabel(10, 55, 390, 34, "", false, GUIEditor.window[2])
        GUIEditor.label[3] = guiCreateLabel(10, 75, 390, 34, "", false, GUIEditor.window[2])
        GUIEditor.button[4] = guiCreateButton(242, 89, 20, 20, "X", false, GUIEditor.window[2])
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFFF0000")    
		guiSetVisible(GUIEditor.window[2],false)
end
addEventHandler("onClientResourceStart", resourceRoot, renderAppGUI)

addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderAppGUI)
function showAppGUI()
    guiSetVisible(GUIEditor.window[1], true)
    exports.GTIdroid:showMainMenu(false)
    exports.GTIdroid:playTick()
	getPlayers()
end

function hideAppGUI()
	if guiGetVisible(GUIEditor.window[1]) or guiGetVisible(GUIEditor.window[2]) or guiGetVisible(GUIEditor.window[3]) then
		guiSetVisible(GUIEditor.window[1],false)
		guiSetVisible(GUIEditor.window[2],false)
		guiSetVisible(GUIEditor.window[3],false)
		exports.GTIdroid:showMainMenu(true)
	end
end
addEvent("onGTIDroidClose", true)
addEventHandler("onGTIDroidClose", root, hideAppGUI)
addEventHandler("onClientResourceStop", resourceRoot, hideAppGUI)

addEvent("onGTIDroidClickBack", true)
addEventHandler("onGTIDroidClickBack", root, function()
	if guiGetVisible(GUIEditor.window[3]) then
		exports.GTIdroid:showMainMenu(false, false)
		guiSetVisible(GUIEditor.window[3],false)
		guiSetVisible(GUIEditor.window[1],true)
	elseif guiGetVisible(GUIEditor.window[1]) or guiGetVisible(GUIEditor.window[2]) then
		guiSetVisible(GUIEditor.window[1],false)
		guiSetVisible(GUIEditor.window[2],false)
	end
end )

function findRotation(x1,y1,z1,x2,y2,z2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end
  local roty = 90+(math.deg(math.asin((z2 - z1) / getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2))))
  return roty,t-90
end

addEventHandler("onClientGUIChanged",root,function()
if source == GUIEditor.edit[1] then
        guiGridListClear(GUIEditor.gridlist[1])
        for k,v in ipairs ( getElementsByType("player") ) do
                local name = string.lower(getPlayerName(v))
                if name and not (v == localPlayer) then
                        if string.find (name,string.lower(guiGetText(GUIEditor.edit[1])) ) then
                                row = guiGridListAddRow ( GUIEditor.gridlist[1] )
                                guiGridListSetItemText ( GUIEditor.gridlist[1], row, column, getPlayerName ( v ), false, false )
                                end
                        end
                end
        end
end
)

function getPlayers()
	if ( column ) then
		if guiGetText(GUIEditor.edit[1]) ~= "" then return end
		guiGridListClear(GUIEditor.gridlist[1])
        for id, player in ipairs(getElementsByType("player")) do
			if not (player == localPlayer) then
				local row = guiGridListAddRow ( GUIEditor.gridlist[1]  )
				guiGridListSetItemText ( GUIEditor.gridlist[1] , row, column, getPlayerName ( player ), false, false )
				guiGridListSetItemData ( GUIEditor.gridlist[1] , row, column, player )
				if isElement(Blips[player]) then
					guiGridListSetItemColor ( GUIEditor.gridlist[1], row, column, 255, 255, 0 )
				end
			end
		end
	end
end

addEventHandler("onClientPlayerJoin",getRootElement(),getPlayers)
addEventHandler("onClientPlayerChangeNick",getRootElement(),getPlayers)

function getOffPlayer()
	if isElement(Blips[source]) then
		destroyElement(Blips[source])
		Blips[source] = nil
	end
	local num = guiGridListGetRowCount (GUIEditor.gridlist[1] )
	for i = 1,num do
		if guiGridListGetItemData ( GUIEditor.gridlist[1] , i, column ) == source then
			guiGridListRemoveRow( GUIEditor.gridlist[1], i )
		end
	end
end
addEventHandler("onClientPlayerQuit",getRootElement(),getOffPlayer)

function getInfo(player)
	if ( player ) then
		local x, y, z = getElementPosition(player)
		local mx, my, mz = getElementPosition(localPlayer)
		local dist = (getDistanceBetweenPoints3D(x, y, z, mx, my, mz)/1000)*0.621371192
		local distance = tonumber(("%.2f"):format(dist))
		local location = getZoneName(x, y, z)
		local city = exports.GTIchat:getPlayerCity(player)
		local status = getPedOccupiedVehicle(player)
		guiSetText ( GUIEditor.label[1], "Distance: "..distance.." Miles")
		guiSetText ( GUIEditor.label[2], "Location: "..city..", "..location )
		if status then
			local veh = getVehicleName(status)
			guiSetText ( GUIEditor.label[3], "Status: in a "..veh )
		else
			guiSetText ( GUIEditor.label[3], "Status: On Foot" )
		end
	end
end

function getInfoxyz(x,y,z)
	local mx, my, mz = getElementPosition(localPlayer)
	local dist = (getDistanceBetweenPoints3D(x, y, z, mx, my, mz)/1000)*0.621371192 
	local distance = tonumber(("%.3f"):format(dist))
	local location = getZoneName(x, y, z)
	local city = getZoneName(x, y, z, true)
	guiSetText ( GUIEditor.label[5], "Distance: "..distance.." Miles")
	guiSetText ( GUIEditor.label[6], "Location: "..city..", "..location )
end

function setLoc(city,loc)
	if city ~= "" then
		local rowindex = getRow(city)
		if not rowindex then
			local rowindex = guiGridListAddRow ( GUIEditor.gridlist[2]  )
			guiGridListSetItemText ( GUIEditor.gridlist[2] , rowindex, column2, city, true, false )
			guiGridListSetItemColor ( GUIEditor.gridlist[2], rowindex, column2, 255, 255, 0 )
			local row = guiGridListInsertRowAfter(GUIEditor.gridlist[2], rowindex)
			guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, loc, false, false )
			guiGridListSetItemData ( GUIEditor.gridlist[2] , row, column2, city)
		return end 
		local row = guiGridListInsertRowAfter(GUIEditor.gridlist[2], rowindex)
		guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, loc, false, false )
		guiGridListSetItemData ( GUIEditor.gridlist[2] , row, column2, city)
	else
		local row = guiGridListAddRow(GUIEditor.gridlist[2])
		guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, loc, false, false )
		guiGridListSetItemData ( GUIEditor.gridlist[2] , row, column2, city)
	end
end

function setHouses(tableh)
	for i,v in pairs(tableh) do
		local x,y,z = v[2],v[3],v[4]
		local city = getZoneName(x,y,z,true)
		local loc = v[1] 
		local rowindex = getRow(city)
		if not rowindex then
			local rowindex = guiGridListAddRow ( GUIEditor.gridlist[2]  )
			guiGridListSetItemText ( GUIEditor.gridlist[2] , rowindex, column2, city, true, false )
			guiGridListSetItemColor ( GUIEditor.gridlist[2], rowindex, column2, 255, 255, 0 )
			local row = guiGridListInsertRowAfter(GUIEditor.gridlist[2], rowindex)
			guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, loc, false, false )
			guiGridListSetItemData ( GUIEditor.gridlist[2] , row, column2, {x,y,z})
		else
			local row = guiGridListInsertRowAfter(GUIEditor.gridlist[2], rowindex)
			guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, loc, false, false )
			guiGridListSetItemData ( GUIEditor.gridlist[2] , row, column2, {x,y,z})
		end
	end
end
addEvent("GTIMapsApp.setHouses",true)
addEventHandler("GTIMapsApp.setHouses",root,setHouses)

function getRow(city)
	local num = guiGridListGetRowCount (GUIEditor.gridlist[2] )
	for i = 0,num do
		if guiGridListGetItemText ( GUIEditor.gridlist[2] , i, column2 ) == city then
			return i
		end
	end
	return false
end

function setCat(theCat)
    local row = guiGridListAddRow ( GUIEditor.gridlist[2]  )
    guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, theCat, false, false )
end

function convertSecsToTime(seconds)
		local hours = 0
		local minutes = 0
		local secs = 0
		local theseconds = seconds
		if theseconds >= 60*60 then
			hours = math.floor(theseconds / (60*60))
			theseconds = theseconds - ((60*60)*hours)
		end
		if theseconds >= 60 then
			minutes = math.floor(theseconds / (60))
			theseconds = theseconds - ((60)*minutes)
		end
		if theseconds >= 1 then
			secs = theseconds
		end
		if minutes < 10 then
		minutes = "0"..minutes
		end
		if secs < 10 then
		secs = "0"..secs
		end
	return minutes,secs
end

addEventHandler("onClientGUIClick",root,function()
	if ( source == GUIEditor.button[1] ) then
		exports.GTIdroid:playTick()
		local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
		local playe = getPlayerFromName(selectedplayer)
		if not isElement(playe) then return end
		if isElement(Blips[playe]) then
			unmark(playe,selectedplayer.." successfully unmarked!")
		else
			local arw = guiCheckBoxGetSelected(button)
			local row, col = guiGridListGetSelectedItem ( GUIEditor.gridlist[1] )
			if isElement(Blips[playe]) then return end
			--triggerServerEvent("GTIMapsApp.mark",resourceRoot,playe,arw,row,col,true)
			if ( not isElement(playe) ) then return end
			markPlayer(playe, arw, row, col, true)
		end
	elseif ( source == GUIEditor.button[2] ) then
		exports.GTIdroid:playTick()
		local selectedplayer = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
		local playe = getPlayerFromName(selectedplayer)
	if (not isElement(playe)) or (not exports.GTIaccounts:isPlayerLoggedIn(playe)) or (not getElementDimension(playe) == 0) then exports.GTIhud:dm("This player can't be marked.", 255, 255, 0) return end
		triggerServerEvent("GTIMapsApp.mark",resourceRoot,playe,arw,row,col,false)
	elseif ( source == GUIEditor.button[4] ) then
		guiSetVisible(GUIEditor.window[2],false)
	elseif ( source == GUIEditor.gridlist[1] ) then
		exports.GTIdroid:playTick()
	elseif ( source == GUIEditor.gridlist[2] ) and guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ) ~= -1 then
		exports.GTIdroid:playTick()
		local selectedloc = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
		local city =  guiGridListGetItemData(GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] )) 
		local fx,fy,fz = getPos(selectedloc,city)
		if fx and fy then
		getInfoxyz(fx,fy,fz)
	end
	elseif ( source == GUIEditor.button[3] ) then
		guiGridListClear(GUIEditor.gridlist[2])
		getCats()
		exports.GTIdroid:playTick()
		guiSetVisible(GUIEditor.window[1],false)
		guiSetVisible(GUIEditor.window[3],true)
		exports.GTIdroid:showMainMenu(false)
	elseif ( source == GUIEditor.button[6] ) then
		exports.GTIdroid:playTick()
		guiSetVisible(GUIEditor.window[3],false)
		guiSetVisible(GUIEditor.window[1],true)
		exports.GTIdroid:showMainMenu(false)
	elseif ( source == GUIEditor.button[5] ) then
		exports.GTIdroid:playTick()
		local selectedloc = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
	if isElement(Bliploc) then
		destroyElement(Bliploc)
		if not isElement(Arrow) then return end
		destroyElement(Arrow)
		Bliploc = nil
		lx,ly,lz = nil
		removeEventHandler("onClientPreRender", getRootElement(), ArrowRender)
		if isTimer(ETATimer) then
		killTimer(ETATimer,750,0)
		exports.GTIhud:drawStat("ETA", "", "", 255, 200, 0)
		end
	else
		local city =  guiGridListGetItemData(GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] )) 
		lx,ly,lz = getPos(selectedloc,city,true)
		if lx and ly and not isElement(Arrow) then
			playert = false
			Bliploc = createBlip(lx,ly,lz,19)
			local rx,ry,rz = getElementPosition(localPlayer)
			Arrow = createObject(1318,rx,ry,rz)
			setElementCollisionsEnabled(Arrow,false)
			addEventHandler("onClientPreRender", getRootElement(), ArrowRender)
			if not isTimer(ETATimer) then
				ETATimer = setTimer(ETA,750,0)
			end
		end
	end
end
end
)

function unmark(playe,msg)
if (not isElement(playe)) then return end
if isElement(Blips[playe]) then
	destroyElement(Blips[playe])
	Blips[playe] = nil
	exports.GTIhud:dm(msg, 255, 255, 0)
	local row, col = guiGridListGetSelectedItem ( GUIEditor.gridlist[1] )
	guiGridListSetItemColor ( GUIEditor.gridlist[1], row, col, 255, 255, 255 )
	if isElement(Arrow) then
	removeEventHandler("onClientPreRender", getRootElement(), ArrowRender) 
	destroyElement(Arrow)
	playert = false
	if isTimer(ETATimer) then
	killTimer(ETATimer,750)
	exports.GTIhud:drawStat("ETA", "", "", 255, 200, 0)
	end
	end
end
end
addEvent("GTIMapsApp.unmark",true)
addEventHandler("GTIMapsApp.unmark",root,unmark)

function markPlayer(playe,arrw,row,col,mark)
	if not isElement(playe) then return end
	local selectedplayer = getPlayerName(playe)
	if mark then
		Blips[playe] = createBlipAttachedTo ( playe, math.random(58,62) )
		exports.GTIhud:dm(selectedplayer.." successfully marked!", 255, 255, 0)
		guiGridListSetItemColor ( GUIEditor.gridlist[1], row, col, 255, 255, 0 )
		if arrw and not isElement(Arrow) then
			local rx,ry,rz = getElementPosition(localPlayer)
			Arrow = createObject(1318,rx,ry,rz)
			setElementCollisionsEnabled(Arrow,false)
			playert = playe
			addEventHandler("onClientPreRender", getRootElement(), ArrowRender)
			if not isTimer(ETATimer) then
				ETATimer = setTimer(ETA,750,0)
			end
		end
	else
	getInfo(playe)
	guiSetText(GUIEditor.window[2],selectedplayer)
	guiSetVisible(GUIEditor.window[2],true)
	end
end
addEvent("GTIMapsApp.markPlayer",true)
addEventHandler("GTIMapsApp.markPlayer",root,markPlayer)

function showLocs()
	if ( source == GUIEditor.gridlist[2] ) then
		if not guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ) then return end
		local selectedcat = guiGridListGetItemText ( GUIEditor.gridlist[2], guiGridListGetSelectedItem ( GUIEditor.gridlist[2] ), 1 )
		if selectedcat == "..." then 
			guiGridListClear(GUIEditor.gridlist[2])
			getCats()
		return end
		if isitacategory(selectedcat) then
			guiGridListClear(GUIEditor.gridlist[2])
			local row = guiGridListAddRow ( GUIEditor.gridlist[2]  )
			guiGridListSetItemText ( GUIEditor.gridlist[2] , row, column2, "...", false, false )
			getLocs(selectedcat)
		end
	end
end
addEventHandler( "onClientGUIDoubleClick", root, showLocs )

function ArrowRender()
	if playert then
		if not isElement(playert) then cancelRender() return end
		lx,ly,lz = getElementPosition(playert)
	end
	if getPedOccupiedVehicle(localPlayer) then
		tx,ty,tz = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local roty,rotz = findRotation(tx,ty,tz,lx,ly,lz)
		setElementPosition(Arrow, tx, ty, tz+1.5)
		setElementRotation(Arrow, 0, roty, rotz)
	else
		tx,ty,tz = getElementPosition(localPlayer)
		local roty,rotz = findRotation(tx,ty,tz,lx,ly,lz)
		setElementPosition(Arrow, tx, ty, tz+1.15)
		setElementRotation(Arrow, 0, roty, rotz)
	end
		if getDistanceBetweenPoints3D(tx,ty,tz,lx,ly,lz) < 25 then 
		cancelRender()
		exports.GTIhud:dm("You've arrived at your destination!", 255, 255, 0)
	end
end

function cancelRender()
	removeEventHandler("onClientPreRender", getRootElement(), ArrowRender)
	if isTimer(ETATimer) then
	killTimer(ETATimer,750,0)
	exports.GTIhud:drawStat("ETA", "", "", 255, 200, 0)
	end
	if isElement(Bliploc) then destroyElement(Bliploc) end
	if isElement(Arrow) then destroyElement(Arrow) end
	Bliploc = nil
	lx,ly,lz = nil
	end

function ETA()
	if getPedOccupiedVehicle(localPlayer) then
		speedx, speedy, speedz = getElementVelocity ( getPedOccupiedVehicle(localPlayer) )
	else
		speedx, speedy, speedz = getElementVelocity ( localPlayer )
end
	local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
	local kmh = actualspeed * 180
	local rx,ry,rz = getElementPosition(localPlayer)
	local dist = (getDistanceBetweenPoints3D(rx,ry,rz,lx,ly,lz)/1000)
	local seconds = tonumber(math.floor((dist/kmh)*60*60))
	local mins,secds = convertSecsToTime(seconds)
	if mins == "00" and secds == "00" then
		exports.GTIhud:drawStat("ETA", "ETA", "N/A", 255, 200, 0)
	else
		exports.GTIhud:drawStat("ETA", "ETA", mins..":"..secds, 255, 200, 0)
	end
end
