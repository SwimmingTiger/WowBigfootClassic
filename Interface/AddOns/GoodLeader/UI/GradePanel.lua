-- GradePanel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/10/2020, 10:50:28 AM

---@type ns
local ns = select(2, ...)

local L = ns.L

---@class GoodLeaderGradePanel: Frame
---@field Title FontString
---@field SubTitle FontString
---@field Label1 FontString
---@field Tags GoodLeaderTagsContainer
---@field raid GoodLeaderRaidData
local GradePanel = ns.Addon:NewClass('UI.GradePanel', 'Frame.GoodLeaderGradePanelTemplate')

function GradePanel:Constructor()
    self:Hide()
    self.SubTitle:SetText(L['恭喜完成BOSS击杀！'])
    self.Label2:SetText(L['给团长评价些有趣的标签吧'])

    self.Commit:SetScript('OnClick', function()
        self:CommitGrade()
        self:Hide()
    end)

    self.scores = {}

    local function SetupScore(obj, label, icon)
        obj.Text:SetText(label)
        obj.Texture:SetTexture(icon)
        tinsert(self.scores, obj)
    end

    SetupScore(self.Score1, L['指挥：'], [[Interface\AddOns\GoodLeader\Media\Spell_Holy_Stoicism]])
    SetupScore(self.Score2, L['公正：'], [[Interface\AddOns\GoodLeader\Media\PVECurrency-Justice]])
    SetupScore(self.Score3, L['运势：'], [[Interface\AddOns\GoodLeader\Media\INV_Misc_Herb_GoldClover]])

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
end

function GradePanel:OnShow()
    self.Title:SetText(self.raid.raidName)
    self.Label1:SetFormattedText(L['请就本次团长|cffffd100%s|r的表现给予评分'], self.raid.leader)
    self.Tags:SetTags(ns.Addon:GetGradeTags())

    local logo = ns.RAID_LOGO[self.raid.raidName]
    if logo then
        self.Logo:SetTexture(logo)
        self.Logo:Show()
    else
        self.Logo:Hide()
    end

    for i, frame in ipairs(self.scores) do
        frame.Score:SetValue(4)
    end
end

function GradePanel:OnHide()
    ns.Grade:ClosePanel()
end

function GradePanel:GetScores()
    local scores = {}
    for i, frame in ipairs(self.scores) do
        scores[i] = frame.Score:GetValue()
    end
    return scores
end

function GradePanel:CommitGrade()
    ns.Grade:Grade(self.raid, self:GetScores(), self.Tags:GetCheckedTags())
end

function GradePanel:SetRaidData(raid)
    self.raid = raid
end
