
-------------------------------------
-- PVP信息 @todo
-- @Author: M
-- @DepandsOn: InspectUnitStats
-- @DepandsOn: InspectUnitStatsHonor.lua
-------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local MAX_ARENA_TEAMS = MAX_ARENA_TEAMS or 3
local GetArenaTeam = GetArenaTeam or function() end
local GetInspectArenaTeamData = GetInspectArenaTeamData or function() end

-- @attachTrigger:INSPECT_STATSFRAME_SHOW
LibEvent:attachTrigger("INSPECT_STATSFRAME_SHOW", function(self, frame)
    local unit = frame.data.unit or "player"

end)

-- inspect's PVP
LibEvent:attachEvent("INSPECT_HONOR_UPDATE", function(self)
    local _, teamName, teamSize, teamRating, playerRating
    for i = 1, MAX_ARENA_TEAMS do
        teamName, teamSize, teamRating, _, _, _, playerRating = GetInspectArenaTeamData(i)
        if teamSize == 2 then
            
        elseif teamSize == 3 then
            
        elseif teamSize == 5 then
            
        end
    end
end)

-- player's PVP
LibEvent:attachEvent("ARENA_TEAM_UPDATE", function(self)
    local _, teamName, teamSize, teamRating, playerRating
    for i = 1, MAX_ARENA_TEAMS do
        teamName, teamSize, teamRating, _, _, _, playerRating = GetInspectArenaTeamData(i)
        if teamSize == 2 then
            
        elseif teamSize == 3 then
            
        elseif teamSize == 5 then
            
        end
    end
end)
