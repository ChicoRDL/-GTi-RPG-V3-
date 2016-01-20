--[[addEvent ("GTIbriefCase_ghostModeOn", true )
addEventHandler ("GTIbriefCase_ghostModeOn", root,
    function ( player )
                --setElementCollidableWith ( vehicle, localPlayer, false )
                for index,vehicle in ipairs(getElementsByType("vehicle")) do --LOOP through all Vehicles
                    setElementCollidableWith(player, vehicle, false) -- Set the Collison off with the Other vehicles.
                    end
    end
)

addEvent ("GTIbriefCase_ghostModeOff", true )
addEventHandler ("GTIbriefCase_ghostModeOff", root,
    function ( )
        for index,vehicle in ipairs ( getElementsByType ("vehicle") ) do
            setElementCollidableWith ( vehicle, localPlayer, true )
        end
    end
)--]]