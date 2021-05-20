-- Master.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/11/2020, 4:31:00 PM

---@type ns
local ns = select(2, ...)

---@type Frame
local UIErrorsFrame = UIErrorsFrame

---@type NeteaseWargameMaster
local Master = ns.Addon:NewModule('Master', 'AceEvent-3.0', 'AceTimer-3.0')
Master:Disable()

function Master:OnInitialize()
    self.errorEvents = {}

    self.chatFilters = {
        CHAT_MSG_SYSTEM = function(_, _, msg)
            return msg == ERR_WARGAME_REQUEST_SENT or msg == ERR_BATTLEGROUND_INVITATION_DECLINED
        end,
        CHAT_MSG_BN_INLINE_TOAST_ALERT = function(_, _, msg)
            return msg == 'BATTLETAG_FRIEND_ADDED' or msg == 'FRIEND_ONLINE'
        end,
    }
end

function Master:OnEnable()
    for event, chatFilter in pairs(self.chatFilters) do
        ChatFrame_AddMessageEventFilter(event, chatFilter)
    end

    self:DisableErrors()

    self:RegisterEvent('UI_ERROR_MESSAGE')
    self:RegisterEvent('UI_INFO_MESSAGE', 'UI_ERROR_MESSAGE')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('UPDATE_BATTLEFIELD_STATUS')

    self:ScheduleTimer('OnTimeout', 60)
    self:ScheduleRepeatingTimer('OnTimer', 2)
end

function Master:OnDisable()
    for event, chatFilter in pairs(self.chatFilters) do
        ChatFrame_RemoveMessageEventFilter(event, chatFilter)
    end

    self:EnableErrors()

    self.isFriend = nil
    self.battleTag = nil
    self.target = nil
    self.game = nil
    self.waitingBattle = nil
    self.waitingFriend = nil
    self.waitingBattleTimer = nil
    self.waitingFriendTimer = nil
end

function Master:EnableErrors()
    for event in pairs(self.errorEvents) do
        UIErrorsFrame:RegisterEvent(event)
    end
end

function Master:DisableErrors()
    wipe(self.errorEvents)
    self:DisableError('UI_ERROR_MESSAGE')
    self:DisableError('UI_INFO_MESSAGE')
end

function Master:DisableError(event)
    if UIErrorsFrame:IsEventRegistered(event) then
        self.errorEvents[event] = true
        UIErrorsFrame:UnregisterEvent(event)
    end
end

function Master:OnTimer()
    if ns.IsBNFriend(self.battleTag) then
        self:RequestBattle()
    else
        self:RequestFriend()
    end
end

function Master:OnTimeout()
    if not ns.IsBNFriend(self.battleTag) then
        self:Result(false, 'friend-timeout')
    else
        self:Result(false, 'battle-timeout')
    end
end

function Master:Start(gameId, battleTag, target)
    local game = ns.Wargame:GetGame(gameId)
    if not game then
        return
    end

    self.battleTag = battleTag
    self.target = target
    self.game = game
    self.isFriend = ns.IsBNFriend(battleTag)
    self:Enable()
end

function Master:RequestBattle()
    if not self.waitingBattle then
        local name = self.battleTag:match('^(.+)#')
        local zone = self.game:GetZoneText()
        local count = self.game.combatCount
        local cmd = format('%s %s %s', name, zone, count)

        StartWarGameByName(cmd)

        self.waitingBattle = true
        self.waitingBattleTimer = self:ScheduleTimer('OnRequestBattleTimeout', 5)
    end
end

function Master:RequestFriend()
    if not self.waitingFriend then
        BNSendFriendInvite(self.battleTag)

        self.waitingFriend = true
        self.waitingFriendTimer = self:ScheduleTimer('OnRequestFriendTimeout', 5)
    end
end

function Master:OnRequestFriendTimeout()
    self.waitingFriend = nil
    self.waitingFriendTimer = nil
end

function Master:OnRequestBattleTimeout()
    self.waitingBattle = nil
    self.waitingBattleTimer = nil
end

function Master:RemoveFriend()
    if not self.isFriend then
        for i = 1, BNGetNumFriends() do
            local id, _, battleTag = BNGetFriendInfo(i)
            if battleTag == self.battleTag then
                BNRemoveFriend(id)
                return
            end
        end
    end
end

function Master:UI_ERROR_MESSAGE(event, code, msg)
    local errorType = GetGameMessageInfo(code)

    if errorType == 'ERR_WARGAME_REQUEST_FAILURE' then
        return
    end
    if errorType == 'ERR_BN_FRIEND_REQUEST_SENT' then
        return self:CancelTimer(self.waitingFriendTimer)
    end

    local reason
    if errorType == 'ERR_BATTLEGROUND_INVITATION_DECLINED' then
        reason = 'enemy-declined'
    elseif errorType == 'ERR_BATTLEGROUND_DUPE_QUEUE' then
        reason = 'ally-dupe'
    end

    if reason then
        self:Result(false, reason)
    end

    UIErrorsFrame:GetScript('OnEvent')(UIErrorsFrame, event, code, msg)
end

function Master:CHAT_MSG_SYSTEM(_, msg)
    if msg == ERR_WARGAME_REQUEST_SENT then
        self:CancelTimer(self.waitingBattleTimer)
    end
end

function Master:UPDATE_BATTLEFIELD_STATUS()
    if self.game:IsInQueue() then
        self:Result(true, 'queued')
    end
end

function Master:Result(ok, reason)
    ns.Wargame:SendStartGameResult(ok, reason)
    self:RemoveFriend()
    self:Disable()
end
