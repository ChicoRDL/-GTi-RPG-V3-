--- Date: 14 January 2015
-- Resource: GTIauth/auth.lua
-- Type: Server Side
-- Author: Jack Johnson (Jack)
----------------------------------------->>

local SALT = "GTI-MTA-AUTH"

function onStart()
	for k,v in ipairs(getElementsByType("player")) do
		getPlayerAuthKey(v) --Force-Generate new keys for current online players (in case they didn't have one)
	end
end
addEventHandler("onResourceStart",resourceRoot,onStart)

function onPlayerLogin()
	if not source or not isElement(source) then return false end -- Just to prevent errors...
	local account = getPlayerAccount(source) -- Player's already logged in. He shouldn't be a guest.
	
	-- Check if the player has an auth key. If not, we'll generate one.
	local key = exports.GTIaccounts:GAD(account,"auth")
	if not key then
		generateAuthKey(source)
	elseif #key < 60 then --Re-gen for auth keys that were bugged during db updates
		generateAuthKey(source)
	end
end
addEventHandler("onPlayerLogin",root,onPlayerLogin)

function generateAuthKey(player)
	if not player or not isElement(player) then return false end -- Just to prevent errors...
	local account = getPlayerAccount(player)
	if not account or isGuestAccount(account) then return false end -- If he's not logged in, we'll stop here.
	
	local key = "GTI:"..sha256(getAccountName(account)..SALT..math.random(-10000,10000))
	exports.GTIaccounts:SAD(account,"auth",tostring(key))
	return true, key
end

function getPlayerAuthKey(player)
	if not (player or not isElement(player)) then return false end
	local account = getPlayerAccount(player)
	if not (account or isGuestAccount(account)) then return false end
	
	local key = exports.GTIaccounts:GAD(account,"auth")
	if not key then
		local state,key = generateAuthKey(player)
	elseif #key < 65 then
		local state,key = generateAuthKey(player)
	end
	
	return key or "GTI:NULL"
end

addCommandHandler("authkey",
function(player)
	if not player or not isElement(player) then return false end
	local account = getPlayerAccount(player)
	if not (account or isGuestAccount(account)) then return false end
	
	local key = exports.GTIaccounts:GAD(account,"auth")
	if not key then
		local state,key = generateAuthKey(player)
	end
	
	outputChatBox("Your key has been outputted to the console. DO NOT SHARE THIS KEY!",player,255,0,0)
	if not key then
		outputConsole("Your key could not be retrieved. Please contact an administrator for support.",player)
	else
		outputConsole("Your key: "..key,player)
	end
end)

addCommandHandler("regenauthkey",
function(player)
	if not player or not isElement(player) then return false end
	local account = getPlayerAccount(player)
	if not (account or isGuestAccount(account)) then return false end
	
	local state,key = generateAuthKey(player)
	if key then
		exports.GTIaccounts:SAD(account,"auth",tostring(key))
		outputChatBox("New Key: "..key,player,255,255,0)
		outputChatBox("DON'T SHARE IT!",player,255,0,0)
		return true
	else
		outputChatBox("Failed to get a new key. Contact an administrator!",player,255,0,0)
		return false
	end
end)