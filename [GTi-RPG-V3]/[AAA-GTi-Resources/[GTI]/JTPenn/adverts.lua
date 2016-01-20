----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 22 Dec 2014
-- Resource: JTPenn/adverts.lua
-- Version: 1.0
----------------------------------------->>

local language = exports.GTIlanguage

local msg = language:getTranslation( "USEFUL_MESSAGES_" .. math.random(1, 13), getElementData(localPlayer, "language") )

local last_msg = msg
outputChatBox("> "..msg, root, 25, 255, 25)
	
setTimer(function()
	repeat msg = language:getTranslation( "USEFUL_MESSAGES_" .. math.random(1, 13), getElementData(localPlayer, "language") ) until msg ~= last_msg
	outputChatBox("> "..msg, root, 25, 255, 25)
	last_msg = msg
end, 60000*5, 0)
