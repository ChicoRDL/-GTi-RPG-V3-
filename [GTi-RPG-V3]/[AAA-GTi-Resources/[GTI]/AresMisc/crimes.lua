local empl = exports.GTIemployment

function isAbleToCrime ( player )
	assert ( isElement ( player ) and getElementType ( player ) == "player", "Bad argument 1 @ isAbleToCrime [player expected, got " .. tostring(player) .. "]" )
	return not empl:getPlayerJob(player) or empl:getPlayerJob(player) == "Criminal"
end
