local mod	= DBM:NewMod("EdwinVanCleef", "DBM-Party-Classic", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190824201836")
mod:SetCreatureID(639)
--mod:SetEncounterID(1144)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 5200",
	"SPELL_AURA_APPLIED 3391"
)

local warningThrash					= mod:NewSpellAnnounce(3391, 3)
local warningAllies					= mod:NewSpellAnnounce(5200, 3)

local timerTrashD					= mod:NewAITimer(180, 3391, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerTrashD:Start(1-delay)
end

do
	local VanCleefAllies = DBM:GetSpellInfo(5200)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 5200 and self:AntiSpam(3, 1) then
		if args.spellName == VanCleefAllies and self:AntiSpam(3, 1) then
			warningAllies:Show()
		end
	end
end

do
	local Thrash = DBM:GetSpellInfo(3391)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 3391 then
		if args.spellName == Thrash and args:IsDestTypeHostile() then
			warningThrash:Show()
			timerTrashD:Start()
		end
	end
end
