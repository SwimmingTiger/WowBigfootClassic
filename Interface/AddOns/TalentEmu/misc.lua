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
	local l10n = CT.l10n;

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
			l10n.PopupQuery,
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
					button:SetText(l10n.TalentFrameCallButtonString);
					button:SetScript("OnClick", function() MT.CreateEmulator(); end);
					button:SetScript("OnEnter", MT.GeneralOnEnter);
					button:SetScript("OnLeave", MT.GeneralOnLeave);
					button.information = l10n.TalentFrameCallButton;
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
					button:SetText(l10n.TalentFrameCallButtonString);
					button:SetScript("OnClick", function() MT.CreateEmulator(); end);
					button:SetScript("OnEnter", MT.GeneralOnEnter);
					button:SetScript("OnLeave", MT.GeneralOnLeave);
					button.information = l10n.TalentFrameCallButton;
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
					Def.param[3] = name;
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
		if CT.BUILD == "WRATH" then
			VT.VAR[CT.SELFGUID] = VT.__emulib.EncodePlayerTalentDataV2() .. VT.__emulib.EncodePlayerGlyphDataV2() .. VT.__emulib.EncodePlayerEquipmentDataV2();
		else
			VT.VAR[CT.SELFGUID] = VT.__emulib.EncodePlayerTalentDataV2() .. VT.__emulib.EncodePlayerEquipmentDataV2();
		end
		for index = 1, VT.SaveButtonMenuAltDefinition.num do
			if VT.SaveButtonMenuAltDefinition[index].param[1] == CT.SELFGUID then
				VT.SaveButtonMenuAltDefinition[index].param[2] = VT.VAR[CT.SELFGUID];
			end
		end
		MT.Debug("StorePlayerData");
	end
	MT.RegisterOnInit('MISC', function(LoggedIn)
	end);
	MT.RegisterOnLogin('MISC', function(LoggedIn)
		if CT.BUILD == "WRATH" then
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
		Driver:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
		Driver:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", 'player');
		-- Driver:RegisterEvent("PLAYER_LOGOUT");
		if CT.BUILD == "WRATH" then
			Driver:RegisterEvent("GLYPH_ADDED");
			Driver:RegisterEvent("GLYPH_REMOVED");
			Driver:RegisterEvent("GLYPH_UPDATED");
		end
		Driver:SetScript("OnEvent", function(Driver, event)
			MT._TimerStart(_StorePlayerData, 0.1, 1);
		end);
	end);

-->
