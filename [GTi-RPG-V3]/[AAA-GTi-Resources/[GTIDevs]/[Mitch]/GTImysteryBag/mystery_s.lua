----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: mystery_s.lua
-- Version: 1.0
----------------------------------------->>

bag = false


local bagLoc = {
-- Los Santos Locations --
{2731.160, -2420.737, 16.994},
{2778.869, -2500.980, 13.061},
{2776.182, -2385.363, 15.624},
{2531.445, -2336.503, 23.706},
{2395.573, -2288.180, 5.463},
{1863.005, -2182.502, 16,325},
{1937.887, -2143.239, 21.048},
{1983.820, -1974.436, 14.540},
{1874.544, -1955.760, 19.470},
{1911.157, -1775.985, 12.783},
{2102.868, -1641.823, 12.777},
{2285.335, -1677.219, 13.861},
{2450.311, -1715.212, 13.082},
{2730.385, -1828.890, 11.244},
{2744.396, -1944.254, 12.947},
{2527.507, -1524.242, 23.430},
{2537.521, -1439.868, 23.400},
{2698.733, -1425.241, 15.650},
{2804.240, -1183.873, 24.868},
{2599.620, -1085.168, 68.985},
{2249.730, -1059.714, 55.369},
{2235.295, -1194.331, 32.925},
{1976.134, -1234.509, 19.447},
{1969.144, -1157.326, 20.364},
{1641.636, -1092.273, 23.306},
{1523.775, -1110.339, 20.254},
{1458.991, -1143.516, 23.791},
{1294.645, -985.983, 32.095},
{1254.701, -1162.776, 23.228},
{919.988, -1311.397, 12.947},
{740.113, -1358.070, 21.033},
{723.329, -1494.752, 1.334},
{372.469, -1794.981, 4.695},
{154.960, -1938.203, 3.173},
{163.554, -1759.408, 6.304},
{64.052, -1533.095, 8.056},
-- San Fierro Locations --
{-2015.901, -969.471, 31.564},
{-2065.625, -785.436, 31.572},
{-2109.710, -395.663, 34.931},
{-2091.466, -99.386, 34.564},
{-2127.701, 10.092, 34.720},
{-2052.515, 72.745, 27.791},
{-1982.278, 137.484, 29.808},
{-2057.884, 250.197, 34.548},
{-2061.543, 306.104, 41.392},
{-2129.993, 226.819, 35.166},
{-2160.450, 305.249, 34.517},
{-2446.003, 522.513, 29.553},
{-2561.533, 636.724, 27.206},
{-2666.129, 580.215, 13.861},
{-2795.521, 524.265, 5.851},
{-2947.102, 498.185, 1.830},
{-2881.824, 680.852, 22.727},
{-2779.071, 897.733, 55.001},
{-2720.283, 988.104, 53.861},
{-2623.235, 1145.434, 55.052},
{-2527.611, 1165.502, 54.838},
{-2314.953, 1541.954, 18.173},
{-2079.709, 1395.096, 6.501},
{-1670.161, 1218.070, 6.650},
{-1674.499, 1204.958, 32.246},
{-1789.488, 1213.842, 32.056},
{-1777.103, 986.942, 23.018},
{-1774.711, 893.677, 24.486},
{-1705.739, 786.144, 24.291},
{-1681.392, 706.166, 30.002},
{-1712.165, 400.552, 6.819},
{-1730.388, 6.636, 2.955},
{-1811.805, -150.112, 8.798},
-- Las Venturas Locations --
{1156.863, 2790.850, 10.220},
{1486.807, 2775.007, 10.220},
{1646.695, 2575.775, 10.220},
{1817.097, 2596.462, 13.272},
{1994.942, 2620.739, 10.220},
{2259.881, 2771.149, 10.220},
{2493.240, 2766.337, 10.220},
{2371.212, 2530.480, 10.220},
{2339.344, 2440.841, 6.195},
{2316.862, 2304.119, 10.220},
{2333.778, 2164.075, 10.235},
{2580.005, 2120.871, 10.220},
{2606.781, 2068.834, 13.272},
{2590.885, 1826.421, 10.220},
{2445.200, 1342.419, 10.220},
{2323.694, 1283.203, 97.036},
{2387.088, 1021.368, 10.220},
{2181.677, 843.059, 6.103},
{1798.113, 843.766, 10.033},
}

function spawnBag ( )
    if ( bag == true ) then return end
    loc = math.random ( #bagLoc )
	mysteryBag = createObject ( 1550, bagLoc[loc][1], bagLoc[loc][2], bagLoc[loc][3], 0, 0, 0, true )
	marker = createMarker ( bagLoc[loc][1], bagLoc[loc][2], bagLoc[loc][3], "cylinder", 2, 0, 0, 0, 0 )
	setElementDoubleSided ( mysteryBag, true )
	timer = setTimer ( tip, 400000, 1 ) --  1350000
	timer1 = setTimer ( second_tip, 800000, 1 ) -- 2000000
	bag = true
	addEventHandler ("onMarkerHit", marker, payOut )
	sendmsg("Mystery Bag: A bag with loot has been spawned on the map, find it!")
end
setTimer ( spawnBag, 90000, 0 )
function tip ( )
    x,y,z = getElementPosition ( mysteryBag )
    zone = getZoneName ( x, y, z, true )
	sendmsg("Mystery Bag Tip: The bag is somewhere in "..zone)
end

function second_tip ( ) -- if they still can't find it, give them a second tip.
	if not isElement ( mysteryBag ) then return end
    x,y,z = getElementPosition ( mysteryBag )
	blip = createBlip ( x, y, z, 37, 2, 255, 0, 0, 255, 0, 9999 )
    zone = getZoneName ( x, y, z, false )
	sendmsg("Mystery Bag Tip: The bag is somewhere in "..zone)
	--deTimer = setTimer ( despawn_Bag, 900000, 1 ) -- 900000
end

function payOut ( player )
	if getElementType(player) ~= "player" then return end
    if ( isPedInVehicle ( player ) ) then return end
	destroyElement ( mysteryBag )
	destroyElement ( marker )
	if isElement ( blip ) then destroyElement ( blip ) end
	if isTimer ( timer ) then killTimer ( timer ) end
    if isTimer ( timer1 ) then killTimer ( timer1 ) end
    if isTimer ( deTimer ) then killTimer ( deTimer ) end
	triggerEvent ("GTImysteryBag_msg", player, player )
end

--[[function despawn_Bag ( )
    bag = false
	sendmsg("Mystery Bag: Nobody has found the bag in time, a new bag will re-spawn shortly!")
	if isElement ( mysteryBag ) then
	    destroyElement ( mysteryBag )
	end
	if isElement ( marker ) then
	    destroyElement ( marker )
	if isElement ( blip ) then destroyElement ( blip ) end
		if isTimer ( timer ) then killTimer ( timer )
		if isTimer ( timer1 ) then killTimer ( timer1 )
		end
	end
end
end--]]

addEvent ("GTImysteryBag_msg", true )
addEventHandler ("GTImysteryBag_msg", root,
   function ( player )
        local name = getPlayerName ( player )
		triggerEvent ("GTImysteryBag_spawnNewBag", player, player )
        sendmsg("Mystery Bag: "..name.." has found the Mystery Bag. Reward: $"..money)
		if isTimer ( timer ) then killTimer ( timer )
		    if isTimer ( timer1 ) then killTimer ( timer1 )
			    if isTimer ( deTimer ) then killTimer ( deTimer )
				if isElement ( blip ) then destroyElement ( blip ) end
				end
			end
		end
    end
)

addEvent ("GTImysteryBag_spawnNewBag", true )
addEventHandler ("GTImysteryBag_spawnNewBag", root,
    function ( player )
	    bag = false
       -- setTimer ( spawnBag, 900000, 1 ) -- 600000
		if ( player ) then
	                money = math.random ( 7500, 12000 )
			--		local groupID = exports.GTIgroups:getPlayerGroup(player)
		            exports.GTIbank:GPM(player, money, "Mystery Bag: Payment")
		            exports.GTIhud:drawNote("GTImysteryBag_payOutNotee", "+ $ "..money, player, 0, 255, 0, 7500)
			--		if not groupID then return end
			--		exports.GTIhud:drawNote("GTImysteryBag_payOutNote", "+ XPG 2500", player, 0, 255, 0, 7500)
			--		exports.GTIgroups:modifyGroupExperience(groupID, 2500)
		end
    end
)

function sendmsg(msg)
	for i,player in pairs(getElementsByType("player")) do
		if exports.GTIutil:isPlayerLoggedIn(player) then --and exports.GTIutil:isPlayerInTeam(player, "Criminals")
		    local r, g, b = getPlayerNametagColor ( player )
			exports.GTIhud:dm(msg, player, r, g, b)
		end
	end
end
