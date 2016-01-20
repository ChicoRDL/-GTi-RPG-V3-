addEvent ("MitchMiscGhostOn", true )
addEventHandler ("MitchMiscGhostOn", root,
    function ( )
        exports.GTIutil:setPlayerGhost ( client, true )
    end
)

addEvent ("MitchMiscGhostOff", true )
addEventHandler ("MitchMiscGhostOff", root,
    function ( )
        exports.GTIutil:setPlayerGhost ( client, false )
    end
)