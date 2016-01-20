----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 27 Dec 2015
-- Resource: GTIapartments/editor/preview.lua
-- Type: Client Side
-- Author: Ares
----------------------------------------->>

local tx, ty, tz = 91, 100, 502
local hideX, hideY, hideZ = 0, 0, 0
local rz = 0
local maxRadius = 5
local camDistance = 4
local rotateSpeed = 4000
local rotateRate = 360/rotateSpeed
local rotX, rotY
local previewObject

originalRotateTick = getTickCount()

function createPreview (model)
	local randomOffset = ((getTickCount() % 20) / 100 ) + 0.001

	if not previewObject then
		previewObject = createObject(model, tx, ty, tz, 0, 0, rz)
		setElementDimension(previewObject, 1111)
		setElementInterior(previewObject, 14)
		setElementFrozen(localPlayer, true)
	else
		setElementModel(previewObject, model)
	end

	setElementPosition(previewObject, tx, ty, tz+randomOffset)
	setElementAlpha(previewObject, 255)
	setElementData(previewObject, "apartmentsobject", true)

	local radius = getElementRadius(previewObject)	
	setObjectScale(previewObject, maxRadius/radius)
	setCameraMatrix(tx-17, ty, tz+3+randomOffset, tx, ty + 2, tz + randomOffset)
	setCameraInterior(14)
end

function rotateObject()
	if ( not isElement(previewObject) ) then return end
	local newTick = getTickCount()
	previewTickDifference = newTick - originalRotateTick
	local newRotation = rotateRate*previewTickDifference
	rz = newRotation
	setElementRotation(previewObject, 0, 0, newRotation)
end
addEventHandler("onClientRender", root, rotateObject)

function getPreviewObject()
	return previewObject
end

function updatePreviewObject(elem)
	previewObject = elem
	return true
end