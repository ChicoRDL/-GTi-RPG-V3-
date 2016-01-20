


--------------------------------
-- Switch effect on or off
--------------------------------
function switchPedWall( pwOn )
    if pwOn then
        enablePedWall()
    else
        disablePedWall()
    end
end

addEvent( "switchPedWall", true )
addEventHandler( "switchPedWall", resourceRoot, switchPedWall )
