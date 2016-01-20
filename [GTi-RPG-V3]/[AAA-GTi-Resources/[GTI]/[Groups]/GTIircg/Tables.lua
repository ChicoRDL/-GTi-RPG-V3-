--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz and Emile ~
-- Resource: GTIircg/Tables.lua ~
-- Description: <Desc> ~
-- Data: #IRCgroups
--<--------------------------------->--


eTable = {
    ["#GHoST"] = 2, -- GHoST
    ["#CIA"] = 14, -- CIA
    ["#PsychoMob"] = 618, -- Psycho Mob
    ["#RudePrawns"] = 7, -- Rude Prawns
    ["#TheWarriors"] = 793, -- TheWarriors
    ["#DemBoyz"] = 3018, -- Dem BoyZ
    -- [#Channel] = ID -- GroupName
}

--
vTable = {
    [2] = "#GHoST", -- GHoST
    [14] = "#CIA", -- CIA
    [618] = "#PsychoMob", -- Psycho Mob
    [7] = "#RudePrawns", -- Rude Prawns
    [3018] = "#DemBoyz", -- Dem BoyZ
    [793] = "#TheWarriors", -- TheWarriors
    -- [GroupID] = "#Channel", -- group 
    }

function getChannelFromGroupID(ID)
    if ( ID and vTable[ID] ) then
        return vTable[ID]
    else 
        return false    
    end
end

function getGroupIDFromChannel(channel)
    if ( channel and eTable[channel] ) then
        return eTable[channel]
    end
end
