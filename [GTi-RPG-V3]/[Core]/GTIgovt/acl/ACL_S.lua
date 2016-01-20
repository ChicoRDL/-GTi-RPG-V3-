----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 18 July 2015
-- Resource: GTIadmin/acl/acl.slua
-- Version: 1.0
----------------------------------------->>

-- Compose Ban List
-------------------->>
addEvent("GTIgovtPanel.getACLs", true)
addEventHandler("GTIgovtPanel.getACLs", root, function()
	local acls = aclGroupList()
	aclsCache = {}

	for index, acls in ipairs(acls) do
		aclsCache [ aclGroupGetName ( acls ) ] = aclGroupListObjects(acls)
	end

	triggerClientEvent(client, "GTIgovtPanel.composeAclList", resourceRoot, aclsCache)
end)

addEvent("GTIgovtPanel.getObjectInfo", true)
addEventHandler("GTIgovtPanel.getObjectInfo", root, function(account)
	if ( not getAccount ( account ) ) then return false end
		local last_active = exports.GTIaccounts:GAD ( getAccount(account), "lastLogin" ) or getTickCount()
		local last_name = exports.GTIaccounts:GAD ( getAccount(account), "lastname")
		triggerClientEvent(client, "GTIgovtPanel.composeObjectInfo", resourceRoot, {last_active, last_name} )
end)

addEvent("GTIgovtPanel.addToACL", true)
addEventHandler("GTIgovtPanel.addToACL", root, function (acl, acc)
	if ( aclGetGroup ( acl ) and not isObjectInACLGroup ( "user."..acc, aclGetGroup ( acl ) ) ) then
		if ( getAccount(acc) ) then
			aclGroupAddObject ( aclGetGroup ( acl ), "user."..acc )
			outputChatBox("ADMIN: You have succesfully added the account '"..acc.."' to the "..acl.. " ACL.", client, 0, 255, 0)
			triggerClientEvent(client, "GTIgovtPanel.clientGetACLs", client)
		else
			outputChatBox("ADMIN: The account '"..acc.."' does not exist", client, 255, 0, 0)
		end
	else
		outputChatBox("ADMIN: This player is already in the '"..acl.."' ACL.", client, 255, 0, 0)
	end
end)

addEvent("GTIgovtPanel.removeFromACL", true)
addEventHandler("GTIgovtPanel.removeFromACL", root, function (acl, acc)
	if ( aclGetGroup ( acl ) and isObjectInACLGroup ( "user."..acc, aclGetGroup( acl ) ) ) then
		aclGroupRemoveObject ( aclGetGroup ( acl ) , "user."..acc )
		outputChatBox("ADMIN: You have succesfully removed the account '"..acc.."' from the "..acl.. " ACL.", client, 0, 255, 0)
		triggerClientEvent(client, "GTIgovtPanel.clientGetACLs", client)
	else
		outputChatBox("ADMIN: This player is not in the '"..acl.."' ACL.", client, 255, 0, 0)
	end
end)

addEvent("GTIgovtPanel.checkACLPerm", true)
addEventHandler("GTIgovtPanel.checkACLPerm", root, function(player)
	if (exports.GTIutil:isPlayerInACLGroup(player, "Admin5", "Dev5", "Dev4")) then
		triggerClientEvent("GTIgovtPanel.tabsDisable", player, player, "Admin")
	end

	if (exports.GTIutil:isPlayerInACLGroup(player, "QCA5", "Dev5", "Dev4")) then
		triggerClientEvent("GTIgovtPanel.tabsDisable", player, player, "QCA")	
	end
	if (exports.GTIutil:isPlayerInACLGroup(player, "Arch5", "Dev5", "Dev4")) then
		triggerClientEvent("GTIgovtPanel.tabsDisable", player, player, "Arch")
	end
end)