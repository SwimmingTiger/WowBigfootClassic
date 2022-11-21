local mod	= DBM:NewMod(618, "DBM-Party-WotLK", 8, 281)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20221013055519")
mod:SetCreatureID(26731)
mod:SetEncounterID(2010)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_HEALTH boss1",
	"CHAT_MSG_MONSTER_YELL"
)

local warningSplitSoon, warningSplitNow
if mod:IsClassic() then
	warningSplitSoon	= mod:NewSoonAnnounce(19570, 2)
	warningSplitNow		= mod:NewSpellAnnounce(19570, 3)
else
	warningSplitSoon	= mod:NewSoonAnnounce("ej7395", 2)
	warningSplitNow		= mod:NewSpellAnnounce("ej7395", 3)
end

mod.vb.warnedSplit1		= false
mod.vb.warnedSplit2		= false

function mod:OnCombatStart()
	self.vb.warnedSplit1 = false
	self.vb.warnedSplit2 = false
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedSplit1 and self:GetUnitCreatureId(uId) == 26731 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.58 then
		self.vb.warnedSplit1 = true
		warningSplitSoon:Show()
	elseif not self.vb.warnedSplit2 and not self:IsDifficulty("normal5") and self:GetUnitCreatureId(uId) == 26731 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.19 then
		self.vb.warnedSplit2 = true
		warningSplitSoon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SplitTrigger1 or msg == L.SplitTrigger2 then
		warningSplitNow:Show()
	end
end
