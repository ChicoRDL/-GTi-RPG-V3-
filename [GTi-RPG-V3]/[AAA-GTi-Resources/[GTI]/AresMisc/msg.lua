function cancelPM()
	cancelEvent()
	exports.GTIhud:dm("This command has been disabled. Use GTIdroid instead.",source,255,0,0)
end
addEventHandler("onPlayerPrivateMessage",root,cancelPM)

