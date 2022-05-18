local mod	= DBM:NewMod("Noth", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220511043833")
mod:SetCreatureID(15954)
mod:SetEncounterID(1117)
mod:SetModelID(16590)
mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29213 29212 29208",--54835 Add in wrath
	"CHAT_MSG_MONSTER_YELL"
--	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, determine if old way is required or if new way is still functional
--TODO, add adds warning/timer scheduling for phase 2, since emote triggers are gone. It's a lot of annoying effort though so I'll wait to assess the need
--[[
source.id = 15954 and (type = "begincast" or type = "cast")
 or (source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
--]]
local warnTeleportNow	= mod:NewAnnounce("WarningTeleportNow", 3, "135736")
local warnTeleportSoon	= mod:NewAnnounce("WarningTeleportSoon", 1, "135736")
local warnCurse			= mod:NewSpellAnnounce(29213, 2)
local warnBlink			= mod:NewSpellAnnounce(29208, 3)

local specWarnAdds		= mod:NewSpecialWarningAdds(29212, "-Healer", nil, nil, 1, 2)

local timerTeleport		= mod:NewTimer(90, "TimerTeleport", "135736", nil, nil, 6)
local timerTeleportBack	= mod:NewTimer(70, "TimerTeleportBack", "135736", nil, nil, 6)
local timerCurseCD		= mod:NewCDTimer(51, 29213, nil, nil, nil, 5, nil, DBM_COMMON_L.CURSE_ICON)-- 51-116
local timerAddsCD		= mod:NewAddsTimer(30, 29212, nil, "-Healer")

mod.vb.teleCount = 0
mod.vb.addsCount = 0
mod.vb.curseCount = 0

function mod:Balcony()
	self.vb.teleCount = self.vb.teleCount + 1
	self.vb.addsCount = 0
	timerCurseCD:Stop()
	timerAddsCD:Stop()
	local timer
	if self.vb.teleCount == 1 then
		timer = 75--70-75 in classic, can't confirm because numpty was looking in bumfuck in vdieo, it's 70 in wrath
		timerAddsCD:Start(5)--Always 5
	elseif self.vb.teleCount == 2 then
		timer = 97--Unknown in Classic
		timerAddsCD:Start(5)--Always 5
	elseif self.vb.teleCount == 3 then
		timer = 126--Unknown in Classic
		timerAddsCD:Start(5)--Always 5
	else
		timer = 55--Unknown in Classic
	end
	timerTeleportBack:Start(timer)
	warnTeleportSoon:Schedule(timer - 20)
	warnTeleportNow:Show()
	self:ScheduleMethod(timer, "BackInRoom")
end

function mod:BackInRoom()
	self.vb.addsCount = 0
	self.vb.curseCount = 0
	timerAddsCD:Stop()
	local timer
	if self.vb.teleCount == 1 then
		timer = 109--Unknown in Classic
		timerAddsCD:Start(3)--Unknown until I can get a less numpty POV
	elseif self.vb.teleCount == 2 then
		timer = 173--Unknown in Classic
		timerAddsCD:Start(17)
	elseif self.vb.teleCount == 3 then
		timer = 93--Unknown in Classic
	else
		timer = 35--Unknown in Classic
	end
	timerTeleport:Start(timer)
	warnTeleportSoon:Schedule(timer - 20)
	warnTeleportNow:Show()
	if self.vb.teleCount == 4 then--11-12 except after 4th return it's 17
		timerCurseCD:Start(17)--verify consistency though
	else
		timerCurseCD:Start(10)--11 in wrath, 9 or 10 in classic, well based off numpty POV
	end
	self:ScheduleMethod(timer, "Balcony")
end

function mod:OnCombatStart(delay)
	self.vb.teleCount = 0
	self.vb.addsCount = 0
	self.vb.curseCount = 0
	timerAddsCD:Start(12-delay)--12
	timerCurseCD:Start(9.5-delay)
	timerTeleport:Start(90.8-delay)
	warnTeleportSoon:Schedule(70.8-delay)
	self:ScheduleMethod(90.8-delay, "Balcony")
end

function mod:SPELL_CAST_SUCCESS(args)
	--if args:IsSpellID(29213, 54835) then -- Curse of the Plaguebringer
	if args.spellId == 29213 then -- Curse of the Plaguebringer
		self.vb.curseCount = self.vb.curseCount + 1
		warnCurse:Show()
		if self.vb.teleCount == 2 and self.vb.curseCount == 2 or self.vb.teleCount == 3 and self.vb.curseCount == 1 then
			timerCurseCD:Start(67)--Niche cases it's 67 and not 53-55
		elseif self.vb.curseCount < 2 then
			timerCurseCD:Start()
		end
	--elseif args.spellId == 29212 then--Cripple that's always cast when he teleports away
		--self:UnscheduleMethod("Balcony")
		--self:Balcony()
	elseif args.spellId == 29208 and args:IsSrcTypeHostile() then
		warnBlink:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
	if msg == L.AddsYell or msg:find(L.AddsYell) then
		self:SendSync("Adds")--Syncing to help unlocalized clients
	end
end

--[[
--These events don't happen in classic, added in wrath
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg == L.Adds or msg:find(L.Adds) then
		self:SendSync("Adds")--Syncing to help unlocalized clients
	elseif msg == L.AddsTwo or msg:find(L.AddsTwo) then
		self:SendSync("AddsTwo")--Syncing to help unlocalized clients
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 29231 and self:AntiSpam() then--Teleport Return
		self:SendSync("Teleport")
	end
end
--]]

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Adds" then--Boss Grounded
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		if self.vb.teleCount < 4 then
			if self.vb.teleCount == 0 and self.vb.addsCount < 3 then--3 waves, 12, 34, 34
				timerAddsCD:Start(34)--30 in Wrath
			elseif self.vb.teleCount == 1 then--3 waves, 3, 34, 30 (3 iffy)
				if self.vb.addsCount == 1 then
					timerAddsCD:Start(33.9)
				elseif self.vb.addsCount == 2 then
					timerAddsCD:Start(30)--47.3 in wrath
				end
			elseif self.vb.teleCount == 2 then--30, 32, 32, 30
				if self.vb.addsCount == 1 or self.vb.addsCount == 4 then
					timerAddsCD:Start(30)
				elseif self.vb.addsCount == 2 or self.vb.addsCount == 3 then
					timerAddsCD:Start(32)
				end
			end
		end
	--Below here can't be used in Classic
	--[[elseif msg == "AddsTwo" then--Boss away
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		--He won't do anymore adds when teleported way on 4th and later teleport
		--He'll never do more than 2 waves
		if self.vb.teleCount < 4 and self.vb.addsCount == 1 then
			if self.vb.teleCount == 3 then
				timerAddsCD:Start(60)--2 big waves, 60 seconds apart
			elseif self.vb.teleCount == 2 then--2 medium waves 46 seconds apart
				timerAddsCD:Start(46)
			else--2 smaller waves 30 seconds apart
				timerAddsCD:Start(30)
			end
		end
	elseif msg == "Teleport" then--Boss away
		self:UnscheduleMethod("BackInRoom")
		self:BackInRoom()--]]
	end
end
