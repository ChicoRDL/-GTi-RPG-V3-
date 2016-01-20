local errors = {
	[1002] = "Download aborted",
	[1003] = "Download failed to initialize",
	[1004] = "Invalid URL",
	[1005] = "Unable to connect to URL",
	[1006] = "URL not allowed",
	[1007] = "Unknown file error",
}

function getHTTPError(number)
	if not (number) then return "Unknown error" end
	
	if (number >= 89) then
		return "Unknown cURL error"
	elseif (number >= 400 and number <= 599) then
		return "Unknown HTTP error"
	else
		return errors[number] or "Unknown"
	end
end