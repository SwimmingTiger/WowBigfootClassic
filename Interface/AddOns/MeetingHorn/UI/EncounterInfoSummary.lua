-- EncounterInfoSummary.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/29/2020, 1:38:48 PM
--
---@type ns
local ns = select(2, ...)

local EncounterInfoSummary = ns.Addon:NewClass('UI.EncounterInfoSummary', 'Frame')
Mixin(EncounterInfoSummary, ns.UI.EncounterInfoBase, ns.UI.EncounterInfoPool)

EncounterInfoSummary.free = {}
EncounterInfoSummary.fixedHeight = 30
EncounterInfoSummary.overviewFixedHeight = 10

function EncounterInfoSummary:Constructor()
    self.children = {}
end

function EncounterInfoSummary:Create(parent)
    return self:Bind(CreateFrame('Frame', nil, parent, 'MeetingHornEncounterInfoSummaryTemplate'))
end

function EncounterInfoSummary:OnFree()
end
