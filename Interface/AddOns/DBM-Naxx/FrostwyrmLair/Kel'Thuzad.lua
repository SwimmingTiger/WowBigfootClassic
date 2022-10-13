local mod	= DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()
local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)

mod:SetRevision("20221010034753")
mod:SetCreatureID(15990)
mod:SetEncounterID(1114)
--mod:SetModelID(15945)--Doesn't work at all, doesn't even render.
mod:SetMinCombatTime(60)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat_yell", L.Yell)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 27808 27819 28410",
	"SPELL_AURA_REMOVED 28410",
	"SPELL_CAST_SUCCESS 27810 27819 27808",
	"UNIT_HEALTH boss1",
	"UNIT_TARGETABLE_CHANGED"
)

--Check if UNIT_TARGETABLE_CHANGED exists in classic wrath. It was a tech they didn't really use until WoD
local warnAddsSoon			= mod:NewAnnounce("warnAddsSoon", 1, "134321")
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnBlastTargets		= mod:NewTargetAnnounce(27808, 2)

--Fissure needs custom code since blizzard went out of their way to break it in classic
local warnFissure
local specWarnFissureYou
local specWarnFissureClose
local yellFissure
if isRetail then
	warnFissure				= mod:NewTargetNoFilterAnnounce(27810, 4, nil, nil, nil, nil, nil, 2)
	specWarnFissureYou		= mod:NewSpecialWarningYou(27810, nil, nil, nil, 3, 2)
	specWarnFissureClose	= mod:NewSpecialWarningClose(27810, nil, nil, nil, 2, 2)
	yellFissure				= mod:NewYell(27810)
else
	warnFissure				= mod:NewSpellAnnounce(27810, 4)
end
local warnMana				= mod:NewTargetAnnounce(27819, 2)
local warnChainsTargets		= mod:NewTargetNoFilterAnnounce(28410, 4)

local specwarnP2Soon		= mod:NewSpecialWarning("specwarnP2Soon")
local specWarnManaBomb		= mod:NewSpecialWarningMoveAway(27819, nil, nil, nil, 1, 2)
local yellManaBomb			= mod:NewShortYell(27819)
local specWarnBlast			= mod:NewSpecialWarningTarget(27808, "Healer", nil, nil, 1, 2)

local blastTimer			= mod:NewBuffActiveTimer(4, 27808, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerManaBomb			= mod:NewCDTimer(20, 27819, nil, nil, nil, 3)--20-50
local timerFrostBlast		= mod:NewCDTimer(40.1, 27808, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--40-46 (might be 33-46)
local timerMC				= mod:NewBuffActiveTimer(20, 28410, nil, nil, nil, 3)
--local timerMCCD			= mod:NewCDTimer(90, 28410, nil, nil, nil, 3)--actually 60 second cdish but its easier to do it this way for the first one.
local timerPhase2			= mod:NewTimer(225, "TimerPhase2", "136116", nil, nil, 6)

mod:AddSetIconOption("SetIconOnMC", 28410, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnManaBomb", 27819, false, false, {8})
mod:AddSetIconOption("SetIconOnFrostTomb", 28169, true, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddRangeFrameOption(10, 27819)

mod.vb.warnedAdds = false
mod.vb.MCIcon = 1
local frostBlastTargets = {}
local chainsTargets = {}

local function AnnounceChainsTargets(self)
	warnChainsTargets:Show(table.concat(chainsTargets, "< >"))
	table.wipe(chainsTargets)
	self.vb.MCIcon = 1
end

local function AnnounceBlastTargets(self)
	if self.Options.SpecWarn27808target then
		specWarnBlast:Show(table.concat(frostBlastTargets, "< >"))
		specWarnBlast:Play("healall")
	else
		warnBlastTargets:Show(table.concat(frostBlastTargets, "< >"))
	end
	blastTimer:Start(3.5)
	if self.Options.SetIconOnFrostTomb then
		for i = #frostBlastTargets, 1, -1 do
			self:SetIcon(frostBlastTargets[i], 8 - i, 4.5)
			frostBlastTargets[i] = nil
		end
	end
end

local function RangeToggle(show)
	if show then
		DBM.RangeCheck:Show(10)
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(chainsTargets)
	table.wipe(frostBlastTargets)
	self.vb.warnedAdds = false
	self.vb.MCIcon = 1
	specwarnP2Soon:Schedule(214-delay)
	timerPhase2:Start()
	--Redundancy below here isn't needed on retail but may be on wrath classic
	if not isRetail then
		warnPhase2:Schedule(224)
		if self.Options.RangeFrame then
			self:Schedule(224-delay, RangeToggle, true)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 27810 then
		if isRetail then
			if args:IsPlayer() then
				specWarnFissureYou:Show()
				specWarnFissureYou:Play("targetyou")
				yellFissure:Yell()
			elseif self:CheckNearby(8, args.destName) then
				specWarnFissureClose:Show(args.destName)
				specWarnFissureClose:Play("watchfeet")
			else
				warnFissure:Show(args.destName)
			end
		else
			warnFissure:Show()
		end
	elseif args.spellId == 27819 then
		timerManaBomb:Start()
	elseif args.spellId == 27808 then
		timerFrostBlast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 27808 then -- Frost Blast
		table.insert(frostBlastTargets, args.destName)
		self:Unschedule(AnnounceBlastTargets)
		self:Schedule(0.5, AnnounceBlastTargets, self)
	elseif args.spellId == 27819 then -- Mana Bomb
		if self.Options.SetIconOnManaBomb then
			self:SetIcon(args.destName, 8, 5.5)
		end
		if args:IsPlayer() then
			specWarnManaBomb:Show()
			specWarnManaBomb:Play("scatter")
			yellManaBomb:Yell()
		else
			warnMana:Show(args.destName)
		end
	elseif args.spellId == 28410 then -- Chains of Kel'Thuzad
		chainsTargets[#chainsTargets + 1] = args.destName
		if self:AntiSpam() then
			timerMC:Start()
			--timerMCCD:Start(60)--60 seconds?
		end
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, self.vb.MCIcon)
		end
		self.vb.MCIcon = self.vb.MCIcon + 1
		self:Unschedule(AnnounceChainsTargets)
		if #chainsTargets >= 3 then
			AnnounceChainsTargets(self)
		else
			self:Schedule(1.0, AnnounceChainsTargets, self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28410 then
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedAdds and self:GetUnitCreatureId(uId) == 15990 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.48 then
		self.vb.warnedAdds = true
		warnAddsSoon:Show()
	end
end

function mod:UNIT_TARGETABLE_CHANGED()
	if self.vb.phase == 1 then
		self:Unschedule(RangeToggle)
		warnPhase2:Cancel()
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end
