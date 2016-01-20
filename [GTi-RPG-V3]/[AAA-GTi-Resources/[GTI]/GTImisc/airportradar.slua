function radarObjects()
  LSradar2 = createObject(1682, 1663.6171875, -2362.703125, 32.091751098633, 0, 0, 0)
  moveLSradar2(1)
  LSradar1 = createObject(1682, 1709.4140625, -2362.703125, 32.091751098633, 0, 0, 0)
  moveLSradar1(1)
  lvradarok = createObject(1682, 1296.1656494141, 1502.7198486328, 26.015625, 0, 0, 90)
  moveLVradar(1)
  radarSF = createObject(1682, -1691.5859375, -619.6953125, 29.6171875, 0, 0, 0)
  moveradarSF(1)
end

function moveLSradar2(point)
    moveObject(LSradar2, 2000, 1663.6171875, -2362.703125, 32.091751098633, 0, 0, 360)
    setTimer(moveObject, 2000, 0, LSradar2, 2000, 1663.6171875, -2362.703125, 32.091751098633, 0, 0, 360)
end

function moveLSradar1(point)
    moveObject(LSradar1, 2000, 1709.4140625, -2362.703125, 32.091751098633, 0, 0, 360)
    setTimer(moveObject, 2000, 0, LSradar1, 2000, 1709.4140625, -2362.703125, 32.091751098633, 0, 0, 360)
end

function moveLVradar(point)
    moveObject(lvradarok, 2000, 1296.1656494141, 1502.7198486328, 26.015625, 0, 0, 360)
    setTimer(moveObject, 2000, 0, lvradarok, 2000, 1296.1656494141, 1502.7198486328, 26.015625, 0, 0, 360)
end

function moveradarSF(point)
    moveObject(radarSF, 2000, -1691.5859375, -619.6953125, 29.6171875, 0, 0, 360)
    setTimer(moveObject, 2000, 0, radarSF, 2000, -1691.5859375, -619.6953125, 29.6171875, 0, 0, 360)
end
addEventHandler("onResourceStart", getResourceRootElement(), radarObjects)

removeWorldModel(1682,10,1294.89,1502.55,26.0156) --LV Original radar
removeWorldModel(1682,10,1709.4141,-2362.7031,31.71875) --LS Original radar I
removeWorldModel(1682,10,1663.6172,-2362.7031,31.71875) --LS Original radar II
removeWorldModel(1682,10,-1691.5859375,-619.6953125,29.6171875) --SF Original radar