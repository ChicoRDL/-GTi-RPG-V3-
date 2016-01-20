-- main variables
local root = getRootElement()
local resourceRoot = getResourceRootElement(getThisResource())
local screenWidth, screenHeight = guiGetScreenSize()

-- settings
local bitDepth = 16 -- between 1 and 64
local outlineStrength = 0.9 -- between 0 and 1 // higher amount will decrease outline strenght

-- functional variables
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
local toonShader, toonTec = dxCreateShader("shaders/Cartoon/shaders/toonShader.fx")
local isEventHandled = false
function switchCartoon(state)
        if not state then
		--destroyElement(toonShader)
		toonShader = nil
		removeEventHandler("onClientPreRender", root, enableCartoon)
		isEventHandled = false
		else
		toonShader, toonTec = dxCreateShader("shaders/Cartoon/shaders/toonShader.fx")
		if not isEventHandled then
		addEventHandler("onClientPreRender", root, enableCartoon)
		isEventHandled = true
		end
        if (not toonShader) then
		
		end
    end
end
addEvent( "switchCartoon", true )
addEventHandler( "switchCartoon", resourceRoot, switchCartoon )

function enableCartoon()
    if (toonShader) then
        dxUpdateScreenSource(myScreenSource)
        
        dxSetShaderValue(toonShader, "ScreenSource", myScreenSource)
		dxSetShaderValue(toonShader, "ScreenWidth", screenWidth)
		dxSetShaderValue(toonShader, "ScreenHeight", screenHeight)
        dxSetShaderValue(toonShader, "BitDepth", bitDepth)
		dxSetShaderValue(toonShader, "OutlineStrength", outlineStrength)

        dxDrawImage(0, 0, screenWidth, screenHeight, toonShader)
    end
end

addEventHandler("onClientResourceStop", resourceRoot,
function()
	if (toonShader) then
		--destroyElement(toonShader)
		toonShader = nil
	end
end)