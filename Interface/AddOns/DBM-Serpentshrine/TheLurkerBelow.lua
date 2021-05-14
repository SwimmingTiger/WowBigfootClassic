local mod	= DBM:NewMod("LurkerBelow", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210422205657")
mod:SetCreatureID(21217)
mod:SetEncounterID(624, 2459)
mod:SetModelID(20216)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_DAMAGE 37363",
--	"SPELL_MISSED 37363",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--UNIT_SPELLCAST_SUCCEEDED is invalid in classic TBC, it needs to be reverted there
--https://github.com/DeadlyBossMods/DBM-BCVanilla/commit/2a6f82618007a84e25fee5dd513ceb8cabe57a57
local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnWhirl			= mod:NewSpellAnnounce(37363, 2)

local specWarnSpout		= mod:NewSpecialWarningSpell(37433, nil, nil, nil, 2, 2)

local timerSubmerge		= mod:NewTimer(105, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerEmerge		= mod:NewTimer(60, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerSpoutCD		= mod:NewCDTimer(50, 37433, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerSpout		= mod:NewBuffActiveTimer(22, 37433, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerWhirlCD		= mod:NewCDTimer(18, 37363, nil, nil, nil, 2)

mod.vb.submerged = false
mod.vb.guardianKill = 0
mod.vb.ambusherKill = 0

local function emerged(self)
	self.vb.submerged = false
	timerEmerge:Cancel()
	warnEmerge:Show()
	timerSubmerge:Start()
	--self:Schedule(90, CheckDive, self)--Legacy mode, used in classic TBC in absence of UNIT_SPELLCAST_SUCCEEDED
end

--[[
--Legacy mode, used in classic TBC in absence of UNIT_SPELLCAST_SUCCEEDED
local function CheckDive(self)
	self:Schedule(0.5, CheckDive, self)
	for uId in DBM:GetGroupMembers() do
		if self:GetUnitCreatureId(uId.."target") == 21217 then
			return
		end
	end
	warnSubmerge:Show()
	timerSubmerge:Cancel()
	timerSpoutCD:Cancel()
	timerWhirlCD:Cancel()
	timerEmerge:Start()
	warnEmerge:Schedule(60)
	timerSubmerge:Schedule(60)
	timerSpoutCD:Schedule(60, 3)
	self:Unschedule(CheckDive)
	self:Schedule(60, emerged, self)
end
--]]

function mod:OnCombatStart(delay)
	self.vb.submerged = false
	timerWhirlCD:Start(15-delay)
	timerSpoutCD:Start(37-delay)
	timerSubmerge:Start(90-delay)
--	self:Schedule(90, CheckDive, self)--Legacy mode, used in classic TBC in absence of UNIT_SPELLCAST_SUCCEEDED
end

function mod:RAID_BOSS_EMOTE(msg, source)
	if (source or "") == L.name then
		specWarnSpout:Show()
		specWarnSpout:Play("watchwave")
		timerSpout:Start()
		timerSpoutCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21865 then
		self.vb.ambusherKill = self.vb.ambusherKill + 1
		if self.vb.ambusherKill == 6 and self.vb.guardianKill == 3 and self.vb.submerged then
			self:Unschedule(emerged)
			self:Schedule(2, emerged, self)
		end
	elseif cId == 21873 then
		self.vb.guardianKill = self.vb.guardianKill + 1
		if self.vb.ambusherKill == 6 and self.vb.guardianKill == 3 and self.vb.submerged then
			self:Unschedule(emerged)
			self:Schedule(2, emerged, self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 28819 and self:AntiSpam(2, 1) then--Submerge Visual
		self:SendSync("Submerge")
	elseif spellId == 37660 and self:AntiSpam(2, 2) then
		self:SendSync("Whirl")
	end
end

--[[
--Legacy mode, used in classic TBC in absence of UNIT_SPELLCAST_SUCCEEDED
function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 37363 and self:AntiSpam(10) then
		warnWhirl:Show()
		timerWhirlCD:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Submerge" then
		self.vb.submerged = true
		self.vb.guardianKill = 0
		self.vb.ambusherKill = 0
		timerSubmerge:Cancel()
		timerSpoutCD:Cancel()
		timerWhirlCD:Cancel()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:Schedule(60, emerged, self)
	elseif msg == "Whirl" then
		warnWhirl:Show()
		timerWhirlCD:Start()
	end
end
