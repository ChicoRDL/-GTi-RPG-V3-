

local tattoos = {
	{ "Imperial Douche", 120},
	{ "Evil Clown", 250},
	{ "Blackjack", 120},
	{ "Eye Catcher", 65},
	{ "Betraying Scroll", 150},
	{ "Tweaker", 145},
	{ "Stone Cross", 200},
	{ "Monster Pups", 240},
	{ "Piggy", 175},
	{ "Ace", 65},
	--[[
	{ "Smiley", 50},
	{ "Fuck Cops", 70},
	{ "Impotent Rage", 70},
	{ "Chinese Dragon", 500},
	{ "Skulls and Rose", 300},
	{ "Unzipped", 190},
	{ "Lucky", 129},
	--]]
}

local selected = 1

local offs = 30
local show = 10

local text = {}
local pos = {}

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		for i, tattoo in ipairs ( tattoos) do
			text[i] = "255;255;255"
			pos[i] = 239+((offs*i))
		end
	end
)
local selpos = 269

addEventHandler("onClientPreRender", root,
    function()
        dxDrawRectangle(65, 229, 312, 336, tocolor(0, 0, 0, 198), false) -- Back
        dxDrawRectangle(65, 229, 312, 34, tocolor(0, 0, 0, 127), false) -- Outlining

        dxDrawText( selected.." / "..(#tattoos), 276, 236, 367, 256, tocolor(255, 255, 255, 255), 1.25, "default", "right", "center", false, false, false, false, false)
        dxDrawText("Tattoos", 75, 236, 266, 256, tocolor(255, 255, 255, 255), 1.25, "default", "left", "center", false, false, false, false, false)
        dxDrawRectangle(65, 147, 312, 79, tocolor(217, 168, 50, 255), false) -- Color
        dxDrawText("Tattoo", 151, 147, 291, 206, tocolor(255, 255, 255, 255), 2.00, "diploma", "left", "center", false, false, false, false, false) -- Main Title
		dxDrawText("Body Arts", 215, 196, 306, 216, tocolor(255, 255, 255, 255), 1.25, "sans", "center", "center", false, false, false, false, false) -- Sub Title

		local tick = getTickCount() / 100
		local sa = math.sin(tick) * 4
		dxDrawRectangle(68, selpos, 306, 24, tocolor(255, 254, 254, sa), false)
		for i, tattoo in ipairs ( tattoos) do
			local name = tattoo[1]
			local price = tattoo[2]

			local color = split( text[i], ";")
			local r, g, b = color[1], color[2], color[3]

			if i <= 10 then
				dxDrawText( name, 75, 209+((offs*i)*2), 266, 289, tocolor(r, g, b, 200), 1.15, "default", "left", "center", false, false, false, false, false)
				dxDrawText("$"..price, 276, 209+((offs*i)*2), 367, 289, tocolor(r, g, b, 255), 1.15, "default", "right", "center", false, false, false, false, false)
			end
		end
    end
)

function changePosition( ttype)
	if ttype then
		selpos = selpos - 1
	else
		selpos = selpos + 1
	end
end

addEventHandler( "onClientKey", root,
	function( key, press)
		if key and press then
			if key == "i" then
				if selected == ((#tattoos-#tattoos)+1) then return end
				selected = selected - 1
				selpos = pos[selected]
			elseif key == "k" then
				if selected == #tattoos then return end
				selected = selected + 1
				selpos = pos[selected]
			end
		end
	end
)
