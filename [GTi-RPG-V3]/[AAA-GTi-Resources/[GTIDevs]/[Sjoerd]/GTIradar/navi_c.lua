-- #######################################
-- ## Name: 	Navi				    ##
-- ## Author:	Vandam					##
-- #######################################


local floor = math.floor
local function getAreaID(x, y)
	return floor((y + 3000)/750)*8 + floor((x + 3000)/750)
end

local function getNodeByID(db, nodeID)
	local areaID = floor(nodeID / 65536)
	if areaID<=63 and areaID>=0 then
		return db[areaID][nodeID]
	else
		outputChatBox(areaID)
		outputChatBox(nodeID)
	end
end

function findNodePosition(x,y)
	local startNode=-1
	local entfernung=10000
	local areaID = getAreaID(x, y)
	for j,row in pairs(vehicleNodes[areaID]) do
		local entfernungNodes=getDistanceBetweenPoints2D(x,y,row.x,row.y)
		if entfernung>entfernungNodes then
			entfernung=entfernungNodes
			startNode=row
		end
	end
	return startNode
end

function getPath(startNode, zielNode)
	local genutzteNodes = {}
	genutzteNodes[startNode.id] = true
	local aktuelleNodes = {}
	local wege = {}
	
	for id,distance in pairs(startNode.neighbours) do
		genutzteNodes[id] = true
		aktuelleNodes[id] = distance
		wege[id] = {startNode.id}
	end
	
	while true do
		local besterNode = -1
		local entfernung = 10000
		
		for aktId,aktDist in pairs(aktuelleNodes) do
			if aktDist<entfernung then
				besterNode = aktId
				entfernung = aktDist
			end
		end
		if besterNode==-1 then
			outputChatBox("Keine weg gefunden")
			return {}
		end
		if zielNode.id == besterNode then
			local zuMalen = besterNode
			local wegPunkte={}
			local wegPunktID=1
			while (tonumber(zuMalen) ~= nil) do
				local wegNode = getNodeByID(vehicleNodes, zuMalen)
				wegPunkte[wegPunktID]=wegNode
				wegPunktID=wegPunktID+1		
				zuMalen = wege[zuMalen]
			end
			return wegPunkte
		end
		
		
		for nachbarID,nachbarDist in pairs(getNodeByID(vehicleNodes, besterNode).neighbours) do
			if not genutzteNodes[nachbarID] then
				wege[nachbarID] = besterNode
				aktuelleNodes[nachbarID] = entfernung+nachbarDist
				genutzteNodes[nachbarID] = true
			end
		end
		aktuelleNodes[besterNode] = nil
		
	end
end

local isWegRender=false
local gefundenerWeg=nil
function findBestWay(zielx,ziely)
	wegSavex,wegSavey=zielx,ziely
	lastMarkerPositionX,lastMarkerPositionY,lastMarkerPositionZ=getElementPosition(getLocalPlayer())
	lastMarkerPositionZ=lastMarkerPositionZ-1
	local startNode = findNodePosition(lastMarkerPositionX,lastMarkerPositionY)
	local zielNode = findNodePosition(zielx,ziely)
	gefundenerWeg=getPath(startNode, zielNode)
	for i, row in ipairs(wegTable) do
		destroyElement(wegTable[i].marker)
	end
	wegTable={}
	for i, wegNode in ipairs(gefundenerWeg) do
		if i==1 then
			wegTable[i]={}
			wegTable[i].marker=createMarker(wegNode.x, wegNode.y, wegNode.z,"cylinder",3,255,0,0)
			wegTable[i].posX=wegNode.x
			wegTable[i].posY=wegNode.y
			wegTable[i].posZ=wegNode.z
			wegTable[i].ID=i
			addEventHandler("onClientMarkerHit",wegTable[i].marker,function(player,dim)
				if getLocalPlayer()==player and dim then
					local wegTableNumber=i
					for i,row in ipairs(wegTable) do
						if row.ID>=wegTableNumber then 
							destroyElement(wegTable[i].marker)
							
							lastMarkerPositionX,lastMarkerPositionY,lastMarkerPositionZ=wegTable[i].posX,wegTable[i].posY,wegTable[i].posZ

							wegTable[i]=nil
						end
					end
				end
			end)
			wegTable[i].lastmarker=createColSphere(wegNode.x, wegNode.y, wegNode.z,8)
			setMarkerColor(wegTable[1].marker, 125, 0, 0, 255)
			setMarkerSize(wegTable[1].marker, 3)
		else
			wegTable[i]={}
			wegTable[i].marker=createColSphere(wegNode.x, wegNode.y, wegNode.z,8)
			wegTable[i].posX=wegNode.x
			wegTable[i].posY=wegNode.y
			wegTable[i].posZ=wegNode.z
			wegTable[i].ID=i		
			addEventHandler("onClientColShapeHit",wegTable[i].marker,function(player,dim)
				if getLocalPlayer()==player and dim then
					local wegTableNumber=i
					for i,row in ipairs(wegTable) do
						if row.ID>=wegTableNumber then 
							destroyElement(wegTable[i].marker)
							
							lastMarkerPositionX,lastMarkerPositionY,lastMarkerPositionZ=wegTable[i].posX,wegTable[i].posY,wegTable[i].posZ

							wegTable[i]=nil
						end
					end
				end
			end)
		end
	end
	if not isWegRender then
		addEventHandler("onClientRender",getRootElement(),wegRender)
		isWegRender=true
	end
end


local letzterNode					
function wegRender()
	if showStreetLine then
		letzterNode=nil
		for i,wayPoint in pairs(wegTable) do
			if letzterNode~=nil then
				if (wegTable[i + 1] ~= nil) then
					dxDrawLine3D(wegTable[i].posX,wegTable[i].posY,wegTable[i].posZ+0.3,wegTable[i + 1].posX,wegTable[i + 1].posY,wegTable[i + 1].posZ+0.3,streetLineColor,20)
				else
					dxDrawLine3D(wegTable[i].posX,wegTable[i].posY,wegTable[i].posZ+0.3,lastMarkerPositionX,lastMarkerPositionY,lastMarkerPositionZ+0.3,streetLineColor,20)
				end
			end
			letzterNode=wegTable[i]
		end
	end
end

addEventHandler("onClientResourceStart",getResourceRootElement(),function()
	addCommandHandler(gpsCommand,function()
		local gps=guiCreateStaticImage(500*px,150*py,600*px,600*py,"images/gps.png",false)
		showCursor(true)
		addEventHandler("onClientGUIClick",gps,function(button,state,absoluteX,absoluteY)
			if button=="left" then
				local mapposx,mapposy=guiGetPosition(gps,true)
				local mapsizex,mapsizey=guiGetSize(gps,true)
				local cursorx,cursory=getCursorPosition()
				local cursorxt=(cursorx*16000-8000)
				local cursoryt=(cursory*9000-4500)*-1
				if mapposx<=cursorx and mapposy<=cursory and mapposx+mapsizey>=cursorx and mapposy+mapsizey>=cursory then
					findBestWay(cursorxt,cursoryt)
					destroyElement(gps)
					showCursor(false)
				end
			end
		end)
	end
	)
	
	bindKey(streetLineKey,"down",function()
		if showStreetLine then
			showStreetLine=false
		else
			showStreetLine=true
		end
	end)
end
)

