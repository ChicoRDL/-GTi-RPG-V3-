local w, h = guiGetScreenSize( );
local x1, y1, z1 = getCameraMatrix()
local sx1, sy1 = getScreenFromWorldPosition(x1, y1, z1)
local enable = false;

--[[
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ),
    function( )
        bindKey( ".", "up", enableBlackWhite );
    end
)
--]]

function findRotation(x1,y1,x2,y2)

  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;

end

addEventHandler( "onClientRender", root,
    function()
        if not enable then return end
        local x2, y2, z2 = getCameraMatrix()
        local d = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2);
        local sx2, sy2 = w/2, h/2
        local dx = x1 - x2
        local dy = y1 - y2
        local dz = z1 - z2
        local multiplier = 0.0160
        local tick = getTickCount() / 1750
        local tick2 = getTickCount() / 500
        local move = math.sin( tick) + 0.025
        local rot = math.sin( tick) + 0.025
        dxSetShaderValue( screenShader, "BlurAmount", d*multiplier+(move/500))
        dxSetShaderValue( screenShader, "Angle", findRotation(dx, dx, dx, dz)) -- Fail code, but gives a nice effect

        dxSetRenderTarget()
        dxUpdateScreenSource( screenSrc)
        --dxDrawImage( 0, move*2.5, w, h, screenShader, (rot/10))
        dxDrawImageSection( 0, 0, w, h, move*1.5, move*1.5, w, h, screenShader, rot, move, 0, tocolor( 255, 255, 255, 255), false)
    end
)

function renderEffect( )
    local x2, y2, z2 = getCameraMatrix()

    local d = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2);

    sx2, sy2 = w/2, h/2

    local dx = x1 - x2
    local dy = y1 - y2
    local dz = z1 - z2

    if getPedOccupiedVehicle(getLocalPlayer()) then
        --multiplier = 0.0003
        multiplier = 0.0060
    else
        --multiplier = 0.0008
        multiplier = 0.0030
    end

    dxSetShaderValue( screenShader, "BlurAmount", d*multiplier );
    dxSetShaderValue( screenShader, "Angle", findRotation(dx, dx, dx, dz)) -- Fail code, but gives a nice effect

    dxSetRenderTarget();
    dxUpdateScreenSource( screenSrc );
    dxDrawImage( 0, 0, w, h, screenShader );

    x1, y1, z1 =  getCameraMatrix()
end

function enableBlackWhite( )
    enable = not enable;
    if enable then
        screenShader = dxCreateShader( "effects/motion.fx" );
        screenSrc = dxCreateScreenSource( w, h );
        if screenShader and screenSrc then
            dxSetShaderValue( screenShader, "ScreenTexture", screenSrc );
            addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
        end
    else
        if screenShader and screenSrc then
            destroyElement( screenShader );
            destroyElement( screenSrc );
            screenShader, screenSrc = nil, nil;
            removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
        end
    end
end
