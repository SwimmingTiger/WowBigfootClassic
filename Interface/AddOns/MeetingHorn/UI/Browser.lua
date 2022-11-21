---@type ns
local ns = select(2, ...)

local L = ns.L

---@class MeetingHornUIBrowser: ScrollFrame
---@field sortId number
---@field sortOrder number
---@field private ActivityList ListView
---@field private Activity Button
---@field private Mode Button
---@field private Header1 Button
---@field private Header2 Button
---@field private Header3 Button
---@field private Header4 Button
local Browser = ns.Addon:NewClass('UI.Browser', 'Frame')

function Browser:Constructor()
    self.Empty.Text:SetText(L['There are no activity, please try searching.'])

    self.Header1:SetText(L['Activity'])
    self.Header2:SetText(L['Mode'])
    self.Header3:SetText(L['Members'])
    self.Header4:SetText(L['Leader'])
    self.Header5:SetText(L['Comment'])
    self.Header6:SetText(L['Operation'])
    self.Header7:SetText(L['Certification'])
    self.Header8:SetText(L['LeaderQrCode'])
    -- self.Header1:Disable()
    self.Header2:Disable()
    self.Header3:Disable()
    self.Header4:Disable()
    self.Header5:Disable()
    self.Header6:Disable()
    self.Header7:Disable()
    self.Header8:Disable()

    -- self.CreateButton:SetText(L['Create Activity'])
    self.ActivityLabel:SetText(L['Activity'])
    self.ModeLabel:SetText(L['Activity Mode'])
    self.SearchLabel:SetText(SEARCH .. L['(Include channel message)'])
    self.ProgressBar.Loading:SetText(L['Receiving active data, please wait patiently'])
    self.ProgressBar:SetMinMaxValues(0, 1)
    self.IconTip:SetText(L['图示'])
    self.IconTip:SetNormalFontObject('GameFontHighlightSmall')
    self.IconTip:SetHighlightFontObject('GameFontNormalSmall')
    self.IconTip:SetScript('OnEnter', function()
        GameTooltip:SetOwner(self.IconTip, 'ANCHOR_RIGHT')
        GameTooltip:SetText(L['图示'])
        GameTooltip:AddLine(format(
                                [[|TInterface\AddOns\MeetingHorn\Media\certification_icon:16:46:0:0:64:64:0:64:19:41|t %s]],
                                L['星团长（按开团次数获取，仅供参考）']), 1, 1, 1)
        GameTooltip:Show()
    end)
    self.IconTip:SetScript('OnLeave', GameTooltip_Hide)
    ns.GUI:GetClass('Dropdown'):Bind(self.Activity)
    ns.GUI:GetClass('Dropdown'):Bind(self.Mode)

    ns.ApplyImageButton(self.ApplyLeaderBtn, {
        text = '申请星团长',
        summary = '微信扫码 申请星团长',
        texture = [[Interface/AddOns/MeetingHorn/Media/ApplyLeaderQR]],
        points = {'BOTTOMLEFT', self, 'BOTTOMRIGHT', 5, -25},
    })
    ns.ApplyImageButton(self.RechargeBtn, {
        text = '直充专区',
        summary = '支付宝/微信扫码登录充值更便捷时时有特惠',
        texture = [[Interface/AddOns/MeetingHorn/Media/RechargeQR]],
        points = {'BOTTOMLEFT', self, 'BOTTOMRIGHT', 5, -25},
    })

    local function Search()
        return self:Search()
    end

    local function QuickButtonOnClick(button)
        if button.id then
            self.Activity:SetValue(button.id)
        elseif button.search then
            self.Input:SetText(button.search)
        end
    end

    local index = 1
    local function AllocQuick()
        local button = self.quicks[index]
        index = index + 1
        return button
    end

    local function SetupQuickButton(search)
        local button = AllocQuick()
        local id
        if type(search) == 'number' then
            local mapName = C_Map.GetAreaInfo(search)
            id = ns.NameToId(mapName) or ns.MatchId(mapName)

            local data = ns.GetActivityData(id)
            if data then
                search = data.shortName or data.name
                search = search:gsub('（.+）', '')
            end
        end

        button:SetText(search)
        button:SetWidth(button:GetTextWidth())
        button:SetScript('OnClick', QuickButtonOnClick)
        button:Show()
        button.id = id
        button.search = search
    end

    --[=[@classic@
    SetupQuickButton(2717)
    SetupQuickButton(1977)
    SetupQuickButton(2677)
    SetupQuickButton(3429)
    SetupQuickButton(3428)
    SetupQuickButton(3456)
    --@end-classic@]=]

    --[=[@bcc@
    SetupQuickButton(4075)
    SetupQuickButton(3959)
    SetupQuickButton(3805)
    SetupQuickButton(3606)
    SetupQuickButton(3845)
    SetupQuickButton(3607)
    SetupQuickButton(3457)
    SetupQuickButton(3923)
    SetupQuickButton(3836)
    SetupQuickButton('5H')
    --@end-bcc@]=]

    -- @lkc@
    SetupQuickButton('5H')
    SetupQuickButton('NAXX')
    SetupQuickButton('ULD')
    SetupQuickButton('TOC')
    SetupQuickButton('ICC')
    SetupQuickButton('OS')
    SetupQuickButton('EOE')
    SetupQuickButton('宝库')
    SetupQuickButton('黑龙')
    SetupQuickButton('红玉')
    -- @end-lkc@

    self.Activity:SetMenuTable(ns.ACTIVITY_FILTER_MENU)
    self.Activity:SetDefaultText(ALL)
    self.Activity:SetCallback('OnSelectChanged', function()
        if forbidCallBack then
            return
        end
        local activityId = tonumber(self.Activity:GetValue())
        local activityData = activityId and ns.GetActivityData(activityId)
        self.Input:SetText(activityData and activityData.shortName or '')
        self:Search()
    end)
    self.Activity:SetMaxItem(20)

    self.Mode:SetMenuTable(ns.MODE_FILTER_MENU)
    self.Mode:SetDefaultText(ALL)
    self.Mode:SetCallback('OnSelectChanged', Search)
    self.Mode:SetMaxItem(20)

    self.Input:HookScript('OnTextChanged', Search)

    ns.UI.ListView:Bind(self.ActivityList)

    self.ActivityList:SetItemTemplate('MeetingHornAcitvityTemplate')
    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemFormatting', function(_, button, item)
        local inApplicant = item:GetCooldown() > 0
        local inActivity = ns.UnitInGroup(item:GetLeader()) or UnitIsUnit(item:GetLeader(), 'player')
        -- local canSignup = not IsInGroup(LE_PARTY_CATEGORY_HOME) and not ns.LFG:GetCurrentActivity()
        local state
        if inActivity then
            state = LFG_LIST_APP_INVITE_ACCEPTED
        elseif inApplicant then
            state = L['Applicanted']
        end
        button.Name:SetText(item:GetTitle())
        button.Leader:SetText(item:GetLeader())
        button.Comment:SetText(item:GetComment())
        button.Mode:SetText(item:GetMode())
        button.Leader:SetTextColor(GetClassColor(item:GetLeaderClass()))
        --[=[@classic@
        button.Comment:SetWidth(item:IsActivity() and 290 or 360)
        --@end-classic@]=]

        -- @lkc@
        if item:GetCertificationLevel() then
            button.Icon:SetTexture(string.format([[Interface\AddOns\MeetingHorn\Media\certification_icon_%d]],
                                                 item:GetCertificationLevel()))
            button.Icon:SetShown(true)
        else
            button.Icon:SetShown(false)
        end
        button.Comment:SetWidth(item:IsActivity() and 250 or 320)
        -- @end-lkc@
        local members = item:GetMembers()
        if members then
            members = format('%d/%d', members, item.data.members)
            button.Members:SetText([[|TInterface\AddOns\MeetingHorn\Media\DataBroker:16:16:0:0:64:32:32:64:0:32|t ]] ..
                                       members)
        else
            button.Members:SetText('-')
        end

        button.State:SetShown(state)
        button.State:SetText(state)
        button.State:SetTextColor(GREEN_FONT_COLOR:GetRGB())

        button.Signup:SetText(L['Whisper'])
        button.Signup:SetShown(item:IsActivity() and not state)
        -- button.Signup:SetEnabled(canSignup)

        local sameInstance
        if item:HaveProgress() then
            button.Instance:SetWidth(16)
            sameInstance = item:IsSameInstance()
            button.Instance.Same:SetShown(sameInstance)
            button.Instance.Diff:SetShown(not sameInstance)
        else
            button.Instance:SetWidth(1)
            button.Instance.Same:Hide()
            button.Instance.Diff:Hide()
        end

        button.NormalBg:SetShown(not sameInstance)
        button.SameInstanceBgLeft:SetShown(sameInstance)
        button.SameInstanceBgRight:SetShown(sameInstance)
        button.QRIcon:SetShown(item:IsOurAddonCreate())
        if item:IsOurAddonCreate() then
            button.QRIcon:SetScript('OnClick', function()
                if not self.QRTooltip then
                    self.QRTooltip = CreateFrame('Frame', nil, self, 'MeetingHornActivityTooltipTemplate')
                    self.QRTooltip:SetPoint('TOPLEFT', self.Header5, 'BOTTOMLEFT', 0, 0)
                    ns.UI.QRCodeWidget:Bind(self.QRTooltip.QRCode)
                end
                self.QRTooltip.QRCode:SetValue(ns.MakeQRCode(item:GetLeader()))
                self.QRTooltip:Show()
            end)
        end

        --[=[@classic@
        button.Instance:ClearAllPoints()
        button.Instance:SetPoint('RIGHT', button, 'LEFT', 155, 0)
        button.Name:SetPoint('LEFT', 5, 0)
        --@end-classic@]=]
    end)
    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemSignupClick', function(_, button, item)
        if item:IsActivity() then
            -- ns.LFG:SignupActivity(item)
            ChatFrame_SendTell(item:GetLeader())
        end
    end)
    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemDoubleClick', function(_, _, item)
        if not item:IsActivity() then
            ChatFrame_SendTell(item:GetLeader())
        end
    end)
    self.ActivityList:SetCallback('OnItemRightClick', function(_, button, item)
        self:OpenActivityMenu(item, button)
    end)
    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemEnter', function(_, button, item)
        local r, g, b = GetClassColor(item:GetLeaderClass())
        GameTooltip:SetOwner(self, 'ANCHOR_NONE')
        GameTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 8, 60)
        GameTooltip:SetText(item:GetTitle())
        GameTooltip:AddLine(item:GetLeader(), r, g, b)
        local level = item:GetLeaderLevel()
        if level then
            local color = GetQuestDifficultyColor(level)
            GameTooltip:AddLine(format('%s |cff%02x%02x%02x%s|r', LEVEL, color.r * 255, color.g * 255, color.b * 255,
                                       item:GetLeaderLevel()), 1, 1, 1)
        end
        GameTooltip:AddLine(item:GetComment(), 0.6, 0.6, 0.6, true)
        GameTooltip:AddLine(' ')

        if not item:IsActivity() then
            GameTooltip:AddLine(L['<Double-Click> Whisper to player'], 1, 1, 1)
        end
        GameTooltip:AddLine(L['<Right-Click> Open activity menu'], 1, 1, 1)
        GameTooltip:Show()
    end)
    self.ActivityList:SetCallback('OnItemLeave', GameTooltip_Hide)

    self.Reset:SetScript('OnClick', function()
        self.Activity:SetValue(nil)
        self.Mode:SetValue(nil)
        self.Input:SetText('')
        self.sortOrder = nil
        self.sortId = nil
        self:Search()
    end)

    self.Refresh:SetScript('OnClick', Search)

    -- self.CreateButton:SetScript('OnClick', function()
    --     ns.Addon.MainPanel:SetTab(2)
    -- end)

    self.progressTimer = ns.Timer:New(function()
        self:UpdateProgress()
    end)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
    -- self:Show()

    --[=[@classic@
    self.Header1:ClearAllPoints()
    self.Header1:SetPoint('BOTTOMLEFT', self.ActivityList, 'TOPLEFT', 2, 5)
    self.Header7:SetShown(false)
    self.Header5:SetWidth(290)
    --@end-classic@]=]

end

function Browser:OnShow()
    self:RegisterMessage('MEETINGHORN_ACTIVITY_ADDED')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_UPDATE')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_REMOVED')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_FILTER_UPDATED', 'Search')
    self:RegisterMessage('MEETINGHORN_CHANNEL_READY')
    self:Search()
    self:UpdateProgress()
end

function Browser:OnHide()
    self:UnregisterAllMessages()

    if self.QRTooltip then
        self.QRTooltip:Hide()
    end
end

function Browser:UpdateProgress()
    if not self.startTime or GetTime() - self.startTime > 50 then
        self.ProgressBar:Hide()
        self.progressTimer:Stop()
    elseif self.ProgressBar:IsShown() then
        self.ProgressBar:SetValue((GetTime() - self.startTime) / 50)
    else
        self.progressTimer:Start(1)
        self.ProgressBar:Show()
        self.ProgressBar:SetValue(0)
    end

    -- @lkc@
    self.IconTip:SetShown(not self.ProgressBar:IsShown())
    -- @end-lkc@
end

function Browser:OnClick(id)
    if id == self.sortId then
        self.sortOrder = (self.sortOrder + 1) % 2
    else
        self.sortId = id
        self.sortOrder = 0
    end
    self:Sort()
end

function Browser:Sort()
    local sortCall = function()
        sort(self.ActivityList:GetItemList(), function(a, b)
            -- @lkc@
            local acl, bcl = a:GetCertificationLevel(), b:GetCertificationLevel()
            if acl or bcl then
                if acl and bcl then
                    return acl > bcl
                else
                    return acl
                end
            end
            if not self.sortId then
                return false
            end
            -- @end-lkc@
            local aid, bid = a:GetActivityId(), b:GetActivityId()
            if aid == bid then
                return a:GetTick() < b:GetTick()
            end

            if aid == 0 then
                return false
            elseif bid == 0 then
                return true
            end

            if self.sortOrder == 0 then
                return aid < bid
            else
                return bid < aid
            end
        end)
        self.ActivityList:Refresh()
    end

    -- @lkc@
    sortCall()
    -- @end-lkc@
    if self.sortId then
        --[=[@classic@
        sortCall()
        --@end-classic@]=]
        self.Sorter:Show()
        self.Sorter:SetParent(self['Header' .. self.sortId])
        self.Sorter:ClearAllPoints()
        self.Sorter:SetPoint('RIGHT', self['Header' .. self.sortId], 'RIGHT', -5, 0)

        if self.sortOrder == 0 then
            self.Sorter:SetTexCoord(0, 0.5, 0, 1)
        else
            self.Sorter:SetTexCoord(0, 0.5, 1, 0)
        end
    else
        self.Sorter:Hide()
    end
end

function Browser:Search()
    self.updateCount = 0
    self.Refresh.SpellHighlightAnim:Stop()
    self.Refresh.SpellHighlightTexture:Hide()

    local activityFilter = self.Activity:GetValue()
    local modeId = self.Mode:GetValue()
    local search = self.Input:GetText()
    local path, activityId

    if type(activityFilter) == 'string' then
        path = activityFilter
    else
        activityId = activityFilter
    end

    local result = ns.LFG:Search(path, activityId, modeId, search)
    self.ActivityList:SetItemList(result)
    self:Sort()
    self.ActivityList:Refresh()
    self.Empty.Text:SetShown(#result == 0)
end

function Browser:MEETINGHORN_ACTIVITY_ADDED()
    if ns.Addon.MainPanel:IsMouseOver() then
        self.updateCount = (self.updateCount or 0) + 1

        if self.updateCount > 5 then
            self.Refresh.SpellHighlightAnim:Play()
            self.Refresh.SpellHighlightTexture:Show()
        end
    end
end

function Browser:MEETINGHORN_ACTIVITY_UPDATE()
    if ns.Addon.MainPanel:IsMouseOver() then
        self.ActivityList:Refresh()
    else
        self:Search()
    end
end

function Browser:MEETINGHORN_ACTIVITY_REMOVED(_, activity)
    local list = self.ActivityList:GetItemList()
    for i, v in ipairs(list) do
        if v:GetLeaderGUID() == activity:GetLeaderGUID() then
            table.remove(list, i)
            break
        end
    end
    self.ActivityList:Refresh()
end

function Browser:MEETINGHORN_CHANNEL_READY()
    self.startTime = GetTime()
    self:UpdateProgress()
end

function Browser:OpenActivityMenu(activity, button)
    if not activity:IsSelf() then
        ns.GUI:ToggleMenu(button, self:CreateActivityMenu(activity), 'cursor')
    end
end

function Browser:CreateActivityMenu(activity)
    return {
        {
            text = format('|c%s%s|r', select(4, GetClassColor(activity:GetLeaderClass())), activity:GetLeader()),
            isTitle = true,
        }, {
            text = WHISPER,
            func = function()
                ChatFrame_SendTell(activity:GetLeader())
            end,
        }, {
            text = C_FriendList.IsIgnored(activity:GetLeader()) and IGNORE_REMOVE or IGNORE,
            func = function()
                C_FriendList.AddOrDelIgnore(activity:GetLeader())
                if not C_FriendList.IsIgnored(activity:GetLeader()) then
                    ns.LFG:RemoveActivity(activity)
                end
            end,
        }, {isSeparator = true}, {text = REPORT_PLAYER, isTitle = true}, {
            text = REPORT_CHAT,
            func = function()
                local reportInfo = ReportInfo:CreateReportInfoFromType(Enum.ReportType.Chat)
                local leader = activity:GetLeader()
                print(leader)
                ReportFrame:InitiateReport(reportInfo, leader, activity:GetLeaderPlayerLocation())
                ns.GUI:CloseMenu()
            end,
        }, {isSeparator = true}, {text = CANCEL},
    }
end
