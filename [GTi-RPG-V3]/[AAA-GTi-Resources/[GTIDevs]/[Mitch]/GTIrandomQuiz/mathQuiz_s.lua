----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local timerfrom, timerto = 6, 12
local MathTimeInSec = 30
local maxNum = 100
local prizefrom, prizeto = 500, 2000
local MathOn = false
local theAns = nil
local thePrize = nil
local MathTime = MathTimeInSec * 1000

function createCode ( theQuiz, theAns, prize )
	outputChatBox ("* Math Quiz: First one to answer "..theQuiz.." wins #00CD00$"..prize, root, 255, 0, 0, true )
	startCodeTimer ( )
	MathOn = true
	theAns = theAns
	theQuiz = theQuiz
end

function makeRandomCode ( Math, Prize )
	if ( Math and Prize ) then
		theAns = Math
		thePrize = Prize
	else
		theQuiz,theAns =  makeMath ( maxNum )
		thePrize = math.random ( prizefrom, prizeto )
	end
	if ( tostring ( theAns ) and tostring ( theQuiz ) and tonumber ( thePrize ) ) then
		createCode( theQuiz, theAns, thePrize )
	end
end

function startCodeTimer ( )
	codeTimer = setTimer ( function ( )
		removeCode ( )
		outputChatBox ("* Math Quiz: No one answered in time.", root, 255, 0, 0, true )
	end , MathTime , 1 )
end

addEventHandler ("onResourceStop", resourceRoot, function ( )
	removeCode ( )
end )

function removeCode ( )
	if isTimer ( codeTimer ) then
		killTimer ( codeTimer )
	end
	theAns = nil
	thePrize = nil
	theQuiz = nil
	MathOn = false
end

function makeMath ( maxNum )
	local num1 = math.floor ( math.random ( maxNum ) )
	local num2 = math.floor ( math.random ( maxNum ) )
	if tonumber ( num1 ) and tonumber ( num2 ) then
		local random = math.floor ( math.random ( 1, 3 ) )
		if random == 1 then
			theAns = tonumber ( num1 ) + tonumber ( num2 )
			theQuiz = ""..tonumber ( num1 ).." + "..tonumber ( num2 )..""
		elseif random == 2 then
			theAns = tonumber ( num1 ) - tonumber ( num2 )
			theQuiz = ""..tonumber ( num1 ).." - "..tonumber ( num2 )..""
		elseif random == 3 then
			theAns = tonumber ( num1 ) * tonumber ( num2 )
			theQuiz = ""..tonumber ( num1 ).." * "..tonumber ( num2 )..""
		end
		if theAns and theQuiz then
			return theQuiz,theAns
		end
	end
end

function detcetChatMessage ( msg, msgtype )
	if ( MathOn == true and msg and msgtype == 0 ) then
		if tonumber ( msg ) == tonumber ( theAns ) then
			onPlayerWin ( source )
		end
	end
end
addEventHandler ("onPlayerChat", root, detcetChatMessage )

function onPlayerWin ( player )
	outputChatBox ("* Math Quiz: "..getPlayerName ( player ).." has answered "..theAns.." and won the Quiz.", root, 255, 0, 0, true )
	exports.GTIbank:GPM ( player, thePrize, "Random Quiz payment")
	removeCode ( )
end

function setRandomTimer ( )
	setTimer( function ( )
		if not MathOn then
			makeRandomCode ( )
		end
			setRandomTimer ( )
	end , math.random ( timerfrom, timerto ) * 60 * 1000 , 1 )
end

addEventHandler ("onResourceStart", resourceRoot, function ( ) setRandomTimer ( ) end )