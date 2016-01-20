local xmlFile = xmlLoadFile ("radios.xml")

stations = {}
stationsNames = {}
stationType = {}
local withoutCarSetting = false

function loadStations ()
    if xmlFile then
        local children = xmlNodeGetChildren (xmlFile)
        for k,v in ipairs(children) do
            local radioTable = xmlNodeGetAttributes (v)
            for name,value in pairs(radioTable) do
                if name == "name" then
                    stationName = value
                elseif name == "path" then
                    stationPath = value
                elseif name == "type" then
					stationT = value
				end
            end
            stations[stationName] = stationPath
			stationType[stationName] = stationT
            table.insert (stationsNames, k, stationName)
        end
    end
end

function loadSettings ()
	local sett = get ("withoutCar")
	if sett then
		withoutCarSetting = sett
	end
end
loadSettings ()
loadStations ()

function onJoin (player)
	triggerClientEvent (player, "sendRadioList", getRootElement(), stationsNames, stations, stationType, withoutCarSetting)
end
addEvent ("requestForRadiosList", true)
addEventHandler ("requestForRadiosList", getRootElement(), onJoin)