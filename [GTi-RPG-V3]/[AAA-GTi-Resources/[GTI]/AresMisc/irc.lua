function job_f(server,channel,user,command,name)
	if not name then exports.GTIirc:ircNotice(user,"Syntax is !job <name>") return end
		local player = exports.GTIutil:findPlayer(name)
		if player then
			local job = exports.GTIemployment:getPlayerJob(player) or 'Unknown'
			exports.GTIirc:ircNotice(user,getPlayerName(player).." is working as "..job..".")
		else
			exports.GTIirc:ircNotice(user,"'"..name.."' no such player")
		end
end

addEventHandler("onResourceStart",resourceRoot,
    function()
        if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
        exports.GTIirc:addIRCCommandHandler("!job",'job_f',0,false)
    end
)

addEventHandler("onResourceStart", root,
	function(resource)
			if (getResourceName(resource) == "GTIirc") then
				setTimer ( 
						function ( )
								 exports.GTIirc:addIRCCommandHandler("!job", 'job_f', 0, false)
						end
				, 3000, 1 )
			end
	end
)


