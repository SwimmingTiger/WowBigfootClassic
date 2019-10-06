local mod	= DBM:NewMod("Viscidus", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(15299)
mod:SetEncounterID(713)
mod:SetModelID(15686)
mod:SetMinSyncRevision(428)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_EMOTE"
)

--TODO, frost damage counter on infoframe (if I recall, it was 250k frost damage to freeze)
--TODO, melee hit counter on infoframe (x number of melee hits to shatter)
local warnFreeze		= mod:NewAnnounce("WarnFreeze", 2, 33395)
local warnShatter		= mod:NewAnnounce("WarnShatter", 2, 12982)

local timerFrozen		= mod:NewBuffActiveTimer(30, 25937, nil, nil, nil, 6)

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.Phase4) then
		self:SendSync("Phase", 1)
	elseif msg:find(L.Phase5) then
		self:SendSync("Phase", 2)
	elseif msg:find(L.Phase6) then
		self:SendSync("Phase", 3)
	elseif msg:find(L.Slow) then
		self:SendSync("Slow")
	elseif msg:find(L.Freezing) then
		self:SendSync("Freezing")
	elseif msg:find(L.Frozen) then
		self:SendSync("Frozen")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Phase" then
		local count = tonumber(arg)
		warnShatter:Show(count)
		if count == 3 then
			timerFrozen:Stop()
		end
	elseif msg == "Slow" then
		warnFreeze:Show(1)
	elseif msg == "Freezing" then
		warnFreeze:Show(2)
	elseif msg == "Frozen" then
		warnFreeze:Show(3)
		timerFrozen:Start()
	end
end
