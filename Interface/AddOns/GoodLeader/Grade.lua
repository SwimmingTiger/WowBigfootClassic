
---@type ns
local ns = select(2, ...)

---@class GoodLeaderRaidData
---@field leader string
---@field leaderGuid string
---@field raidName string
---@field timestamp number

---@class GoodLeaderGrade
---@field db table<string, GoodLeaderRaidData>
---@field panel GoodLeaderGradePanel
local Grade = ns.Addon:NewModule('Grade', 'AceEvent-3.0')

function Grade:OnInitialize()
    self.db = ns.Addon.db.profile.cache
    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:RegisterEvent('ENCOUNTER_END')
end

function Grade:GROUP_ROSTER_UPDATE()
    C_Timer.After(1, function()
        if not ns.IsInGroup() then
            self:ShowPanel()
        end
    end)
end

function Grade:ENCOUNTER_END(_, bossId, _, _, _, success)
    if success ~= 1 then
        return
    end

    local raidName = GetInstanceInfo()
    if not raidName then
        return
    end

    local data = self.db[raidName]
    if not data then
        data = {}
        self.db[raidName] = data
    end

    data.leader, data.leaderGuid = ns.GetGroupLeader()
    data.raidName = raidName
    data.timestamp = time()
end

function Grade:PickRaidData()
    local best
    for k, v in pairs(self.db) do
        if not best or v.timestamp < best.timestamp then
            best = v
        end
    end
    if best then
        self.db[best.raidName] = nil
    end
    return best
end

function Grade:ShowPanel()
    if self.panel and self.panel:IsShown() then
        return
    end

    local raid = self:PickRaidData()
    if not raid then
        return
    end

    if UnitIsUnit('player', raid.leader) then
        return self:ShowPanel()
    end

    if not self.panel then
        self.panel = ns.UI.GradePanel:New(UIParent)
    end
    self.panel:SetRaidData(raid)
    StaticPopupSpecial_Show(self.panel)
end

function Grade:ClosePanel()
    StaticPopupSpecial_Hide(self.panel)

    self:GROUP_ROSTER_UPDATE()
end

---@param raid GoodLeaderRaidData
function Grade:Grade(raid, scores, tags)
    ns.Addon:SendServer('SRS', raid.leader, raid.leaderGuid, raid.raidName, scores, tags)
end
