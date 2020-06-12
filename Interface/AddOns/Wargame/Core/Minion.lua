-- Minion.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/11/2020, 4:34:17 PM

---@type ns
local ns = select(2, ...)

---@type NeteaseWargameMinion
local Minion = ns.Addon:NewModule('Minion', 'AceEvent-3.0', 'AceTimer-3.0')
Minion:Disable()

function Minion:OnInitialize()
    self.chatFilters = {
        CHAT_MSG_BN_INLINE_TOAST_ALERT = function(_, _, msg)
            return msg == 'BATTLETAG_FRIEND_ADDED' or msg == 'FRIEND_REQUEST' or msg == 'FRIEND_ONLINE'
        end,
    }
end

function Minion:OnEnable()
    self.tempFriends = {}

    for event, chatFilter in pairs(self.chatFilters) do
        ChatFrame_AddMessageEventFilter(event, chatFilter)
    end

    PVPHelperFrame:UnregisterEvent('WARGAME_REQUESTED')

    self:RegisterEvent('WARGAME_REQUESTED')
    self:RegisterEvent('UI_ERROR_MESSAGE')
    self:RegisterEvent('UI_INFO_MESSAGE', 'UI_ERROR_MESSAGE')
    self:RegisterEvent('UPDATE_BATTLEFIELD_STATUS')

    self:ScheduleTimer('OnTimeout', 60)

    if not self.isFriend then
        self:RegisterEvent('BN_FRIEND_INVITE_ADDED')
        self:RegisterEvent('BN_FRIEND_LIST_SIZE_CHANGED')

        local now = ns.time()

        for i = 1, BNGetNumFriendInvites() do
            local id, _, _, _, sendTime = BNGetFriendInviteInfo(i)
            if now - sendTime < 30 then
                self:BN_FRIEND_INVITE_ADDED(nil, id)
            end
        end
    end
end

function Minion:OnDisable()
    for event, chatFilter in pairs(self.chatFilters) do
        ChatFrame_RemoveMessageEventFilter(event, chatFilter)
    end

    PVPHelperFrame:RegisterEvent('WARGAME_REQUESTED')

    self.isFriend = nil
    self.battleTag = nil
end

function Minion:OnTimeout()
    self:Result(false, 'minion-timeout')
end

function Minion:BN_FRIEND_INVITE_ADDED(_, id)
    BNAcceptFriendInvite(id)
    self.tempFriends[id] = true
end

function Minion:BN_FRIEND_LIST_SIZE_CHANGED(_, id)
    if not self.tempFriends[id] then
        return
    end

    if select(3, BNGetFriendInfoByID(id)) ~= self.battleTag then
        BNRemoveFriend(id)
        self.tempFriends[id] = nil
    else
        self:UnregisterEvent('BN_FRIEND_INVITE_ADDED')
        self:UnregisterEvent('BN_FRIEND_LIST_SIZE_CHANGED')
    end
end

function Minion:WARGAME_REQUESTED(event, target, zoneText, ...)
    if zoneText ~= self.game:GetZoneText() or target ~= self.target then
        PVPHelperFrame:GetScript('OnEvent')(PVPHelperFrame, event, target, zoneText, ...)
        return
    end

    ns.Spawn(WarGameRespond, true)
end

function Minion:UI_ERROR_MESSAGE(event, code, msg)
    local type = GetGameMessageInfo(code)
    local reason

    if type == 'ERR_BATTLEGROUND_DUPE_QUEUE' then
        reason = 'ally-dupe'
    else
        return
    end

    self:Result(false, reason)
end

function Minion:UPDATE_BATTLEFIELD_STATUS()
    if self.game:IsInQueue() then
        self:Result(true, 'queued')
    end
end

function Minion:Start(gameId, battleTag, target)
    local game = ns.Wargame:GetGame(gameId)
    if not game then
        return
    end

    self.battleTag = battleTag
    self.target = Ambiguate(target, 'none')
    self.game = game
    self.isFriend = ns.IsBNFriend(battleTag)
    self:Enable()
end

function Minion:Result(ok, reason)
    ns.Wargame:SendStartGameResult(ok, reason)
    self:Disable()
end
