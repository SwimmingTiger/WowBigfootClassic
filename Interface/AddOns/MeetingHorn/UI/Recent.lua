-- Recent.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/4/2020, 10:41:15 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local Recent = ns.Addon:NewClass('UI.Recent', 'Frame')

local RecentItem = ns.Addon:NewClass('UI.RecentItem', ns.GUI:GetClass('ViewItem'))

function RecentItem:Constructor()
    self.Text = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    self.Text:SetPoint('CENTER')

    local bg = self:CreateTexture(nil, 'BACKGROUND')
    bg:SetAllPoints(true)
    bg:SetColorTexture(0.588, 0.588, 0.588, 0.05)

    local ht = self:CreateTexture(nil, 'HIGHLIGHT')
    ht:SetAllPoints(true)
    ht:SetColorTexture(0.588, 0.588, 0.588, 0.05)
end

function Recent:Constructor()
    ns.GUI:GetClass('Dropdown'):Bind(self.Instance)
    ns.GUI:GetClass('GridView'):Bind(self.Members)
    ns.UI.QRCodeWidget:Bind(self.QRCode)

    self.Members:SetItemHeight(30)
    self.Members:SetItemClass(RecentItem)
    self.Members:SetColumnCount(3)
    self.Members:SetItemSpacing(3, 3)
    self.Members:SetCallback('OnItemFormatting', function(_, button, info)
        button.Text:SetText(info.name)
        button.Text:SetTextColor(GetClassColor(info.class))
    end)
    self.Members:SetCallback('OnItemMenu', function(_, button, info)
        ns.GUI:ToggleMenu(button, {
            {text = RAID_CLASS_COLORS[info.class]:WrapTextInColorCode(info.name), isTitle = true}, {
                text = WHISPER,
                func = function()
                    ChatFrame_SendTell(info.name)
                end,
            }, {
                text = INVITE,
                func = function()
                    InviteToGroup(info.name)
                end,
            }, {

                text = ADD_FRIEND,
                func = function()
                    C_FriendList.AddFriend(info.name)
                end,
            }, {text = CANCEL},
        })
    end)

    ns.UI.CountdownButton:Bind(self.Invite)

    self.Invite:SetText(L['Invite All'])
    self.Instance.Label:SetText(L['Instance Name'])
    self.QRCode.Label:SetText('微信扫码关注该团长，及时收到开团提醒。')

    self.Instance:SetCallback('OnSelectChanged', function()
        self:UpdateMembers()
        self:UpdateQRCode()
    end)

    self.Invite:SetScript('OnClick', function(btn)
        local list = self.Members:GetItemList()

        for i, info in ipairs(list) do
            if not (UnitInRaid(info.name) or UnitInParty(info.name)) then
                InviteToGroup(info.name)
            end
        end
        btn:SetCountdown(600)
    end)

    self:SetScript('OnShow', self.OnShow)
end

function Recent:OnShow()
    self:UpdateInstances()
    self:UpdateMembers()
end

function Recent:UpdateInstances()
    local menu = {}
    local value

    for i = 1, GetNumSavedInstances() do
        local name, id = GetSavedInstanceInfo(i)
        local members = ns.LFG:GetInstanceMembers(id)
        tinsert(menu, {text = name, value = id, disabled = not members})

        if not value and members then
            value = id
        end
    end

    --[[@debug@
    tinsert(menu, {text = 'Debug', value = -1})
    if not value then
        value = -1
    end
    --@end-debug@]]

    self.Instance:SetMenuTable(menu)
    self.Instance:SetValue(value)
end

function Recent:UpdateMembers()
    local id = self.Instance:GetValue()
    local members = ns.LFG:GetInstanceMembers(id)

    local r = {}

    --[[@debug@
    if id == -1 and not members then
        tinsert(r, {name = 'Test1', class = 'PALADIN'})
        tinsert(r, {name = 'Test2', class = 'MAGE'})
        tinsert(r, {name = 'Test3', class = 'ROGUE'})
        tinsert(r, {name = 'Test4', class = 'WARLOCK'})
        tinsert(r, {name = 'Test5', class = 'WARRIOR'})
        tinsert(r, {name = 'Test6', class = 'SHAMAN'})
        tinsert(r, {name = 'Test7', class = 'HUNTER'})
    end
    --@end-debug@]]

    if members then
        for k, v in pairs(members) do
            if k ~= 'leader' then
                tinsert(r, {name = k, class = v})
            end
        end
        sort(r, function(a, b)
            if a.class == b.class then
                return a.name < b.name
            end
            return a.class < b.class
        end)
    end

    self.Members:SetItemList(r)
    self.Members:Refresh()
end

function Recent:UpdateQRCode()
    local id = self.Instance:GetValue()
    local members = ns.LFG:GetInstanceMembers(id)

    --[[@debug@
    if id == -1 and not members then
        members = {}
        members.leader = ns.UnitFullName('player')
    end
    --@end-debug@]]

    if members then
        self.QRCode:SetValue(ns.MakeQRCode(members.leader))
        self.QRCode:Show()
    else
        self.QRCode:Hide()
    end
end
