local sW, sH = guiGetScreenSize()

colName = "Categories"

sname = ""
selected = 1
selShow = 1

offs = 30
show = 10

showing = {}

vTable = showing

animRT = false

local viewing = {}

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		changeShowcase( categories)
		--vTable = categories
		--viewing[localPlayer] = true
	end
)

addEventHandler( "onClientResourceStop", resourceRoot,
	function()
		if viewing[localPlayer] then
			viewing[localPlayer] = nil
			--setCameraTarget( localPlayer)
		end
	end
)

selpos = 269
idir = "ui/images/"
udmove = 3

move = 0
moved_up = 0
maxed = false

local anim_pos = 0

addEventHandler("onClientPreRender", root,
    function()
		if not render then return end
		--if getPlayerName( localPlayer) ~= "LilDolla" then return end
		local mc = split( menuColor, ",")
		dxDrawRectangle(65, 150, 312, 79, tocolor( mc[1], mc[2], mc[3], 255), false) -- Color
		dxDrawImageSection( 65, 150, 312, 79, -anim_pos, -(anim_pos+2), 164, 164, idir..viewedImage..".png", 0, 0, 0, tocolor( 255, 255, 255, 55), false)
		anim_pos = anim_pos + 0.25
		dxDrawImage( 65, 150, 312, 79, idir..menuLogo..".png", 0, 0, 0, tocolor(255, 255, 255), false)
		if #vTable >= 10 then
			dxDrawRectangle(65, 229, 312, 336, tocolor(0, 0, 0, 198), false) -- Back
			dxDrawRectangle(65, 565, 312, 34, tocolor(0, 0, 0, 220), false) -- Up/Down
		else
			dxDrawRectangle(65, 229, 312, 35+(#vTable*offs), tocolor(0, 0, 0, 198), false) -- Back
		end
		dxDrawRectangle(65, 229, 312, 34, tocolor(0, 0, 0, 127), false) -- Outlining
        dxDrawText( selShow.." / "..(#vTable), 276, 236, 367, 256, tocolor(255, 255, 255, 255), 1.25, "default", "right", "center", false, false, false, false, false)
        dxDrawText( string.upper( colName), 75, 236, 266, 256, tocolor(255, 255, 255, 255), 1.25, "default", "left", "center", false, false, false, false, false)
		if #vTable >= 10 then
			if selected ~= 1 then
				dxDrawImage( 203, 571, 16, 16, idir.."u.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
			else
				dxDrawImage( 203, 571, 16, 16, idir.."u.png", 0, 0, 0, tocolor(255, 255, 255, 55), false)
			end
			if selShow ~= #vTable then
				dxDrawImage(219, 571, 16, 16, idir.."d.png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
			else
				dxDrawImage(219, 571, 16, 16, idir.."d.png", 0, 0, 0, tocolor(255, 255, 255, 55), false)
			end
		end
		if #vTable ~= 0 then
			dxDrawRectangle(65, selpos, 312, 25, tocolor(255, 254, 254, 255), false) -- Selection Bar
		end
		for i, tableData in ipairs ( vTable) do
			local name = tableData[1]
			local price = tableData[2]

			local color = split( data.text[i], ";") or { 255, 255, 255}
			local r, g, b = color[1], color[2], color[3]

			local restriction = tonumber((209+move)+((offs*i)*2))
			if tableData[3] and string.find( tableData[3], ",") then
				local rest2 = tonumber((238.5+(move/2))+(offs*i))
				local color = split( tableData[3], ",")
				local cR, cG, cB = color[1], color[2], color[3]
				if rest2 >= 263 and rest2 <= 540 then
					if i == selShow then
						dxDrawImage( 72, (238.5+(move/2))+(offs*i), 24, 24, idir..viewedImage..".png", 0, 0, 0, tocolor( cR, cG, cB, 255), false)
					else
						dxDrawImage( 72, (238.5+(move/2))+(offs*i), 24, 24, idir..viewedImage..".png", 0, 0, 0, tocolor( cR, cG, cB, 255), false)
					end
				end
			end
			if restriction >= 269 and restriction <= 809 then
				if tableData[3] and string.find( tableData[3], ",") then
					dxDrawText( name, 100, (209+move)+((offs*i)*2), 266, 289, tocolor(r, g, b, 255), 1.15, "default-bold", "left", "center", false, false, false, false, false)
				else
					dxDrawText( name, 75, (209+move)+((offs*i)*2), 266, 289, tocolor(r, g, b, 255), 1.15, "default-bold", "left", "center", false, false, false, false, false)
				end
				if price == "-" then
					--dxDrawText( "", 276, (209+move)+((offs*i)*2), 367, 289, tocolor(r, g, b, 255), 1.15, "default-bold", "right", "center", false, false, false, false, false)
					dxDrawImage( 342, (234+move)+(offs*i), 32, 32, idir..viewedImage..".png", 0, 0, 0, tocolor( 255, 255, 255, 200), false)
				elseif price and type(items[price]) == "table" then
					--dxDrawText( (#items[price]).." Items", 276, (209+move)+((offs*i)*2), 367, 289, tocolor(r, g, b, 255), 1.15, "default-bold", "right", "center", false, false, false, false, false)
					dxDrawText( (#items[price]), 276, (209+move)+((offs*i)*2), 337, 289, tocolor(r, g, b, 255), 1.15, "default-bold", "right", "center", false, false, false, false, false)
					if i == selShow then
						dxDrawImage( 342, (234+move)+(offs*i), 24, 24, idir..viewedImage..".png", 0, 0, 0, tocolor( 255, 255, 255, 190), false)
					else
						dxDrawImage( 342, (234+move)+(offs*i), 24, 24, idir..viewedImage..".png", 0, 0, 0, tocolor( 255, 255, 255, 190), false)
					end
				else
					if tableData[3] ~= true then
						dxDrawText( "$"..price, 276, (209+move)+((offs*i)*2), 367, 289, tocolor(r, g, b, 255), 1.15, "default-bold", "right", "center", false, false, false, false, false)
					else
						dxDrawImage( 342, (234+move)+(offs*i), 24, 24, idir..viewedImage..".png", 0, 0, 0, tocolor( 255, 255, 255, 190), false)
					end
				end
			end
		end
    end
)
