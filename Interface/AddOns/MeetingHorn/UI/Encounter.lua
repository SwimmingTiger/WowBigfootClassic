-- Encounter.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/22/2020, 10:01:07 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

---@class MeetingHornUIEncounter
local Encounter = ns.Addon:NewClass('UI.Encounter', 'Frame')

function Encounter:Constructor()
    ns.UI.ListView:Bind(self.BossList)

    self.zoneMenuList = {}

    self.zoneFilter = function(v)
        return not self.zone or v.zone == self.zone
    end

    self.zoneMenuChecked = function(info)
        return self.zone == info.zone
    end

    self.zoneMenuOnClick = function(_, info)
        self.ZoneButton:SetText(info.text)
        self:SetZoneFilter(info.zone)
    end

    self.BossList:SetItemTemplate('MeetingHornEncounterBossButtonTemplate')
    self.BossList:SetCallback('OnItemFormatting', function(_, button, info)
        button:SetText(info.name)
        button.Creature:SetTexture(info.icon)

        if info.bossId == self.bossId then
            button:LockHighlight()
        else
            button:UnlockHighlight()
        end
    end)
    self.BossList:SetCallback('OnItemClick', function(_, button, info)
        self:SetCurrentBoss(info.bossId)
    end)
    self.BossList:SetItemList(self.bosses)

    self.ZoneButton:SetScript('OnClick', function(button)
        ns.GUI:ToggleMenu(button, self.zoneMenuList)
    end)

    ns.GUI:GetClass('Dropdown'):Bind(self.Instance)

    self.Instance:SetMenuTable((function()
        local function Checked(info)
            return self.instanceId == info.value
        end

        local r = {}
        for i, v in ipairs(ns.ENCOUNTER_DATA) do
            tinsert(r, {text = v.title, checkable = true, value = v.instanceId, checked = Checked})
        end
        return r
    end)())
    self.Instance:SetCallback('OnSelectChanged', function()
        return self:SetCurrentInstance(self.Instance:GetValue())
    end)

    self.selectedTab = 1
    self:SetupTabs({{L['职责攻略'], self.Panel1}, {L['技能'], self.Panel2}, {L['视频攻略'], self.Panel3}})

    ns.UI.EncounterInfoPanel:Bind(self.Panel1)
    ns.UI.EncounterInfoPanel:Bind(self.Panel2)

    self.Panel3.Label:SetText('PC查看视频及站位请按<Ctrl+C>复制地址到浏览器打开')

    self:Open(ns.DEFAULT_ENCOUNTER_INSTANCE_ID)

    self:SetScript('OnShow', self.OnShow)
end

function Encounter:OnShow()
    ns.Stats:Send('EncounterOpen')
end

function Encounter:SetZoneFilter(zone)
    self.zone = zone
    self.BossList:SetItemList(tFilter(self.instanceInfo.bosses, self.zoneFilter, true))
end

function Encounter:SetCurrentBoss(bossId)
    local info = ns.ENCOUNTER_BOSSES[bossId]
    self.bossId = bossId
    self.BossTitle:SetText(info.name)
    self.BossList:Refresh()
    self.Panel1:SetInfo(info.summary, info.desc, true)
    self.Panel2:SetInfo(info.abilities, info.desc)

    if info.url then
        self.Panel3.Url.text = info.url
        self.Panel3.Url:SetText(info.url)
        self.Tab3:Show()
    else
        self.Tab3:Hide()

        if self.selectedTab == 3 then
            self:SetTab(1)
        end
    end
end

function Encounter:SetCurrentInstance(instanceId, bossId)
    if self.instanceId ~= instanceId then
        self.instanceId = instanceId
        self.instanceInfo = ns.ENCOUNTER_INSTANCES[instanceId]
        self.ZoneButton:SetText(ALL)
        self.Title:SetText(self.instanceInfo.title)
        self.Instance:SetValue(instanceId)

        local menu = wipe(self.zoneMenuList)
        tinsert(menu, {
            text = ALL,
            checkable = true,
            isRatio = true,
            func = self.zoneMenuOnClick,
            checked = self.zoneMenuChecked,
        })

        for i, v in ipairs(self.instanceInfo.zones) do
            tinsert(menu, {
                text = v.text,
                zone = v.zone,
                checkable = true,
                isRatio = true,
                func = self.zoneMenuOnClick,
                checked = self.zoneMenuChecked,
            })
        end

        self:SetZoneFilter(nil)

        if not bossId then
            bossId = self.instanceInfo.bosses[1].bossId
        end
    end

    if bossId then
        self:SetCurrentBoss(bossId)
    end
end

function Encounter:SetupTabs(tabs)
    local function UpdateTabs(tab)
        self.selectedTab = tab:GetID()
        self:UpdateTabs()
    end

    for i, v in ipairs(tabs) do
        local tab = self.Tabs[i]
        tab.frame = v[2]
        tab.tooltip = v[1]
        tab:HookScript('OnClick', UpdateTabs)
    end

    self:UpdateTabs()
end

function Encounter:UpdateTabs()
    for i, tab in ipairs(self.Tabs) do
        local selected = self.selectedTab == i
        tab:SetEnabled(not selected)
        tab.Selected:SetShown(selected)
        tab.Unselected:SetShown(not selected)
        tab.frame:SetShown(selected)

        if selected then
            tab:LockHighlight()
        else
            tab:UnlockHighlight()
        end
    end
end

function Encounter:SetTab(tab)
    self.selectedTab = tab
    self:UpdateTabs()
end

function Encounter:Open(instanceId, bossId, tab)
    self:SetCurrentInstance(instanceId, bossId)

    if tab then
        self:SetTab(tab)
    end
end

function Encounter:GetCurrent()
    return self.instanceId, self.bossId
end

local function ChatWalkNode(node, channel)
    if node.title then
        SendChatMessage(node.title, channel)
    end
    if node.desc then
        for _, line in ipairs {strsplit('\n', node.desc)} do
            SendChatMessage(line, channel)
        end
    end

    if node.children then
        for i, v in ipairs(node.children) do
            ChatWalkNode(v, channel)
        end
    end
end

function Encounter:SendChat(info, channel)
    local instance = ns.ENCOUNTER_INSTANCES[self.instanceId]
    local boss = ns.ENCOUNTER_BOSSES[self.bossId]

    SendChatMessage(instance.title .. ' ' .. boss.name .. ' ' .. ns.ROLE_TIPS[info.role], channel)

    ChatWalkNode(info, channel)

    self.cooldown = GetTime()
    ns.Addon:SendMessage('ENCOUNTER_CHAT_COOLDOWN')

    if self.cooldownTimer then
        self.cooldownTimer:Cancel()
    end
    self.cooldownTimer = C_Timer.NewTimer(60, function()
        self.cooldown = nil
        ns.Addon:SendMessage('ENCOUNTER_CHAT_COOLDOWN')
    end)
end

function Encounter:GetChatCooldown()
    return self.cooldown or 0, 60
end
