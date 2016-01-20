local db = dbConnect( "sqlite", "contacts.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS contacts(account varchar(255), contactAccName varchar(255), status varchar(255))")

local temp = {}
local temp2 = {}
function addContact(contact,status)
	if not isElement(contact) or ( client == contact ) then return end
    local account = getPlayerAccount(client)
	if isPlayerInContactList(client,contact) then return end
	local contactacc = getPlayerAccount(contact)
	if isGuestAccount(account) or isGuestAccount(contactacc) then return end
	local accountname = getAccountName(account)
	local contactaccname = getAccountName(contactacc)
	if accountname and contactaccname and status then
		dbExec( db, "INSERT INTO contacts(`account`, `contactAccName`, `status`) VALUES (?,?,?)", accountname, contactaccname, status)
		getContactslogin(client,account)
	end
end
addEvent ( "GTIcontactsApp.addContact", true )
addEventHandler ( "GTIcontactsApp.addContact", root, addContact )

function addFriend(accn1,accn2)
	local acc1 = getAccount(accn1)
	local acc2 = getAccount(accn2)
	if isGuestAccount(acc1) or isGuestAccount(acc2) then return end
	local plr2 = getAccountPlayer(acc2)
	local plr1 = getAccountPlayer(acc1)
	if isAccInContactList(acc1,acc2) then
		dbExec( db, "UPDATE contacts SET status=? WHERE contactAccName=? AND account=?", "Friend", accn2, accn1)
	else
		dbExec( db, "INSERT INTO contacts(account, contactAccName, status) VALUES (?,?,?)", accn1, accn2, "Friend")
	end
	if isAccInContactList(acc2,acc1) then
		dbExec( db, "UPDATE contacts SET status=? WHERE contactAccName=? AND account=?", "Friend", accn1, accn2)
	else
		dbExec( db, "INSERT INTO contacts(account, contactAccName, status) VALUES (?,?,?)", accn2, accn1, "Friend")
	end
	if isElement(plr1) then
		getContactslogin(plr1,acc1)
	end
	if isElement(plr2) then
		getContactslogin(plr2,acc2)
	end
end

		
function getContactslogin(plr,acc)
	if isGuestAccount(acc) or not isElement(plr) then return end
    local accname = getAccountName(acc)
    local pollquery = dbPoll(dbQuery( db, "SELECT * FROM contacts WHERE account=?", accname),-1)
	temp[plr] = {}
    for i = 1,#pollquery do
		local contactacc = getAccount(pollquery[i].contactAccName)
		if contactacc then
			local contactname = exports.GTIaccounts:invGet(contactacc, "GTIcontactsApp.nick") or exports.GTIaccounts:GAD(contactacc,"lastname")
			local lastlogin = exports.GTIaccounts:GAD(contactacc,"lastLogin")
			table.insert(temp[plr],{contactname,pollquery[i].status,pollquery[i].contactAccName,lastlogin})
		end
	end
	triggerClientEvent(plr, "GTIcontactsApp.recieveContacts", resourceRoot, temp[plr])
	temp[plr] = nil
end

function getContacts()
	local acc = getPlayerAccount(client)
	if isGuestAccount(acc) then return end
    local accname = getAccountName(acc)
    local pollquery = dbPoll(dbQuery( db, "SELECT * FROM contacts WHERE account=?", accname),-1)
	temp[client] = {}
    for i = 1,#pollquery do
		local contactacc = getAccount(pollquery[i].contactAccName)
		if contactacc then
			local contactname = exports.GTIaccounts:invGet(contactacc, "GTIcontactsApp.nick") or exports.GTIaccounts:GAD(contactacc,"lastname")
			local lastlogin = exports.GTIaccounts:GAD(contactacc,"lastLogin")
			table.insert(temp[client],{contactname,pollquery[i].status,pollquery[i].contactAccName,lastlogin})
		end
	end
	triggerClientEvent(client, "GTIcontactsApp.recieveContacts", resourceRoot, temp[client])
	temp[client] = nil
end
addEvent ( "GTIcontactsApp.getContacts", true )
addEventHandler ( "GTIcontactsApp.getContacts", root, getContacts )

function changeStatus(contactacc,status)
	local acc = getPlayerAccount(client)
	if isGuestAccount(acc) then return end
    local accname = getAccountName(acc)
	local cacc = getAccount(contactacc)
    dbExec( db, "UPDATE contacts SET status=? WHERE contactAccName=? AND account=?", status, contactacc, accname)
	if getAccStatus(cacc,acc) == "Friend" and status ~= "Friend" then
		changeStatusFriend(accname,contactacc)
	end
end
addEvent ( "GTIcontactsApp.changeStatus", true )
addEventHandler ( "GTIcontactsApp.changeStatus", root, changeStatus )

function changeStatusFriend(accname,contactacc,status)
    dbExec( db, "UPDATE contacts SET status=? WHERE contactAccName=? AND account=?", "Neutral", accname, contactacc)
	local cacc = getAccount(contactacc)
	local plr = getAccountPlayer(cacc)
	if isElement(plr) then
		getContactslogin(plr,cacc)
	end
end

function deleteContact(contactacc)
	local acc = getPlayerAccount(client)
	local cacc = getAccount(contactacc)
	if isGuestAccount(acc) then return end
    local accname = getAccountName(acc)
    dbExec( db, "DELETE FROM contacts WHERE contactAccName=? AND account=?", contactacc, accname)
	if getAccStatus(cacc,acc) == "Friend" then
		changeStatusFriend(accname,contactacc)
	end
end
addEvent ( "GTIcontactsApp.deleteContact", true )
addEventHandler ( "GTIcontactsApp.deleteContact", root, deleteContact )


----------exports
-------------------->
function isPlayerInContactList(player,contact)
	if not isElement(player) or not isElement(contact) then return false end
	local acc = getPlayerAccount(player)
	local contactacc = getPlayerAccount(contact)
	if isGuestAccount(acc) or isGuestAccount(contactacc) then return end
    local accname = getAccountName(acc)
	local contactaccname = getAccountName(contactacc)
    local pollquery = dbPoll(dbQuery( db, "SELECT status FROM contacts WHERE contactAccName=? AND account=?", contactaccname, accname),-1)
	if #pollquery == 0 then
		return false
	else 
		return true
	end
end
function isAccInContactList(acc,contactacc)
	if isGuestAccount(acc) or isGuestAccount(contactacc) then return end
    local accname = getAccountName(acc)
	local contactaccname = getAccountName(contactacc)
    local pollquery = dbPoll(dbQuery( db, "SELECT status FROM contacts WHERE contactAccName=? AND account=?", contactaccname, accname),-1)
	if #pollquery == 0 then
		return false
	else 
		return true
	end
end
function getContactStatus(player,contact)
	if not isElement(player) or not isElement(contact) then return false end
	local acc = getPlayerAccount(player)
	local contactacc = getPlayerAccount(contact)
	if not acc or not contactacc then return end
	if isGuestAccount(acc) or isGuestAccount(contactacc) then return end
    local accname = getAccountName(acc)
	local contactaccname = getAccountName(contactacc)
    local pollquery = dbPoll(dbQuery( db, "SELECT status FROM contacts WHERE contactAccName=? AND account=?", contactaccname, accname),-1)
	if #pollquery == 0 then
		return false
	else 
		return pollquery[1].status
	end
end
function arePlayersFriend(plr1,plr2)
	if (getContactStatus(plr1,plr2) == "Friend") and (getContactStatus(plr2,plr1) == "Friend") then
		return true
	else
		return false
	end
end
function getAccStatus(acc,contactacc)
	if isGuestAccount(acc) or isGuestAccount(contactacc) then return end
    local accname = getAccountName(acc)
	local contactaccname = getAccountName(contactacc)
    local pollquery = dbPoll(dbQuery( db, "SELECT status FROM contacts WHERE contactAccName=? AND account=?", contactaccname, accname),-1)
	if #pollquery == 0 then
		return false
	else 
		return pollquery[1].status
	end
end

function getOnlineFriends(player)
	if not isElement(player) then return {} end
	local acc = getPlayerAccount(player)
    local accname = getAccountName(acc)
    local pollquery = dbPoll(dbQuery( db, "SELECT * FROM contacts WHERE account=?", accname),-1)
	temp2[player] = {}
    for i = 1,#pollquery do
		if pollquery[i].status == "Friend" then
			local contactacc = getAccount(pollquery[i].contactAccName)
			local contact = getAccountPlayer(contactacc)
			if isElement(contact) then
				table.insert(temp2[player],contact)
			end
		end
	end
	return temp2[player]
end

-- For Ignoring Players
------------------------>>

function isPlayerBlocked(player, contact)
	return getContactStatus(player, contact) == "Blocked" or false
end	
