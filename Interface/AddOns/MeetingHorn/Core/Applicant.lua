-- Applicant.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/16/2019, 10:25:09 AM

---@type ns
local ns = select(2, ...)

local APPLICANT_STATUS = ns.APPLICANT_STATUS

---@class MeetingHornApplicant
---@field private name string
---@field private guid string
---@field private class string
---@field private classFileName string
---@field private race string
---@field private state APPLICANT_STATUS
local Applicant = ns.Addon:NewClass('Applicant')

function Applicant:Constructor(name, class, race, level)
    self.name = name
    self:Update(class, race, level)
end

function Applicant:GetName()
    return self.name
end

function Applicant:GetGUID()
    return self.guid
end

function Applicant:GetClass()
    return self.class
end

function Applicant:GetClassFileName()
    return self.classFileName
end

function Applicant:GetRace()
    return self.race
end

function Applicant:Update(class, race, level)
    self.class = ns.GetClassLocale(class)
    self.classFileName = class
    self.race = race
    self.level = level
    self.state = nil
    self.tick = time()
end

function Applicant:IsTimeOut()
    return time() - self.tick > 300
end

function Applicant:StartCooldown()
    self.start = time()
    self.duration = 60
end

function Applicant:SetState(state)
    self.state = state
end

function Applicant:GetState()
    if ns.UnitInGroup(self.name) then
        return APPLICANT_STATUS.Joined
    end
    return self.state
end

function Applicant:GetCooldown()
    if not self.start then
        return 0
    end
    return self.start + self.duration - time()
end
