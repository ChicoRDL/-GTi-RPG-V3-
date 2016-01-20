local wheels = {
	{fileName="wheel_or1", model=1025},
	{fileName="wheel_lr5", model=1084},
	{fileName="wheel_lr4", model=1076},
	{fileName="wheel_lr3", model=1078},
	{fileName="wheel_lr2", model=1083},
	{fileName="wheel_lr1", model=1077},
	{fileName="wheel_sr6", model=1073},
	{fileName="wheel_sr5", model=1080},
	{fileName="wheel_sr4", model=1081},
	{fileName="wheel_sr3", model=1074},
	{fileName="wheel_sr2", model=1075},
	{fileName="wheel_sr1", model=1079},
	{fileName="wheel_gn5", model=1098},
	{fileName="wheel_gn4", model=1097},
	{fileName="wheel_gn3", model=1096},
	{fileName="wheel_gn2", model=1085},
	{fileName="wheel_gn1", model=1082},
}

addEvent ("GTIsettings_setWheelsMods", true )
addEventHandler ("GTIsettings_setWheelsMods", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("wheelmods")
		if setting == "Yes" then
			for index, wheel in pairs( wheels ) do
				wtext = engineLoadTXD ( "wheels/J2_wheels.txd", 1025 )
				engineImportTXD ( wtext, 1025 )
				wmod = engineLoadDFF ( "wheels/"..wheel.fileName.. "_.dff", wheel.model )
				engineReplaceModel ( wmod, wheel.model )
			end
		elseif setting == "No" then
			engineRestoreModel ( 1082 )
			engineRestoreModel ( 1085 )
			engineRestoreModel ( 1097 )
			engineRestoreModel ( 1077 )
			engineRestoreModel ( 1083 )
			engineRestoreModel ( 1084 )
			engineRestoreModel ( 1081 )
			engineRestoreModel ( 1098 )
			engineRestoreModel ( 1074 )
			engineRestoreModel ( 1096 )
			engineRestoreModel ( 1080 )
			engineRestoreModel ( 1073 )
			engineRestoreModel ( 1025 )
			engineRestoreModel ( 1078 )
			engineRestoreModel ( 1076 )
			engineRestoreModel ( 1079 )
			engineRestoreModel ( 1075 )
		end
	end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( )
		local setting = exports.GTIsettings:getSetting("wheelmods")
		if setting == "Yes" then
			for index, wheel in pairs( wheels ) do
				wtext = engineLoadTXD ( "wheels/J2_wheels.txd", 1025 )
				engineImportTXD ( wtext, 1025 )
				wmod = engineLoadDFF ( "wheels/"..wheel.fileName.. "_.dff", wheel.model )
				engineReplaceModel ( wmod, wheel.model )
			end
		elseif setting == "No" then
			engineRestoreModel ( 1082 )
			engineRestoreModel ( 1085 )
			engineRestoreModel ( 1097 )
			engineRestoreModel ( 1077 )
			engineRestoreModel ( 1083 )
			engineRestoreModel ( 1084 )
			engineRestoreModel ( 1081 )
			engineRestoreModel ( 1098 )
			engineRestoreModel ( 1074 )
			engineRestoreModel ( 1096 )
			engineRestoreModel ( 1080 )
			engineRestoreModel ( 1073 )
			engineRestoreModel ( 1025 )
			engineRestoreModel ( 1078 )
			engineRestoreModel ( 1076 )
			engineRestoreModel ( 1079 )
			engineRestoreModel ( 1075 )
		end
	end
)