local cookie = xmlLoadFile("cookie.xml")
if cookie then
	outputDebugString("Cookie loaded!")
end

function getCookieOption (key)
	if cookie then
		local child = xmlFindChild(cookie,key,0)
		if child then
			return xmlNodeGetValue(child)
		else
			return false
		end
	else
		createCookie()
		return getCookieOption(key)
	end
end

function setCookieOption (key,value)
	if cookie then
		local child = xmlFindChild(cookie,key,0)
		if not child then
			child = xmlCreateChild(cookie,key)
		end
		if xmlNodeSetValue(child,value) then
			return xmlSaveFile(cookie)
		else
			return false
		end
	else
		createCookie()
		return setCookieOption(key,value)
	end
end

function createCookie ()
	outputDebugString("New cookie created!")
	cookie = xmlCreateFile("cookie.xml","cookie")
	return xmlSaveFile(cookie)
end