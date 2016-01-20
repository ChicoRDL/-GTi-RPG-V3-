------------------------------------->>
-- CIT: Community of Integrity and Transparency
-- Date: 28 Nov 2013
-- Resource: JTPenn/elementSource.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
-- All Rights Reserved By Developers
------------------------------------->>

local GET_ELEMENT_RESOURCE = true

if (GET_ELEMENT_RESOURCE) then

function getElementResource(_, _, _, _, _, _, _, element)
	outputChatBox("Getting Element Resource...")
	if not isElement(element) then return end
	
	local resources = getResources()
	local eleType = getElementType(element)
	for i,resource in ipairs(resources) do
		if (getResourceState(resource) == "running") then
			local resRoot = getResourceDynamicElementRoot(resource)
			if (resRoot) then
				local elements = getElementsByType(eleType, resRoot)
				if (elements) then
					for i,element2 in ipairs(elements) do
						if (element2 == element) then
							outputChatBox("Element is from resource "..getResourceName(resource))
							return
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, getElementResource)

end
