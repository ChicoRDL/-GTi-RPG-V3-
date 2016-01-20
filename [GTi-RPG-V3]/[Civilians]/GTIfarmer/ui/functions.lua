local lastTable = false

data = {
	visn = {},
	name = {},
	text = {},
	pos = {},
	d  = {},
	cost = {},
}
ids = {}

render = false

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		for i, shop in ipairs ( shops) do
			local x, y, z = shop[1], shop[2], shop[3]
			local identifier = shop[4]
			local worldData = shop[5]
			local worldData = split( worldData, ";")

			local int = worldData[1]
			local dim = worldData[2]

			local marker = createMarker( x, y, z, "cylinder", 1.25, 255, 125, 0, 150)
			local col = createColTube( x, y, z, 0.75, 1.75)
			ids[col] = identifier

			setElementInterior( marker, int)
			setElementDimension( marker, dim)
			setElementInterior( col, int)
			setElementDimension( col, dim)

			addEventHandler( "onClientColShapeHit", col, uiEnter)
		end
		--changeShowcase( categories)
	end
)

function setMenuLogo( file)
	menuLogo = file
end

function setMenuIcon( file)
	if file then
		viewedImage = file
	end
end

function setMenuColor( colorString)
	if colorString then
		menuColor = colorString
	end
end

local curShop = ""

function uiEnter( hitElement, matching)
	if isElement( hitElement) and getElementType( hitElement) == "player" and matching then
		if hitElement ~= localPlayer then return end
		if isPlayerInVehicle( localPlayer) then return end
		if not getElementData( localPlayer, "job") == "Farmer" then return end
		local id = ids[source]
		if id then
			showChat( false)
			toggleAllControls( false)
			changeShowcase( items[id], "Seed Packages")
			setMenuColor( tcolor[id])
			curShop = id
			if not render then
				render = true
			end
			if trans[id] and trans[id] ~= 0 then
				local logoFile = tostring( "logo"..trans[id])
				local iconFile = tostring( "ttile"..trans[id])
				setMenuIcon( iconFile)
				setMenuLogo( logoFile)
			else
				setMenuIcon( "ttile")
				setMenuLogo( "logo")
			end
		end
	end
end

function uiExit()
	if render then
		render = false
		showChat( true)
		toggleAllControls( true)
	end
end

addEventHandler( "onClientPlayerWasted", localPlayer,
	function()
		uiExit()
	end
)

function bugStopper()
	uiExit()
end
addEvent( "GTIfood.bugStopper", true)
addEventHandler( "GTIfood.bugStopper", root, bugStopper)

function changeShowcase( theTable, visibleName)
	if theTable == lastTable then return false end
	if theTable and type( theTable) == "table" then
		if visibleName and visibleName ~= "" then
			colName = visibleName
		end
		--lastTable = theTable
		for i, item in pairs (vTable) do
			vTable[i] = nil
			data.text[i] = nil
			data.pos[i] = nil
			data.name[i] = nil
			data.d[i] = nil
			data.visn[i] = nil
			data.cost[i] = nil
		end
		for i, cdata in ipairs ( theTable) do
			if i ~= 1 then
				data.text[i] = "255;255;255"
			else
				data.text[i] = "0;0;0"
			end
			data.pos[i] = 239+((offs*i))
			if not cdata[3] then
				table.insert( vTable, { cdata[1], cdata[2]})
			else
				table.insert( vTable, { cdata[1], cdata[2], cdata[3]})
				data.d[i] = cdata[3]
			end
			data.visn[i] = cdata[1]
			if cdata[2] and type( items[cdata[2]]) == "table" then
				data.name[i] = cdata[2]
				data.cost[i] = 0
			else
				data.name[i] = cdata[1]
				data.cost[i] = cdata[2]
			end
		end
		sname = data.name[selected]
		selpos = 269
		move = 0
		selected = 1
		selShow = 1
	end
end

function getItemData( id)
	if data.d[id] then
		return data.d[id]
	else
		return false
	end
end

valid_keys = {
	["w"] = true,
	["s"] = true,
	["space"] = true,
	["enter"] = true,
	["backspace"] = true,
	["mouse1"] = true,
	["mouse2"] = true,
	["mouse_wheel_up"] = true,
	["mouse_wheel_down"] = true,
}

addEventHandler( "onClientKey", root,
	function( key, press)
		if not render then return end
		if key and valid_keys[key] and press then
			--if getPlayerName( localPlayer) ~= "LilDolla" then return end
			if key == "mouse_wheel_up" or key == "w" then
				if selected == ((#vTable-#vTable)+1) then
					if not maxed then
						return
					end
				end
				if selShow <= 10 then
					data.text[selected] = "255;255;255"
					selected = selected - 1
					selShow = selShow - 1
					selpos = data.pos[selected]
					data.text[selected] = "0;0;0"
					sname = data.name[selected]
				else
					move = move + 60
					data.text[moved_up] = "255;255;255"
					moved_up = moved_up - 1
					selShow = selShow - 1
					--data.text[moved_up] = "0;0;0"
					sname = data.name[selected]
					if selShow <= 9 then
						selected = selected - 1
					end
					if selShow - 1 == 9 then
						maxed = false
					end
				end
			elseif key == "mouse_wheel_down" or key == "s" then
				if selected ~= 10 then
					if not data.pos[selected+1] then return end
					data.text[selected] = "255;255;255"
					selected = selected + 1
					selShow = selShow + 1
					moved_up = moved_up + 1
					selpos = data.pos[selected]
					data.text[selected] = "0;0;0"
					sname = data.name[selected]
				else
					if selShow ~= #vTable then
						if show+moved_up == #vTable then
							return
						end
						--if not data.name[selShow+1] then return end
						move = move - 60
						moved_up = moved_up + 1
						data.text[selShow] = "255;255;255"
						selShow = selShow + 1
						data.text[selShow] = "0;0;0"
						sname = data.name[selShow]
					else
						if selShow ~= 10 then
							if not maxed then
								maxed = true
							end
						end
						return
					end
				end
			elseif key == "mouse1" or key == "enter" then
				if data.name[selShow] then
					local name = data.name[selShow]
					if items[name] then
						changeShowcase( items[name], data.visn[selShow])
					else
						local chp = getElementHealth( localPlayer)

						local name = name
						local cost = data.cost[selShow]
						local seeds = getItemData(selShow)

						if getPlayerMoney( localPlayer) > 0 then
							if tonumber( theSeeds) ~= 10000 then
								if tonumber( theSeeds+100) <= 10000 then
									giveSeeds( seeds, cost)
									exports.GTIhud:dm( "You bought "..seeds.." seeds for $"..cost, 255, 255, 0)
								else
									exports.GTIhud:dm( "You have enough seeds to use.", 255, 255, 0)
								end
							else
								exports.GTIhud:dm( "You are carrying the maximum amount of seeds.", 255, 0, 0)
							end
						else
							exports.GTIhud:dm( "You do not have enough money to buy "..seeds.." seeds.", 255, 0, 0)
						end

						uiExit( true)
					end
				end
			elseif key == "mouse2" then
				uiExit()
			end
		end
	end
)
