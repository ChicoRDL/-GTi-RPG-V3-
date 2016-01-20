addEventHandler("onClientResourceStart", root,
	function (res)
		if ( getResourceName(res) == "GTIemployment" or source == resourceRoot ) then
			function isAbleToCrime ( player )
				assert ( isElement ( player ) and getElementType ( player ) == "player", "Bad argument 1 @ isAbleToCrime [player expected, got " .. tostring(player) .. "]" )
				return not exports.GTIemployment:getPlayerJob() or exports.GTIemployment:getPlayerJob() == "Criminal"
			end
		end
	end
)
