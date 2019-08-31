local mod	= DBM:NewMod("Ragnaros-Classic", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190810001130")
mod:SetCreatureID(11502)
mod:SetEncounterID(672)
mod:SetModelID(11121)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)
mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 20566",
	"UNIT_DIED"
)

--TODO, def needs some special warnings, add spawn stuff, etc
local warnWrathRag		= mod:NewSpellAnnounce(20566, 3)
local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", 2)
local warnEmerge		= mod:NewAnnounce("WarnEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", 2)

local timerWrathRag		= mod:NewCDTimer(25, 20566, nil, nil, nil, 2)--25-30
local timerSubmerge		= mod:NewTimer(180, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerEmerge		= mod:NewTimer(90, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerCombatStart	= mod:NewCombatTimer(73)

mod.vb.addDied = 0

function mod:OnCombatStart(delay)
	self.vb.addDied = 0
	timerSubmerge:Start(-delay)
	timerWrathRag:Start(27-delay)
end

local function emerged(self)
	timerEmerge:Cancel()
	warnEmerge:Show()
	timerSubmerge:Start()
--	timerWrathRag:Start()--need to find out what it is first.
	self.vb.addDied = 0
end

do
	local Wrath = DBM:GetSpellInfo(20566)
	function mod:SPELL_CAST_SUCCESS(args)
		--if args.spellId == 20566 then
		if args.spellName == Wrath then
			warnWrathRag:Show()
			timerWrathRag:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Submerge then
		self:SendSync("Submerge")
	--Could also use this instead
	--"<37.8 22:36:31> [CLEU] SPELL_CAST_START#false#Creature-0-3137-409-16929-54404-00007003D3#Majordomo Executus#2584#0##nil#-2147483648#-2147483648#19774#Summon Ragnaros#4", -- [1677]
	--"<38.0 22:36:31> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Impudent whelps! You've rushed headlong to your own deaths! See now, the master stirs!\r\n#Majordomo Executus###Shiramura
	elseif msg == L.Pull then
		timerCombatStart:Start()
	end
end

function mod:OnSync(msg)
	if msg == "Submerge" then
		self:Unschedule(emerged)
		timerWrathRag:Cancel()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:Schedule(90, emerged, self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 12143 then--Son of Flame
		self.vb.addDied = self.vb.addDied + 1
		if self.vb.addDied == 8 then--After all 8 die he emerges immediately
			self:Unschedule(emerged)
			emerged(self)
		end
	end
end
