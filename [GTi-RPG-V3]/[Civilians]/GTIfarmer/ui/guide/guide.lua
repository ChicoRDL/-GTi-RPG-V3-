
keys = {
	{ "l_mouse", "Buy"},
	{ "r_mouse", "Exit"},
	{ "m_mouse", "Change Item's"},
	--{ "W", "Change Item"},
	--{ "S", "Change Item"},
}

images = {
	['l_mouse'] = true,
	['r_mouse'] = true,
	['m_mouse'] = true,
}

local offset = 65

local size = 0

addEventHandler("onClientRender", root,
    function()
		if not render then return end
        dxDrawRectangle(65, 847, 65 + size, 28, tocolor(0, 0, 0, 200), false)
		for i, key in ipairs ( keys) do
			size = 65 + ((i * 1.15) * offset)
			local length = dxGetTextWidth( key[2], 1.15, "defualt-bold")

			if images[key[1]] then
				local text = ": "..key[2]
				dxDrawImage( -40 + ((i * 1.65) * offset), 849, 24, 24, "ui/guide/"..key[1]..".png", 0, 0, 0, tocolor( 255, 255, 255, 255))
				dxDrawText( text, -15 + ((i * 1.65) * offset), 847, 65, 875, tocolor(255, 255, 255, 255), 1.15, "default-bold", "left", "center", false, false, false, false, false)
			else
				local text = key[1]..": "..key[2]
				dxDrawText( text, -65 + ((i * 1.65) * offset + (length + 10)), 847, 65, 875, tocolor(255, 255, 255, 255), 1.15, "default-bold", "left", "center", false, false, false, false, false)
			end
		end
    end
)
