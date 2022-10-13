local mod	= DBM:NewMod("Twins", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221010035226")
mod:SetCreatureID(25165, 25166)
mod:SetEncounterID(727, 2491)
mod:SetModelID(23334)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45230 45347 45348",
	"SPELL_AURA_APPLIED_DOSE 45347 45348",
	"SPELL_CAST_START 45248 45342 45329",
	"SPELL_CAST_SUCCESS 45342 45329",
	"SPELL_DAMAGE 45256",
	"SPELL_MISSED 45256",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnBlade				= mod:NewSpellAnnounce(45248, 3)
local warnBlow				= mod:NewTargetNoFilterAnnounce(45256, 3)
local warnConflag			= mod:NewTargetNoFilterAnnounce(45333, 3)
local warnNova				= mod:NewTargetNoFilterAnnounce(45329, 3)

local specWarnConflag		= mod:NewSpecialWarningYou(45333, nil, nil, nil, 1, 2)
local yellConflag			= mod:NewYell(45333, nil, false)
local specWarnNova			= mod:NewSpecialWarningYou(45329, nil, nil, nil, 1, 2)
local yellNova				= mod:NewYell(45329)
local specWarnPyro			= mod:NewSpecialWarningDispel(45230, "MagicDispeller", nil, 2, 1, 2)
local specWarnDarkTouch		= mod:NewSpecialWarningStack(45347, false, 5, nil, 2, 1, 6)
local specWarnFlameTouch	= mod:NewSpecialWarningStack(45348, false, 5, nil, nil, 1, 6)

local timerBladeCD			= mod:NewCDTimer(11.5, 45248, nil, "Melee", 2, 2)
local timerBlowCD			= mod:NewCDTimer(20, 45256, nil, nil, nil, 3)
local timerConflagCD		= mod:NewCDTimer(31, 45333, nil, nil, nil, 3)
local timerNovaCD			= mod:NewCDTimer(31, 45329, nil, nil, nil, 3)
local timerConflag			= mod:NewCastTimer(3.5, 45333, nil, false, 2)
local timerNova				= mod:NewCastTimer(3.5, 45329, nil, false, 2)

local berserkTimer			= mod:NewBerserkTimer(360)

mod:AddRangeFrameOption(10, 45333)
mod:AddSetIconOption("ConflagIcon", 45333, false, false, {8})
mod:AddSetIconOption("NovaIcon", 45329, false, false, {7})

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45248 then
		warnBlade:Show()
		timerBladeCD:Start()
	elseif args.spellId == 45342 then
		timerConflag:Start()
		timerConflagCD:Start()
	elseif args.spellId == 45329 then
		timerNova:Start()
		timerNovaCD:Start()
	end
end

--Redundant checks for nova and conflag that are slower but don't require locales
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45329 and args.destName and self:AntiSpam(5, args.destName..1) then
		if args:IsPlayer() then
			specWarnNova:Show()
			specWarnNova:Play("targetyou")
			yellNova:Yell()
		else
			warnNova:Show(args.destName)
		end
		if self.Options.NovaIcon then
			self:SetIcon(args.destName, 7, 5)
		end
	elseif args.spellId == 45342 and args.destName and self:AntiSpam(5, args.destName..2) then
		if args:IsPlayer() then
			specWarnConflag:Show()
			specWarnConflag:Play("targetyou")
			yellConflag:Yell()
		else
			warnConflag:Show(args.destName)
		end
		if self.Options.ConflagIcon then
			self:SetIcon(args.destName, 8, 5)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45230 and not args:IsDestTypePlayer() then
		specWarnPyro:Show(args.destName)
		specWarnPyro:Play("dispelboss")
	elseif args.spellId == 45347 and args:IsPlayer() then
		if (args.amount or 1) >= 5 and (args.amount % 5 == 0) then
			specWarnDarkTouch:Show(args.amount)
			specWarnDarkTouch:Play("stackhigh")
		end
	elseif args.spellId == 45348 and args:IsPlayer() then
		if (args.amount or 1) >= 5 and (args.amount % 5 == 0) then
			specWarnFlameTouch:Show(args.amount)
			specWarnFlameTouch:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_DAMAGE(_, _, _, _, _, destName, _, _, spellId)
	if spellId == 45256 then
		warnBlow:Show(destName)
		timerBlowCD:Start()
	end
end

function mod:SPELL_MISSED(_, _, _, _, _, _, _, _, spellId)
	if spellId == 45256 then
		timerBlowCD:Start()
	end
end

--Emotes still fire at cast start, which means getting target of cast before cast finishes
--This still acts as fastest way to get target. The additional checks in success are for locales that may be missing
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if (msg == L.Nova or msg:find(L.Nova)) and target and self:AntiSpam(5, target..1) then
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnNova:Show()
			specWarnNova:Play("targetyou")
			yellNova:Yell()
		else
			warnNova:Show(target)
		end
		if self.Options.NovaIcon then
			self:SetIcon(target, 7, 5)
		end
	elseif (msg == L.Conflag or msg:find(L.Conflag)) and target and self:AntiSpam(5, target..2) then
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnConflag:Show()
			specWarnConflag:Play("targetyou")
			yellConflag:Yell()
		else
			warnConflag:Show(target)
		end
		if self.Options.ConflagIcon then
			self:SetIcon(target, 8, 5)
		end
	end
end
