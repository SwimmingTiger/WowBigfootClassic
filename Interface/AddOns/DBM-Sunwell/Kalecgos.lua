local mod	= DBM:NewMod("Kal", "DBM-Sunwell")
local Kal 	= DBM:GetModByName("Kal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220923022829")
mod:SetCreatureID(24850)
mod:SetEncounterID(724, 2488)
mod:SetModelID(26628)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 44799",
	"SPELL_CAST_SUCCESS 45018",
	"SPELL_AURA_APPLIED 44978 45001 45002 45004 45006 45010 45029 46021 45018",
	"SPELL_AURA_APPLIED_DOSE 45018",
	"UNIT_HEALTH target",
	"UNIT_DIED"
)

local warnPortal		= mod:NewAnnounce("WarnPortal", 4, 46021)
local warnBuffet		= mod:NewSpellAnnounce(45018, 3, nil, false, 2)
local warnBreath		= mod:NewSpellAnnounce(44799, 3, nil, false)
local warnCorrupt		= mod:NewTargetNoFilterAnnounce(45029, 3)

local specWarnBuffet	= mod:NewSpecialWarningStack(45018, nil, 10, nil, nil, 1, 6)
local specWarnWildMagic	= mod:NewSpecialWarning("SpecWarnWildMagic")

local timerNextPortal	= mod:NewNextCountTimer(25, 46021, nil, nil, nil, 5)
local timerBreathCD		= mod:NewCDTimer(15, 44799, nil, false, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tanks?
local timerBuffetCD		= mod:NewCDTimer(8, 45018, nil, nil, nil, 2)
local timerPorted		= mod:NewBuffActiveTimer(60, 46021, nil, nil, nil, 6)
local timerExhausted	= mod:NewBuffActiveTimer(60, 44867, nil, nil, nil, 6)

mod:AddRangeFrameOption(10, 46021)
mod:AddBoolOption("ShowFrame", true)
mod:AddBoolOption("FrameLocked", false)
mod:AddBoolOption("FrameClassColor", true, nil, function()
	Kal:UpdateColors()
end)
mod:AddBoolOption("FrameUpwards", false, nil, function()
	Kal:ChangeFrameOrientation()
end)

Kal.Options.FramePoint = "CENTER"
Kal.Options.FrameX = 150
Kal.Options.FrameY = -50

mod.vb.portCount = 1

function mod:OnCombatStart(delay)
	self.vb.portCount = 1
	if self.Options.ShowFrame then
		Kal:CreateFrame()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	Kal:DestroyFrame()
	DBM.RangeCheck:Hide()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 44978 and args:IsPlayer() and self:IsHealer() then
		specWarnWildMagic:Show(L.Heal)
	elseif args.spellId == 45001 and args:IsPlayer() then
		specWarnWildMagic:Show(L.Haste)
	elseif args.spellId == 45002 and args:IsPlayer() and self:IsMelee() then
		specWarnWildMagic:Show(L.Hit)
	elseif args.spellId == 45004 and args:IsPlayer() and not self:IsHealer() then
		specWarnWildMagic:Show(L.Crit)
	elseif args.spellId == 45006 and args:IsPlayer() and not self:IsHealer() then
		specWarnWildMagic:Show(L.Aggro)
	elseif args.spellId == 45010 and args:IsPlayer() then
		specWarnWildMagic:Show(L.Mana)
	elseif args.spellId == 45029 and self:IsInCombat() then
		warnCorrupt:Show(args.destName)
	elseif args.spellId == 46021 then
		if args:IsPlayer() then
			timerPorted:Start()
			timerExhausted:Schedule(60)
		end
		if self:AntiSpam(20, 2) then
			local grp, class
			if IsInGroup() then
				for i = 1, DBM:GetNumGroupMembers() do
					local name, _, subgroup, _, _, fileName = GetRaidRosterInfo(i)
					if name == args.destName then
						grp = subgroup
						class = fileName
						break
					end
				end
			else
				-- solo raid
				grp = 0
				class = select(2, UnitClass("player"))
			end
			Kal:AddEntry(("%s (%d)"):format(args.destName, grp or 0), class)
			warnPortal:Show(self.vb.portCount, args.destName, grp or 0)
			self.vb.portCount = self.vb.portCount + 1
			timerNextPortal:Start(nil, self.vb.portCount)
		end
	elseif args.spellId == 45018 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 10 and amount % 2 == 0 then
			specWarnBuffet:Show(amount)
			specWarnBuffet:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args.spellId == 44799 then
		warnBreath:Show()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45018 then
		warnBuffet:Show()
		timerBuffetCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 24892 then
		DBM:EndCombat(self)
	end
	if bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
		local grp
		if IsInGroup() then
			for i = 1, DBM:GetNumGroupMembers() do
				local name, _, subgroup = GetRaidRosterInfo(i)
				if name == args.destName then
					grp = subgroup
					break
				end
			end
		else
			grp = 0
		end
		Kal:RemoveEntry(("%s (%d)"):format(args.destName, grp or 0))
	end
end

function mod:UNIT_HEALTH(uId)
	local id = self:GetUnitCreatureId(uId)
	if id == 24850 or id == 24892 then
		self:SendSync("Health", id, math.floor(100 * UnitHealth(uId) / UnitHealthMax(uId)))
	end
end

function mod:OnSync(msg, id, health, sender)
	if msg ~= "Health" then return end
	if self.Options.ShowFrame then
		Kal:UpdateHealth(tonumber(id), tonumber(health))
	end
end
