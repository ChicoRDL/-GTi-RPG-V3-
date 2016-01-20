----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 22 Dec 2014
-- Resource: JTPenn/adverts.lua
-- Version: 1.0
----------------------------------------->>

--local msg = language:getTranslation( "USEFUL_MESSAGES_" .. math.random(1, amount), getElementData(localPlayer, "language") )
--local last_msg = msg
--outputChatBox("> "..msg, 25, 255, 25)

local language = exports.GTIlanguage
local amount = 13
local last_msg = ""
	
setTimer(function()
	local setting = exports.GTIsettings:getSetting("useful_msg")
	if setting == "No" then return end
	if setting == "Yes" then
		repeat msg = language:getTranslation( "USEFUL_MESSAGES_" .. math.random(1, amount), getElementData(localPlayer, "language") ) until msg ~= last_msg
		outputChatBox("> "..msg, 25, 255, 25)
		last_msg = msg
	end
end, 60000*5, 0)
