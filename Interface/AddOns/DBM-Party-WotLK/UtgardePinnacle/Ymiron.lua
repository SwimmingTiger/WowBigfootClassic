local mod	= DBM:NewMod(644, "DBM-Party-WotLK", 11, 286)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20220724021612")
mod:SetCreatureID(26861)
mod:SetEncounterID(2028)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 51750",
	"SPELL_AURA_APPLIED 48294 59301",
	"SPELL_AURA_REMOVED 48294 59301"
)

local warningBane		= mod:NewSpellAnnounce(48294, 3)
local warningScreams	= mod:NewSpellAnnounce(51750, 2)

local timerBane			= mod:NewBuffActiveTimer(5, 48294, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerScreams		= mod:NewBuffActiveTimer(8, 51750, nil, nil, nil, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 51750 then
		warningScreams:Show()
		timerScreams:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48294, 59301) then
		warningBane:Show()
		timerBane:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(48294, 59301) then
		timerBane:Stop()
	end
end
