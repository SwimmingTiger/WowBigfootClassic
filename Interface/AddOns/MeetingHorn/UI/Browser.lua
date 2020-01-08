
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
    -- self.Header1:Disable()
    self.Header2:Disable()
    self.Header3:Disable()
    self.Header4:Disable()
    self.Header5:Disable()
    self.Header6:Disable()

    self.ActivityLabel:SetText(L['Activity'])
    self.ModeLabel:SetText(L['Activity Mode'])
    self.SearchLabel:SetText(SEARCH .. L['(Include channel message)'])
    self.Loading:SetText(L['Receiving active data, please wait patiently'])

    ns.Timer:New(function()
        self.index = ((self.index or 0) + 1) % 4
        self.LoadingProgress:SetText(string.rep('.', self.index))
    end):Start(1)

    ns.GUI:GetClass('Dropdown'):Bind(self.Activity)
    ns.GUI:GetClass('Dropdown'):Bind(self.Mode)

    local function Search()
        return self:Search()
    end

    local function QuickButtonOnClick(button)
        self.Activity:SetValue(button.id)
    end

    ---@param button Button
    local function SetupQuickButton(button, id)
        local data = ns.GetActivityData(id)
        button:SetText(data.shortName or data.name)
        button:SetScript('OnClick', QuickButtonOnClick)
        button.id = id
    end

    SetupQuickButton(self.Quick1, 1)
    SetupQuickButton(self.Quick2, 2)

    self.Activity:SetMenuTable(ns.ACTIVITY_FILTER_MENU)
    self.Activity:SetDefaultText(ALL)
    self.Activity:SetCallback('OnSelectChanged', function()
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
        local canSignup = not IsInGroup(LE_PARTY_CATEGORY_HOME) and not ns.LFG:GetCurrentActivity()
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
        button.Comment:SetWidth(item:IsActivity() and 290 or 360)
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
        button.Signup:SetEnabled(canSignup)
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

    self:SetScript('OnShow', self.Search)
    self:RegisterMessage('MEETINGHORN_ACTIVITY_UPDATE')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_FILTER_UPDATED', 'Search')
    self:Show()
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
    if self.sortId then
        sort(self.ActivityList:GetItemList(), function(a, b)
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

function Browser:MEETINGHORN_ACTIVITY_UPDATE()
    if ns.Addon.MainPanel:IsMouseOver() then
        self.ActivityList:Refresh()
    else
        self:Search()
    end
end

function Browser:OpenActivityMenu(activity, button)
    if not activity:IsSelf() then
        ns.GUI:ToggleMenu(button, self:CreateActivityMenu(activity), 'cursor')
    end
end

function Browser:CreateActivityMenu(activity)
    return {
        { --
            text = format('|c%s%s|r', select(4, GetClassColor(activity:GetLeaderClass())), activity:GetLeader()),
            isTitle = true,
        }, {
            text = WHISPER,
            func = function()
                ChatFrame_SendTell(activity:GetLeader())
            end,
        }, {
            text = REPORT_PLAYER,
            hasArrow = true,
            menuTable = {
                {
                    text = REPORT_SPAMMING,
                    func = function()
                        PlayerReportFrame:InitiateReport(PLAYER_REPORT_TYPE_SPAM, activity:GetLeader(),
                                                         activity:GetLeaderPlayerLocation())
                        ns.GUI:CloseMenu()
                    end,
                }, {
                    text = REPORT_BAD_LANGUAGE,
                    func = function()
                        PlayerReportFrame:InitiateReport(PLAYER_REPORT_TYPE_LANGUAGE, activity:GetLeader(),
                                                         activity:GetLeaderPlayerLocation())
                        ns.GUI:CloseMenu()
                    end,
                }, {
                    text = REPORT_BAD_NAME,
                    func = function()
                        PlayerReportFrame:InitiateReport(PLAYER_REPORT_TYPE_BAD_PLAYER_NAME, activity:GetLeader(),
                                                         activity:GetLeaderPlayerLocation())
                        ns.GUI:CloseMenu()
                    end,
                }, {
                    text = REPORT_CHEATING,
                    func = function()
                        HelpFrame_ShowReportCheatingDialog(activity:GetLeaderPlayerLocation())
                        ns.GUI:CloseMenu()
                    end,
                },
            },
        }, {text = CANCEL},
    }
end
