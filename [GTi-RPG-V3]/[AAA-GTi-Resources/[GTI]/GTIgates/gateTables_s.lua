----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 11 March 2014
-- Resource: GTIgates/gateTables_s.lua
-- Type: Server Side
-- Author: LilDolla
----------------------------------------->>

--[[
gates = {
	{ pos={ x, y, z}, rot={x, y, z}, model=980, world={ int, dim}, size=2, res={ team={""}, job={""}}, move={x, y, z}, animation={enter, leave}, settings={ vehicle=boolean}},
}
--]]

gates = {
	--ASGH
	{ lock={"", ""}, pos={ 1171.699, -1324.800, 14.399}, forceCenter={0, 0, 0}, rot={ 0, 0, 90}, model=1569, world={ 0, 0}, size=4, move={ 1171.699, -1326.099, 14.399}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --ASGH Front Door 1
	{ lock={"", ""}, pos={ 1171.699, -1321.799, 14.399}, forceCenter={0, 0, 0}, rot={ 0, 0, 270}, model=1569, world={ 0, 0}, size=4, move={ 1171.699, -1320.5, 14.399}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --ASGH Front Door 2
	{ lock={"", ""}, pos={ 1124.400, -1335.5, 15}, forceCenter={0, 0, 0}, rot={ 0, 0, 90.241}, model=3037, world={ 0, 0}, size=8, move={ 1124.400, -1335.5, 10.600}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --ASGH Garage Door 1
	{ lock={"", ""}, pos={ 1110.599, -1335.5, 15}, forceCenter={0, 0, 0}, rot={ 0, 0, 90.241}, model=3037, world={ 0, 0}, size=8, move={ 1110.599, -1335.5, 10.600}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --ASGH Garage Door 2
	{ lock={"", ""}, pos={ 1097.799, -1335.5, 15}, forceCenter={0, 0, 0}, rot={ 0, 0, 90.241}, model=3037, world={ 0, 0}, size=8, move={ 1097.799, -1335.5, 10.600}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --ASGH Garage Door 3
	--LSGC
	{ lock={"", ""}, pos={ 785.400, -1152.5, 25.5}, forceCenter={0, 0, 0}, rot={ 0, 0, 270}, model=3037, world={ 0, 0}, size=8, move={ 785.400, -1152.5, 30.700}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Los Santos Golf Course 1
	{ lock={"", ""}, pos={ 664.900, -1309.099, 15.199}, forceCenter={0, 0, 0}, rot={ 0, 0, 180}, model=3037, world={ 0, 0}, size=8, move={ 664.900, -1309.099, 20.399}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Los Santos Golf Course 2
	--Land Prison
	--Maingates
	{ lock={"", ""}, pos={ 287.399, 1407, 11.100}, forceCenter={287.603, 1410.95, 10.481}, rot={ 0, 0, 270}, model=985, world={ 0, 0}, size=8, move={ 287.399, 1398.899, 11.300}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Main Gate 1
	{ lock={"", ""}, pos={ 287.399, 1414.899, 11.100}, forceCenter={287.603, 1410.95, 10.481}, rot={ 0, 0, 270}, model=986, world={ 0, 0}, size=8, move={ 287.399, 1423.299, 11.100}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Main Gate 2
	--Interior Gates
	{ lock={"Government", "Correctional Officer"}, pos={ 158.299, 1497.099, 1710.400}, forceCenter={0, 0, 0}, rot={ 0, 0, 90}, model=5856, world={ 0, 51}, size=2, move={ 158.299, 1497.099, 1713.099}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Gate 1
	{ lock={"Government", "Correctional Officer"}, pos={ 156.100, 1490.229, 1710}, forceCenter={156.100, 1490.91, 1710}, rot={ 0, 0, 90}, model=3089, world={ 0, 51}, size=1, move={ 156.100, 1488.950, 1710}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Gate 2
	{ lock={"Government", "Correctional Officer"}, pos={ 160.399, 1481, 1710.400}, forceCenter={160.399, 1481, 1709.400}, rot={ 0, 0, 180}, model=5856, world={ 0, 51}, size=2, move={ 160.399, 1481, 1712.999}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Gate 3
	{ lock={"Government", "Correctional Officer"}, pos={ 172.799, 1484.199, 1702.300}, forceCenter={172.863, 1476.986, 1703.261}, rot={ 0, 0, 270}, model=976, world={ 0, 51}, size=2, move={ 172.800, 1487.300, 1702.300}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Gate 4
	{ lock={"Government", "Correctional Officer"}, pos={ 178.099, 1473, 1702.1}, forceCenter={177.966, 1469.454, 1703.256}, rot={ 0, 0, 270}, model=976, world={ 0, 51}, size=2, move={ 178.099, 1479.800, 1702.1}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Gate 5
	{ lock={"Government", "Correctional Officer"}, pos={ 213.250, 1466.799, 1703.5}, forceCenter={212.499, 1466.799, 1703.5}, rot={ 0, 0, 180}, model=3089, world={ 0, 51}, size=1, move={ 214.399, 1466.799, 1703.5}, animation={ "OutQuad", "InQuad"}, settings={ vehicle="t"}}, --Gate 6
}
