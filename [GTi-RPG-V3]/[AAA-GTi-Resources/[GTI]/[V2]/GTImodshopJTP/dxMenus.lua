----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 05 Mar 2015
-- Resource: GTImodshop/dxMenus.lua
-- Version: 1.0
----------------------------------------->>

menu = {}	-- Table of Menus

-- Main Menu
------------->>

function menu.main()
	dxCreateWindow("menu", "images/transfender.png", "Categories")
	dxCreateButton("Color", "")
	dxCreateButton("Test Item 2", "")
	dxCreateButton("Test Item 3", "")
	dxCreateButton("Test Item 4", "")
	dxCreateButton("Test Item 5", "")
end