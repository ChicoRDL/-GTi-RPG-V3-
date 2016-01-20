local Blip1 = {}
Blip = 0
ext = 0
extinguished = 0

local fire = engineLoadDFF("fire.dff",1)
engineReplaceModel(fire,2023)

function ExtinguishEmpty(weapon,_,_,hitX,hitY,hitZ,hitElement)
    if weapon ~= 42 then return end
    if (getPlayerJob() == "Firefighter") and getPedTotalAmmo(localPlayer) == 2 then
		exports.GTIhud:dm("Your extinguisher is empty, go refill it.", 255, 255, 0)
	end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,ExtinguishEmpty)

addEvent("GTIfirefighter.firesound", true)
addEventHandler("GTIfirefighter.firesound", root, function(sound)
	if getPlayerJob() == "Firefighter" and firesound then
		setSoundVolume(firesound, sound)
	end
end )

addEvent("GTIfirefighter.blip", true)
addEventHandler("GTIfirefighter.blip", root, function(FX,FY,FZ,sound)
	if (getPlayerJob() == "Firefighter") and FX then 
		fireblip = exports.GTIblips:createCustomBlip(FX, FY, 25, 25, "fire.png", 9999)
		Blip = 1
		firesound = playSound3D("fire.mp3", FX, FY, FZ, true)
		setSoundMaxDistance( firesound, 150 )
		setSoundVolume(firesound, sound)
		local location = getZoneName(FX,FY,FZ)
		local city = getZoneName(FX,FY,FZ,true)
		exports.GTIhud:dm("A fire has been reported in ".. location .." (".. city ..")", 255, 255, 0)
    end
end )

addEvent("GTIfirefighter.noVoice", true)
addEventHandler("GTIfirefighter.noVoice", root, function(ped,obj)
  setPedVoice(ped, "PED_TYPE_DISABLED", "n/a")
  setElementStreamable(obj,true)
end )

addEvent("GTIfirefighter.doneDX", true)
addEventHandler("GTIfirefighter.doneDX", root, function()
	if (getPlayerJob() == "Firefighter") then 
		if extinguished > 0 then
			triggerServerEvent("GTIfirefighter.pay", resourceRoot, extinguished)
			extinguished = 0 
		end
		exports.GTIhud:dm("The fire has been extinguished. Please wait while a new fire is declared.", 255, 255, 0)
		if firesound then stopSound(firesound) end
		firesound = false
		if Blip == 1 then exports.GTIblips:destroyCustomBlip(fireblip) end
		Blip = 0
	end
end )

addEvent("GTIfirefighter.doneVeh", true)
addEventHandler("GTIfirefighter.doneVeh", root, function(x,y,z)
	if (getPlayerJob() == "Firefighter") then 
		for i, vblip in ipairs(Blip1) do
			local blipX, blipY = exports.GTIblips:getCustomBlipPosition(vblip)
			if ( getDistanceBetweenPoints2D(x, y, blipX, blipY) < 1 ) then
				exports.GTIblips:destroyCustomBlip(vblip)
				table.remove(Blip1,i)
			end
		end
	local mx,my,mz = getElementPosition(localPlayer)
	if (getDistanceBetweenPoints3D(mx,my,mz,x,y,z) < 350) then 
		setTimer( function()
		exports.GTIhud:dm("The fire has been extinguished.", 255, 255, 0)
		end, 1500, 1)
	end
end
end ) 

addEvent("GTIfirefighter.destroyedVehMission", true)
addEventHandler("GTIfirefighter.destroyedVehMission", root, function(x,y,z,veh)
	if (getPlayerJob() == "Firefighter") then 
		local vehfireblip = exports.GTIblips:createCustomBlip(x, y, 35, 35, "vehfire.png", 9999)    
		table.insert(Blip1,vehfireblip)
		local location = getZoneName(x,y,z)
		local city = getZoneName(x,y,z,true)
		if veh == "Automobile" then
			cor = "An"
		else
			cor = "A"
		end
		exports.GTIhud:dm(cor.." "..veh.." has exploded in ".. location .." (".. city ..") and the place needs to be extinguished.", 255, 255, 0)
	end
end )

addEvent("GTIfirefighter.whereVehMission", true)
addEventHandler("GTIfirefighter.whereVehMission", root, function(x,y,z)
	if (getPlayerJob() == "Firefighter") then 
		local vehfireblip = exports.GTIblips:createCustomBlip(x, y, 35, 35, "vehfire.png", 9999)
		table.insert(Blip1,vehfireblip)
	end
end )

function noDamage ( attacker, weapon, bodypart, loss )
	if weapon == 42 then
		cancelEvent()
    end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, noDamage )

function ExtinguishSys ( attacker, weapon )
    if ( getElementModel(source) == 137 or getElementModel(source) == 138 ) and getElementType (source) == "ped" then
		cancelEvent()
		if weapon == 42 and (getPlayerJob() == "Firefighter") and attacker == localPlayer then
			ext = ext + 1
			if (ext == 66) then
				ext = 0
				triggerServerEvent("GTIfirefighter.flameToExtinguish", resourceRoot, source)
				if getElementModel(source) == 137 then
					extinguished = extinguished + 1
				elseif getElementModel(source) == 138 then
					triggerServerEvent("GTIfirefighter.vehpay", resourceRoot)
				end
			end
		end
	end
end
addEventHandler ( "onClientPedDamage", root, ExtinguishSys )

function vehFlame()
	if not isElementInWater(source) and source == getPedOccupiedVehicle(localPlayer) and getElementInterior(source) == 0 and getElementDimension(source) == 0 then
		local dx,dy,dz = getElementPosition(source)
		local newZ = getGroundPosition(dx,dy,dz)
		if newZ and newZ > 0 and newZ < 100 then
			local vehtype = getVehicleType(source)
			triggerServerEvent("GTIfirefighter.createVehFlame",resourceRoot,dx,dy,newZ,vehtype)
		end
	end
end
addEventHandler("onClientVehicleExplode", root, vehFlame)

function onTakeJob( job )
    if ( job == "Firefighter" ) then 
    triggerServerEvent("GTIfirefighter.whereIsTheFire", resourceRoot)
	end
end
addEventHandler ("onClientPlayerGetJob", localPlayer, onTakeJob)


function onJobQuit(job)
    if ( job == "Firefighter" ) then 
		if ( Blip == 1 ) then 
			exports.GTIblips:destroyCustomBlip(fireblip) 
		end
	destroyAllBlips()
		if firesound then stopSound(firesound) end
	firesound = false
	Blip = 0
	ext = 0     
		if isElement(freezemarker) then destroyElement(freezemarker) end
			if extinguished > 0 then
				triggerServerEvent("GTIfirefighter.pay", resourceRoot, extinguished)
				extinguished = 0 
			end
		end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)

function destroyAllBlips()
	for i, theBlip in ipairs( Blip1 ) do 
		exports.GTIblips:destroyCustomBlip(theBlip)
		table.remove(Blip1,i) 
	end
	if (#Blip1 > 0) then 
		destroyAllBlips()
	end
end

addEventHandler("onClientResourceStop", resourceRoot, function()
	if extinguished > 0 then
		triggerServerEvent("GTIfirefighter.pay", resourceRoot, extinguished)
		extinguished = 0 
	end
end
)

addEventHandler("onClientResourceStart", root,
	function (res)
		if ( getResourceName(res) == "GTIemployment" or source == resourceRoot ) then
			
			function getPlayerJob()
				return exports.GTIemployment:getPlayerJob(true)
			end
		end
	end
)
