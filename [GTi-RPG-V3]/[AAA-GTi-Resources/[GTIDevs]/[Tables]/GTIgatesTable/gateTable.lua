----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 11 March 2014
-- Resource: GTIgates/gateTables_s.lua
-- Type: Server Side
-- Author: LilDolla
----------------------------------------->>

--[[
gates = {
    { lock={ team, job}, pos={ x, y, z}, forceCenter={ x, y, z (This can force the colshape to be at a certain place, leave as 0,0,0 to disable)}, rot={x, y, z}, model=980, world={ int, dim}, size=2, res={ team={""}, job={""}}, move={x, y, z}, animation={enter, leave}, settings={ "settingName;state[boolean]"},
}
--]]

gates = {
    --LS Ammunation
    { lock={"", ""}, pos={ 1369.699, -1281.300, 12.57}, forceCenter={1369.5, -1279.800, 13.5}, rot={ 0, 0, 90}, model=1569, world={ 0, 0}, size=4, move={ 1369.699, -1282.699, 12.57}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --Door 1
    { lock={"", ""}, pos={ 1369.699, -1278.300, 12.57}, forceCenter={1369.5, -1279.800, 13.5}, rot={ 0, 0, 270}, model=1569, world={ 0, 0}, size=4, move={ 1369.699, -1276.900, 12.57}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --Door 2
    --All Saints
    { lock={"", ""}, pos={ 1171.699, -1324.800, 14.399}, forceCenter={1173.312, -1323.277, 14.393}, rot={ 0, 0, 90}, model=1569, world={ 0, 0}, size=4, move={ 1171.699, -1326.099, 14.399}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --ASGH Front Door 1
    { lock={"", ""}, pos={ 1171.699, -1321.799, 14.399}, forceCenter={1173.312, -1323.277, 14.393}, rot={ 0, 0, 270}, model=1569, world={ 0, 0}, size=4, move={ 1171.699, -1320.5, 14.399}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --ASGH Front Door 2
    { lock={"", ""}, pos={ 1124.400, -1335.5, 15}, forceCenter={0, 0, 0}, rot={ 0, 0, 90.241}, model=3037, world={ 0, 0}, size=8, move={ 1124.400, -1335.5, 10.600}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --ASGH Garage Door 1
    { lock={"", ""}, pos={ 1110.599, -1335.5, 15}, forceCenter={0, 0, 0}, rot={ 0, 0, 90.241}, model=3037, world={ 0, 0}, size=8, move={ 1110.599, -1335.5, 10.600}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --ASGH Garage Door 2
    { lock={"", ""}, pos={ 1097.799, -1335.5, 15}, forceCenter={0, 0, 0}, rot={ 0, 0, 90.241}, model=3037, world={ 0, 0}, size=8, move={ 1097.799, -1335.5, 10.600}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --ASGH Garage Door 3
    -- Jefferson Hospital
    { lock={"", ""}, pos={ 2031, -1401.2, 16.2}, forceCenter={2029.570, -1400.592, 16.28}, rot={ 0, 0, 180}, model=1569, world={ 0, 0}, size=4, move={ 2032.4, -1401.2, 16.2}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --Door 1
    { lock={"", ""}, pos={ 2028, -1401.2, 16.2}, forceCenter={2029.570, -1400.592, 16.28}, rot={ 0, 0, 360}, model=1569, world={ 0, 0}, size=4, move={ 2026.6, -1401.2, 16.2}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --Door 2
    --Land Prison
    --Interior Gates
    { lock={"Law Enforcement", "Correctional Officer"}, pos={ 158.299, 1497.099, 1710.400}, forceCenter={0, 0, 0}, rot={ 0, 0, 90}, model=5856, world={ 0, 51}, size=2, move={ 158.299, 1497.099, 1713.099}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 1
    { lock={"Law Enforcement", "Correctional Officer"}, pos={ 156.100, 1490.229, 1710}, forceCenter={156.100, 1490.91, 1710}, rot={ 0, 0, 90}, model=3089, world={ 0, 51}, size=1, move={ 156.100, 1488.950, 1710}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 2
    { lock={"Law Enforcement", "Correctional Officer"}, pos={ 160.399, 1481, 1710.400}, forceCenter={160.399, 1481, 1709.400}, rot={ 0, 0, 180}, model=5856, world={ 0, 51}, size=2, move={ 160.399, 1481, 1712.999}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 3
    { lock={"Law Enforcement", "Correctional Officer"}, pos={ 172.799, 1484.199, 1702.300}, forceCenter={172.863, 1476.986, 1703.261}, rot={ 0, 0, 270}, model=976, world={ 0, 51}, size=2, move={ 172.800, 1487.300, 1702.300}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 4
    { lock={"Law Enforcement", "Correctional Officer"}, pos={ 178.099, 1473, 1702.1}, forceCenter={177.966, 1469.454, 1703.256}, rot={ 0, 0, 270}, model=976, world={ 0, 51}, size=2, move={ 178.099, 1479.800, 1702.1}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 5
    { lock={"Law Enforcement", "Correctional Officer"}, pos={ 213.250, 1466.799, 1703.5}, forceCenter={212.499, 1466.799, 1703.5}, rot={ 0, 0, 180}, model=3089, world={ 0, 51}, size=1, move={ 214.399, 1466.799, 1703.5}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 6
    --Area 69, NG.
    { lock={"National Guard" and "Terrorists", ""}, pos={ 96.7001953125, 2071.400390625, 19.2}, forceCenter={0, 0, 0}, rot={ 0, 0, 90}, model=980, world={ 0, 0}, size=7, move={ 96.700195312, 2083.1015625, 19.2}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --MainGate
    { lock={"National Guard" and "Terrorists", ""}, pos={ 137.7998046875, 1941.2001953125, 19.4}, forceCenter={135.19279, 1941.16248, 19.31440}, rot={ 0, 0, 180}, model=988, world={ 0, 0}, size=7, move={ 143.10000610352, 1941.2001953125, 19.4}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 1 (1)
    { lock={"National Guard" and "Terrorists", ""}, pos={ 132.2998046875, 1941.2001953125, 19.4}, forceCenter={135.19279, 1941.16248, 19.31440}, rot={ 0, 0, 180}, model=988, world={ 0, 0}, size=7, move={ 127.09999847412, 1941.2001953125, 19.4}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 1 (2)
    { lock={"National Guard" and "Terrorists", ""}, pos={ 285.599609375, 1818.5, 17.7}, forceCenter={285.30869, 1821.07849, 17.64063}, rot={ 0, 0, 270}, model=988, world={ 0, 0}, size=7, move={ 285.599609375, 1813.2, 17.7}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 2 (1)
    { lock={"National Guard" and "Terrorists", ""}, pos={ 285.599609375, 1824, 17.7}, forceCenter={285.30869, 1821.07849, 17.64063}, rot={ 0, 0, 270}, model=988, world={ 0, 0}, size=7, move={ 285.599609375, 1829.3000488281, 17.7}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --Gate 2 (2)
    { lock={"National Guard" and "Terrorists", ""}, pos={ 96.7001953125, 1920.2998046875, 17.799999237061}, forceCenter={0, 0, 0}, rot={ 0, 0, 270}, model=988, world={ 0, 0}, size=7, move={ 96.7001953125, 1925.7001953125, 17.799999237061}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --MainGate 2
    { lock={"National Guard" and "Terrorists", ""}, pos={ 341.7998046875, 1773.599609375, 19.200000762939}, forceCenter={0, 0, 0}, rot={ 0, 0, 217.99072265625}, model=980, world={ 0, 0}, size=7, move={ 332.400390625, 1766.2998046875, 19.200000762939}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"}}, --MainGate 3


-- Groups
    -- Q7
    { lock={"Group", 618}, pos={2480.644, 682.499, 16.515}, forceCenter={0, 0, 0}, rot={ 0, 0, 180}, model=980, world={ 0, 0}, size=7, move={2480.644, 682.499, 22.715}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
       
    -- TriForce
    { lock={"Group", 82}, pos={ 1035, -370, 76}, forceCenter={0, 0, 0}, rot={ 0, 0, 0}, model=16773, world={ 0, 0}, size=7, move={ 1035, -370, 84}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
    
    -- White Beards
   --[[ { lock={"Group", 618}, pos={ 1174, -1720.4, 16.2}, forceCenter={0, 0, 0}, rot={0, 0, 322}, model=971, world={ 0, 0}, size=7, move={ 1174, -1720.4, 21.1}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
    { lock={"Group", 618}, pos={ 1181, -1720.4, 16.2}, forceCenter={0, 0, 0}, rot={0, 0, 36}, model=971, world={ 0, 0}, size=7, move={ 1181, -1720.4, 21.1}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },]]

     -- GHoST
    { lock={"Group", 2}, pos={1447.580, 663.400, 12.520}, forceCenter={0, 0, 0}, rot={ 0, 0, 0}, model=980, world={ 0, 0}, size=7, move={1447.744, 663.400, 17.820}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
    { lock={"Group", 2}, pos={1388.329, 685.905, 6.561}, forceCenter={0, 0, 0}, rot={ 0, 0, 0}, model=971, world={ 0, 0}, size=7, move={1388.329, 685.905, -3.561}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
    { lock={"Group", 2}, pos={1527.380, 663.924, 12.672}, forceCenter={0, 0, 0}, rot={ 0, 0, 0}, model=980, world={ 0, 0}, size=7, move={1527.380, 663.924, 17.672}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
    --[[ Rude Prawns 

    { lock={"Group", 7}, pos={ 713.27, -1584.1, 3.1}, forceCenter={0, 0, 0}, rot={0, 0, 270}, model=980, world={ 0, 0}, size=3.5, move={ 713.27, -1584.1, 8.4}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} }, ]]
    
    -- CIA
    { lock={"Group", 14}, pos={1862.2, -1325, 15.3}, forceCenter={0, 0, 0}, rot={ 0, 0, 90}, model=980, world={ 0, 0}, size=7, move= {1862.2, -1325, 9}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },
    { lock={"Group", 14}, pos={1887.180, -1287.717, 9.515}, forceCenter={0, 0, 0}, rot={ 0, 0, 60}, model=971, world={ 0, 0}, size=7, move= {1887.180, -1287.717, 16.418}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;true"} },

    { lock={"Group", 14}, pos={1955.88, -1304.83, 14}, forceCenter={1954.5, -1304, 12.579}, rot={ 0, 0, 180}, model=3089, world={ 0, 0}, size=4, move={1955.8, -1304.86, 17.58}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --ASGH Front Door 1
    { lock={"Group", 14}, pos={1952.9, -1304.83, 14}, forceCenter={1954.5, -1304, 12.579}, rot={ 0, 0, 360}, model=3089, world={ 0, 0}, size=4, move={1952.8, -1304.83, 17.58}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, --ASGH Front Door 2

    { lock={"Group", 14}, pos={1961.4, -1312, 21.1}, forceCenter={1962, -1314, 21}, rot={ 0, 0, 0}, model=3089, world={ 0, 0}, size=4, move={1959.9, -1312, 21.1}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, -- Meeting room 1
    { lock={"Group", 14}, pos={1964.4, -1312, 21.1}, forceCenter={1962, -1314, 21}, rot={ 0, 0, 180}, model=3089, world={ 0, 0}, size=4, move={1965.8, -1312, 21.1}, animation={ "OutQuad", "InQuad"}, settings={ "vehAllowed;false"}}, -- Meeting room 2

}


--Export
function getGatesTable()
    return gates
end
