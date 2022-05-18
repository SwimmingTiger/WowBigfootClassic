-- $Id: EJLoot.lua 374 2022-01-26 14:33:01Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

-- ////////////////////////////////////////////////////////////////////////////////////////
-- AtlasEJLootFrame.lootScroll to replace EncounterJournal.encounter.info.lootScroll
-- ////////////////////////////////////////////////////////////////////////////////////////

-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local ipairs = _G.ipairs
local pairs = _G.pairs
local select = _G.select
local tonumber = _G.tonumber
local string = _G.string
local math = _G.math
-- Libraries
local floor = math.floor
local format = string.format

local WoWClassicEra, WoWClassicTBC, WoWRetail
local wowtocversion  = select(4, GetBuildInfo())
if wowtocversion < 20000 then
	WoWClassicEra = true
elseif wowtocversion > 19999 and wowtocversion < 90000 then 
	WoWClassicTBC = true
else
	WoWRetail = true
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)
-- UIDropDownMenu
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")

local EJ_SetDifficulty, EJ_SetLootFilter = EJ_SetDifficulty, EJ_SetLootFilter
local EJ_GetLootInfoByIndex = EJ_GetLootInfoByIndex
if WoWRetail then
	EJ_GetLootInfoByIndex = C_EncounterJournal.GetLootInfoByIndex
end
local EJ_GetEncounterInfo, EJ_GetNumLoot = EJ_GetEncounterInfo, EJ_GetNumLoot

local NO_INV_TYPE_FILTER = 0;

local ATLAS_EJ_DIFFICULTIES = 
{
	{ size = "5", prefix = PLAYER_DIFFICULTY1, difficultyID = 1 },
	{ size = "5", prefix = PLAYER_DIFFICULTY2, difficultyID = 2 },
	{ size = "5", prefix = PLAYER_DIFFICULTY6, difficultyID = 23 },
	{ size = "5", prefix = PLAYER_DIFFICULTY_TIMEWALKER, difficultyID = 24 },
	{ size = "25", prefix = PLAYER_DIFFICULTY3, difficultyID = 7 },
	{ size = "10", prefix = PLAYER_DIFFICULTY1, difficultyID = 3 },
	{ size = "10", prefix = PLAYER_DIFFICULTY2, difficultyID = 5 },
	{ size = "25", prefix = PLAYER_DIFFICULTY1, difficultyID = 4 },
	{ size = "25", prefix = PLAYER_DIFFICULTY2, difficultyID = 6 },
	{ prefix = PLAYER_DIFFICULTY3, difficultyID = 17 },
	{ prefix = PLAYER_DIFFICULTY1, difficultyID = 14 },
	{ prefix = PLAYER_DIFFICULTY2, difficultyID = 15 },
	{ prefix = PLAYER_DIFFICULTY6, difficultyID = 16 },
	{ prefix = PLAYER_DIFFICULTY_TIMEWALKER, difficultyID = 33 },
}

local SlotFilterToSlotName = {}
if WoWRetail then
	SlotFilterToSlotName = {
		[Enum.ItemSlotFilterType.Head] = INVTYPE_HEAD,
		[Enum.ItemSlotFilterType.Neck] = INVTYPE_NECK,
		[Enum.ItemSlotFilterType.Shoulder] = INVTYPE_SHOULDER,
		[Enum.ItemSlotFilterType.Cloak] = INVTYPE_CLOAK,
		[Enum.ItemSlotFilterType.Chest] = INVTYPE_CHEST,
		[Enum.ItemSlotFilterType.Wrist] = INVTYPE_WRIST,
		[Enum.ItemSlotFilterType.Hand] = INVTYPE_HAND,
		[Enum.ItemSlotFilterType.Waist] = INVTYPE_WAIST,
		[Enum.ItemSlotFilterType.Legs] = INVTYPE_LEGS,
		[Enum.ItemSlotFilterType.Feet] = INVTYPE_FEET,
		[Enum.ItemSlotFilterType.MainHand] = INVTYPE_WEAPONMAINHAND,
		[Enum.ItemSlotFilterType.OffHand] = INVTYPE_WEAPONOFFHAND,
		[Enum.ItemSlotFilterType.Finger] = INVTYPE_FINGER,
		[Enum.ItemSlotFilterType.Trinket] = INVTYPE_TRINKET,
		[Enum.ItemSlotFilterType.Other] = EJ_LOOT_SLOT_FILTER_OTHER,
	}
end

local BOSS_LOOT_BUTTON_HEIGHT = 45
local INSTANCE_LOOT_BUTTON_HEIGHT = 64

function Atlas_EJ_ResetLootFilter()
	if (WoWClassicEra or WoWClassicTBC) then return end
	EJ_ResetLootFilter()
end

function Atlas_EncounterJournal_DisplayLoot(instanceID, encounterId)
	AtlasEJLootFrame.instanceID = instanceID
	AtlasEJLootFrame.encounterID = encounterId
--	EncounterJournal.instanceID = instanceID
--	EncounterJournal.encounterID = encounterId
--	EJ_SelectInstance(instanceID)
	AtlasEJLootFrame:Show()
end

function Atlas_EncounterJournal_OnLoad(self)
	if (WoWClassicEra or WoWClassicTBC) then return end
--	EncounterJournalTitleText:SetText(ADVENTURE_JOURNAL)
--	SetPortraitToTexture(EncounterJournalPortrait,"Interface\\EncounterJournal\\UI-EJ-PortraitIcon")
--	self:RegisterEvent("EJ_LOOT_DATA_RECIEVED")
	self:RegisterEvent("EJ_DIFFICULTY_UPDATE")
--	self:RegisterEvent("UNIT_PORTRAIT_UPDATE")
--	self:RegisterEvent("SEARCH_DB_LOADED")
--	self:RegisterEvent("UI_MODEL_SCENE_INFO_UPDATED")

--	self.encounter.freeHeaders = {}
--	self.encounter.usedHeaders = {}

--	self.encounter.overviewFrame = self.encounter.info.overviewScroll.child
--	self.encounter.overviewFrame.isOverview = true
--	self.encounter.overviewFrame.overviews = {}
--	self.encounter.info.overviewScroll.ScrollBar.scrollStep = 30

--	self.encounter.infoFrame = self.encounter.info.detailsScroll.child
--	self.encounter.info.detailsScroll.ScrollBar.scrollStep = 30

--	self.encounter.bossesFrame = self.encounter.info.bossesScroll.child
--	self.encounter.info.bossesScroll.ScrollBar.scrollStep = 30

--	self.encounter.info.overviewTab:Click()

-- ////////////////////////////////////////////////////////////////////////////////////////
-- AtlasEJLootFrame.lootScroll to replace EncounterJournal.encounter.info.lootScroll
-- ////////////////////////////////////////////////////////////////////////////////////////
	self.lootScroll.update = Atlas_EncounterJournal_LootUpdate
	self.lootScroll.scrollBar.doNotHide = true
	self.lootScroll.dynamic = Atlas_EncounterJournal_LootCalcScroll
	HybridScrollFrame_CreateButtons(self.lootScroll, "AtlasEncounterItemTemplate", 0, 0)


--	self.searchResults.scrollFrame.update = EncounterJournal_SearchUpdate
--	self.searchResults.scrollFrame.scrollBar.doNotHide = true
--	HybridScrollFrame_CreateButtons(self.searchResults.scrollFrame, "EncounterSearchLGTemplate", 0, 0)

--[[
	local homeData = {
		name = HOME,
		OnClick = function()
			if ( not EncounterJournal.instanceSelect.suggestTab:IsEnabled() ) then
				EJSuggestFrame_OpenFrame();
			else
				EncounterJournal_ListInstances();
			end
		end,
	}
]]
--	NavBar_Initialize(self.navBar, "NavButtonTemplate", homeData, self.navBar.home, self.navBar.overflow)
	LibDD:UIDropDownMenu_Initialize(self.lootScroll.lootFilter, Atlas_EncounterJournal_InitLootFilter, "MENU")
	LibDD:UIDropDownMenu_Initialize(self.lootScroll.lootSlotFilter, Atlas_EncounterJournal_InitLootSlotFilter, "MENU")

	-- initialize tabs
--	local instanceSelect = base.JournalInstanceID
--	local tierName = EJ_GetTierInfo(EJ_GetCurrentTier())
--	UIDropDownMenu_SetText(instanceSelect.tierDropDown, tierName)

	-- check if tabs are active
--	local dungeonInstanceID = EJ_GetInstanceByIndex(1, false)
--	if( not dungeonInstanceID ) then
--		instanceSelect.dungeonsTab.grayBox:Show()
--	end
--	local raidInstanceID = EJ_GetInstanceByIndex(1, true)
--	if( not raidInstanceID ) then
--		instanceSelect.raidsTab.grayBox:Show()
--	end

	-- set the suggestion panel frame to open by default
--	EJSuggestFrame_OpenFrame()
end

function Atlas_EncounterJournal_OnLeave(self)
--	self:UnregisterEvent("EJ_LOOT_DATA_RECIEVED");
end

function Atlas_EncounterJournal_HasChangedContext(instanceID, instanceType, difficultyID)
	if ( instanceType == "none" ) then
		-- we've gone from a dungeon to the open world
		return EncounterJournal.lastInstance ~= nil
	elseif ( instanceID ~= 0 and (instanceID ~= EncounterJournal.lastInstance or EncounterJournal.lastDifficulty ~= difficultyID) ) then
		-- dungeon or difficulty has changed
		return true
	end
	return false
end

function Atlas_EncounterJournal_ResetDisplay(instanceID, instanceType, difficultyID)
	if ( instanceType == "none" ) then
		EncounterJournal.lastInstance = nil
		EncounterJournal.lastDifficulty = nil
		EJSuggestFrame_OpenFrame()
	else
		EJ_ContentTab_Select(EncounterJournal.instanceSelect.dungeonsTab.id)

		EncounterJournal_DisplayInstance(instanceID)
		EncounterJournal.lastInstance = instanceID
		-- try to set difficulty to current instance difficulty
		if ( EJ_IsValidInstanceDifficulty(difficultyID) ) then
			EJ_SetDifficulty(difficultyID)
		end
		EncounterJournal.lastDifficulty = difficultyID
	end
end

function Atlas_EncounterJournal_OnShow(self)
	if ( tonumber(GetCVar("advJournalLastOpened")) == 0 ) then
		SetCVar("advJournalLastOpened", GetServerTime() );
	end
	MainMenuMicroButton_HideAlert(EJMicroButton);
	MicroButtonPulseStop(EJMicroButton);

	UpdateMicroButtons();
	PlaySound(839);
	Atlas_EncounterJournal_LootUpdate();
	Atlas_EncounterJournal_UpdateDifficulty();
	--LibDD:UIDropDownMenu_Initialize(self.lootScroll.lootFilter, Atlas_EncounterJournal_InitLootFilter, "MENU");
	--LibDD:UIDropDownMenu_Initialize(self.lootScroll.lootSlotFilter, Atlas_EncounterJournal_InitLootSlotFilter, "MENU");

--	local instanceSelect = EncounterJournal.instanceSelect;

	--automatically navigate to the current dungeon if you are in one;
	local mapID = C_Map.GetBestMapForUnit("player")
	local instanceID = mapID and EJ_GetInstanceForMap(mapID) or 0
	local _, instanceType, difficultyID = GetInstanceInfo()
	if ( Atlas_EncounterJournal_HasChangedContext(instanceID, instanceType, difficultyID) ) then
		Atlas_EncounterJournal_ResetDisplay(instanceID, instanceType, difficultyID);
--[[
	elseif ( EncounterJournal.queuedPortraitUpdate ) then
		-- fixes portraits when switching between fullscreen and windowed mode
		EncounterJournal_UpdatePortraits();
		EncounterJournal.queuedPortraitUpdate = false;
	elseif ( self.encounter.overviewFrame:IsShown() and EncounterJournal.overviewDefaultRole and not EncounterJournal.encounter.overviewFrame.linkSection ) then
		local spec, role;

		spec = GetSpecialization();
		if (spec) then
			role = GetSpecializationRole(spec);
		else
			role = "DAMAGER";
		end

		if ( EncounterJournal.overviewDefaultRole ~= role ) then
			EncounterJournal_ToggleHeaders(EncounterJournal.encounter.overviewFrame);
		end
]]
	end

--	local tierData = EJ_TIER_DATA[EJ_GetCurrentTier()];
--	if ( not instanceSelect.suggestTab:IsEnabled() or EncounterJournal.suggestFrame:IsShown() ) then
--		tierData = EJ_TIER_DATA[EJSuggestTab_GetPlayerTierIndex()];
--	end
--	instanceSelect.bg:SetTexture(tierData.backgroundTexture);
--	instanceSelect.raidsTab.selectedGlow:SetVertexColor(tierData.r, tierData.g, tierData.b);
--	instanceSelect.dungeonsTab.selectedGlow:SetVertexColor(tierData.r, tierData.g, tierData.b);
end

function Atlas_EncounterJournal_OnEvent(self, event, ...)
--	if  event == "EJ_LOOT_DATA_RECIEVED" then
--		local itemID = ...
--		if itemID and not EJ_IsLootListOutOfDate() then
--			Atlas_EncounterJournal_LootCallback(itemID);
--[[
			if EncounterJournal.searchResults:IsShown() then
				EncounterJournal_SearchUpdate();
			elseif EncounterJouranl_IsSearchPreviewShown() then
				EncounterJournal_UpdateSearchPreview();
			end
]]
--		else
--			Atlas_EncounterJournal_LootUpdate();
--		end
--	elseif event == "EJ_DIFFICULTY_UPDATE" then
	if event == "EJ_DIFFICULTY_UPDATE" then
		--fix the difficulty buttons
		Atlas_EncounterJournal_UpdateDifficulty(...);
--[[
	elseif event == "UNIT_PORTRAIT_UPDATE" then
		local unit = ...;
		if not unit then
			EncounterJournal_UpdatePortraits();
		end
	elseif event == "SEARCH_DB_LOADED" then
		EncounterJournal_RestartSearchTracking();
	elseif event == "PLAYER_LEVEL_UP" and EncounterJournal:IsShown() then
		EncounterJournal_CheckLevelAndDisplayLootTab();
	elseif event == "UI_MODEL_SCENE_INFO_UPDATED" then
		local forceUpdate = true;
		EncounterJournal_ShowCreatures(forceUpdate);
	elseif event == "SPELL_TEXT_UPDATE" then
		local spellID = ...;
		EncounterJournal_UpdateSpellText(self, spellID);
]]
	end
end

function Atlas_EncounterJournal_UpdateDifficulty(newDifficultyID)
	for _, entry in pairs(ATLAS_EJ_DIFFICULTIES) do
		if entry.difficultyID == newDifficultyID then
			if (entry.size) then
				AtlasEJLootFrame.lootScroll.difficulty:SetFormattedText(ENCOUNTER_JOURNAL_DIFF_TEXT, entry.size, entry.prefix);
			else
				AtlasEJLootFrame.lootScroll.difficulty:SetText(entry.prefix);
			end
			Atlas_EncounterJournal_Refresh();
			break;
		end
	end
end

function Atlas_EncounterJournal_SetLootButton(item)
	local itemInfo = EJ_GetLootInfoByIndex(item.index);
	if ( itemInfo and itemInfo.name ) then
		item.name:SetText(WrapTextInColorCode(itemInfo.name, itemInfo.itemQuality));
		item.icon:SetTexture(itemInfo.icon);
		if itemInfo.handError then
			item.slot:SetText(INVALID_EQUIPMENT_COLOR:WrapTextInColorCode(itemInfo.slot));
		else
			item.slot:SetText(itemInfo.slot);
		end
		if itemInfo.weaponTypeError then
			item.armorType:SetText(INVALID_EQUIPMENT_COLOR:WrapTextInColorCode(itemInfo.armorType));
		else
			item.armorType:SetText(itemInfo.slot);
		end

		local numEncounters = EJ_GetNumEncountersForLootByIndex(item.index);
		if (numEncounters == 1) then
			item.boss:SetFormattedText(BOSS_INFO_STRING, EJ_GetEncounterInfo(itemInfo.encounterID));
		elseif ( numEncounters == 2) then
			local itemInfoSecond = EJ_GetLootInfoByIndex(item.index, 2);
			local secondEncounterID = itemInfoSecond and itemInfoSecond.encounterID;
			if ( itemInfo.encounterID and secondEncounterID ) then
				item.boss:SetFormattedText(BOSS_INFO_STRING_TWO, EJ_GetEncounterInfo(itemInfo.encounterID), EJ_GetEncounterInfo(secondEncounterID));
			end
		elseif ( numEncounters > 2 ) then
			item.boss:SetFormattedText(BOSS_INFO_STRING_MANY, EJ_GetEncounterInfo(itemInfo.encounterID));
		end

		local itemName, _, quality = GetItemInfo(itemInfo.link);
		SetItemButtonQuality(item, quality, itemInfo.link);
	else
		--item.name:SetText(RETRIEVING_ITEM_INFO);
		item.name:SetText(L["ATLAS_REOPEN_LOOT_AGAIN"]);
		item.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
		item.slot:SetText("");
		item.armorType:SetText("");
		item.boss:SetText("");
	end
	item.encounterID = itemInfo and itemInfo.encounterID;
	item.itemID = itemInfo and itemInfo.itemID;
	item.link = itemInfo and itemInfo.link;
	item:Show();
	if item.showingTooltip then
		Atlas_EncounterJournal_SetTooltip(item.link);
	end
end

function Atlas_EncounterJournal_LootCallback(itemID)
	local scrollFrame = AtlasEJLootFrame.lootScroll;

	for i, item in ipairs(scrollFrame.buttons) do
		if item.itemID == itemID and item:IsShown() then
			Atlas_EncounterJournal_SetLootButton(item, item.index);
		end
	end
end

function Atlas_EncounterJournal_LootUpdate()
	Atlas_EncounterJournal_UpdateFilterString();
	local scrollFrame = AtlasEJLootFrame.lootScroll;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	local items = scrollFrame.buttons;
	local item, index;

	local numLoot = EJ_GetNumLoot();
	local buttonSize = BOSS_LOOT_BUTTON_HEIGHT;

	for i = 1,#items do
		item = items[i];
		index = offset + i;
		if index <= numLoot then
			if (AtlasEJLootFrame.encounterID) then
				item:SetHeight(BOSS_LOOT_BUTTON_HEIGHT);
				item.boss:Hide();
				item.bossTexture:Hide();
				item.bosslessTexture:Show();
			else
				buttonSize = INSTANCE_LOOT_BUTTON_HEIGHT;
				item:SetHeight(INSTANCE_LOOT_BUTTON_HEIGHT);
				item.boss:Show();
				item.bossTexture:Show();
				item.bosslessTexture:Hide();
			end
			item.index = index;
			Atlas_EncounterJournal_SetLootButton(item);
		else
			item:Hide();
		end
	end

	local totalHeight = numLoot * buttonSize;
	HybridScrollFrame_Update(scrollFrame, totalHeight, scrollFrame:GetHeight());
end

function Atlas_EncounterJournal_LootCalcScroll(offset)
	local buttonHeight = BOSS_LOOT_BUTTON_HEIGHT;
	local numLoot = EJ_GetNumLoot();

	if (not AtlasEJLootFrame.encounterID) then
		buttonHeight = INSTANCE_LOOT_BUTTON_HEIGHT;
	end

	local index = floor(offset/buttonHeight)
	return index, offset - (index*buttonHeight);
end

function Atlas_EncounterJournal_Loot_OnUpdate(self)
	if GameTooltip:IsOwned(self) then
		if IsModifiedClick("DRESSUP") then
			ShowInspectCursor();
		else
			ResetCursor();
		end
	end
end

function Atlas_EncounterJournal_SetTooltip(link)
	if (not link) then
		return;
	end

	local classID, specID = EJ_GetLootFilter();

	if (specID == 0) then
		local spec = GetSpecialization();
		if (spec and classID == select(3, UnitClass("player"))) then
			specID = GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player"));
		else
			specID = -1;
		end
	end

	GameTooltip:SetAnchorType("ANCHOR_RIGHT");
	GameTooltip:SetHyperlink(link, classID, specID);
	GameTooltip_ShowCompareItem();
end

function Atlas_EncounterJournal_Refresh(self)
	Atlas_EncounterJournal_LootUpdate();
--[[
	if EncounterJournal.encounterID then
		EncounterJournal_DisplayEncounter(EncounterJournal.encounterID, true)
	elseif EncounterJournal.instanceID then
		EncounterJournal_DisplayInstance(EncounterJournal.instanceID, true);
	end
]]
end

function Atlas_EncounterJournal_SelectDifficulty(self, value)
	EJ_SetDifficulty(value);
end

function Atlas_EncounterJournal_DifficultyInit(self, level)
	local currDifficulty = EJ_GetDifficulty and EJ_GetDifficulty() or nil
	local info = LibDD:UIDropDownMenu_CreateInfo();
	for i=1,#ATLAS_EJ_DIFFICULTIES do
		local entry = ATLAS_EJ_DIFFICULTIES[i];
		if EJ_IsValidInstanceDifficulty and EJ_IsValidInstanceDifficulty(entry.difficultyID) then
			info.func = Atlas_EncounterJournal_SelectDifficulty;
			if (entry.size) then
				info.text = format(ENCOUNTER_JOURNAL_DIFF_TEXT, entry.size, entry.prefix);
			else
				info.text = entry.prefix;
			end
			info.arg1 = entry.difficultyID;
			info.checked = currDifficulty == entry.difficultyID;
			LibDD:UIDropDownMenu_AddButton(info);
		end
	end
end
function Atlas_EncounterJournal_OnFilterChanged(self)
	LibDD:CloseDropDownMenus(1);
	Atlas_EncounterJournal_LootUpdate();
end

function Atlas_EncounterJournal_SetClassAndSpecFilter(self, classID, specID)
	EJ_SetLootFilter(classID, specID);
	Atlas_EncounterJournal_OnFilterChanged(self);
end

function Atlas_EncounterJournal_RefreshSlotFilterText(self)
	local text = ALL_INVENTORY_SLOTS;
	local slotFilter = C_EncounterJournal.GetSlotFilter();
	if slotFilter ~= Enum.ItemSlotFilterType.NoFilter then
		for _, filter in pairs(Enum.ItemSlotFilterType) do
			if ( filter == slotFilter ) then
				text = SlotFilterToSlotName[filter];
				break;
			end
		end
	end

	AtlasEJLootFrame.lootScroll.slotFilter:SetText(text);
end

function Atlas_EncounterJournal_SetSlotFilter(self, slot)
	C_EncounterJournal.SetSlotFilter(slot);
	Atlas_EncounterJournal_RefreshSlotFilterText(self);
	Atlas_EncounterJournal_OnFilterChanged(self);
end

function Atlas_EncounterJournal_UpdateFilterString()
	local name, _;
	local classID, specID = EJ_GetLootFilter();

	if (specID > 0) then
		_, name = GetSpecializationInfoByID(specID, UnitSex("player"))
	elseif (classID > 0) then
		local classInfo = C_CreatureInfo.GetClassInfo(classID);
		if classInfo then
			name = classInfo.className;
		end
	end

	if name then
		AtlasEJLootFrame.lootScroll.classClearFilter.text:SetText(format(EJ_CLASS_FILTER, name));
		AtlasEJLootFrame.lootScroll.classClearFilter:Show();
		AtlasEJLootFrame.lootScroll:SetHeight(360);
	else
		AtlasEJLootFrame.lootScroll.classClearFilter:Hide();
		AtlasEJLootFrame.lootScroll:SetHeight(382);
	end
end

local CLASS_DROPDOWN = 1;
function Atlas_EncounterJournal_InitLootFilter(self, level)
	local filterClassID, filterSpecID = EJ_GetLootFilter and EJ_GetLootFilter() or nil
	local sex = UnitSex("player");
	local classDisplayName, classTag, classID;
	local info = LibDD:UIDropDownMenu_CreateInfo();
	info.keepShownOnClick = nil;

	if (L_UIDROPDOWNMENU_MENU_VALUE == CLASS_DROPDOWN) then
		info.text = ALL_CLASSES;
		info.checked = (filterClassID == 0);
		info.arg1 = 0;
		info.arg2 = 0;
		info.func = Atlas_EncounterJournal_SetClassAndSpecFilter;
		LibDD:UIDropDownMenu_AddButton(info, level);

		local numClasses = GetNumClasses();
		for i = 1, numClasses do
			classDisplayName, classTag, classID = GetClassInfo(i);
			info.text = classDisplayName;
			info.checked = (filterClassID == classID);
			info.arg1 = classID;
			info.arg2 = 0;
			info.func = Atlas_EncounterJournal_SetClassAndSpecFilter;
			LibDD:UIDropDownMenu_AddButton(info, level);
		end
	end

	if (level == 1) then
		info.text = CLASS;
		info.func =  nil;
		info.notCheckable = true;
		info.hasArrow = true;
		info.value = CLASS_DROPDOWN;
		LibDD:UIDropDownMenu_AddButton(info, level)

		if ( filterClassID > 0 ) then
			classID = filterClassID;
			
			local classInfo = C_CreatureInfo.GetClassInfo(filterClassID);
			if classInfo then
				classDisplayName = classInfo.className;
				classTag = classInfo.classFile;
			end
		else
			classDisplayName, classTag, classID = UnitClass("player");
		end
		info.text = classDisplayName;
		info.notCheckable = true;
		info.arg1 = nil;
		info.arg2 = nil;
		info.func =  nil;
		info.hasArrow = false;
		LibDD:UIDropDownMenu_AddButton(info, level);

		info.notCheckable = nil;
		local numSpecs = GetNumSpecializationsForClassID(classID);
		for i = 1, numSpecs do
			local specID, specName = GetSpecializationInfoForClassID(classID, i, sex);
			info.leftPadding = 10;
			info.text = specName;
			info.checked = (filterSpecID == specID);
			info.arg1 = classID;
			info.arg2 = specID;
			info.func = Atlas_EncounterJournal_SetClassAndSpecFilter;
			LibDD:UIDropDownMenu_AddButton(info, level);
		end

		info.text = ALL_SPECS;
		info.leftPadding = 10;
		info.checked = (classID == filterClassID) and (filterSpecID == 0);
		info.arg1 = classID;
		info.arg2 = 0;
		info.func = Atlas_EncounterJournal_SetClassAndSpecFilter;
		LibDD:UIDropDownMenu_AddButton(info, level);
	end
end

function Atlas_EncounterJournal_InitLootSlotFilter(self, level)
	local slotFilter = C_EncounterJournal.GetSlotFilter();

	local info = LibDD:UIDropDownMenu_CreateInfo();
	info.text = ALL_INVENTORY_SLOTS;
	info.checked = slotFilter == Enum.ItemSlotFilterType.NoFilter;
	info.arg1 = Enum.ItemSlotFilterType.NoFilter;
	info.func = Atlas_EncounterJournal_SetSlotFilter;
	LibDD:UIDropDownMenu_AddButton(info);

	C_EncounterJournal.ResetSlotFilter();
	local isLootSlotPresent = {};
	local numLoot = EJ_GetNumLoot();
	for i = 1, numLoot do
		local itemInfo = EJ_GetLootInfoByIndex(i);
		local filterType = itemInfo and itemInfo.filterType;
		if ( filterType ) then
			isLootSlotPresent[filterType] = true;
		end
	end
	C_EncounterJournal.SetSlotFilter(slotFilter);
	for _, filter in pairs(Enum.ItemSlotFilterType) do
		if ( (isLootSlotPresent[filter] or filter == slotFilter) and filter ~= Enum.ItemSlotFilterType.NoFilter ) then
			info.text = SlotFilterToSlotName[filter];
			info.checked = slotFilter == filter;
			info.arg1 = filter;
			LibDD:UIDropDownMenu_AddButton(info);
		end
	end
end
