local mod	= DBM:NewMod("Gothik", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20201102044230")
mod:SetCreatureID(16060)
mod:SetEncounterID(1109)
mod:SetModelID(16279)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

--TODO, actual naxx 40 waves, right now 25 man are used
--(source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
local warnWaveNow		= mod:NewAnnounce("WarningWaveSpawned", 3, nil, false)
local warnWaveSoon		= mod:NewAnnounce("WarningWaveSoon", 2)
local warnRiderDown		= mod:NewAnnounce("WarningRiderDown", 4)
local warnKnightDown	= mod:NewAnnounce("WarningKnightDown", 2)
local warnPhase2		= mod:NewPhaseAnnounce(2, 3)

local timerPhase2		= mod:NewTimer(270, "TimerPhase2", "136116", nil, nil, 6)
local timerWave			= mod:NewTimer(20, "TimerWave", "135974", nil, nil, 1)

mod.vb.wave = 0

--TODO, actual wave info and timer verification, this is Naxx25 data

local wavesClassic = {
	{3, L.Trainee, next = 20},
	{3, L.Trainee, next = 20},
	{3, L.Trainee, next = 10},
	{2, L.Knight, next = 10},
	{3, L.Trainee, next = 15},
	{2, L.Knight, next = 5},
	{3, L.Trainee, next = 20},
	{2, L.Knight, 3, L.Trainee, next = 10},
	{1, L.Rider, next = 10},
	{3, L.Trainee, next = 5},
	{2, L.Knight, next = 15},
	{1, L.Rider, 3, L.Trainee, next = 10},
	{2, L.Knight, next = 10},
	{3, L.Trainee, next = 10},
	{1, L.Rider, next = 5},
	{2, L.Knight, next = 5},
	{3, L.Trainee, next = 20},
	{1, L.Rider, 2, L.Knight, 3, L.Trainee},
}

--[[
local wavesWrath25 = {
	{3, L.Trainee, next = 20},
	{3, L.Trainee, next = 20},
	{3, L.Trainee, next = 10},
	{2, L.Knight, next = 10},
	{3, L.Trainee, next = 15},
	{2, L.Knight, next = 5},
	{3, L.Trainee, next = 20},
	{3, L.Trainee, 2, L.Knight, next = 10},
	{3, L.Trainee, next = 10},
	{1, L.Rider, next = 5},
	{3, L.Trainee, next = 15},
	{1, L.Rider, next = 10},
	{2, L.Knight, next = 10},
	{1, L.Rider, next = 10},
	{1, L.Rider, 3, L.Trainee, next = 5},
	{1, L.Knight, 3, L.Trainee, next = 5},
	{1, L.Rider, 3, L.Trainee, next = 20},
	{1, L.Rider, 2, L.Knight, 3, L.Trainee},
}
--]]

local function getWaveString(wave)
	local waveInfo = wavesClassic[wave]
	if #waveInfo == 2 then
		return L.WarningWave1:format(unpack(waveInfo))
	elseif #waveInfo == 4 then
		return L.WarningWave2:format(unpack(waveInfo))
	elseif #waveInfo == 6 then
		return L.WarningWave3:format(unpack(waveInfo))
	end
end

function mod:NextWave()
	self.vb.wave = self.vb.wave + 1
	warnWaveNow:Show(self.vb.wave, getWaveString(self.vb.wave))
	local next = wavesClassic[self.vb.wave].next
	if next then
		timerWave:Start(next, self.vb.wave + 1)
		warnWaveSoon:Schedule(next - 3, self.vb.wave + 1, getWaveString(self.vb.wave + 1))
		self:ScheduleMethod(next, "NextWave")
	end
end

function mod:OnCombatStart(delay)
	self.vb.wave = 0
	timerPhase2:Start()
	warnPhase2:Schedule(270)
	timerWave:Start(27, self.vb.wave + 1)
	warnWaveSoon:Schedule(24, self.vb.wave + 1, getWaveString(self.vb.wave + 1))
	self:ScheduleMethod(27, "NextWave")
--	DBM:AddMsg("Add timers/spawn names are probably not correct, as they are from Naxx 25. You can help correct this by sharing well angled videos of mobs spawning in that show the SPAWNING (not running in from a blind spot)")
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16126 then -- Unrelenting Rider
		warnRiderDown:Show()
	elseif cid == 16125 then -- Unrelenting Deathknight
		warnKnightDown:Show()
	end
end

