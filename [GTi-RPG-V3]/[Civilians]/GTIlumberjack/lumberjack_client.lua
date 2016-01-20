------------------------------------------------->>
-- PROJECT:			Grand Theft International
-- RESOURCE: 		GTIlumberjack/lumberjack_client.lua
-- DESCRIPTION:		Lumberjack job, cut the trees > transport them to a log industry.
-- AUTHOR:			Nerox
-- RIGHTS:			All rights reserved to author
------------------------------------------------->>
local allowedTrees = { ---------- IN THIS TABLE NEVER UNCOMMENT AN EXPLOITABLE ID --------------
	[615] = true,
	[616] = true,
	[617] = true,
	[618] = true,
	[619] = true,
	[620] = true,
	[621] = true,
	[622] = true,
	[623] = true,
	[624] = true,
	[634] = true,
	[641] = true,
	[645] = true,
	[648] = true,
	[649] = true,
	[652] = true,
	[654] = true,
	[655] = true,
	[656] = true,
	[657] = true,
	[658] = true,
	[659] = true,
	[660] = true,
	[661] = true,
	[669] = true,
	[670] = true,
	[671] = true,
	[672] = true,
	[673] = true,
	--[674] = ture,---> exploitable
	[685] = true,
	[686] = true,
	[687] = true,
	[691] = true,
	[700] = true,
	[703] = true,
	[705] = true,
	[706] = true,
	[707] = true,
	[708] = true,
	[709] = true,
	[710] = true,
	[711] = true,
	[712] = true,
	[713] = true,
	[714] = true,
	[715] = true,
	[716] = true,
	[717] = true,
	[718] = true,
	[719] = true,
	[720] = true,
	[721] = true,
	[722] = true,
	[723] = true,
	[724] = true,
	[725] = true,
	[726] = true,
	[727] = true,
	[728] = true,
	[729] = true,
	[730] = true,
	[731] = true,
	[732] = true,
	[733] = true,
	[734] = true,
	[735] = true,
	[736] = true,
	[739] = true,
	[740] = true,
	[763] = true,
	[764] = true,
	[765] = true,
	[766] = true,
	[767] = true,
	[768] = true,
	[769] = true,
	[770] = true,
	[771] = true,
	--[772] = true, ---> exploitable
	[773] = true,
	[774] = true,
	[775] = true,
	[776] = true,
	[777] = true,
	--[778] = true, ---> exploitable
	[779] = true,
	[780] = true,
	[781] = true,
	[782] = true,
	--[881] = true, ---> exploitable
	--[882] = true, ---> exploitable
	--[883] = true, ---> exploitable
	--[884] = true, ---> exploitable
	--[885] = true, ---> exploitable
	[886] = true,
	[887] = true,
	[888] = true,
	--[889] = true, ---> exploitable
	[890] = true,
	--[891] = true, ---> exploitable
	[892] = true,
	[893] = true,
	[894] = true,
	[895] = true,
}
local notAllowedTrees ={
    [683] = true,	
	[688] = true,
	[689] = true,
	[690] = true,
	[694] = true,
	[695] = true,
	[698] = true,
	[790] = true,
	[791] = true,
	[16060] = true,
	[16061] = true,
	[18268] = true,
	[18269] = true,
	[18270] = true,
	[18271] = true,
	[18272] = true,
	[772] = true,
	[778] = true,
}
local woodOnFire = {
    {-1860.840, -1649.872, 25.170},
	{-1853.940, -1654.124, 23.454},
	{-1853.962, -1650.050, 24.334},
	{-1856.637, -1645.548, 23.925},
	{-1860.354, -1645.953, 24.728},
	{-1864.235, -1650.105, 23.926},
	{-1863.994, -1654.762, 23.203},
	{-1860.087, -1653.043, 26.220},
    {-1858.364, -1652.126, 25.403},
    {-1857.235, -1651.497, 25.309},
    {-1857.751, -1649.142, 25.250},
    {-1857.264, -1656.324, 23.754},
    {-1860.174, -1655.748, 24.095},
    {-1853.611, -1645.434, 23.015},
}
local mx, my = 1440,900
local sx, sy = guiGetScreenSize()
local fx, fy = (sx /mx), (sy / my) 
local isEventToAskCutHandled = false
local disableMultipleTrigger = false
local length = 5
local cancelNextTime = false
local cutTimer
local isKeyBinded = false
local isNumberOtHandled = false
local maxCutTrees = 30
local isErrorMsgHandled = false
addEventHandler("onClientResourceStart", resourceRoot, function()
    for i=1, #woodOnFire do
	createEffect ("fire_large", woodOnFire[i][1], woodOnFire[i][2], woodOnFire[i][3])
	end
end)
function numberOfTrees()
    if exports.GTIemployment:getPlayerJob(true) and exports.GTIemployment:getPlayerJob() == "Lumberjack" then
    local numberOfTreesCut = getElementData(localPlayer, "GTIlumberjack.cuttenTrees") or 0
	if numberOfTreesCut < maxCutTrees then
    exports.GTIhud:drawStat("GTIlumberjack.numberOfTrees", "Number of trees cut", ""..numberOfTreesCut.."/"..maxCutTrees.."", 255, 255, 0, 250)
	elseif numberOfTreesCut >= maxCutTrees then
	exports.GTIhud:drawStat("GTIlumberjack.numberOfTrees", "Number of trees cut", ""..numberOfTreesCut.."/"..maxCutTrees.."", 255, 0, 0, 250)
	end
	end
end
function notAllowedTree()
    if exports.GTIemployment:getPlayerJob(true) and exports.GTIemployment:getPlayerJob() == "Lumberjack" then
    exports.GTIhud:drawStat("GTIlumberjack.notAllowedTree", "You cannot cut this trees", "", 255, 0, 0, 250)
end
end
function showLimitError()
    if exports.GTIemployment:getPlayerJob(true) and exports.GTIemployment:getPlayerJob() == "Lumberjack" then
	if getElementData(localPlayer, "GTIlumberjack.cuttenTrees") >= maxCutTrees then
	isErrorMsgHandled = true
    exports.GTIhud:drawStat("GTIlumberjack.limitError", "You cannot cut more trees", "", 255, 0, 0, 250)
end
end
end
function getPointFrontOfElement(x, y, z, rz)
    local tx = x + - ( length ) * math.sin( math.rad( rz ) ) 
    local ty = y + length * math.cos( math.rad( rz ) )
    local tz = z
	return tx, ty, tz
end
local isDestroyHandled = false
function onClientRequestCutTree(key, keyState, x , y, z, id, lodid, hitElement)
   if keyState == "down" then
   if not isDestroyHandled then
   addEventHandler("onClientElementDestroy", root, onPlayerHideVehicle)
   isDestroyHandled = true
   end
   cancelNextTime = true
   exports.GTIhud:drawProgressBar("GTIlumberjack.progressToCut", " ", 255, 255, 0, 5000)
   cutTimer = setTimer(function()
   triggerServerEvent("GTIlumberjack.onRequestCutTree", localPlayer, x , y, z, id, lodid, hitElement)
   cancelNextTime = false
   end, 5000, 1)
   elseif keyState == "up" then
   if cancelNextTime then
   exports.GTIhud:drawProgressBar("GTIlumberjack.progressToCut", " ", 255, 255, 0, 0)
   killTimer(cutTimer)
   end
   end
end
function onPlayerHideVehicle() -- while cutting
    if getElementType(source) == "vehicle" then
    if getVehicleModelFromName(getVehicleName(source)) == 486 and getPedOccupiedVehicle(localPlayer) == source then
    removeEventHandler("onClientRender", root, checkPlayerPositionToTree)
	if isTimer(cutTimer) then
	killTimer(cutTimer)
	end
    unbindKey("n", "both", onClientRequestCutTree)
	isKeyBinded = false
    exports.GTIhud:drawNote("GTIlumberjack.notAllowedTree", "", 255, 0, 0, 0)
    notAllowedTreeHandled = false
    exports.GTIhud:drawNote("GTIlumberjack.cutTheTree", "", 255, 255, 0, 0)
    isEventToAskCutHandled = false
	exports.GTIhud:drawProgressBar("GTIlumberjack.progressToCut", " ", 255, 255, 0, 0)
	removeEventHandler("onClientElementDestroy", root, onPlayerHideVehicle)
	isDestroyHandled = false
end
end
end
function checkPlayerPositionToTree() ------- This function checks if there is a tree infront of the player or not.
    if exports.GTIemployment:getPlayerJob(true) and exports.GTIemployment:getPlayerJob() == "Lumberjack" then
	if not isNumberOtHandled then
	addEventHandler("onClientRender", root, numberOfTrees)
	isNumberOtHandled = true
	end
	if isPedInVehicle(localPlayer) and getElementModel(getPedOccupiedVehicle(localPlayer)) == 486 then
    local x, y, z = getElementPosition(localPlayer)
    local _, _, rz = getElementRotation( localPlayer ) 
	local tx, ty, tz = getPointFrontOfElement(x, y, z, rz)
    local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material, lighting, piece, worldID, worldX, worldY, worldZ, worldRX, worldRY, worldRZ, worldLODID = processLineOfSight( x, y, z, tx, ty, tz, true, false, false, true, true, false, false, false, localPlayer, true, false ) 
    if (getElementData(localPlayer, "GTIlumberjack.cuttenTrees")or 0) >= maxCutTrees and not isErrorMsgHandled then
	addEventHandler("onClientRender", root, showLimitError)
	isErrorMsgHandled = true
	elseif (getElementData(localPlayer, "GTIlumberjack.cuttenTrees")or 0) < maxCutTrees and isErrorMsgHandled then
	removeEventHandler("onClientRender", root, showLimitError)
	isErrorMsgHandled = false
	elseif allowedTrees[worldID] and not disableMultipleTrigger and not isErrorMsgHandled then
	disableMultipleTrigger = true
	if not isEventToAskCutHandled then
	exports.GTIhud:drawNote("GTIlumberjack.cutTheTree", "Hold N to cut the tree", 255, 255, 0, 100000)
	isEventToAskCutHandled = true
	end
	if not isKeyBinded then
	bindKey("n", "both", onClientRequestCutTree, worldX, worldY, worldZ, worldID, worldLODID, hitElement)
	isKeyBinded = true
	end
    setTimer(function()	
	disableMultipleTrigger = false
	end,1500,1)
	elseif notAllowedTrees[worldID] and not isErrorMsgHandled then
	if not notAllowedTreeHandled then
    exports.GTIhud:drawNote("GTIlumberjack.notAllowedTree", "You cannot cut this trees", 255, 0, 0, 100000)
	notAllowedTreeHandled = true
	end
	elseif not notAllowedTrees[worldID] and not allowedTrees[worldID] then
	if isKeyBinded then
	exports.GTIhud:drawProgressBar("GTIlumberjack.progressToCut", " ", 255, 255, 0, 0)
	unbindKey("n", "both", onClientRequestCutTree)
	isKeyBinded = false
	if isTimer(cutTimer) then
	killTimer(cutTimer)
	end
	end
	if isEventToAskCutHandled then
	exports.GTIhud:drawNote("GTIlumberjack.cutTheTree", "", 255, 255, 0, 0)
	isEventToAskCutHandled = false
	end
	if notAllowedTreeHandled then
	exports.GTIhud:drawNote("GTIlumberjack.notAllowedTree", "", 255, 0, 0, 0)
	notAllowedTreeHandled = false
	end
end
end
end
end
function onPlayerEnterDozer(vehicle)
    if eventName == "onClientPlayerVehicleEnter" and source == localPlayer then
    if getVehicleModelFromName(getVehicleName(vehicle)) == 486 then
	addEventHandler("onClientRender", root, checkPlayerPositionToTree)
	end
	elseif eventName == "onClientPlayerVehicleExit" and source == localPlayer then
	if getVehicleModelFromName(getVehicleName(vehicle)) == 486 then
	removeEventHandler("onClientRender", root, checkPlayerPositionToTree)
end
end
end
function updateEventsHandled(jobName, newJob)
    if eventName == "onClientPlayerGetJob" then
	if jobName == "Lumberjack" then
	addEventHandler("onClientPlayerVehicleEnter", root, onPlayerEnterDozer)
	addEventHandler("onClientPlayerVehicleExit", root, onPlayerEnterDozer)
	addEventHandler("onClientRender", root, numberOfTrees)
	isNumberOtHandled = true
	end
	elseif eventName == "onClientPlayerQuitJob" then
	if jobName == "Lumberjack" then
	removeEventHandler("onClientRender", root, numberOfTrees)
	isNumberOtHandled = false
	removeEventHandler("onClientPlayerVehicleEnter", root, onPlayerEnterDozer)
	removeEventHandler("onClientPlayerVehicleExit", root, onPlayerEnterDozer)
	exports.GTIhud:drawNote("GTIlumberjack.cutTheTree", "", 255, 255, 0, 0)
	isEventToAskCutHandled = false
	exports.GTIhud:drawNote("GTIlumberjack.notAllowedTree", "", 255, 0, 0, 0)
	notAllowedTreeHandled = false
	end
end
end
addEventHandler("onClientPlayerGetJob", root, updateEventsHandled)
addEventHandler("onClientPlayerQuitJob", root, updateEventsHandled)
addEventHandler("onClientResourceStart", root, function(res)
    if (res == getThisResource() or res == getResourceFromName("GTIemployment")) then
    if (not getResourceFromName("GTIemployment") or getResourceState(getResourceFromName("GTIemployment")) ~= "running") then return end
	if exports.GTIemployment:getPlayerJob(true) and exports.GTIemployment:getPlayerJob() == "Lumberjack" then
	if not isNumberOtHandled then
	addEventHandler("onClientRender", root, numberOfTrees)
	isNumberOtHandled = true
	end
	addEventHandler("onClientPlayerVehicleEnter", root, onPlayerEnterDozer)
	addEventHandler("onClientPlayerVehicleExit", root, onPlayerEnterDozer)
	end
end	
end)
function onReqGetGroundPos(x, y, z)
    local groundPos = getGroundPosition(x, y, z+5)
	triggerServerEvent("GTIlumberjack.recieveGroundPosition", getResourceRootElement(getThisResource()), groundPos)
end
addEvent("GTIlumberjack.getGroundPosition", true)
addEventHandler("GTIlumberjack.getGroundPosition", root, onReqGetGroundPos)
