--
-- c_bloom.lua
--
local orderPriority = "-1.0"	-- The lower this number, the later the effect is applied

local BloomSettings = {}
BloomSettings.var = {}
local scx, scy = guiGetScreenSize ()

--
-- c_rtpool.lua
--
-----------------------------------------------------------------------------------
-- Pool of render targets
-----------------------------------------------------------------------------------
local RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( sx, sy )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.sx == sx and info.sy == sy then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( sx, sy )
	if rt then
		RTPool.list[rt] = { bInUse = true, sx = sx, sy = sy }
	end
	return rt
end

function RTPool.clear()
	for rt,info in pairs(RTPool.list) do
		destroyElement(rt)
	end
	RTPool.list = {}
end


-----------------------------------------------------------------------------------
-- DebugResults
-- Store all the rendertarget results for debugging
-----------------------------------------------------------------------------------
local DebugResults = {}
DebugResults.items = {}

function DebugResults.frameStart()
	DebugResults.items = {}
end

function DebugResults.addItem( rt, label )
	table.insert( DebugResults.items, { rt=rt, label=label } )
end

function DebugResults.drawItems( sizeX, sliderX, sliderY )
	local posX = 5
	local gapX = 4
	local sizeY = sizeX * 90 / 140
	local textSizeY = 15 + 10
	local posY = 5
	local textColor = tocolor(0,255,0,255)
	local textShad = tocolor(0,0,0,255)

	local numImages = #DebugResults.items
	local totalWidth = numImages * sizeX + (numImages-1) * gapX
	local totalHeight = sizeY + textSizeY

	posX = posX - (totalWidth - (scx-10)) * sliderX / 100
	posY = posY - (totalHeight - scy) * sliderY / 100

	local textY = posY+sizeY+1
	for index,item in ipairs(DebugResults.items) do
		dxDrawImage( posX, posY, sizeX, sizeY, item.rt )
		local sizeLabel = string.format( "%d) %s %dx%d", index, item.label, dxGetMaterialSize( item.rt ) )
		dxDrawText( sizeLabel, posX+1.0, textY+1, posX+sizeX+1.0, textY+16, textShad,  1, "arial", "center", "top", true )
		dxDrawText( sizeLabel, posX,	 textY,   posX+sizeX,     textY+15, textColor, 1, "arial", "center", "top", true )
		posX = posX + sizeX + gapX
	end
end

----------------------------------------------------------------
-- enableBloom
----------------------------------------------------------------

function enableBloom()
	if bloomEffectsEnabled then return end
	-- Create things
	myBloomScreenSource = dxCreateScreenSource( scx/2, scy/2 )

	bloomBlurHShader,tecName = dxCreateShader( "shaders/Bloom/fx/blurH.fx" )

	bloomBlurVShader,tecName = dxCreateShader( "shaders/Bloom/fx/blurV.fx" )

	bloomBrightPassShader,tecName = dxCreateShader( "shaders/Bloom/fx/brightPass.fx" )

    bloomAddBlendShader,tecName = dxCreateShader( "shaders/Bloom/fx/addBlend.fx" )

	-- Get list of all elements used
	bloomEffectParts = {
						myBloomScreenSource,
						bloomBlurVShader,
						bloomBlurHShader,
						bloomBrightPassShader,
						bloomAddBlendShader,
					}

	-- Check list of all elements used
	bloomBAllValid = true
	for _,part in ipairs(bloomEffectParts) do
		bloomBAllValid = part and bloomBAllValid
	end
	
	setBloomEffectVariables ()
	bloomEffectsEnabled = true
	
	if not bloomBAllValid then
		disableBloom()
	end	
end

-----------------------------------------------------------------------------------
-- disableBloom
-----------------------------------------------------------------------------------
function disableBloom()
	if not bloomEffectsEnabled then return end
	-- Destroy all shaders
	for _,part in ipairs(bloomEffectParts) do
		if part then
			destroyElement( part )
		end
	end
	bloomEffectParts = {}
	bloomBAllValid = false
	RTPool.clear()
	
	-- Flag effect as stopped
	bloomEffectsEnabled = false
end

---------------------------------
-- BloomSettings for effect
---------------------------------
function setBloomEffectVariables()
    local v = BloomSettings.var
    -- Bloom
    v.cutoff = 0.08
    v.power = 1.88
	v.blur = 0.9
    v.bloom = 1.7
    v.blendR = 204
    v.blendG = 153
    v.blendB = 130
    v.blendA = 100

	-- Debugging
    v.PreviewEnable=0
    v.PreviewPosY=0
    v.PreviewPosX=100
    v.PreviewSize=70
end

-----------------------------------------------------------------------------------
-- onClientHUDRender
-----------------------------------------------------------------------------------
addEventHandler( "onClientHUDRender", root,
    function()
		if not bloomBAllValid or not BloomSettings.var then return end
		local v = BloomSettings.var	
			
		-- Reset render target pool
		RTPool.frameStart()
		DebugResults.frameStart()
		-- Update screen
		dxUpdateScreenSource( myBloomScreenSource, true )
			
		-- Start with screen
		local current = myBloomScreenSource

		-- Apply all the effects, bouncing from one render target to another
		current = bloomApplyBrightPass( current, v.cutoff, v.power )
		current = bloomApplyDownsample( current )
		current = bloomApplyDownsample( current )
		current = bloomApplyGBlurH( current, v.bloom, v.blur )
		current = bloomApplyGBlurV( current, v.bloom, v.blur )

		-- When we're done, turn the render target back to default
		dxSetRenderTarget()

		-- Mix result onto the screen using 'add' rather than 'alpha blend'
		if current then
			dxSetShaderValue( bloomAddBlendShader, "TEX0", current )
			local col = tocolor(v.blendR, v.blendG, v.blendB, v.blendA)
			dxDrawImage( 0, 0, scx, scy, bloomAddBlendShader, 0,0,0, col )
		end
		-- Debug stuff
		if v.PreviewEnable > 0.5 then
			DebugResults.drawItems ( v.PreviewSize, v.PreviewPosX, v.PreviewPosY )
		end
	end
,true ,"low" .. orderPriority )


-----------------------------------------------------------------------------------
-- Apply the different stages
-----------------------------------------------------------------------------------
function bloomApplyDownsample( Src, amount )
	if not Src then return nil end
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src )
	DebugResults.addItem( newRT, "bloomApplyDownsample" )
	return newRT
end

function bloomApplyGBlurH( Src, bloom, blur )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomBlurHShader, "TEX0", Src )
	dxSetShaderValue( bloomBlurHShader, "TEX0SIZE", mx,my )
	dxSetShaderValue( bloomBlurHShader, "BLOOM", bloom )
	dxSetShaderValue( bloomBlurHShader, "BLUR", blur )
	dxDrawImage( 0, 0, mx, my, bloomBlurHShader )
	DebugResults.addItem( newRT, "bloomApplyGBlurH" )
	return newRT
end

function bloomApplyGBlurV( Src, bloom, blur )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomBlurVShader, "TEX0", Src )
	dxSetShaderValue( bloomBlurVShader, "TEX0SIZE", mx,my )
	dxSetShaderValue( bloomBlurVShader, "BLOOM", bloom )
	dxSetShaderValue( bloomBlurVShader, "BLUR", blur )
	dxDrawImage( 0, 0, mx,my, bloomBlurVShader )
	DebugResults.addItem( newRT, "bloomApplyGBlurV" )
	return newRT
end

function bloomApplyBrightPass( Src, cutoff, power )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomBrightPassShader, "TEX0", Src )
	dxSetShaderValue( bloomBrightPassShader, "CUTOFF", cutoff )
	dxSetShaderValue( bloomBrightPassShader, "POWER", power )
	dxDrawImage( 0, 0, mx,my, bloomBrightPassShader )
	DebugResults.addItem( newRT, "bloomApplyBrightPass" )
	return newRT
end


----------------------------------------------------------------
-- Avoid errors messages when memory is low
----------------------------------------------------------------
_dxDrawImage = dxDrawImage
function bloomxdxDrawImage(posX, posY, width, height, image, ... )
	if not image then return false end
	return _dxDrawImage( posX, posY, width, height, image, ... )
end

function setBloomShaderEnabled( blOn )
	if blOn then
		enableBloom()
	else
		disableBloom()
	end
end