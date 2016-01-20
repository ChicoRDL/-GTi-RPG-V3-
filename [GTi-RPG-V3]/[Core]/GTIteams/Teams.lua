----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 02 Dec 2013
-- Resource: GTIteams/teams.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local teams = {
["Government"] 			= createTeam("Government", 150, 150, 150),
["National Guard"] 		= createTeam("National Guard", 30, 125, 30),
["Law Enforcement"] 	= createTeam("Law Enforcement", 30, 125, 255),
["Emergency Services"] 	= createTeam("Emergency Services", 30, 255, 125),
["Civilian Workforce"] 	= createTeam("Civilian Workforce", 255, 200, 0),
["Criminals"] 			= createTeam("Criminals", 175, 25, 25),
["Terrorists"] 			= createTeam("Terrorists", 125, 30, 125),
--["Off-Duty"] 			= createTeam("Off-Duty", 255, 125, 0),
["General Population"] 	= createTeam("General Population", 255, 255, 255),
}

-- Exports
----------->>

function assignTeam(player, teamName, noBlip)
	if (not isElement(player) or type(teamName) ~= "string") then return false end

	local team = getTeamFromName(teamName)
	if (not team) then return false end

	setPlayerTeam(player, team)
	local r,g,b = getTeamColor(team)
	return exports.GTIblips:setPlayerNameColor(player, r, g, b, noBlip)
end

-- Default Team
---------------->>

addEventHandler("onPlayerJoin", root, function()
	assignTeam(source, "General Population", true)
end)

for i,player in ipairs(getElementsByType("player")) do
	assignTeam(player, "General Population")
end
