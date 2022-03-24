local addonName, addon = ...
local module = addon:CreateModule("Aura Tracker")

module.defaultSettings = {
	enable = true,
	fontSize = 10,
}

module.optionsTable = {
	enable = {
		order = 1,
		type = "toggle",
		name = "Enable",
		set = module.UpdateSettings,
	},
	break1 = {
		order = 2,
		type = "header",
		name = "",
	},
	fontSize = {
		order = 3,
		type = "range",
		name = "Font Size",
		desc = "For Blizzard Cooldown Count",
		min = 4,
		max = 36,
		step = 1,
		set = module.UpdateSettings,
	},
}

local auraList

local GetTime = GetTime
local UnitAura = UnitAura

function module:OnEvent(event, ...)
	if event == "UNIT_AURA" then
		module:FindAura(...)
	elseif event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	elseif event == "TEST_MODE" then
		for i = 1, MAX_ARENA_ENEMIES do
			local auraFrame = self["arena"..i]

			if self.db.enable and addon.testMode then
				auraFrame:Show()
				auraFrame.texture:SetTexture(136071)
				auraFrame.cooldown:SetCooldown(GetTime(), random(15,45))
			else
				auraFrame:Hide()
				auraFrame.texture:SetTexture(nil)
				auraFrame.cooldown:Clear()
			end
		end
	elseif event == "UPDATE_SETTINGS" then
		for i = 1, MAX_ARENA_ENEMIES do
			local auraFrame = self["arena"..i]

			if self.db.enable then
				auraFrame:RegisterUnitEvent("UNIT_AURA", "arena"..i)
			else
				auraFrame:UnregisterEvent("UNIT_AURA")
				auraFrame:Hide()
			end

			auraFrame.cooldown.text:SetFont(auraFrame.cooldown.text.fontFile, self.db.fontSize, "OUTLINE")
		end

		if addon.testMode then
			self:OnEvent("TEST_MODE")
		end
	end
end

function module:FindAura(unit)
	local foundSpellID, foundDuration, foundExpirationTime, foundTexture = nil, 0, 0, nil

	for i = 1, 2 do
		local filter = (i == 1 and "HELPFUL" or "HARMFUL")

		for n = 1, 30 do
			local _, texture, _, _, duration, expirationTime, _, _, _, spellID = UnitAura(unit, n, filter)

			if not spellID then break end

			if auraList[spellID] then
				if not foundSpellID or auraList[spellID] < auraList[foundSpellID] then
					foundSpellID = spellID
					foundDuration = duration
					foundExpirationTime = expirationTime
					foundTexture = texture
				end
			end
		end
	end

	local auraFrame = self[unit]

	if foundSpellID then
		local foundStartTime = foundExpirationTime - foundDuration

		if foundDuration > 0 and foundStartTime ~= auraFrame.startTime then
			auraFrame.cooldown:SetCooldown(foundStartTime, foundDuration)
			auraFrame.startTime = foundStartTime
		elseif foundDuration == 0 then
			auraFrame.cooldown:Clear()
			auraFrame.startTime = 0
		end

		auraFrame.texture:SetTexture(foundTexture)
		auraFrame:Show()
	else
		auraFrame.cooldown:Clear()
		auraFrame.startTime = 0
		auraFrame:Hide()
	end
end

-- Create a frame to display aura icon & cooldown
for i = 1, MAX_ARENA_ENEMIES do
	local arenaFrame = _G["ArenaEnemyFrame"..i]

	local auraFrame = CreateFrame("Frame", nil, arenaFrame, "sArenaIconTemplate")
	auraFrame:Hide()
	auraFrame:SetFrameLevel(arenaFrame:GetFrameLevel())
	auraFrame:SetPoint("CENTER", arenaFrame.classPortrait, 0, 1)
	auraFrame:SetSize(23, 23)

	auraFrame.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	auraFrame.texture:AddMaskTexture(auraFrame.mask)

	auraFrame.cooldown:SetSwipeTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
	auraFrame.cooldown:SetUseCircularEdge(true)
	auraFrame.cooldown:SetSwipeColor(0, 0, 0, 0.6)

	auraFrame:SetScript("OnEvent", module.OnEvent)

	module["arena"..i] = auraFrame
	arenaFrame.auraFrame = auraFrame
end

auraList = tInvert({
	-- Higher up = higher priority

	-- Crowd Control
	33786,	-- Cyclone

	10912,	-- Mind Control (Rank 3)
	10911,	-- Mind Control (Rank 2)
	605,	-- Mind Control (Rank 1)

	-- Hard CC (6s)
	8643,	-- Kidney Shot
	10308,	-- Hammer of Justice (Rank 4)

	-- Hard CC (5s)
	12809,	-- Concussion Blow
	5589,	-- Hammer of Justice (Rank 3)
	
	-- Hard CC (4s)
	8983,	-- Bash (Rank 3)
	5588,	-- Hammer of Justice (Rank 2)
	1833,	-- Cheap Shot
	34510,	-- Stormherald Stun

	-- Hard CC (3s)
	27006,	-- Pounce (Rank 4)
	9827,	-- Pounce (Rank 3)
	9823,	-- Pounce (Rank 2)
	9005,	-- Pounce (Rank 1)
	25274,	-- Intercept Stun (Rank 5)
	30197, 	-- Intercept (Felguard) (Rank 3)
	30195, 	-- Intercept (Felguard) (Rank 2)
	30153,	-- Intercept (Felguard) (Rank 1)
	6798,	-- Bash (Rank 2)
	853,	-- Hammer of Justice (Rank 1)
	24394,	-- Intimidation
	5530,	-- Mace Specialization
	19410,	-- Improved Concussive Shot
	28445,	-- Improved Concussive Shot
	18093,	-- Pyroclasm
	15269,	-- Blackout
	27223,	-- Death Coil (Rank 4)
	17926,	-- Death Coil (Rank 3)
	17925,	-- Death Coil (Rank 2)
	6789,	-- Death Coil (Rank 1)

	-- Hard CC (2s)
	30414,	-- Shadowfury (Rank 3)
	30413,	-- Shadowfury (Rank 2)
	30283,	-- Shadowfury (Rank 1)
	5211,	-- Bash (Rank 1)
	20549,	-- War Stomp
	20170,	-- Seal of Justice Stun
	12355,	-- Impact

	-- Hard CC (1s)
	7922,	-- Charge Stun
	23454,	-- Brutal Earthstorm Diamond
	
	-- Soft CC
	2094,	-- Blind
	19503,	-- Scatter Shot
	33043,	-- Dragon's Breath (Rank 4)
	33042,	-- Dragon's Breath (Rank 3)
	33041,	-- Dragon's Breath (Rank 2)
	31661,	-- Dragon's Breath (Rank 1)
	18658,	-- Hibernate (Rank 3)
	18657,	-- Hibernate (Rank 2)
	2637,	-- Hibernate (Rank 1)
	14309,	-- Freezing Trap - Effect (Rank 3)
	14308,	-- Freezing Trap - Effect (Rank 2)
	3355,	-- Freezing Trap - Effect (Rank 1)
	27068,	-- Wyvern Sting (Rank 4)
	24133,	-- Wyvern Sting (Rank 3)
	24132,	-- Wyvern Sting (Rank 2)
	19386,	-- Wyvern Sting (Rank 1)
	12826,	-- Polymorph (Rank 4)
	12825,	-- Polymorph (Rank 3)
	12824,	-- Polymorph (Rank 2)
	118,	-- Polymorph (Rank 1)
	28271,	-- Polymorph: Turtle
	28272,	-- Polymorph: Pig
	6358,	-- Seduction (Succubus)
	17928,	-- Howl of Terror (Rank 2)
	5484,	-- Howl of Terror (Rank 1)
	6215,	-- Fear (Rank 3)
	6213,	-- Fear (Rank 2)
	5782,	-- Fear (Rank 1)
	10890,	-- Phychic Scream (Rank 4)
	10888,	-- Phychic Scream (Rank 3)
	8124,	-- Phychic Scream (Rank 2)
	8122,	-- Phychic Scream (Rank 1)
	5246,	-- Intimidating Shout
	20511,	-- Intimidating Shout
	10326,	-- Turn Evil (Rank 1)
	20066,	-- Repentance
	22570,	-- Maim
	11297,	-- Sap (Rank 3)
	2070,	-- Sap (Rank 2)
	6770,	-- Sap (Rank 1)
	38764,	-- Gouge (Rank 6)
	11286,	-- Gouge (Rank 5)
	11285,	-- Gouge (Rank 4)
	8629,	-- Gouge (Rank 3)
	1777,	-- Gouge (Rank 2)
	1776,	-- Gouge (Rank 1)

	-- Immunities
	1020,	-- Divine Shield (Rank 2)
	642,	-- Divine Shield (Rank 1)
	5573,	-- Divine Protection
	498,	-- Divine Protection
	45438,	-- Ice Block
	34692,	-- The Beast Within
	19574,	-- Bestial Wrath
	3411,	-- Intervene
	10278,	-- Blessing of Protection
	1044,	-- Blessing of Freedom
	31224,	-- Cloak of Shadows
	27827,	--Spirit of Redemption

	-- Silences
	18469,	-- Counterspell - Silenced
	24259,	-- Spell Lock
	31117,	-- Unstable Affliction
	43523,	-- Unstable Affliction
	34490,	-- Silencing Shot
	18498,	-- Shield Bash - Silenced
	1330,	-- Garrote - Silence

	-- Anti-Crowd Control
	23920,	-- Spell Reflection
	8178,	-- Grounding Totem Effect
	27148,	-- Blessing of Sacrifice
	6346,	-- Fear Ward

	5384,	-- Feign Death

	-- Disarms
	676,	-- Disarm
	14251,	-- Riposte

	-- Roots
	26989,	-- Entangling roots (Rank 7)
	9853,	-- Entangling roots (Rank 6)
	9852,	-- Entangling roots (Rank 5)
	5196,	-- Entangling roots (Rank 4)
	5195,	-- Entangling roots (Rank 3)
	1062,	-- Entangling roots (Rank 2)
	339,	-- Entangling roots (Rank 1)
	19975,	-- Entangling Roots (Rank 1) (Nature's Grasp talent)
	19974,	-- Entangling Roots (Rank 2) (Nature's Grasp talent)
	19973,	-- Entangling Roots (Rank 3) (Nature's Grasp talent)
	19972,	-- Entangling Roots (Rank 4) (Nature's Grasp talent)
	19971,	-- Entangling Roots (Rank 5) (Nature's Grasp talent)
	19970,	-- Entangling Roots (Rank 6) (Nature's Grasp talent)
	27010,	-- Entangling Roots (Rank 7) (Nature's Grasp talent)
	25999,	-- Boar Charge (Boar)
	4167,	-- Web (Rank 1)
	4168,	-- Web (Rank 2)
	4169,	-- Web (Rank 3)
	27088,	-- Frost Nova (Rank 5)
	10230,	-- Frost Nova (Rank 4)
	6131,	-- Frost Nova (Rank 3)
	865,	-- Frost Nova (Rank 2)
	122,	-- Frost Nova (Rank 1)
	33395,	-- Freeze (Water Elemental)
	27067,	-- Counterattack (Rank 4)
	20910,	-- Counterattack (Rank 3)
	20909,	-- Counterattack (Rank 2)
	19306,	-- Counterattack (Rank 1)
	44047,	-- Chastise (Rank 6)
	44046,	-- Chastise (Rank 5)
	44045,	-- Chastise (Rank 4)
	44044,	-- Chastise (Rank 3)
	44043,	-- Chastise (Rank 2)
	44041,	-- Chastise (Rank 1)
	19229,	-- Improved Wing Clip
	19185,	-- Entrapment
	12494,	-- Frostbite
	23694,	-- Improved Hamstring
	
	29166,	-- Innervate
	
	3045,	-- Rapid Fire
	12042,	-- Arcane Power
	28682,	-- Combustion
	12472,	-- Icy Veins
	31884,	-- Avenging Wrath
	10060,	-- Power Infusion
	13750,	-- Adrenaline Rush
	18708,	-- Fel Domination
	13877,	-- Blade Flurry
	12292,	-- Deathwish
	12328,	-- Sweeping Strikes
	
	33206,	-- Pain Suppresion
	46989,	-- Improved Blink (Rank 2)
	47000,	-- Improved Blink (Rank 1)
	26669,	-- Evasion (Rank 2)
	5277,	-- Evasion (Rank 1)
	30823,	-- Shamanistic Rage
	18499,	-- Berserker Rage
	31842,	-- Divine Illumination
	22812,	-- Barkskin
	19263,	-- Deterrance

	41425,	-- Hypothermia
	66,		-- Invisibility (Fading)
})