local guiEnabled = get("gui_enabled")
local snowToggle = get("snow_toggle")

addEvent("onClientReady",true)
addEventHandler("onClientReady",root,function()
	triggerClientEvent(client,"triggerGuiEnabled",client,guiEnabled,snowToggle)
end)


function helpOnLoginMsgs ( )
	outputChatBox ("Christmas: To enable the snow texture use /groundsnow", source, 0, 255, 0 )
	outputChatBox ("Christmas: To enable the snow use /snow", source, 0, 255, 0 )
	--outputChatBox ("Christmas: To enable clouds use /clouds", source, 0, 255, 0 )
	outputChatBox ("Christmas: groundsnow doesn't work properly when Detail Shader is enabled!", source, 0, 255, 0 )
end
addEventHandler ("onPlayerLogin", root, helpOnLoginMsgs )

function helpOnStartMsgs ( )
	outputChatBox ("Christmas: To enable snow texture use /groundsnow", root, 0, 255, 0 )
	outputChatBox ("Christmas: To enable snow use /snow", root, 0, 255, 0 )
	--outputChatBox ("Christmas: To enable clouds use /clouds", root, 0, 255, 0 )
	outputChatBox ("Christmas: groundsnow doesn't work properly when Detail Shader is enabled!", root, 0, 255, 0 )
end
addEventHandler ("onResourceStart", resourceRoot, helpOnStartMsgs )