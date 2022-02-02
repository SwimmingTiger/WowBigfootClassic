local mod	= DBM:NewMod("Vashj", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220131033455")
mod:SetCreatureID(21212)
mod:SetEncounterID(628, 2463)
mod:SetModelID(20748)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20210919000000)
mod:SetMinSyncRevision(20210919000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 38280 38575 360327 38511",
	"SPELL_AURA_REMOVED 38280 38132 38112",
	"SPELL_CAST_START 38253",
	"SPELL_CAST_SUCCESS 38316 38511",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
--	"CHAT_MSG_LOOT"
)

local warnCharge		= mod:NewTargetNoFilterAnnounce(38280, 4)
local warnEntangle		= mod:NewSpellAnnounce(38316, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnElemental		= mod:NewAnnounce("WarnElemental", 4, 31687)
local warnStrider		= mod:NewAnnounce("WarnStrider", 3, 475)
local warnNaga			= mod:NewAnnounce("WarnNaga", 3, 2120)
local warnShield		= mod:NewAnnounce("WarnShield", 3, 38112)
--local warnLoot			= mod:NewAnnounce("WarnLoot", 4, 38132)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPersuasion	= mod:NewTargetNoFilterAnnounce(38511, 4)

--local specWarnCore		= mod:NewSpecialWarning("SpecWarnCore", nil, nil, nil, 1, 8)
local specWarnCharge	= mod:NewSpecialWarningMoveAway(38280, nil, nil, nil, 1, 2)
local yellCharge		= mod:NewYell(38280)
local specWarnElemental	= mod:NewSpecialWarning("SpecWarnElemental")--Changed from soon to a now warning. the soon warning not accurate because of 11 second variation so not useful special warning.
local specWarnToxic		= mod:NewSpecialWarningMove(38575, nil, nil, nil, 1, 2)

local timerCharge		= mod:NewTargetTimer(20, 38280, nil, nil, nil, 3)
local timerElemental	= mod:NewTimer(22, "TimerElementalActive", 39088, nil, nil, 1)--Blizz says they are active 20 seconds per patch notes, but my logs don't match those results. 22 second up time.
local timerElementalCD	= mod:NewTimer(45, "TimerElemental", 39088, nil, nil, 1)--46-57 variation. because of high variation the pre warning special warning not useful, fortunately we can detect spawns with precise timing.
local timerStrider		= mod:NewTimer(63, "TimerStrider", 475, nil, nil, 1)
local timerNaga			= mod:NewTimer(47.5, "TimerNaga", 2120, nil, nil, 1)
local timerMC			= mod:NewCDTimer(21, 38511, nil, nil, nil, 3)--21-27

mod:AddRangeFrameOption(10, 38280)
mod:AddSetIconOption("ChargeIcon", 38280, false, false, {1})
mod:AddSetIconOption("MCIcon", 38511, false, false, {2, 3})

mod.vb.shieldLeft = 4
mod.vb.nagaCount = 1
mod.vb.striderCount = 1
mod.vb.elementalCount = 1
mod.vb.mcIcon = 2
local elementals = {}

local function StriderSpawn(self)
	self.vb.striderCount = self.vb.striderCount + 1
	warnStrider:Schedule(57, tostring(self.vb.striderCount))
	timerStrider:Start(63, tostring(self.vb.striderCount))
	self:Schedule(63, StriderSpawn, self)
end

local function NagaSpawn(self)
	warnNaga:Schedule(42.5, tostring(self.vb.nagaCount))
	self.vb.nagaCount = self.vb.nagaCount + 1
	timerNaga:Start(47., tostring(self.vb.nagaCount))
	self:Schedule(47.5, NagaSpawn, self)
end

function mod:OnCombatStart(delay)
	table.wipe(elementals)
	self:SetStage(1)
	self.vb.shieldLeft = 4
	self.vb.nagaCount = 1
	self.vb.striderCount = 1
	self.vb.elementalCount = 1
	self.vb.mcIcon = 2
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38280 then
		timerCharge:Start(args.destName)
		if args:IsPlayer() then
			specWarnCharge:Show()
			specWarnCharge:Play("runout")
			yellCharge:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnCharge:Show(args.destName)
		end
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 1, 20)
		end
	elseif args:IsSpellID(38575, 360327) and args:IsPlayer() and self:AntiSpam() then
		specWarnToxic:Show()
		specWarnToxic:Play("runaway")
	elseif args.spellId == 38511 then
		if self.Options.MCIcon then
			self:SetIcon(args.destName, self.vb.mcIcon)
		end
		self.vb.mcIcon = self.vb.mcIcon + 1
		warnPersuasion:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 38280 then
		timerCharge:Stop(args.destName)
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif args.spellId == 38132 then
		if self.Options.LootIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 38511 then
		if self.Options.MCIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 38112 then--and not self:IsTrivial()
		self.vb.shieldLeft = self.vb.shieldLeft - 1
		warnShield:Show(self.vb.shieldLeft)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38253 and not elementals[args.sourceGUID] then
		specWarnElemental:Show()
		timerElemental:Start()
		elementals[args.sourceGUID] = true
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 38316 then
		warnEntangle:Show()
	elseif args.spellId == 38511 then
		self.vb.mcIcon = 2
		timerMC:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 22009 then
		self.vb.elementalCount = self.vb.elementalCount + 1
		timerElementalCD:Start(nil, tostring(self.vb.elementalCount))
		warnElemental:Schedule(45, tostring(self.vb.elementalCount))
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_VASHJ_YELL_PHASE2 or msg:find(L.DBM_VASHJ_YELL_PHASE2) then
		self:SendSync("Phase2")
	elseif msg == L.DBM_VASHJ_YELL_PHASE3 or msg:find(L.DBM_VASHJ_YELL_PHASE3) then
		self:SendSync("Phase3")
	end
end

--[[
function mod:CHAT_MSG_LOOT(msg)
	-- DBM:AddMsg(msg) --> Meridium receives loot: [Magnetic Core]
	local player, itemID = msg:match(L.LootMsg)
	if player and itemID and tonumber(itemID) == 31088 and self:IsInCombat() then
		self:SendSync("LootMsg", player)
	end
end
--]]

do
	local myName = UnitName("player")
	function mod:OnSync(msg)--playerName
		if not self:IsInCombat() then return end
		if msg == "Phase2" and self.vb.phase < 2 then
			self:SetStage(2)
			self.vb.nagaCount = 1
			self.vb.striderCount = 1
			self.vb.elementalCount = 1
			self.vb.shieldLeft = 4
			warnPhase2:Show()
			timerNaga:Start(nil, self.vb.nagaCount)
			warnNaga:Schedule(42.5, self.vb.elementalCount)
			self:Schedule(47.5, NagaSpawn, self)
			timerElementalCD:Start(nil, self.vb.elementalCount)
			warnElemental:Schedule(45, self.vb.elementalCount)
			timerStrider:Start(nil, self.vb.striderCount)
			warnStrider:Schedule(57, self.vb.striderCount)
			self:Schedule(63, StriderSpawn, self)
		elseif msg == "Phase3" and self.vb.phase < 3 then
			self:SetStage(3)
			warnPhase3:Show()
			timerNaga:Cancel()
			warnNaga:Cancel()
			timerElementalCD:Cancel()
			warnElemental:Cancel()
			timerStrider:Cancel()
			warnStrider:Cancel()
			--timerMC:Start()--Unknown initial
			self:Unschedule(NagaSpawn)
			self:Unschedule(StriderSpawn)
--		elseif msg == "LootMsg" and playerName then
			--[[playerName = DBM:GetUnitFullName(playerName) or playerName
			if self:AntiSpam(2, playerName) then
				if playerName == myName then
					specWarnCore:Show()
					specWarnCore:Play("useitem")
				else
					warnLoot:Show(playerName)
				end
			end--]]
		end
	end
end
