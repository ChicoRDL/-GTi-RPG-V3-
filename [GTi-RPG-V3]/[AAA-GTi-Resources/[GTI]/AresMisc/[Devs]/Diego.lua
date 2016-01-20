--------------------------------------------
-- What: client.luac
-- By: Diego
-- For: Grand Theft International
-- Description: Misc. client sided scripts as well as bug fixes.
---------------------------------------------

--breakableObjects:
function setOjectsNotBreakable ()
	for i,objects in ipairs(getElementsByType("object")) do
		if (objects) then
			model = getElementModel (objects)
				if model == 3280 or model == 2942 then
					setObjectBreakable(objects, false)
				elseif model == 3872 then
					setElementCollisionsEnabled(objects, false)
			end
		end
	end
end
addEventHandler ("onClientResourceStart", resourceRoot, setOjectsNotBreakable) 
