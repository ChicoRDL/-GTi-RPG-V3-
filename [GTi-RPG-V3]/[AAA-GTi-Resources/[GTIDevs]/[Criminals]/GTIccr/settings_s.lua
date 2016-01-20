-- { Name, Start Time, Max Players Per Team, Interior, Dimension, Alarm Location}
settings = { "Caligula's Casino Robbery", 10, 40, 1, 801, "2235.961,1613.256,1005.180"}

blip_pos = "2192.529,1676.997,11.367"

--[[ GTIcnr Events
    onCnREventStart
        - source: root element
        - arguments: event
    onCnRPointEnter
        - source: the col
        - arguments: hitElement, matchingDimension
    onCnRPointLeave
        - source: the col
        - arguments: leaveElement, matchingDimension
--]]

enter_exit_points = {
    { 2196.263, 1677.191, 11.367, "0;0", "enter;all"},
    --{ 2767.174, -1615.389, 10.922, "0;0", "enter;law"},
    { 2233.958, 1714.684, 1011.483, "1;801", "leave;law"},
    --{ 2298.084, 1571.333, 12.047, "0;0", "enter;crim"},
    { 2204.400, 1551.517, 1008.322, "1;801", "leave;crim"},
    { 2151.065, 1602.875, 1005.177, "1;801", "leave;crim"},
}

warps = {
    { 2233.784, 1713.586, 1012.183, 0, "enter;law"},
    --{ 2155.228, 1625.485, 1009.359, 0, "enter;crim"},
    { 2152.660, 1602.856, 1005.175, 0, "enter;crim"},
    { 2155.228, 1625.485, 1009.359, 0, "enter;medic"},
    { 2193.652, 1677.128, 12.367, 45, "leave;law"},
    { 2193.652, 1677.128, 12.367, 45, "leave;medic"},
    { 2193.652, 1677.128, 12.367, 45, "leave;crim"},
    --{ 2297.725, 1569.181, 9.820, 180, "leave;crim"},
}

points = {
    { 2146.156, 1607.182, 1005.180, "gateOpener"},
    { 2141.969, 1629.289, 992.576},
    { 2141.969, 1633.318, 992.576},
    { 2141.969, 1637.168, 992.576},
    { 2141.969, 1641.137, 992.576},
    { 2146.538, 1629.289, 992.576},
    { 2146.538, 1633.318, 992.576},
    { 2146.538, 1637.168, 992.576},
    { 2146.538, 1641.137, 992.576},
}

objects = {
    -- { id, "x,y,z,int,dim", rot_string "rx,ry,rz", type},
    { 11416, "2149.899,1601.299,1006.5", "0,0,0", "gate"},
    { 11416, "2149.936,1604.687,1002.968", "0,0,270", "object"},
    { 11416, "2160.432,1603.581,1000.97", "0,0,0", "object"},
    { 9093, "2145.799,1604.634,1006.263", "0,0,90", "object"},
    { 9093, "2150.096,1602.881,1001.97", "0,0,0", "object"},
    { 9093, "2176.559,1609.1,1000.577", "0,0,90", "object"},
}

function getEventDetails()
    return settings, enter_exit_points, warps, points, objects, blip_pos
end
