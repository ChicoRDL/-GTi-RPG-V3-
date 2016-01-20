--[[topKills = {}
topHeadshots = {}
topDamage = {}


addEventHandler( "onResourceStart", resourceRoot,
    function()
		col = createColCuboid( 865.371, 499.701, -100, 2200, 2600, 300)
		addEventHandler( "onColShapeHit", col, dmEnter)
		addEventHandler( "onColShapeLeave", col, dmLeave)
    end
)

function dmEnter( hitElement, dim)
    if isElement( hitElement) and dim then
        if getElementType ( hitElement ) == "player" then
			if not exports.GTIgangTerritories:isGangster ( hitElement ) and not exports.GTIgangTerritories:isSWAT( hitElement ) then return end
            if not topKills [ getAccountName ( getPlayerAccount ( hitElement ) ) ] then
                topKills[ getAccountName( getPlayerAccount ( hitElement ) ) ] = 0
                topHeadshots[ getAccountName( getPlayerAccount ( hitElement ) ) ] = 0
                topDamage[ getAccountName( getPlayerAccount ( hitElement ) ) ] = 0
            end
            addTops ( hitElement )
        end
    end
end

function dmLeave ( hitElement, dim)
    if isElement ( hitElement ) and dim then
        if getElementType ( hitElement ) == "player" then
            exports.GTIhud:drawNote("GTIdeathmatchingDamage", "", hitElement)
            exports.GTIhud:drawNote("GTIdeathmatchingKill", "", hitElement)
            exports.GTIhud:drawNote("GTIdeathmatchingHeadshot", "", hitElement)
        end
    end
end


function addTops ( player )
    local max_kills, key_kills = -math.huge
    for k, v in pairs(topKills) do
        if v > max_kills then
        max_kills, key_kills = v, k
        end
    end
    local max_headshots, key_headshots = -math.huge
    for k, v in pairs(topHeadshots) do
        if v > max_headshots then
        max_headshots, key_headshots = v, k
        end
    end
    local max_damage, key_damage = -math.huge
    for k, v in pairs(topDamage) do
        if v > max_damage then
        max_damage, key_damage = v, k
        end
    end
    r, g, b = getPlayerNametagColor(player)
        if not key_damage then
            key_damage = "Unknown"
        else
            key_damage = getPlayerName ( getAccountPlayer ( getAccount ( key_damage ) ) ) or exports.GTIaccounts:GAD( getAccount(key_damage), "lastname") or "Unknown"
        end
        if not max_damage then
            max_damage = 0
        end
        if not key_headshots then
            key_headshots = "Unknown"
        else
            key_headshots = getPlayerName ( getAccountPlayer ( getAccount ( key_headshots ) ) ) or exports.GTIaccounts:GAD( getAccount(key_headshots), "lastname") or "Unknown"
        end
        if not max_headshots then
            max_headshots = 0
        end
        if not key_kills then
            key_kills = "Unknown"
        else
            key_kills = getPlayerName ( getAccountPlayer ( getAccount ( key_kills ) ) ) or exports.GTIaccounts:GAD( getAccount(key_kills), "lastname") or "Unknown"
        end
        if not max_kills then
            max_kills = 0
        end
		if not exports.GTIgangTerritories:isGangster ( player ) and not exports.GTIgangTerritories:isSWAT( player ) then return end
       -- exports.GTIhud:drawNote("GTIdeathmatchingDamage", "Top Damage: " .. key_damage.. " (" .. max_damage .. " HP )", player, r, g, b, math.huge)
        exports.GTIhud:drawNote("GTIdeathmatchingHeadshot", "Top HS: " .. key_headshots .. " ( " .. max_headshots .. " headshots )", player, 0, 255, 0, math.huge)
        exports.GTIhud:drawNote("GTIdeathmatchingKill", "Top Kills: " .. key_kills .. " ( " .. max_kills .. " kills )", player, 0, 255, 0, math.huge)
end

function updateTops ( )
    for index, value in ipairs ( getElementsByType ( "player" ) ) do
        if isPlayerInDMArea ( value ) then
            addTops ( value )
        end
    end
end


addEventHandler( "onPlayerWasted", root, 
    function ( _, attacker, _, bodypart )
        if isPlayerInDMArea ( source ) and isPlayerInDMArea ( attacker ) then
            topKills[ getAccountName( getPlayerAccount ( attacker ) ) ]  = topKills[ getAccountName( getPlayerAccount ( attacker ) ) ] + 1
            updateTops ( )
            if ( bodypart == 9 ) then
                topHeadshots[ getAccountName( getPlayerAccount ( attacker ) ) ]  = topHeadshots[ getAccountName( getPlayerAccount ( attacker ) ) ] + 1
            end
        end
    end
)

function isPlayerInDMArea( element)
    if not isElement ( element ) then return false end
        return isElementWithinColShape ( element, col )
end


addEventHandler("onResourceStart", resourceRoot, function ( )
    for i,v in ipairs ( getElementsByType ("player") ) do
        if isPlayerInDMArea ( v ) then
            topKills[ getAccountName( getPlayerAccount ( v ) ) ] = 0
            topHeadshots[ getAccountName( getPlayerAccount ( v ) ) ] = 0
            topDamage[ getAccountName( getPlayerAccount ( v ) ) ] = 0
            updateTops ()
        end
    end
            updateTops ()
end
)

function onResign ( )
	exports.GTIhud:drawNote("GTIdeathmatchingDamage", "", source)
    exports.GTIhud:drawNote("GTIdeathmatchingKill", "", source)
	exports.GTIhud:drawNote("GTIdeathmatchingHeadshot", "", source)
end
addEvent ("onPlayerQuitJob", true )
addEventHandler ("onPlayerQuitJob", root, onResign )

function resetStats ( )
	local time = getRealTime ( )
    local hours = time.hour
    local minutes = time.minute
	if hours == 23 and minutes == 59 then
	topKills[ getAccountName( getPlayerAccount ( hitElement ) ) ] = 0
    topHeadshots[ getAccountName( getPlayerAccount ( hitElement ) ) ] = 0
    topDamage[ getAccountName( getPlayerAccount ( hitElement ) ) ] = 0 --]]