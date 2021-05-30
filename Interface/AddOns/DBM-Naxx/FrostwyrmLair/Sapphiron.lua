local mod	= DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210525105043")
mod:SetCreatureID(15989)
mod:SetEncounterID(1119)
--mod:SetModelID(16033)--Scales incorrectly
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28522 28547",
	"SPELL_CAST_START 28524",
	"SPELL_CAST_SUCCESS 28542"--55665 Wrath spellId
)


--[[
ability.id = 28524 and type = "begincast"
 or (ability.id = 28542 or ability.id = 28560) and type = "cast"
--]]
--TODO, air phase and landing better detection from transcriptor, timer adjustments
local warnDrainLifeNow	= mod:NewSpellAnnounce(28542, 2)
local warnDrainLifeSoon	= mod:NewSoonAnnounce(28542, 1)
local warnIceBlock		= mod:NewTargetNoFilterAnnounce(28522, 2)
local warnAirPhaseSoon	= mod:NewAnnounce("WarningAirPhaseSoon", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnAirPhaseNow	= mod:NewAnnounce("WarningAirPhaseNow", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnLanded		= mod:NewAnnounce("WarningLanded", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

local warnBlizzard		= mod:NewSpecialWarningGTFO(28547, nil, nil, nil, 1, 8)
local warnDeepBreath	= mod:NewSpecialWarning("WarningDeepBreath", nil, nil, nil, 1, 2)
local yellIceBlock		= mod:NewYell(28522)

local timerDrainLife	= mod:NewCDTimer(22, 28542, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerAirPhase		= mod:NewTimer(66, "TimerAir", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)--80?
local timerLanding		= mod:NewTimer(28.5, "TimerLanding", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerIceBlast		= mod:NewTimer(7, "TimerIceBlast", 15876, nil, nil, 2, DBM_CORE_L.DEADLY_ICON)

local berserkTimer		= mod:NewBerserkTimer(900)

mod:AddRangeFrameOption(10, 28522)

local noTargetTime = 0
mod.vb.isFlying = false
local UnitAffectingCombat = UnitAffectingCombat

local function resetIsFlying(self)
	self.vb.isFlying = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function Landing()
	warnAirPhaseSoon:Schedule(56)
	warnLanded:Show()
	timerAirPhase:Start()--66
end

function mod:OnCombatStart(delay)
	noTargetTime = 0
	self.vb.isFlying = false
	warnAirPhaseSoon:Schedule(38.5 - delay)
	timerAirPhase:Start(48.5 - delay)
	berserkTimer:Start(-delay)
	self:RegisterOnUpdateHandler(function(self, elapsed)
		if not self:IsInCombat() then return end
		local foundBoss, target
		for uId in DBM:GetGroupMembers() do
			local unitID = uId.."target"
			if self:GetUnitCreatureId(unitID) == 15989 and UnitAffectingCombat(unitID) then
				target = DBM:GetUnitFullName(unitID.."target")
				foundBoss = true
				break
			end
		end
		if foundBoss and not target then
			noTargetTime = noTargetTime + elapsed
		elseif foundBoss then
			noTargetTime = 0
		end
		--Timers don't appear right for classic, close but might need some slight tweaking
		if noTargetTime > 0.5 and not self.vb.isFlying then
			noTargetTime = 0
			self.vb.isFlying = true
			self:Schedule(60, resetIsFlying, self)
			timerDrainLife:Cancel()
			warnDrainLifeSoon:Cancel()
			timerAirPhase:Cancel()
			warnAirPhaseNow:Show()
			timerLanding:Start()--28.5 (seems mostly right)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	end, 0.2)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28522 and args:IsDestTypePlayer() then
		warnIceBlock:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellIceBlock:Yell()
		end
	elseif args.spellId == 28547 and args:IsPlayer() then
		warnBlizzard:Show(args.spellName)
		warnBlizzard:Play("watchfeet")
	end
end

function mod:SPELL_CAST_START(args)
	--if args:IsSpellID(28542, 55665) then -- Life Drain
	if args.spellId == 28524 and args:IsSrcTypeHostile() then -- Frost Breath
		timerIceBlast:Start()
		timerLanding:Update(16.3, 28.5)--Probably not even needed, if base timer is more accurate
		self:Schedule(12.2, Landing, self)
		warnDeepBreath:Show()
		warnDeepBreath:Play("findshelter")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	--if args:IsSpellID(28542, 55665) then -- Life Drain
	if args.spellId == 28542 and args:IsSrcTypeHostile() then -- Life Drain
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(18.5)
		timerDrainLife:Start()
	end
end
