local userData = {}
local screenshotsToDelete  = {}
local url = "localhost/custom/igreporter/igreporter.php"
local QCA_CHAN = "#QCA"

function theCallBack(responseData, errno, playerAccount, bugInfo)
	if (errno == 0) then
		local data = fromJSON(responseData)
		local player = getAccountPlayer ( getAccount(playerAccount) )
		if (data["success"]) then
			if ( isElement(player) ) then
				exports.GTIhud:dm(data["success"]["message"], player, 0, 255, 0)
				outputConsole(data["success"]["link"], player)
			end
			deleteSSs()
			local priority, exploitable, link = bugInfo[1], bugInfo[2], data["success"]["link"]
			if ( priority ) == "Low" then text = "3[Low] A new bug report has arrived! BUG_LINK" end
			if ( priority ) == "Medium" then text = "8[Medium] A new bug report has arrived! BUG_LINK" end
			if ( priority ) == "High" then text = "4[High] A new bug report has arrived! BUG_LINK" end
			if ( exploitable ) then text = "5[Exploitable] A new bug report has arrived! BUG_LINK"	end
			local text = string.gsub(text, "BUG_LINK", link)
			
			exports.GTIirc:ircSay(exports.GTIirc:ircGetChannelFromName(QCA_CHAN), ""..text)
			if ( string.sub(text, 1, 1) == "3" ) then R, G, B = 0, 255, 0 end
			if ( string.sub(text, 1, 1) == "8" ) then R, G, B = 255, 255, 0 end
			if ( string.sub(text, 1, 1) == "4" ) then R, G, B = 255, 0, 0 end
			if ( string.sub(text, 1, 1) == "5" ) then R, G, B = 255, 120, 120 end
			
			for i,v in ipairs(getElementsByType("player")) do
				if exports.GTIutil:isPlayerInACLGroup( v, "QCA1", "QCA4", "QCA5", "Dev1", "Dev2", "Dev3", "Dev4", "Dev5") then
					outputChatBox("(QCA) "..string.sub(text, 2), v, R, G, B)
				end
			end
			
			R, G, B = nil, nil, nil
		elseif (data["error"]) then
			if ( isElement(player) ) then
				exports.GTIhud:dm(data["error"]["message"], player, 255, 0, 0)
			end
			deleteSSs()
		end
	else
			deleteSSs()
	end
end

function postHandler(data)
	local accountName = getAccountName(getPlayerAccount(client))
	if ( not exports.GTIutil:isPlayerLoggedIn(client) ) then return end
	if ( not exports.GTIauth:getPlayerAuthKey(client) ) then return exports.GTIhud:dm("Your account must be linked to the forum in order to use this feature", client, 255, 0, 0) end
	userData[accountName] = {}
	
	userData[accountName]["authkey"] = exports.GTIauth:getPlayerAuthKey(client)
	userData[accountName]["ipaddr"] = getPlayerIP(client)
	if (data["loc"]) then
		local x, y, z = getElementPosition(client)
		userData[accountName]["location"] = string.format("%.3f", x) .. ", " .. string.format("%.3f", y) .. ", " .. string.format("%.3f", z) .. " ( " .. (getZoneName ( x, y, z ) or 'Unknown').. " ) "
	else
		userData[accountName]["location"] = ""
	end
	
	for k, v in pairs(data) do userData[accountName][k] = v end
	if (data["screenshot"]) then
		if (takePlayerScreenShot(client, data["screendimentions"]["screenw"], data["screendimentions"]["screenh"], "GTIbreporter." .. getAccountName(getPlayerAccount(client)))) then end
		userData["screendimentions"] = nil
		exports.GTIhud:dm("Uploading screenshot, please wait a few seconds..", client, 255, 128, 0)
	else
		fetchRemote(url, theCallBack, toJSON(userData[accountName]), false, accountName, {userData[accountName]['priority'], userData[accountName]['exploitable']})
		userData[accountName] = nil
	end
	
end
addEvent("GTIbreporter.submit", true)
addEventHandler("GTIbreporter.submit", root, postHandler)

function getFormattedData(thedata)
	local formattedData = ""
	for k, v in ipairs(thedata) do
		formattedData = formattedData .. k:gsub("^%1", string.upper) .. "\n"
	end
end

function onScreenshotTaken(resource, status, imageData, timestamp, tag)
	if ( not tag:find("GTIbreporter") ) then return end
	local accountName = getAccountName( getPlayerAccount(source) )
	if (status == "ok") then
		--outputDebugString("Screenshot taken, saving and continuing...")
		userData[accountName]["status"] = true
		local timeTaken = getRealTime()
		filename = accountName .. "_" ..  timeTaken.year + 1900 .. "-" .. string.format("%02d", timeTaken.month + 1) .. "-" .. string.format("%02d", timeTaken.monthday) .. "_" .. string.format("%02d", timeTaken.hour) .. "-" .. string.format("%02d", timeTaken.minute) .. "-" .. string.format("%02d", timeTaken.second) .. ".jpeg"
		local newfile = fileCreate("/screenshots/" .. filename)
		if (newfile) then
			fileWrite(newfile, imageData)
			userData[accountName]["filename"] = filename
			fileFlush(newfile)
			fileClose(newfile)
			userData[accountName]["saved"] = true
			
			exports.GTIhud:dm("Screenshot taken. Uploading bug report...",source,0,255,0)
			uploadToServer()
		else
			--outputDebugString("Issue creating a new image onto system. File permissions?",1)
			exports.GTIhud:dm("Was unable to save screenshot. Please contact an administrator.",source,255,0,0)
			return
		end
	else
		exports.GTIhud:dm("Was unable to take screenshot, skipping the screenshot...", source, 255, 0, 0)
		userData[accountName]["status"] = "failed"
		return
	end
end
addEventHandler("onPlayerScreenShot", root, onScreenshotTaken)

function uploadToServer()
	for accName, datatable in pairs(userData) do
		if (datatable["saved"] and datatable["filename"]) then
			datatable["saved"] = nil
			datatable["status"] = nil
			if ( getAccountPlayer( getAccount(accName) ) ) then
				local player = getAccountPlayer( getAccount(accName) )
			end
			fetchRemote(url, theCallBack, toJSON(userData[accName]), false, accName, {userData[accName]['priority'], userData[accName]['exploitable']})
			screenshotsToDelete[datatable["filename"]] = getRealTime().minute
			userData[accName] = nil
		elseif (datatable["status"] == "failed") then
			userData[accName]["screenshot"] = false
			datatable["saved"] = nil
			datatable["status"] = nil
			if ( getAccountPlayer( getAccount(accName) ) ) then
				local player = getAccountPlayer( getAccount(accName) )
			end
			fetchRemote(url, theCallBack, toJSON(userData[accName]), false, accName)
			userData[accName] = nil
		end
	end
end
--setTimer(uploadToServer, 10000, 0)

function deleteSSs()
	for imgname, minute in pairs(screenshotsToDelete) do
		fileDelete("/screenshots/" .. imgname)
		screenshotsToDelete[imgname] = nil
	end
end
--setTimer(deleteSSs, 100000, 0)

addEventHandler("onResourceStart", root, 
	function(resource)
		if (getResourceName(resource) ~= "GTIirc" and resource ~= getThisResource()) then return end
		if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
		exports.GTIirc:ircRaw(exports.LilDolla:getIRCServer(), "JOIN "..QCA_CHAN)
	end
)