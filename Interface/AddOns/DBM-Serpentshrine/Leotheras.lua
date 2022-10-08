local mod	= DBM:NewMod("Leotheras", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220923022829")
mod:SetCreatureID(21215)
mod:SetEncounterID(625, 2460)
mod:SetModelID(20514)
mod:SetUsedIcons(5, 6, 7, 8)
mod:SetHotfixNoticeRev(20220114000000)--01-14-22
mod:SetMinSyncRevision(20220114000000)--01-14-22
mod:DisableRegenDetection()--Disable Player regen pull detection
--mod:DisableESCombatDetection()--Disable ENCOUNTER_START

mod:RegisterCombat("combat")

--TODO, possibly adjust timers for unit died P1 trigger method. Yell method should primarily be a backup, not primary, but kept around for now
--Not using RegisterEventsInCombat on purpose because it uses weird combat rules
--mod:RegisterEvents(
--	"UNIT_DIED"
--)
mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 37640 37676 37749",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase			= mod:NewAnnounce("WarnPhase", 2)
local warnDemon			= mod:NewTargetAnnounce(37676, 4)
local warnMC			= mod:NewTargetNoFilterAnnounce(37749, 4)
local warnPhase2		= mod:NewPhaseAnnounce(2, 2)

local specWarnWhirl		= mod:NewSpecialWarningRun(37640, nil, nil, nil, 4, 2)
local specWarnDemon		= mod:NewSpecialWarningYou(37676, nil, nil, nil, 1, 2)

local timerWhirlCD		= mod:NewCDTimer(27, 37640, nil, nil, nil, 2)
local timerWhirl		= mod:NewBuffActiveTimer(12, 37640, nil, nil, nil, 2)
local timerPhase		= mod:NewTimer(60, "TimerPhase", 39088, nil, nil, 6)
local timerDemonCD		= mod:NewCDTimer(23, 37676, nil, nil, nil, 6)
local timerDemon		= mod:NewBuffFadesTimer(30, 37676, nil, nil, nil, 6)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("DemonIcon", 37676, false, false, {8, 7, 6, 5})

local warnDemonTargets = {}
local warnMCTargets = {}
mod.vb.binderKill = 0
mod.vb.demonIcon = 8
mod.vb.whirlCount = 0

local function humanWarns(self)
	self.vb.whirlCount = 0
	warnPhase:Show(L.Human)
	--timerWhirlCD:Start(15)
	timerPhase:Start(45, L.Demon)
end

local function showDemonTargets(self)
	warnDemon:Show(table.concat(warnDemonTargets, "<, >"))
	table.wipe(warnDemonTargets)
	self.vb.demonIcon = 8
	timerDemon:Start()
end

local function showMCTargets()
	warnMC:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	self.vb.binderKill = 0
	self.vb.demonIcon = 8
	self.vb.whirlCount = 0
	table.wipe(warnMCTargets)
	table.wipe(warnDemonTargets)
end

function mod:OnCombatEnd(delay)
	self.vb.binderKill = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37640 then
		specWarnWhirl:Show()
		specWarnWhirl:Play("justrun")
		timerWhirl:Start()
		if self.vb.phase ~= 2 then
			self.vb.whirlCount = self.vb.whirlCount + 1
			if self.vb.whirlCount < 3 then
				timerWhirlCD:Start()
			end
		else
			timerWhirlCD:Start()
		end
	elseif args.spellId == 37676 then
		warnDemonTargets[#warnDemonTargets + 1] = args.destName
		self:Unschedule(showDemonTargets)
		if self.Options.DemonIcon then
			self:SetIcon(args.destName, self.vb.demonIcon)
			self.vb.demonIcon = self.vb.demonIcon - 1
		end
		if args:IsPlayer() then
			specWarnDemon:Show()
			specWarnDemon:Play("targetyou")
		end
		if #warnDemonTargets >= 5 then
			showDemonTargets(self)
		else
			self:Schedule(0.7, showDemonTargets, self)
		end
	elseif args.spellId == 37749 then
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMCTargets)
		self:Schedule(0.3, showMCTargets)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDemon or msg:find(L.YellDemon) then
		self:SendSync("Demon")
    elseif msg == L.YellPhase1 or msg:find(L.YellPhase1) then
        self:SendSync("Phase1")
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		self:SendSync("Phase2")
	end
end

function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21806 then
		self.vb.binderKill = self.vb.binderKill + 1
		if self.vb.binderKill == 3 and self.vb.phase == 0  then
			self:SetStage(1)
			timerWhirlCD:Start(15)
			timerPhase:Start(60, L.Demon)
			berserkTimer:Start()
		end
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Demon" then
		warnPhase:Show(L.Demon)
		timerWhirl:Cancel()
		timerWhirlCD:Cancel()
		timerPhase:Cancel()
		timerDemonCD:Start()
		timerPhase:Start(nil, L.Human)
		self:Schedule(60, humanWarns, self)
	elseif msg == "Phase2" and self.vb.phase < 2 then
		self:SetStage(2)
		self:Unschedule(humanWarns)
		timerPhase:Cancel()
		timerWhirl:Cancel()
		timerWhirlCD:Cancel()
		timerDemonCD:Cancel()
		warnPhase2:Show()
		timerWhirlCD:Start(22.5)
    elseif msg == "Phase1" and self.vb.phase == 0 then
		self:SetStage(1)
		timerWhirlCD:Start(15)
		timerPhase:Start(60, L.Demon)
		berserkTimer:Start()
	end
end
