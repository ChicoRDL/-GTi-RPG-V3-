----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 01 Jan 2014
-- Resource: GTIinteriors/interiorWarps.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local colAssociates = {}	-- Table that links Interiors together
local colRestrictions = {}	-- Table of interior restrictions

local intEntry = {}		-- Interior Entry Markers

INT_MARKER_DEFAULT_ALPHA = 175	-- Default Marker Alpha
INT_MARKER_DEFAULT_SIZE = 2.0	-- Default Marker Size
Z_OFFSET_MARKER = 2				-- Z-Offset (Marker, not Warp)
Z_OFFSET_WARP = 1				-- Z-Offset (Warp)
COL_RADIUS = 1.5				-- Radius of Warp Col

addEvent("onInteriorEnter", true)
addEvent("onInteriorExit", true)

local validResource = {["GTIinteriors"] = true, ["GTIintTable"] = true}
function createInteriorMarkers(resource)
	if (not validResource[getResourceName(resource)]) then return end
	for m1,m2 in pairs(colAssociates) do
		destroyElement(m2)
	end
	colAssociates = {}
	colRestrictions = {}

	local interiors = exports.GTIintTable:getInteriorsTable()
	for i,v in ipairs(interiors) do
		if (v[1] and v[2]) then
			-- Entry Marker
			local intTbl = v[1]
			-- Dev Server Color Change
			if (getServerPort() ~= 22003 and intTbl.color[1] == 200 and intTbl.color[2] == 0 and intTbl.color[3] == 255) then
				intTbl.color[1], intTbl.color[2], intTbl.color[3] = 255, 255, 0
			end
			
				-- Create Marker
			local entryMarker = createMarker(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3]+Z_OFFSET_MARKER, "arrow", intTbl.size,
				intTbl.color[1], intTbl.color[2], intTbl.color[3], INT_MARKER_DEFAULT_ALPHA)
				-- Create Col
			local entryCol = createColSphere(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3]+Z_OFFSET_WARP, COL_RADIUS)
				-- Set Interior
			if (intTbl.int and intTbl.int ~= 0) then
				setElementInterior(entryMarker, intTbl.int)
				setElementInterior(entryCol, intTbl.int)
			end
				-- Set Dimension
			if (intTbl.dim and intTbl.dim ~= 0) then
				setElementDimension(entryMarker, intTbl.dim)
				setElementDimension(entryCol, intTbl.dim)
			end
				-- Store Rotation Data (Col)
			setElementData(entryCol, "rot", intTbl.rot or 0, false)
				-- Store Z Data (Marker)
			setElementData(entryMarker, "originalZ", intTbl.pos[3]+Z_OFFSET_MARKER)
				-- Store Restrictions
			if (intTbl.res) then
				colRestrictions[entryCol] = intTbl.res
			end
			-- Return Marker
			local intTbl = v[2]
				-- Create Marker
			local returnMarker = createMarker(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3]+Z_OFFSET_MARKER, "arrow", intTbl.size,
				intTbl.color[1], intTbl.color[2], intTbl.color[3], INT_MARKER_DEFAULT_ALPHA)
				-- Create Col
			local returnCol = createColSphere(intTbl.pos[1], intTbl.pos[2], intTbl.pos[3]+Z_OFFSET_WARP, COL_RADIUS)
				-- Set Interior
			if (intTbl.int and intTbl.int ~= 0) then
				setElementInterior(returnMarker, intTbl.int)
				setElementInterior(returnCol, intTbl.int)
			end
				-- Set Dimension
			if (intTbl.dim and intTbl.dim ~= 0) then
				setElementDimension(returnMarker, intTbl.dim)
				setElementDimension(returnCol, intTbl.dim)
			end
				-- Store Rotation Data (Col)
			setElementData(returnCol, "rot", intTbl.rot or 0, false)
				-- Store Z Data (Marker)
			setElementData(returnMarker, "originalZ", intTbl.pos[3]+Z_OFFSET_MARKER)
				-- Store Restrictions
			if (intTbl.res) then
				colRestrictions[returnCol] = intTbl.res
			end
			-- Events
			addEventHandler("onColShapeHit", entryCol, warpBetweenInteriors)
			addEventHandler("onColShapeHit", returnCol, warpBetweenInteriors)
			-- Associations
			colAssociates[entryCol] = returnCol
			colAssociates[returnCol] = entryCol
			-- Entry v. Return
			intEntry[entryCol] = true
		end
	end
end
addEventHandler("onResourceStart", root, createInteriorMarkers)

-- Interior Warps
------------------>>

local warpInProgress = {}
function warpBetweenInteriors(player, dim)
	if (not isElement(player) or getElementType(player) ~= "player" or
		isPedInVehicle(player) or not dim or doesPedHaveJetPack(player)) then return end
	if (warpInProgress[player]) then return end

	-- Check for Restrictions
	local mR = colRestrictions[source]
	if (mR) then
		local cleared
		-- Team Check
		if (mR.team and not cleared) then
			for i,v in ipairs(mR.team) do
				if (exports.GTIutil:isPlayerInTeam(player, v)) then
					cleared = true
					break
				end
			end
		end
		-- Job Check
		if (mR.job and not cleared) then
			for i,v in ipairs(mR.job) do
				if (exports.GTIemployment:getPlayerJob(player, true) == v) then
					cleared = true
					break
				end
			end
		end
		if (mR.wl and not cleared) then
			if (exports.GTIpoliceWanted:getPlayerWantedLevel(player) <= mR.wl ) then
				cleared = true
			end
		end
		if (not cleared) then
			exports.GTIhud:dm("You are not allowed to enter this interior", player, 255, 25, 25)
			return
		end
	end

	warpInProgress[player] = true
	local x,y,z = getElementPosition(colAssociates[source])
	local rot = getElementData(colAssociates[source], "rot")
	local int = getElementInterior(colAssociates[source])
	local dim = getElementDimension(colAssociates[source])

	--Set the player's "last known" data before warping | remove it if the int is 0 (Jack)
	if (int ~= 0) then
		local x,y,z = getElementPosition(player)
		setElementData(player, "lastPosition", table.concat({x,y,z}, ","), false)
	else
		removeElementData(player, "lastPosition")
	end

	setElementInterior(player, int)
	setElementDimension(player, dim)
	setElementRotation(player, 0, 0, rot, "default", true)
	setElementPosition(player, x, y, z)
	setTimer(function() warpInProgress[player] = nil end, 1000, 1)

	if (intEntry[source]) then
		triggerEvent("onInteriorEnter", source, player, colAssociates[source])
		triggerClientEvent(player, "onClientInteriorEnter", source, player, colAssociates[source])
	else
		triggerEvent("onInteriorExit", source, player, colAssociates[source])
		triggerClientEvent(player, "onClientInteriorExit", source, player, colAssociates[source])
	end
end

function getPlayerLastPosition(player)
	if not player or not isElement(player) then return false end

	local position = getElementData(player, "lastPosition")
	if position then
		local x,y,z = unpack( split(position, ",") )
		return tonumber(x), tonumber(y), tonumber(z)
	end

	return false
end

addEventHandler("onHouseEnter", root, 
	function (player)
		x, y, z = getElementPosition(source)
		setElementData(player, "lastPosition", table.concat({x,y,z}, ","), false)
	end
)

addEventHandler("onPlayerSpawn", root, function()
	removeElementData(source, "lastPosition")
end)
