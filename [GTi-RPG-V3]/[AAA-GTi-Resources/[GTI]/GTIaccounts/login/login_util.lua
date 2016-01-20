----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 01 Dec 2013
-- Resource: GTIaccounts/login_util.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Store Login Info
-------------------->>

function getLoginInfo()
	local xml = xmlLoadFile("@:GTIaccounts/login.xml")
	if (not xml) then return false end
	
	local xmlAccount = xmlFindChild(xml, "account", 0)
	if (not xmlAccount) then xmlUnloadFile(xml) return false end
	
	local username = xmlNodeGetAttribute(xmlAccount, "username")
	local password = xmlNodeGetAttribute(xmlAccount, "password")
	if (not username or not password) then xmlUnloadFile(xml) return false end
	
	xmlUnloadFile(xml)
	return username, password
end

function storeLoginInfo(username, password)
	local xml = xmlLoadFile("@:GTIaccounts/login.xml")
	if (not xml) then
		xml = xmlCreateFile("@:GTIaccounts/login.xml", "login")
	end
	
	local xmlAccount = xmlFindChild(xml, "account", 0)
	if (not xmlAccount) then
		xmlAccount = xmlCreateChild(xml, "account")
	end
	
	xmlNodeSetAttribute(xmlAccount, "username", username)
	xmlNodeSetAttribute(xmlAccount, "password", password)
	
	xmlSaveFile(xml)
	xmlUnloadFile(xml)
	return true
end

function deleteLoginInfo()
	return fileDelete("@:GTIaccounts/login.xml")
end

-- Register Panel
------------------>>

function getPasswordStrength(password)
	local letters = string.find(password, "%a")
	local numbers = string.find(password, "%d")
	local symbols = string.find(password, "%W")
	if (letters and numbers and symbols) then
		return "Strong"
	elseif ((letters and numbers) or (letters and symbols) or (numbers and symbols)) then
		return "Medium"
	elseif (letters or numbers or symbols) then
		return "Weak"
	end
end

-- Fetch Updates
----------------->>

addEventHandler("onClientResourceStart", resourceRoot, function()
	fetchRemote("http://mta.gtirpg.net/MTA/RawFile/updates.txt",
		function(responseData, errno)
			if (errno == 0) then
				local updates = string.sub(responseData, 1, 5000)
				guiSetText(login.label[1], updates)
				guiSetText(login.label[2], updates)
			end
		end
	)
end)
