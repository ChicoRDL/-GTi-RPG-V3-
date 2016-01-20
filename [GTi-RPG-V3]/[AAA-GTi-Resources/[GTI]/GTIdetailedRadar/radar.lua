local satelliteTextures = { }
local satelliteFiles = {"sattelite/sattelite_0_0.jpeg",
    "sattelite/sattelite_0_1.jpeg",
    "sattelite/sattelite_0_2.jpeg",
    "sattelite/sattelite_0_3.jpeg",
    "sattelite/sattelite_0_4.jpeg",
    "sattelite/sattelite_0_5.jpeg",
    "sattelite/sattelite_0_6.jpeg",
    "sattelite/sattelite_0_7.jpeg",
    "sattelite/sattelite_0_8.jpeg",
    "sattelite/sattelite_0_9.jpeg",
    "sattelite/sattelite_0_10.jpeg",
    "sattelite/sattelite_0_11.jpeg",
    "sattelite/sattelite_1_0.jpeg",
    "sattelite/sattelite_1_1.jpeg",
    "sattelite/sattelite_1_2.jpeg",
    "sattelite/sattelite_1_3.jpeg",
    "sattelite/sattelite_1_4.jpeg",
    "sattelite/sattelite_1_5.jpeg",
    "sattelite/sattelite_1_6.jpeg",
    "sattelite/sattelite_1_7.jpeg",
    "sattelite/sattelite_1_8.jpeg",
    "sattelite/sattelite_1_9.jpeg",
    "sattelite/sattelite_1_10.jpeg",
    "sattelite/sattelite_1_11.jpeg",
    "sattelite/sattelite_2_0.jpeg",
    "sattelite/sattelite_2_1.jpeg",
    "sattelite/sattelite_2_2.jpeg",
    "sattelite/sattelite_2_3.jpeg",
    "sattelite/sattelite_2_4.jpeg",
    "sattelite/sattelite_2_5.jpeg",
    "sattelite/sattelite_2_6.jpeg",
    "sattelite/sattelite_2_7.jpeg",
    "sattelite/sattelite_2_8.jpeg",
    "sattelite/sattelite_2_9.jpeg",
    "sattelite/sattelite_2_10.jpeg",
    "sattelite/sattelite_2_11.jpeg",
    "sattelite/sattelite_3_0.jpeg",
    "sattelite/sattelite_3_1.jpeg",
    "sattelite/sattelite_3_2.jpeg",
    "sattelite/sattelite_3_3.jpeg",
    "sattelite/sattelite_3_4.jpeg",
    "sattelite/sattelite_3_5.jpeg",
    "sattelite/sattelite_3_6.jpeg",
    "sattelite/sattelite_3_7.jpeg",
    "sattelite/sattelite_3_8.jpeg",
    "sattelite/sattelite_3_9.jpeg",
    "sattelite/sattelite_3_10.jpeg",
    "sattelite/sattelite_3_11.jpeg",
    "sattelite/sattelite_4_0.jpeg",
    "sattelite/sattelite_4_1.jpeg",
    "sattelite/sattelite_4_2.jpeg",
    "sattelite/sattelite_4_3.jpeg",
    "sattelite/sattelite_4_4.jpeg",
    "sattelite/sattelite_4_5.jpeg",
    "sattelite/sattelite_4_6.jpeg",
    "sattelite/sattelite_4_7.jpeg",
    "sattelite/sattelite_4_8.jpeg",
    "sattelite/sattelite_4_9.jpeg",
    "sattelite/sattelite_4_10.jpeg",
    "sattelite/sattelite_4_11.jpeg",
    "sattelite/sattelite_5_0.jpeg",
    "sattelite/sattelite_5_1.jpeg",
    "sattelite/sattelite_5_2.jpeg",
    "sattelite/sattelite_5_3.jpeg",
    "sattelite/sattelite_5_4.jpeg",
    "sattelite/sattelite_5_5.jpeg",
    "sattelite/sattelite_5_6.jpeg",
    "sattelite/sattelite_5_7.jpeg",
    "sattelite/sattelite_5_8.jpeg",
    "sattelite/sattelite_5_9.jpeg",
    "sattelite/sattelite_5_10.jpeg",
    "sattelite/sattelite_5_11.jpeg",
    "sattelite/sattelite_6_0.jpeg",
    "sattelite/sattelite_6_1.jpeg",
    "sattelite/sattelite_6_2.jpeg",
    "sattelite/sattelite_6_3.jpeg",
    "sattelite/sattelite_6_4.jpeg",
    "sattelite/sattelite_6_5.jpeg",
    "sattelite/sattelite_6_6.jpeg",
    "sattelite/sattelite_6_7.jpeg",
    "sattelite/sattelite_6_8.jpeg",
    "sattelite/sattelite_6_9.jpeg",
    "sattelite/sattelite_6_10.jpeg",
    "sattelite/sattelite_6_11.jpeg",
    "sattelite/sattelite_7_0.jpeg",
    "sattelite/sattelite_7_1.jpeg",
    "sattelite/sattelite_7_2.jpeg",
    "sattelite/sattelite_7_3.jpeg",
    "sattelite/sattelite_7_4.jpeg",
    "sattelite/sattelite_7_5.jpeg",
    "sattelite/sattelite_7_6.jpeg",
    "sattelite/sattelite_7_7.jpeg",
    "sattelite/sattelite_7_8.jpeg",
    "sattelite/sattelite_7_9.jpeg",
    "sattelite/sattelite_7_10.jpeg",
    "sattelite/sattelite_7_11.jpeg",
    "sattelite/sattelite_8_0.jpeg",
    "sattelite/sattelite_8_1.jpeg",
    "sattelite/sattelite_8_2.jpeg",
    "sattelite/sattelite_8_3.jpeg",
    "sattelite/sattelite_8_4.jpeg",
    "sattelite/sattelite_8_5.jpeg",
    "sattelite/sattelite_8_6.jpeg",
    "sattelite/sattelite_8_7.jpeg",
    "sattelite/sattelite_8_8.jpeg",
    "sattelite/sattelite_8_9.jpeg",
    "sattelite/sattelite_8_10.jpeg",
    "sattelite/sattelite_8_11.jpeg",
    "sattelite/sattelite_9_0.jpeg",
    "sattelite/sattelite_9_1.jpeg",
    "sattelite/sattelite_9_2.jpeg",
    "sattelite/sattelite_9_3.jpeg",
    "sattelite/sattelite_9_4.jpeg",
    "sattelite/sattelite_9_5.jpeg",
    "sattelite/sattelite_9_6.jpeg",
    "sattelite/sattelite_9_7.jpeg",
    "sattelite/sattelite_9_8.jpeg",
    "sattelite/sattelite_9_9.jpeg",
    "sattelite/sattelite_9_10.jpeg",
    "sattelite/sattelite_9_11.jpeg",
    "sattelite/sattelite_10_0.jpeg",
    "sattelite/sattelite_10_1.jpeg",
    "sattelite/sattelite_10_2.jpeg",
    "sattelite/sattelite_10_3.jpeg",
    "sattelite/sattelite_10_4.jpeg",
    "sattelite/sattelite_10_5.jpeg",
    "sattelite/sattelite_10_6.jpeg",
    "sattelite/sattelite_10_7.jpeg",
    "sattelite/sattelite_10_8.jpeg",
    "sattelite/sattelite_10_9.jpeg",
    "sattelite/sattelite_10_10.jpeg",
    "sattelite/sattelite_10_11.jpeg",
    "sattelite/sattelite_11_0.jpeg",
    "sattelite/sattelite_11_1.jpeg",
    "sattelite/sattelite_11_2.jpeg",
    "sattelite/sattelite_11_3.jpeg",
    "sattelite/sattelite_11_4.jpeg",
    "sattelite/sattelite_11_5.jpeg",
    "sattelite/sattelite_11_6.jpeg",
    "sattelite/sattelite_11_7.jpeg",
    "sattelite/sattelite_11_8.jpeg",
    "sattelite/sattelite_11_9.jpeg",
    "sattelite/sattelite_11_10.jpeg",
    "sattelite/sattelite_11_11.jpeg",
}

function enableDetailedRadar(bool)
	if bool then
		for index, value in ipairs ( satelliteFiles ) do
			downloadFile(value)
		end
		if not arefilesdownloaded then
		exports.GTIhud:dm("Radar files are being downloaded.",0,0,255)
		removeEventHandler ( "onClientFileDownloadComplete", root, onDownloadFinish)
		addEventHandler ( "onClientFileDownloadComplete", root, onDownloadFinish)
		else
		toggleCustomRadar(true)
		end
	else
		toggleCustomRadar(false)
	end
end
function arefilesdownloaded()
local bool = true
	for index, value in ipairs ( satelliteFiles ) do
		if not fileExists(value) then
			local bool = false
		end
	end
	return bool
end
	
function onDownloadFinish(file,success)
	if (source == resourceRoot) then
		if success and file == "sattelite/sattelite_11_11.jpeg" then
			toggleCustomRadar(true)
			exports.GTIhud:dm("Radar files were succesfully downloaded.",0,255,0)
		end
	end
end

function toggleCustomRadar (bool)
	if bool then
		handleTileLoading ( )
		timer = setTimer ( handleTileLoading, 1000, 0 )
	else
		if isTimer ( timer ) then killTimer ( timer ) end
		for name, data in pairs ( satelliteTextures ) do
			unloadTile ( name )
		end
	end
end

function handleTileLoading ( )
	local visibleTileNames = table.merge ( engineGetVisibleTextureNames ( "radar??" ), engineGetVisibleTextureNames ( "radar???" ) )
	for name, data in pairs ( satelliteTextures ) do
		if not table.find ( visibleTileNames, name ) then
			unloadTile ( name )
		end
	end
	for index, name in ipairs ( visibleTileNames ) do
		loadTile ( name )
	end
end

function table.merge ( ... )
	local ret = { }
	
	for index, tbl in ipairs ( {...} ) do
		for index, val in ipairs ( tbl ) do
			table.insert ( ret, val )
		end
	end
	
	return ret
end

function table.find ( tbl, val )
	for index, value in ipairs ( tbl ) do
		if value == val then
			return index
		end
	end
	
	return false
end

function loadTile ( name )
	if type ( name ) ~= "string" then
		return false
	end
	if satelliteTextures[name] then
		return true
	end
	local id = tonumber ( name:match ( "%d+" ) )
	if not id then
		return false
	end
	local row = math.floor ( id / 12 )
	local col = id - ( row * 12 )
	local posX = -3000 + 500 * col
	local posY =  3000 - 500 * row
	local file = string.format ( "sattelite/sattelite_%d_%d.jpeg", row, col )
	if not fileExists(file) then return end
	local texture = dxCreateTexture ( file )
	if not texture --[[or not overlay]] then
		return end
	local shader = dxCreateShader ( "texreplace.fx" )
	if not shader then
	--	outputChatBox ( "Failed to load shader" )
		destroyElement ( texture )
		return false
	end
	dxSetShaderValue ( shader, "gTexture", texture )
	engineApplyShaderToWorldTexture ( shader, name )
	satelliteTextures[name] = { shader = shader, texture = texture }
	return true
end

function unloadTile ( name )
	local tile = satelliteTextures[name]
	if not tile then
		return false
	end
	if isElement ( tile.shader )  then destroyElement ( tile.shader )  end
	if isElement ( tile.texture ) then destroyElement ( tile.texture ) end
	satelliteTextures[name] = nil
	return true
end