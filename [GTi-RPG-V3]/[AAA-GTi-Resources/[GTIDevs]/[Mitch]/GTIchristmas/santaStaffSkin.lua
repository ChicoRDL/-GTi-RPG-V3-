function loadobjSanta ( resource )
    if resource ~= getThisResource ( ) then return end
	txd1 = engineLoadTXD('santa.txd')
    engineImportTXD ( txd1, 217)
    dff1 = engineLoadDFF('santa.dff', 217)
        engineReplaceModel(dff1, 217)
end
addEventHandler ("onClientResourceStart", resourceRoot, loadobjSanta )