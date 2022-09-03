local mod	= DBM:NewMod(600, "DBM-Party-WotLK", 6, 275)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20220724021612")
mod:SetCreatureID(28923)
mod:SetEncounterID(1986)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 52960 59835"
)

local warningNova	= mod:NewSpellAnnounce(52960, 3)

--local timerNovaCD	= mod:NewCDTimer(30, 52960, nil, nil, nil, 2)
local timerAchieve	= mod:NewAchievementTimer(120, 1867)

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(52960, 59835) then
		warningNova:Show()
--		timerNovaCD:Start()
	end
end
