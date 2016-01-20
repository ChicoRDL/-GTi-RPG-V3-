local screenW, screenH = guiGetScreenSize()

GTImedic = {
    checkbox = {},
    label = {},
    gridlist = {},
    window = {},
}

GTImedic.window[1] = guiCreateWindow((screenW - 496) / 2, (screenH - 399) / 2, 496, 399, "GTI - Paramedic Computer", false)
guiWindowSetSizable(GTImedic.window[1], false)
guiSetVisible( GTImedic.window[1], false)

GTImedic.gridlist[1] = guiCreateGridList(10, 26, 195, 349, false, GTImedic.window[1])
plrColumn = guiGridListAddColumn(GTImedic.gridlist[1], "Players", 0.9)
guiGridListSetSortingEnabled(GTImedic.gridlist[1],false)

GTImedic.label[1] = guiCreateLabel(453, 26, 30, 15, "Close", false, GTImedic.window[1])
guiSetFont(GTImedic.label[1], "default-small")
guiLabelSetHorizontalAlign(GTImedic.label[1], "center", false)
guiLabelSetVerticalAlign(GTImedic.label[1], "center")

GTImedic.label[2] = guiCreateLabel(215, 155, 271, 15, "_______________________________________________________________", false, GTImedic.window[1])

GTImedic.label[3] = guiCreateLabel(215, 26, 240, 16, "Name: ", false, GTImedic.window[1])

GTImedic.label[4] = guiCreateLabel(215, 51, 271, 16, "Health: ", false, GTImedic.window[1])

GTImedic.label[5] = guiCreateLabel(215, 77, 290, 16, "Location: ", false, GTImedic.window[1])

GTImedic.label[6] = guiCreateLabel(215, 103, 290, 16, "Travel State: ", false, GTImedic.window[1])

GTImedic.label[7] = guiCreateLabel(215, 129, 290, 16, "Team: ", false, GTImedic.window[1])
--[[
GTImedic.label[8] = guiCreateLabel(215, 210, 271, 15, "Filters", false, GTImedic.window[1])
guiSetFont(GTImedic.label[8], "default-small")
guiLabelSetHorizontalAlign(GTImedic.label[8], "center", false)
guiLabelSetVerticalAlign(GTImedic.label[8], "center")

GTImedic.checkbox[1] = guiCreateCheckBox(225, 235, 125, 15, "Below 25% HP", false, false, GTImedic.window[1])

GTImedic.checkbox[2] = guiCreateCheckBox(225, 256, 125, 15, "Above 50% HP", false, false, GTImedic.window[1])

GTImedic.checkbox[3] = guiCreateCheckBox(225, 277, 125, 15, "Above 75% HP", false, false, GTImedic.window[1])

GTImedic.checkbox[4] = guiCreateCheckBox(345, 235, 125, 15, "Below 50% HP", false, false, GTImedic.window[1])

GTImedic.checkbox[5] = guiCreateCheckBox(345, 256, 125, 15, "Below 75% HP", false, false, GTImedic.window[1])

GTImedic.checkbox[6] = guiCreateCheckBox(345, 277, 125, 15, "View All Players", false, false, GTImedic.window[1])
--]]

GTImedic.label[9] = guiCreateLabel(10, 375, 30, 15, "Refresh", false, GTImedic.window[1])
guiSetFont(GTImedic.label[9], "default-small")
guiLabelSetHorizontalAlign(GTImedic.label[9], "center", false)
guiLabelSetVerticalAlign(GTImedic.label[9], "center")

GTImedic.label[10] = guiCreateLabel(215, 298, 271, 15, "Personal Medic Details", false, GTImedic.window[1])
guiSetFont(GTImedic.label[10], "default-small")
guiLabelSetHorizontalAlign(GTImedic.label[10], "center", false)
GTImedic.label[11] = guiCreateLabel(215, 323, 271, 16, "Rank: ", false, GTImedic.window[1])

GTImedic.label[12] = guiCreateLabel(215, 339, 271, 16, "Next Rank: ", false, GTImedic.window[1])

GTImedic.label[13] = guiCreateLabel(215, 355, 271, 16, "Heal Points: ", false, GTImedic.window[1])

GTImedic.label[14] = guiCreateLabel(215, 371, 271, 16, "Heal Points Required for Promo: ", false, GTImedic.window[1])

GTImedic.label[15] = guiCreateLabel(225, 180, 113, 15, "Mark Selected Player", false, GTImedic.window[1])
guiSetFont(GTImedic.label[15], "default-small")
guiLabelSetHorizontalAlign(GTImedic.label[15], "center", false)
guiLabelSetVerticalAlign(GTImedic.label[15], "center")

GTImedic.label[16] = guiCreateLabel(355, 180, 113, 15, "Mark All Players", false, GTImedic.window[1])
guiSetFont(GTImedic.label[16], "default-small")
guiLabelSetHorizontalAlign(GTImedic.label[16], "center", false)
guiLabelSetVerticalAlign(GTImedic.label[16], "center")

playerRow = {}

local labelChanges = {
	{ GTImedic.label[3]},
	{ GTImedic.label[4]},
	{ GTImedic.label[5]},
	{ GTImedic.label[6]},
	{ GTImedic.label[7]},
	--{ GTImedic.label[8]},
	{ GTImedic.label[10]},
}

addEvent( "accessMedicComputer", true)
addEventHandler( "accessMedicComputer", root,
	function()
		if not guiGetVisible( GTImedic.window[1]) then
			guiGridListClear(GTImedic.gridlist[1])
			for i, player in ipairs (getElementsByType( "player")) do
				if getElementHealth( player) < 100 then
					local name = getPlayerName( player)
					local team = getPlayerTeam( player)
					local tR, tG, tB = getTeamColor( team or getTeamFromName("General Population"))
					--
					local row = guiGridListAddRow( GTImedic.gridlist[1])
					guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
					guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
					playerRow[player] = row
				end
			end

			guiSetVisible( GTImedic.window[1], true)
			showCursor( true)
		end
	end
)

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		for i, player in ipairs (getElementsByType( "player")) do
			if getElementHealth( player) < 100 then
				local name = getPlayerName( player)
				local team = getPlayerTeam( player)
				local tR, tG, tB = getTeamColor( team or getTeamFromName("General Population"))
				--
				local row = guiGridListAddRow( GTImedic.gridlist[1])
				guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
				guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
				playerRow[player] = row
			end
		end
		for i, v in ipairs (labelChanges) do
			guiLabelSetColor( v[1], 30, 255, 125)
		end
	end
)

addEventHandler( "onClientMouseEnter", root,
	function()
		if source == GTImedic.label[1] then
			guiLabelSetColor( source, 30, 255, 125)
		elseif source == GTImedic.label[9] then
			guiLabelSetColor( source, 30, 255, 125)
		elseif source == GTImedic.label[15] then
			guiLabelSetColor( source, 30, 255, 125)
		elseif source == GTImedic.label[16] then
			guiLabelSetColor( source, 30, 255, 125)
		end
	end
)

addEventHandler( "onClientMouseLeave", root,
	function()
		if source == GTImedic.label[1] then
			guiLabelSetColor( source, 255, 255, 255)
		elseif source == GTImedic.label[9] then
			guiLabelSetColor( source, 255, 255, 255)
		elseif source == GTImedic.label[15] then
			guiLabelSetColor( source, 255, 255, 255)
		elseif source == GTImedic.label[16] then
			guiLabelSetColor( source, 255, 255, 255)
		end
	end
)
--[[
addEventHandler( "onClientPlayerJoin", root,
	function()
		for i, player in ipairs (getElementsByType( "player")) do
			local name = getPlayerName( player)
			local team = getPlayerTeam( player)
			local tR, tG, tB = getTeamColor(team or getTeamFromName("General Population"))
			--
			guiGridListClear( GTImedic.gridlist[1])
			local row = guiGridListAddRow( GTImedic.gridlist[1])
			guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
			guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			playerRow[player] = row
		end
	end
)
--]]
addEventHandler( "onClientPlayerQuit", root,
	function()
		--[[for i, player in ipairs (getElementsByType( "player")) do
			local name = getPlayerName( player)
			local team = getPlayerTeam( player)
			local tR, tG, tB = getTeamColor( team)
			--
			guiGridListClear( GTImedic.gridlist[1])
			local row = guiGridListAddRow( GTImedic.gridlist[1])
			guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
			guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			playerRow[player] = row
		end--]]
		local markState = marks[source]
		if markState ~= nil then
			markState[source] = nil
			destroyElement( markState)
		end
	end
)

function getPlayerHealthGroup( theType, hp)
	if not theType then return end
	for i, v in ipairs (getElementsByType( "player")) do
		if theType == "below" then
			for k, n in pairs (getElementsByType( "player")) do
				local health = getElementHealth( n)
				if health <= hp then
					return n
				else
					return nil
				end
			end
		elseif theType == "above" then
			for k, n in pairs (getElementsByType( "player")) do
				local health = getElementHealth( n)
				if health >= hp then
					return n
				else
					return nil
				end
			end
		elseif theType == "all" then
			guiGridListClear( GTImedic.gridlist[1])
			for k, n in pairs (getElementsByType( "player")) do
				if getElementHealth( n) < 100 then
					local name = getPlayerName( n)
					local team = getPlayerTeam( n)
					local tR, tG, tB = getTeamColor( team)
					local row = guiGridListAddRow( GTImedic.gridlist[1])
					guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
					guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
				end
			end
		end
	end
end

marks = {}

function markPlayer( theType, player)
	if not theType then return end
	if theType == "player" then
		local name = getPlayerName( player)
		if name then
			if marks[player] == nil then
				outputChatBox( "You have marked "..name, 30, 255, 125)
				local blip = createBlipAttachedTo( player, 41, 2, 255, 0, 0, 255, 0, 450)
				marks[player] = blip
			else
				outputChatBox( "You have unmarked "..name, 30, 255, 125)
				local theBlip = marks[player]
				destroyElement( theBlip)
				marks[player] = nil
			end
		end
	elseif theType == "all" then
		for i, players in ipairs (getElementsByType( "player")) do
			local blips = marks[players]
			if blips == nil then
				--outputChatBox( "You have marked all players", 30, 255, 125)
				if players ~= localPlayer then
					local blip = createBlipAttachedTo( players, 41, 2, 255, 0, 0, 255, 0, 450)
					marks[players] = blip
				end
			else
				--outputChatBox( "You have unmarked all players", 30, 255, 125)
				destroyElement( blips)
				marks[players] = nil
			end
			--
		end
	end
end

addEventHandler( "onClientGUIClick", root,
	function()
		if source == GTImedic.gridlist[1] then
			local selectedRow, selectedCol = guiGridListGetSelectedItem( GTImedic.gridlist[1])
			local name = guiGridListGetItemText( GTImedic.gridlist[1], selectedRow, selectedCol)
			local player = getPlayerFromName(name)
			if player then
				local markState = marks[player]
				local state = guiGetEnabled( GTImedic.label[15])
				if markState ~= nil then
					guiSetText( GTImedic.label[15], "Unmark Selected Player")
				else
					guiSetText( GTImedic.label[15], "Mark Selected Player")
				end
				if state == false then
					local allmark = guiGetText( GTImedic.label[16])
					if allmark == "Unmark All Players" then
					elseif allmark == "Mark All Players" then
						guiSetEnabled( GTImedic.label[15], true)
						guiLabelSetColor( GTImedic.label[15], 255, 255, 255)
					end
				end
				getDetails( player)
			else
				guiSetEnabled( GTImedic.label[15], false)
				guiLabelSetColor( GTImedic.label[15], 10, 10, 10)
			end
			for i, plrs in ipairs ( getElementsByType( "player")) do
				local markedPlayers = marks[plrs]
				if markedPlayers == nil then
					guiSetText( GTImedic.label[16], "Mark All Players")
				else
					guiSetText( GTImedic.label[16], "Unmark All Players")
				end
			end
		--Refresh
		elseif source == GTImedic.label[9] then
			getPlayerHealthGroup( "all")
		--Closing
		elseif source == GTImedic.label[1] then
			if guiGetVisible( GTImedic.window[1]) then
				guiSetVisible( GTImedic.window[1], false)
				showCursor( false)
			end
		--Marking
		elseif source == GTImedic.label[15] then
			local selectedRow, selectedCol = guiGridListGetSelectedItem( GTImedic.gridlist[1])
			local name = guiGridListGetItemText( GTImedic.gridlist[1], selectedRow, selectedCol)
			local player = getPlayerFromName(name)
			if player then
				if player ~= localPlayer then
					local markState = marks[player]
					markPlayer( "player", player)
					if markState ~= nil then
						guiSetText( GTImedic.label[15], "Mark Selected Player")
					else
						guiSetText( GTImedic.label[15], "Unmark Selected Player")
					end
				else
					outputChatBox( "You can't mark yourself.", 255, 0, 0)
				end
			end
		elseif source == GTImedic.label[16] then
			markPlayer( "all")
			for i, plrs in ipairs ( getElementsByType( "player")) do
				local markedPlayers = marks[plrs]
				if markedPlayers == nil then
					guiSetText( GTImedic.label[16], "Mark All Players")
					guiSetEnabled( GTImedic.label[15], true)
					guiLabelSetColor( GTImedic.label[15], 255, 255, 255)
				else
					guiSetText( GTImedic.label[16], "Unmark All Players")
					guiSetEnabled( GTImedic.label[15], false)
					guiLabelSetColor( GTImedic.label[15], 100, 100, 100)
				end
			end
		--Filtering
		elseif source == GTImedic.checkbox[1] then
			local selection = guiCheckBoxGetSelected( GTImedic.checkbox[1])
			if selection == true then
				guiSetEnabled( GTImedic.checkbox[2], false)
				guiSetEnabled( GTImedic.checkbox[3], false)
				guiSetEnabled( GTImedic.checkbox[4], false)
				guiSetEnabled( GTImedic.checkbox[5], false)
				guiSetEnabled( GTImedic.checkbox[6], false)
				guiGridListClear( GTImedic.gridlist[1])
				--
				local players = getPlayerHealthGroup( "below", 25)
				if players == nil then return end
				playerRow = {}
				local name = getPlayerName( players)
				local team = getPlayerTeam( players)
				local tR, tG, tB = getTeamColor( team)
				local row = guiGridListAddRow( GTImedic.gridlist[1])
				guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
				guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			else
				guiSetEnabled( GTImedic.checkbox[2], true)
				guiSetEnabled( GTImedic.checkbox[3], true)
				guiSetEnabled( GTImedic.checkbox[4], true)
				guiSetEnabled( GTImedic.checkbox[5], true)
				guiSetEnabled( GTImedic.checkbox[6], true)
				local players = getPlayerHealthGroup( "all")
			end
		elseif source == GTImedic.checkbox[2] then
			local selection = guiCheckBoxGetSelected( GTImedic.checkbox[2])
			if selection == true then
				guiSetEnabled( GTImedic.checkbox[1], false)
				guiSetEnabled( GTImedic.checkbox[3], false)
				guiSetEnabled( GTImedic.checkbox[4], false)
				guiSetEnabled( GTImedic.checkbox[5], false)
				guiSetEnabled( GTImedic.checkbox[6], false)
				guiGridListClear( GTImedic.gridlist[1])
				--
				local players = getPlayerHealthGroup( "above", 50)
				if players == nil then return end
				playerRow = {}
				local name = getPlayerName( players)
				local team = getPlayerTeam( players)
				local tR, tG, tB = getTeamColor( team)
				local row = guiGridListAddRow( GTImedic.gridlist[1])
				guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
				guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			else
				guiSetEnabled( GTImedic.checkbox[1], true)
				guiSetEnabled( GTImedic.checkbox[3], true)
				guiSetEnabled( GTImedic.checkbox[4], true)
				guiSetEnabled( GTImedic.checkbox[5], true)
				guiSetEnabled( GTImedic.checkbox[6], true)
				local players = getPlayerHealthGroup( "all")
			end
		elseif source == GTImedic.checkbox[3] then
			local selection = guiCheckBoxGetSelected( GTImedic.checkbox[3])
			if selection == true then
				guiSetEnabled( GTImedic.checkbox[1], false)
				guiSetEnabled( GTImedic.checkbox[2], false)
				guiSetEnabled( GTImedic.checkbox[4], false)
				guiSetEnabled( GTImedic.checkbox[5], false)
				guiSetEnabled( GTImedic.checkbox[6], false)
				guiGridListClear( GTImedic.gridlist[1])
				--
				local players = getPlayerHealthGroup( "above", 75)
				if players == nil then return end
				playerRow = {}
				local name = getPlayerName( players)
				local team = getPlayerTeam( players)
				local tR, tG, tB = getTeamColor( team)
				local row = guiGridListAddRow( GTImedic.gridlist[1])
				guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
				guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			else
				guiSetEnabled( GTImedic.checkbox[1], true)
				guiSetEnabled( GTImedic.checkbox[2], true)
				guiSetEnabled( GTImedic.checkbox[4], true)
				guiSetEnabled( GTImedic.checkbox[5], true)
				guiSetEnabled( GTImedic.checkbox[6], true)
				getPlayerHealthGroup( "all")
			end
		elseif source == GTImedic.checkbox[4] then
			local selection = guiCheckBoxGetSelected( GTImedic.checkbox[4])
			if selection == true then
				guiSetEnabled( GTImedic.checkbox[1], false)
				guiSetEnabled( GTImedic.checkbox[2], false)
				guiSetEnabled( GTImedic.checkbox[3], false)
				guiSetEnabled( GTImedic.checkbox[5], false)
				guiSetEnabled( GTImedic.checkbox[6], false)
				guiGridListClear( GTImedic.gridlist[1])
				--
				local players = getPlayerHealthGroup( "below", 50)
				if players == nil then return end
				playerRow = {}
				local name = getPlayerName( players)
				local team = getPlayerTeam( players)
				local tR, tG, tB = getTeamColor( team)
				local row = guiGridListAddRow( GTImedic.gridlist[1])
				guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
				guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			else
				guiSetEnabled( GTImedic.checkbox[1], true)
				guiSetEnabled( GTImedic.checkbox[2], true)
				guiSetEnabled( GTImedic.checkbox[3], true)
				guiSetEnabled( GTImedic.checkbox[5], true)
				guiSetEnabled( GTImedic.checkbox[6], true)
				local players = getPlayerHealthGroup( "all")
			end
		elseif source == GTImedic.checkbox[5] then
			local selection = guiCheckBoxGetSelected( GTImedic.checkbox[5])
			if selection == true then
				guiSetEnabled( GTImedic.checkbox[1], false)
				guiSetEnabled( GTImedic.checkbox[2], false)
				guiSetEnabled( GTImedic.checkbox[3], false)
				guiSetEnabled( GTImedic.checkbox[4], false)
				guiSetEnabled( GTImedic.checkbox[6], false)
				guiGridListClear( GTImedic.gridlist[1])
				--
				local players = getPlayerHealthGroup( "below", 75)
				if players == nil then return end
				playerRow = {}
				local name = getPlayerName( players)
				local team = getPlayerTeam( players)
				local tR, tG, tB = getTeamColor( team)
				local row = guiGridListAddRow( GTImedic.gridlist[1])
				guiGridListSetItemText( GTImedic.gridlist[1], row, plrColumn, name, false, false)
				guiGridListSetItemColor( GTImedic.gridlist[1], row, plrColumn, tR, tG, tB)
			else
				guiSetEnabled( GTImedic.checkbox[1], true)
				guiSetEnabled( GTImedic.checkbox[2], true)
				guiSetEnabled( GTImedic.checkbox[3], true)
				guiSetEnabled( GTImedic.checkbox[4], true)
				guiSetEnabled( GTImedic.checkbox[6], true)
				local players = getPlayerHealthGroup( "all")
			end
		elseif source == GTImedic.checkbox[6] then
			local selection = guiCheckBoxGetSelected( GTImedic.checkbox[6])
			if selection == true then
				guiSetEnabled( GTImedic.checkbox[1], false)
				guiSetEnabled( GTImedic.checkbox[2], false)
				guiSetEnabled( GTImedic.checkbox[3], false)
				guiSetEnabled( GTImedic.checkbox[4], false)
				guiSetEnabled( GTImedic.checkbox[5], false)
				guiGridListClear( GTImedic.gridlist[1])
				--
				local players = getPlayerHealthGroup( "all")
			else
				guiSetEnabled( GTImedic.checkbox[1], true)
				guiSetEnabled( GTImedic.checkbox[2], true)
				guiSetEnabled( GTImedic.checkbox[3], true)
				guiSetEnabled( GTImedic.checkbox[4], true)
				guiSetEnabled( GTImedic.checkbox[5], true)
				local players = getPlayerHealthGroup( "all")
			end
		end
	end
)

function getDetails( thePlr)
	if thePlr then
		if not isElement( thePlr) then return end
		local name = getPlayerName( thePlr)
		local hp = getElementHealth( thePlr)
		local team = getPlayerTeam( thePlr)
		local teamName = getTeamName( team)
		local x, y, z = getElementPosition( localPlayer)
		local tX, tY, tZ = getElementPosition( thePlr)
		local location, city = getZoneName( tX, tY, tZ, false), getZoneName( tX,tY,tZ, true)
		local distance = getDistanceBetweenPoints3D( x, y, z, tX, tY, tZ)
		guiSetText( GTImedic.label[3], "Name: "..name)
		guiSetText( GTImedic.label[4], "Health: "..math.floor(hp).."%")
		guiSetText( GTImedic.label[5], "Location: "..location..", "..city.." ( "..math.floor(distance).."m)")
		guiSetText( GTImedic.label[7], "Team: "..teamName)
	else
		guiSetText( GTImedic.label[3], "Name: ")
		guiSetText( GTImedic.label[4], "Health: ")
		guiSetText( GTImedic.label[5], "Location: ")
		guiSetText( GTImedic.label[7], "Team: ")
	end
end
