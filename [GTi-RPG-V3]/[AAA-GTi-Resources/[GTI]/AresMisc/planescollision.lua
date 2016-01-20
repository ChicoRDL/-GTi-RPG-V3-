function onPlaneEnterAsPilot(pilot,seat)
	if seat == 0 then
		--if exports.GTIemployment:getPlayerJob(true) == "Pilot" then
			if getVehicleType(source) == "Plane" then
				for index, value in ipairs (getElementsByType("vehicle")) do
					if getVehicleType(value) == "Plane" then
						setElementCollidableWith(value,source,false)
					end
				end
			end
		--end
	end
end
addEventHandler("onClientVehicleEnter",root,onPlaneEnterAsPilot)
