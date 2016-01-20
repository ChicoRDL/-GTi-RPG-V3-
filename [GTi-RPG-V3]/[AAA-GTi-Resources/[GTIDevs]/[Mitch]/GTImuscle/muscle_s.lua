----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 4 Oct 2015
-- Resource: muscle_s.lua
-- Version: 1.0
----------------------------------------->>

local weight = {}

addEvent ("GTImuscleStats", true )
addEventHandler ("GTImuscleStats", root,
    function ( text )
	    if isElement ( weight[client] ) then destroyElement ( weight[client] )
			pedStat = tonumber ( text )
			setPedStat ( client, 23, pedStat )
			exports.GTIhud:dm("Player body stats added to your CJ", client, 255, 150, 0)
			local acc = getPlayerAccount ( client )
            exports.GTIaccounts:SAD ( acc, "MuscleStat", tostring ( text ) )
		end
	end
)

addEvent ("GTImuscleAnim", true )
addEventHandler ("GTImuscleAnim", root,
    function ( )
	    exports.GTIanims:setJobAnimation ( client, "Freeweights", "gym_free_up_smooth", 60000, true, false, false, false )
	end
)

addEvent ("GTImuscleObject", true )
addEventHandler ("GTImuscleObject", root,
    function ( )
	    weight[client] = createObject ( 2913, 2168.279, 1099.348, 0, -90, 0, 0, true )
		exports.bone_attach:attachElementToBone( weight[client], client, 12, -0.2, -0.01, 0.1, 90, 90, 0 )
		setElementDimension ( weight[client], getElementDimension ( client ) )
	    setElementInterior ( weight[client], getElementInterior ( client ) )
	end
)

addEvent ("onPlayerQuitJob", true )

function loadPlayerStat ( irrelevant, account )
    local acc = getPlayerAccount ( source )
    local playerStat = tonumber ( exports.GTIaccounts:GAD ( acc, "MuscleStat" ) ) or 0
    setPedStat ( source, 23, playerStat )
end
addEventHandler ("onPlayerLogin", root, loadPlayerStat )
addEventHandler ("onPlayerQuitJob", root, loadPlayerStat )

addEvent ("GTImuscle_CancelTraining", true )
addEventHandler ("GTImuscle_CancelTraining", root,
	function ( )
		exports.GTIanims:setJobAnimation ( client, false )
		if isElement ( weight[client] ) then 
			destroyElement ( weight[client] )
		end
	end
)