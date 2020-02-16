local mod	= DBM:NewMod("Vaelastrasz", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200214232222")
mod:SetCreatureID(13020)
mod:SetEncounterID(611)
mod:SetModelID(13992)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23461",
	"SPELL_AURA_APPLIED 18173",
	"SPELL_AURA_REMOVED 18173"
)

--TODO, Burning Adrenaline have an actual CD timer?
local warnBreath			= mod:NewCastAnnounce(23461, 2, nil, nil, "Tank", 2)
local warnAdrenaline		= mod:NewTargetNoFilterAnnounce(18173, 2)

local specWarnAdrenaline	= mod:NewSpecialWarningYou(18173, nil, nil, nil, 1, 2)
local yellAdrenaline		= mod:NewYell(18173, nil, false)

local timerAdrenaline		= mod:NewTargetTimer(20, 18173, nil, nil, nil, 3)
local timerCombatStart		= mod:NewCombatTimer(43)

do
	local FlameBreath = DBM:GetSpellInfo(23461)
	print(FlameBreath)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 23461 then
		if args.spellName == FlameBreath then
			self:SendSync("Breath")
			if self:AntiSpam(8, 1) then
				warnBreath:Show()
			end
		end
	end
end

do
	local BurningAdrenaline = DBM:GetSpellInfo(18173)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 18173 then
		if args.spellName == BurningAdrenaline then
			if self:AntiSpam(5, "Adrenaline") then
				self:SendSync("Adrenaline", args.destName)
			end
			if self:AntiSpam(5, args.destName) then
				timerAdrenaline:Start(args.destName)
				if args:IsPlayer() then
					specWarnAdrenaline:Show()
					specWarnAdrenaline:Play("targetyou")
					yellAdrenaline:Yell()
				else
					warnAdrenaline:Show(args.destName)
				end
			end
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		--if args.spellId == 18173 then
		if args.spellName == BurningAdrenaline then
			if self:AntiSpam(5, "AdrenalineOver") then
				self:SendSync("AdrenalineOver", args.destName)
			end
			timerAdrenaline:Stop(args.destName)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Event or msg:find(L.Event) then
		if self:AntiSpam(5, "PullRP") then
			self:SendSync("PullRP")
		end
	end
end

function mod:OnSync(msg, targetName)
	if self:AntiSpam(5, msg) then
		--Do nothing, this is just an antispam threshold for syncing
	end
	if msg == "PullRP" then
		timerCombatStart:Start()
	end
	if not self:IsInCombat() then return end
	if msg == "Breath" and self:AntiSpam(8, 1) then
		warnBreath:Show()
	elseif msg == "Adrenaline" and targetName and self:AntiSpam(5, targetName) then
		warnAdrenaline:Show(targetName)
		timerAdrenaline:Start(targetName)
	elseif msg == "AdrenalineOver" and targetName then
		timerAdrenaline:Stop(targetName)
	end
end
