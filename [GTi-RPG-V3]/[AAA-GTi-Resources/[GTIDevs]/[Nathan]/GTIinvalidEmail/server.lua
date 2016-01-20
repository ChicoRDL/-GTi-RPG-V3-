function setEmail(player, email)
	exports.GTIaccounts:SAD(getPlayerAccount(client), "email", email)
	exports.GTIhud:dm("Your email has been set to " .. email, client, 0, 255, 0)
end
addEvent("setEmail", true)
addEventHandler("setEmail", resourceRoot, setEmail)

function init(_, account)
	local emailOnAccount = exports.GTIaccounts:GAD(account, "email")
	if not emailOnAccount or emailOnAccount == "" then
		triggerClientEvent(source, "initClient", source)
	end
end
addEventHandler("onPlayerLogin",root,init)
