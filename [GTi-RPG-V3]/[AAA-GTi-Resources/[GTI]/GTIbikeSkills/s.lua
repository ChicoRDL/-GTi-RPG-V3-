local db = dbConnect( "sqlite", "skills.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS skills(account varchar(255), stats varchar(255))")

function setSkills(skills)
	if type(skills) ~= "number" then return end
    local account = getPlayerAccount(client)
	if isGuestAccount(account) then return end
	local accname = getAccountName(account)
	if isAccInDB(accname) then
		dbExec( db, "UPDATE skills SET stats=? WHERE account=?", skills, accname)
	else
		dbExec( db, "INSERT INTO skills VALUES (?,?)", accname, skills)
	end
	setPedStat(client,229,skills)
	setPedStat(client,230,tonumber(skills))
end
addEvent("GTIBikeSkills.setSkills",true)
addEventHandler("GTIBikeSkills.setSkills",root,setSkills)

function isAccInDB(account)
	local pollquery = dbPoll(dbQuery( db, "SELECT * FROM skills WHERE account=?", account),-1)
	if #pollquery == 0 then
		return false
	else
		return true
	end
end

function getSkills(_,account)
	if isGuestAccount(account) then return end
	local accname = getAccountName(account)
	local pollquery = dbPoll(dbQuery( db, "SELECT stats FROM skills WHERE account=?", accname),-1)
	if #pollquery > 0 then
		if tonumber(pollquery[1].stats) > 999 then pollquery[1].stats = 999 end
		local skills = pollquery[1].stats
		triggerClientEvent(source,"GTIBikeSkills.setClient",resourceRoot,tonumber(skills))
		setPedStat(source,229,tonumber(skills))
		setPedStat(source,230,tonumber(skills))
	else
		triggerClientEvent(source,"GTIBikeSkills.setClient",resourceRoot,0)
		setPedStat(source,229,0)
		setPedStat(source,230,0)
	end
end
addEventHandler("onPlayerLogin",root,getSkills)

function getSkillsOnStart()
	setTimer(function()
	for i,plr in pairs(getElementsByType("player")) do
		local account = getPlayerAccount(plr)
		if isGuestAccount(account) then return end
		local accname = getAccountName(account)
		local pollquery = dbPoll(dbQuery( db, "SELECT stats FROM skills WHERE account=?", accname),-1)
		if #pollquery > 0 then
			if tonumber(pollquery[1].stats) > 999 then pollquery[1].stats = 999 end
			local skills = pollquery[1].stats
			triggerClientEvent(plr,"GTIBikeSkills.setClient",resourceRoot,tonumber(skills))
			setPedStat(plr,229,tonumber(skills))
			setPedStat(plr,230,tonumber(skills))
		else
			triggerClientEvent(plr,"GTIBikeSkills.setClient",resourceRoot,0)
			setPedStat(plr,229,0)
			setPedStat(plr,230,0)
		end
	end
end,1000,1)
end
addEventHandler("onResourceStart",resourceRoot,getSkillsOnStart)