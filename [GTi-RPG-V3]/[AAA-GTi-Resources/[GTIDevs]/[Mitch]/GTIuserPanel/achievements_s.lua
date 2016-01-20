-- Achievement1 = Register an Account
-- Achievement2 = 100 Hours
-- Achievement3 = 1000 Kills
-- Achievement4 = 100 Medic kits used
local UPDATE_TIMER = 1800000 -- 30 Mins

function timer ( )
	triggerEvent ("GTIachievements_playtime", resourceRoot )
	triggerEvent ("GTIachievements_kills", resourceRoot )
	triggerEvent ("GTIachievements_medkits", resourceRoot )
end
setTimer ( timer, UPDATE_TIMER, 0 )

function FirstTimeLogin ( )
	if exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "Achievement1" ) == 1 then return end
	local name = getPlayerName ( source )
	outputChatBox ("Achievements: "..name..", Unlocked achievement 'Register an account on GTI'", root, 0, 255, 0, false )
	exports.GTIaccounts:SAD( getPlayerAccount ( source ), "Achievement1", 1 )
end
addEventHandler ("onPlayerLogin", root, FirstTimeLogin )

function playTime ( )
	if exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "Achievement2" ) == 1 then return end
	local time = tonumber ( exports.GTIstats:getPlayerPlaytime ( source ) ) or 0
	if time >= 6000 then
		local name = getPlayerName ( source )
		outputChatBox ("Achievements: "..name..", Unlocked achievement '100 hours of Playtime'", root, 0, 255, 0, false )
		exports.GTIaccounts:SAD( getPlayerAccount ( source ), "Achievement2", 1 )
	end
end
addEvent ("GTIachievements_playtime", true )
addEventHandler ("GTIachievements_playtime", root, playTime )

function kills ( )
	if exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "Achievement3" ) == 1 then return end
	local killsa =  tonumber ( exports.GTIstats:getStatData ( getPlayerAccount ( source ), "kills" ) ) or 0
	if killsa >= 1000 then
		local name = getPlayerName ( source )
		outputChatBox ("Achievements: "..name..", Unlocked achievement 'Get 1000 kills'", root, 0, 255, 0, false )
		exports.GTIaccounts:SAD( getPlayerAccount ( source ), "Achievement3", 1 )
	end
end
addEvent ("GTIachievements_kills", true )
addEventHandler ("GTIachievements_kills", root, kills )

function medkits ( )
	if exports.GTIaccounts:GAD ( getPlayerAccount ( source ), "Achievement4" ) == 1 then return end
	local med =  tonumber ( exports.GTIstats:getStatData ( getPlayerAccount ( source ), "med_kits_used" ) ) or 0
	if med >= 100 then
		local name = getPlayerName ( source )
		outputChatBox ("Achievements: "..name..", Unlocked achievement 'Use over 100 Medic Kits'", root, 0, 255, 0, false )
		exports.GTIaccounts:SAD( getPlayerAccount ( source ), "Achievement4", 1 )
	end
end
addEvent ("GTIachievements_medkits", true )
addEventHandler ("GTIachievements_medkits", root, medkits )
