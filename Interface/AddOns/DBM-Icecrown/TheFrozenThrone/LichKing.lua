local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220816155700")
mod:SetCreatureID(36597)
mod:SetEncounterID(1106)
mod:DisableEEKillDetection()--EE fires at 10%
mod:SetModelID(30721)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetMinSyncRevision(20220623000000)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68981 72259 72262 70372 70358 70498 70541 72762 73539 73650 72350",
	"SPELL_CAST_SUCCESS 70337 69409 69200 68980 73654",
	"SPELL_DISPEL 70337 70338",
	"SPELL_AURA_APPLIED 72143 72754 73650",
	"SPELL_SUMMON 69037",
	"UNIT_HEALTH target focus",
	"UNIT_AURA_UNFILTERED",
	"UNIT_DIED"
)

local isPAL = select(2, UnitClass("player")) == "PALADIN"
local isPRI = select(2, UnitClass("player")) == "PRIEST"

--TODO, possibly switch to faster less cpu wasting UNIT_TARGET scanning method, but only if classic has "boss" unit ids
local warnRemorselessWinter 		= mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake						= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit				= mod:NewTargetNoFilterAnnounce(69200, 3) --Transition Add
local warnShamblingSoon				= mod:NewSoonAnnounce(70372, 2) --Phase 1 Add
local warnShamblingHorror			= mod:NewSpellAnnounce(70372, 3) --Phase 1 Add
local warnDrudgeGhouls				= mod:NewSpellAnnounce(70358, 2) --Phase 1 Add
local warnShamblingEnrage			= mod:NewTargetNoFilterAnnounce(72143, 3, nil, "Tank|Healer|RemoveEnrage") --Phase 1 Add Ability
local warnNecroticPlague			= mod:NewTargetNoFilterAnnounce(70337, 3) --Phase 1+ Ability
local warnNecroticPlagueJump		= mod:NewAnnounce("WarnNecroticPlagueJump", 4, 70337, nil, nil, nil, 70337) --Phase 1+ Ability
local warnPhase2					= mod:NewPhaseAnnounce(2)
local valkyrWarning					= mod:NewAnnounce("ValkyrWarning", 3, 71844, nil, nil, nil, 71844)--Phase 2 Ability
local warnDefileSoon				= mod:NewSoonAnnounce(72762, 3)	--Phase 2+ Ability
local warnDefileCast				= mod:NewTargetNoFilterAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr				= mod:NewSpellAnnounce(71844, 3) --Phase 2 Add
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warnSummonVileSpirit			= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add
local warnHarvestSoul				= mod:NewTargetNoFilterAnnounce(68980, 3) --Phase 3 Ability
local warnTrapCast					= mod:NewTargetNoFilterAnnounce(73539, 4) --Phase 1 Heroic Ability
local warnRestoreSoul				= mod:NewCastAnnounce(73650, 2) --Phase 3 Heroic

local specWarnSoulreaper			= mod:NewSpecialWarningDefensive(69409, nil, nil, nil, 1, 2) --Phase 1+ Ability
local specWarnNecroticPlague		= mod:NewSpecialWarningMoveAway(70337, nil, nil, nil, 1, 2) --Phase 1+ Ability
local specWarnRagingSpirit			= mod:NewSpecialWarningYou(69200, nil, nil, nil, 1, 2) --Transition Add
local specWarnYouAreValkd			= mod:NewSpecialWarning("SpecWarnYouAreValkd", nil, nil, nil, 1, 2, nil, nil, 71844) --Phase 2+ Ability
local specWarnDefileCast			= mod:NewSpecialWarningMoveAway(72762, nil, nil, nil, 3, 2) --Phase 2+ Ability
local yellDefile					= mod:NewYell(72762)
local specWarnDefileNear			= mod:NewSpecialWarningClose(72762, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnHarvestSoul			= mod:NewSpecialWarningYou(68980, nil, nil, nil, 1, 2) --Phase 3+ Ability
local specWarnInfest				= mod:NewSpecialWarningSpell(70541, nil, nil, nil, 2) --Phase 1+ Ability
local specWarnSoulreaperOtr			= mod:NewSpecialWarningTaunt(69409, nil, nil, nil, 1, 2) --phase 2+
local specWarnTrap					= mod:NewSpecialWarningYou(73539, nil, nil, nil, 3, 2) --Heroic Ability
local yellTrap						= mod:NewYell(73539)
local specWarnTrapNear				= mod:NewSpecialWarningClose(73539, nil, nil, nil, 3, 2) --Heroic Ability
local specWarnHarvestSouls			= mod:NewSpecialWarningSpell(73654, nil, nil, nil, 1, 2) --Heroic Ability
local specWarnValkyrLow				= mod:NewSpecialWarning("SpecWarnValkyrLow", nil, nil, nil, 1, 2, nil, nil, 71844)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(68983, nil, nil, nil, 1, 8)

local timerCombatStart				= mod:NewCombatTimer(53.5)
local timerPhaseTransition			= mod:NewTimer(62.5, "PhaseTransition", 72262, nil, nil, 6)
local timerSoulreaper	 			= mod:NewTargetTimer(5.1, 69409, nil, "Tank|Healer")
local timerSoulreaperCD	 			= mod:NewNextTimer(30.5, 69409, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerHarvestSoul	 			= mod:NewTargetTimer(6, 68980)
local timerHarvestSoulCD			= mod:NewNextTimer(75, 68980, nil, nil, nil, 6)
local timerInfestCD					= mod:NewNextTimer(22.5, 70541, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerNecroticPlagueCleanse 	= mod:NewTimer(5, "TimerNecroticPlagueCleanse", 70337, "Healer", nil, 5, DBM_COMMON_L.HEALER_ICON, nil, nil, nil, nil, nil, nil, 70541)
local timerNecroticPlagueCD			= mod:NewNextTimer(30, 70337, nil, nil, nil, 3)
local timerDefileCD					= mod:NewNextTimer(32.5, 72762, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)
local timerEnrageCD					= mod:NewCDTimer(20, 72143, nil, "Tank|RemoveEnrage", nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)
local timerShamblingHorror 			= mod:NewNextTimer(60, 70372, nil, nil, nil, 1)
local timerDrudgeGhouls 			= mod:NewNextTimer(20, 70358, nil, nil, nil, 1)
local timerRagingSpiritCD			= mod:NewNextTimer(22, 69200, nil, nil, nil, 1)
local timerSummonValkyr 			= mod:NewCDTimer(45, 71844, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON, nil, 2, 3)
local timerVileSpirit 				= mod:NewNextTimer(30.5, 70498, nil, nil, nil, 1)
local timerTrapCD		 			= mod:NewNextTimer(15.5, 73539, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)
local timerRestoreSoul 				= mod:NewCastTimer(40, 73650, nil, nil, nil, 6)
local timerRoleplay					= mod:NewTimer(162, "TimerRoleplay", 72350, nil, nil, 6)

local berserkTimer					= mod:NewBerserkTimer(900)

mod:AddSetIconOption("DefileIcon", 72762, true, 0, {7})
mod:AddSetIconOption("NecroticPlagueIcon", 70337, true, 0, {4})
mod:AddSetIconOption("RagingSpiritIcon", 69200, false, 0, {6})
mod:AddSetIconOption("TrapIcon", 73539, true, 0, {7})
mod:AddSetIconOption("ValkyrIcon", 71844, true, 5, {1, 2, 3})
mod:AddSetIconOption("HarvestSoulIcon", 68980, false, 0, {5})
mod:AddBoolOption("AnnounceValkGrabs", false, nil, nil, nil, nil, 71844)

local warnedValkyrGUIDs = {}
local plagueHop = DBM:GetSpellInfo(70338)--Hop spellID only, not cast one.
local plagueExpires = {}
local lastPlague
local numberOfPlayers = 1
mod.vb.valkIcon = 1

local function NextPhase(self)
	self:SetStage(0)
	if self.vb.phase == 1 then
		berserkTimer:Start()
		warnShamblingSoon:Schedule(15)
		timerShamblingHorror:Start(20)
		timerDrudgeGhouls:Start(10)
		if numberOfPlayers > 1 then
			timerNecroticPlagueCD:Start(27)
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerTrapCD:Start()
		end
	elseif self.vb.phase == 2 then
		warnPhase2:Show()
		if numberOfPlayers > 1 then
			timerSummonValkyr:Start(20)
		end
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		timerInfestCD:Start(14)
		warnDefileSoon:Schedule(33)
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		timerVileSpirit:Start(20)
		timerSoulreaperCD:Start(40)
		timerDefileCD:Start(38)
		timerHarvestSoulCD:Start(14)
		warnDefileSoon:Schedule(33)
	end
end

local function RestoreWipeTime(self)
	self:SetWipeTime(5)--Restore it after frostmourn room.
end

function mod:OnCombatStart(delay)
	self.vb.valkIcon = 1
	numberOfPlayers = DBM:GetNumRealGroupMembers()
	if UnitExists("pet") then
		numberOfPlayers = numberOfPlayers + 1
	end
	self.vb.phase = 0
	NextPhase(self)
	table.wipe(warnedValkyrGUIDs)
	table.wipe(plagueExpires)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 68983",
			"SPELL_MISSED 68983"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:DefileTarget(targetname, uId)
	if not targetname then return end
	warnDefileCast:Show(targetname)
	if self.Options.DefileIcon then
		self:SetIcon(targetname, 7, 4)
	end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		specWarnDefileCast:Play("runout")
		yellDefile:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDefileNear:Show(targetname)
			end
		end
	end
end

function mod:TrapTarget(targetname, uId)
	if not targetname then return end
	warnTrapCast:Show(targetname)
	if self.Options.TrapIcon then
		self:SetIcon(targetname, 7, 4)
	end
	if targetname == UnitName("player") then
		specWarnTrap:Show()
		specWarnTrap:Play("watchstep")
		yellTrap:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnTrapNear:Show(targetname)
				specWarnTrapNear:Play("watchstep")
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 72259) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		timerRagingSpiritCD:Start(6)
		warnShamblingSoon:Cancel()
		timerShamblingHorror:Cancel()
		timerDrudgeGhouls:Cancel()
		timerSummonValkyr:Cancel()
		timerInfestCD:Cancel()
		timerNecroticPlagueCD:Cancel()
		timerTrapCD:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
	elseif args.spellId == 72262 then -- Quake (phase transition end)
		warnQuake:Show()
		timerRagingSpiritCD:Cancel()
		NextPhase(self)
	elseif args.spellId == 70372 then -- Shambling Horror
		warnShamblingSoon:Cancel()
		warnShamblingHorror:Show()
		warnShamblingSoon:Schedule(55)
		timerShamblingHorror:Start()
	elseif args.spellId == 70358 then -- Drudge Ghouls
		warnDrudgeGhouls:Show()
		timerDrudgeGhouls:Start()
	elseif args.spellId == 70498 then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif args.spellId == 70541 then -- Infest
		specWarnInfest:Show()
		timerInfestCD:Start()
	elseif args.spellId == 72762 then -- Defile
		self:BossTargetScanner(36597, "DefileTarget", 0.02, 15)
		warnDefileSoon:Cancel()
		warnDefileSoon:Schedule(27)
		timerDefileCD:Start()
	elseif args.spellId == 73539 then -- Shadow Trap (Heroic)
		self:BossTargetScanner(36597, "TrapTarget", 0.02, 15)
		timerTrapCD:Start()
	elseif args.spellId == 73650 then -- Restore Soul (Heroic)
		warnRestoreSoul:Show()
		timerRestoreSoul:Start()
	elseif args.spellId == 72350 then -- Fury of Frostmourne
		self:SetWipeTime(190)--Change min wipe time mid battle to force dbm to keep module loaded for this long out of combat roleplay
		self:Stop()
		self:ClearIcons()
		timerRoleplay:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 70337 then -- Necrotic Plague (SPELL_AURA_APPLIED is not fired for this spell)
		lastPlague = args.destName
		timerNecroticPlagueCD:Start()
		timerNecroticPlagueCleanse:Start()
		if args:IsPlayer() then
			specWarnNecroticPlague:Show()
			specWarnNecroticPlague:Play("runout")
		else
			warnNecroticPlague:Show(lastPlague)
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(lastPlague, 4, 5)
		end
	elseif args.spellId == 69409 then -- Soul reaper (MT debuff)
		timerSoulreaper:Start(args.destName)
		timerSoulreaperCD:Start()
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
			specWarnSoulreaper:Play("defensive")
		else
			specWarnSoulreaperOtr:Show(args.destName)
			specWarnSoulreaperOtr:Play("tauntboss")
		end
	elseif args.spellId == 69200 then -- Raging Spirit
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
			specWarnRagingSpirit:Play("targetyou")
		else
			warnRagingSpirit:Show(args.destName)
		end
		if self.vb.phase == 1 then
			timerRagingSpiritCD:Start()
		else
			timerRagingSpiritCD:Start(17)
		end
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 6, 5)
		end
	elseif args.spellId == 68980 then -- Harvest Soul
		timerHarvestSoul:Start(args.destName)
		timerHarvestSoulCD:Start()
		if args:IsPlayer() then
			specWarnHarvestSoul:Show()
			specWarnHarvestSoul:Play("targetyou")
		else
			warnHarvestSoul:Show(args.destName)
		end
		if self.Options.HarvestSoulIcon then
			self:SetIcon(args.destName, 5, 5)
		end
	elseif args.spellId == 73654 then -- Harvest Souls (Heroic)
		specWarnHarvestSouls:Show()
		specWarnHarvestSouls:Play("phasechange")
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
		self:SetWipeTime(50)--We set a 45 sec min wipe time to keep mod from ending combat if you die while rest of raid is in frostmourn
		self:Schedule(50, RestoreWipeTime, self)
	end
end

function mod:SPELL_DISPEL(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 70337 or args.extraSpellId == 70338) then
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72143 then -- Shambling Horror enrage effect.
		warnShamblingEnrage:Show(args.destName)
		timerEnrageCD:Start(args.sourceGUID)
	elseif args.spellId == 72754 and args:IsPlayer() and self:AntiSpam(2, 1) then		-- Defile Damage
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	elseif args.spellId == 73650 and self:AntiSpam(3, 2) then		-- Restore Soul (Heroic)
		timerHarvestSoulCD:Start(58)
		timerVileSpirit:Start(10)--May be wrong too but we'll see, didn't have enough log for this one.
	end
end

do
	local valkyrTargets = {}
	local grabIcon = 1
	local lastValk = 0
	local UnitIsUnit, UnitInVehicle, IsInRaid = UnitIsUnit, UnitInVehicle, IsInRaid

	local function scanValkyrTargets(self)
		if (time() - lastValk) < 10 then    -- scan for like 10secs
			for uId in DBM:GetGroupMembers() do        -- for every raid member check ..
				if UnitInVehicle(uId) and not valkyrTargets[uId] then      -- if person #i is in a vehicle and not already announced
					valkyrWarning:Show(UnitName(uId))
					valkyrTargets[uId] = true
					if UnitIsUnit(uId, "player") then
						specWarnYouAreValkd:Show()
						specWarnYouAreValkd:Play("targetyou")
					end
					if IsInGroup() and self.Options.AnnounceValkGrabs and DBM:GetRaidRank() > 1 then
						local channel = (IsInRaid() and "RAID") or "PARTY"
						if self.Options.ValkyrIcon then
							SendChatMessage(L.ValkGrabbedIcon:format(grabIcon, UnitName(uId)), channel)
							grabIcon = grabIcon + 1--Makes assumption discovery order of vehicle grabs will match combat log order, since there is a delay
						else
							SendChatMessage(L.ValkGrabbed:format(UnitName(uId)), channel)
						end
					end
				end
			end
			self:Schedule(0.5, scanValkyrTargets, self)  -- check for more targets in a few
		else
			table.wipe(valkyrTargets)       -- no more valkyrs this round, so lets clear the table
			grabIcon = 1
			self.vb.valkIcon = 1
		end
	end

	function mod:SPELL_SUMMON(args)
		if args.spellId == 69037 then -- Summon Val'kyr
			if self.Options.ValkyrIcon then
				self:ScanForMobs(args.destGUID, 2, self.vb.valkIcon, 1, nil, 12, "ValkyrIcon")
			end
			self.vb.valkIcon = self.vb.valkIcon + 1
			if time() - lastValk > 15 then -- show the warning and timer just once for all three summon events
				warnSummonValkyr:Show()
				if numberOfPlayers > 1 then--It's still cast in solo raid, and they do come, we just don't care since they don't grab main threat target, so supress timer anyways.
					timerSummonValkyr:Start()
				end
				lastValk = time()
				scanValkyrTargets(self)
				--if self.Options.ValkyrIcon then
				--	local cid = self:GetCIDFromGUID(args.destGUID)
				--	if self:IsDifficulty("normal25", "heroic25") then
				--		self:ScanForMobs(args.destGUID, 1, 2, 3, nil, 20, "ValkyrIcon")--mod, scanId, iconSetMethod, mobIcon, maxIcon,
				--	else
				--		self:ScanForMobs(args.destGUID, 1, 2, 1, nil, 20, "ValkyrIcon")
				--	end
				--end
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 68983 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then		-- Remorseless Winter
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:IsDifficulty("heroic10", "heroic25") and self:GetUnitCreatureId(uId) == 36609 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.55 and not warnedValkyrGUIDs[UnitGUID(uId)] then
		warnedValkyrGUIDs[UnitGUID(uId)] = true
		specWarnValkyrLow:Show()
		specWarnValkyrLow:Play("stopattack")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LKPull or msg:find(L.LKPull) then
		self:SendSync("CombatStart")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37698 then--Shambling Horror
		timerEnrageCD:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	local name = DBM:GetUnitFullName(uId)
	if (not name) or (name == lastPlague) then return end
	local _, _, _, _, _, expires, _, _, _, spellId = DBM:UnitDebuff(uId, plagueHop)
	if not spellId or not expires then return end
	if spellId == 70338 and expires > 0 and not plagueExpires[expires] then
		plagueExpires[expires] = true
		warnNecroticPlagueJump:Show(name)
		timerNecroticPlagueCleanse:Start()
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(uId, 4, 5)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "CombatStart" then
		timerCombatStart:Start()
	end
end
