local messages = {
	["kill"] = {
		{ "Killed you with a"},
		{ "Slaughtered you with a"},
		{ "Annihilated you with a"},
		{ "Wiped you away with a"},
		{ "Buried you using a"},
	},
	["suicide"] = {
		{ "Ended yourself"},
		{ "Committed suicide"},
		{ "Eased out the burden"},
		{ "Cut your life short"},
	}
}

--Weapons with no images
local noimg = {
	[0] = true,
	[1] = true,
	[13] = true,
	[19] = true,
	[20] = true,
	[21] = true,
	[51] = true,
}

local gnames = {
	["combat shotgun"] = "SPAS-12",
	["freefall bomb"] = "Bomb",
}

--

local dstring = ""
local perp = false
local name = ""
local killType = "suicide"
local gun = 0
local hp = 0
local ap = 0
local resTimer = false

local healthTimer = setTimer(function() end, 1000, 0)

local spawnTime = 5000

function setKillDetails( killer, weapon)
	gun = weapon
	hp = getElementHealth( killer)
	ap = getPedArmor( killer)
	perp = killer
	name = getPlayerName( killer)
end

function getKillerDetails()
end

addEventHandler( "onClientPlayerSpawn", localPlayer,
	function()
		removeEventHandler( "onClientPreRender", root, renderBox, false)
		resTimer = false
		perp = false
	end
)

addEventHandler( "onClientPlayerWasted", localPlayer,
	function( killer, weapon, bodypart)
		if killer and killer ~= localPlayer then
			--outputDebugString( getPlayerName( source).." was killed by a player.")
			killType = "kill"
			setKillDetails( killer, weapon)
			perp = killer
			spawnTime = 15000
		else
			--outputDebugString( getPlayerName( source).." commited suicide.")
			killType = "suicide"
			perp = localPlayer
			spawnTime = 5000
		end
		local num = math.random( #messages[killType])
		dstring = tostring( messages[killType][num][1])
		addEventHandler( "onClientPreRender", root, renderBox, false)
		resTimer = setTimer(function() end, spawnTime, 0)
	end
)

function renderBox()

	dxDrawRectangle(1225, 413, 295, 73, tocolor(0, 0, 0, 200), false) -- Background

	local nlength = string.len( name)
	if killType ~= "suicide" then
		if nlength > 9 then
			dxDrawText( name, 1229, 416, 1382, 456, tocolor(255, 255, 255, 255), 1.35, "arial", "left", "top", true, false, false, false, false) -- Name
		else
			dxDrawText( name, 1229, 416, 1382, 456, tocolor(255, 255, 255, 255), 1.75, "arial", "left", "top", true, false, false, false, false) -- Name
		end
	else
		dxDrawText( "You", 1229, 416, 1382, 456, tocolor(255, 255, 255, 255), 1.75, "arial", "left", "top", true, false, false, false, false) -- Name
	end

	if killType ~= "suicide" then
		if not noimg[gun] then
			dxDrawImage(1388, 416, 128, 40, "weaps/"..gun..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- Weapon Image
		end
	else
		dxDrawImage(1388, 416, 128, 40, "weaps/noose.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- Weapon Image
	end

	local health = hp
	local maxHealth = getPedStat( perp, 24)
	local maxHealth = (((maxHealth-569)/(1000-569))*100)+100
	local health = health/maxHealth
	local r1, g1, b1, r2, g2, b2, a
	if (health > 0.25) then
		r1,g1,b1 = 85,125,85
		r2,g2,b2 = 25,60,37
		a = 200
	else
		r1,g1,b1 = 200,100,105
		r2,g2,b2 = 80,40,40
		local aT = getTimerDetails(healthTimer)
		if (aT > 500) then
			a = (aT-500)/500*200
		else
			a = (500-aT)/500*200
		end
	end

	dxDrawRectangle(1294, 411, 226, 5, tocolor(r2, g2, b2, 255), false) -- Health Bar Shadow
	dxDrawRectangle(1520, 411, -health*226, 5, tocolor(r1, g1, b1, a), false) -- Health Bar

	local armor = ap
	local armor = ap/100

	dxDrawRectangle(1225, 411, 70, 5, tocolor(20, 60, 80, 255), false) -- Armor Bar Shadow
	dxDrawRectangle(1295, 411, -armor*70, 5, tocolor(90, 165, 200, 255), false) -- Armor Bar

	if resTimer then
		local rT = getTimerDetails( resTimer)
		local rT = rT/spawnTime

		dxDrawRectangle(1517, 477, -289, 6, tocolor(107, 38, 41, 255), false) -- Respawn Timer Shadow
		dxDrawRectangle(1517, 477, -rT*289, 6, tocolor(200, 100, 105, 255), false) -- Respawn Timer
	end

	if killType ~= "suicide" then
		local gname = gnames[string.lower(getWeaponNameFromID( gun))]
		if gname then
			dxDrawText( gname, 1461, 456, 1516, 472, tocolor(255, 255, 255, 200), 1.15, "arial", "right", "center", false, false, false, false, false) -- Gun Name
		else
			dxDrawText( getWeaponNameFromID( gun), 1461, 456, 1516, 472, tocolor(255, 255, 255, 200), 1.15, "arial", "right", "center", false, false, false, false, false) -- Gun Name
		end
	else
		dxDrawText( "Noose", 1461, 456, 1516, 472, tocolor(255, 255, 255, 200), 1.15, "arial", "right", "center", false, false, false, false, false) -- Gun Name
	end

	dxDrawText( dstring, 1229, 441, 1382, 457, tocolor(255, 255, 255, 200), 1.15, "arial", "left", "center", true, false, false, false, false) -- Message
	
	-- Interior Fix
	if (perp ~= localPlayer) then
		setElementInterior(localPlayer, getElementInterior(perp))
		setElementDimension(localPlayer, getElementDimension(perp))
	end
end
