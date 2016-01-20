----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares (known as Arse aswell)
-- Date: 12 Dec 2015
-- Resource: GTImisc/nvision.lua
-- Version: 1.0
----------------------------------------->>

local bones = { 
				{1,		2}, 					-- Pelvis with Pelvis
				{2,		3}, 					-- Pelvis with Spine
				{3,		4}, 					-- Spine with Upper Torso
			
				{4,		22},	{4,		32}, 	-- Upper torso with shoulders

				{22,	23}, 	{32,	33},    -- Shoulder with elbow
				{23,	24},	{33,	34},    -- Elbow with wrist

				{1,		41},	{1,		51},  	-- Pelvis with hip
				
				{41,	42}, 	{51,	52},    -- Hip with knee
				{42,	43}, 	{52,	53}, 	-- Knee with ankle
				{43,	44}, 	{53,	54},    -- Ankle with foot
				}
 
addEventHandler('onClientRender', root,
        function()
			if ( getCameraGoggleEffect( ) ~= "normal" ) then
				for index, value in ipairs ( getElementsByType("player") ) do
					if ( isElementStreamedIn(value) and value ~= localPlayer ) then
						local hx,hy,hz = getElementPosition(value)            
						local cx,cy,cz = getCameraMatrix()
						local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
						local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, value )
							if ( dist < 250 and not isItClear ) then
								for key, pair in pairs ( bones ) do
										local start = pair[1]
										local finish = pair[2]
										local bone_1 = {getPedBonePosition(value, start)}
										local bone_2 = {getPedBonePosition(value, finish)}
										local screen_1 = {getScreenFromWorldPosition(unpack(bone_1))}
										local screen_2 = {getScreenFromWorldPosition(unpack(bone_2))}
										if ( screen_1[1] and screen_2[1] ) then
											dxDrawLine(screen_1[1], screen_1[2], screen_2[1], screen_2[2], nil, 1, false)
										end
								end
							end
					end
				end
			end
        end
)

----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares (known as Arse aswell)
-- Date: 12 Dec 2015
-- Resource: GTImisc/nvision.lua
-- Version: 2.0
----------------------------------------->>

addEventHandler("onClientRender", root,
	function ()
		if ( getCameraGoggleEffect( ) ~= "normal" ) then
			if ( not pwEffectEnabled ) then
				pwEffectEnabled = true
				enablePedWall()
			end
		else
			if ( pwEffectEnabled ) then
				pwEffectEnabled = false
				disablePedWall()
			end
		end
	end
)

local colorizePed = {1 ,0.5 ,0 ,1} -- rgba colors 
local specularPower = 1.3
local effectMaxDistance = 250
-- don't touch
local wallShader = {}
local PWTimerUpdate = 110
--local actKey = 'o'


function enablePedWall()
	pwEffectEnabled = true
	enablePedWallTimer()
	--outputChatBox('PedWall turned on',255,128,0)
	--outputChatBox('Press '..actKey..' for x-ray vision',255,128,0)
end

function disablePedWall()
	pwEffectEnabled = false
	disablePedWallTimer()
	--outputChatBox('PedWall turned off',255,128,0)
end


function createWallEffectForPlayer(thisPlayer)
    if not wallShader[thisPlayer] then
		wallShader[thisPlayer] = dxCreateShader ( "fx/ped_wall.fx", 1, 0, true, "ped" )
		if not wallShader then return false
		else
		dxSetShaderValue( wallShader[thisPlayer], "sColorizePed",colorizePed )
		dxSetShaderValue( wallShader[thisPlayer], "sSpecularPower",specularPower )
		engineApplyShaderToWorldTexture ( wallShader[thisPlayer], "*" , thisPlayer )
		engineRemoveShaderFromWorldTexture( wallShader[thisPlayer],"muzzle_texture*" , thisPlayer )
		if getElementAlpha(thisPlayer)==255 then setElementAlpha( thisPlayer, 254 ) end
		return true
		end
    end
end

function destroyShaderForPlayer(thisPlayer)
    if wallShader[thisPlayer] then
		engineRemoveShaderFromWorldTexture( wallShader[thisPlayer], "*" , thisPlayer)
		destroyElement(wallShader[thisPlayer])
		wallShader[thisPlayer] = nil
	end
end

function enablePedWallTimer()
	if PWenTimer then 
		return 
	end
	PWenTimer = setTimer(	function()
		--[[if getKeyState( actKey ) == true and pwEffectEnabled then 
			effectOn = true
		else 
			effectOn = false			
		end]]
		effectOn = true
		for index,thisPlayer in ipairs(getElementsByType("player")) do
			if isElementStreamedIn(thisPlayer) and thisPlayer~=localPlayer then
				local hx,hy,hz = getElementPosition(thisPlayer)            
				local cx,cy,cz = getCameraMatrix()
				local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
				local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, thisPlayer )
				if (dist<effectMaxDistance ) and not isItClear and effectOn then 
					createWallEffectForPlayer(thisPlayer)
				end 
				if (dist>effectMaxDistance ) or  isItClear or not effectOn then 
					destroyShaderForPlayer(thisPlayer) 
				end
			end
			if not isElementStreamedIn(thisPlayer) then destroyShaderForPlayer(thisPlayer) end
		end
	end
	,PWTimerUpdate,0 )
end

function disablePedWallTimer()
	if PWenTimer then
		for index,thisPlayer in ipairs(getElementsByType("player")) do
			destroyShaderForPlayer(thisPlayer)
		end
		killTimer( PWenTimer )
		PWenTimer = nil		
	end
end