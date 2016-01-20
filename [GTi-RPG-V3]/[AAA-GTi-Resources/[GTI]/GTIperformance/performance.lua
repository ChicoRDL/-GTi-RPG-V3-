local listener

function monitor()
	local time,usage = getPerformanceStats("Lua timing")
	for k,v in ipairs(usage) do
		local _usage = string.gsub(v[2],"[^0-9]", "") or 0
		if (_usage ~= nil) then
			local _usage = math.floor(tonumber(_usage))
			if (tonumber(_usage) > 50) then
				outputChatBox("[PM] Resource: "..v[1].." is using high CPU usage! (".._usage.."%)",255,255,0,true)
			end
		end
	end
end

function monitor_cmd(cmd,state)
	if (not state) then return false end
	outputChatBox(tostring(type(state)))
	if (not state == "on" or not state == "off") then return false end
	
	if (state == "on") then
		if (isTimer(listener)) then
			killTimer(listener)
		end
		
		listener = setTimer(monitor,1000,0)
		outputChatBox("Monitor on.",255,0,0,true)
	elseif (state == "off") then
		if (isTimer(listener)) then
			killTimer(listener)
			outputChatBox("Monitor off.",255,0,0,true)
		end
	end
end
addCommandHandler("performance_monitor",monitor_cmd)