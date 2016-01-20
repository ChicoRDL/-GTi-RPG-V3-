local last_update = ""
local updates = {}

function notifyUpdate(theupdate, category, by)
	if (theupdate and category and by) then
		local updateFormat = "[Update] "..category..": "..theupdate.." ("..by..")"
		--local echoUpdate = "[Update]: "..by.." pushed an update onto the server. (["..category.."] "..theupdate..")"
		--outputChatBox("** (Update) " .. category .. ": " .. theupdate .. " (" .. by .. ")", getRootElement(), 255, 128, 0)
		--exports.GTIhud:drawNote( "updateNotification", updateFormat, root, 255, 128, 0, 10000)
		outputChatBox(updateFormat, root, 255, 150, 0)
		exports.GTIlogs:outputWebLog(updateFormat)
		last_update = category..": "..theupdate.." ("..by..")"
		table.insert( updates, category..": "..theupdate.." ("..by..")")
		outputIRC( category..": "..theupdate.." ("..by..")")
	end
end

function outputIRC( text)
	local chan = exports.GTIirc:ircGetChannelFromName( "#updates")
	exports.GTIirc:ircSay( chan, text)
end

function ircGetLastUpdate()
	for i, update in pairs ( updates) do
		outputIRC( update)
		--[[
		if #updates > 5 then
			if i <= 6 then
				outputIRC( update[1])
			else
				outputIRC( update[1])
			end
		end
		--]]
	end
end
exports.GTIirc:addIRCCommandHandler( "!update", ircGetLastUpdate(), 0, false)

addEventHandler( "onResourceStart", resourceRoot,
	function()
		local ircServer = exports.LilDolla:getIRCServer()
		exports.GTIirc:ircJoin( ircServer, "#updates")
	end
)

addEventHandler( "onResourceStop", resourceRoot,
	function()
		exports.GTIirc:ircPart( exports.GTIirc:ircGetChannelFromName( "#updates"), "Update Retrieval Script Stopped.")
	end
)
