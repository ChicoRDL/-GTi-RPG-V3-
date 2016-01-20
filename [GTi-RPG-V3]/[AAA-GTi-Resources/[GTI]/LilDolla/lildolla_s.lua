
-- /map-warp
-------------->>

addCommandHandler("map-warp",
	function( player, cmd, x, y, z)
		if x and y and z then
			if exports.GTIgovt:isAdmin( player) or exports.GTIgovt:isDeveloper( player) or exports.GTIgovt:isArchitect( player) then
				setElementPosition( player, x, y, z)
				exports.GTIlogs:outputAdminLog( getPlayerName( player).." used /map-warp to warp to '"..getZoneName( x, y, z)..", "..getZoneName( x, y, z, true).."'", "admin", player)
			end
		end
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function ( )
		if ( getServerPort() == 22020 ) then
			addCommandHandler("resource-stop", 
				function (player, _, resource)
					if ( not resource ) then return end
					local resource = getResourceFromName(resource)
						if ( resource ) then
							if ( getResourceState(resource) == "running" ) then
								stopResource(resource)
								outputConsole("restart: Resource stopping...")
							end
						end
				end
			)
			addCommandHandler("resource-refresh", 
				function (player, _, resource)
					refreshResources()
				end
			)
			addCommandHandler("resource-start", 
				function (player, _, resource)
					if ( not resource ) then return end
					local resource = getResourceFromName(resource)
						if ( resource ) then
							if ( getResourceState(resource) == "loaded" ) then
								startResource(resource)
								outputConsole("start: Resource starting...")
							end
						end
				end
			)
		end
	end
)
