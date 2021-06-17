--
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
---@field private challengeGroups MeetingHornChallengeGroup[]
---@field private challengeGroup MeetingHornChallengeGroup
local LFG = ns.Addon:NewModule('LFG', 'AceEvent-3.0', 'AceTimer-3.0', 'AceComm-3.0', 'LibCommSocket-3.0')

function LFG:OnEnable()
    self.cooldown = ns.Addon.db.profile.cache.cooldown
    self.currentCache = ns.Addon.db.profile.cache.current
    self.members = MEETINGHORN_DB_CHARACTER_MEMBERS

    self.chats = {}
    self.activities = {}
    self.applicants = {}
    self.lockCache = {}
    self.banCache = {}
    self.bossCache = {}
    self.welcome = {}
    self.inCity = false
    self.filters = setmetatable({}, {
        __mode = 'k',
        __index = function(t, k)
            local result = false
            for i, v in ipairs(ns.Addon.db.global.activity.filters) do
                if strfind(k, v.text, 1, v.plainText) then
                    result = true
                    break
                end
            end
            t[k] = result
            return t[k]
        end,
    })

    self.activtyTimer = ns.Timer:New(function()
        return self:OnActivityTimer()
    end)
    self.sendTimer = ns.Timer:New(function()
        return self:OnSendTimer()
    end)
    self.leaveTimer = ns.Timer:New(function()
        return self:OnLeaveTimer()
    end)
    self.idleTimer = ns.Timer:New(function()
        return self:OnIdleTimer()
    end)
    self.idleTimer:Start(5)

    self:RegisterEvent('CHAT_MSG_CHANNEL')
    -- self:RegisterEvent('CHAT_MSG_WHISPER')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:RegisterMessage('MEETINGHORN_SHOW')
    self:RegisterMessage('MEETINGHORN_HIDE')

    self:ListenSocket('MEETINGHORN')
    self:ConnectServer(UnitFactionGroup('player') == 'Alliance' and 'Zpqmxown' or 'Nwoxmqpz')
    self:RegisterSocket('JOIN', 'OnSocketJoin')
    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SNEWVERSION')
    --[[@classic@
    self:RegisterServer('SWORLDBUFF')
    --@end-classic@]]
    self:RegisterServer('SNOTICE')

    self:RegisterChallenge('SGA', 'SGETACTIVITY')
    self:RegisterChallenge('SGP', 'SACTIVITYGROUPPROGRESS')
    self:RegisterChallenge('SAP', 'SACTIVITYPROGRESS')
    self:RegisterChallenge('SAF', 'SACTIVITYFETCHREWARD')

    self:RegisterEvent('ENCOUNTER_END')
    self:RegisterEvent('ENCOUNTER_START')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA')
    self:RegisterEvent('RAID_INSTANCE_WELCOME')

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
        else
            self:MEETINGHORN_HIDE()
        end
        self:ZONE_CHANGED_NEW_AREA()
    end)

    C_Timer.After(5, function()
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
        for i, v in ipairs {EnumerateServerChannels()} do
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
    self.activtyTimer:Start(self:GetCooldown())

    self.current = self:RecvActivity(activity:GetChannelName(), UnitGUID('player'), ns.UnitFullName('player'),
                                     activity:ToProto())

    if userInput then
        self:SendServer('SEI', self.current:GetName(), self.current:GetMode(), self.current:GetComment(),
                        ns.ADDON_VERSION, self.current:GetLeaderClass(), self.current:GetLeaderLevel(),
                        self.current:GetMembers(), self.current.data.members, (GetGuildInfo('player')))
    end

    self:SendMessage('MEETINGHORN_CURRENT_CREATED')
end

function LFG:CloseActivity()
    self:RemoveActivity(self.current, true)
    self.activtyTimer:Stop()
    self.sendTimer:Stop()
    self.current = nil
    wipe(self.applicants)
    wipe(self.currentCache)
    self:SendMessage('MEETINGHORN_CURRENT_CLOSED')
    self:SendMessage('MEETINGHORN_APPLICANT_UPDATE')
    self:SendServer('SED')
end

---@param activity MeetingHornActivity
function LFG:AddActivity(activity)
    -- tinsert(self.activities, random(1, #self.activities + 1), activity)

    local insertTo
    if activity:IsSameInstance() then
        insertTo = 1
    else
        for i, v in ipairs(self.activities) do
            if not v:IsSameInstance() then
                insertTo = i
                break
            end
        end
    end

    if not insertTo then
        tinsert(self.activities, activity)
    else
        tinsert(self.activities, insertTo, activity)
    end

    self.activities[activity:GetLeaderGUID()] = activity
    self:SendMessage('MEETINGHORN_ACTIVITY_UPDATE')
end

---@param activity MeetingHornActivity
function LFG:RemoveActivity(activity, noEvent)
    tDeleteItem(self.activities, activity)
    self.activities[activity:GetLeaderGUID()] = nil
    if not noEvent then
        self:SendMessage('MEETINGHORN_ACTIVITY_REMOVED', activity)
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

function LFG:RecvActivity(channelName, guid, unitName, text, lineId)
    local activity = self.activities[guid]
    if not activity then
        activity = ns.Activity:FromProto(text, unitName, guid, channelName, lineId)
        if activity then
            self:AddActivity(activity)
            self:SendMessage('MEETINGHORN_ACTIVITY_ADDED')
            return activity
        end
    else
        if activity:Update(text, unitName, guid, channelName, lineId) then
            self:RemoveActivity(activity, true)
            self:AddActivity(activity)
            return activity
            -- else
            --     self:RemoveActivity(activity)
        end
    end
end

function LFG:RecvChat(channelName, guid, unitName, text, lineId)
    local activity = self.chats[guid]
    if not activity then
        activity = ns.Activity:New(0, nil, text)
        activity:SetLeader(unitName)
        activity:SetLeaderGUID(guid)
        activity:SetChannelName(channelName)
        activity:SetLineId(lineId)
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
    self:SendServer('SLOGIN', ns.ADDON_VERSION, ns.GetPlayerItemLevel(), UnitGUID('player'), UnitLevel('player'))
    self:SendMessage('MEETINGHORN_SERVER_CONNECTED')

    --[[@debug@
    print('Connected')
    --@end-debug@]]
end

function LFG:SNEWVERSION(_, version, url, changelog)
    SendSystemMessage(format(L.SUMMARY_NEW_VERSION, L.ADDON_NAME, version, url))
end

function LFG:SNOTICE(_, text)
    ns.SystemMessage(format('|cff00ffff集结号温馨提示|r: |cff47e53d%s|r', text))
end

--[[@classic@
function LFG:SWORLDBUFF(_, enable, data)
    if type(data) == 'table' then
        ns.WorldBuff:SetPos(data)
    end
    self:SendMessage('MEETINGHORN_WORLDBUFF_STATUS_CHANGED', enable)
end
--@end-classic@]]

---- Challenge

function LFG:RegisterChallenge(event, method)
    method = self[method] or self[event]
    assert(type(method) == 'function')

    self:RegisterServer(event, function(event, err, ...)
        if err and err > 0 then
            --[[@debug@
            print(event, err)
            --@end-debug@]]
            local errString = ns.errorString(err)
            if errString then
                ns.Message(format('|cffff0000%s。|r', errString))
            end
            if err == ns.ErrorCode.ADDON_UPDATED then
                self:SendMessage('MEETINGHORN_CHALLENGE_OUT_OF_DATE')
            end
            return
        end
        return method(self, event, ...)
    end)
end

function LFG:GetChallengeGroup(id)
    if not self.challengeGroups then
        return
    end

    for i, challengeGroup in ipairs(self.challengeGroups) do
        if challengeGroup.id == id then
            return challengeGroup
        end
    end
end

function LFG:GetChallenge(id)
    if not self.challengeGroups then
        return
    end

    for i, challengeGroup in ipairs(self.challengeGroups) do
        local item = challengeGroup:Get(id)
        if item then
            return item
        end
    end
end

function LFG:RequestChallengeGroup()
    self:SendServer('CGA', UnitGUID('player'), ns.ADDON_VERSION)
end

function LFG:SGETACTIVITY(_, activities, progress, moreActivities)
    self.challengeGroups = {}

    local challengeGroup = ns.ChallengeGroup:New(activities)
    challengeGroup:UpdateProgresses(progress)
    tinsert(self.challengeGroups, challengeGroup)

    if moreActivities then
        --[[@debug@
        dump('moreActivities', moreActivities)
        --@end-debug@]]
        for i, v in ipairs(moreActivities) do
            table.insert(self.challengeGroups, ns.ChallengeGroup:New(v))
        end
    end
    self:SendMessage('MEETINGHORN_CHALLENGE_GROUP_READY')
end

function LFG:RequestChallengeGroupProgress(id)
    self:SendServer('CGP', UnitGUID('player'), id)
end

function LFG:SACTIVITYGROUPPROGRESS(_, id, proto, progress)
    if not self.challengeGroups then
        return
    end

    local challengeGroup = self:GetChallengeGroup(id)
    if challengeGroup then
        challengeGroup:UpdateProto(proto)
        challengeGroup:UpdateProgresses(progress)
        self:SendMessage('MEETINGHORN_CHALLENGE_GROUP_UPDATED', id)
    end
end

function LFG:RequestChallengeProgress(id)
    self:SendServer('CAP', UnitGUID('player'), id)
end

function LFG:SACTIVITYPROGRESS(_, id, progresses)
    --[[@debug@
    dump(progresses)
    --@end-debug@]]
    if type(progresses) == 'table' then
        local item = self:GetChallenge(id)
        if item then
            item:UpdateProgress(progresses[1])
            self:SendMessage('MEETINGHORN_CHALLENGE_PROGRESS_UPDATED', id)
        end
    end
end

function LFG:FetchChallengeReward(id, itemId)
    local battleTag = select(2, BNGetInfo())
    self:SendServer('CAF', UnitGUID('player'), id, itemId, battleTag)
end

function LFG:SACTIVITYFETCHREWARD(_, id)
    local item = self:GetChallenge(id)
    if item then
        item:Fetched()
        self:SendMessage('MEETINGHORN_CHALLENGE_PROGRESS_UPDATED', id)
    end
end

----

function LFG:CHAT_MSG_CHANNEL(event, text, unitName, _, _, _, flag, _, _, channelName, _, lineId, guid)
    local baseChannelName = channelName:match('^([^ -]+)')
    if baseChannelName then
        channelName = baseChannelName
    end

    channelName = ns.Channel:GetUsChannelName(channelName) or channelName

    if ns.IsOurChannel(channelName) then
        -- if self:CheckUnit(guid) then
        if not self:RecvActivity(channelName, guid, unitName, text, lineId) then
            self:RecvChat(channelName, guid, unitName, text, lineId)
        end
        -- self:LockUnit(guid)
        -- end
    elseif ns.IsCompatChannel(channelName) then
        self:RecvChat(channelName, guid, unitName, text, lineId)
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
    local channels = {EnumerateServerChannels()}
    local inCity = tContains(channels, L['CHANNEL: Recruit'])

    if inCity ~= self.inCity then
        self.inCity = inCity
        self:SendMessage('MEETINGHORN_CITY_CHANGED')
    end

    if not self.inCity and self.current and self.current.data.category.inCity then
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
        if not ns.IsGroupLeader() or ns.GetNumGroupMembers() >= self.current.data.members then
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

function LFG:OnLeaveTimer()
    self.leaveTimer:Stop()
    ns.Channel:Leave(L['CHANNEL: Group'])
end

function LFG:MEETINGHORN_SHOW()
    self:TouchCategory('Raid')
    self.leaveTimer:Stop()
end

function LFG:MEETINGHORN_HIDE()
    if not self.current then
        self.leaveTimer:Start(60)
    end
end

function LFG:ENCOUNTER_START(_, bossId)
    self.bossCache[bossId] = time()
    self.currentBossId = bossId

    if ns.ENCOUNTER_BOSSES[bossId] then
        self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    end
end

function LFG:COMBAT_LOG_EVENT_UNFILTERED()
    local _, event, _, _, _, _, _, guid, name = CombatLogGetCurrentEventInfo()
    if event == 'UNIT_DIED' and guid == UnitGUID('player') then
        self.youDead = true
    end
end

function LFG:RAID_INSTANCE_WELCOME()
    local instanceId = select(8, GetInstanceInfo())
    if self.welcome[instanceId] then
        return
    end

    self.welcome[instanceId] = true

    local instanceInfo = ns.ENCOUNTER_INSTANCES[instanceId]
    if not instanceInfo then
        return
    end

    ns.Message(L['欢迎来到%s，打开集结号查看|cff47e53d|Hmeetinghornencounter:%s|h[Boss击杀攻略]|r。'],
               instanceInfo.title, instanceId)
end

function LFG:ENCOUNTER_END(_, bossId, _, _, _, success)
    if success == 1 then
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
            self:SaveInstanceMembers(id)
        end)
    elseif self.youDead then
        local bossData = ns.ENCOUNTER_BOSSES[bossId]
        if bossData then
            ns.Message(
                L['你在与[%s]的战斗中阵亡，|cff00ffff|Hmeetinghornencounter:%s:%s:%s|h[点击查看Boss攻略]|h|r。'],
                bossData.name, select(8, GetInstanceInfo()), bossId, 1)
        end
    end
    self.youDead = nil
    self.currentBossId = nil
end

function LFG:GetInstanceMembers(id)
    return self.members[id]
end

function LFG:SaveInstanceMembers(id)
    if not id or id == -1 then
        return
    end

    self.members[id] = self.members[id] or {}

    local members = self.members[id]

    for unit in ns.IterateGroup() do
        if UnitExists(unit) then
            local name = ns.UnitFullName(unit)

            if not members.leader and UnitIsGroupLeader(unit) then
                members.leader = name
            end

            if not UnitIsUnit(unit, 'player') then
                members[name] = UnitClassBase(unit)
            end
        end
    end
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
    local id = ns.Channel:GetSendChannelId(channel)
    if not id then
        ns.Channel:Join(channel)
    end
end

function LFG:OnHardWare()
end

function LFG:ClearFilterCache()
    wipe(self.filters)
end

function LFG:IsFilter(text)
    if text then
        return self.filters[text]
    end
end

--[[@classic@
function LFG:WorldBuff(instanceId, npcId, spellId)
    ns.RandomCall(30, self.SendServer, self, 'SWB', instanceId, npcId, spellId, GetServerTime())
end

function LFG:KillWorldBuffNpc(instanceId, npcId)
    ns.RandomCall(30, self.SendServer, self, 'SKN', instanceId, npcId, GetServerTime())
end
--@end-classic@]]
