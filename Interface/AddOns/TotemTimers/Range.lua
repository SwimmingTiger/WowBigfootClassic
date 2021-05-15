-- Copyright © 2008-2014 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters



local map, mapfloor = nil,nil
local mapWidth, mapHeight = 0,0

-- local mapdata = LibStub("LibMapData-1.0")


--[[ mapdata:RegisterCallback("MapChanged",
    function(event,mapname,mfloor,w,h)
        map = mapname
        mapfloor = mfloor
        mapWidth = w or 0
        mapHeight = h or 0
    end) ]]

local function yards(x,y)
    return x*mapWidth,y*mapHeight
end


if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local playerName = UnitName("player")

local RaidNames = {}
local RaidClasses = {}
local RaidRange = {[1]={},[2]={},[3]={},[4]={}}
local RaidRangeCount = {0,0,0,0}
local inRaid = false
local inParty = false
local inBattleground = false
local TotemPositions = {[1]={x=0,y=0},[2]={x=0,y=0},[3]={x=0,y=0},[4]={x=0,y=0},}
local PlayerRange = {}


local function checkRange(unit,nr)
    return true
   --[[ if UnitIsDeadOrGhost(unit) then return true end
    local totem = XiTimers.timers[nr].activeTotem
    if TotemData[totem].noRangeCheck then return true end
    if TotemData[totem].partyOnly and not UnitInParty(unit) and unit ~= "player" then return true end 
    if mapWidth > 0 and mapHeight > 0 then
        --check range using coordinates
        local element = XiTimers.timers[nr].button.element
        local x,y = GetPlayerMapPosition(unit)
        x = x * mapWidth
        y = y * mapHeight
        local xDist = x - TotemPositions[element].x
        local yDist = y - TotemPositions[element].y
        local squareDist = xDist*xDist+yDist*yDist
        return squareDist<=TotemData[totem].range        
    else  -- no coordinates => no range check
        return true
    end]]
end

local lastUnit = 0

-- only check two players per update
local function UpdatePartyRange()
   --[[ for i = 1,2 do
        lastUnit = lastUnit + 1
        if (not inRaid and lastUnit > 4) or (inRaid and lastUnit > 25) then lastUnit = 1 end
        local unit
        if inRaid then
            unit = "raid"..lastUnit
        else
            unit = "party"..lastUnit
        end
        if UnitExists(unit) and not UnitIsUnit(unit, "player") then
            local guid = UnitGUID(unit)
            for nr = 1,4 do
                if XiTimers.timers[nr].timers[1] > 0 then 
                    local range = checkRange(unit,nr)
                    local element = XiTimers.timers[nr].button.element
                    if (not RaidRange[element][guid]) ~= range then
                        if range then RaidRange[element][guid] = nil
                        else RaidRange[element][guid] = true end
                        RaidRangeCount[element] = 0
                        for k,v in pairs(RaidRange[element]) do
                            RaidRangeCount[element] = RaidRangeCount[element] + 1
                        end                    
                    end
                end                    
            end
        end
    end ]]
end

local lastPlayerTotem = 0

local function UpdatePlayerRange()
    --[[ lastPlayerTotem = lastPlayerTotem + 1
    if lastPlayerTotem > 4 then lastPlayerTotem = 1 end
    if XiTimers.timers[lastPlayerTotem].timers[1] > 0 then
        local element = XiTimers.timers[lastPlayerTotem].button.element
        PlayerRange[element] = checkRange("player", lastPlayerTotem)
    end ]]
end

local rangeFrame = CreateFrame("Frame", "TotemTimers_RangeFrame")
rangeFrame:Hide()
TotemTimers.RangeFrame = rangeFrame
rangeFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
rangeFrame:RegisterEvent("GROUP_ROSTER_UPDATE")


local Settings

--[[ rangeFrame:SetScript("OnUpdate", function(self)
    if Settings.CheckRaidRange and (inRaid or inParty) then
        UpdatePartyRange()
    end
    if Settings.CheckPlayerRange then UpdatePlayerRange() end
end) ]]


local function GetUnitData(unit)
    if not UnitExists(unit) then return end
    if not UnitIsUnit(unit, "player") then
        local guid = UnitGUID(unit)
        if not guid then return end
        RaidNames[guid] = UnitName(unit)
		local _
        _,RaidClasses[guid] = UnitClass(unit)
    end   
end


--[[ rangeFrame:SetScript("OnEvent", function(self, event, unit, spellname, spellrank, counter, spellid)
    local _,instance = IsInInstance()
    if instance == "raid" or instance == "pvp" then inRaid = true else inRaid = false end
    if instance == "arena" or instance == "party" then inParty = true else inParty = false end
    if inRaid then
        for i = 1,25 do
            local unit = "raid"..i
            GetUnitData(unit)
        end
    elseif inParty then
        for i = 1,4 do
            local unit = "party"..i
            GetUnitData(unit)
        end
    end
end) ]]


--[[ rangeFrame:SetScript("OnShow", function()
    Settings = TotemTimers.ActiveProfile
end) ]]



function TotemTimers.ResetRange(element)
    wipe(RaidRange[element])
    RaidRangeCount[element] = 0
end



function TotemTimers.GetPlayerRange(element)
    return (not TotemTimers.ActiveProfile.CheckPlayerRange and true) or PlayerRange[element]
end

function TotemTimers.GetOutOfRange(element)
    return RaidRangeCount[element]
end

function TotemTimers.GetOutOfRangePlayers(element)
    return RaidRange[element], RaidNames, RaidClasses
end

function TotemTimers.GetRaidRoles()
    return RaidRoles, RaidClasses
end

--position of totems around player in radians, order fire,earth,water,air
local TotemOffsets = {0.7354,5.4978,3.927,2.3562,}

local sin, cos = math.sin, math.cos

function TotemTimers.SetTotemPosition(element)
  --[[ local x,y = GetPlayerMapPosition("player")
   x = x * mapWidth
   y = y * mapHeight
   local facing = GetPlayerFacing()
   local offsetX = -sin(facing+TotemOffsets[element])
   local offsetY = cos(facing+TotemOffsets[element])
   TotemPositions[element].x = x+offsetX
   TotemPositions[element].y = y+offsetY ]]
end
