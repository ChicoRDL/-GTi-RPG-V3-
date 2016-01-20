GTIu = {
    button = {},
    window = {},
    staticimage = {},
    memo = {}
}

local sW, sH = guiGetScreenSize()   -- Screen resolution
local webFileDownloading            -- Is the file being downloaded?
local updatesFile                   -- Updates file
local updatesData                   -- Processed updates data
local downloading                   -- Is the file downloading?
local checksum                      -- Figure out if a new update is available
local startup = true                -- Did the script just start?

function onStart()
    GTIu.window[1] = guiCreateWindow((sW - 568) / 2, (sH - 432) / 2, 568, 432, "GTI Updates", false)
    guiWindowSetSizable(GTIu.window[1], false)

    GTIu.memo[1] = guiCreateMemo(10, 113, 548, 280, "Awaiting for updates to be loaded...", false, GTIu.window[1])
    guiSetAlpha(GTIu.memo[1], 0.80)
    guiMemoSetReadOnly(GTIu.memo[1], true)
    GTIu.staticimage[1] = guiCreateStaticImage(168, 27, 231, 76, "images/logo.png", false, GTIu.window[1])
    GTIu.button[1] = guiCreateButton(500, 403, 58, 21, "Close", false, GTIu.window[1])
    addEventHandler("onClientGUIClick",GTIu.button[1],openPanel,false)

    guiSetVisible(GTIu.window[1], false) --Set the window invisible

    updates()
end
addEventHandler("onClientResourceStart",resourceRoot,onStart)

function openPanel()
    local view = guiGetVisible(GTIu.window[1])
    guiSetVisible(GTIu.window[1], not view)
    showCursor(not view)
end
addEvent("GTIupdates:showUpdatesPanel",true)
addEventHandler("GTIupdates:showUpdatesPanel",root,openPanel)

--TODO: Implement checksum checking
function updates()
    if downloading then return end

    if not fileExists("updates.txt") then
        fetchRemote("http://mta.gtirpg.net/MTA/RawFile/updates.txt", processDownload)
        downloading = true
        return
    else
        updatesFile = fileOpen("updates.txt")
    end

    --Process buffer
    if (updatesFile) then
        local buffer = ""
        while not fileIsEOF(updatesFile) do
            buffer = buffer .. fileRead(updatesFile, 500)
        end

        updatesData = buffer
    end

    --Checksum
    fetchRemote("https://mta.gtirpg.net/MTA/updates-md5.php", processChecksum)

    fileClose(updatesFile)

    guiSetText(GTIu.memo[1], updatesData or "Failed to load updates data.")
end

function processDownload(responseData, errno)
    if (errno == 0) then
        if not fileExists("updates.txt") then
            updatesFile = fileCreate("updates.txt")
        else
            updatesFile = fileOpen("updates.txt")
        end

        fileWrite(updatesFile, responseData)
        fileFlush(updatesFile)
        fileClose(updatesFile)

        setTimer(updates,1000,1)
    else
        guiSetText(GTIu.memo[1], "Failed to collect updates from webserver (Error: "..getHTTPError(errno) or errno..")")
    end
end

function processChecksum(responseData,errno)
    if (errno == 0) then
        if (startup == false) then
            if (checksum ~= responseData) then
                exports.GTIhud:dm("A new update has been submitted. Use /updates to see.",localPlayer,255,255,0)
            end
        end

        --update checksum
        checksum = responseData
        startup = false --disable this now.
    end
end

setTimer(function()
    fetchRemote("http://mta.gtirpg.net/MTA/RawFile/updates.txt", processDownload)
    fetchRemote("http://mta.gtirpg.net/MTA/updates-md5.php", processChecksum)
end, 1000*60, 0)
