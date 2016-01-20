stationsNames = {} -- using station ID, ex. stationNames[ID] = "kwejk fm"
stations = {} -- path
stationType = {} -- 0 GTA radio, 1+ internet radio ex. = stationType["radio kwejk fm"] = 1, stationType["radio off"] = 0
usedStations = {} -- stations IDs, script use stations[ID]
notUsedStations = {} -- stations IDs
usedRadiosXML = xmlLoadFile ("used.xml")
currentStationID = 0 -- 0 = off
currentStation = nil
stationsCount = 0
usedStationsCount = 0
canUse = false
volume = 100
local scrollLimit = 800 --one stations change per 1000ms
local scrollTimer = nil
local lastGTAChannel = 0
local withoutBeingInCar = false

allowVehicles = {}
allowVehicles["Automobile"] = true
allowVehicles["Plane"] = true
allowVehicles["Bike"] = true
allowVehicles["Helicopter"] = true
allowVehicles["Boat"] = true
allowVehicles["Train"] = false
allowVehicles["Trailer"] = false
allowVehicles["BMX"] = false
allowVehicles["Monster Truck"] = true
allowVehicles["Quad"] = false


function loadUsedStations ()
	if not usedRadiosXML then
		usedRadiosXML = xmlCreateFile ("used.xml", "root")
		usedRadiosUsedNode = xmlCreateChild (usedRadiosXML,"radios")
		usedRadiosVolumeNode = xmlCreateChild (usedRadiosXML, "volume")
		xmlNodeSetValue (usedRadiosVolumeNode, "100")
		xmlSaveFile (usedRadiosXML)
	end
	local usedChild = xmlFindChild (usedRadiosXML, "radios", 0)
	local children = xmlNodeGetChildren (usedChild)
	for key,value in ipairs(children) do
		local attributes = xmlNodeGetAttributes (value)
		if attributes then
			for name,v in pairs(attributes) do
				if name == "name" then
					rName = v
				end
				if name == "ID" then
					rID = tonumber(v)
				end
			end
			local founded = false
			
			for k,v in ipairs(notUsedStations) do
				if v == rID then
					founded = k
					break
				end
			end
			if tonumber(founded) then
				table.insert (usedStations, key, rID)
				usedStationsCount = usedStationsCount + 1
				table.remove (notUsedStations, founded)
			else
				outputDebugString ("There is no such a station on server")
			end
		end
	end
	local volumeChild = xmlFindChild (usedRadiosXML, "volume", 0)
	if volumeChild then
		volume = tonumber(xmlNodeGetValue(volumeChild))
	end
end
addEvent ("onRadioListLoad", true)
addEventHandler ("onRadioListLoad", getRootElement(), loadUsedStations)

function getStationName (ID)
	if ID == 0 then
		return "Radio off"
	else
		local nm = stationsNames[ID]
		if nm then
			return nm
		else
			return false
		end
	end
end

function getStationID (name)
	local finded = nil
	if name then
		for k,v in ipairs(stationsNames) do
			if v == name then
				finded = k
				break
			end
		end
		if tonumber(finded) then
			return finded
		else
			return false
		end
	end
end

function onStart ()
	triggerServerEvent ("requestForRadiosList", getLocalPlayer(), getLocalPlayer())
end
addEventHandler ("onClientResourceStart", getResourceRootElement(getThisResource()), onStart)

function onJoin (names, st, typ, withoutCarSetting)
	stationsNames = names
	stations = st
	stationType = typ
	for k,v in ipairs(stationsNames) do
		stationsCount = stationsCount + 1
		table.insert (notUsedStations, k, k)
	end
	triggerEvent ("onRadioListLoad", getRootElement())
	if withoutCarSetting == "true" then
		withoutBeingInCar = true
	elseif withoutCarSetting == "false" then
		withoutBeingInCar = false
	end
	if withoutBeingInCar == true then
		canUse = true
        setRadioStation ("off")
		
		bindKey ("mouse_wheel_up", "both", scroll)
		bindKey ("mouse_wheel_down", "both", scroll)
	else
		addEventHandler("onClientPlayerVehicleEnter", getRootElement(), onEnterVeh)
		addEventHandler("onClientPlayerVehicleExit", getRootElement(), onExitVeh)
		addEventHandler ("onClientPlayerWasted", getLocalPlayer(), onWasted)
	end
end
addEvent ("sendRadioList", true)
addEventHandler ("sendRadioList", getRootElement(), onJoin)

function saveRadios ()
	local radiosChild = xmlFindChild (usedRadiosXML, "radios", 0)
	if radiosChild then
		local children = xmlNodeGetChildren (radiosChild)
		for k,v in ipairs(children) do
			xmlDestroyNode (v)
		end
		for k,v in ipairs(usedStations) do
			local newChild = xmlCreateChild (radiosChild, "used")
			xmlNodeSetAttribute (newChild, "name", getStationName(v))
			xmlNodeSetAttribute (newChild, "ID", v)
		end	
	end
	local volumeChild = xmlFindChild (usedRadiosXML, "volume", 0)
	if volumeChild then
		xmlNodeSetValue (volumeChild, tostring(volume))
	end
	xmlSaveFile (usedRadiosXML)
end	
addEventHandler ("onClientResourceStop", getResourceRootElement(getThisResource()), saveRadios)

-------veh---------------------
-------------------------------
-------------------------------

function onEnterVeh(veh, seat)
	if source == getLocalPlayer () then
		if allowVehicles[getVehicleType(veh)] == true then
			canUse = true
			setRadioStation (currentStationID)
		end
	end
end


function onExitVeh(veh, seat)
    if source == getLocalPlayer() then
		canUse = false
        setRadioStation ("off")
    end
end
addEvent ("onClientPlayerQuitJob", true )
addEventHandler ("onClientPlayerQuitJob", root, onExitVeh )
addEvent ("onClientPlayerGetJob", true )
addEventHandler ("onClientPlayerGetJob", root, onExitVeh )

function onPlayerCmdHide(veh, seat)
		canUse = false
        setRadioStation ("off")
end
addCommandHandler ("hide", onPlayerCmdHide )
addCommandHandler ("djv", onPlayerCmdHide )

function onWasted ()
	canUse = false
   setRadioStation ("off")
end

function scroll (key, keystate)
	if canUse == true then
		if isTimer (scrollTimer) == false then
			scrollTimer = setTimer (
				function ()
					scrollTimer = nil
				end
				,scrollLimit,1
			)
			if key == "radio_next" or key == "mouse_wheel_up" then -- scroll forwards
				setRadioStation ("next")
			elseif key == "radio_previous" or key == "mouse_wheel_down" then -- scroll backwards
				setRadioStation ("back")
			end
		else
			exSetRadioChannel (lastGTAChannel)
		end
	end
end
bindKey ("radio_next", "both", scroll)
bindKey ("radio_previous", "both", scroll)

function exSetRadioChannel (c)
	local c = tonumber(c)
	lastGTAChannel = c
	setRadioChannel (c)
end

function playRadioChangeSound (id)
	local sound = playSoundFrontEnd (34)
	setTimer (playSoundFrontEnd, 500, 1, 35)
end
addEvent ("onRadioStationChange", true)
addEventHandler ("onRadioStationChange", getRootElement(), playRadioChangeSound)

function setRadioStation (st) -- st can be off, number of station (useful on veh enter), "next" and "back"
	if tonumber(st) then
		if currentStation then
			stopSound (currentStation)
		end
		if st >= usedStationsCount then
			currentStationID = usedStationsCount
		else
			currentStationID = st
		end
		if st == 0 then
			exSetRadioChannel (0)
			currentStation = nil
			stName = "Radio off"
			stType = 0
		else
			stName = stationsNames[usedStations[currentStationID]]
			stType = tonumber(stationType[stName])
			if stName then
				if stType == 0 then
					currentStation = nil
					local stID = stations[stName]
					if stID then
						exSetRadioChannel (stID)
					end
				else
					exSetRadioChannel (0)
					local stPath = stations[stName]
					if stPath then
						currentStation = playSound (stPath)
						if currentStation then
							setSoundVolume (currentStation, volume/100)
						end
					end
				end
			else
				outputChatBox ("error", 255,0,0)
			end
		end
		triggerEvent ("onRadioStationChange", getRootElement(), currentStationID)
		showStationText (stName, stType)
	elseif st == "off" then
		if stationType[stationsNames[usedStations[currentStationID]]] == 0 then
			exSetRadioChannel (0)
		else
			if currentStation then
				stopSound (currentStation)
				currentStation = nil
			end
		end
	elseif st == "next" then
		if currentStation then
			stopSound (currentStation)
		end
		if currentStationID >= usedStationsCount then
			currentStationID = 0
			exSetRadioChannel (0)
			stName = "Radio off"
			stType = 0
		else
			currentStationID = currentStationID + 1
			stName = stationsNames[usedStations[currentStationID]]
			stType = tonumber(stationType[stName])
			if stType == 0 then -- gta radio
				currentStation = nil
				local stID = stations[stName]
				if stID then
					exSetRadioChannel (stID)
				end
			else
				exSetRadioChannel (0)
				local stPath = stations[stName]
				if stPath then
					currentStation = playSound (stPath)
					if currentStation then
						setSoundVolume (currentStation, volume/100)
					end
				else
					outputChatBox ("error", 255,0,0)
				end
			end
		end
		triggerEvent ("onRadioStationChange", getRootElement(), currentStationID)
		showStationText (stName, stType)
	elseif st == "back" then
		if currentStation then
			stopSound (currentStation)
		end
		currentStationID = currentStationID - 1
		if currentStationID > usedStationsCount then -- possible when someone delete used stations in car
			currentStationID = usedStationsCount -- set on last station
		elseif currentStationID < 0 then
			currentStationID = usedStationsCount
		end
		if currentStationID == 0 then
			exSetRadioChannel (0)
			currentStation = nil
			stName = "Radio off"
			stType = 0
		else
			stName = stationsNames[usedStations[currentStationID]]
			stType = tonumber(stationType[stName])
			if stType == 0 then -- gta radio
				currentStation = nil
				local stID = stations[stName]

				if stID then
					exSetRadioChannel (stID)
				end
			else
				exSetRadioChannel (0)
				local stPath = stations[stName]
				if stPath then
					currentStation = playSound (stPath)
					if currentStation then
						setSoundVolume (currentStation, volume/100)
					end
				else
					outputChatBox ("error", 255,0,0)
				end
			end
		end
		triggerEvent ("onRadioStationChange", getRootElement(), currentStationID)
		showStationText (stName, stType)
	end
end