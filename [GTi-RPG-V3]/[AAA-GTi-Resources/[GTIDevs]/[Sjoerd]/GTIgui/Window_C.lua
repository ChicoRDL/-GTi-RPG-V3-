--[[ Make a custom GTI window ]]--
function createWindow(x, y, width, height, text, relative, source_resource)
	local window = guiCreateStaticImage(x, y, width, height, "img/back.png", relative )
	local winTitle = guiCreateLabel((width/2)-((string.len(text)*7)/2), 3, (string.len(text)*10), 20, text, relative, window)
	local winTitleFont = guiCreateFont( "fonts/RobotoSlab-Bold.ttf", 11 )
	local winFont = guiCreateFont( "fonts/RobotoSlab-Bold.ttf", 10 )

	-- Add resource to restart list
	if source_resource then
		triggerServerEvent("GTIgui.addToRefreshList", resourceRoot, source_resource)
	end

	-- Add a cloose button
	-- local close_button = guiCreateButton(width-30, 0, 30, 28, "X", false, window)
	-- addEventHandler("onClientGUIClick", close_button, function()
		-- guiSetVisible(window, false)
	-- end)

	-- Apply the new font style of the GUI
	guiSetFont(winTitle, winTitleFont)
	return window
end

--[[ Walrus default font ]]--
function setDefaultFont(inputElement, size)
	local font = guiCreateFont("fonts/RobotoSlab-Bold.ttf", size)
	guiSetFont(inputElement, font)
end

--[[ Toggle the cursor (globally) ]]--
-- function toggleCursor()
	-- if isCursorShowing(localPlayer) then
    		-- showCursor(false, false)
    	-- else
    		-- showCursor(true, true)
    	-- end
-- end
----bindKey("x", "down", toggleCursor, "Toggle cursor")
