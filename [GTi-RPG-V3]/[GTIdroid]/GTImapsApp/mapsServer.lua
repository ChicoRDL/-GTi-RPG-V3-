local housesdata = {}

function mark(thePlayer,arrow,row,col,mark)
	if not isElement(client) or not isElement(thePlayer) then return end
    local clientname = getPlayerName(client)
    local name = getPlayerName(thePlayer)

	triggerClientEvent(client,"GTIMapsApp.markPlayer",resourceRoot,thePlayer,arrow,row,col,mark)
end
addEvent("GTIMapsApp.mark",true)
addEventHandler("GTIMapsApp.mark",root,mark)

function getHouses()
	local houses = exports.GTIhousing:getPlayerTotalHouses(client) or {}
	housesdata[client] = {}
	for i,v in ipairs(houses) do
		local address = exports.GTIhousing:getHouseData(v, "address")
		local pos = exports.GTIhousing:getHouseData(v, "location")
		local loc = split(pos, ",")
		local x,y,z,int,dim = tonumber(loc[1]), tonumber(loc[2]), tonumber(loc[3]), tonumber(loc[4]), tonumber(loc[5])
		table.insert(housesdata[client],{address,x,y,z})
	end
	triggerClientEvent(client,"GTIMapsApp.setHouses",resourceRoot,housesdata[client])
	housesdata[client] = nil
end
addEvent("GTIMapsApp.getHouses",true)
addEventHandler("GTIMapsApp.getHouses",root,getHouses)