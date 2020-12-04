-- EncounterInfoPanel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/28/2020, 12:56:11 PM
--
---@type ns
local ns = select(2, ...)

---@class EncounterInfoPanel: Frame
---@field Overview EncounterInfoOverview
local EncounterInfoPanel = ns.Addon:NewClass('UI.EncounterInfoPanel', 'ScrollFrame')
Mixin(EncounterInfoPanel, ns.UI.EncounterInfoBase)

EncounterInfoPanel.overviewFixedHeight = 10

function EncounterInfoPanel:Constructor()
    self.children = {}
end

function EncounterInfoPanel:RequestRender()
    self:SetScript('OnUpdate', self.OnUpdateRender)
end

function EncounterInfoPanel:RequestAdjustHeight()
    self:SetScript('OnUpdate', self.OnUpdateAdjustHeight)
end

function EncounterInfoPanel:OnUpdateRender()
    self:OnRender()
    self:RequestAdjustHeight()
end

function EncounterInfoPanel:OnUpdateAdjustHeight()
    self:SetScript('OnUpdate', nil)
    self:OnAdjustHeight()
end

function EncounterInfoPanel:OnRender()
    for i, child in ipairs(self.children) do
        child:Free()
    end
    wipe(self.children)

    ns.UI.EncounterInfoBase.SetInfo(self, self.info, self.sortChildren)
end

function EncounterInfoPanel:OnAdjustHeight()
    self:AdjustHeight()
end

function EncounterInfoPanel:SetInfo(info, desc, sortChildren)
    self.info = info or {desc = '暂无'}
    self.info.desc = desc or self.info.desc
    self.sortChildren = sortChildren
    self:RequestRender()
end
