addEvent("GTIdriverlock.sound", true)
addEventHandler("GTIdriverlock.sound", root, function(sound,veh)
if not isElement(veh) then return end
local x,y,z = getElementPosition(veh)
if sound == "locked" then
playSFX3D("script", 113, 0, x, y, z)
elseif sound == "lock" then
playSound3D("lock.mp3", x, y, z)
elseif sound == "unlock" then
playSound3D("unlock.mp3", x, y, z)
end
end )