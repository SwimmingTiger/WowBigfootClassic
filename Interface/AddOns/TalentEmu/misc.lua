--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local next = next;
	local select = select;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local GetTalentInfo =GetTalentInfo;
	local GetAddOnInfo, IsAddOnLoaded = GetAddOnInfo, IsAddOnLoaded;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local PanelTemplates_GetSelectedTab = PanelTemplates_GetSelectedTab;
	local UIParent = UIParent;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

-->
	local L = CT.L;

-->		constant
-->
MT.BuildEnv('MISC');
-->		predef
-->		MISC
	--
	if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
		_G._163_ALAEMU_SETCONFIG = MT.SetConfig;
		_G._163_ALAEMU_GETCONFIG = MT.GetConfig;
	end
	--	popup

		VT.__popuplib.add_meta("EMU_INSPECT", {
			L.PopupQuery,
			function(which, frame)
				MT.SendQueryRequest(frame.name, frame.server, true, true);
			end,
		});
		VT.__popuplib.add_list("SELF", "EMU_INSPECT");
		VT.__popuplib.add_list("FRIEND", "EMU_INSPECT");
		--VT.__popuplib.add_list("FRIEND_OFFLINE", "EMU_INSPECT");
		VT.__popuplib.add_list("PLAYER", "EMU_INSPECT");
		VT.__popuplib.add_list("PARTY", "EMU_INSPECT");
		VT.__popuplib.add_list("RAID", "EMU_INSPECT");
		VT.__popuplib.add_list("RAID_PLAYER", "EMU_INSPECT");
		VT.__popuplib.add_list("CHAT_ROSTER", "EMU_INSPECT");
		VT.__popuplib.add_list("GUILD", "EMU_INSPECT");
		VT.__popuplib.add_list("_BRFF_SELF", "EMU_INSPECT");
		VT.__popuplib.add_list("_BRFF_PARTY", "EMU_INSPECT");
		VT.__popuplib.add_list("_BRFF_RAID_PLAYER", "EMU_INSPECT");
		--	VT.__popuplib.add_list("*", "EMU_INSPECT");

	--
	--	TalentFrameCall
		local _TalentFrame = nil;
		local Orig_TalentFrameTalent_OnClick = nil;
		local function _TalentFrameTalent_OnClick(self, mouseButton)
			if IsShiftKeyDown() then
				local Map = VT.__emulib.GetTalentMap(CT.SELFCLASS);
				if Map ~= nil then
					local TreeIndex, TalentIndex = PanelTemplates_GetSelectedTab(_TalentFrame), self:GetID();
					local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, TalentIndex);
					local SpellID = MT.QueryTalentSpellID(CT.SELFCLASS, TreeIndex, Map.RMap[TreeIndex][TalentIndex], rank);
					local link = MT.GetSpellLink(SpellID, name);
					if link ~= nil then
						local editBox = ChatEdit_ChooseBoxForSend();
						editBox:Show();
						editBox:SetFocus();
						editBox:Insert(link);
					end
					return;
				end
			end
			return Orig_TalentFrameTalent_OnClick(self, mouseButton);
		end
		local TalentFrameTalents = {  };
		local function HookTalentFrame(self, event, addon)
			if addon == "Blizzard_TalentUI" then
				if self ~= nil then
					self:UnregisterEvent("ADDON_LOADED");
					self:SetScript("OnEvent", nil);
				end

				_TalentFrame = _G.TalentFrame or _G.PlayerTalentFrame;
				Orig_TalentFrameTalent_OnClick = _G.TalentFrameTalent_OnClick or _G.PlayerTalentFrameTalent_OnClick;
				if _G.TalentFrame ~= nil then
					for i = 1, 999 do
						local b = _G["TalentFrameTalent" .. i];
						if b then
							b:SetScript("OnClick", _TalentFrameTalent_OnClick);
							TalentFrameTalents[i] = b;
						else
							break;
						end
					end

					local button = CreateFrame('BUTTON', nil, _TalentFrame, "UIPanelButtonTemplate");
					button:SetSize(80, 20);
					button:SetPoint("RIGHT", _G.TalentFrameCloseButton, "LEFT", -2, 0);
					button:SetText(L.TalentFrameCallButtonString);
					button:SetScript("OnClick", function() MT.CreateEmulator(); end);
					button:SetScript("OnEnter", MT.GeneralOnEnter);
					button:SetScript("OnLeave", MT.GeneralOnLeave);
					button.information = L.TalentFrameCallButton;
					_TalentFrame.__TalentEmuCall = button;
				elseif _G.PlayerTalentFrame ~= nil then
					for i = 1, 999 do
						local b = _G["PlayerTalentFrameTalent" .. i];
						if b then
							b:SetScript("OnClick", _TalentFrameTalent_OnClick);
							TalentFrameTalents[i] = b;
						else
							break;
						end
					end

					local button = CreateFrame('BUTTON', nil, _TalentFrame, "UIPanelButtonTemplate");
					button:SetSize(80, 20);
					button:SetPoint("RIGHT", _G.PlayerTalentFrameCloseButton, "LEFT", -2, 0);
					button:SetText(L.TalentFrameCallButtonString);
					button:SetScript("OnClick", function() MT.CreateEmulator(); end);
					button:SetScript("OnEnter", MT.GeneralOnEnter);
					button:SetScript("OnLeave", MT.GeneralOnLeave);
					button.information = L.TalentFrameCallButton;
					_TalentFrame.__TalentEmuCall = button;
					VT.__autostyle:AddReskinObject(button);
				end
			end
		end

		if IsAddOnLoaded("Blizzard_TalentUI") then
			HookTalentFrame(nil, nil, "Blizzard_TalentUI");
		else
			local Agent = CreateFrame('FRAME');
			Agent:RegisterEvent("ADDON_LOADED");
			Agent:SetScript("OnEvent", HookTalentFrame);
			Agent = nil;
		end

		--GameTooltip:SetHyperlink("itemString" or "itemLink")
		--GameTooltip:SetSpellBookItem(SpellBookID, BookType)
		--GameTooltip:SetSpellByID(SpellID)
	--

	local ME = {
		['\97\108\101\120\35\53\49\54\55\50\50'] = 1,
		['\229\141\149\233\133\146\231\170\157\35\53\49\54\51\55'] = 1,
		['\65\76\65\35\53\49\51\55\55'] = 1,
	};

	local trytimes = 0;
	local function _PerdiocGenerateTitle()
		local halt = true;
		for index = 1, VT.SaveButtonMenuAltDefinition.num do
			local Def = VT.SaveButtonMenuAltDefinition[index];
			if Def.text == nil then
				local lClass, class, lRace, race, sex, name, realm = GetPlayerInfoByGUID(Def.param[1]);
				if class ~= nil and name ~= nil then
					Def.text = "|c" .. RAID_CLASS_COLORS[class].colorStr .. name .. "|r";
					Def.param[3] = Def.text;
				else
					halt = false;
				end
			end
		end
		trytimes = trytimes + 1;
		if halt or trytimes > 10 then
			MT._TimerHalt(_PerdiocGenerateTitle);
		end
	end
	local function _StorePlayerData()
		if DT.BUILD == "WRATH" then
			VT.VAR[CT.SELFGUID] = VT.__emulib.EncodePlayerTalentDataV2() .. VT.__emulib.EncodePlayerGlyphDataV2() .. VT.__emulib.EncodePlayerEquipmentDataV2();
		else
			VT.VAR[CT.SELFGUID] = VT.__emulib.EncodePlayerTalentDataV2() .. VT.__emulib.EncodePlayerEquipmentDataV2();
		end
		for index = 1, VT.SaveButtonMenuAltDefinition.num do
			if VT.SaveButtonMenuAltDefinition[index].param[1] == CT.SELFGUID then
				VT.SaveButtonMenuAltDefinition[index].param[2] = VT.VAR[CT.SELFGUID];
			end
		end
		MT.Error("StorePlayerData");
	end
	MT.RegisterOnInit('MISC', function(LoggedIn)
	end);
	MT.RegisterOnLogin('MISC', function(LoggedIn)
		if DT.BUILD == "WRATH" then
			local Map = VT.__emulib.GetTalentMap(CT.SELFCLASS);
			VT.MAP[CT.SELFCLASS] = { VMap = Map.VMap, RMap = Map.RMap, };
		end
		--
		local SET = VT.SET;
		SET.supreme = not not ME[CT.BNTAG];
		if SET.supreme then
			MT.SetConfig("inspect_pack", true);
		end
		--
		for GUID, code in next, VT.VAR do
			if GUID ~= "savedTalent" then
				VT.SaveButtonMenuAltDefinition.num = VT.SaveButtonMenuAltDefinition.num + 1;
				VT.SaveButtonMenuAltDefinition[VT.SaveButtonMenuAltDefinition.num] = {
					param = { GUID, code, },
				};
			end
		end
		MT._TimerStart(_PerdiocGenerateTitle, 0.5);
		--
		_StorePlayerData();
		local Driver = CreateFrame('FRAME', nil, UIParent);
		Driver:RegisterEvent("CONFIRM_TALENT_WIPE");
		--	Fires when the user selects the "Yes, I do." confirmation prompt after speaking to a class trainer and choosing to unlearn their talents.
		--	Payload	number:cost	number:respecType
		--	inexistent	Driver:RegisterEvent("PLAYER_TALENT_UPDATE");
		--	inexistent	Driver:RegisterEvent("PLAYER_LEARN_TALENT_FAILED");
		--	inexistent	Driver:RegisterEvent("TALENTS_INVOLUNTARILY_RESET");
		--	inexistent	Driver:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");
		Driver:RegisterEvent("CHARACTER_POINTS_CHANGED");
		--	Fired when the player's available talent points change.
		--	Payload	number:change	-1 indicates one used (learning a talent)	1 indicates one gained (leveling)
		--	SPELLS_CHANGED
		--	Fires when spells in the spellbook change in any way. Can be trivial (e.g.: icon changes only), or substantial (e.g.: learning or unlearning spells/skills).
		--	Payload	none
		-- Driver:RegisterEvent("PLAYER_LOGOUT");
		Driver:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
		if DT.BUILD == "WRATH" then
			Driver:RegisterEvent("GLYPH_ADDED");
			Driver:RegisterEvent("GLYPH_REMOVED");
			Driver:RegisterEvent("GLYPH_UPDATED");
		end
		Driver:SetScript("OnEvent", function(Driver, event)
			MT._TimerStart(_StorePlayerData, 0.1, 1);
		end);
	end);


--[[
	do	--	button_on_unitFrame
		local function unitFrameButton_OnEvent(self, event)
			if VT.SET.inspectButtonOnUnitFrame then
				if (MT.InspectButtonKeyFunc and MT.InspectButtonKeyFunc()) and self.unitFrame:IsShown() and UnitIsPlayer(self.unitFrame.unit) then
					--self:Show();
					--self:SetPoint("TOP", self.unitFrame, "TOP");
					self:EnableMouse(true);
					self:SetAlpha(1.0);
				else
					--self:Hide();
					self:EnableMouse(false);
					self:SetAlpha(0.0);
				end
			end
		end
		local temp_unkFrame_id = 1;
		local function hookUnitFrame(unitFrame)
			local unitFrameName = unitFrame:GetName();
			if not unitFrameName or unitFrameName == "" then
				unitFrameName = "UNK" .. temp_unkFrame_id;
			end
			local unitFrameButton = CreateFrame('BUTTON', nil, UIParent);
			unitFrameButton:SetSize(60, 60);
			unitFrameButton:Show();
			unitFrameButton:SetAlpha(0.0);
			unitFrameButton:EnableMouse(false);
			unitFrameButton:SetNormalTexture(TTEXTURESET.INSPECT_BUTTON);
			unitFrameButton:GetNormalTexture():SetVertexColor(TTEXTURESET.INSPECT_BUTTON_COLOR[1], TTEXTURESET.INSPECT_BUTTON_COLOR[2], TTEXTURESET.INSPECT_BUTTON_COLOR[3], TTEXTURESET.INSPECT_BUTTON_COLOR[4]);
			unitFrameButton:SetPushedTexture(TTEXTURESET.INSPECT_BUTTON);
			unitFrameButton:GetPushedTexture():SetVertexColor(TTEXTURESET.INSPECT_BUTTON_COLOR[1], TTEXTURESET.INSPECT_BUTTON_COLOR[2], TTEXTURESET.INSPECT_BUTTON_COLOR[3], TTEXTURESET.INSPECT_BUTTON_COLOR[4]);
			local portrait = _G[unitFrameName .. "Portrait"];
			if portrait then
				unitFrameButton:SetPoint("CENTER", portrait, "CENTER");
			else
				unitFrameButton:SetPoint("TOP", unitFrame, "TOP");
			end
			--	local UnitFrameButtonLabel = unitFrameButton:CreateFontString(unitFrameButton:GetName() .. "Title", "ARTWORK");
			--	local font, size, outline = PlayerFrame.healthbar.TextString:GetFont();
			--	UnitFrameButtonLabel:SetFont(font, 32, "OUTLINE");
			--	UnitFrameButtonLabel:SetPoint("CENTER");
			--	UnitFrameButtonLabel:SetTextColor(0.0, 1.0, 0.0, 1.0);
			--	UnitFrameButtonLabel:SetText("TE");
			--	UnitFrameButtonLabel:Show();
			unitFrameButton:RegisterEvent("MODIFIER_STATE_CHANGED");
			unitFrameButton:SetScript("OnEvent", unitFrameButton_OnEvent);
			unitFrameButton:SetScript("OnUpdate", function(self, elasped)
			end);
			unitFrameButton:SetScript("OnClick", function(self)
				local unit = self.unitFrame.unit;
				unit = unit or 'target';
				if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitFactionGroup(unit) == CT.SELFFACTION then
					local name, realm = UnitName(unit);
					if name then
						MT.SendQueryRequest(name, realm, false, true);
					else
						name, realm = strsplit("-", unit);
						MT.SendQueryRequest(name, realm, false, true);
					end
				end		
			end);
			unitFrameButton.unitFrame = unitFrame;
		end

		C_Timer.After(1.0, function() hookUnitFrame(TargetFrame); end);
	end
	local LootMonitorDriver = {
		Area = {
			[339] = {
				function(Driver)
					Driver.map = 339;
					Driver:RegisterEvent("ENCOUNTER_END");
					Driver:RegisterEvent("BOSS_KILL");
					Driver:RegisterEvent("UPDATE_INSTANCE_INFO");
					--	print("Reg BOSS");
					return Driver:OnEvent("ENCOUNTER_END");
				end,
				function(Driver)
					for instanceIndex = 1, Driver.GetNumSavedInstances() do
						local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = Driver.GetSavedInstanceInfo(instanceIndex);
						if locked and isRaid then
							local inst = Driver.instance_name_hash[name];
							if inst == "BT" then	--	564
								Driver.Instance = "BT";
								Driver.LockedInstanceID = id;
								Driver.Time = time();
								Driver.LockedInstanceKey = CT.SELFREALM .. ":" .. CT.SELFFACTION .. ":" .. "BT:" .. Driver.LockedInstanceID;
								--	local _, _, _8Killed = Driver.GetSavedInstanceEncounterInfo(instanceIndex, 8);
								--	local _, _, _9Killed = Driver.GetSavedInstanceEncounterInfo(instanceIndex, 9);
								--	if _8Killed or _9Killed then
									Driver:RegisterEvent("CHAT_MSG_LOOT");
									Driver:RegisterEvent("LOOT_OPENED");
									--	print("Reg VT.LOOT", _8Killed, _9Killed);
								--	else
									--	Driver:UnregisterEvent("CHAT_MSG_LOOT");
									--	Driver:UnregisterEvent("LOOT_OPENED");
									--	--	print("UnrReg VT.LOOT", _8Killed, _9Killed);
								--	end
								return;
							end
						end
					end
					Driver:UnregisterEvent("CHAT_MSG_LOOT");
					Driver:UnregisterEvent("LOOT_OPENED");
					--	print("UnrReg VT.LOOT", nil, nil);
				end,
				{
					--高阶督军纳因图斯
						[32239] = "1-高阶督军纳因图斯",	--	Slippers of the Seacaller
						[32240] = "1-高阶督军纳因图斯",	--	Guise of the Tidal Lurker
						[32377] = "1-高阶督军纳因图斯",	--	Mantle of Darkness
						[32241] = "1-高阶督军纳因图斯",	--	Helm of Soothing Currents
						[32234] = "1-高阶督军纳因图斯",	--	Fists of Mukoa
						[32242] = "1-高阶督军纳因图斯",	--	Boots of Oceanic Fury
						[32232] = "1-高阶督军纳因图斯",	--	Eternium Shell Bracers
						[32243] = "1-高阶督军纳因图斯",	--	Pearl Inlaid Boots
						[32245] = "1-高阶督军纳因图斯",	--	Tide-stomper's Greaves
						[32238] = "1-高阶督军纳因图斯",	--	Ring of Calming Waves
						[32247] = "1-高阶督军纳因图斯",	--	Ring of Captured Storms
						[32237] = "1-高阶督军纳因图斯",	--	The Maelstrom's Fury
						[32236] = "1-高阶督军纳因图斯",	--	Rising Tide
						[32248] = "1-高阶督军纳因图斯",	--	Halberd of Desolation
					--苏普雷姆斯
						[32256] = "2-苏普雷姆斯",	--	Waistwrap of Infinity
						[32252] = "2-苏普雷姆斯",	--	Nether Shadow Tunic
						[32259] = "2-苏普雷姆斯",	--	Bands of the Coming Storm
						[32251] = "2-苏普雷姆斯",	--	Wraps of Precise Flight
						[32258] = "2-苏普雷姆斯",	--	Naturalist's Preserving Cinch
						[32250] = "2-苏普雷姆斯",	--	Pauldrons of Abyssal Fury
						[32260] = "2-苏普雷姆斯",	--	Choker of Endless Nightmares
						[32261] = "2-苏普雷姆斯",	--	Band of the Abyssal Lord
						[32257] = "2-苏普雷姆斯",	--	Idol of the White Stag
						[32254] = "2-苏普雷姆斯",	--	The Brutalizer
						[32262] = "2-苏普雷姆斯",	--	Syphon of the Nathrezim
						[32255] = "2-苏普雷姆斯",	--	Felstone Bulwark
						[32253] = "2-苏普雷姆斯",	--	Legionkiller
					--阿卡玛之影
						[32273] = "3-阿卡玛之影",	--	Amice of Brilliant Light
						[32270] = "3-阿卡玛之影",	--	Focused Mana Bindings
						[32513] = "3-阿卡玛之影",	--	Wristbands of Divine Influence
						[32265] = "3-阿卡玛之影",	--	Shadow-walker's Cord
						[32271] = "3-阿卡玛之影",	--	Kilt of Immortal Nature
						[32264] = "3-阿卡玛之影",	--	Shoulders of the Hidden Predator
						[32275] = "3-阿卡玛之影",	--	Spiritwalker Gauntlets
						[32276] = "3-阿卡玛之影",	--	Flashfire Girdle
						[32279] = "3-阿卡玛之影",	--	The Seeker's Wristguards
						[32278] = "3-阿卡玛之影",	--	Grips of Silent Justice
						[32263] = "3-阿卡玛之影",	--	Praetorian's Legguards
						[32268] = "3-阿卡玛之影",	--	Myrmidon's Treads
						[32266] = "3-阿卡玛之影",	--	Ring of Deceitful Intent
						[32361] = "3-阿卡玛之影",	--	Blind-Seers Icon
					--塔隆·血魔
						[32323] = "4-塔隆·血魔",	--	Shadowmoon Destroyer's Drape
						[32329] = "4-塔隆·血魔",	--	Cowl of Benevolence
						[32327] = "4-塔隆·血魔",	--	Robe of the Shadow Council
						[32324] = "4-塔隆·血魔",	--	Insidious Bands
						[32328] = "4-塔隆·血魔",	--	Botanist's Gloves of Growth
						[32510] = "4-塔隆·血魔",	--	Softstep Boots of Tracking
						[32280] = "4-塔隆·血魔",	--	Gauntlets of Enforcement
						[32512] = "4-塔隆·血魔",	--	Girdle of Lordaeron's Fallen
						[32330] = "4-塔隆·血魔",	--	Totem of Ancestral Guidance
						[32348] = "4-塔隆·血魔",	--	Soul Cleaver
						[32326] = "4-塔隆·血魔",	--	Twisted Blades of Zarak
						[32325] = "4-塔隆·血魔",	--	Rifle of the Stoic Guardian
					--古尔图格·血沸
						[32337] = "5-古尔图格·血沸",	--	Shroud of Forgiveness
						[32338] = "5-古尔图格·血沸",	--	Blood-cursed Shoulderpads
						[32340] = "5-古尔图格·血沸",	--	Garments of Temperance
						[32339] = "5-古尔图格·血沸",	--	Belt of Primal Majesty
						[32334] = "5-古尔图格·血沸",	--	Vest of Mounting Assault
						[32342] = "5-古尔图格·血沸",	--	Girdle of Mighty Resolve
						[32333] = "5-古尔图格·血沸",	--	Girdle of Stability
						[32341] = "5-古尔图格·血沸",	--	Leggings of Divine Retribution
						[32335] = "5-古尔图格·血沸",	--	Unstoppable Aggressor's Ring
						[32501] = "5-古尔图格·血沸",	--	Shadowmoon Insignia
						[32269] = "5-古尔图格·血沸",	--	Messenger of Fate
						[32344] = "5-古尔图格·血沸",	--	Staff of Immaculate Recovery
						[32343] = "5-古尔图格·血沸",	--	Wand of Prismatic Focus
					--灵魂之匣
						[32353] = "6-灵魂之匣",	--	Gloves of Unfailing Faith
						[32351] = "6-灵魂之匣",	--	Elunite Empowered Bracers
						[32347] = "6-灵魂之匣",	--	Grips of Damnation
						[32352] = "6-灵魂之匣",	--	Naturewarden's Treads
						[32517] = "6-灵魂之匣",	--	The Wavemender's Mantle
						[32346] = "6-灵魂之匣",	--	Boneweave Girdle
						[32354] = "6-灵魂之匣",	--	Crown of Empowered Fate
						[32345] = "6-灵魂之匣",	--	Dreadboots of the Legion
						[32349] = "6-灵魂之匣",	--	Translucent Spellthread Necklace
						[32362] = "6-灵魂之匣",	--	Pendant of Titans
						[32350] = "6-灵魂之匣",	--	Touch of Inspiration
						[32332] = "6-灵魂之匣",	--	Torch of the Damned
						[32363] = "6-灵魂之匣",	--	Naaru-Blessed Life Rod
					--莎赫拉丝主母
						[32367] = "7-莎赫拉丝主母",	--	Leggings of Devastation
						[32366] = "7-莎赫拉丝主母",	--	Shadowmaster's Boots
						[32365] = "7-莎赫拉丝主母",	--	Heartshatter Breastplate
						[32370] = "7-莎赫拉丝主母",	--	Nadina's Pendant of Purity
						[32368] = "7-莎赫拉丝主母",	--	Tome of the Lightbringer
						[32369] = "7-莎赫拉丝主母",	--	Blade of Savagery
						[31101] = "7-莎赫拉丝主母",	--	Pauldrons of the Forgotten Conqueror
						[31103] = "7-莎赫拉丝主母",	--	Pauldrons of the Forgotten Protector
						[31102] = "7-莎赫拉丝主母",	--	Pauldrons of the Forgotten Vanquisher
					--伊利达雷议会
						[32331] = "8-伊利达雷议会",	--	Cloak of the Illidari Council
						[32519] = "8-伊利达雷议会",	--	Belt of Divine Guidance
						[32518] = "8-伊利达雷议会",	--	Veil of Turning Leaves
						[32376] = "8-伊利达雷议会",	--	Forest Prowler's Helm
						[32373] = "8-伊利达雷议会",	--	Helm of the Illidari Shatterer
						[32505] = "8-伊利达雷议会",	--	Madness of the Betrayer
						[31098] = "8-伊利达雷议会",	--	Leggings of the Forgotten Conqueror
						[31100] = "8-伊利达雷议会",	--	Leggings of the Forgotten Protector
						[31099] = "8-伊利达雷议会",	--	Leggings of the Forgotten Vanquisher
					--伊利丹·怒风
						[32524] = "9-伊利丹·怒风",	--	斗篷
						[32525] = "9-伊利丹·怒风",	--	兜帽
						[32235] = "9-伊利丹·怒风",	--	眼罩
						[32521] = "9-伊利丹·怒风",	--	铁壁
						[32497] = "9-伊利丹·怒风",	--	蛋戒
						[32483] = "9-伊利丹·怒风",	--	骨头
						[32496] = "9-伊利丹·怒风",	--	蛋花
						[31089] = "9-伊利丹·怒风",	--	骑牧术
						[31091] = "9-伊利丹·怒风",	--	战猎萨
						[31090] = "9-伊利丹·怒风",	--	贼法德
						[32471] = "9-伊利丹·怒风",	--	蛋匕
						[32500] = "9-伊利丹·怒风",	--	蛋挞
						[32374] = "9-伊利丹·怒风",	--	狗杖
						[32375] = "9-伊利丹·怒风",	--	蛋盾
						[32336] = "9-伊利丹·怒风",	--	黑工
						[32837] = "9-伊利丹·怒风",	--	主手
						[32838] = "9-伊利丹·怒风",	--	副手
					--小怪
						[32590] = "0-小怪",	--	Nethervoid Cloak
						[34012] = "0-小怪",	--	Shroud of the Final Stand
						[32609] = "0-小怪",	--	Boots of the Divine Light
						[32593] = "0-小怪",	--	Treads of the Den Mother
						[32592] = "0-小怪",	--	Chestguard of Relentless Storms
						[32608] = "0-小怪",	--	Pillager's Gauntlets
						[32606] = "0-小怪",	--	Girdle of the Lightbearer
						[32591] = "0-小怪",	--	Choker of Serrated Blades
						[32589] = "0-小怪",	--	Hellfire-Encased Pendant
						[32526] = "0-小怪",	--	Band of Devastation
						[32528] = "0-小怪",	--	Blessed Band of Karabor
						[32527] = "0-小怪",	--	Ring of Ancient Knowledge
						[34009] = "0-小怪",	--	Hammer of Judgement
						[32943] = "0-小怪",	--	Swiftsteel Bludgeon
						[34011] = "0-小怪",	--	Illidari Runeshield
						[32228] = "0-小怪",	--	Empyrean Sapphire
						[32231] = "0-小怪",	--	Pyrestone
						[32229] = "0-小怪",	--	Lionseye
						[32249] = "0-小怪",	--	Seaspray Emerald
						[32230] = "0-小怪",	--	Shadowsong Amethyst
						[32227] = "0-小怪",	--	Crimson Spinel
						[32428] = "0-小怪",	--	Heart of Darkness
						[32897] = "0-小怪",	--	Mark of the Illidari
					--图纸
						[32738] = "0-小怪",	--	Plans: Dawnsteel Bracers
						[32739] = "0-小怪",	--	Plans: Dawnsteel Shoulders
						[32736] = "0-小怪",	--	Plans: Swiftsteel Bracers
						[32737] = "0-小怪",	--	Plans: Swiftsteel Shoulders
						[32748] = "0-小怪",	--	Pattern: Bindings of Lightning Reflexes
						[32744] = "0-小怪",	--	Pattern: Bracers of Renewed Life
						[32750] = "0-小怪",	--	Pattern: Living Earth Bindings
						[32751] = "0-小怪",	--	Pattern: Living Earth Shoulders
						[32749] = "0-小怪",	--	Pattern: Shoulders of Lightning Reflexes
						[32745] = "0-小怪",	--	Pattern: Shoulderpads of Renewed Life
						[32746] = "0-小怪",	--	Pattern: Swiftstrike Bracers
						[32747] = "0-小怪",	--	Pattern: Swiftstrike Shoulders
						[32754] = "0-小怪",	--	Pattern: Bracers of Nimble Thought
						[32755] = "0-小怪",	--	Pattern: Mantle of Nimble Thought
						[32753] = "0-小怪",	--	Pattern: Swiftheal Mantle
						[32752] = "0-小怪",	--	Pattern: Swiftheal Wraps
					--
				},
			},
			[335] = {
				function(Driver)
					Driver.map = 335;
					Driver:RegisterEvent("ENCOUNTER_END");
					Driver:RegisterEvent("BOSS_KILL");
					Driver:RegisterEvent("UPDATE_INSTANCE_INFO");
					--	print("Reg BOSS");
					return Driver:OnEvent("ENCOUNTER_END");
				end,
				function(Driver)
					for instanceIndex = 1, Driver.GetNumSavedInstances() do
						local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = Driver.GetSavedInstanceInfo(instanceIndex);
						if locked and isRaid then
							local inst = Driver.instance_name_hash[name];
							if inst == "SW" then	--	580
								Driver.Instance = "SW";
								Driver.LockedInstanceID = id;
								Driver.Time = time();
								Driver.LockedInstanceKey = CT.SELFREALM .. ":" .. CT.SELFFACTION .. ":" .. "SW:" .. Driver.LockedInstanceID;
								--	local _, _, _5Killed = Driver.GetSavedInstanceEncounterInfo(instanceIndex, 8);
								--	local _, _, _6Killed = Driver.GetSavedInstanceEncounterInfo(instanceIndex, 9);
								--	if _5Killed or _6Killed then
									Driver:RegisterEvent("CHAT_MSG_LOOT");
									Driver:RegisterEvent("LOOT_OPENED");
									--	print("Reg VT.LOOT", _5Killed, _6Killed);
								--	else
									--	Driver:UnregisterEvent("CHAT_MSG_LOOT");
									--	Driver:UnregisterEvent("LOOT_OPENED");
									--	print("UnrReg VT.LOOT", _5Killed, _6Killed);
								--	end
								return;
							end
						end
					end
					Driver:UnregisterEvent("CHAT_MSG_LOOT");
					Driver:UnregisterEvent("LOOT_OPENED");
					--	print("UnrReg VT.LOOT", nil, nil);
				end,
				{
					--卡雷苟斯
						[34170] = "1-卡雷苟斯",	--	Pantaloons of Calming Strife
						--[34386] = "1-卡雷苟斯",	--	Pantaloons of Growing Strife
						[34169] = "1-卡雷苟斯",	--	Breeches of Natural Aggression
						--[34384] = "1-卡雷苟斯",	--	Breeches of Natural Splendor
						[34168] = "1-卡雷苟斯",	--	Starstalker Legguards
						[34167] = "1-卡雷苟斯",	--	Legplates of the Holy Juggernaut
						--[34382] = "1-卡雷苟斯",	--	Judicator's Legguards
						[34166] = "1-卡雷苟斯",	--	Band of Lucent Beams
						[34848] = "1-卡雷苟斯",	--	Bracers of the Forgotten Conqueror
						[34851] = "1-卡雷苟斯",	--	Bracers of the Forgotten Protector
						[34852] = "1-卡雷苟斯",	--	Bracers of the Forgotten Vanquisher
						[34165] = "1-卡雷苟斯",	--	Fang of Kalecgos
						[34164] = "1-卡雷苟斯",	--	Dragonscale-Encrusted Longblade
					--布鲁塔卢斯
						[34181] = "2-布鲁塔卢斯",	--	Leggings of Calamity
						[34180] = "2-布鲁塔卢斯",	--	Felfury Legplates
						--[34381] = "2-布鲁塔卢斯",	--	Felstrength Legplates
						[34178] = "2-布鲁塔卢斯",	--	Collar of the Pit Lord
						[34177] = "2-布鲁塔卢斯",	--	Clutch of Demise
						[34853] = "2-布鲁塔卢斯",	--	Belt of the Forgotten Conqueror
						[34854] = "2-布鲁塔卢斯",	--	Belt of the Forgotten Protector
						[34855] = "2-布鲁塔卢斯",	--	Belt of the Forgotten Vanquisher
						[34176] = "2-布鲁塔卢斯",	--	Reign of Misery
						[34179] = "2-布鲁塔卢斯",	--	Heart of the Pit
					--菲米斯
						[34352] = "3-菲米丝",	--	Borderland Fortress Grips
						[34188] = "3-菲米丝",	--	Leggings of the Immortal Night
						--[34385] = "3-菲米丝",	--	Leggings of the Immortal Beast
						[34186] = "3-菲米丝",	--	Chain Links of the Tumultuous Storm
						--[34383] = "3-菲米丝",	--	Kilt of Spiritual Reconstruction
						[34184] = "3-菲米丝",	--	Brooch of the Highborne
						[34856] = "3-菲米丝",	--	Boots of the Forgotten Conqueror
						[34857] = "3-菲米丝",	--	Boots of the Forgotten Protector
						[34858] = "3-菲米丝",	--	Boots of the Forgotten Vanquisher
						[34182] = "3-菲米丝",	--	Grand Magister's Staff of Torrents
						[34185] = "3-菲米丝",	--	Sword Breaker's Bulwark
					--艾瑞达双子
						[34205] = "4-艾瑞达双子",	--	Shroud of Redeemed Souls
						[34190] = "4-艾瑞达双子",	--	Crimson Paragon's Cover
						[34210] = "4-艾瑞达双子",	--	Amice of the Convoker
						[34202] = "4-艾瑞达双子",	--	Shawl of Wonderment
						--[34393] = "4-艾瑞达双子",	--	Shoulderpads of Knowledge's Pursuit
						[34209] = "4-艾瑞达双子",	--	Spaulders of Reclamation
						--[34391] = "4-艾瑞达双子",	--	Spaulders of Devastation
						[34195] = "4-艾瑞达双子",	--	Shoulderpads of Vehemence
						--[34392] = "4-艾瑞达双子",	--	Demontooth Shoulderpads
						[34194] = "4-艾瑞达双子",	--	Mantle of the Golden Forest
						[34208] = "4-艾瑞达双子",	--	Equilibrium Epaulets
						--[34390] = "4-艾瑞达双子",	--	Erupting Epaulets
						[34192] = "4-艾瑞达双子",	--	Pauldrons of Perseverance
						--[34388] = "4-艾瑞达双子",	--	Pauldrons of Berserking
						[34193] = "4-艾瑞达双子",	--	Spaulders of the Thalassian Savior
						--[34389] = "4-艾瑞达双子",	--	Spaulders of the Thalassian Defender
						[35290] = "4-艾瑞达双子",	--	Sin'dorei Pendant of Conquest
						[35291] = "4-艾瑞达双子",	--	Sin'dorei Pendant of Salvation
						[35292] = "4-艾瑞达双子",	--	Sin'dorei Pendant of Triumph
						[34204] = "4-艾瑞达双子",	--	Amulet of Unfettered Magics
						[34189] = "4-艾瑞达双子",	--	Band of Ruinous Delight
						[34206] = "4-艾瑞达双子",	--	Book of Highborne Hymns
						[34197] = "4-艾瑞达双子",	--	Shiv of Exsanguination
						[34199] = "4-艾瑞达双子",	--	Archon's Gavel
						[34203] = "4-艾瑞达双子",	--	Grip of Mannoroth
						[34198] = "4-艾瑞达双子",	--	Stanchion of Primal Instinct
						[34196] = "4-艾瑞达双子",	--	Golden Bow of Quel'Thalas
					--穆鲁
						[34232] = "5-穆鲁",	--	Fel Conquerer Raiments
						[34233] = "5-穆鲁",	--	Robes of Faltered Light
						--[34399] = "5-穆鲁",	--	Robes of Ghostly Hatred
						[34212] = "5-穆鲁",	--	Sunglow Vest
						--[34398] = "5-穆鲁",	--	Utopian Tunic of Elune
						[34211] = "5-穆鲁",	--	Harness of Carnal Instinct
						--[34397] = "5-穆鲁",	--	Bladed Chaos Tunic
						[34234] = "5-穆鲁",	--	Shadowed Gauntlets of Paroxysm
						--[34408] = "5-穆鲁",	--	Gloves of the Forest Drifter
						[34229] = "5-穆鲁",	--	Garments of Serene Shores
						--[34396] = "5-穆鲁",	--	Garments of Crashing Shores
						[34228] = "5-穆鲁",	--	Vicious Hawkstrider Hauberk
						[34215] = "5-穆鲁",	--	Warharness of Reckless Fury
						--[34394] = "5-穆鲁",	--	Breastplate of Agony's Aversion
						[34240] = "5-穆鲁",	--	Gauntlets of the Soothed Soul
						[34216] = "5-穆鲁",	--	Heroic Judicator's Chestguard
						--[34395] = "5-穆鲁",	--	Noble Judicator's Chestguard
						[34213] = "5-穆鲁",	--	Ring of Hardened Resolve
						[34230] = "5-穆鲁",	--	Ring of Omnipotence
						[35282] = "5-穆鲁",	--	Sin'dorei Band of Dominance
						[35283] = "5-穆鲁",	--	Sin'dorei Band of Salvation
						[35284] = "5-穆鲁",	--	Sin'dorei Band of Triumph
						[34427] = "5-穆鲁",	--	Blackened Naaru Sliver
						[34430] = "5-穆鲁",	--	Glimmering Naaru Sliver
						[34429] = "5-穆鲁",	--	Shifting Naaru Sliver
						[34428] = "5-穆鲁",	--	Steely Naaru Sliver
						[34214] = "5-穆鲁",	--	Muramasa
						[34231] = "5-穆鲁",	--	Aegis of Angelic Fortune
					--基尔加丹
						[34241] = "6-基尔加丹",	--	Cloak of Unforgivable Sin
						[34242] = "6-基尔加丹",	--	Tattered Cape of Antonidas
						[34339] = "6-基尔加丹",	--	Cowl of Light's Purity
						--[34405] = "6-基尔加丹",	--	Helm of Arcane Purity
						[34340] = "6-基尔加丹",	--	Dark Conjuror's Collar
						[34342] = "6-基尔加丹",	--	Handguards of the Dawn
						--[34406] = "6-基尔加丹",	--	Gloves of Tyri's Power
						[34344] = "6-基尔加丹",	--	Handguards of Defiled Worlds
						[34244] = "6-基尔加丹",	--	Duplicitous Guise
						--[34404] = "6-基尔加丹",	--	Mask of the Fury Hunter
						[34245] = "6-基尔加丹",	--	Cover of Ursol the Wise
						--[34403] = "6-基尔加丹",	--	Cover of Ursoc the Mighty
						[34333] = "6-基尔加丹",	--	Coif of Alleria
						[34332] = "6-基尔加丹",	--	Cowl of Gul'dan
						--[34402] = "6-基尔加丹",	--	Shroud of Chieftain Ner'zhul
						[34343] = "6-基尔加丹",	--	Thalassian Ranger Gauntlets
						[34243] = "6-基尔加丹",	--	Helm of Burning Righteousness
						--[34401] = "6-基尔加丹",	--	Helm of Uther's Resolve
						[34345] = "6-基尔加丹",	--	Crown of Anasterian
						--[34400] = "6-基尔加丹",	--	Crown of Dath'Remar
						[34341] = "6-基尔加丹",	--	Borderland Paingrips
						[34334] = "6-基尔加丹",	--	Thori'dal, the Stars' Fury
						[34329] = "6-基尔加丹",	--	Crux of the Apocalypse
						[34247] = "6-基尔加丹",	--	Apolyon, the Soul-Render
						[34335] = "6-基尔加丹",	--	Hammer of Sanctification
						[34331] = "6-基尔加丹",	--	Hand of the Deceiver
						[34336] = "6-基尔加丹",	--	Sunflare
						[34337] = "6-基尔加丹",	--	Golden Staff of the Sin'dorei
					--小怪
						[34351] = "0-小怪",	--	Tranquil Majesty Wraps
						--[34407] = "0-小怪",	--	Tranquil Moonlight Wraps
						[34350] = "0-小怪",	--	Gauntlets of the Ancient Shadowmoon
						--[34409] = "0-小怪",	--	Gauntlets of the Ancient Frostwolf
						[35733] = "0-小怪",	--	Ring of Harmonic Beauty
						[34183] = "0-小怪",	--	Shivering Felspine
						[34346] = "0-小怪",	--	Mounting Vengeance
						[34349] = "0-小怪",	--	Blade of Life's Inevitability
						[34348] = "0-小怪",	--	Wand of Cleansing Light
						[34347] = "0-小怪",	--	Wand of the Demonsoul
						[35273] = "0-小怪",	--	Study of Advanced Smelting
						[34664] = "0-小怪",	--	Sunmote
						[32228] = "0-小怪",	--	Empyrean Sapphire
						[32231] = "0-小怪",	--	Pyrestone
						[32229] = "0-小怪",	--	Lionseye
						[32249] = "0-小怪",	--	Seaspray Emerald
						[32230] = "0-小怪",	--	Shadowsong Amethyst
						[32227] = "0-小怪",	--	Crimson Spinel
						[35208] = "0-小怪",	--	Plans: Sunblessed Gauntlets
						[35210] = "0-小怪",	--	Plans: Sunblessed Breastplate
						[35209] = "0-小怪",	--	Plans: Hard Khorium Battlefists
						[35211] = "0-小怪",	--	Plans: Hard Khorium Battleplate
					--图纸
						[35212] = "0-小怪",	--	Pattern: Leather Gauntlets of the Sun
						[35216] = "0-小怪",	--	Pattern: Leather Chestguard of the Sun
						[35213] = "0-小怪",	--	Pattern: Fletcher's Gloves of the Phoenix
						[35217] = "0-小怪",	--	Pattern: Embrace of the Phoenix
						[35214] = "0-小怪",	--	Pattern: Gloves of Immortal Dusk
						[35218] = "0-小怪",	--	Pattern: Carapace of Sun and Shadow
						[35215] = "0-小怪",	--	Pattern: Sun-Drenched Scale Gloves
						[35219] = "0-小怪",	--	Pattern: Sun-Drenched Scale Chestguard
						[35204] = "0-小怪",	--	Pattern: Sunfire Handwraps
						[35206] = "0-小怪",	--	Pattern: Sunfire Robe
						[35205] = "0-小怪",	--	Pattern: Hands of Eternal Light
						[35207] = "0-小怪",	--	Pattern: Robe of Eternal Light
						[35198] = "0-小怪",	--	Design: Loop of Forged Power
						[35201] = "0-小怪",	--	Design: Pendant of Sunfire
						[35199] = "0-小怪",	--	Design: Ring of Flowing Life
						[35202] = "0-小怪",	--	Design: Amulet of Flowing Life
						[35200] = "0-小怪",	--	Design: Hard Khorium Band
						[35203] = "0-小怪",	--	Design: Hard Khorium Choker
						[35186] = "0-小怪",	--	Schematic: Annihilator Holo-Gogs
						[35187] = "0-小怪",	--	Schematic: Justicebringer 3000 Specs
						[35189] = "0-小怪",	--	Schematic: Powerheal 9000 Lens
						[35190] = "0-小怪",	--	Schematic: Hyper-Magnified Moon Specs
						[35191] = "0-小怪",	--	Schematic: Wonderheal XT68 Shades
						[35192] = "0-小怪",	--	Schematic: Primal-Attuned Goggles
						[35193] = "0-小怪",	--	Schematic: Lightning Etched Specs
						[35194] = "0-小怪",	--	Schematic: Surestrike Goggles v3.0
						[35195] = "0-小怪",	--	Schematic: Mayhem Projection Goggles
						[35196] = "0-小怪",	--	Schematic: Hard Khorium Goggles
						[35197] = "0-小怪",	--	Schematic: Quad Deathblow X44 Goggles
					--
				},
			},
		},
		OnLoad = function(Driver)
			if VT.LOOT._v == nil or VT.LOOT._v < 20220727.0 then
				wipe(VT.LOOT);
				VT.LOOT._v = 20220727.0;
			end
			for map, meta in next, Driver.Area do
				for item, val in next, meta[3] do
					Driver.ValidItem[item] = val;
				end
			end
			Driver:RegisterEvent("ZONE_CHANGED_NEW_AREA");
			Driver:RegisterEvent("ZONE_CHANGED");
			Driver:RegisterEvent("ZONE_CHANGED_INDOORS");
			Driver:RegisterEvent("NEW_WMO_CHUNK");
			Driver:RegisterEvent("PLAYER_ENTERING_WORLD");
			Driver:SetScript("OnEvent", Driver.OnEvent);
			Driver:OnEvent("NOTHING");
		end,
		ValidItem = setmetatable({  }, { __index = function() return true; end }),
		--	ValidItem = {  },
		CreatureLooted = {  },
		GetSavedLockedInstanceID = function(Driver)
			for instanceIndex = 1, Driver.GetNumSavedInstances() do
				local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = Driver.GetSavedInstanceInfo(instanceIndex);
				if locked and isRaid then
					local inst = Driver.instance_name_hash[name];
					if inst == "BT" then	--	564
						return id;
					end
				end
			end
		end,
		CheckItem = function(Driver, item, p)
			item = tonumber(item);
			if item ~= nil and Driver.ValidItem[item] then
				local id = Driver.LockedInstanceKey;
				VT.LOOT[id] = VT.LOOT[id] or {  };
				local V = VT.LOOT[id];
				local N = #V;
				if N == 0 then
					N = 1;
					V[1] = { Instance = Driver.Instance, Time = Driver.Time, };
				else
					local v = V[N];
					if Driver.Time - v.Time > 604800 then
						N = N + 1;
						V[N] = { Instance = Driver.Instance, Time = Driver.Time, };
					end
				end
				V[N][item] = (V[N][item] or 0) + p;
			end
		end,
		OnEvent = function(Driver, event, ...)
			if event == "LOOT_OPENED" then
				for slot = 1, Driver.GetNumLootItems() do
					if LootSlotHasItem(slot) then
						local src = Driver.GetLootSourceInfo(slot);
						--	Creature-0-5002-564-9076-22917-00004FF2A6
						if Driver.CreatureLooted[src] == nil then
							local link = Driver.GetLootSlotLink(slot);
							if link ~= nil then
								local id = strmatch(link, "|Hitem:(%d+):");
								if id ~= nil then
									Driver:CheckItem(id, 1);
								end
							end
						end
					end
				end
				for slot = 1, Driver.GetNumLootItems() do
					if LootSlotHasItem(slot) then
						local src = Driver.GetLootSourceInfo(slot);
						Driver.CreatureLooted[src] = true;
					end
				end
			elseif event == "CHAT_MSG_LOOT" then
				local id = strmatch(..., "|Hitem:(%d+):");
				if id ~= nil then
					Driver:CheckItem(id, 10000);
				end
			elseif event == "ENCOUNTER_END" or event == "BOSS_KILL" or event == "UPDATE_INSTANCE_INFO" then
				local meta = Driver.Area[Driver.map];
				if meta ~= nil then
					return meta[2](Driver);
				end
			else
				local map = Driver.GetBestMapForUnit('player');
				local meta = Driver.Area[map];
				--	print("Map", map, meta, Driver.map);
				if meta ~= nil then
					if map ~= Driver.map then
						Driver.map = map;
						return meta[1](Driver);
					end
				else
					Driver.map = nil;
					Driver:UnregisterEvent("ENCOUNTER_END");
					Driver:UnregisterEvent("BOSS_KILL");
					Driver:UnregisterEvent("UPDATE_INSTANCE_INFO");
					Driver:UnregisterEvent("CHAT_MSG_LOOT");
					Driver:UnregisterEvent("LOOT_OPENED");
					--	print("Unreg BOSS & VT.LOOT");
				end
			end
		end,
		GetLootSourceInfo = _G.GetLootSourceInfo,
		GetNumLootItems = _G.GetNumLootItems,
		LootSlotHasItem = _G.LootSlotHasItem,
		GetLootSlotInfo = _G.GetLootSlotInfo,
		GetLootSlotLink = _G.GetLootSlotLink,
		GetNumSavedInstances = _G.GetNumSavedInstances,
		GetSavedInstanceInfo = _G.GetSavedInstanceInfo,
		GetSavedInstanceEncounterInfo = _G.GetSavedInstanceEncounterInfo,
		GetBestMapForUnit = _G.C_Map.GetBestMapForUnit,
		instance_name_hash = __ala_meta__.__raidlib.__raid_meta.hash,
	};
	function NS.InitLootMonitor()
		local Driver = CreateFrame('FRAME');
		for method, func in next, LootMonitorDriver do
			Driver[method] = func;
		end
		NS.LootMonitorDriver = Driver;
		return Driver:OnLoad();
	end
	do	--	dev
		function NS.display_pack(meta)
			local info = __emulib.DecodeAddonPackData(meta or nil);
			if info then
				print("Packed: ", info);
			else
				print("Packed: |cffff0000none|r")
			end
		end
		--
		do	--	QUERY GUILD OR GROUP
			local function display(result)
				print("------------");
				local total = 0;
				for i = 1, #__emulib.KnownAddOnPacks do
					if result[i] > 0 then
						print(__emulib.KnownAddOnPacks[i], result[i]);
						total = total + result[i];
					end
				end
				if result[0] > 0 then
					print("OTHER", result[0]);
					total = total + result[0];
				end
				print("TOTAL", total);
			end
			local function do_check(cache, result, timer, call)
				if #cache > 0 then
					if time() - timer < 4 then
						for _, name in inext, cache, 0 do
							if not VT.TQueryCache[name] then
								C_Timer.After(1.0, call);
								print("Querying", timer + 4 - time());
								return;
							end
						end
					end
					for i = 0, #__emulib.KnownAddOnPacks do
						result[i] = 0;
					end
					for _, name in inext, cache, 0 do
						local meta = VT.TQueryCache[name];
						if meta then
							local pack = tonumber(meta.pack);
							if pack then
								local index = #__emulib.KnownAddOnPacks - 1;
								local magic = 2 ^ index;
								while magic >= 1 do
									if pack >= magic then
										result[index + 1] = result[index + 1] + 1;
										pack = pack - magic;
									end
									magic = magic / 2;
									index = index - 1;
								end
							elseif strsub(meta.pack, 1, 2) == "a`" then
								local hasone = false;
								local list = { strsplit("`", strsub(meta.pack, 2)) };
								for _, v in next, list do
									local addon, enabled, loaded = strsplit("~", v);
									addon = tonumber(addon);
									if addon ~= nil then
										hasone = true;
										if loaded == "1" then
											result[addon] = result[addon] + 1;
										end
									end
								end
								if not hasone then
									result[0] = result[0] + 1;
								end
							else
								result[0] = result[0] + 1;
							end
						end
					end
					display(result);
				end
			end
			do
				local cache = {  };
				local result = {  };
				local timer = 0;
				local function check()
					do_check(cache, result, timer, check);
				end
				function NS.EX_QUERY_GUILD()
					local num_total, num_online, num_online_and_mobile = GetNumGuildMembers();
					if num_online > 0 then
						wipe(cache);
						for i = 1, num_total do
							local name, _, _, _, _, _, _, _, online = GetGuildRosterInfo(i);
							if online then
								tinsert(cache, MT.SendQueryRequest(name, nil, false, false));
							end
						end
						timer = time();
						C_Timer.After(1.0, check);
						print("Querying", 4);
					end
				end
			end
			--------	/run __ala_meta__.emu.EX_QUERY_GUILD()
			do
				local cache = {  };
				local result = {  };
				local timer = 0;
				local function check()
					do_check(cache, result, timer, check);
				end
				function NS.EX_QUERY_GROUP()
					if GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) > 0 or GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE) > 0 then
						wipe(cache);
						for i = 1, MAX_RAID_MEMBERS do
							local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i);
							if name and online then
								tinsert(cache, MT.SendQueryRequest(name, nil, false, false));
							end
						end
						timer = time();
						C_Timer.After(1.0, check);
						print("Querying", 4);
					end
				end
			end
			--------	/run __ala_meta__.emu.EX_QUERY_GROUP()
		end
		--
	end
--]]

-->
