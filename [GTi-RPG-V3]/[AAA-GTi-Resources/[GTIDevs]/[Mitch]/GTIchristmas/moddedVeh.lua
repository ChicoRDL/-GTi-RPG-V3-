function loadobj ( resource )
    if resource ~= getThisResource ( ) then return end
	txd1 = engineLoadTXD('quad.txd')
    engineImportTXD ( txd1, 471)
    dff1 = engineLoadDFF('quad.dff', 471)
        engineReplaceModel(dff1, 471)
end
addEventHandler ("onClientResourceStart", resourceRoot, loadobj )