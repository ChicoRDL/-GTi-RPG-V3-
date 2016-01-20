----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>
function onLogin ( )
	if exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "Tutorial" ) == 1 then return end
	exports.GTIaccounts:SAD( getPlayerAccount ( source ), "Tutorial", 1 )
	triggerClientEvent ( source, "GTIinfoPanel_showTutorial", source )
	outputChatBox ("Welcome to GTI, you can close the tutorial panel after 1 minute passed", source, 255, 0, 0 )
end
addEventHandler ("onPlayerSpawn", root, onLogin )