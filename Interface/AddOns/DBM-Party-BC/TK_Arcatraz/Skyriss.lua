local mod = DBM:NewMod(551, "DBM-Party-BC", 15, 254)
local L = mod:GetLocalizedStrings()


mod:SetRevision("20210422205657")

mod:SetCreatureID(20912)
mod:SetEncounterID(1914)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED 39019 37162 39017",
	"SPELL_AURA_REMOVED 39019 37162 39017",
	"UNIT_HEALTH"
)

local warnSplitSoon     = mod:NewSoonAnnounce("ej5335", 2)
local warnSplit         = mod:NewSpellAnnounce("ej5335", 3)
local warnMindControl   = mod:NewTargetNoFilterAnnounce(39019, 4)
local warnMindRend      = mod:NewTargetAnnounce(39017, 2)

local timerMindControl  = mod:NewTargetTimer(6, 39019, nil, nil, nil, 3)
local timerMindRend     = mod:NewTargetTimer(6, 39017, nil, false, 2, 3)

mod.vb.warnedSplit1		= false
mod.vb.warnedSplit2		= false

function mod:OnCombatStart()
	self.vb.warnedSplit1 = false
	self.vb.warnedSplit2 = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39019, 37162) then
		warnMindControl:Show(args.destName)
		timerMindControl:Start(args.destName)
	elseif args.spellId == 39017 then
		warnMindRend:Show(args.destName)
		timerMindRend:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39019, 37162) then
		timerMindControl:Stop(args.destName)
	elseif args.spellId == 39017 then
		timerMindRend:Stop(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Split then
        warnSplit:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedSplit1 and self:GetUnitCreatureId(uId) == 20912 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
		self.vb.warnedSplit1 = true
		warnSplitSoon:Show()
	elseif not self.vb.warnedSplit2 and self:IsDifficulty("heroic5", "timewalker") and self:GetUnitCreatureId(uId) == 20912 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.37 then
		self.vb.warnedSplit2 = true
		warnSplitSoon:Show()
	end
end
