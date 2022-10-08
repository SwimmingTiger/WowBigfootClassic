local mod = DBM:NewMod(603, "DBM-Party-WotLK", 16, 276)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20221006190430")
--mod:SetEncounterID(1990)--TODO, why was this unreliable?

mod:RegisterEvents(
	"SPELL_AURA_REMOVED 69708",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, if boss tokens still don't exist by this classic content update, this mod is basically useless
local WarnWave		= mod:NewAnnounce("WarnWave", 2)

local timerEscape	= mod:NewAchievementTimer(360, 4526, "achievementEscape")

mod.vb.waveCount = 0

local ragingGoul = L.Ghoul
local witchDoctor = L.Doctor
local abomination = L.Abom

local addWaves = {
	[1] = { "6 "..ragingGoul, "1 "..witchDoctor },
	[2] = { "6 "..ragingGoul, "2 "..witchDoctor, "1 "..abomination },
	[3] = { "6 "..ragingGoul, "2 "..witchDoctor, "2 "..abomination },
	[4] = { "12 "..ragingGoul, "3 "..witchDoctor, "3 "..abomination },
}

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69708 then			--Lich King has broken out of his iceblock, this starts actual event
		self.vb.waveCount = 0
		if self:IsDifficulty("heroic5") then
			timerEscape:Start()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 69768 then--Summon Ice Wall
		self.vb.waveCount = self.vb.waveCount + 1
		if self.vb.waveCount == 1 then
			WarnWave:Show(table.concat(addWaves[1], ", "))
		elseif self.vb.waveCount == 2 then
			WarnWave:Show(table.concat(addWaves[2], ", "))
		elseif self.vb.waveCount == 3 then
			WarnWave:Show(table.concat(addWaves[3], ", "))
		elseif self.vb.waveCount == 4 then
			WarnWave:Show(table.concat(addWaves[4], ", "))
		end
	elseif spellId == 72830 then--Achievement Check
		timerEscape:Stop()
	end
end
