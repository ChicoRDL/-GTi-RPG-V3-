--local houseData = {}

--[[
addEventHandler( "onResourceStart", resourceRoot,
	function()
		for i = 1, 819 do
			local location = exports.GTIhousing:getHouseData( i, "location")
			local locData = split( location, ",")

			local x, y, z = locData[1], locData[2], locData[3]

			local loc = getZoneName( x, y, z)
			local city = getZoneName( x, y, z, true)

			if loc and city then
				table.insert( houseData, {loc..", "..city})
			end
		end
	end
)

function getHouseLocation( id)
	for i, houseLoc in ipairs do
		if i == id then
			local location = houseLoc[1]

			return location
		else
			return false
		end
	end
end
--]]

function getHouseLocation( x, y, z)
	--if x and y and z then
		local loc = getZoneName( x, y, z)
		local city = getZoneName( x, y, z, true)

		return city
	--end
end
