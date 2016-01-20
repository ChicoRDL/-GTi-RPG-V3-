local textsToDraw = {}

local showtime = 4500
local maxbubbles = 3

local showthebubbles = true

addEvent("GTIchat.playSound", true)
addEventHandler("GTIchat.playSound", root, playSound)

function income(message)
	addText(source,message)
end
addEvent("GTIsocial.addBubble", true)
addEventHandler("GTIsocial.addBubble", root, income)

function addText(source,message)
	local notfirst = false
	for i,v in ipairs(textsToDraw) do
		if v[1] == source then
			v[3] = v[3] + 1
			notfirst = true
		end
	end
	local infotable = {source,message,0}
	table.insert(textsToDraw,infotable)
	if not notfirst then
		setTimer(removeText,showtime,1,infotable)
	end
end

function removeText(infotable)
	for i,v in ipairs(textsToDraw) do
		if v[1] == infotable[1] and v[2] == infotable[2] then
			for i2,v2 in ipairs(textsToDraw) do
				if v2[1] == v[1] and v[3] - v2[3] == 1 then
					setTimer(removeText,showtime ,1,v2)
				end
			end
			table.remove(textsToDraw,i)
			break
		end
	end
end

function getTextsToRemove()
	for i,v in ipairs(textsToDraw) do
		if v[1] == source then
			removeText(v)
		end
	end
end
addEventHandler("onClientPlayerQuit",getRootElement(),getTextsToRemove)

function handleDisplay()
	if showthebubbles then
		for i,v in ipairs(textsToDraw) do
			if isElement(v[1]) then
				if getElementHealth(v[1]) > 0 then
					local camPosXl, camPosYl, camPosZl = getPedBonePosition (v[1], 6)
					local camPosXr, camPosYr, camPosZr = getPedBonePosition (v[1], 7)
					local x,y,z = (camPosXl + camPosXr) / 2, (camPosYl + camPosYr) / 2, (camPosZl + camPosZr) / 2
					local posx,posy = getScreenFromWorldPosition(x,y,z+0.25)
					local cx,cy,cz = getCameraMatrix()
					local px,py,pz = getElementPosition(v[1])
					local distance = getDistanceBetweenPoints3D(cx,cy,cz,px,py,pz)
					local posx,posy = getScreenFromWorldPosition(x,y,z+0.040*distance+0.15)
					local elementtoignore1 = getPedOccupiedVehicle(getLocalPlayer()) or getLocalPlayer()
					local elementtoignore2 = getPedOccupiedVehicle(v[1]) or v[1]
					if posx and distance <= 30 and ( isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore1) or isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore2) ) and ( not maxbubbles or  v[3] < maxbubbles ) and isElementStreamedIn(v[1]) then -- change this when multiple ignored elements can be specified
						local width = dxGetTextWidth(v[2],1,"default")
						--dxDrawRectangle(posx - (3 + (0.5 * width)),posy - (2 + (v[3] * 20)),width + 5,19,tocolor(25,25,25,35))
						--dxDrawRectangle(posx - (6 + (0.5 * width)),posy - (2 + (v[3] * 20)),width + 11,19,tocolor(25,25,25,35))
						--dxDrawRectangle(posx - (8 + (0.5 * width)),posy - (1 + (v[3] * 20)),width + 15,17,tocolor(25,25,25,35))
						--dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (1 + (v[3] * 20)),width + 19,17,tocolor(25,25,25,25))
						--dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (v[3] * 20) + 1,width + 19,13,tocolor(25,25,25,25))
						--dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (v[3] * 20) + 1,width + 23,13,tocolor(25,25,25,25))
						--dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (v[3] * 20) + 4,width + 23,7,tocolor(25,25,25,25))
						--
						dxDrawRectangle(posx - (3 + (0.5 * width)),posy - (2 + (v[3] * 20)),width + 5,19,tocolor(25, 25, 25, 200))
						dxDrawLine(posx - (3 + (0.5 * width)), posy - (2 + (v[3] * 20)), posx + (2 + (0.5 * width)), posy - (2 + (v[3] * 20)), tocolor(0, 0, 0, 255), 1)
						dxDrawLine(posx - (3 + (0.5 * width)), posy - (-15 + (v[3] * 20)), posx + (2 + (0.5 * width)), posy - (-15 + (v[3] * 20)), tocolor(0, 0, 0, 255), 1)
						--
						local r,g,b = 255,255,255
						dxDrawText(v[2],posx - (0.5 * width),posy - (v[3] * 20),posx - (0.5 * width),posy - (v[3] * 20),tocolor(r,g,b,255),1,"default","left","top",false,false,false)
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),handleDisplay)