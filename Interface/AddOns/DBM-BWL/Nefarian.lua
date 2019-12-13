local mod	= DBM:NewMod("Nefarian-Classic", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20191206204159")
mod:SetCreatureID(11583)
mod:SetEncounterID(617)
mod:SetModelID(11380)
mod:RegisterCombat("combat")
mod:SetWipeTime(25)--guesswork

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 22539 22686",
	"SPELL_AURA_APPLIED 22687 22667",
	"UNIT_HEALTH mouseover target",
	"CHAT_MSG_MONSTER_YELL"
)

local warnClassCall		= mod:NewAnnounce("WarnClassCall", 3, "136116")
local warnPhase			= mod:NewPhaseChangeAnnounce()
local warnPhase3Soon	= mod:NewPrePhaseAnnounce(3)
local warnShadowFlame	= mod:NewCastAnnounce(22539, 2)
local warnFear			= mod:NewCastAnnounce(22686, 2)

local specwarnMC		= mod:NewSpecialWarningTarget(22667, nil, nil, 2, 1, 2)
local specwarnVeilShadow= mod:NewSpecialWarningDispel(22687, "RemoveCurse", nil, nil, 1, 2)

local timerClassCall	= mod:NewTimer(30, "TimerClassCall", "136116", nil, nil, 5)
local timerFearNext		= mod:NewCDTimer(30, 22686, nil, nil, nil, 2)

mod.vb.phase = 1

function mod:OnCombatStart(delay)
	self.vb.phase = 1
end

do
	local ShadowFlame, BellowingRoar = DBM:GetSpellInfo(22539), DBM:GetSpellInfo(22686)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 22539 then
		if args.spellName == ShadowFlame then
			self:SendSync("Shadowflame")
			if self:AntiSpam(5, 1) then
				warnShadowFlame:Show()
			end
		--elseif args.spellId == 22686 then
		elseif args.spellName == BellowingRoar then
			self:SendSync("Fear")
			if self:AntiSpam(5, 2) then
				warnFear:Show()
				timerFearNext:Start()
			end
		end
	end
end

do
	local VielShadow, ShadowCommand = DBM:GetSpellInfo(22687), DBM:GetSpellInfo(22667)
	function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 22687 then
		if args.spellName == VielShadow then
			self:SendSync("VielShadow", args.destName)
			if self:AntiSpam(5, args.destName .. "1") then
				if self:CheckDispelFilter() then
					specwarnVeilShadow:Show(args.destName)
					specwarnVeilShadow:Play("dispelnow")
				end
			end
		--elseif args.spellId == 22667 then
		elseif args.spellName == ShadowCommand then
			self:SendSync("MindControl", args.destName)
			if self:AntiSpam(5, args.destName .. "2") then
				specwarnMC:Show(args.destName)
				specwarnMC:Play("findmc")
			end
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 11583 and self.vb.phase < 2.5 then
		warnPhase3Soon:Show()
		self.vb.phase = 2.5
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDK or msg:find(L.YellDK) then
		self:SendSync("ClassCall", "DK")
	elseif msg == L.YellDruid or msg:find(L.YellDruid) then
		self:SendSync("ClassCall", "Druid")
	elseif msg == L.YellHunter or msg:find(L.YellHunter) then
		self:SendSync("ClassCall", "Hunter")
	elseif msg == L.YellMage or msg:find(L.YellMage) then
		self:SendSync("ClassCall", "Mage")
	elseif msg == L.YellPaladin or msg:find(L.YellPaladin) then
		self:SendSync("ClassCall", "Paladin")
	elseif msg == L.YellPriest or msg:find(L.YellPriest) then
		self:SendSync("ClassCall", "Priest")
	elseif msg == L.YellRogue or msg:find(L.YellRogue) then
		self:SendSync("ClassCall", "Rogue")
	elseif msg == L.YellShaman or msg:find(L.YellShaman) then
		self:SendSync("ClassCall", "Shaman")
	elseif msg == L.YellWarlock or msg:find(L.YellWarlock) then
		self:SendSync("ClassCall", "Warlock")
	elseif msg == L.YellWarrior or msg:find(L.YellWarrior) then
		self:SendSync("ClassCall", "Warrior")
	elseif msg == L.YellMonk or msg:find(L.YellMonk) then
		self:SendSync("ClassCall", "Monk")
	elseif msg == L.YellP2 or msg:find(L.YellP2) then
		self:SendSync("Phase", 2)
	elseif msg == L.YellP3 or msg:find(L.YellP3) then
		self:SendSync("Phase", 3)
	end
end

function mod:OnSync(msg, arg)
	if msg == "ClassCall" and arg then
		warnClassCall:Show(arg)
		timerClassCall:Start(arg)
	elseif msg == "Phase" and arg then
		local phase = tonumber(arg) or 0
		if phase == 2 then
			self.vb.phase = 2
		elseif phase == 3 then
			self.vb.phase = 3
		end
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(arg))
	elseif msg == "Shadowflame" and self:AntiSpam(5, 1) then
		warnShadowFlame:Show()
	elseif msg == "Fear" and self:AntiSpam(5, 2) then
		warnFear:Show()
		timerFearNext:Start()
	elseif msg == "VielShadow" and arg and self:AntiSpam(5, arg .. "1") then
		if self:CheckDispelFilter() then
			specwarnVeilShadow:Show(arg)
			specwarnVeilShadow:Play("dispelnow")
		end
	elseif msg == "MindControl" and arg and self:AntiSpam(5, arg .. "2") then
		specwarnMC:Show(arg)
		specwarnMC:Play("findmc")
	end
end
