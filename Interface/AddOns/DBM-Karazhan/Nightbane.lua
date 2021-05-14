local mod	= DBM:NewMod("NightbaneRaid", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210414181517")
mod:SetCreatureID(17225)
mod:SetEncounterID(662, 2454)
mod:SetModelID(18062)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 36922",
	"SPELL_CAST_SUCCESS 37098",
	"SPELL_AURA_APPLIED 30129 30130",
	"CHAT_MSG_MONSTER_YELL"
)

local warningFear			= mod:NewSpellAnnounce(36922, 4)
local warningAsh			= mod:NewTargetAnnounce(30130, 2, nil, false)
local WarnAir				= mod:NewAnnounce("DBM_NB_AIR_WARN", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warningBone			= mod:NewSpellAnnounce(37098, 3)

local specWarnCharred		= mod:NewSpecialWarningGTFO(30129, nil, nil, nil, 1, 6)

local timerNightbane		= mod:NewCombatTimer(36)
local timerFearCD			= mod:NewCDTimer(31.5, 36922, nil, nil, nil, 2)
local timerAirPhase			= mod:NewTimer(57, "timerAirPhase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerBone				= mod:NewBuffActiveTimer(11, 37098, nil, nil, nil, 1)

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.DBM_NB_EMOTE_PULL then
		timerNightbane:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 36922 then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37098 then
		warningBone:Show()
		timerBone:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30129 and args:IsPlayer() and not self:IsTrivial() and self:AntiSpam() then
		specWarnCharred:Show(args.spellName)
		specWarnCharred:Play("watchfeet")
	elseif args.spellId == 30130 then
		warningAsh:Show(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_NB_YELL_AIR then
		WarnAir:Show()
		timerAirPhase:Stop()
		timerAirPhase:Start()
	elseif msg == L.DBM_NB_YELL_GROUND or msg == L.DBM_NB_YELL_GROUND2 then--needed. because if you deal more 25% damage in air phase, air phase repeated and shroten. So need to update exact ground phase.
		timerAirPhase:Update(43, 57)
	end
end
