local mod	= DBM:NewMod("Shahraz", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220511043833")
mod:SetCreatureID(22947)
mod:SetEncounterID(607, 2478)
mod:SetModelID(21252)
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20220130000000)
mod:SetMinSyncRevision(20220130000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED 41001",
	"SPELL_AURA_REMOVED 41001",
	"SPELL_CAST_SUCCESS 40823",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--[[
ability.id = 40823 and type = "cast"
 or ability.id = 41001 and type = "applydebuff"
--]]
--TODO, announce auras?
--TODO, it looks like something about 2/3rds into fight resets the bosses timers, her enrage maybe?
local warnFA			= mod:NewTargetNoFilterAnnounce(41001, 4)
local warnShriek		= mod:NewSpellAnnounce(40823)
local warnEnrageSoon	= mod:NewSoonAnnounce(21340)--not actual spell id
local warnEnrage		= mod:NewSpellAnnounce(21340)

local specWarnFA		= mod:NewSpecialWarningYouPos(41001, nil, nil, nil, 1, 2)
local yellFA			= mod:NewShortPosYell(41001)

local timerFACD			= mod:NewCDTimer(20.7, 41001, nil, nil, nil, 3)--20-51
local timerAura			= mod:NewTimer(15, "timerAura", 22599)
local timerShriekCD		= mod:NewCDTimer(15.8, 40823, nil, nil, nil, 2)--15-46.9

mod:AddSetIconOption("FAIcons", 41001, true, false, {1, 2, 3})
mod:AddInfoFrameOption(41001, true)
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("FAHelper", {"North", "South", "None"}, "North", "misc")

mod.vb.prewarn_enrage = false
mod.vb.enrage = false
mod.vb.FABehavior = "North"
local FATargets = {}

local updateInfoFrame
do
	local twipe = table.wipe
	local lines, sortedLines = {}, {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		for i=1, #FATargets do
			local name = FATargets[i]
			if mod.vb.FABehavior ~= "None" then
				if i == 1 then
					addLine(DBM_COMMON_L.LEFT, name)
				elseif i == 2 then
					addLine(DBM_COMMON_L.RIGHT, name)
				else
					if mod.vb.FABehavior == "North" then
						addLine(DBM_COMMON_L.NORTH, name)
					else
						addLine(DBM_COMMON_L.SOUTH, name)
					end
				end
			else
				addLine(i, name)
			end
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.prewarn_enrage = false
	self.vb.enrage = false
	self.vb.FABehavior = self.Options.FAHelper--Default it to whatever user has it set to, until group leader overrides it
	timerShriekCD:Start(15.8-delay)
	timerFACD:Start(24.4-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"UNIT_HEALTH"
		)
	end
	if UnitIsGroupLeader("player") then
		if self.Options.FAHelper == "North" then
			self:SendSync("North")
		elseif self.Options.FAHelper == "South" then
			self:SendSync("South")
		elseif self.Options.FAHelper == "None" then
			self:SendSync("None")
		end
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41001 then
		--In case no UNIT_SPELLCAST_SUCCEEDED event caught
		if self:AntiSpam(3, 40869) then
			table.wipe(FATargets)
			timerFACD:Start()
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(3, "function", updateInfoFrame, false, false)
			end
		end
		if not tContains(FATargets, args.destName) then
			table.insert(FATargets, args.destName)
		end
		local icon = #FATargets
		warnFA:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnFA:Show(self:IconNumToTexture(icon))
			specWarnFA:Play("scatter")
			yellFA:Yell(icon, icon)
			if self.vb.FABehavior ~= "None" then
				if icon == 1 then--Star is Left
					DBM.Arrow:ShowStatic(270, 12)
				elseif icon == 2 then
					DBM.Arrow:ShowStatic(90, 12)
				else
					if self.vb.FABehavior == "North" then
						DBM.Arrow:ShowStatic(0, 12)
					else
						DBM.Arrow:ShowStatic(180, 12)
					end
				end
			end
		end
		if self.Options.FAIcons then
			self:SetIcon(args.destName, icon)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 41001 then
		if args:IsPlayer() then
			DBM.Arrow:Hide()
		end
		if self.Options.FAIcons then
			self:SetIcon(args.destName, 0)
		end
		if DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 40823 then
		warnShriek:Show()
		timerShriekCD:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg, source)
	if not self.vb.enrage and (source or "") == L.name then
		self.vb.enrage = true
		warnEnrage:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and self:GetUnitCreatureId(uId) == 22947 and not self.vb.prewarn_enrage then
		self:UnregisterShortTermEvents()
		self.vb.prewarn_enrage = true
		warnEnrageSoon:Show()
	end
end

do
	local aura = {
		[40880] = true,
		[40882] = true,
		[40883] = true,
		[40891] = true,
		[40896] = true,
		[40897] = true
	}
	--["40869-Fatal Attraction"] = "pull:24.4, 26.8, 28.0, 20.7, 21.9, 26.6, 22.0, 23.2, 23.0, 25.7, 26.6, 26.8, 25.6, 23.1, 26.8, 25.4",
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		if self:AntiSpam(3, spellId) then
			if aura[spellId] then
				self:SendSync("Prismatic", spellId)
			elseif spellId == 40869 then--Cast event not in combat log, only applied and that can be resisted (especially on non timewalker). this ensures timer always exists
				table.wipe(FATargets)
				timerFACD:Start()
			end
		end
	end
end

do
	--Delayed function just to make absolute sure RL sync overrides user settings after OnCombatStart functions run
	local function UpdateRLPreference(self, msg)
		if msg == "North" then
			self.vb.FABehavior = "North"
		elseif msg == "South" then
			self.vb.FABehavior = "South"
		elseif msg == "None" then
			self.vb.FABehavior = "None"
		end
	end
	--Cluttering comms for UNIT events because of nochanges is fun.
	function mod:OnSync(msg, spellId, sender)
		if msg == "Prismatic" and sender and self:IsInCombat() then
			local spellName = DBM:GetSpellInfo(tonumber(spellId))
			timerAura:Start(spellName)
		elseif msg == "North" or msg == "South" or msg == "None" then
			self:Schedule(3, UpdateRLPreference, self, msg)
		end
	end
end
