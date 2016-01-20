local peds = {
[createPed(147,1272.708, 273.082, 19.558, 251.960)] = {createColSphere(1279.224, 272.229, 12.565,13),1276.916, 279.663, 19},
[createPed(147,1636.516, -1188.160, 24.097, 358.329)] = {createColSphere(1634.223, -1181, 24.097,12),1628.068, -1186.545, 24.412},
}
local doorsloc = {
{1628.4000244141, -1183.9000244141, 24.39999961853, 0, 0, 0},
{1279.3000488281, 277.5, 19.79999923706, 0, 0, 66.25},
}
local money = {}
addCommandHandler("markbstores",function()
	if blip then
		destroyElement(blip1)
		destroyElement(blip2)
		blip = false
	else
		blip1 = createBlip(1634.223, -1182, 24.097, 36)
		blip2 = createBlip(1279.224, 272.229, 12.565, 36)
		blip = true
	end
end)

local doors = {}
local money = {}
function cancelDamage()
	cancelEvent()
end
addEventHandler("onClientResourceStart",resourceRoot,function()
	for i,v in pairs(peds) do
		addEventHandler("onClientPedDamage",i,cancelDamage)
		addEventHandler("onClientColShapeLeave",v[1],onLeave)
	end
	createDoors()
end)
function detectAim( target )
    if (exports.GTIemployment:getPlayerJob(true) == "Criminal") and ( target ) and ( getElementType( target ) == "ped" ) and getControlState("aim_weapon") and peds[target] then
        if isRobbing or isTime then
            if not isDX then
                exports.GTIhud:dm("You've already robbed this store.", 200, 0, 0 )
                isDX = true
                setTimer(function() isDX = false end, 10000, 1)
            end
        return end
		if isElement(marker) then return end
		if not isElementWithinColShape(localPlayer,peds[target][1]) then return end
		if getElementData(localPlayer,"isPlayerRobbing") == true then outputChatBox("You're already robbing.",255,0,0) return end
		colshape = peds[target][1]
		if getCriminals(colshape) and not isDX then
			local x,y,z = getElementPosition(getDoor(colshape))
			marker = createMarker(x,y,z-1.3,"cylinder",1,255,0,0)
			addEventHandler("onClientMarkerHit",marker,plantbomb)
			exports.GTIhud:dm("Go plant a bomb to explode the saferoom's door.", 200, 0, 0 )
			setPedAnimation( target, "ped", "cower", -1, false, false, false, true)
			setTimer(setPedAnimation,180000,1,target)
			isDX = true
			setTimer(function() isDX = false end, 10000, 1)
		end
    end
end
addEventHandler ( "onClientPlayerTarget", localPlayer, detectAim )

function plantbomb(thePlayer,dim)
	if (thePlayer == localPlayer) and dim then
		local crims = getCriminals(colshape)
		local door = getDoor(colshape)
		local mx,my,mz = getElementPosition(localPlayer)
		local x,y,z = getElementPosition(door)
		if mz > z then return end
		if crims then
			triggerServerEvent("GTIBettingStoreRob.rob", localPlayer, crims)
		end
		destroyElement(marker)
	end
end
function getCriminals(col)
	count = {}
	for i,v in pairs(getElementsWithinColShape(col,"player")) do
		if getTeamName(getPlayerTeam(v)) == "Criminals" then
			table.insert(count,v)
		end
	end
	if #count < 3 then--3
		exports.GTIhud:dm("There isn't enough criminals to rob.", 200, 0, 0 )
		return false
	else
		return count
	end		
	count = nil
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


addEvent("GTIBettingStoreRob.start", true)
addEventHandler("GTIBettingStoreRob.start", root, function(name)
	if isRobbing then return end
	if getElementData(localPlayer,"isPlayerRobbing") == true then outputChatBox("You're already robbing.",255,0,0) return end
	isRobbing = true
	local col = getCol()
	if not col then return end
	local door = getDoor(col) 
	if not isElement(door) then return end
	if isElement(marker) then destroyElement(marker) end
	local x,y,z = getElementPosition(door)
    bomb = createObject ( 1654, x, y, z-0.9, -90, 0, 0, true )
    seconds = 180
	isRobbing = true
	setElementData(localPlayer, "isPlayerRobbing", true)
	isTime = true
    timer1 = setTimer ( timerCountDown, 1000, 0, door )
	exports.GTIhud:dm(name.." started a robbery, stay inside for 3 minutes!", 200, 0, 0)
end)
	
function getDoor(col)
	for i,v in pairs(getElementsWithinColShape(col,"object")) do
		if (getElementModel(v) == 3089) then
			return v
		end
	end
end
function getCol()
	for i,v in pairs(peds) do
		if isElementWithinColShape(localPlayer,v[1]) then
			return v[1]
		end
	end
end
function getMoneyLoc(door)
	for i,v in pairs(peds) do
		if v[1] == door then
			return v[2],v[3],v[4]
		end
	end
end
function recreateDoor()
	isTime = false
	createDoors()
	noMoney()
end	
function timerCountDown(door)
        seconds = seconds - 1
        local mins,secds = convertSecsToTime(seconds)
        if mins == "00" and secds == "00" then
			if not isElement(door) then return end
            killTimer(timer1)
			local x,y,z = getElementPosition(door)
			local mx,my,mz = getMoneyLoc(getCol())
			setTimer(recreateDoor,180000,1)
            createMoney(mx,my,mz)
			destroyElement(door)
			destroyElement(bomb)
			createExplosion(x,y,z,12,true,1,false)
            exports.GTIhud:drawStat("bettingRobTimer", "", "", 200, 0, 0)
			isRobbing = false
			setElementData(localPlayer, "isPlayerRobbing", false)
			triggerServerEvent("GTIBettingStoreRob.store", localPlayer)
        else
            exports.GTIhud:drawStat("bettingRobTimer", "Time left", mins..":"..secds, 250, 0, 0)
        end
    end
	
function destroyDoors()
	for i,v in ipairs(doors) do
		if isElement(v) then destroyElement(v) end
	end
	doors = {}
end
function createDoors()
	destroyDoors()
	if (exports.GTIemployment:getPlayerJob(true) == "Criminal") then
		for i,v in pairs(doorsloc) do
			local door = createObject(3089,v[1],v[2],v[3],v[4],v[5],v[6])
			table.insert(doors,door)
		end
	end
end
function createMoney(x,y,z)
	for i=1,4 do
		local px,py,pz = getPos(x,y,z)
		if pz then
			local moni = createPickup(px,py,pz,3,1212)
			addEventHandler("onClientPickupHit", moni, pay)
			table.insert(money,moni)
		end
	end
end

function pay(thePlayer,dim)
	if (thePlayer == localPlayer) and dim then
		destroyElement(source)
		triggerServerEvent("GTIBettingStoreRob.pay", localPlayer)
	end
end

function getPos(x,y,z)
	for i = 1,9 do
		local state = math.random(1,4)
		if (state == 1) then
			_x,_y = x+math.random(1,2.5),y+math.random(1,2.5)
		elseif (state == 2) then
			_x,_y = x-math.random(1,2.5),y+math.random(1,2.5)
		elseif (state == 3) then
			_x,_y = x+math.random(1,2.5),y-math.random(1,2.5)
		elseif (state == 4) then
			_x,_y = x-math.random(1,2.5),y-math.random(1,2.5)
		end
		local _z = z
		if isLineOfSightClear(x,y,_z,_x,_y,_z+2) then
			return _x,_y,_z
		end
	end
end

function noMoney()
	for i,v in pairs(money) do
		if isElement(v) then destroyElement(v) end
		table.remove(money,i)
	end
	if #money > 0 then noMoney() end
end

function stopRob()
	noMoney()
    if ( isRobbing == false ) then return end
    exports.GTIhud:drawStat("bettingRobTimer", "", "", 200, 0, 0)
    if isTimer ( timer1 ) then killTimer ( timer1 ) end
	isRobbing = false
	setElementData(localPlayer, "isPlayerRobbing", false)
	if isElement(bomb) then destroyElement(bomb) end
	if isElement(marker) then destroyElement(marker) end
end
addEvent ("GTIammunationRob_cancelRob", true )
addEventHandler ("GTIammunationRob_cancelRob", root, stopRob )
addEventHandler ("onClientPlayerWasted", localPlayer, function()
	if ( isRobbing == true ) then
		exports.GTIhud:dm ("You failed the robbery!", 200, 0, 0)
	end
	stopRob()
end)

function quitJob(job)
	if (job == "Criminal") then
		stopRob()
		destroyDoors()
	end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, quitJob)
function getJob(job)
	if (job == "Criminal") then
		createDoors()
	end
end 
addEventHandler ("onClientPlayerGetJob", localPlayer, getJob)
function onLeave(thePlayer,dim)
	if (thePlayer == localPlayer) and dim and isRobbing then
		if isElement(marker) then destroyElement(marker) end
		stopRob()
		exports.GTIhud:dm ("You failed the robbery!", 200, 0, 0)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, function()
    if (not getResourceFromName("GTIemployment") or getResourceState(getResourceFromName("GTIemployment")) ~= "running") then return end
	createDoors()
end)