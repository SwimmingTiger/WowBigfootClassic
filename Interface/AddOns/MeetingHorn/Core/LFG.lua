-- LFG.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/11/2019, 11:15:30 AM

local tinsert = table.insert
local random = fastrandom or math.random

---@type ns
local ADDON_NAME, ns = ...

local L = ns.L
local AceSerializer = LibStub('AceSerializer-3.0')

---@class MeetingHornLFG
---@field private current MeetingHornActivity
---@field private activities MeetingHornActivity[]
---@field private chats MeetingHornActivity[]
---@field private applicants MeetingHornApplicant[]
---@field private bans string[]
---@field private activtyTimer MeetingHornTimer
---@field private sendTimer MeetingHornTimer
---@field private lockCache table<string, number>
---@field private banCache table<string, number>
---@field private idle boolean
local LFG = ns.Addon:NewModule('LFG', 'AceEvent-3.0', 'AceTimer-3.0', 'AceComm-3.0', 'NetEaseSocket-3.0')

function LFG:OnEnable()
    self.cooldown = ns.Addon.db.profile.cache.cooldown
    self.currentCache = ns.Addon.db.profile.cache.current

    self.chats = {}
    self.activities = {}
    self.applicants = {}
    self.lockCache = {}
    self.banCache = {}
    self.bossCache = {}
    self.inCity = false

    self.activtyTimer = ns.Timer:New(function()
        return self:OnActivityTimer()
    end)
    self.sendTimer = ns.Timer:New(function()
        return self:OnSendTimer()
    end)
    self.idleTimer = ns.Timer:New(function()
        return self:OnIdleTimer()
    end)
    self.idleTimer:Start(5)

    self:RegisterEvent('CHAT_MSG_CHANNEL')
    self:RegisterEvent('CHAT_MSG_WHISPER')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('GROUP_ROSTER_UPDATE')

    self:ListenSocket('MEETINGHORN')
    self:ConnectServer('S1' .. UnitFactionGroup('player'))
    self:RegisterSocket('JOIN', 'OnSocketJoin')
    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SNEWVERSION')

    self:RegisterEvent('ENCOUNTER_END')
    self:RegisterEvent('ENCOUNTER_START')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA')

    self.errorBlocker = CreateFrame('Frame')
    self.errorBlocker:RegisterEvent('ADDON_ACTION_BLOCKED')
    self.errorBlocker:SetScript('OnEvent', function(self, ...)
        self.ok = nil
    end)
    self.errorBlocker.Start = function(self)
        self.ok = true
        self.frames = {GetFramesRegisteredForEvent('ADDON_ACTION_BLOCKED')}
        for _, frame in ipairs(self.frames) do
            if frame ~= self then
                frame:UnregisterEvent('ADDON_ACTION_BLOCKED')
            end
        end
    end
    self.errorBlocker.End = function(self)
        for _, frame in ipairs(self.frames) do
            frame:RegisterEvent('ADDON_ACTION_BLOCKED')
        end
    end
    self.errorBlocker.IsOk = function(self)
        return self.ok
    end

    C_Timer.After(1, function()
        if self.currentCache.name and time() - self.cooldown.start < 5 * 60 then
            local id = ns.NameToId(self.currentCache.name)
            local modeId = ns.ModeToId(self.currentCache.mode)
            if id and modeId then
                self:CreateActivity(ns.Activity:New(id, modeId, self.currentCache.comment))
            end
        end
        self:ZONE_CHANGED_NEW_AREA()
    end)

    C_Timer.After(5, function()
        self:TouchCategory('Raid')
        self:ZONE_CHANGED_NEW_AREA()
    end)

    local serverChannels = {}

    local function IsServerChannel(channel)
        return serverChannels[channel]
    end

    hooksecurefunc('ChatConfig_UpdateCheckboxes', function(frame)
        if not frame.checkBoxTable or not frame.checkBoxTable[1] or not frame.checkBoxTable[1].channelID then
            return
        end

        local checkBoxName = frame:GetName() .. 'CheckBox'
        for i, value in ipairs(frame.checkBoxTable) do

            if value.channelName then
                local checkBox = _G[checkBoxName .. i .. 'Check']

                if ns.IsOurChannel(value.channelName) and not IsServerChannel(value.channelName) then
                    BlizzardOptionsPanel_CheckButton_Disable(checkBox)
                end
            end
        end
    end)

    hooksecurefunc(ChannelFrame.ChannelList, 'AddChannelButtonInternal', function(f, button, _, name, _, channelId)
        if ns.IsOurChannel(name) and not IsServerChannel(name) then
            button:Disable()
            local text = ('%s %s %s'):format(button:GetChannelNumberText(), button:GetChannelName(),
                                             button:GetMemberCountText())
            button.Text:SetText(DISABLED_FONT_COLOR:WrapTextInColorCode(text))
        end
    end)

    local function RefreshServerChannels()
        for i, v in ipairs{EnumerateServerChannels()} do
            serverChannels[v] = true
        end
    end

    ChatConfigFrame:HookScript('OnShow', RefreshServerChannels)
    ChannelFrame:HookScript('OnShow', RefreshServerChannels)

end

function LFG:GetCurrentActivity()
    return self.current
end

---@param activity MeetingHornActivity
function LFG:CreateActivity(activity, userInput)
    self.currentCache.name = activity:GetName()
    self.currentCache.mode = activity:GetMode()
    self.currentCache.comment = activity:GetComment()
    self.current = activity
    self.activtyTimer:Start(self:GetCooldown())
    self:SendMessage('MEETINGHORN_CURRENT_CREATED')

    if userInput then
        self:SendServer('SEI', activity:GetName(), activity:GetMode(), activity:GetComment())
    end

    self:RecvActivity(activity:GetChannelName(), UnitGUID('player'), UnitName('player'), activity:ToProto())
end

function LFG:CloseActivity()
    wipe(self.applicants)
    wipe(self.currentCache)
    self.current = nil
    self.activtyTimer:Stop()
    self.sendTimer:Stop()
    self:SendMessage('MEETINGHORN_CURRENT_CLOSED')
    self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
end

---@param activity MeetingHornActivity
function LFG:AddActivity(activity)
    -- tinsert(self.activities, random(1, #self.activities + 1), activity)
    tinsert(self.activities, 1, activity)
    self.activities[activity:GetLeaderGUID()] = activity
    self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
end

---@param activity MeetingHornActivity
function LFG:RemoveActivity(activity, noEvent)
    tDeleteItem(self.activities, activity)
    self.activities[activity:GetLeaderGUID()] = nil
    if not noEvent then
        self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
    end
end

function LFG:GetApplicationCount()
    local count = 0
    for _, activity in ipairs(self.activities) do
        if activity:GetCooldown() > 0 then
            count = count + 1
        end
    end
    return count
end

function LFG:GetApplicantCount()
    return #self.applicants
end

function LFG:GetActivityCount()
    return #self.activities
end

function LFG:GetChatCount()
    return #self.chats
end

function LFG:OnIdleTimer()
    return self:Clean()
end

function LFG:OnSendTimer()
    local channel = self.current:GetChannelId()
    if channel then
        local isAFK = UnitIsAFK('player')
        if not isAFK then
            self.errorBlocker:Start()
            pcall(SendChatMessage, self.current:ToProto(), 'CHANNEL', nil, channel)
            self.errorBlocker:End()
        end

        if isAFK or self.errorBlocker:IsOk() then
            self.sendTimer:Stop()
            self.activtyTimer:Start(self.current:GetInterval())
            self:StartCooldown(self.current:GetInterval())
        end
    end
end

function LFG:StartCooldown(duration)
    self.cooldown.start = time()
    self.cooldown.duration = duration
end

function LFG:GetCooldown()
    local remain = self.cooldown.start + self.cooldown.duration - time()
    if remain < 0 then
        return 0
    end
    return remain
end

function LFG:OnActivityTimer()
    if UnitIsAFK('player') then
        return
    end

    self.activtyTimer:Stop()

    if not self.current then
        return
    end

    local channel = self.current:GetChannelId()
    if channel then
        self.sendTimer:Start(0.1)
    else
        self:TouchCategory(self.current:GetPath())
        self.activtyTimer:Start(0.1)
    end
end

function LFG:OnSocketJoin(cmd, unit, d, ...)
    if d ~= 'WHISPER' then
        return
    end
    if not self.current then
        return
    end
    self:AddApplicant(unit, ...)
end

function LFG:RecvActivity(channelName, guid, unitName, text)
    local activity = self.activities[guid]
    if not activity then
        activity = ns.Activity:FromProto(text, unitName, guid, channelName)
        if activity then
            self:AddActivity(activity)
            return true
        end
    else
        if activity:Update(text, unitName, guid, channelName) then
            self:RemoveActivity(activity, true)
            self:AddActivity(activity)
            return true
            -- else
            --     self:RemoveActivity(activity)
        end
    end
end

function LFG:RecvChat(channelName, guid, unitName, text)
    local activity = self.chats[guid]
    if not activity then
        activity = ns.Activity:New(0, nil, text)
        activity:SetLeader(unitName)
        activity:SetLeaderGUID(guid)
        activity:SetChannelName(channelName)
        activity:UpdateTick()

        tinsert(self.chats, 1, activity)
        self.chats[guid] = activity
    else
        activity:SetComment(text)
    end
    return self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
end

function LFG:Clean()
    local activityChanged = false
    local applicantChanged = false
    for i = #self.activities, 1, -1 do
        local activity = self.activities[i]
        if activity:IsTimeOut() then
            tremove(self.activities, i)
            self.activities[activity:GetLeaderGUID()] = nil
            activityChanged = true
        end
    end

    for i = #self.chats, 1, -1 do
        local activity = self.chats[i]
        if activity:IsTimeOut() then
            tremove(self.chats, i)
            self.chats[activity:GetLeaderGUID()] = nil
            activityChanged = true
        end
    end

    for i = #self.applicants, 1, -1 do
        local applicant = self.applicants[i]
        if applicant:IsTimeOut() then
            tremove(self.applicants, i)
            applicantChanged = true
        end
    end

    if activityChanged then
        self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
    end
    if applicantChanged then
        self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
    end
end

function LFG:Search(path, activityId, modeId, search)
    if search and search:trim() == '' then
        search = nil
    end

    if search then
        search = search:lower()
    end

    if activityId then
        local data = ns.GetActivityData(activityId)
        self:TouchCategory(data.category.path)
    end

    local result = {}
    for _, activity in ipairs(self.activities) do
        if activity:Match(path, activityId, modeId, search) then
            tinsert(result, activity)
        end
    end

    if search then
        for _, activity in ipairs(self.chats) do
            if activity:Match(nil, nil, nil, search) then
                tinsert(result, activity)
            end
        end
    end
    return result
end

function LFG:SERVER_CONNECTED()
    self:SendServer('SLOGIN', ns.ADDON_VERSION, ns.GetPlayerItemLevel())
end

function LFG:SNEWVERSION(_, version, url, changelog)
    SendSystemMessage(format(L.SUMMARY_NEW_VERSION, L.ADDON_NAME, version, url))
end

function LFG:CHAT_MSG_CHANNEL(event, text, unitName, _, _, _, flag, _, _, channelName, _, _, guid)
    local baseChannelName = channelName:match('^([^ -]+)')
    if baseChannelName then
        channelName = baseChannelName
    end

    if ns.IsOurChannel(channelName) then
        -- if self:CheckUnit(guid) then
        if not self:RecvActivity(channelName, guid, unitName, text) then
            self:RecvChat(channelName, guid, unitName, text)
        end
        -- self:LockUnit(guid)
        -- end
    elseif ns.IsCompatChannel(channelName) then
        self:RecvChat(channelName, guid, unitName, text)
    end
end

function LFG:CHAT_MSG_WHISPER(event, text, unitName, _, _, _, flag, _, _, _, _, _, guid)
    if not self.current then
        return
    end
    if not guid then
        return
    end
    if text == '1' or text == '组' then
        local class, race = select(2, GetPlayerInfoByGUID(guid))
        self:AddApplicant(unitName, class, race)
    end
end

function LFG:ZONE_CHANGED_NEW_AREA()
    local name = select(6, EnumerateServerChannels())
    local inCity = name and name == L['CHANNEL: Recruit']

    if inCity ~= self.inCity then
        self.inCity = inCity
        self:SendMessage('MEETINGHORN_CITY_CHANGED')
    end

    if not self.inCity and self.current then
        self:CloseActivity()
    end
end

function LFG:IsInCity()
    return self.inCity
end

local ERR_DECLINE_GROUP_S_P = ERR_DECLINE_GROUP_S:format('(.+)')

function LFG:CheckDecline(text)
    local unit = text:match(ERR_DECLINE_GROUP_S_P)
    if unit then
        local applicant = self.applicants[unit]
        if applicant then
            applicant:SetState(ns.APPLICANT_STATUS.Declined)
            self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
        end
        return true
    end
end

function LFG:CHAT_MSG_SYSTEM(event, text, ...)
    self:CheckDecline(text)
end

function LFG:GROUP_ROSTER_UPDATE()
    local applicantChanged = false
    local activityChanged = false

    if self.current then
        if not ns.IsGroupLeader() or GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) >= self.current.data.members then
            self:CloseActivity()
        end

        if ns.IsGroupLeader() then
            for i = #self.applicants, 1, -1 do
                local applicant = self.applicants[i]
                if ns.UnitInGroup(applicant:GetName()) then
                    self.applicants[applicant:GetName()] = nil
                    tremove(self.applicants, i)
                    applicantChanged = true
                end
            end
        end
    end

    for i, activity in ipairs(self.activities) do
        if ns.UnitInGroup(activity:GetLeader()) then
            activity:ResetCooldown()
            activityChanged = true
        end
    end

    if activityChanged then
        self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
    end
    if applicantChanged then
        self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
    end
end

function LFG:ENCOUNTER_START(_, bossId)
    self.bossCache[bossId] = time()
end

function LFG:ENCOUNTER_END(_, bossId, _, _, _, success)
    if success ~= 1 then
        return
    end

    RequestRaidInfo()

    local raidName = GetInstanceInfo()
    local leaderName, leaderGUID = ns.GetGroupLeader()
    local looterName, looterGUID = ns.GetGroupLooter()
    local lootMethod = GetLootMethod()
    local startTime = self.bossCache[bossId]
    local timeDiff = startTime and time() - startTime or -1

    if looterGUID == leaderGUID then
        looterName = nil
        looterGUID = nil
    end

    C_Timer.After(5, function()
        local id = ns.GetRaidId(raidName)
        self:SendServer('SBK', raidName, id, bossId, timeDiff, leaderName, leaderGUID, looterName, looterGUID,
                        ns.ADDON_VERSION, lootMethod)
    end)
end

function LFG:CheckUnit(guid)
    local now = time()
    local banTick = self.banCache[guid]
    if banTick and now < banTick then
        return false
    end
    local lockTick = self.lockCache[guid]
    if lockTick and now < lockTick then
        self.banCache[guid] = now + 20 * 60
        return false
    end
    return true
end

function LFG:LockUnit(guid, seconds)
    self.lockCache[guid] = max(self.lockCache[guid] or 0, time() + (seconds or ns.MIN_INTERVAL) - 5)
end

function LFG:GetApplicants()
    return self.applicants
end

---@param activity MeetingHornActivity
function LFG:SignupActivity(activity)
    activity:StartCooldown()

    local class = select(2, UnitClass('player'))
    local race = UnitRace('player')
    local level = UnitLevel('player')
    local text = AceSerializer:Serialize('JOIN', class, race, level)
    self:SendCommMessage('MEETINGHORN', text, 'WHISPER', activity:GetLeader())
    self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
end

---@param applicant MeetingHornApplicant
function LFG:RemoveApplicant(applicant)
    tDeleteItem(self.applicants, applicant)
    self.applicants[applicant:GetName()] = nil
    self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
end

function LFG:AddApplicant(unitName, class, race, level)
    unitName = Ambiguate(unitName, 'none')

    local applicant = self.applicants[unitName]
    if applicant then
        applicant:Update(class, race, level)
    else
        applicant = ns.Applicant:New(unitName, class, race, level)
        tinsert(self.applicants, 1, applicant)
        self.applicants[applicant:GetName()] = applicant
    end
    self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
    self:SendMessage('MEETINGHORN_NEW_APPLICANT')
end

---@param applicant MeetingHornApplicant
function LFG:InviteApplicant(applicant)
    InviteUnit(applicant:GetName())
    applicant:SetState(ns.APPLICANT_STATUS.Invited)
    self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
end

function LFG:TouchCategory(path)
    local category = ns.GetCategoryData(path)
    if not category then
        return
    end
    local channel = category.channel
    local id = GetChannelName(channel)
    if not id or id == 0 then
        JoinTemporaryChannel(channel)
    end
end

function LFG:OnHardWare()
end
