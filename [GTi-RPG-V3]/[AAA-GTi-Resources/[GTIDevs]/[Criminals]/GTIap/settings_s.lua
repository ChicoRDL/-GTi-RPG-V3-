-- { Name, Start Time, Max Players Per Team, Interior, Dimension, Alarm Location}
settings = { "Airport Bomber", 10, 20, 0, 801, "1787.756,-2484.143,20.338"}

blip_pos = "1685.645,-2334.720,12.547"

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
    { 1685.645, -2334.720, 12.547, "0;0", "enter;all"},
    { 1937.322, -2474.873, 12.539, "0;801", "leave;law"},
    { 1680.467, -2473.477, 12.555, "0;801", "leave;crim"},
}

warps = {
    { 1933.155, -2475.445, 12.539, 83, "enter;law"},
    --{ 2155.228, 1625.485, 1009.359, 0, "enter;crim"},
    { 1687.109, -2473.434, 12.555, 0, "enter;crim"},
    { 1927.778, -2480.373, 12.539, 0, "enter;medic"},
    { 1685.6533203125, -2327.7724609375, 12.546875, 180, "leave;law"},
    { 1685.6533203125, -2327.7724609375, 12.546875, 180, "leave;medic"},
    { 1685.6533203125, -2327.7724609375, 12.546875, 180, "leave;crim"},
    --{ 2297.725, 1569.181, 9.820, 180, "leave;crim"},
}

points = {
    {1712.6042, -2451.4922, 120.371796},
}

objects = {
}


function getEventDetails()
    return settings, enter_exit_points, warps, points, objects, blip_pos
end
