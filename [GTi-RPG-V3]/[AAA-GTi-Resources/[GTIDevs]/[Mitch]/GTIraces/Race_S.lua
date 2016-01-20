rewards = 
{
[1]=8000,
[2]=10,
[3]=1000
}

function getCurrentDate()
	local timeTable = getRealTime()
	return timeTable["month"].."/"..timeTable["monthday"].." "..timeTable["hour"]..":"..timeTable["minute"]
end

function onPlayerQuit ()
	if racers and racers[source] then	
		for i=1,#racers do
			if source == racers[i] then
				table.remove ( racers, i )
			end
		end
	end
end
addEventHandler ( "onPlayerQuit", root, onPlayerQuit )

local signedUpPlayers
local signUpTrack
local signUpIsIllegal
local signUpBlip
local signUpMarker
local stopRaceToSignUpDelay = 300000 -- 15 minutes
local signUpToStartDelay = 360000 -- 6 minutes
local signUpToStartDelaySecondAttempt = 120000 -- 2 minutes
local signUpEndTimer
local signUpTimer

function formatTime(miliSeconds)
	if miliSeconds >= 60000 then
		local plural = ''
			if math.floor((miliSeconds/1000)/60) >= 2 then
				plural = 's'
			end	
		return tostring(math.floor((miliSeconds/1000)/60) .. " minute" .. plural)
	else
		local plural = ''
		if math.floor((miliSeconds/1000)) >= 2 then
			plural = 's'
		end	
		return tostring(math.floor((miliSeconds/1000)) .. " second" .. plural)
	end
end

function raceTime(pSource)
	if isTimer ( signUpTimer ) then 
		local timeLeft, executeLeft, executeTotal = getTimerDetails ( signUpTimer ) 
		local timeLeft = formatTime(timeLeft)
		exports.GTIhud:dm ( tostring( timeLeft ).." left before sign-up starts.", pSource, 0, 255, 0 )
	elseif isTimer ( signUpEndTimer ) then 
		local timeLeft, executeLeft, executeTotal = getTimerDetails ( signUpEndTimer ) 
		local timeLeft = formatTime(timeLeft)
		exports.GTIhud:dm ( tostring ( timeLeft ).." left before sign-up ends.", pSource, 0, 255, 0 )
	elseif racers then
		exports.GTIhud:dm ( "There is a race going on right now!", pSource, 0, 255, 0 )
	end
end
addCommandHandler ( "racetime", raceTime, false, false )

function startRaceSignUp()
	if signingUp or racers then return end
	local fileList
	local tracksTable
	if fileExists ( "tracks\\tracklist.txt" ) then
		fileList = fileOpen ( "tracks\\tracklist.txt" )
	end
	if fileList then
		tracksTable = fromJSON ( fileRead ( fileList, fileGetSize ( fileList ) ) )
		fileClose ( fileList )
		local newTrack = tracksTable[math.random(1,#tracksTable)][1]
		if newTrack == signUpTrack then
			repeat newTrack = tracksTable[math.random(1,#tracksTable)][1]		
			until newTrack ~= signUpTrack
		end
		signUpTrack = newTrack
		if signUpTrack and fileExists( "tracks\\"..signUpTrack..".track") then
			local trackFile = fileOpen( "tracks\\"..signUpTrack..".track")
			local trackDataTable = fromJSON ( fileRead ( trackFile, fileGetSize ( trackFile ) ) )
			fileClose ( trackFile )
			local startX, startY, startZ = trackDataTable[1][1], trackDataTable[1][2], trackDataTable[1][3]
			local x2, y2, z2 = trackDataTable[2][1], trackDataTable[2][2], trackDataTable[2][3]
			signUpMarker = createMarker ( startX, startY, startZ-1, "checkpoint", 7.5, 0, 0, 255, 130 )
			setMarkerTarget ( signUpMarker, x2, y2, z2 )
			signUpBlip = createBlipAttachedTo ( signUpMarker, 53 )
			signingUp = true
			signUpIsIllegal = math.random ( 0, 3 ) == 1
			signedUpPlayers = {}
			addEventHandler ( "onMarkerHit", signUpMarker, onSignUpMarkerHit, false )
			signUpEndTimer = setTimer ( onSignUpEnd, signUpToStartDelay, 1 )
			local announceMessage = "A new street race has been planned, you can signup at the race flag blip."
			if signUpIsIllegal then
				announceMessage = "A new illegal street race has been planned, you can signup at the race flag blip."
			end
			for i=1, #getElementsByType ( "player" ) do
				exports.GTIhud:dm ( announceMessage, getElementsByType ( "player" )[i], 0, 255, 0 )
			end		
		end
	end
end
-- Ignore this ^_^
copTeams = { ["Terrorits"]=true, ["National Guard"]=true }

function onSignUpMarkerHit( hitElement )
	if getElementType ( hitElement ) == "player" then
		if not getElementData ( hitElement, "race_isSignedUp" ) then
			if getPedOccupiedVehicle ( hitElement ) then
				if getVehicleController ( getPedOccupiedVehicle ( hitElement ) ) == hitElement then
					local playerTeamName = getTeamName ( getPlayerTeam( hitElement ) )
					if not copTeams[playerTeamName] then
						table.insert ( signedUpPlayers, hitElement ) 
						exports.GTIhud:dm ( "You succesfully signed up! Use /racetime to check the timer", hitElement, 0, 255, 0 )
						-- toggleControl ( hitElement, "enter_exit", false )
						setElementData ( hitElement, "race_isSignedUp", true )
					else
						exports.GTIhud:dm ( "Law can't sign up for a street race!", hitElement, 255, 0, 0 )
					end
				end
			else
				exports.GTIhud:dm ( "You need a vehicle to sign up!", hitElement, 255, 0, 0 )
			end
		end
	end
end

function onSignUpEnd()
	if #signedUpPlayers >= 2 then
		destroyElement ( signUpBlip )
		destroyElement ( signUpMarker )
		startRacePre ( signUpTrack, signUpIsIllegal, true, false )
	else
		destroyElement ( signUpBlip )
		destroyElement ( signUpMarker )
		signingUp = false
		for i=1, #signedUpPlayers do
			if isElement ( signedUpPlayers[i] ) then
				setElementData ( signedUpPlayers[i], "race_isSignedUp", false )
				toggleControl ( signedUpPlayers[i], "enter_exit", true )
				exports.GTIhud:dm ( "There were not enough players to start the race!", signedUpPlayers[i], 255, 0, 0 )
			end
		end
		signedUpPlayers = false
		startRaceSignUp()
	end
end

function getSignedUpPlayers ()
	local newSignedUpPlayers = {}
	local signUpDis
	for i=1, #signedUpPlayers do
		if isElement ( signedUpPlayers[i] ) then
			if not isPedDead ( signedUpPlayers[i] ) and getPedOccupiedVehicle ( signedUpPlayers[i] ) and getVehicleController ( getPedOccupiedVehicle ( signedUpPlayers[i] ) ) == signedUpPlayers[i] then
				local playerTeamName = getTeamName ( getPlayerTeam( signedUpPlayers[i] ) )
				if not copTeams[playerTeamName] then						
					table.insert ( newSignedUpPlayers, signedUpPlayers[i] )
				end
			end
			setElementData ( signedUpPlayers[i], "race_isSignedUp", false )
		end
	end
	return newSignedUpPlayers
end
addEvent ( "server_startRace", true )

function startRacePre ( trackName, illegal, useNos, damageProof )
	if racers then return end
	if fileExists ( "tracks\\"..trackName..".track" ) then
		firstReward = rewards[1]
		secondReward = rewards[2]
		thirdReward = rewards[3]
		if illegal then
			firstReward = firstReward * 1.4
			secondReward = secondReward * 1.4
			thirdReward = thirdReward * 1.4	
		end	
		setElementData ( root, "raceStarted", true ) 
		raceTrackName = trackName
		local trackDataFile = fileOpen ( "tracks\\"..trackName..".track" )
		fileSetPos ( trackDataFile, 0 )
		local trackDataSealed = fileRead ( trackDataFile, fileGetSize ( trackDataFile ) )
		trackData = fromJSON ( trackDataSealed )
		fileClose ( trackDataFile )	
		racers = getSignedUpPlayers()
		finishedRacers = {}
		--local startingX, startingY, startingZ = trackData[1][1], trackData[1][2], trackData[1][3]+1
		local lineCars = 0
		for i=1, #racers do
			setElementData ( racers[i], "race_isFinished", false ) 
			triggerClientEvent ( racers[i], "startPreRace", racers[i], trackName, trackDataSealed, racers )
			if illegal then 
				--exports.server:givePlayerWantedPoints(racers[i], 10)
			end
			setTimer ( 
			function ()
				if racers then
					setCameraTarget ( racers[i], racers[i] )
					local pVehicle = getPedOccupiedVehicle ( racers[i] )
					if not pVehicle then return end
					fixVehicle( pVehicle )
					setVehicleDamageProof ( pVehicle, damageProof )
					if useNos then
						local vehHasNos = false
						local upgrades = getVehicleUpgrades(pVehicle)
						for i,upgrade in ipairs(upgrades) do
							if upgrade == 1010 or upgrade == 1009 or upgrade == 1008 then
								vehHasNos = true	
							end
						end
						if not vehHasNos then
							addVehicleUpgrade ( pVehicle, 1010 )
						end
					end
				end
			end
			, 1350, 1 )
		end
		setElementData ( root, "race_countdown", false ) 
		startCountDownTimer = setTimer ( startRaceCountdown, 4000, 1 )
	end
end
addEventHandler ( "server_startRace", root, startRacePre )

function startRaceCountdown()
	if racers then
		countdownTime = 5
		countdownGoDisplayTime = 2
		setElementData ( root, "race_countdown", countdownTime ) 
		countDownTimer = setTimer ( 
		function () 
			if racers then
				countdownTime = countdownTime - 1
				if countdownTime == 0 then
					if not raceStarted then		
						startRace ()			
					end		
					setTimer ( setElementData, countdownGoDisplayTime*1000, 1, root, "race_countdown", false  )
				end	
				setElementData ( root, "race_countdown", countdownTime ) 		
			end	
		end, 1000, countdownTime + 1 )	
	end
end

function startRace ()
	raceStartTicks = getTickCount ()
	for i=1, #racers do
		setElementFrozen  ( racers[i], false )
		setElementFrozen  ( getPedOccupiedVehicle ( racers[i] ) or racers[i], false )
		triggerClientEvent ( racers[i], "startRace", racers[i], raceStartTicks )
	end
	raceStarted = true
	addEventHandler ( "onNFSPlayerFinish", root, onNFSPlayerFinish )
end
addEvent ( "onNFSPlayerFinish", true )

positions = 
{
[1]="st",
[2]="nd",
[3]="rd"

}

function onNFSPlayerFinish ()
	table.insert ( finishedRacers, source )
	-- Money
	exports.GTIbank:GPM(source, firstReward, "Race Money")
	exports.GTIstats:modifyStatData ( getPlayerAccount ( source ), "races_won", 1 )
	notifyRacersOf(getPlayerName(source).." came in first earning $"..firstReward.." and ending the race." )
	stopRace()
end
addEvent ( "server_stopRace", true )

function notifyRacersOf(message)
	for i=1, #racers do
		if isElement(racers[i]) then	
			exports.GTIhud:dm ( message, racers[i], 0, 255, 0 )			
		end		
	end
end

function stopRace( onShutDown )
	if racers then
		for i=1, #racers do	
			setElementData ( racers[i], "race_isFinished", false ) 
			setElementData ( racers[i], "race_isSignedUp", false ) 
			if isElement ( racers[i]) then		
				if not onShutDown then triggerClientEvent ( racers[i], "stopRace", racers[i] ) end		
			end	
		end
		setElementData ( root, "raceStarted", false ) 
		racers = nil
		raceTrackName = nil
		raceStarted = nil
		finishedRacers = nil
		signingUp = false
		removeEventHandler ( "onNFSPlayerFinish", root, onNFSPlayerFinish )
		if isTimer ( startCountDownTimer ) then killTimer ( startCountDownTimer ) end
		if isTimer ( countDownTimer ) then killTimer ( countDownTimer ) end
		setElementData ( root, "race_countdown", false ) 
		signUpTimer = setTimer ( startRaceSignUp, stopRaceToSignUpDelay, 1 )	
	end
end
addEventHandler ( "onResourceStop", resourceRoot, function () stopRace(true) end )
addEventHandler ( "onResourceStart", resourceRoot, startRaceSignUp )
addEventHandler ( "server_stopRace", root, function () stopRace(false) end )
