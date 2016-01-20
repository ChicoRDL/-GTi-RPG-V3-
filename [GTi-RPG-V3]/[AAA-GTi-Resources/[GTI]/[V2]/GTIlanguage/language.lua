----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 08 April 2015
-- Resource: GTIlanguage/language.lua
-- Type: Both sides
-- Author: Jack Johnson (Jack)
----------------------------------------->>
function onClientStart()
	localPlayer:setData("language",getLocalization()["code"],true) --sync
end
addEventHandler("onClientResourceStart",resourceRoot,onClientStart)

function getTranslation(text_variable,language)
	--Make sure the language table resource is online
	if not (isLanguageResourceOnline()) then
		return false
	end
	
	--Figure out if we're client or server
	local side = nil
	if (localPlayer == nil) then side = "server" else side = "client" end
	
	--Get the language table
	local lTable = exports.GTIlanguageTable:getLanguages()
	
	--Check language
	if not language then
		language = getPlayerLanguage() or "en_US"
	end
	
	--Check if that language exists, otherwise return false. If it exists but no translation, return en_US version.
	if not (lTable[side][text_variable]) then return false end
	
	return lTable[side][text_variable][language] or lTable[side][text_variable]["en_US"]
end
	

function getPlayerLanguage(player)
	if localPlayer then
		player = localPlayer
	end
	
	if not player then
		outputDebugString("Bad argument @ 'getPlayerLanguage' [Expected player, got nil]",1)
		return false
	elseif not (isElement(player) and getElementType(player) == "player") then
		outputDebugString("Bad argument @ 'getPlayerLanguage' [Expected player, got "..tostring(type(player)).."]",1)
		return false
	end
	
	return player:getData("language")
end

function isLanguageResourceOnline()
	if (getResourceState(getResourceFromName("GTIlanguageTable")) == "running") then return true else return false end
end
