local mod	= DBM:NewMod("Ragnaros-Classic", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200103232253")
mod:SetCreatureID(11502)
mod:SetEncounterID(672)
mod:SetModelID(11121)
mod:SetHotfixNoticeRev(20200103000000)--2020, 01, 03
mod:SetMinSyncRevision(20200103000000)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 19774",
	"SPELL_CAST_SUCCESS 20566 19773",
	"CHAT_MSG_MONSTER_YELL"
)
mod:RegisterEventsInCombat(
--	"SPELL_CAST_SUCCESS 20566 19773",
	"UNIT_DIED"
)

--[[
ability.id = 20566 and type = "cast" or target.id = 12143 and type = "death"
--]]
local warnWrathRag		= mod:NewSpellAnnounce(20566, 3)
local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")

local timerWrathRag		= mod:NewCDTimer(25, 20566, nil, nil, nil, 2, nil, DBM_CORE_IMPORTANT_ICON, nil, mod:IsMelee() and 1, 4)--25-31.6
local timerSubmerge		= mod:NewTimer(180, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6, nil, nil, 1, 5)
local timerEmerge		= mod:NewTimer(90, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6, nil, nil, 1, 5)
local timerCombatStart	= mod:NewCombatTimer(73)

mod.vb.addLeft = 0
local addsGuidCheck = {}

mod:AddRangeFrameOption("10", nil, "-Melee")

function mod:OnCombatStart(delay)
	table.wipe(addsGuidCheck)
	self.vb.addLeft = 0
	timerWrathRag:Start(26.7-delay)
	timerSubmerge:Start(180-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function emerged(self)
	timerEmerge:Stop()
	warnEmerge:Show()
	timerWrathRag:Start(26.7)--need to find out what it is first.
	timerSubmerge:Start(180)
end

do
	local summonRag = DBM:GetSpellInfo(19774)
	function mod:SPELL_CAST_START(args)
		--if args.spellId == 20566 then
		if args.spellName == summonRag and self:AntiSpam(5, 4) then
			self:SendSync("SummonRag")
		end
	end
end

do
	local Wrath, domoDeath = DBM:GetSpellInfo(20566), DBM:GetSpellInfo(19773)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 20566 then
		if args.spellName == Wrath then
			self:SendSync("WrathRag")
			if self:AntiSpam(5, 1) then
				warnWrathRag:Show()
				timerWrathRag:Start()
			end
		elseif args.spellName == domoDeath then
			self:SendSync("DomoDeath")
		end
	end
end

function mod:UNIT_DIED(args)
	local guid = args.destGUID
	local cid = self:GetCIDFromGUID(guid)
	if cid == 12143 then--Son of Flame
		self:SendSync("AddDied", guid)--Send sync it died do to combat log range and size of room
		--We're in range of event, no reason to wait for sync, especially in a raid that might not have many DBM users
		if not addsGuidCheck[guid] then
			addsGuidCheck[guid] = true
			self.vb.addLeft = self.vb.addLeft - 1
			if self.vb.addLeft == 0 then--After all 8 die he emerges immediately
				self:Unschedule(emerged)
				emerged(self)
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Submerge then
		self:SendSync("Submerge")
	elseif msg == L.Pull and self:AntiSpam(5, 4) then
		self:SendSync("SummonRag")
	end
end

function mod:OnSync(msg, guid)
	if msg == "SummonRag" and self:AntiSpam(5, 2) then
		timerCombatStart:Start()
	elseif msg == "Submerge" and self:IsInCombat() then
		self:Unschedule(emerged)
		timerWrathRag:Stop()
		warnSubmerge:Show()
		timerEmerge:Start(90)
		self:Schedule(90, emerged, self)
		self.vb.addLeft = self.vb.addLeft + 8
	elseif msg == "AddDied" and self:IsInCombat() and guid and not addsGuidCheck[guid] then
		--A unit died we didn't detect ourselves, so we correct our adds counter from sync
		addsGuidCheck[guid] = true
		self.vb.addLeft = self.vb.addLeft - 1
		if self.vb.addLeft == 0 then--After all 8 die he emerges immediately
			self:Unschedule(emerged)
			emerged(self)
		end
	elseif msg == "WrathRag" and self:IsInCombat() and self:AntiSpam(5, 1) then
		warnWrathRag:Show()
		timerWrathRag:Start()
	elseif msg == "DomoDeath" and self:AntiSpam(5, 3) then
		--The timer between yell/summon start and ragnaros being attackable is variable, but time between domo death and him being attackable is not.
		--As such, we start lowest timer of that variation on the RP start, but adjust timer if it's less than 10 seconds at time domo dies
		local remaining = timerCombatStart:GetRemaining()
		if remaining < 10 then
			local adjust = 10 - remaining
			timerCombatStart:AddTime(adjust)
		end
	end
end
