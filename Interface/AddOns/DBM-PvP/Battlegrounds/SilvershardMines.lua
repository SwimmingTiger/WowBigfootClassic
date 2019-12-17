if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z727", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190908135243")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 727 then
			bgzone = true
			self:RegisterShortTermEvents(
				"CHAT_MSG_BG_SYSTEM_HORDE",
				"CHAT_MSG_BG_SYSTEM_ALLIANCE",
				"CHAT_MSG_BG_SYSTEM_NEUTRAL",
				"CHAT_MSG_RAID_BOSS_EMOTE"
			)
		elseif bgzone then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end

do
	local cartTimer	= mod:NewTimer(9.5, "TimerCart", "134376") -- interface/icons/inv_misc_pocketwatch_01.blp
	local cartCount	= 0

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
		-- TODO: Can we track the differnce between alliance and horde carts?
		if msg:find(L.Capture) then
			cartCount = cartCount + 1
			cartTimer:Start(nil, cartCount)
		end
	end
	mod.CHAT_MSG_BG_SYSTEM_ALLIANCE = mod.CHAT_MSG_RAID_BOSS_EMOTE
	mod.CHAT_MSG_BG_SYSTEM_HORDE = mod.CHAT_MSG_RAID_BOSS_EMOTE
	mod.CHAT_MSG_BG_SYSTEM_NEUTRAL = mod.CHAT_MSG_RAID_BOSS_EMOTE
end
