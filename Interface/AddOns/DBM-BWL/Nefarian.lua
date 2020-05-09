local mod	= DBM:NewMod("Nefarian-Classic", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200423162250")
mod:SetCreatureID(11583)
mod:SetEncounterID(617)
mod:SetModelID(11380)
mod:RegisterCombat("combat_yell", L.YellP1)--ENCOUNTER_START appears to fire when he lands, so start of phase 2, ignoring all of phase 1
mod:SetWipeTime(50)--guesswork
mod:SetHotfixNoticeRev(20200310000000)--2020, Mar, 10th
mod:SetMinSyncRevision(20200310000000)--2020, Mar, 10th

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 22539 22686",
	"SPELL_AURA_APPLIED 22687 22667",
	"UNIT_DIED",
	"UNIT_HEALTH mouseover target"
)

local WarnAddsLeft			= mod:NewAnnounce("WarnAddsLeft", 2, "136116")
local warnClassCall			= mod:NewAnnounce("WarnClassCall", 3, "136116")
local warnPhase				= mod:NewPhaseChangeAnnounce()
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3)
local warnShadowFlame		= mod:NewCastAnnounce(22539, 2)
local warnFear				= mod:NewCastAnnounce(22686, 2)

local specwarnShadowCommand	= mod:NewSpecialWarningTarget(22667, nil, nil, 2, 1, 2)
local specwarnVeilShadow	= mod:NewSpecialWarningDispel(22687, "RemoveCurse", nil, nil, 1, 2)

local timerPhase			= mod:NewPhaseTimer(15)
local timerClassCall		= mod:NewTimer(30, "TimerClassCall", "136116", nil, nil, 5)
local timerFearNext			= mod:NewCDTimer(26.7, 22686, nil, nil, 3, 2)--26-42.5

mod.vb.phase = 1
mod.vb.addLeft = 42
local addsGuidCheck = {}

function mod:OnCombatStart(delay, yellTriggered)
	table.wipe(addsGuidCheck)
	self.vb.addLeft = 42
	--if yellTriggered then--Triggered by Phase 1 yell from talking to Nefarian (uncomment if ENCOUNTER_START isn't actually fixed with weekly reset)
		self.vb.phase = 1
	--else--Blizz can't seem to figure out ENCOUNTER_START, so any pull not triggered by yell will be treated as if it's already phase 2
	--	self.vb.phase = 2
	--end
end

do
	local ShadowFlame, BellowingRoar = DBM:GetSpellInfo(22539), DBM:GetSpellInfo(22686)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 22539 then
		if args.spellName == ShadowFlame then
			if self:AntiSpam(5, "Shadowflame") then
				self:SendSync("Shadowflame")
			end
			if self:AntiSpam(8, 1) then
				warnShadowFlame:Show()
			end
		--elseif args.spellId == 22686 then
		elseif args.spellName == BellowingRoar then
			if self:AntiSpam(5, "Fear") then
				self:SendSync("Fear")
			end
			if self:AntiSpam(8, 2) then
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
			if self:AntiSpam(8, args.destName .. "1") then
				if self:CheckDispelFilter() then
					specwarnVeilShadow:Show(args.destName)
					specwarnVeilShadow:Play("dispelnow")
				end
			end
		--elseif args.spellId == 22667 then
		elseif args.spellName == ShadowCommand then
			self:SendSync("MindControl", args.destName)
			if self:AntiSpam(8, args.destName .. "2") then
				specwarnShadowCommand:Show(args.destName)
				specwarnShadowCommand:Play("findmc")
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local guid = args.destGUID
	local cid = self:GetCIDFromGUID(guid)
	if cid == 14264 or cid == 14263 or cid == 14261 or cid == 14265 or cid == 14262 or cid == 14302 then--Red, Bronze, Blue, Black, Green, Chromatic
		self:SendSync("AddDied", guid)--Send sync it died do to combat log range and size of room
		--We're in range of event, no reason to wait for sync, especially in a raid that might not have many DBM users
		if not addsGuidCheck[guid] then
			addsGuidCheck[guid] = true
			self.vb.addLeft = self.vb.addLeft - 1
			if self.vb.addLeft >= 1 and (self.vb.addLeft % 3 == 0) then
				WarnAddsLeft:Show(self.vb.addLeft)
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
	if (msg == L.YellDruid or msg:find(L.YellDruid)) and self:AntiSpam(5, "ClassCall") then
		self:SendSync("ClassCall", "DRUID")
	elseif (msg == L.YellHunter or msg:find(L.YellHunter)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "HUNTER")
	elseif (msg == L.YellWarlock or msg:find(L.YellWarlock)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "WARLOCK")
	elseif (msg == L.YellMage or msg:find(L.YellMage)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "MAGE")
	elseif (msg == L.YellPaladin or msg:find(L.YellPaladin)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "PALADIN")
	elseif (msg == L.YellPriest or msg:find(L.YellPriest)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "PRIEST")
	elseif (msg == L.YellRogue or msg:find(L.YellRogue)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "ROGUE")
	elseif (msg == L.YellShaman or msg:find(L.YellShaman)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "SHAMAN")
	elseif (msg == L.YellWarrior or msg:find(L.YellWarrior)) and self:AntiSpam(5, "ClassCall")  then
		self:SendSync("ClassCall", "WARRIOR")
	elseif msg == L.YellP2 or msg:find(L.YellP2) then
		self:SendSync("Phase", 2)
	elseif msg == L.YellP3 or msg:find(L.YellP3) then
		self:SendSync("Phase", 3)
	end
end

function mod:OnSync(msg, arg)
	if self:AntiSpam(5, msg) then
		--Do nothing, this is just an antispam threshold for syncing
	end
	if msg == "Phase" and arg then
		local phase = tonumber(arg) or 0
		if phase == 2 then
			self.vb.phase = 2
			timerPhase:Start(15)--15 til encounter start fires, not til actual land?
			--timerFearNext:Start(46.6)
		elseif phase == 3 then
			self.vb.phase = 3
		end
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(arg))
	end
	if not self:IsInCombat() then return end
	if msg == "ClassCall" and arg then
		warnClassCall:Show(LOCALIZED_CLASS_NAMES_MALE[arg])
		timerClassCall:Start(30, LOCALIZED_CLASS_NAMES_MALE[arg])
	elseif msg == "Shadowflame" and self:AntiSpam(8, 1) then
		warnShadowFlame:Show()
	elseif msg == "Fear" and self:AntiSpam(8, 2) then
		warnFear:Show()
		timerFearNext:Start()
	elseif msg == "VielShadow" and arg and self:AntiSpam(8, arg .. "1") then
		if self:CheckDispelFilter() then
			specwarnVeilShadow:Show(arg)
			specwarnVeilShadow:Play("dispelnow")
		end
	elseif msg == "MindControl" and arg and self:AntiSpam(8, arg .. "2") then
		specwarnShadowCommand:Show(arg)
		specwarnShadowCommand:Play("findmc")
	elseif msg == "AddDied" and arg and not addsGuidCheck[arg] then
		--A unit died we didn't detect ourselves, so we correct our adds counter from sync
		addsGuidCheck[arg] = true
		self.vb.addLeft = self.vb.addLeft - 1
		if self.vb.addLeft >= 1 and (self.vb.addLeft % 3 == 0) then
			WarnAddsLeft:Show(self.vb.addLeft)
		end
	end
end
