local mod	= DBM:NewMod(640, "DBM-Party-WotLK", 10, 285)
local L		= mod:GetLocalizedStrings()


mod:SetRevision("20221006190430")
mod:SetCreatureID(23954)--23980 is no longer used like it was in wrath. Kept just to keep first death from ending fight early
mod:SetMainBossID(23954)
mod:SetEncounterID(2025)
mod.noBossDeathKill = true--Ignore death, since he dies twice

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)--Yell seems removed on retail, but maybe it'll return in classic WoTLK. Although I doubt it. Classic viscidous removedd explode emote on retail AND classic

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 42723 42669 59706 59709 42708 42729 59708 59734",
	"SPELL_AURA_APPLIED 42730 59735",
	"SPELL_AURA_REMOVED 42730 59735",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warningWoeStrike	= mod:NewTargetNoFilterAnnounce(42730, 2, nil, "RemoveCurse", 2)

local specWarnSpelllock	= mod:NewSpecialWarningCast(42729, "SpellCaster", nil, 2, 1, 2)
local specWarnSmash		= mod:NewSpecialWarningDodge(42723, "Tank", nil, nil, 1, 2)

local timerSmash		= mod:NewCastTimer(3, 42723, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerWoeStrike	= mod:NewTargetTimer(10, 42723, nil, "RemoveCurse", nil, 5, nil, DBM_COMMON_L.CURSE_ICON)

function mod:OnCombatStart(delay)
	self:SetStage(1)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(42723, 42669, 59706, 59709) then
		specWarnSmash:Show()
		specWarnSmash:Play("shockwave")
		timerSmash:Start()
	elseif args:IsSpellID(42708, 42729, 59708, 59734) then
		specWarnSpelllock:Show()
		specWarnSpelllock:Play("stopcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42730, 59735) then
		warningWoeStrike:Show(args.destName)
		timerWoeStrike:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(42730, 59735) then
		timerWoeStrike:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 23954 then--Only trigger kill for unit_died if he dies in phase 2 with at least one player alive, otherwise it's an auto wipe.
		if DBM:NumRealAlivePlayers() > 0 and self.vb.phase == 2 then
			DBM:EndCombat(self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 42863 then -- Scourge Resurrection
		self:SendSync("Stage2")
	end
end

function mod:OnSync(event, arg)
	if not self:IsInCombat() then return end
	if event == "Stage2" then
		self:SetStage(2)
	end
end
