----------------------------------------->>
-- GTI: Grand Theft International
-- Author: Jack Johnson (Jack)
-- Date: 17 Mar 2015
-- Resource: GTImodshop/modshop.lua
-- Version: 1.0
----------------------------------------->>

menu = {}	-- Table of Menus
toggled = false

-- Main Menu
------------->>

function menu.main()
	if not toggled then
		dxCreateWindow("menu", "images/transfender.png", "Categories")
		dxCreateButton("Color", "")
		dxCreateButton("Test Item 2", "")
		dxCreateButton("Test Item 3", "")
		dxCreateButton("Test Item 4", "")
		dxCreateButton("Test Item 5", "")
	else
		dxDestroyWindow()
	end
	toggled = not toggled
	showCursor(toggled)
end
addCommandHandler("modshop",function() menu.main() end)