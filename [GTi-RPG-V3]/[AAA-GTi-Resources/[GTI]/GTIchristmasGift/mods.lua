local hats = { [2476] = "santa1" }
local filepath = "/files/"

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		for ID, filename in pairs (hats) do
			engineImportTXD(engineLoadTXD(filepath.."santa.txd"), ID)
			--engineReplaceCOL(engineLoadCOL(filepath.."santa.col"), ID)
			engineReplaceModel(engineLoadDFF(filepath..filename..".dff"), ID)
		end
	end
)