local mod	= DBM:NewMod("XT002", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220816155700")
mod:SetCreatureID(33293)
mod:SetEncounterID(1142)
mod:SetModelID(28611)
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62776",
	"SPELL_AURA_APPLIED 62776 63018 65121 63024 64234 63849",
	"SPELL_AURA_REMOVED 63018 65121 63024 64234 63849",
	"SPELL_DAMAGE 64208 64206",
	"SPELL_MISSED 64208 64206"
)

--TODO, figure out TIMEwalker CD for tantrums
--TODO, bomb CD timers?
--TODO, correct timers on heart phases?
local warnLightBomb					= mod:NewTargetNoFilterAnnounce(65121, 3)
local warnGravityBomb				= mod:NewTargetNoFilterAnnounce(64234, 3)

local specWarnLightBomb				= mod:NewSpecialWarningMoveAway(65121, nil, nil, nil, 1, 2)
local yellLightBomb					= mod:NewYell(65121)
local specWarnGravityBomb			= mod:NewSpecialWarningMoveAway(64234, nil, nil, nil, 1, 2)
local yellGravityBomb				= mod:NewYell(64234)
local specWarnConsumption			= mod:NewSpecialWarningGTFO(64206, nil, nil, nil, 1, 8)--Hard mode void zone dropped by Gravity Bomb

local enrageTimer					= mod:NewBerserkTimer(600)
local timerTympanicTantrum			= mod:NewBuffActiveTimer(8, 62776, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerTympanicTantrumCD		= mod:NewCDTimer(62, 62776, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerHeart					= mod:NewCastTimer(30, 63849, nil, nil, nil, 6, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerLightBomb				= mod:NewTargetTimer(9, 65121, nil, nil, nil, 3)
local timerGravityBomb				= mod:NewTargetTimer(9, 64234, nil, nil, nil, 3)
local timerAchieve
if WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1) then
	timerAchieve					= mod:NewAchievementTimer(205, 12329)
else
	timerAchieve					= mod:NewAchievementTimer(205, 2937)
end

mod:AddSetIconOption("SetIconOnLightBombTarget", 65121, true, true, {1})
mod:AddSetIconOption("SetIconOnGravityBombTarget", 64234, true, true, {2})

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	timerTympanicTantrumCD:Start(30-delay)

	--if self:IsClassic() and self:IsDifficulty("normal10") then
	--	timerTympanicTantrumCD:Start(35-delay)
	--else
	--	timerTympanicTantrumCD:Start(50-delay)
	--end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62776 then					-- Tympanic Tantrum (aoe damge + daze)
		timerTympanicTantrumCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62776 then	-- Tympanic Tantrum
		timerTympanicTantrum:Start()
	elseif args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if args:IsPlayer() then
			specWarnLightBomb:Show()
			specWarnLightBomb:Play("runout")
			yellLightBomb:Yell()
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 1)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
			specWarnGravityBomb:Play("runout")
			yellGravityBomb:Yell()
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 2)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif args.spellId == 63849 then
		timerHeart:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(63024, 64234) then	-- Gravity Bomb
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 63849 then
		timerHeart:Stop()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 64208 or spellId == 64206) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnConsumption:Show(spellName)
		specWarnConsumption:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
