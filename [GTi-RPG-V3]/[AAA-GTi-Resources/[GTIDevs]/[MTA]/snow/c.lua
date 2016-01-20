local treeList = {"sm_des_bush*", "*tree*", "*ivy*",  "weeelm","*branch*", "cypress*","*bark*","*pine*","veg_*", "*largefur*", "hazelbr*", "gen_log", "trunk5","bchamae", "vegaspalm01_128"}
local toRemove = {
"*decal*","*8bit*", "*logos*", "*badge*","*plate*","vehicle*", "?emap*", "?hite*","*92*", "*wheel*", "*interior*","*handle*", "*body*",  "*sign*","headlight", "headlight1","shad*","coronastar","tx*","lod*","cj_w_grad","*cloud*","*smoke*","sphere_cj","particle*","*water*", "sw_sand", "coral",                    
}
flakes = {}
sxx,syy = guiGetScreenSize()
sx,sy = sxx/2,syy/2
function shader()
    snowShader = dxCreateShader ( "snow_ground.fx", 0, 250 )
    treeShader = dxCreateShader( "snow_trees.fx" )
    for _,v in ipairs(treeList) do
        engineApplyShaderToWorldTexture ( treeShader, v )
    end
    engineApplyShaderToWorldTexture ( snowShader, "*" )
    for _,v in ipairs(toRemove) do
        engineRemoveShaderFromWorldTexture ( snowShader, v )
    end
    shader = true
end

function disableshader()
    if isElement(snowShader) then destroyElement(snowShader) end
    if isElement(treeShader) then destroyElement(treeShader) end
    shader = false
end

function render()
    local rx,ry,rz = getWorldFromScreenPosition(sxx,syy,1)
    for i,v in pairs(flakes) do
        local draw_x,draw_y = v[1],v[2]+0.0001
        if draw_y > syy then
            flakes[i][2] = 0
        end
        if isLineOfSightClear(rx,ry,rz,draw_x,draw_y,rz,true,true,true,true,false,false,false) then
            local size = v[3]
            local num = v[4]
            local rot = v[5]
            local alpha = v[6]
            flakes[i][2] = draw_y
            dxDrawImage(draw_x,draw_y,size,size,"snowflake"..tostring(num)..".png",rot,0,0,tocolor(222,235,255,alpha))
        end
    end
end
function create()
    for i=1,20 do
        local rx,ry,rz = getWorldFromScreenPosition(sxx,syy,1)
        local draw_x,draw_y = math.random(sxx),0
        if isLineOfSightClear(rx,ry,rz,draw_x,draw_y,rz,true,true,true,true,false,false,false) then
            local size = math.random()
            local num = math.random(1,5)
            local rot = math.random(0,360)
            local alpha = math.random(100,255)
            dxDrawImage(draw_x,draw_y,size,size,"snowflake"..tostring(num)..".png",rot,0,0,tocolor(222,235,255,alpha))
            table.insert(flakes,{draw_x,draw_y,size,num,rot,alpha})
        end
    end
    addEventHandler("onClientRender",root,render)
end
addCommandHandler("snow",create)