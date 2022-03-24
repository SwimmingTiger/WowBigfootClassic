-- EncounterInfoBase.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/29/2020, 12:51:41 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local EncounterInfoBase = {}
local EncounterInfoPool = {}
ns.UI.EncounterInfoBase = EncounterInfoBase
ns.UI.EncounterInfoPool = EncounterInfoPool

local ROLE_COORDS = {
    TANK = {0, 32 / 256, 0, 32 / 64},
    HEALER = {64 / 256, 96 / 256, 0, 32 / 64},
    DAMAGER = {32 / 256, 64 / 256, 0, 32 / 64},
    MELEE = {32 / 256, 64 / 256, 0, 32 / 64},
    RANGE = {32 / 256, 64 / 256, 0, 32 / 64},
}

local ROLE_TIPS = {
    TANK = ENCOUNTER_JOURNAL_SECTION_FLAG0,
    DAMAGER = ENCOUNTER_JOURNAL_SECTION_FLAG1,
    HEALER = ENCOUNTER_JOURNAL_SECTION_FLAG2,
    MELEE = L['近战输出者预警'],
    RANGE = L['远程输出者预警'],
}
ns.ROLE_TIPS = ROLE_TIPS

local ROLE_TITLES = {TANK = TANK, HEALER = HEALER, DAMAGER = DAMAGER, MELEE = MELEE, RANGE = RANGED}

function EncounterInfoBase:AdjustHeight()
    local height = self.fixedHeight or 0

    if self.Overview:IsVisible() then
        local h = self.Overview.Text:GetStringHeight() + (self.overviewFixedHeight or 0)
        self.Overview:SetHeight(h)
        height = height + h
    end

    if self.Children:IsVisible() then
        local h = 0
        for i, child in ipairs(self.children) do
            h = h + child:AdjustHeight()
        end
        self.Children:SetHeight(h)
        height = height + h
    end

    if self.FootOverview:IsVisible() then
        local h = self.FootOverview.Text:GetStringHeight() + (self.overviewFixedHeight or 0)
        self.FootOverview:SetHeight(h)
        height = height + h
    end

    self:SetHeight(height)
    return height
end

function EncounterInfoBase:SetInfo(info, sortChildren)
    self.info = info
    if self.Overview then
        if info.desc then
            self.desc = true
            self.Overview.Text:SetText(info.desc)
            self.Overview:Show()
        else
            self.desc = nil
            self.Overview:Hide()
            self.Overview:SetHeight(5)
        end
    end
    if self.FootOverview then
        if info.footDesc then
            self.footDesc = true
            self.FootOverview.Text:SetText(info.footDesc)
            self.FootOverview:Show()
        else
            self.footDesc = nil
            self.FootOverview:Hide()
        end
    end
    if self.Button then
        self.Button.IconButton:Hide()
        if info.role then
            local coords = ROLE_COORDS[info.role]
            if coords then
                self.Button.IconButton.Icon:SetTexCoord(unpack(coords))
                self.Button.IconButton:Show()
                self.Button.IconButton.tooltip = ROLE_TIPS[info.role]
            end

            self.Button.ChatButton:Show()
        else
            self.Button.ChatButton:Hide()
        end

        local spellName, spellIcon, _
        if info.spell then
            spellName, _, spellIcon = GetSpellInfo(info.spell)
        end

        local title = info.title or spellName or ROLE_TITLES[info.role]

        self.Button.Title:SetText(title)

        if spellIcon then
            self.Button.AbilityIcon:SetTexture(spellIcon)
            self.Button.AbilityIcon:Show()
            self.Button.Title:SetPoint('LEFT', self.Button.AbilityIcon, 'RIGHT', 5, 0)
        else
            self.Button.AbilityIcon:Hide()
            self.Button.Title:SetPoint('LEFT', self.Button.ExpandedIcon, 'RIGHT', 5, 0)
        end
    end

    if self.Title then
        self.Title.Text:SetText(info.title)
    end

    if info.children and #info.children > 0 then
        local OnChildSizeChanged = function()
            C_Timer.After(0, function()
                return self:AdjustHeight()
            end)
        end

        local children
        if not sortChildren then
            children = info.children
        else
            children = {}
            for i, v in ipairs(info.children) do
                if v.role and ns.PlayerIsRole(v.role) then
                    tinsert(children, 1, v)
                else
                    tinsert(children, v)
                end
            end
        end

        for i, v in ipairs(children) do
            local child
            if v.noCollapse then
                child = ns.UI.EncounterInfoSummary:Alloc(self.Children)
            else
                child = ns.UI.EncounterInfo:Alloc(self.Children)
            end

            child:ClearAllPoints()
            if i == 1 then
                child:SetPoint('TOPLEFT')
                child:SetPoint('TOPRIGHT')
            else
                child:SetPoint('TOPLEFT', self.children[i - 1], 'BOTTOMLEFT', 0, 0)
                child:SetPoint('TOPRIGHT', self.children[i - 1], 'BOTTOMRIGHT', 0, 0)
            end

            child:SetInfo(v)
            child:Show()
            child:SetScript('OnSizeChanged', OnChildSizeChanged)

            tinsert(self.children, child)
        end

        self.Children:Show()
    else
        self.Children:Hide()
    end

    if self.Expand then
        if info.role and not info.spell and ns.PlayerIsRole(info.role) then
            self.expanded = true
        elseif info.expanded then
            self.expanded = true
        end
    end

    if self.UpdateState then
        self:UpdateState()
    end
end

function EncounterInfoPool:Alloc(parent)
    local obj = tremove(self.free)
    if not obj then
        obj = self:Create(parent)
    end
    obj:SetParent(parent)
    if obj.OnAlloc then
        obj:OnAlloc()
    end
    return obj
end

function EncounterInfoPool:Free()
    for i, child in ipairs(self.children) do
        child:Free()
    end
    wipe(self.children)
    self:SetScript('OnSizeChanged', nil)
    self:Hide()
    self:ClearAllPoints()
    self:SetParent(UIParent)
    self:OnFree()
    tinsert(self.free, self)
end
