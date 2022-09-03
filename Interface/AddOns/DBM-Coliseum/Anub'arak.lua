local mod	= DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220816155700")
mod:SetCreatureID(34564)
mod:SetEncounterID(1085)
mod:SetModelID(29268)
mod:SetUsedIcons(1, 2, 3, 4, 5, 8)
mod:SetMinSyncRevision(20220623000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 67574 66013 66012 1022",
	"SPELL_AURA_REFRESH 67574 66013 66012",
	"SPELL_AURA_REMOVED 66013 1022",
	"SPELL_CAST_START 66118 66134",
	"RAID_BOSS_EMOTE"
)

local warnAdds				= mod:NewAnnounce("warnAdds", 3, 45419)
local preWarnShadowStrike	= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike		= mod:NewSpellAnnounce(66134, 4)
local warnPursue			= mod:NewTargetNoFilterAnnounce(67574, 4)
local warnFreezingSlash		= mod:NewTargetNoFilterAnnounce(66012, 2, nil, "Tank|Healer")
local warnHoP				= mod:NewTargetNoFilterAnnounce(1022, 2, nil, false)--Heroic strat revolves around kiting pursue and using Hand of Protection.
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnPursue		= mod:NewSpecialWarningRun(67574, nil, nil, 2, 4, 2)
local specWarnShadowStrike	= mod:NewSpecialWarningSpell(66134, false, nil, 2, 1)--Don't have a good voice for this. Need a "stun mob now"
local specWarnPCold			= mod:NewSpecialWarningYou(66013, false, nil, nil, 1, 2)

local timerAdds				= mod:NewTimer(45, "timerAdds", 45419, nil, nil, 1)
local timerSubmerge			= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerEmerge			= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerFreezingSlash	= mod:NewCDTimer(20, 66012, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerPCold			= mod:NewBuffActiveTimer(15, 66013, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerShadowStrike		= mod:NewNextTimer(30.5, 66134, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerHoP				= mod:NewBuffActiveTimer(10, 1022, nil, false, nil, 5)--So we will track bops to make this easier.

local enrageTimer			= mod:NewBerserkTimer(570)	-- 9:30 ? hmpf (no enrage while submerged... this sucks)

mod:AddSetIconOption("PursueIcon", 67574, true, 0, {8})
mod:AddSetIconOption("SetIconsOnPCold", 66013, true, 7, {1, 2, 3, 4, 5})
mod:AddBoolOption("AnnouncePColdIcons", false, nil, nil, nil, nil, 66013)
mod:AddBoolOption("AnnouncePColdIconsRemoved", false, nil, nil, nil, nil, 66013)

mod.vb.Burrowed = false

local function Adds(self)
	if self:IsInCombat() then
		if not self.vb.Burrowed then
			timerAdds:Start()
			warnAdds:Schedule(45)
			self:Schedule(45, Adds, self)
		end
	end
end

local function ShadowStrike(self)
	self:Unschedule(ShadowStrike)
	if self:IsInCombat() then
		timerShadowStrike:Stop()
		timerShadowStrike:Start()
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25.5)
		self:Schedule(30.5, ShadowStrike, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.Burrowed = false
	timerAdds:Start(10-delay)
	warnAdds:Schedule(10-delay)
	self:Schedule(10-delay, Adds, self)
	warnSubmergeSoon:Schedule(70-delay)
	timerSubmerge:Start(80-delay)
	enrageTimer:Start(-delay)
	timerFreezingSlash:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerShadowStrike:Start()
		preWarnShadowStrike:Schedule(25.5-delay)
		self:Schedule(30.5-delay, ShadowStrike, self)
	end
end

function mod:AnnouncePcoldIcons(uId, icon)
	if self.Options.AnnouncePColdIcons and IsInGroup() and DBM:GetRaidRank() > 1 then
		SendChatMessage(L.PcoldIconSet:format(icon, DBM:GetUnitFullName(uId)), IsInRaid() and "RAID" or "PARTY")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67574 then
		if args:IsPlayer() then
			specWarnPursue:Show()
			specWarnPursue:Play("justrun")
			specWarnPursue:ScheduleVoice(1.5, "keepmove")
		else
			warnPursue:Show(args.destName)
		end
		if self.Options.PursueIcon then
			self:SetIcon(args.destName, 8, 15)
		end
	elseif args.spellId == 66013 then
		timerPCold:Show()
		if args:IsPlayer() then
			specWarnPCold:Show()
			specWarnPCold:Play("targetyou")
		end
		if self.Options.SetIconsOnPCold then
			local maxIcon = self:IsDifficulty("normal25", "heroic25") and 5 or 2
			self:SetSortedIcon("roster", 1, args.destName, 1, maxIcon, false, "AnnouncePcoldIcons")
		end
	elseif args.spellId == 66012 then
		warnFreezingSlash:Show(args.destName)
		timerFreezingSlash:Start()
	elseif args.spellId == 1022 and self:IsInCombat() then
		warnHoP:Show(args.destName)
		timerHoP:Start(args.destName)
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 66013 then
		if self.Options.SetIconsOnPCold then
			self:SetIcon(args.destName, 0)
			if self.Options.AnnouncePColdIconsRemoved and DBM:GetRaidRank() > 1 then
				SendChatMessage(L.PcoldIconRemoved:format(args.destName), "RAID")
			end
		end
	elseif args.spellId == 1022 and self:IsInCombat() then
		timerHoP:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 66118 then
		warnPhase3:Show()
		warnEmergeSoon:Cancel()
		warnSubmergeSoon:Cancel()
		timerEmerge:Stop()
		timerSubmerge:Stop()
		if self:IsDifficulty("normal10", "normal25") then
			timerAdds:Cancel()
			warnAdds:Cancel()
			self:Unschedule(Adds)
		end
	elseif args.spellId == 66134 then
		self:Unschedule(ShadowStrike)
		ShadowStrike(self)
		if self.Options.SpecWarn66134spell then
			specWarnShadowStrike:Show()
		else
			warnShadowStrike:Show()
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		self.vb.Burrowed = true
		timerAdds:Cancel()
		warnAdds:Cancel()
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
	elseif msg and msg:find(L.Emerge) then
		self.vb.Burrowed = false
		timerAdds:Start(5)
		warnAdds:Schedule(5)
		self:Schedule(5, Adds, self)
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(65)
		timerSubmerge:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerShadowStrike:Stop()
			preWarnShadowStrike:Cancel()
			self:Unschedule(ShadowStrike)
			self:Schedule(5.5, ShadowStrike, self)
		end
	end
end
