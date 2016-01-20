-- 12959: Palomni Creek Library

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		local txd = engineLoadTXD( 'sw_library.txd')
		engineImportTXD( txd, 12959)
	end
)
