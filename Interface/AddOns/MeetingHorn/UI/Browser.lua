-- Browser.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/11/2019, 5:03:49 PM

---@type ns
local ns = select(2, ...)

local L = ns.L

---@class MeetingHornUIBrowser: ScrollFrame
---@field private ActivityList ListView
---@field private Activity Button
---@field private Mode Button
---@field private Header1 Button
---@field private Header2 Button
---@field private Header3 Button
---@field private Header4 Button
local Browser = ns.Addon:NewClass('UI.Browser', 'Frame')

function Browser:Constructor()
    self.ActivityList.scrollBar.doNotHide = true
    self.ActivityList.buttonHeight = 24

    self.Empty.Text:SetText(L['There are no activity, please try searching.'])

    self.Header1:SetText(L['Activity'])
    self.Header2:SetText(L['Mode'])
    self.Header3:SetText(L['Leader'])
    self.Header4:SetText(L['Comment'])
    self.Header5:SetText(L['Operation'])
    self.Header1:Disable()
    self.Header2:Disable()
    self.Header3:Disable()
    self.Header4:Disable()
    self.Header5:Disable()

    self.ActivityLabel:SetText(L['Activity'])
    self.ModeLabel:SetText(L['Activity Mode'])
    self.SearchLabel:SetText(SEARCH .. L['(Include channel message)'])

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
        button.Comment:SetWidth(item:IsActivity() and 190 or 260)

        button.State:SetShown(state)
        button.State:SetText(state)
        button.State:SetTextColor(GREEN_FONT_COLOR:GetRGB())

        button.Signup:SetShown(item:IsActivity() and not state)
        button.Signup:SetEnabled(canSignup)
    end)
    ---@param item MeetingHornActivity
    self.ActivityList:SetCallback('OnItemSignupClick', function(_, button, item)
        if item:IsActivity() then
            ns.LFG:SignupActivity(item)
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
        self:Search()
    end)

    self:SetScript('OnShow', self.Search)
    self:RegisterMessage('MEETINGHORN_ACTIVITY_UPDATE')
    self:Show()
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
    ns.GUI:ToggleMenu(button, self:CreateActivityMenu(activity), 'cursor')
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
        }, {text = CANCEL},
    }
end
