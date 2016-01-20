----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 9 Sep 2015
-- Resource: briefCase_s.lua
-- Version: 1.0
----------------------------------------->>

local caseLoc = {
{2136.123, 1421.594, 10.820}, -- Mechanic LV
{2029.359, 1162.401, 10.820}, -- Token Shop LV
{2112.359, 943.327, 10.820}, -- LV Ammunation South
{2508.333, 1150.072, 22.023}, -- Come-A-Lot
{2434.565, 1689.734, 10.828}, -- Caligula Palace
{2350.690, 2142.755, 10.681}, -- Old Venturas Strip
{1899.357, 2090.251, 9.820}, -- Redainst East
{1499.614, 2030.368, 14.740}, -- Above LV Hospital
{1128.202, 2074.163, 10.820}, -- North LV Burger
}

local caseDropPoint = {
{1747.122, 1978.814, 9.820}, -- LV Rental place
{1569.303, 1564.047, 9.820}, -- LV Airport
{1098.539, 1449.345, 11.547}, -- LV Stadium
{1688.624, 722.490, 9.820}, -- LV South warehouse
{2628.943, 1824.308, 10.023}, -- LV Chinese building
{2306.436, 2442.042, 9.820}, -- LVPD
}

local case = false

addEvent ("onInteriorEnter", true )
addEvent ("onHouseEnter", true )
addEvent ("onPlayerQuitJob", true )
addEvent ("onPlayerGetJob", true )

function spawnTheCase ( )
    if case == true then return end
	random = math.random ( #caseLoc )
	x, y, z = caseLoc[random][1], caseLoc[random][2], caseLoc[random][3]
	briefCase = createPickup ( x, y, z, 3, 1210, 50, 1 )
	briefBlip = createBlipAttachedTo ( briefCase, 23 )

	case = true

	sendmsg("BriefCase Run: Get the briefcase and deliver it for a reward!")

	addEventHandler ("onPickupHit", briefCase, attachCase )

	setElementVisibleTo ( briefBlip, root, false )
	
	for i,player in ipairs ( getPlayersInTeam ( getTeamFromName ( "Criminals" ) ) ) do
		if ( exports.GTIgangTerritories:isGangster ( player ) ) then
			setElementVisibleTo ( briefBlip, player, true )
		end
	end
end

setTimer ( spawnTheCase, 300000, 0 )

local moneyCase = {}

function attachCase ( player )
        if isPedInVehicle ( player ) then return end
	if ( isElement ( getElementType(getPedContactElement(player)) == "vehicle" )) then return end
		local job = exports.GTIemployment:getPlayerJob ( player )
		if job == "Gangster" then

		if isElement ( briefCase ) then destroyElement ( briefCase ) end
		if isElement ( briefCase1 ) then destroyElement ( briefCase1 ) end
		if isElement ( briefBlip ) then destroyElement ( briefBlip ) end
		if isElement ( blip ) then destroyElement ( blip ) end

		bfc = player
		--triggerClientEvent ("GTIbriefCase_ghostModeOn", player )

		moneyCase[player] = createObject ( 1210, 2168.279, 1099.348, 0, -90, 0, 0, true )
		exports.bone_attach:attachElementToBone( moneyCase[player], player, 12, 0, -0.03, 0.3, 180, 0, 0 )
		briefBlipq = createBlipAttachedTo ( moneyCase[player], 23 )

		loc = math.random ( #caseDropPoint )
		dmarker = createMarker ( caseDropPoint[loc][1], caseDropPoint[loc][2], caseDropPoint[loc][3], "cylinder", 2, 0, 200, 0, 175 )
		dblip = createBlipAttachedTo ( dmarker, 41 )

		sendmsg("BriefCase Run: Someone got the briefcase! get him before he deliveres it!")

		toggleControl ( player, "enter_exit", false )
		toggleControl ( player, "enter_passenger", false )
		toggleControl ( player, "accelerate", false )
		toggleControl ( player, "brake_reverse", false )

		addEventHandler ("onMarkerHit", dmarker, payOut )

		setElementVisibleTo ( dblip, root, false )
		setElementVisibleTo ( dmarker, root, false )
		setElementVisibleTo ( briefBlipq, root, false )
	
		for i,player in ipairs ( getPlayersInTeam ( getTeamFromName ( "Criminals" ) ) ) do
			if ( exports.GTIgangTerritories:isGangster ( player ) ) then
				setElementVisibleTo ( dblip, bfc, true )
				setElementVisibleTo ( dmarker, bfc, true )
				setElementVisibleTo ( briefBlipq, player, true )
			end
		end
	end
end

function payOut ( player )
	if ( player ) and ( exports.bone_attach:isElementAttachedToBone ( moneyCase[player] ) == true ) and not isPedInVehicle ( player ) then
	    if isElement ( dmarker ) then destroyElement ( dmarker ) end
	    if isElement ( dblip ) then destroyElement ( dblip ) end
		if isElement ( briefBlipq ) then destroyElement ( briefBlipq ) end
		if isElement ( moneyCase[player] ) then destroyElement ( moneyCase[player] ) end
		if isElement ( blip ) then destroyElement ( blip ) end

		local groupID = exports.GTIgroups:getPlayerGroup(player)

		exports.GTIgroups:modifyGroupExperience(groupID, 2500)
		exports.GTIbank:GPM(player, 7500, "Brief Case Run: Payment")
		exports.GTIstats:modifyStatData( getPlayerAccount(player), "briefcase_progress", 1)

		exports.GTIhud:drawNote("GTIBriefCase_payOutNotee", "+ $ 7,500", player, 0, 255, 0, 7500)
		exports.GTIhud:drawNote("GTIBriefCase_payXPNotee", "+ XPG 2500", player, 0, 255, 0, 7500)

		toggleControl ( player, "enter_exit", true )
		toggleControl ( player, "enter_passenger", true )
		toggleControl ( player, "accelerate", true )
		toggleControl ( player, "brake_reverse", true )

		case = false

		local name = getPlayerName ( player )
		sendmsg("BriefCase Run: "..name.." has delivered the briefcase. Reward: $ 7,500" )
	end
end

function playerWasted ( ammo, attacker, weapon, bodypart )
	if ( exports.bone_attach:isElementAttachedToBone ( moneyCase[source] ) == true ) then
		if source == bfc then
			if ( getElementType ( attacker ) == "player" ) then
				destroyElement ( moneyCase[source] )
				destroyElement ( dblip )
				destroyElement ( dmarker )
				destroyElement ( briefBlipq )

				if isElement ( blip ) then destroyElement ( blip ) end

				local dx, dy, dz = getElementPosition ( source )
				briefCase1 = createPickup ( dx, dy, dz, 3, 1210, 50, 1 )
				blip = createBlipAttachedTo ( briefCase1, 23 )

				toggleControl ( source, "enter_exit", true )
				toggleControl ( source, "enter_passenger", true )
				toggleControl ( source, "accelerate", true )
				toggleControl ( source, "brake_reverse", true )

				sendmsg("BriefCase Run: BriefCase holder got killed, pickup the briefcase!" )

				addEventHandler ("onPickupHit", briefCase1, attachCase )
				--triggerClientEvent ("GTIbriefCase_ghostModeOff", source )
				setElementVisibleTo ( blip, root, false )
	
				for i,player in ipairs ( getPlayersInTeam ( getTeamFromName ( "Criminals" ) ) ) do
					if ( exports.GTIgangTerritories:isGangster ( player ) ) then
						setElementVisibleTo ( blip, player, true )
					end
				end
			end
		end
	end
end
addEventHandler ("onPlayerWasted",  getRootElement(), playerWasted )

function disconnect ( quitPlayer )
	if (exports.bone_attach:isElementAttachedToBone( moneyCase[source] ) == true ) then
		if source == bfc then
			local dx, dy, dz = getElementPosition ( source )
			destroyElement ( moneyCase[source] )
			destroyElement ( dblip )
			destroyElement ( dmarker )

			if isElement ( briefBlipq ) then destroyElement ( briefBlipq ) end
			if isElement ( blip ) then destroyElement ( blip ) end

			briefCase1 = createPickup ( dx, dy, dz, 3, 1210, 50, 1 )
			blip = createBlipAttachedTo ( briefCase1, 23 )

			toggleControl ( source, "enter_exit", true )
			toggleControl ( source, "enter_passenger", true )
			toggleControl ( source, "accelerate", true )
			toggleControl ( source, "brake_reverse", true )

			sendmsg("BriefCase Run: BriefCase holder quit the game, pickup the briefcase" )

			addEventHandler ("onPickupHit", briefCase1, attachCase )
			setElementVisibleTo ( blip, root, false )

			for i,player in ipairs ( getPlayersInTeam ( getTeamFromName ( "Criminals" ) ) ) do
			        if ( exports.GTIgangTerritories:isGangster ( player ) ) then
					setElementVisibleTo ( blip, player, true )
				end
			end
		end
	end
end
addEventHandler ("onPlayerQuit", root, disconnect )


function interiorEnter ( player )
    if ( exports.bone_attach:isElementAttachedToBone ( moneyCase[player] ) == true ) then
		if player == bfc then
			destroyElement ( moneyCase[player] )
			destroyElement ( dblip )
			destroyElement ( dmarker )
			if isElement ( briefBlipq ) then destroyElement ( briefBlipq ) end
			if isElement ( blip ) then destroyElement ( blip ) end
			
			toggleControl ( player, "enter_exit", true )
			toggleControl ( player, "enter_passenger", true )
			toggleControl ( player, "accelerate", true )
			toggleControl ( player, "brake_reverse", true )

			sendmsg("BriefCase Run: BriefCase holder tried to enter an interior, object failed!" )
			case = false
		end
	end
end
addEventHandler ("onInteriorEnter", root, interiorEnter )
addEventHandler ("onHouseEnter", root, interiorEnter )

function quitGetJob ( )
    if source then
		if isElement ( dblip ) then setElementVisibleTo ( dblip, source, false ) end
		if isElement ( dmarker ) then setElementVisibleTo ( dmarker, source, false ) end
		if isElement ( briefBlipq ) then setElementVisibleTo ( briefBlipq, source, false ) end
		if isElement ( blip ) then setElementVisibleTo ( blip, source, false ) end
		if isElement ( briefBlip ) then setElementVisibleTo ( briefBlip, source, false ) end

		if ( exports.bone_attach:isElementAttachedToBone ( moneyCase[source] ) == true ) then
			destroyElement ( moneyCase[source] )
			destroyElement ( dblip )
			destroyElement ( dmarker )

			if isElement ( briefBlipq ) then destroyElement ( briefBlipq ) end
			if isElement ( blip ) then destroyElement ( blip ) end

			toggleControl ( source, "enter_exit", true )
			toggleControl ( source, "enter_passenger", true )
			toggleControl ( source, "accelerate", true )
			toggleControl ( source, "brake_reverse", true )

			sendmsg("BriefCase Run: BriefCase holder quit his job!" )
			--triggerClientEvent ("GTIbriefCase_ghostModeOff", source )
			case = false
		end
	end
end
addEventHandler ("onPlayerQuitJob", root, quitGetJob )

function showBlips (player)
	if ( exports.GTIgangTerritories:isGangster ( source ) ) then
		if isElement ( briefBlipq ) then setElementVisibleTo ( briefBlipq, source, true ) end
		if isElement ( blip ) then setElementVisibleTo ( blip, source, true ) end
		if isElement ( briefBlip ) then setElementVisibleTo ( briefBlip, source, true ) end
	end
end
addEventHandler ("onPlayerGetJob", root, showBlips )

addEventHandler ("onPlayerLogin", root, 
	function ()
		setTimer(
			function ()
				if ( exports.GTIgangTerritories:isGangster(source) ) then
					if isElement ( briefBlipq ) then setElementVisibleTo ( briefBlipq, source, true ) end
					if isElement ( blip ) then setElementVisibleTo ( blip, source, true ) end
					if isElement ( briefBlip ) then setElementVisibleTo ( briefBlip, source, true ) end
				end
			end, 3000, 1
		)
	end
)

addEventHandler("onPlayerContact", root, 
	function (_, current)
		if ( current ) then
			if ( exports.bone_attach:isElementAttachedToBone ( moneyCase[source] ) and getElementType(current) == "vehicle" ) then
				destroyElement ( moneyCase[source] )
				destroyElement ( dblip )
				destroyElement ( dmarker )
				destroyElement ( briefBlipq )
				if isElement ( blip ) then destroyElement ( blip ) end

				local dx, dy, dz = getElementPosition ( source )
				briefCase1 = createPickup ( dx, dy, dz, 3, 1210, 50, 1 )
				blip = createBlipAttachedTo ( briefCase1, 23 )

				toggleControl ( source, "enter_exit", true )
				toggleControl ( source, "enter_passenger", true )
				toggleControl ( source, "accelerate", true )
				toggleControl ( source, "brake_reverse", true )

				addEventHandler ("onPickupHit", briefCase1, attachCase )
				setElementVisibleTo ( blip, root, false )

				for i,player in ipairs ( getPlayersInTeam ( getTeamFromName ( "Criminals" ) ) ) do
					if ( exports.GTIgangTerritories:isGangster ( player ) ) then
						setElementVisibleTo ( blip, player, true )
					end
				end
			end
		end
	end
)


function sendmsg ( msg )
	for i,player in pairs ( getElementsByType ("player" ) ) do
		local job = exports.GTIemployment:getPlayerJob ( player )
		if exports.GTIutil:isPlayerLoggedIn ( player ) and job == "Gangster" then
			local r, g, b = getPlayerNametagColor ( player )
			exports.GTIhud:dm ( msg, player, r, g, b )
		end
	end
end

