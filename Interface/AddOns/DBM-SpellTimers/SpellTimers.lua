-- **********************************************************
-- **             Deadly Boss Mods - SpellTimers           **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
--
-- The localizations are written by:
--    * enGB/enUS: Nitram/Tandanu        http://www.deadlybossmods.com
--    * deDE: Nitram/Tandanu             http://www.deadlybossmods.com
--    * zhCN: yleaf(yaroot@gmail.com)
--    * zhTW: yleaf(yaroot@gmail.com)/Juha
--    * koKR: BlueNyx(bluenyx@gmail.com)/nBlueWiz(everfinale@gmail.com)
--    * esES: Interplay/1nn7erpLaY       http://www.1nn7erpLaY.com
--
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isTBC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)

local default_bartext = "%spell: %player"
local default_settings = {
	enabled				= true,
	showlocal			= true,
	only_from_raid		= true,
	active_in_pvp		= true,
	own_bargroup		= false,
	show_portal			= true,
	disable_encounter	= true
}

if isClassic and not isTBC then
	default_settings.spells				= {
		{ spell = 22700, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 74A
	}
	default_settings.portal_alliance	= {
		{ spell = 10059, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormwind
		{ spell = 11416, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Ironforge
		{ spell = 11419, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Darnassus
		{ spell = 32266, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Exodar
	}
	default_settings.portal_horde		= {
		{ spell = 11417, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Orgrimmar
		{ spell = 11418, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Undercity
		{ spell = 11420, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Thunder Bluff
		{ spell = 32667, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Silvermoon
	}
elseif isTBC then
	default_settings.spells				= {
		{ spell = 22700, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 74A
	}
	default_settings.portal_alliance	= {
		{ spell = 10059, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormwind
		{ spell = 11416, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Ironforge
		{ spell = 11419, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Darnassus
		{ spell = 32266, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Exodar
		{ spell = 33691, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath
	}
	default_settings.portal_horde		= {
		{ spell = 11417, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Orgrimmar
		{ spell = 11418, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Undercity
		{ spell = 11420, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Thunder Bluff
		{ spell = 32667, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Silvermoon
		{ spell = 35717, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath
	}
else
	default_settings.spells				= {
		{ spell = 22700, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 74A
		{ spell = 44389, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 110G
		{ spell = 54711, bartext = default_bartext, cooldown = 300 }, 	-- Scrapbot Construction Kit
		{ spell = 67826, bartext = default_bartext, cooldown = 600 }, 	-- Jeeves
	}
	default_settings.portal_alliance	= {
		{ spell = 10059, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormwind
		{ spell = 11416, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Ironforge
		{ spell = 11419, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Darnassus
		{ spell = 32266, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Exodar
		{ spell = 33691, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath
		{ spell = 49360, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Theramore
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran (Northrend)
		{ spell = 88345, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Tol Barad
		{ spell = 132620, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Vale of eternal Blossoms
		{ spell = 120146, bartext = default_bartext, cooldown = 60 }, 	-- Ancient Portal: Dalaran
		{ spell = 176246, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormshield
		{ spell = 224873, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran - Broken Isles
		{ spell = 281400, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Boralus
	}
	default_settings.portal_horde		= {
		{ spell = 11417, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Orgrimmar
		{ spell = 11418, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Undercity
		{ spell = 11420, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Thunder Bluff
		{ spell = 32667, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Silvermoon
		{ spell = 35717, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath
		{ spell = 49361, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stonard
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran (Northrend)
		{ spell = 88346, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Tol Barad
		{ spell = 132626, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Vale of eternal Blossoms
		{ spell = 120146, bartext = default_bartext, cooldown = 60 }, 	-- Ancient Portal: Dalaran
		{ spell = 176244, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Warspear
		{ spell = 224873, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran - Broken Isles
		{ spell = 281402, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dazar'alor
	}
end

DBM_SpellTimers_Settings = {}
local settings = default_settings

local L = DBM_SpellsUsed_Translations

local SpellBarIndex, SpellIDIndex, SpellNameIndex = {}, {}, {}

local type, pairs = type, pairs
local DBM, DBT = DBM, DBT

local function rebuildSpellIDIndex()
	SpellIDIndex = {}
	for k, v in pairs(settings.spells) do
		if v.spell then
			local DBMSpell = DBM:GetSpellInfo(v.spell)
			if DBMSpell == nil then
				settings.spells[k] = nil -- Removes any invalid spells on load.
			else
				SpellIDIndex[v.spell]		= k
				SpellNameIndex[DBMSpell]	= k
			end
		end
	end
end

local function addDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" and type(t1[i]) == "table" then
			addDefaultOptions(t1[i], v)
		end
	end
end

do
	local select = select

	DBM:RegisterOnGuiLoadCallback(function()
		local createnewentry
		local CurCount = 0
		local panel = _G["DBM_GUI"]:CreateNewPanel(L.TabCategory_SpellsUsed, "option")
		local generalarea = panel:CreateArea(L.AreaGeneral)
		local auraarea = panel:CreateArea(L.AreaAuras)

		local function regenerate()
			for i = select("#", auraarea.frame:GetChildren()), 1, -1 do
				local v = select(i, auraarea.frame:GetChildren())
				if v:GetName() ~= "GetAdditionalID_Pull" then
					v:Hide()
					v:SetParent(UIParent)
					v:ClearAllPoints()
				end
			end
			CurCount = 0

			if #settings.spells == 0 then
				createnewentry()
			else
				for _, _ in pairs(settings.spells) do
					createnewentry()
				end
			end
		end

		do
			local twipe = table.wipe

			local enabled = generalarea:CreateCheckButton(L.Enabled, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)

			local showLocal = generalarea:CreateCheckButton(L.ShowLocalMessage, true)
			showLocal:SetScript("OnShow", function(self) self:SetChecked(settings.showlocal) end)
			showLocal:SetScript("OnClick", function(self) settings.showlocal = not not self:GetChecked() end)

			local onlyFromRaid = generalarea:CreateCheckButton(L.OnlyFromRaid, true)
			onlyFromRaid:SetScript("OnShow", function(self) self:SetChecked(settings.only_from_raid) end)
			onlyFromRaid:SetScript("OnClick", function(self) settings.only_from_raid = not not self:GetChecked() end)

			local showInPVP = generalarea:CreateCheckButton(L.EnableInPVP, true)
			showInPVP:SetScript("OnShow", function(self) self:SetChecked(settings.active_in_pvp) end)
			showInPVP:SetScript("OnClick", function(self) settings.active_in_pvp = not not self:GetChecked() end)

			local enablePortals = generalarea:CreateCheckButton(L.EnablePortals, true)
			enablePortals:SetScript("OnShow", function(self) self:SetChecked(settings.show_portal) end)
			enablePortals:SetScript("OnClick", function(self) settings.show_portal = not not self:GetChecked() end)

			local disableEncounter = generalarea:CreateCheckButton(L.DisableEncounter, true)
			disableEncounter:SetScript("OnShow", function(self) self:SetChecked(settings.disable_encounter) end)
			disableEncounter:SetScript("OnClick", function(self) settings.disable_encounter = not not self:GetChecked() end)

			local resetbttn = generalarea:CreateButton(L.Reset, 140, 20)
			resetbttn:SetPoint("TOPRIGHT", generalarea.frame, "TOPRIGHT", -15, -15)
			resetbttn:SetScript("OnClick", function()
				twipe(DBM_SpellTimers_Settings)
				addDefaultOptions(settings, default_settings)
				regenerate()
				_G["DBM_GUI_OptionsFrame"]:DisplayFrame(panel.frame)
			end)
		end

		do
			local tremove, gsub = table.remove, string.gsub

			local function onchange_spell(field)
				return function(self)
					settings.spells[self.guikey] = settings.spells[self.guikey] or {}
					if field == "spell" then
						settings.spells[self.guikey][field] = self:GetNumber()
						rebuildSpellIDIndex()
					elseif field == "cooldown" then
						settings.spells[self.guikey][field] = self:GetNumber()
					elseif field == "enabled" then
						settings.spells[self.guikey].enabled = not not self:GetChecked()
					else
						settings.spells[self.guikey][field] = self:GetText()
					end
				end
			end

			local function onshow_spell(field)
				return function(self)
					settings.spells[self.guikey] = settings.spells[self.guikey] or {}
					if field == "bartext" and settings.spells[self.guikey].spell and settings.spells[self.guikey].spell > 0 then
						local spellinfo = DBM:GetSpellInfo(settings.spells[self.guikey].spell)
						if spellinfo == nil then
							DBM:AddMsg("Illegal SpellID found. Please remove the Spell " .. settings.spells[self.guikey].spell .. " from your DBM Options GUI (spelltimers)");
						else
							self:SetText(gsub(settings.spells[self.guikey][field] or "", "%%spell", spellinfo))
						end
					elseif field == "enabled" then
						self:SetChecked(settings.spells[self.guikey].enabled or false)
					else
						self:SetText(settings.spells[self.guikey][field] or "")
					end
				end
			end

			local getadditionalid = CreateFrame("Button", "GetAdditionalID_Pull", auraarea.frame)
			getadditionalid.myheight = 15
			getadditionalid:SetNormalTexture(130838) -- "Interface\\Buttons\\UI-PlusButton-UP"
			getadditionalid:SetPushedTexture(130836) -- "Interface\\Buttons\\UI-PlusButton-DOWN"
			getadditionalid:SetSize(15, 15)

			function createnewentry()
				CurCount = CurCount + 1
				local spellid = auraarea:CreateEditBox(L.SpellID, "", 65)
				spellid.myheight = 34
				spellid.guikey = CurCount
				spellid:SetPoint("TOPLEFT", auraarea.frame, "TOPLEFT", 40, 15 - (CurCount * 35))
				spellid:SetScript("OnTextChanged", onchange_spell("spell"))
				spellid:SetScript("OnShow", onshow_spell("spell"))
				spellid:SetNumeric(true)

				local bartext = auraarea:CreateEditBox(L.BarText, "", 190)
				bartext.myheight = 0
				bartext.guikey = CurCount
				bartext:SetPoint('TOPLEFT', spellid, "TOPRIGHT", 20, 0)
				bartext:SetScript("OnTextChanged", onchange_spell("bartext"))
				bartext:SetScript("OnShow", onshow_spell("bartext"))

				local cooldown = auraarea:CreateEditBox(L.Cooldown, "", 45)
				cooldown.myheight = 0
				cooldown.guikey = CurCount
				cooldown:SetPoint("TOPLEFT", bartext, "TOPRIGHT", 20, 0)
				cooldown:SetScript("OnTextChanged", onchange_spell("cooldown"))
				cooldown:SetScript("OnShow", onshow_spell("cooldown"))
				cooldown:SetNumeric(true)

				local enableit = auraarea:CreateCheckButton("")
				enableit.myheight = 0
				enableit.guikey = CurCount
				enableit:SetScript("OnShow", onshow_spell("enabled"))
				enableit:SetScript("OnClick", onchange_spell("enabled"))
				enableit:SetPoint("LEFT", cooldown, "RIGHT", 5, 0)

				local removeEntry = CreateFrame("Button", "DeleteAdditionalID_Pull", auraarea.frame)
				removeEntry.myheight = 0
				removeEntry.guikey = CurCount
				removeEntry:SetNormalTexture(130821) -- "Interface\\Buttons\\UI-MinusButton-DOWN"
				removeEntry:SetPushedTexture(130820) -- "Interface\\Buttons\\UI-MinusButton-DOWN"
				removeEntry:SetSize(15, 15)
				removeEntry:SetScript("OnClick", function(self)
					tremove(settings.spells, self.guikey)
					regenerate()
					_G["DBM_GUI_OptionsFrame"]:DisplayFrame(panel.frame)
				end)
				removeEntry:SetPoint("RIGHT", spellid, "LEFT", -15, 0)

				getadditionalid:ClearAllPoints()
				getadditionalid:SetPoint("RIGHT", spellid, "LEFT", -15, -20)
				getadditionalid:SetScript("OnClick", function()
					if spellid:GetNumber() > 0 and bartext:GetText():len() > 0 and cooldown:GetNumber() > 0 then
						createnewentry()
					else
						DBM:AddMsg(L.Error_FillUp)
					end
				end)
				if _G["DBM_GUI"].currentViewing == panel.frame and CurCount > 1 then
					_G["DBM_GUI_OptionsFrame"]:DisplayFrame(panel.frame)
				end
			end

			if #settings.spells == 0 then
				createnewentry()
			else
				for _ = 1, #settings.spells do
					createnewentry()
				end
			end
		end
	end)
end

do
	local IsInInstance, UnitFactionGroup, GetSpellTexture, CombatLogGetCurrentEventInfo = IsInInstance, UnitFactionGroup, GetSpellTexture, CombatLogGetCurrentEventInfo

	local function clearAllSpellBars()
		for k, _ in pairs(SpellBarIndex) do
			DBT:CancelBar(k)
			SpellBarIndex[k] = nil
		end
	end

	local lastmsg, myportals = "", {}
	local eventsUnregistered = false
	local mainframe = CreateFrame("frame", "DBM_SpellTimers", UIParent)
	local spellEvents = {
		["SPELL_CAST_SUCCESS"]	= true,
		["SPELL_RESURRECT"]		= true,
		["SPELL_HEAL"]			= true,
		["SPELL_AURA_APPLIED"]	= true,
		["SPELL_AURA_REFRESH"]	= true,
	}

	mainframe:SetScript("OnEvent", function(self, event, addon)
		if event == "ADDON_LOADED" and addon == "DBM-SpellTimers" then
			self:UnregisterEvent("ADDON_LOADED")
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
			self:RegisterEvent("ENCOUNTER_START")
			self:RegisterEvent("ENCOUNTER_END")
			settings = DBM_SpellTimers_Settings
			addDefaultOptions(settings, default_settings)
			myportals = UnitFactionGroup("player") == "Alliance" and settings.portal_alliance or settings.portal_horde
			rebuildSpellIDIndex()
		elseif settings.enabled and event == "ENCOUNTER_START" and not eventsUnregistered then
			if settings.disable_encounter then
				clearAllSpellBars()
				self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				eventsUnregistered = true
			end
		elseif settings.enabled and event == "ENCOUNTER_END" and eventsUnregistered then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			eventsUnregistered = false
		elseif settings.enabled and event == "PLAYER_ENTERING_BATTLEGROUND" then
			clearAllSpellBars()
		elseif settings.enabled and event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local _, combatEvent, _, _, sourceName, _, _, _, destName, _, _, spellid, spellinfo = CombatLogGetCurrentEventInfo()
			if spellEvents[combatEvent] then
				local _, instanceType = IsInInstance()
				if not settings.active_in_pvp and (instanceType == "pvp" or instanceType == "arena") then
					return
				end
				if settings.only_from_raid and not DBM:GetRaidUnitId(sourceName) then
					return
				end
				local guikey = isClassic and SpellNameIndex[spellinfo] or SpellIDIndex[spellid]
				local v = guikey and settings.spells[guikey]
				if v and v.enabled then
					if not isClassic and v.spell ~= spellid then
						DBM:AddMsg("DBM-SpellTimers Index mismatch error! " .. guikey .. " " .. spellid)
					end
					local bartext = v.bartext:gsub("%%spell", spellinfo or "UNKNOWN SPELL"):gsub("%%player", sourceName or "UNKNOWN SOURCE"):gsub("%%target", destName or "UNKNOWN TARGET")
					SpellBarIndex[bartext] = DBT:CreateBar(v.cooldown, bartext, GetSpellTexture(isClassic and v.spell or spellid), nil, true)
					if settings.showlocal then
						local msg = L.Local_CastMessage:format(bartext)
						if not lastmsg or lastmsg ~= msg then
							DBM:AddMsg(msg)
							lastmsg = msg
						end
					end
				end
			elseif settings.show_portal and combatEvent == "SPELL_CREATE" then
				if settings.only_from_raid and not DBM:GetRaidUnitId(sourceName) then
					return
				end
				for _, v in pairs(myportals) do
					if isClassic and DBM:GetSpellInfo(v.spell) == spellinfo or v.spell == spellid then
						local bartext = v.bartext:gsub("%%spell", spellinfo):gsub("%%player", sourceName):gsub("%%target", destName)
						SpellBarIndex[bartext] = DBT:CreateBar(v.cooldown, bartext, GetSpellTexture(isClassic and v.spell or spellid), nil, true)
						if settings.showlocal then
							local msg = L.Local_CastMessage:format(bartext)
							if not lastmsg or lastmsg ~= msg then
								DBM:AddMsg(msg)
								lastmsg = msg
							end
						end
					end
				end
			end
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end
