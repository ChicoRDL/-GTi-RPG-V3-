local cWindow = guiCreateWindow(337, 177, 816, 762, "CINEMA", false)
local browser = guiCreateBrowser(0, 0, 800, 600, false, false, false, cWindow)

local theBrowser = guiGetBrowser(browser)
addEventHandler("onClientBrowserCreated", theBrowser, 
    function()
        loadBrowserURL(source, "http://www.youtube.com")
    end
)


CINEMA = {
    button = {},
    window = {},
    edit = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        guiWindowSetSizable(cWindow, false)
        guiSetProperty(cWindow, "CaptionColour", "FF0309FB")
        guiSetVisible(cWindow,false)



        CINEMA.button[1] = guiCreateButton(9, 608, 388, 35, "GET URL", false, cWindow)
        guiSetFont(CINEMA.button[1], "default-bold-small")
        guiSetProperty(CINEMA.button[1], "NormalTextColour", "FFFF0000")
        CINEMA.button[2] = guiCreateButton(427, 608, 381, 35, "PUT VIDEO IN CINEMA", false, cWindow)
        guiSetFont(CINEMA.button[2], "default-bold-small")
        guiSetProperty(CINEMA.button[2], "NormalTextColour", "FFFF0000")
        CINEMA.button[3] = guiCreateButton(10, 653, 388, 35, "CLOSE", false, cWindow)
        guiSetFont(CINEMA.button[3], "default-bold-small")
        guiSetProperty(CINEMA.button[3], "NormalTextColour", "FFFF0000")
        CINEMA.button[4] = guiCreateButton(425, 654, 383, 34, "VIEW VIDEO IN FULL SCREEN MODE", false, cWindow)
        guiSetFont(CINEMA.button[4], "default-bold-small")
        guiSetProperty(CINEMA.button[4], "NormalTextColour", "FFFF0000")
        CINEMA.edit[1] = guiCreateEdit(11, 700, 796, 52, "", false, cWindow) 
    end
)

local colis = createColRectangle(85.863, 1022.91, 50, 100)
function geturl()
if source == CINEMA.button[1] then
guiSetText(CINEMA.edit[1],getBrowserURL(theBrowser))
end
end
addEventHandler("onClientGUIClick",root,geturl)


function dxDrawImage3D(x,y,z,w,h,m,c,r,...)
        local lx, ly, lz = x+w, y+h, (z+tonumber(r or 0)) or z
    return dxDrawMaterialLine3D(x,y,z, lx, ly, lz, m, h, c , ...)
end
 
 
local screenWidth, screenHeight = guiGetScreenSize()
 
local webBrowser = createBrowser(screenWidth, screenHeight, false, false)

function webBrowserRender()
    if (isElementWithinColShape(localPlayer, colis)) then
        local x, y = 110.7, 1024.15
        dxDrawMaterialLine3D(x, y, 23.25, x, y, 14.75, webBrowser, 18.2, tocolor(255, 255, 255, 255), x, y+1, 19)
    end
end

function fullscreen()
    local URLs = string.sub(guiGetText(CINEMA.edit[1]),"33")
    if source == CINEMA.button[4] then
        triggerServerEvent("PRcinema.fullScreen", localPlayer, "https://www.youtube.com/embed/"..URLs.."?autoplay=1&iv_load_policy=3&enablejsapi=1&fs=0&theme=light")
    end
end
addEventHandler("onClientGUIClick",root,fullscreen)

function brow()
    if source == CINEMA.button[2] then
        triggerServerEvent("PRcinema.startVideo", localPlayer, guiGetText(CINEMA.edit[1]))
    end
end
addEventHandler("onClientBrowserCreated", webBrowser, brow)
addEventHandler("onClientGUIClick",root,brow)

function startVideo(url)
    if (isElementWithinColShape(localPlayer, colis)) then
        loadBrowserURL(webBrowser, url)
        addEventHandler("onClientPreRender", root, webBrowserRender)
    end
end        
addEvent("PRcinema.startVideoClient", true)
addEventHandler("PRcinema.startVideoClient", root, startVideo)

function openFullscreen(url)
    if (isElementWithinColShape(localPlayer, colis)) then
        loadBrowserURL(webBrowser, url)
    end
end
addEvent("PRcinema.fullScreenClient", true)
addEventHandler("PRcinema.fullScreenClient", root, openFullscreen)

function url()
    if (guiGetVisible(cWindow)) then
        guiSetVisible(cWindow,false)
        showCursor( false )
        guiSetInputEnabled( false )
    else    
        guiSetVisible(cWindow,true)
        showCursor( true )
        guiSetInputEnabled( true )
    end    
end
addEvent("PRcinema.openGUI", true)
addEventHandler("PRcinema.openGUI", root, url)


function closeman()
    if source == CINEMA.button[3] then
        guiSetVisible(cWindow,false)
        showCursor( false )
        guiSetInputEnabled( false )
    end 
end
addEventHandler("onClientGUIClick",root,closeman)