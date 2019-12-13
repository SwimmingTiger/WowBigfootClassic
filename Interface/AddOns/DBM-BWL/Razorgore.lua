local mod	= DBM:NewMod("Razorgore", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20191206204159")
mod:SetCreatureID(12435, 99999)--Bogus detection to prevent invalid kill detection if razorgore happens to die in phase 1
mod:SetEncounterID(610)--BOSS_KILL is valid, but ENCOUNTER_END is not
mod:DisableEEKillDetection()--So disable only EE
mod:SetModelID(10115)
mod:SetMinSyncRevision(168)
mod:RegisterCombat("yell", L.YellPull)
mod:SetWipeTime(180)--guesswork

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 23023",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
)

local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnConflagration		= mod:NewTargetNoFilterAnnounce(23023, 2)

local timerAddsSpawn		= mod:NewTimer(47, "TimerAddsSpawn", 19879, nil, nil, 1)--Only for start of adds, not adds after the adds.

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	timerAddsSpawn:Start()
	self.vb.phase = 1
end

do
	local Conflagration = DBM:GetSpellInfo(23023)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 23023 and args:IsDestTypePlayer() then
		if args.spellName == Conflagration and args:IsDestTypePlayer() then
			self:SendSync("Conflag", args.destName)
			if self:AntiSpam(5, args.destName) then
				warnConflagration:Show(args.destName)
			end
		end
	end
end

--For some reason this no longer works
function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.Phase2Emote or msg:find(L.Phase2Emote) then
		self:SendSync("Phase2")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 12435 and self.vb.phase == 2 then--Only trigger kill for unit_died if he dies in phase 2, otherwise it's an auto wipe.
		--self:SendSync("Win")
		DBM:EndCombat(self)
	end
end

function mod:OnSync(msg, name)
	if not self:IsInCombat() then return end
	if msg == "Phase2" then
		warnPhase2:Show()
		self.vb.phase = 2
	elseif msg == "Conflag" and name and self:AntiSpam(5, name) then
		warnConflagration:Show(name)
	--elseif msg == "Win" then
	--	DBM:EndCombat(self)
	end
end
