addEvent ("GTIuserPanel_updates", true )
addEventHandler ("GTIuserPanel_updates", root,
function()
	triggerClientEvent(client,"GTIupdates:showUpdatesPanel",client)
end)

function onResourceStartBind ( )
    for i,v in ipairs ( getElementsByType ("player") ) do
        bindKey ( v, "F10", "down", showGui )
    end
end
addEventHandler ("onResourceStart", resourceRoot, onResourceStartBind )

function showGui ( player )
	if exports.GTIprison:isPlayerInJail ( player ) then return exports.GTIhud:dm("You can't open the user panel when jailed!", player, 255, 0, 0) end
	triggerClientEvent ( player, "GTIuserPanel_OpenGUI", player )
end

function saveColor1 ( r1, g1, b1 )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor1R", tonumber ( r1 ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor1G", tonumber ( g1 ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor1B", tonumber ( b1 ) )
end
addEvent ("GTIuserpanel_saveColor1", true )
addEventHandler ("GTIuserpanel_saveColor1", root, saveColor1 )

function saveColor2 ( r2, g2, b2 )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor2R", tonumber ( r2 ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor2G", tonumber ( g2 ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor2B", tonumber ( b2 ) )
end
addEvent ("GTIuserpanel_saveColor2", true )
addEventHandler ("GTIuserpanel_saveColor2", root, saveColor2 )

function saveColor3 ( r3, g3, b3 )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor3R", tonumber ( r3 ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor3G", tonumber ( g3 ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "UserPanelColor3B", tonumber ( b3 ) )
end
addEvent ("GTIuserpanel_saveColor3", true )
addEventHandler ("GTIuserpanel_saveColor3", root, saveColor3 )

function saveWeaponMods ( value )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "WeaponMods", tonumber ( value ) )
end
addEvent ("GTIuserpanel_saveWeaponMods", true )
addEventHandler ("GTIuserpanel_saveWeaponMods", root, saveWeaponMods )

function saveLaser ( laser )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "Laser", tonumber ( laser ) )
end
addEvent ("GTIuserpanel_saveLaser", true )
addEventHandler ("GTIuserpanel_saveLaser", root, saveLaser )

function saveLaserColor ( r, g, b )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "LaserColorR", tonumber ( r ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "LaserColorG", tonumber ( g ) )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "LaserColorB", tonumber ( b ) )
end
addEvent ("GTIuserPanel_saveLaserColor", true )
addEventHandler ("GTIuserPanel_saveLaserColor", root, saveLaserColor )

function saveWheelsMods ( wvalue )
	exports.GTIaccounts:SAD ( getPlayerAccount ( client ), "WheelsMods", tonumber ( wvalue ) )
end
addEvent ("GTIuserpanel_saveWheelsMods", true )
addEventHandler ("GTIuserpanel_saveWheelsMods", root, saveWheelsMods )

function getColor1 ( )
	local color1R = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor1R")
	local color1G = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor1G")
	local color1B = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor1B")
	local color2R = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor2R")
	local color2G = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor2G")
	local color2B = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor2B")
	local color3R = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor3R")
	local color3G = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor3G")
	local color3B = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "UserPanelColor3B")
	local wepMods = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "WeaponMods" )
	local getLaser = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "Laser" )
	local lr = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "LaserColorR" )
	local lg = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "LaserColorG" )
	local lb = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "LaserColorB" )
	local wMods = exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "WheelsMods" )
	bindKey(source, "F10", "down", showGui)
	triggerClientEvent ( source, "GTIuserpanel_setColor1", source, color1R, color1G, color1B, color2R, color2G, color2B, color3R, color3G, color3B )
	triggerClientEvent ( source, "GTIuserpanel_setWeaponMods", source, wepMods )
	triggerClientEvent ( source, "GTIuserPanel_laserED", source, getLaser )
	triggerClientEvent ( source, "GTIuserpanel_setLaserBtnColor", source, getLaser )
	triggerClientEvent ( source, "GTIuserpanel_setLaserColorOnLogin", source, lr, lg, lb )
	triggerClientEvent ( source, "GTIuserpanel_setWheelsMods", source, wMods )
end
addEventHandler ("onPlayerLogin", root, getColor1 )