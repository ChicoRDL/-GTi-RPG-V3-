addEvent("GTIvehiclehud:onPlayerChangeSpeedUnits",true)

--onSpeedUnitChanged: Called when the player changes his speed preference and updates his inventory with the new value.
function onSpeedUnitChanged(preference)
	if (client) and (isElement(client)) and (getElementType(client) == "player") then
		exports.GTIaccounts:invSet(getPlayerAccount(client),"vehunits",preference)
		--outputDebugString("[Veh Units] Updated "..getPlayerName(client).."'s speed preference.")
		return
	end
end
addEventHandler("GTIvehiclehud:onPlayerChangeSpeedUnits",root,onSpeedUnitChanged)

--getSpeedPreference: Loaded when the player logs in or when the resource starts.
local retry = {} --Retry table (DON'T REMOVE)
function getSpeedPreference(player)
	--First, determine whether it was the event that was called.
	if not (isElement(player)) then
		if not (isElement(source)) then return end --If source doesn't exist, just cancel.
		
		player = source --set source to player.
	end
	
	if (player) and (getElementType(player) == "player") then --Check if the player still exists and is actually a player.
		preference = exports.GTIaccounts:invGet(getPlayerAccount(player),"vehunits") --get his inventory crap.
		if not preference then --If for some reason it failed to get this, we'll run some backup...
			preference = "mph" --Warning avoider.
			if not (retry[player]) then --Re-call the function if "retry" hasn't been attempted.
				setTimer(getSpeedPreference,1000,1,player) --try to pull the data again
				retry[player] = true
			end
		end
		
		triggerClientEvent(player,"GTIvehiclehud:onSpeedUnitCollected",player,preference) --Send him his crap.
	end
end
addEventHandler("onDatabaseLoad",root,getSpeedPreference)

--onPlayerQuit: clear out the player's table to save lua memory. (IMPORTANT!)
addEventHandler("onPlayerQuit",root,
function()
	if (retry[source]) then
		retry[source] = nil --clear memory
	end
end)

--onStart: load everyone's preference when the script starts.
function onStart()
	for k,v in ipairs(getElementsByType("player")) do
		setTimer(getSpeedPreference,500,1,v) --Delay it for half a second to give the client a chance to load.
	end
end
addEventHandler("onResourceStart",resourceRoot,onStart)