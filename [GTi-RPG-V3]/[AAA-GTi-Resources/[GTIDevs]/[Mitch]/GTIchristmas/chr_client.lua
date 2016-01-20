--[[local gMe       = getLocalPlayer();
local gRoot     = getRootElement();
local gResRoot  = getResourceRootElement( getThisResource () );

local period = math.random( 250, 750 );

local treeBall = {
  { 1950.9020996094, 1516.1427001953, 32.829601287842, 'corona', 3.0, 255, 0, 255, 255 },
  { 1942.9020996094, 1512.1427001953, 30.829601287842, 'corona', 4.0, 255, 0, 0, 255 },
  { 1940.9020996094, 1517.1427001953, 42.829601287842, 'corona', 5.0, 255, 255, 0, 255 },
  { 1947.9020996094, 1512.1427001953, 26.829601287842, 'corona', 4.0, 255, 150, 255, 255 },
  { 1947.9020996094, 1510.1427001953, 37.829601287842, 'corona', 4.0, 0, 150, 255, 255 },
  { 1947.9020996094, 1520.1427001953, 37.829601287842, 'corona', 5.0, 0, 255, 255, 255 },
  { 1947.9020996094, 1522.1427001953, 27.829601287842, 'corona', 6.0, 0, 65, 255, 255 },
  { 1935.9020996094, 1517.1427001953, 30.829601287842, 'corona', 4.0, 255, 0, 255, 255 },
  { 1948.9020996094, 1516.1427001953, 47.829601287842, 'corona', 3.0, 255, 0, 255, 255 },
  { 1942.9020996094, 1512.1427001953, 22.829601287842, 'corona', 3.0, 255, 150, 10, 255 },
  { 1940.9020996094, 1515.1427001953, 36.829601287842, 'corona', 4.0, 255, 65, 65, 255 }
};

local ball = {};

addEventHandler( 'onClientResourceStart', gResRoot,
  function()
    local star = createObject( 1247, 1945.9020996094, 1517.1427001953, 58.829601287842 );
    setObjectScale( star, 15.0 );
    
    starCorona = createMarker( 1945.9020996094, 1517.1427001953, 58.829601287842, 'corona', 8.0, 255, 0, 0, 255 );
    
    for i, tball in ipairs( treeBall ) do
      ball[i] = createMarker( tball[1], tball[2], tball[3], tball[4], tball[5], tball[6], tball[7], tball[8], tball[9] );
      setElementData( ball[i], 'period', math.random( 250, 750 ) );
    end;
    
    snowGrass = engineLoadTXD( 'jeffers4_lae.txd' );
    engineImportTXD( snowGrass, 5429 );
    --playSound3D( 'WinterRoad.wma', 1946.5057373047, 1502.3828125, 10, true );
  end
);

local posZ = 9.891975402832;

addEventHandler( 'onClientRender', gRoot,
  function()
    fxAddSparks( 1939.5118408203, 1505.0559082031, 13.2321166992188, 0, 0, 2, 1.5, 2, 0, 0, 0, false, 2, 1 );
    fxAddSparks( 1952.7985839844, 1505.0559082031, 13.2321166992188, 0, 0, 2, 1.5, 2, 0, 0, 0, false, 2, 1 );
    fxAddSparks( 1945.9020996094, 1517.1427001953, 58.829601287842, 0, 0, -2, 2.5, 15, 0, 0, 0, false, 1, 2 );
    fxAddSparks( 1945.9020996094, 1517.1427001953, 58.829601287842, 0, 0, 2, 2.5, 15, 0, 0, 0, false, 5, 2 );
    
    local ap = math.abs( math.cos( getTickCount()/250 )*255 );
    local r = math.abs( math.cos( getTickCount()/250)*255 );
    setMarkerColor( starCorona, r, 0, 0, ap );
    
    for k, treeBalls in ipairs( ball ) do
      local ap = math.abs( math.cos( getTickCount()/getElementData( treeBalls, 'period' ) )*255 );
      local r, g, b = getMarkerColor( treeBalls );
      setMarkerColor( treeBalls, r, g, b, ap );
    end;
    
    posZ = posZ + 0.52;
    if posZ > 100 then posZ = 9; end;
    local c1 = math.random( 0, 255 );
    local c2 = math.random( 0, 255 );
    local c3 = math.random( 0, 255 );
    fxAddGlass( 1939.353515625, 1489.439453125, posZ, c1, c2, c3, 255, 0.1, 10 );
    fxAddGlass( 1952.6787109375, 1489.439453125, posZ, c1, c2, c3, 255, 0.1, 10 );
  end
);]]