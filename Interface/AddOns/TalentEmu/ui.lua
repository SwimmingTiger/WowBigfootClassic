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
	local type = type;
	local next = next;
	local select = select;
	local wipe, tinsert, tremove = table.wipe, table.insert, table.remove;
	local strsplit, strsub, strupper, strmatch, format, gsub = string.split, string.sub, string.upper, string.match, string.format, string.gsub;
	local tostring, tonumber = tostring, tonumber;
	local min, max, floor, random = math.min, math.max, math.floor, math.random;
	local sin360, cos360 = sin, cos;
	local UnitLevel = UnitLevel;
	local GetItemInfo = GetItemInfo;
	local GetSpellInfo = GetSpellInfo;
	local FindSpellBookSlotBySpellID, PickupSpell = FindSpellBookSlotBySpellID, PickupSpell;
	local IsControlKeyDown = IsControlKeyDown;
	local IsAltKeyDown = IsAltKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local GetMouseFocus = GetMouseFocus;
	local GetCursorPosition = GetCursorPosition;
	local _G = _G;
	local DressUpItemLink = DressUpItemLink;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local UIParent = UIParent;
	local GameTooltip = GameTooltip;
	local GameFontNormal = GameFontNormal;
	local GameFontHighlight = GameFontHighlight;
	local GameFontHighlightSmall = GameFontHighlightSmall;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS;
	local StaticPopupDialogs = StaticPopupDialogs;
	local StaticPopup_Show = StaticPopup_Show;
	local MAJOR_GLYPH, MINOR_GLYPH = MAJOR_GLYPH, MINOR_GLYPH;

-->
	local l10n = CT.l10n;

-->		constant
	local TUISTYLE = {
		FrameBorderSize = 8,

		FrameXSizeMin_Style1 = 250,
		FrameYSizeMin_Style1 = 165,
		FrameXSizeMin_Style2 = 100,
		FrameYSizeMin_Style2 = 180,
		FrameHeaderYSize = 20,
		FrameFooterYSize = 24,

		FrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		FrameFontSize = 16,
		FrameFontSizeMid = 14,
		FrameFontSizeSmall = 12,
		FrameFontOutline = "NORMAL",

		TreeFrameXToBorder = 4,
		TreeFrameYToBorder = 0,
		TreeFrameHeaderYSize = 0,
		TreeFrameFooterYSize = 20,
		TreeFrameSeqWidth = 1,
		TreeNodeSize = 42,
		TreeNodeXGap = 12,
		TreeNodeYGap = 12,
		TreeNodeXToBorder = 14,
		TreeNodeYToTop = 12,
		TreeNodeYToBottom = 10,
		TreeNodeFont = NumberFont_Shadow_Med:GetFont(),--=[[Fonts\ARHei.ttf]]--[[Fonts\FRIZQT__.TTF]],
		TreeNodeFontSize = 16,
		TreeNodeFontOutline = "NORMAL",

		TalentDepArrowXSize = 16,
		TalentDepArrowYSize = 20,
		TalentDepBranchXSize = 8,

		SpellListFrameXSize = 200,
		SpellListFrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		SpellListFrameFontSize = 14,
		SpellListFrameFontOutline = "NORMAL",
		SpellListFrameXToBorder = 4,
		SpellListFrameYToTop = 32,
		SpellListFrameYToBottom = 32,
		SpellListNodeHeight = 24;

		EquipmentFrameXSize = CT.BUILD == "CLASSIC" and 280 or 340;
		EquipmentNodeSize = 38;
		EquipmentNodeGap = 6;
		EquipmentNodeXToBorder = 8;
		EquipmentNodeYToBorder = 8;
		EquipmentNodeTextGap = 4;

		GlyphFrameSize = 200,
		MajorGlyphNodeSize = 64,
		MinorGlyphNodeSize = 48,

		ControlButtonSize = 18,
		SideButtonSize = 28,
		SideButtonGap = 2,
		EditBoxXSize = 240,
		EditBoxYSize = 32,
		CurClassIndicatorSize = 36,

		TreeButtonXSize = 68,
		TreeButtonYSize = 18,
		TreeButtonGap = 10,
		TreeButtonTexCoord = { 0.05, 0.95, 0.40, 0.70, },

		IconTextDisabledColor = { 1.0, 1.0, 1.0, 1.0, },
		IconTextAvailableColor = { 0.0, 1.0, 0.0, 1.0, },
		IconTextMaxRankColor = { 1.0, 1.0, 0.0, 1.0, },
		IconToolTipCurRankColor = { 0.0, 1.0, 0.0, 1.0, },
		IconToolTipNextRankColor = { 0.0, 0.5, 1.0, 1.0, },
		IconToolTipNextRankDisabledColor = { 1.0, 0.0, 0.0, 1.0, },
		IconToolTipMaxRankColor = { 1.0, 0.5, 0.0, 1.0, },

	};
	local TTEXTURESET = {
		LIBDBICON = CT.TEXTUREICON,
		UNK = CT.TEXTUREUNK,
		SQUARE_HIGHLIGHT = CT.TEXTUREPATH .. [[CheckButtonHilight]],
		NORMAL_HIGHLIGHT = CT.TEXTUREPATH .. [[UI-Panel-MinimizeButton-Highlight]],
		SEP_HORIZONTAL = CT.TEXTUREPATH .. [[UI-ChatFrame-BorderLeft]],
		SEP_HORIZONTAL_COORD = { 0.25, 0.3125, 0.0, 1.0, },
		SEP_VERTICAL = CT.TEXTUREPATH .. [[UI-ChatFrame-BorderTop]],
		SEP_VERTICAL_COORD = { 0.0, 1.0, 0.25, 0.3125, },
		CONTROL_NORMAL_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		CONTROL_PUSHED_COLOR = { 0.5, 0.5, 0.5, 1.0, },
		CONTROL_DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
		CONTROL_HIGHLIGHT_COLOR = { 0.25, 0.25, 0.5, 0.5, },

		ARROW = CT.TEXTUREPATH .. [[UI-TalentArrows]],
		ARROW_COORD = {
			[1] = {  8 / 64, 24 / 64, 40 / 64, 56 / 64, },	--vertical disable
			[2] = {  8 / 64, 24 / 64, 08 / 64, 26 / 64, },	--vertical enable
			[3] = { 40 / 64, 56 / 64, 40 / 64, 56 / 64, },	--horizontal disable
			[4] = { 40 / 64, 56 / 64,  8 / 64, 24 / 64, },	--horizontal enable
		},
		BRANCH = CT.TEXTUREPATH .. [[UI-TalentBranches]],
		BRANCH_COORD = {
			[1] = { 44 / 256, 54 / 256, 0.5, 1.0, },		--vertical disable
			[2] = { 44 / 256, 54 / 256, 0.0, 0.5, },		--vertical enable
			[3] = { 66 / 256, 98 / 256, 43 / 64, 53 / 64, },--horizontal disable
			[4] = { 66 / 256, 98 / 256, 11 / 64, 21 / 64, },--horizontal enable
			[5] = { 143 / 256, 153 / 256, 43 / 64, 53 / 64, },
			[6] = { 143 / 256, 153 / 256, 11 / 64, 21 / 64, },
		},

		ICON_BG = [[Interface\GMChatFrame\UI-GMStatusFrame-Pulse]],
		ICON_BG_COORD = { 16 / 256, 240 / 256, 20 / 128, 108 / 128, },
		ICON_LIGHT_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		ICON_UNLIGHT_COLOR = { 0.250, 0.250, 0.250, 1.0, },
		ICON_HIGHLIGHT_COORD = { 0.08, 0.92, 0.08, 0.92, },
		ICON_HIGHLIGHT_COLOR = { 0.0, 1.0, 1.0, },
		ICON_NECESSARY = CT.TEXTUREPATH .. [[ReadyCheck-Ready]],
		ICON_FORBIDDEN = CT.TEXTUREPATH .. [[ReadyCheck-NotReady]],

		TALENT_RESET_BG = CT.TEXTUREPATH .. [[Arcane_Circular_Frame]],
		TALENT_RESET_BG_COORD = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },
		TALENT_RESET_BG_COLOR = { 0.25, 0.25, 0.25, },
		TALENT_RESET_HIGHLIGHT = CT.TEXTUREPATH .. [[Arcane_Circular_Flash]],
		TALENT_RESET_HIGHLIGHT_COORD = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },

		LOCK = [[Interface\Buttons\UI-OptionsButton]],	--CT.TEXTUREPATH .. [[Config]],
		LOCK_NORMAL_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		LOCK_LOCKED_COLOR = { 0.5, 0.5, 0.5, 1.0, },
		LOCK_UNLOCKED_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		CLOSE = CT.TEXTUREPATH .. [[Close]],
		CLOSE_COORD = { 0.0, 1.0, 0.0, 1.0, },
		CLOSE_NORMAL_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		RESET = CT.TEXTUREPATH .. [[CharacterUndelete]],
		RESET_COORD = { 7 / 32, 25 / 32, 7 / 32, 25 / 32, },
		DROP = CT.TEXTUREPATH .. [[ArrowDown]],
		SPEC_NORMAL_COLOR = { 1.0, 1.0, 1.0, 0.5 },
		SPEC_PUSHED_COLOR = { 1.0, 1.0, 1.0, 0.25 },
		SPEC_INDICATOR_COORD = { 0.10, 0.90, 0.08, 0.92, },
		SPEC_INDICATOR_COLOR = { 0.0, 1.0, 1.0, },

		SPELLTAB = CT.TEXTUREPATH .. [[UI-MicroButton-EJ-UP]],
		SPELLTAB_COORD = { 3 / 32, 29 / 32, 31 / 64, 57 / 64 },
		APPLY = CT.TEXTUREPATH .. [[ReadyCheck-Ready]],
		IMPORT = CT.TEXTUREPATH .. [[Vehicle-AllianceMagePortal]],
		IMPORT_COORD = { 5 / 32, 27 / 32, 5 / 32, 27 / 32, },
		EXPORT = CT.TEXTUREPATH .. [[Vehicle-HordeMagePortal]],
		EXPORT_COORD = { 6 / 32, 28 / 32, 5 / 32, 27 / 32, },
		SAVE = CT.TEXTUREPATH .. [[Save]],
		SEND = CT.TEXTUREPATH .. [[UI-ChatIcon-Share]],
		EDIT_OK = [[Interface\Buttons\UI-Checkbox-Check]],

		CLASS = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
		CLASS_HIGHLIGHT = CT.TEXTUREPATH .. [[UI-Calendar-Button-Glow]],
		CLASS_HIGHLIGHT_COORD = { 6 / 64, 57 / 64, 6 / 64, 57 / 64, },
		CLASS_HIGHLIGHT_COLOR = { 0.0, 1.0, 0.0, 1.0, },
		CLASS_INDICATOR = CT.TEXTUREPATH .. [[EventNotificationGlow]],
		CLASS_INDICATOR_COORD = { 4 / 64, 60 / 64, 5 / 64, 61 / 64, },
		CLASS_INDICATOR_COLOR = { 0.0, 1.0, 0.0, 1.0, },

		EQUIPMENT_TEXTURE = [[Interface\Buttons\Spell-Reset]];
		EQUIPMENT_TEXTURE_COORD = { 6 / 64, 58 / 64, 6 / 64, 58 / 64, };
		EQUIPMENT_GLOW = [[Interface\Buttons\UI-ActionButton-Border]];
		EQUIPMENT_GLOW_COORD = { 0.25, 0.75, 0.25, 0.75, };
		EQUIPMENT_HIGHLIGHT = [[Interface\Buttons\ActionbarFlyoutButton-FlyoutMidLeft]];
		EQUIPMENT_HIGHLIGHT_COORD = { 8 / 32, 24 / 32, 8 / 64, 24 / 64, };
		EQUIPMENT_EMPTY = {
			[0] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Ammo]],
			[1] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Head]],
			[2] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Neck]],
			[3] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Shoulder]],
			[4] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Shirt]],
			[5] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Chest]],
			[6] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Waist]],
			[7] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Legs]],
			[8] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Feet]],
			[9] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Wrists]],
			[10] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Hands]],
			[11] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Finger]],
			[12] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Rfinger]],
			[13] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Trinket]],
			[14] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Trinket]],
			[15] = [[Interface\Paperdoll\UI-Backpack-EmptySlot]],
			[16] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Mainhand]],
			[17] = [[Interface\Paperdoll\UI-PaperDoll-Slot-SecondaryHand]],
			[18] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Ranged]],
			[19] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Tabard]],
		};
	};

-->
MT.BuildEnv('UI');
-->		predef
-->		UI
	--[==[	Frame Definition
		Frame
					initialized		(bool)
					style			(num(identify))
					CurTreeIndex	(num)
					ClassTDB		(table)
					class			(string)
					level			(num)
					TotalUsedPoints	(num)
					TotalAvailablePoints	(num)
					data			(string)
					readOnly		(bool)
					name			(string)
					TreeButtonsBar					CurTreeIndicator	(texture)
					TreeButtons[]	(frame table)
					TreeFrames[]	(frame table)
													id					(identify)
													TreeNodes			(frame)
																					id					(identify)
																					MaxVal				(fontString)
																					MinVal				(fontString)
																					Split				(fontString)
																					active				(bool)
																					TalentSeq				(num)
													HSeq				(texture)
													VSep				(texture)
													TalentSet			(table)
																					total
																					CountByTier			(num table)
																					TopCheckedTier		(num)
																					TopAvailableTier	(num)
													DependArrows		(table)
																					coordFamily			(num(identify))
													NodeDependArrows	(table-table)
													TreeTDB				(table)
	--]==]
	--
		function MT.UI.FrameSetName(Frame, name)				--	NAME CHANGED HERE ONLY	--	and MT.UI.FrameUpdateLabelText
			Frame.name = name;
			if name ~= nil then
				local cache = VT.TQueryCache[name];
				local objects = Frame.objects;
				objects.Name:SetText(name);
				if VT.SET.supreme and cache ~= nil and cache.PakData[1] ~= nil then
					local _, info = VT.__emulib.DecodeAddOnPackData(cache.PakData[1]);
					if info then
						objects.PackLabel:SetText(info);
						objects.PackLabel:Show();
					else
						objects.PackLabel:Hide();
					end
				else
					objects.PackLabel:Hide();
				end
				objects.ResetToEmuButton:Show();
				objects.ResetToSetButton:Hide();
				local ClassButtons = Frame.ClassButtons;
				for index = 1, #DT.IndexToClass do
					ClassButtons[index]:Hide();
				end
				objects.CurClassIndicator:Hide();
				local TreeFrames = Frame.TreeFrames;
				for TreeIndex = 1, 3 do
					wipe(TreeFrames[TreeIndex].TalentChanged);
				end
				if name ~= l10n.message then
					MT.UI.FrameSetBinding(Frame, name);
					if cache == nil or cache.EquData.Tick == nil then
						Frame.objects.EquipmentFrameButton:Hide();
						Frame.EquipmentFrameContainer:Hide();
						MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
					else
						Frame.objects.EquipmentFrameButton:Show();
					end
				else
					Frame.objects.EquipmentFrameButton:Hide();
					Frame.EquipmentFrameContainer:Hide();
					MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
				end
			else
				local objects = Frame.objects;
				objects.Name:SetText(l10n.Emu);
				objects.PackLabel:Hide();
				objects.ResetToEmuButton:Hide();
				objects.ResetToSetButton:Hide();
				local ClassButtons = Frame.ClassButtons;
				for index = 1, #DT.IndexToClass do
					ClassButtons[index]:Show();
				end
				objects.CurClassIndicator:Show();
				objects.CurClassIndicator:ClearAllPoints();
				objects.CurClassIndicator:SetPoint("CENTER", ClassButtons[DT.ClassToIndex[Frame.class]]);
				MT.UI.FrameReleaseBinding(Frame);
				Frame.objects.EquipmentFrameButton:Hide();
				Frame.EquipmentFrameContainer:Hide();
				MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
			end
		end
		function MT.UI.FrameSetLevel(Frame, level)				--	LEVEL CHANGED HERE ONLY
			if level == nil then
				Frame.level = DT.MAX_LEVEL;
				Frame.TotalUsedPoints = 0;
				Frame.TotalAvailablePoints = MT.GetLevelAvailablePoints(DT.MAX_LEVEL);
			else
				if type(level) == 'string' then
					level = tonumber(level);
				end
				Frame.level = level;
				Frame.TotalAvailablePoints = MT.GetLevelAvailablePoints(level);
			end
		end
		function MT.UI.FrameSetClass(Frame, class)				--	CLASS CHANGED HERE ONLY
			if class == nil then
				Frame.class = nil;
				Frame.ClassTDB = nil;
				Frame.initialized = false;
				Frame.objects.Name:SetTextColor(1.0, 1.0, 1.0, 1.0);
				Frame.objects.Label:SetTextColor(1.0, 1.0, 1.0, 1.0);
			else
				--	check class value
					local Type = type(class);
					if Type == 'number' then
						if DT.IndexToClass[class] == nil then
							MT.Debug("MT.UI.FrameSetClass", 1, "class", "number", class);
							return false;
						end
						class = DT.IndexToClass[class];
					elseif Type == 'table' then
						class = class.class;
						Type = type(class);
						if Type == 'number' then
							if DT.IndexToClass[class] == nil then
								MT.Debug("MT.UI.FrameSetClass", 2, "class", "table", "number", class);
								return false;
							end
							class = DT.IndexToClass[class];
						elseif Type ~= 'string' then
							MT.Debug("MT.UI.FrameSetClass", 3, "class", "table", Type, class);
							return false;
						else
							class = strupper(class);
							if DT.ClassToIndex[class] == nil then
								MT.Debug("MT.UI.FrameSetClass", 4, "class", "table", "string", class);
								return false;
							end
						end
					elseif Type == 'string' then
						class = strupper(class);
						if DT.ClassToIndex[class] == nil then
							local index = tonumber(class);
							if index ~= nil then
								class = DT.IndexToClass[index];
								if class == nil then
									MT.Debug("MT.UI.FrameSetClass", 5, "class", "string", index);
									return false;
								end
							end
						end
					else
						MT.Debug("MT.UI.FrameSetClass", 6, "class", Type);
						return false;
					end
				--

				local SpecList = DT.ClassSpec[class];
				if SpecList == nil then
					MT.Debug("MT.UI.FrameSetClass", 7, class, "SpecList == nil");
					return false;
				end
				local ClassTDB = DT.TalentDB[class];
				if ClassTDB == nil then
					MT.Debug("MT.UI.FrameSetClass", 8, class, "ClassTDB == nil");
					return false;
				end
				local TreeFrames = Frame.TreeFrames;
				local TreeButtons = Frame.TreeButtons;
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local SpecID = SpecList[TreeIndex];
					local TreeTDB = ClassTDB[SpecID];
					TreeFrame.SpecID = SpecID;

					local SpecTexture = DT.TalentSpecIcon[SpecID];
					local TreeButton = TreeButtons[TreeIndex];
					if SpecTexture ~= nil then
						TreeButton:SetNormalTexture(SpecTexture);
						TreeButton:SetPushedTexture(SpecTexture);
						TreeButton.information = l10n.DATA[SpecID];
						TreeButton.Title:SetText(l10n.DATA[SpecID]);
					else
						TreeButton:SetNormalTexture(TTEXTURESET.UNK);
						TreeButton:SetPushedTexture(TTEXTURESET.UNK);
					end
					TreeFrame.BG:SetTexture(DT.SpecBG[SpecID]);
					TreeFrame.TreeLabel:SetText(l10n.DATA[SpecID]);
					for TalentSeq = 1, #TreeTDB do
						local TalentDef = TreeTDB[TalentSeq];
						local Node = TreeNodes[TalentDef[10]];
						Node.TalentSeq = TalentSeq;
						Node:Show();
						local _, _, texture = GetSpellInfo(TalentDef[8][1]);
						if texture ~= nil then
							Node:SetNormalTexture(texture);
							Node:SetPushedTexture(texture);
						elseif TalentDef[9] ~= nil then
							Node:SetNormalTexture(TalentDef[9]);
							Node:SetPushedTexture(TalentDef[9]);
						else
							Node:SetNormalTexture(TTEXTURESET.UNK);
							Node:SetPushedTexture(TTEXTURESET.UNK);
						end
						Node.MaxVal:SetText(TalentDef[4]);
						Node.CurVal:SetText("0");

						local DepTSeq = TalentDef[11];
						if DepTSeq ~= nil then
							local Arrow = MT.UI.DependArrowGet(TreeFrame);
							MT.UI.DependArrowSet(Arrow, TalentDef[1] - TalentDef[5], TalentDef[2] - TalentDef[6], false, Node, TreeNodes[TreeTDB[DepTSeq][10]]);
							local DepArrows = TreeFrame.NodeDependArrows[DepTSeq];
							DepArrows[#DepArrows + 1] = Arrow;
						end

						if TalentDef[1] == 0 then
							if TalentDef[5] == nil then
								MT.UI.TreeNodeActivate(Node);
							end
						end
					end
					TreeFrame.TreeTDB = TreeTDB;
				end

				local color = RAID_CLASS_COLORS[class];
				Frame.objects.Name:SetTextColor(color.r, color.g, color.b, 1.0);
				Frame.objects.Label:SetTextColor(color.r, color.g, color.b, 1.0);
				Frame.BG:SetTexture(DT.ClassBG[class][random(1, #DT.ClassBG[class])]);

				Frame.class = class;
				Frame.ClassTDB = ClassTDB;
				Frame.initialized = true;

				if CT.SELFCLASS == class then
					Frame.ApplyTalentsButton:Show();
				else
					Frame.ApplyTalentsButton:Hide();
				end

				MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, class, MT.GetPointsReqLevel(Frame.TotalUsedPoints));
			end

			return true;
		end
		function MT.UI.FrameSetTalent(Frame, TalData, activeGroup)	--	TALENTDATA CHANGED HERE ONLY
			if TalData == nil or TalData == "" then
				Frame.TalData = nil;
				local Points = Frame.objects.Name.Points1;
				Frame.objects.Name:ClearAllPoints();
				Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
				Frame.label = nil;
				Frame.objects.Label:Hide();
				Frame.objects.ResetToSetButton:ClearAllPoints();
				Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Name, "RIGHT", 0, 0);
				Frame.objects.TalentGroupSelect:Hide();
			else
				--	check point value
					if not Frame.initialized then
						MT.Debug("MT.UI.FrameSetTalent", 1, "not initialized");
						return false;
					end
					if type(TalData) ~= 'table' then
						MT.Debug("MT.UI.FrameSetTalent", 2, type(TalData));
						return false;
					end
					if TalData[1] ~= "" and tonumber(TalData[1]) == nil then
						MT.Debug("MT.UI.FrameSetTalent", 3, TalData);
						return false;
					end
				--

				Frame.TalData = TalData;
				Frame.activeGroup = activeGroup or TalData.active or 1;

				local seldata = TalData[Frame.activeGroup];
				local TreeFrames = Frame.TreeFrames;
				local len = #seldata;
				local pos = 1;
				local offset = 0;
				for TreeIndex = 1, 3 do
					if pos > len then
						break;
					end
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local TreeTDB = TreeFrame.TreeTDB;
					local TalentSet = TreeFrame.TalentSet;
					for TalentSeq = 1, #TreeTDB do
						if pos > len then
							break;
						end
						local val = strsub(seldata, pos, pos);
						val = tonumber(val);
						if val ~= 0 then
							local TalentDef = TreeTDB[TalentSeq];
							local DepTSeq = TalentDef[11];
							if DepTSeq ~= nil and DepTSeq <= len then
								local depval = strsub(seldata, offset + DepTSeq, offset + DepTSeq);
								if depval ~= "0" then
									depval = tonumber(depval);
									local deppts = depval - TalentSet[DepTSeq];
									if deppts > 0 then
										MT.UI.TreeNodeChangePoint(TreeNodes[TreeTDB[DepTSeq][10]], deppts);
									end
								end
							end
							local pts = val - TalentSet[TalentSeq];
							if pts > 0 then
								local ret = MT.UI.TreeNodeChangePoint(TreeNodes[TalentDef[10]], pts);
								if ret < 0 then
									MT.Debug("MT.UI.FrameSetTalent", 4, ret, "tab", TreeIndex, "tier", TalentDef[1], "col", TalentDef[2], "maxPoints", TalentDef[4], "set", val, TalentDef, pos);
								elseif ret > 0 then
									MT.Debug("MT.UI.FrameSetTalent", 5, ret, "tab", TreeIndex, "tier", TalentDef[1], "col", TalentDef[2], "maxPoints", TalentDef[4], "set", val, TalentDef, pos);
								end
							end
						end
						pos = pos + 1;
					end
					offset = pos;
				end

				if TalData.num > 1 then
					local Points = Frame.objects.Name.Points2;
					Frame.objects.Name:ClearAllPoints();
					Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
					local val = TalData[Frame.activeGroup];
					local stats = MT.CountTreePoints(val, Frame.class);
					Frame.label = stats[1] .. "-" .. stats[2] .. "-" .. stats[3];
					Frame.objects.Label:SetText(Frame.label);
					Frame.objects.Label:Show();
					Frame.objects.ResetToSetButton:ClearAllPoints();
					Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Label, "RIGHT", 0, 0);
					Frame.objects.TalentGroupSelect:Show();
				else
					local Points = Frame.objects.Name.Points1;
					Frame.objects.Name:ClearAllPoints();
					Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
					Frame.label = nil;
					Frame.objects.Label:Hide();
					Frame.objects.ResetToSetButton:ClearAllPoints();
					Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Name, "RIGHT", 0, 0);
					Frame.objects.TalentGroupSelect:Hide();
				end
			end

			return true;
		end
		function MT.UI.FrameSetReadOnly(Frame, readOnly)		--	READONLY CHANGED HERE ONLY	--	DISABLED, ALWAYS FALSE
			readOnly = false;
			if Frame.readOnly == readOnly then
				return;
			end
			Frame.readOnly = readOnly;
			local objects = Frame.objects;
			if readOnly then
				objects.ReadOnlyButton:GetNormalTexture():SetVertexColor(TTEXTURESET.LOCK_LOCKED_COLOR[1], TTEXTURESET.LOCK_LOCKED_COLOR[2], TTEXTURESET.LOCK_LOCKED_COLOR[3], TTEXTURESET.LOCK_LOCKED_COLOR[4]);
				MT.UI.FrameNoRemainingPoints(Frame);
			else
				objects.ReadOnlyButton:GetNormalTexture():SetVertexColor(TTEXTURESET.LOCK_UNLOCKED_COLOR[1], TTEXTURESET.LOCK_UNLOCKED_COLOR[2], TTEXTURESET.LOCK_UNLOCKED_COLOR[3], TTEXTURESET.LOCK_UNLOCKED_COLOR[4]);
				if Frame.TotalAvailablePoints > Frame.TotalUsedPoints then
					MT.UI.FrameHasRemainingPoints(Frame);
				end
			end
		end
		function MT.UI.FrameSetEditByRule(Frame, rule)			--	LOCKED CHANGED HERE ONLY
			rule = not not rule;
			if Frame.rule == rule then
				return;
			end
			Frame.rule = rule;
			--	all icons processed in 'SetClass'
			--	all icons but tie 1 processed in 'ChangePoint'
			local TreeFrames = Frame.TreeFrames;
			if rule then
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local TalentSet = TreeFrame.TalentSet;
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						if TalentSet[TalentSeq] == 0 then
							local TalentDef = TreeTDB[TalentSeq];
							MT.UI.TreeNodeSetTextColorUnavailable(TreeNodes[TalentDef[10]]);
						end
					end
				end
			else
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						local TalentDef = TreeTDB[TalentSeq];
						if TalentDef[1] == 0 then
							if TalentDef[5] == nil then
								MT.UI.TreeNodeSetTextColorAvailable(TreeNodes[TalentDef[10]]);
							end
						else
							break;
						end
					end
				end
				MT.UI.FrameResetTalents(Frame);
			end
		end
		function MT.UI.FrameSetInfo(Frame, class, level, TalData, activeGroup, name, readOnly, rule)
			MT.UI.FrameReset(Frame, true, false, true);
			if not MT.UI.FrameSetClass(Frame, class) then
				Frame:Hide();
				return false;
			end
			if TalData ~= nil then
				MT.UI.FrameSetTalent(Frame, TalData, activeGroup);
			end
			MT.UI.FrameSetLevel(Frame, level);
			--	MT.UI.FrameSetReadOnly(Frame, readOnly);
			MT.UI.FrameSetEditByRule(Frame, rule);
			MT.UI.FrameSetName(Frame, name);

			return true;
		end
		function MT.UI.TreeNodeChangePoint(Node, numPoints)		--	POINTS CHANGED HERE ONLY
			if not Node.active then
				return -1;
			end
			local TreeFrame = Node.TreeFrame;
			local Frame = TreeFrame.Frame;
			if Frame.readOnly then
				return -1;
			end
			if numPoints == 0 then
				return 1;
			elseif numPoints > 0 then	--	caps to available points
				local remainingPoints = Frame.TotalAvailablePoints - Frame.TotalUsedPoints;
				if remainingPoints <= 0 then
					return 2;
				elseif remainingPoints < numPoints then
					numPoints = remainingPoints;
				end
			end

			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentSeq = Node.TalentSeq;
			local TalentDef = TreeTDB[TalentSeq];

			if (numPoints > 0 and TalentSet[TalentSeq] == TalentDef[4]) or (numPoints < 0 and TalentSet[TalentSeq] == 0) then	--	increased from max_rank OR decreased from min_rank
				return 2;
			end

			if Node.free_edit then
				local ret = 0;

				if TalentSet[TalentSeq] + numPoints >= TalentDef[4] then
					if TalentSet[TalentSeq] + numPoints > TalentDef[4] then
						ret = 4;
					end
					numPoints = TalentDef[4] - TalentSet[TalentSeq];
					TalentSet[TalentSeq] = TalentDef[4];
					MT.UI.TreeNodeSetTextColorMaxRank(Node);
					MT.UI.TreeNodeLight(Node);
				elseif TalentSet[TalentSeq] + numPoints <= 0 then
					if TalentSet[TalentSeq] + numPoints < 0 then
						ret = 5;
					end
					numPoints = -TalentSet[TalentSeq];
					TalentSet[TalentSeq] = 0;
					MT.UI.TreeNodeUnlight(Node);
					MT.UI.TreeNodeSetTextColorUnavailable(Node);
				else
					TalentSet[TalentSeq] = TalentSet[TalentSeq] + numPoints;
					MT.UI.TreeNodeSetTextColorAvailable(Node);
					if numPoints > 0 then
						MT.UI.TreeNodeLight(Node);
						MT.UI.TreeNodeSetTextColorAvailable(Node);
					end
				end
				Node.CurVal:SetText(TalentSet[TalentSeq]);

				return ret;
			else
				local tier = TalentDef[1];
				local depby = TalentDef[12];
				if numPoints < 0 then	--	whether it can be decreased
					if depby ~= nil then		--	depended on by other
						for i = 1, #depby do
							if TalentSet[depby[i]] > 0 then
								return 3;
							end
						end
					end
					if TalentSet.TopCheckedTier >= tier + 1 then
						local numPointsLowerTier = 0;
						for i = 0, tier do
							numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[i];
						end
						for i = tier + 1, TalentSet.TopCheckedTier do
							numPoints = max(numPoints, i * CT.NUM_POINTS_NEXT_TIER - numPointsLowerTier);
							if numPoints == 0 then
								return 3;
							end
							numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[i];
						end
					end
				end

				local ret = 0;

				if TalentSet[TalentSeq] + numPoints >= TalentDef[4] then
					if TalentSet[TalentSeq] + numPoints > TalentDef[4] then
						ret = 4;
					end
					numPoints = TalentDef[4] - TalentSet[TalentSeq];
					TalentSet[TalentSeq] = TalentDef[4];
					MT.UI.TreeNodeSetTextColorMaxRank(Node);
					MT.UI.TreeNodeLight(Node);
					if depby ~= nil then
						for i = 1, #depby do
							MT.UI.TreeNodeActivate_RecheckPoint(TreeFrame.TreeNodes[TreeTDB[depby[i]][10]]);
						end
						local Arrows = TreeFrame.NodeDependArrows[TalentSeq];
						for i = 1, #Arrows do
							MT.UI.DependArrowSetTexCoord(Arrows[i], true);
						end
					end
				elseif TalentSet[TalentSeq] + numPoints <= 0 then
					if TalentSet[TalentSeq] + numPoints < 0 then
						ret = 5;
					end
					numPoints = -TalentSet[TalentSeq];
					TalentSet[TalentSeq] = 0;
					MT.UI.TreeNodeUnlight(Node);
					MT.UI.TreeNodeSetTextColorAvailable(Node);
				else
					TalentSet[TalentSeq] = TalentSet[TalentSeq] + numPoints;
					MT.UI.TreeNodeSetTextColorAvailable(Node);
					if numPoints > 0 then
						MT.UI.TreeNodeLight(Node);
					end
				end
				Node.CurVal:SetText(TalentSet[TalentSeq]);

				if numPoints < 0 and depby ~= nil then	--	deactive talents that depend on this
					for i = 1, #depby do
						MT.UI.TreeNodeDeactive(TreeFrame.TreeNodes[TreeTDB[depby[i]][10]]);
					end
					local Arrows = TreeFrame.NodeDependArrows[TalentSeq];
					for i = 1, #Arrows do
						MT.UI.DependArrowSetTexCoord(Arrows[i], false);
					end
				end

				--	CountByTier			index begin from 0
				--	TopAvailableTier	begin from 0
				--	TopCheckedTier		begin from 0
				TalentSet.Total = TalentSet.Total + numPoints;
				TreeFrame.CurTreePoints:SetText(TalentSet.Total);
				TalentSet.CountByTier[TalentDef[1]] = TalentSet.CountByTier[TalentDef[1]] + numPoints;

				local TopAvailableTier = min(floor(TalentSet.Total / CT.NUM_POINTS_NEXT_TIER), DT.MAX_NUM_TIER - 1);
				if TopAvailableTier > TalentSet.TopAvailableTier then
					MT.UI.TreeNodesActivateTier(TreeFrame.TreeNodes, TopAvailableTier);
					TalentSet.TopAvailableTier = TopAvailableTier;
				elseif TopAvailableTier < TalentSet.TopAvailableTier then
					MT.UI.TreeNodesDeactiveTier(TreeFrame.TreeNodes, TalentSet.TopAvailableTier);
					TalentSet.TopAvailableTier = TopAvailableTier;
				end

				if numPoints < 0 then
					if Frame.TotalAvailablePoints == Frame.TotalUsedPoints then
						MT.UI.FrameHasRemainingPoints(Frame);
					end
					Frame.TotalUsedPoints = Frame.TotalUsedPoints + numPoints;
				else
					Frame.TotalUsedPoints = Frame.TotalUsedPoints + numPoints;
					if Frame.TotalAvailablePoints == Frame.TotalUsedPoints then
						MT.UI.FrameNoRemainingPoints(Frame);
					end
				end

				TalentSet.TopCheckedTier = 0;
				for i = TopAvailableTier, 0, -1 do
					if TalentSet.CountByTier[i] > 0 then
						TalentSet.TopCheckedTier = i;
						break;
					end
				end
				--	if TalentSet.CountByTier[TalentSet.TopAvailableTier] == 0 then
				--		TalentSet.TopCheckedTier = TalentSet.TopAvailableTier - 1;
				--	else
				--		TalentSet.TopCheckedTier = TalentSet.TopAvailableTier;
				--	end

				if Frame.name ~= nil then
					local TalentChanged = TreeFrame.TalentChanged;
					if TalentChanged[TalentSeq] ~= nil then
						TalentChanged[TalentSeq] = TalentChanged[TalentSeq] + numPoints;
						if TalentChanged[TalentSeq] == 0 then
							TalentChanged[TalentSeq] = nil;
						end
					else
						TalentChanged[TalentSeq] = numPoints;
					end
				end

				MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, Frame.class, MT.GetPointsReqLevel(Frame.TotalUsedPoints));

				local EditBox = Frame.EditBox;
				if EditBox.type == "save" and not EditBox.charChanged then
					EditBox:SetText(MT.GenerateTitleFromRawData(Frame));
				end

				MT.UI.FrameUpdateLabelText(Frame);
				if GetMouseFocus() == Node then
					MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TreeFrame.SpecID, TalentDef[1] * 5, TreeFrame.TalentSet.Total, TalentDef[8], TalentSet[TalentSeq], TalentDef[4])
				end

				return ret;
			end
		end
		function MT.UI.TreeFrameResetTalentDependTree(TreeFrame, TalentSeq)
			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			if TalentSet[TalentSeq] > 0 then
				local depby = TreeTDB[TalentSeq][12];
				if depby then
					for index = 1, #depby do
						MT.UI.TreeFrameResetTalentDependTree(TreeFrame, depby[index]);
					end
				end
				MT.UI.TreeNodeChangePoint(TreeFrame.TreeNodes[TreeTDB[TalentSeq][10]], -TalentSet[TalentSeq]);
			end
		end
		function MT.UI.TreeFrameResetTalents(TreeFrame)
			local TreeTDB = TreeFrame.TreeTDB;
			for TalentSeq = #TreeTDB, 1, -1 do
				MT.UI.TreeFrameResetTalentDependTree(TreeFrame, TalentSeq);
			end
		end
		function MT.UI.FrameResetTalents(Frame)
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				MT.UI.TreeFrameResetTalents(TreeFrame);
			end
		end
		function MT.UI.FrameReset(Frame, ResetData, ResetName, ResetSetting)
			if ResetData ~= false then
				local TreeFrames = Frame.TreeFrames;
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];

					local TreeNodes = TreeFrame.TreeNodes;
					for i = 1, DT.MAX_NUM_TALENTS do
						TreeNodes[i]:Hide();
						TreeNodes[i].TalentSeq = nil;
						MT.UI.TreeNodeDeactive(TreeNodes[i]);
					end

					local TalentSet = TreeFrame.TalentSet;
					for i = 1, DT.MAX_NUM_TALENTS do
						TalentSet[i] = 0;
					end
					for Tier = 0, DT.MAX_NUM_TIER do
						TalentSet.CountByTier[Tier] = 0;
					end
					TalentSet.Total = 0;
					TalentSet.TopAvailableTier = 0;
					TalentSet.TopCheckedTier = 0;

					for i = 1, DT.MAX_NUM_TALENTS do
						wipe(TreeFrame.NodeDependArrows[i]);
					end

					local DependArrows = TreeFrame.DependArrows;
					for i = 1, #DependArrows do
						DependArrows[i]:Hide();
						DependArrows[i]:ClearAllPoints();
						DependArrows[i].Branch1:Hide();
						DependArrows[i].Branch1:ClearAllPoints();
						DependArrows[i].Corner:Hide();
						DependArrows[i].Branch2:Hide();
						DependArrows[i].Branch2:ClearAllPoints();
					end
					DependArrows.used = 0;

					TreeFrame.CurTreePoints:SetText("0");
				end

				MT.UI.FrameSetClass(Frame, nil);
				MT.UI.FrameSetLevel(Frame, nil);
				MT.UI.FrameSetTalent(Frame, nil);
			end
			if ResetName ~= false then
				MT.UI.FrameSetName(Frame, nil);
			end
			if ResetSetting ~= false then
				--	MT.UI.FrameSetReadOnly(Frame, false);
				MT.UI.FrameSetEditByRule(Frame, false);
			end

			MT.UI.FrameUpdateLabelText(Frame);

			Frame.initialized = false;
		end
		function MT.UI.FrameNoRemainingPoints(Frame)
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TreeNodes = TreeFrame.TreeNodes;
				for TalentSeq = 1, #TreeTDB do
					if TreeTDB[TalentSeq][4] ~= TalentSet[TalentSeq] then
						MT.UI.TreeNodeSetTextColorUnavailable(TreeNodes[MT.GetTreeNodeIndex(TreeTDB[TalentSeq])]);
					end
				end
			end
		end
		function MT.UI.FrameHasRemainingPoints(Frame)
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TreeNodes = TreeFrame.TreeNodes;
				for TalentSeq = 1, #TreeTDB do
					if TreeTDB[TalentSeq][4] == TalentSet[TalentSeq] then
						--	MT.UI.TreeNodeSetTextColorMaxRank(TreeNodes[MT.GetTreeNodeIndex(TreeTDB[TalentSeq])]);
					elseif TalentSet[TalentSeq] > 0 or TreeTDB[TalentSeq][1] == 0 then
						MT.UI.TreeNodeSetTextColorAvailable(TreeNodes[MT.GetTreeNodeIndex(TreeTDB[TalentSeq])]);
					else
						local TalentDef = TreeTDB[TalentSeq];
						local numPointsLowerTier = 0;
						for j = 0, TalentDef[1] - 1 do
							numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[j];
						end
						if numPointsLowerTier >= TalentDef[1] * CT.NUM_POINTS_NEXT_TIER then
							MT.UI.TreeNodeActivate_RecheckReq(TreeNodes[MT.GetTreeNodeIndex(TreeTDB[TalentSeq])]);
						end
					end
				end
			end
		end
		function MT.UI.FrameUpdateLabelText(Frame)
			local objects = Frame.objects;
			if Frame.name ~= nil then
				local should_show = false;
				for TreeIndex = 1, 3 do
					local TreeFrame = Frame.TreeFrames[TreeIndex];
					local TalentChanged = TreeFrame.TalentChanged;
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						if TalentChanged[TalentSeq] then
							should_show = true;
							break;
						end
					end
				end
				if should_show then
					objects.ResetToSetButton:Show();
					if Frame.label ~= nil then
						objects.Label:SetText(Frame.label .. l10n.LabelPointsChanged);
					else
						objects.Name:SetText(Frame.name .. l10n.LabelPointsChanged);
					end
				else
					objects.ResetToSetButton:Hide();
					if Frame.label ~= nil then
						objects.Label:SetText(Frame.label);
					else
						objects.Name:SetText(Frame.name);
					end
				end
			end
			objects.CurPointsUsed:SetText(Frame.TotalUsedPoints);
			objects.CurPointsReqLevel:SetText(MT.GetPointsReqLevel(Frame.TotalUsedPoints));
			objects.CurPointsRemaining:SetText(MT.GetLevelAvailablePoints(Frame.level) - Frame.TotalUsedPoints);
		end
		function MT.UI.FrameSetStyle(Frame, style)
			local TreeFrames = Frame.TreeFrames;
			if Frame.style ~= style then
				Frame.style = style;
				if style == 1 then
					TreeFrames[1]:Show();
					TreeFrames[2]:Show();
					TreeFrames[3]:Show();
					TreeFrames[2]:ClearAllPoints();
					TreeFrames[2]:SetPoint("CENTER", Frame, "CENTER", 0, (TUISTYLE.FrameFooterYSize - TUISTYLE.FrameHeaderYSize) * 0.5);
					TreeFrames[1]:ClearAllPoints();
					TreeFrames[1]:SetPoint("TOPRIGHT", TreeFrames[2], "TOPLEFT");
					TreeFrames[1]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMLEFT");
					TreeFrames[3]:ClearAllPoints();
					TreeFrames[3]:SetPoint("TOPLEFT", TreeFrames[2], "TOPRIGHT");
					TreeFrames[3]:SetPoint("BOTTOMLEFT", TreeFrames[2], "BOTTOMRIGHT");
					TreeFrames[1].TreeLabel:Show();
					TreeFrames[2].TreeLabel:Show();
					TreeFrames[3].TreeLabel:Show();
					Frame.TreeButtonsBar:Hide();
					Frame:SetMinResize(TUISTYLE.FrameXSizeMin_Style1, TUISTYLE.FrameYSizeMin_Style1);

					local scale = (Frame:GetHeight() - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize);
					Frame.TreeFrameScale = scale;
					Frame:SetWidth(scale * TUISTYLE.TreeFrameXSizeTriple + TUISTYLE.TreeFrameXToBorder * 2);
				elseif style == 2 then
					TreeFrames[1]:Hide();
					TreeFrames[2]:Hide();
					TreeFrames[3]:Hide();
					TreeFrames[Frame.CurTreeIndex]:Show();
					TreeFrames[2]:ClearAllPoints();
					TreeFrames[2]:SetPoint("CENTER", Frame, "CENTER", 0, (TUISTYLE.FrameFooterYSize - TUISTYLE.FrameHeaderYSize) * 0.5);
					TreeFrames[1]:ClearAllPoints();
					TreeFrames[1]:SetPoint("TOPLEFT", TreeFrames[2], "TOPLEFT");
					TreeFrames[1]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMRIGHT");
					TreeFrames[3]:ClearAllPoints();
					TreeFrames[3]:SetPoint("TOPLEFT", TreeFrames[2], "TOPLEFT");
					TreeFrames[3]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMRIGHT");
					TreeFrames[1].TreeLabel:Hide();
					TreeFrames[2].TreeLabel:Hide();
					TreeFrames[3].TreeLabel:Hide();
					Frame.TreeButtonsBar:Show();
					Frame:SetMinResize(TUISTYLE.FrameXSizeMin_Style2, TUISTYLE.FrameYSizeMin_Style2);

					local scale = (Frame:GetHeight() - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize);
					Frame.TreeFrameScale = scale;
					Frame:SetWidth(scale * TUISTYLE.TreeFrameXSizeSingle + TUISTYLE.TreeFrameXToBorder * 2);
				else
					return;
				end
				MT.UI.TreeUpdate(Frame, Frame.CurTreeIndex, true);
			end
		end
		function MT.UI.TreeNodeLight(Node)
			Node:GetNormalTexture():SetVertexColor(TTEXTURESET.ICON_LIGHT_COLOR[1], TTEXTURESET.ICON_LIGHT_COLOR[2], TTEXTURESET.ICON_LIGHT_COLOR[3], TTEXTURESET.ICON_LIGHT_COLOR[4]);
			Node:GetPushedTexture():SetVertexColor(TTEXTURESET.ICON_LIGHT_COLOR[1], TTEXTURESET.ICON_LIGHT_COLOR[2], TTEXTURESET.ICON_LIGHT_COLOR[3], TTEXTURESET.ICON_LIGHT_COLOR[4]);
		end
		function MT.UI.TreeNodeUnlight(Node)
			Node:GetNormalTexture():SetVertexColor(TTEXTURESET.ICON_UNLIGHT_COLOR[1], TTEXTURESET.ICON_UNLIGHT_COLOR[2], TTEXTURESET.ICON_UNLIGHT_COLOR[3], TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
			Node:GetPushedTexture():SetVertexColor(TTEXTURESET.ICON_UNLIGHT_COLOR[1], TTEXTURESET.ICON_UNLIGHT_COLOR[2], TTEXTURESET.ICON_UNLIGHT_COLOR[3], TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
		end
		function MT.UI.TreeNodeSetTextColorAvailable(Node)
			Node.Split:SetTextColor(TUISTYLE.IconTextAvailableColor[1], TUISTYLE.IconTextAvailableColor[2], TUISTYLE.IconTextAvailableColor[3], TUISTYLE.IconTextAvailableColor[4]);
			Node.MaxVal:SetTextColor(TUISTYLE.IconTextAvailableColor[1], TUISTYLE.IconTextAvailableColor[2], TUISTYLE.IconTextAvailableColor[3], TUISTYLE.IconTextAvailableColor[4]);
			Node.CurVal:SetTextColor(TUISTYLE.IconTextAvailableColor[1], TUISTYLE.IconTextAvailableColor[2], TUISTYLE.IconTextAvailableColor[3], TUISTYLE.IconTextAvailableColor[4]);
		end
		function MT.UI.TreeNodeSetTextColorUnavailable(Node)
			Node.Split:SetTextColor(TUISTYLE.IconTextDisabledColor[1], TUISTYLE.IconTextDisabledColor[2], TUISTYLE.IconTextDisabledColor[3], TUISTYLE.IconTextDisabledColor[4]);
			Node.MaxVal:SetTextColor(TUISTYLE.IconTextDisabledColor[1], TUISTYLE.IconTextDisabledColor[2], TUISTYLE.IconTextDisabledColor[3], TUISTYLE.IconTextDisabledColor[4]);
			Node.CurVal:SetTextColor(TUISTYLE.IconTextDisabledColor[1], TUISTYLE.IconTextDisabledColor[2], TUISTYLE.IconTextDisabledColor[3], TUISTYLE.IconTextDisabledColor[4]);
		end
		function MT.UI.TreeNodeSetTextColorMaxRank(Node)
			Node.Split:SetTextColor(TUISTYLE.IconTextMaxRankColor[1], TUISTYLE.IconTextMaxRankColor[2], TUISTYLE.IconTextMaxRankColor[3], TUISTYLE.IconTextMaxRankColor[4]);
			Node.MaxVal:SetTextColor(TUISTYLE.IconTextMaxRankColor[1], TUISTYLE.IconTextMaxRankColor[2], TUISTYLE.IconTextMaxRankColor[3], TUISTYLE.IconTextMaxRankColor[4]);
			Node.CurVal:SetTextColor(TUISTYLE.IconTextMaxRankColor[1], TUISTYLE.IconTextMaxRankColor[2], TUISTYLE.IconTextMaxRankColor[3], TUISTYLE.IconTextMaxRankColor[4]);
		end
		function MT.UI.TreeNodeActivate(Node)	--	Ligth Node when points increased from 0 instead of activated
			Node.active = true;
			MT.UI.TreeNodeSetTextColorAvailable(Node);
		end
		function MT.UI.TreeNodeDeactive(Node)	--	Unlight Node certainly when deactived
			Node.active = false;
			MT.UI.TreeNodeSetTextColorUnavailable(Node);
			MT.UI.TreeNodeUnlight(Node);
		end
		function MT.UI.TreeNodeNecessary(Node)
			Node.Overlay:Show();
			Node.Overlay:SetTexture(TTEXTURESET.ICON_NECESSARY);
		end
		function MT.UI.TreeNodeForbidden(Node)
			Node.Overlay:Show();
			Node.Overlay:SetTexture(TTEXTURESET.ICON_FORBIDDEN);
		end
		function MT.UI.TreeNodeActivate_RecheckReq(Node)
			local TalentSeq = Node.TalentSeq;
			if TalentSeq then
				local TreeFrame = Node.TreeFrame;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentDef = TreeTDB[TalentSeq];
				local DepTSeq = TalentDef[11];
				if DepTSeq == nil or TreeFrame.TalentSet[DepTSeq] == TreeTDB[DepTSeq][4] then
					MT.UI.TreeNodeActivate(Node);
				end
			end
		end
		function MT.UI.TreeNodeActivate_RecheckPoint(Node)
			local TalentSeq = Node.TalentSeq;
			if TalentSeq > 0 then
				local TreeFrame = Node.TreeFrame;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TalentDef = TreeTDB[TalentSeq];
				if TalentDef[1] == 0 then
					MT.UI.TreeNodeActivate(Node);
				end
				local numPointsLowerTier = 0;
				for Tier = 0, TalentDef[1] - 1 do
					numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[Tier];
				end
				if numPointsLowerTier >= TalentDef[1] * CT.NUM_POINTS_NEXT_TIER then
					MT.UI.TreeNodeActivate(Node);
				end
			end
		end
		function MT.UI.TreeNodesActivateTier(TreeNodes, tier)
			for i = tier * DT.MAX_NUM_COL + 1, (tier + 1) * DT.MAX_NUM_COL do
				MT.UI.TreeNodeActivate_RecheckReq(TreeNodes[i]);
			end
		end
		function MT.UI.TreeNodesDeactiveTier(TreeNodes, tier)
			for i = tier * DT.MAX_NUM_COL + 1, (tier + 1) * DT.MAX_NUM_COL do
				MT.UI.TreeNodeDeactive(TreeNodes[i]);
			end
		end
		function MT.UI.DependArrowSetTexCoord(Arrow, enabled)
			local Branch1, Corner, Branch2, coordFamily = Arrow.Branch1, Arrow.Corner, Arrow.Branch2, Arrow.coordFamily;
			if coordFamily == 11 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[4][1], TTEXTURESET.ARROW_COORD[4][2], TTEXTURESET.ARROW_COORD[4][3], TTEXTURESET.ARROW_COORD[4][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[3][1], TTEXTURESET.ARROW_COORD[3][2], TTEXTURESET.ARROW_COORD[3][3], TTEXTURESET.ARROW_COORD[3][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 12 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[4][2], TTEXTURESET.ARROW_COORD[4][1], TTEXTURESET.ARROW_COORD[4][3], TTEXTURESET.ARROW_COORD[4][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[3][2], TTEXTURESET.ARROW_COORD[3][1], TTEXTURESET.ARROW_COORD[3][3], TTEXTURESET.ARROW_COORD[3][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 21 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 22 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 31 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 32 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 41 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][4], TTEXTURESET.ARROW_COORD[2][3]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 42 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][4], TTEXTURESET.ARROW_COORD[2][3]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			end
			if coordFamily == 31 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][3], TTEXTURESET.BRANCH_COORD[6][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][3], TTEXTURESET.BRANCH_COORD[5][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 32 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][3], TTEXTURESET.BRANCH_COORD[6][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][3], TTEXTURESET.BRANCH_COORD[5][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 41 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][4], TTEXTURESET.BRANCH_COORD[6][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][4], TTEXTURESET.BRANCH_COORD[5][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 42 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][4], TTEXTURESET.BRANCH_COORD[6][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][4], TTEXTURESET.BRANCH_COORD[5][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			end
		end
		function MT.UI.DependArrowSet(Arrow, verticalDist, horizontalDist, enabled, Node, DepNode)
			local Branch1, Corner, Branch2 = Arrow.Branch1, Arrow.Corner, Arrow.Branch2;
			local coordFamily = nil;
			if verticalDist == 0 then		--horizontal
				if horizontalDist > 0 then
					Arrow:SetPoint("CENTER", Node, "LEFT", -TUISTYLE.TalentDepArrowXSize / 6, 0);
					Branch1:SetSize(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist, TUISTYLE.TalentDepBranchXSize);
					Branch1:SetPoint("LEFT", DepNode, "RIGHT");
					Branch1:SetPoint("RIGHT", Arrow, "CENTER");
					coordFamily = 11;
				elseif horizontalDist < 0 then
					horizontalDist = -horizontalDist;
					Arrow:SetPoint("CENTER", Node, "RIGHT", TUISTYLE.TalentDepArrowXSize / 6, 0);
					Branch1:SetSize(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist, TUISTYLE.TalentDepBranchXSize);
					Branch1:SetPoint("RIGHT", DepNode, "LEFT");
					Branch1:SetPoint("LEFT", Arrow, "CENTER");
					coordFamily = 12;
				end
				Corner:Hide();
				Branch2:Hide();
			elseif horizontalDist == 0 then	--vertical
				if verticalDist > 0 then
					Arrow:SetPoint("CENTER", Node, "TOP", 0, TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetSize(TUISTYLE.TalentDepBranchXSize, TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist);
					Branch1:SetPoint("TOP", DepNode, "BOTTOM");
					Branch1:SetPoint("BOTTOM", Arrow, "CENTER");
					coordFamily = 21;
				elseif verticalDist < 0 then
					verticalDist = -verticalDist;
					Arrow:SetPoint("CENTER", Node, "BOTTOM", 0, -TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetSize(TUISTYLE.TalentDepBranchXSize, TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist);
					Branch1:SetPoint("BOTTOM", DepNode, "TOP");
					Branch1:SetPoint("TOP", Arrow, "CENTER");
					coordFamily = 22;
				end
				Corner:Hide();
				Branch2:Hide();
			else	--TODO
				if verticalDist > 0 then
					Arrow:SetPoint("CENTER", Node, "TOP", 0, TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetHeight(TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist + TUISTYLE.TreeNodeSize * 0.5 - TUISTYLE.TalentDepBranchXSize);
					--Branch1:SetPoint("TOP", DepNode, "CENTER");
					Branch1:SetPoint("BOTTOM", Arrow, "CENTER");
					Corner:SetPoint("BOTTOM", Branch1, "TOP");
					-- Branch2:SetWidth(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist + TUISTYLE.TreeNodeSize * 0.5);
					if horizontalDist > 0 then
						Branch2:SetPoint("LEFT", DepNode, "RIGHT");
						Branch2:SetPoint("BOTTOMRIGHT", Branch1, "TOPLEFT");
						coordFamily = 31;
					else
						Branch2:SetPoint("RIGHT", DepNode, "LEFT");
						Branch2:SetPoint("BOTTOMLEFT", Branch1, "TOPRIGHT");
						coordFamily = 32;
					end
				else
					verticalDist = -verticalDist;
					Arrow:SetPoint("CENTER", Node, "BOTTOM", 0, -TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetHeight(TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist + TUISTYLE.TreeNodeSize * 0.5 - TUISTYLE.TalentDepBranchXSize);
					--Branch1:SetPoint("BOTTOM", DepNode, "CENTER");
					Branch1:SetPoint("TOP", Arrow, "CENTER");
					Corner:SetPoint("BOTTOM", Branch1, "TOP");
					-- Branch2:SetWidth(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist + TUISTYLE.TreeNodeSize * 0.5);
					if horizontalDist > 0 then
						Branch2:SetPoint("LEFT", DepNode, "RIGHT");
						Branch2:SetPoint("TOPRIGHT", Branch1, "BOTTOMLEFT");
						coordFamily = 41;
					else
						Branch2:SetPoint("RIGHT", DepNode, "LEFT");
						Branch2:SetPoint("TOPLEFT", Branch1, "BOTTOMRIGHT");
						coordFamily = 42;
					end
				end
				Branch2:Show();
				Corner:Show();
			end
			Arrow:Show();
			Branch1:Show();
			Arrow.coordFamily = coordFamily;
			MT.UI.DependArrowSetTexCoord(Arrow, enabled);
		end
		function MT.UI.DependArrowCreate(TreeFrame)
			local Arrow = TreeFrame:CreateTexture(nil, "OVERLAY");
			Arrow:SetTexture(TTEXTURESET.ARROW);
			Arrow:SetSize(TUISTYLE.TalentDepArrowXSize, TUISTYLE.TalentDepArrowYSize);

			local Branch1 = TreeFrame:CreateTexture(nil, "ARTWORK");
			Branch1:SetWidth(TUISTYLE.TalentDepBranchXSize);
			Branch1:SetTexture(TTEXTURESET.BRANCH);

			local Corner = TreeFrame:CreateTexture(nil, "ARTWORK");
			Corner:SetSize(TUISTYLE.TalentDepBranchXSize, TUISTYLE.TalentDepBranchXSize);
			Corner:SetTexture(TTEXTURESET.BRANCH);
			Corner:Hide();

			local Branch2 = TreeFrame:CreateTexture(nil, "ARTWORK");
			Branch2:SetHeight(TUISTYLE.TalentDepBranchXSize);
			Branch2:SetTexture(TTEXTURESET.BRANCH);
			Branch2:Hide();

			Arrow.Branch1 = Branch1;
			Arrow.Corner = Corner;
			Arrow.Branch2 = Branch2;

			return Arrow;
		end
		function MT.UI.DependArrowGet(TreeFrame)
			local DependArrows = TreeFrame.DependArrows;
			DependArrows.used = DependArrows.used + 1;
			if DependArrows.used > #DependArrows then
				DependArrows[DependArrows.used] = MT.UI.DependArrowCreate(TreeFrame);
			end
			return DependArrows[DependArrows.used];
		end
		local function TooltipFrame_OnUpdate_Tooltip1(TooltipFrame, elasped)
			TooltipFrame.delay = TooltipFrame.delay - elasped;
			if TooltipFrame.delay > 0 then
				return;
			end
			TooltipFrame:SetScript("OnUpdate", nil);
			local Tooltip1 = TooltipFrame.Tooltip1;
			if Tooltip1:IsShown() then
				--Tooltip1:Show();
				TooltipFrame:SetWidth(Tooltip1:GetWidth() + 4);
				TooltipFrame:SetHeight(TooltipFrame.Tooltip1LabelLeft:GetHeight() + Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterRight:GetHeight());
				TooltipFrame:SetAlpha(1.0);
				Tooltip1:SetAlpha(1.0);
			else
				TooltipFrame:Hide();
			end
		end
		local function TooltipFrame_OnUpdate_Tooltip12(TooltipFrame, elasped)
			TooltipFrame.delay = TooltipFrame.delay - elasped;
			if TooltipFrame.delay > 0 then
				return;
			end
			TooltipFrame:SetScript("OnUpdate", nil);
			local Tooltip1 = TooltipFrame.Tooltip1;
			local Tooltip2 = TooltipFrame.Tooltip2;
			if Tooltip1:IsShown() or Tooltip2:IsShown() then
				--Tooltip1:Show();
				--Tooltip2:Show();
				TooltipFrame:SetWidth(max(Tooltip1:GetWidth(), Tooltip2:GetWidth()) + 2);
				TooltipFrame:SetHeight(TooltipFrame.Tooltip1LabelLeft:GetHeight() + Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterLeft:GetHeight() + TooltipFrame.Tooltip2LabelLeft:GetHeight() + Tooltip2:GetHeight() + TooltipFrame.Tooltip2FooterLeft:GetHeight() - 8);
				TooltipFrame:SetAlpha(1.0);
				Tooltip1:SetAlpha(1.0);
				Tooltip2:SetAlpha(1.0);
			else
				TooltipFrame:Hide();
			end
		end
		function MT.UI.TooltipFrameSetTalent(TooltipFrame, Node, SpecID, reqPts, pts, spellTable, CurRank, MaxRank)
			local Tooltip1LabelLeft = TooltipFrame.Tooltip1LabelLeft;
			local Tooltip1LabelRight = TooltipFrame.Tooltip1LabelRight;
			local Tooltip1 = TooltipFrame.Tooltip1;

			local Tooltip1FooterLeft = TooltipFrame.Tooltip1FooterLeft;
			local Tooltip1FooterRight = TooltipFrame.Tooltip1FooterRight;

			local Tooltip2LabelLeft = TooltipFrame.Tooltip2LabelLeft;
			local Tooltip2 = TooltipFrame.Tooltip2;

			local Tooltip2FooterLeft = TooltipFrame.Tooltip2FooterLeft;
			local Tooltip2FooterRight = TooltipFrame.Tooltip2FooterRight;

			TooltipFrame.OwnerFrame = Node.TreeFrame.Frame;
			TooltipFrame:ClearAllPoints();
			TooltipFrame:SetPoint("BOTTOMRIGHT", Node, "TOPLEFT", -4, 4);
			TooltipFrame:Show();
			TooltipFrame:SetAlpha(0.0);
			if CurRank == 0 then
				Tooltip1LabelLeft:Show();
				--Tooltip1:Show();
				Tooltip1FooterLeft:Show();
				Tooltip1FooterRight:Show();
				Tooltip2LabelLeft:Hide();
				Tooltip2:Hide();
				Tooltip2FooterLeft:Hide();
				Tooltip2FooterRight:Hide();

				Tooltip1LabelLeft:SetText(l10n.NextRank);
				if Node.active then
					Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankColor[1], TUISTYLE.IconToolTipNextRankColor[2], TUISTYLE.IconToolTipNextRankColor[3], TUISTYLE.IconToolTipNextRankColor[4]);
					Tooltip1LabelRight:Hide();
				else
					Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
					if reqPts > pts then
						Tooltip1LabelRight:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
						Tooltip1LabelRight:Show();
						Tooltip1LabelRight:SetText(format(l10n.ReqPoints, pts, reqPts, l10n.DATA[SpecID]));
					end
				end

				Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip1:SetSpellByID(spellTable[1]);
				Tooltip1FooterRight:SetText(tostring(spellTable[1]));
				Tooltip1:SetAlpha(0.0);

				TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
				TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
			elseif CurRank == MaxRank then
				Tooltip1LabelLeft:Show();
				--Tooltip1:Show();
				Tooltip1FooterLeft:Show();
				Tooltip1FooterRight:Show();
				Tooltip2LabelLeft:Hide();
				Tooltip2:Hide();
				Tooltip2FooterLeft:Hide();
				Tooltip2FooterRight:Hide();

				Tooltip1LabelLeft:SetText(l10n.maxRMaxRanknk);
				Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipMaxRankColor[1], TUISTYLE.IconToolTipMaxRankColor[2], TUISTYLE.IconToolTipMaxRankColor[3], TUISTYLE.IconToolTipMaxRankColor[4]);
				Tooltip1LabelRight:Hide();

				Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip1:SetSpellByID(spellTable[MaxRank]);
				Tooltip1FooterRight:SetText(tostring(spellTable[MaxRank]));
				Tooltip1:SetAlpha(0.0);

				TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
				TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
			else
				Tooltip1LabelLeft:Show();
				--Tooltip1:Show();
				Tooltip1FooterLeft:Show();
				Tooltip1FooterRight:Show();
				Tooltip2LabelLeft:Show();
				--Tooltip2:Show();
				Tooltip2FooterLeft:Show();
				Tooltip2FooterRight:Show();

				Tooltip1LabelLeft:SetText(l10n.CurRank);
				Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipCurRankColor[1], TUISTYLE.IconToolTipCurRankColor[2], TUISTYLE.IconToolTipCurRankColor[3], TUISTYLE.IconToolTipCurRankColor[4]);

				Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip1:SetSpellByID(spellTable[CurRank]);
				Tooltip1FooterRight:SetText(tostring(spellTable[CurRank]));
				Tooltip1:SetAlpha(0.0);

				Tooltip2LabelLeft:SetText(l10n.NextRank);
				if Node.active then
					Tooltip2LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankColor[1], TUISTYLE.IconToolTipNextRankColor[2], TUISTYLE.IconToolTipNextRankColor[3], TUISTYLE.IconToolTipNextRankColor[4]);
					Tooltip1LabelRight:Hide();
				else
					Tooltip2LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
				end

				Tooltip2:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip2:SetPoint("TOPLEFT", Tooltip2LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip2:SetSpellByID(spellTable[CurRank + 1]);
				Tooltip2FooterRight:SetText(tostring(spellTable[CurRank + 1]));
				Tooltip2:SetAlpha(0.0);

				TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
				TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip12);
			end
		end
		function MT.UI.SetTooltip(Node)
			local TreeFrame = Node.TreeFrame;
			local TalentSeq = Node.TalentSeq;
			local TalentDef = TreeFrame.TreeTDB[TalentSeq];
			if TalentDef ~= nil then
				MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TreeFrame.SpecID, TalentDef[1] * 5, TreeFrame.TalentSet.Total, TalentDef[8], TreeFrame.TalentSet[TalentSeq], TalentDef[4]);
			else
				MT.UI.HideTooltip(Node);
			end
		end
		function MT.UI.HideTooltip(Node)
			local TooltipFrame = VT.TooltipFrame;
			TooltipFrame:Hide();
			TooltipFrame.Tooltip1:Hide();
			TooltipFrame.Tooltip2:Hide();
		end
		function MT.UI.SpellListFrameUpdate(SpellListFrame, class, level)
			local list = SpellListFrame.list;
			wipe(list);
			local pos = 0;
			list.class = class;
			local showAll = SpellListFrame.ShowAllSpell:GetChecked();
			local search = SpellListFrame.SearchEdit:GetText();
			if search == "" then search = nil; end
			local TreeFrames = SpellListFrame.Frame.TreeFrames;
			local ClassSDB = DT.SpellDB[class];
			if ClassSDB ~= nil then
				for index = 1, #ClassSDB do
					local SpellDef = ClassSDB[index];
					if not SpellDef.talent or TreeFrames[SpellDef.requireSpecIndex].TalentSet[SpellDef.requireIndex] > 0 then
						local NumLevel = #SpellDef;
						for Level = 1, NumLevel do
							local v = SpellDef[Level];
							if search == nil or strmatch(GetSpellInfo(v[2]), search) or strmatch(tostring(v[2]), search) then
								if v[1] <= level then
									if showAll then
										pos = pos + 1;
										list[pos] = v;
									elseif Level == NumLevel then
										pos = pos + 1;
										list[pos] = v;
									end
								else
									if not showAll then
										if Level > 1 then
											pos = pos + 1;
											list[pos] = SpellDef[Level - 1];
										end
									end
									break;
								end
							end
						end
					end
				end
				SpellListFrame.ScrollList:SetNumValue(#list);
				SpellListFrame.ScrollList:Update();
			end
		end
		function MT.UI.SpellListFrameToggle(Frame)
			local SpellListFrame, SpellListFrameContainer = Frame.SpellListFrame, Frame.SpellListFrameContainer;
			local SideAnchorTop = Frame.SideAnchorTop;
			local SideAnchorBottom = Frame.SideAnchorBottom;
			if SpellListFrameContainer:IsShown() then
				SpellListFrameContainer:Hide();
				SideAnchorTop:ClearAllPoints();
				SideAnchorTop:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorTop:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
				SideAnchorBottom:ClearAllPoints();
				SideAnchorBottom:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
			else
				SpellListFrameContainer:Show();
				MT.UI.SpellListFrameUpdate(SpellListFrame, Frame.class, MT.GetPointsReqLevel(Frame.TotalUsedPoints));
				SideAnchorTop:ClearAllPoints();
				SideAnchorTop:SetPoint("TOPLEFT", SpellListFrameContainer, "TOPRIGHT", 2, 0);
				SideAnchorTop:SetPoint("BOTTOMLEFT", SpellListFrameContainer, "BOTTOMRIGHT", 2, 0);
				SideAnchorBottom:ClearAllPoints();
				SideAnchorBottom:SetPoint("TOPLEFT", SpellListFrameContainer, "TOPRIGHT", 2, 0);
				SideAnchorBottom:SetPoint("BOTTOMLEFT", SpellListFrameContainer, "BOTTOMRIGHT", 2, 0);
			end
		end
		local EquipmentFrameDelayUpdateList = {  };
		local function EquipmentFrameDelayUpdate()
			for EquipmentContainer, EquData in next, EquipmentFrameDelayUpdateList do
				EquipmentFrameDelayUpdateList[EquipmentContainer] = nil;
				if EquipmentContainer.Frame:IsShown() then
					MT.UI.EquipmentFrameUpdate(EquipmentContainer, EquData);
				end
			end
		end
		function MT.UI.EquipmentFrameUpdate(EquipmentContainer, EquData)
			local recache = false;
			local EquipmentNodes = EquipmentContainer.EquipmentNodes;
			for slot = 0, 19 do
				local Node = EquipmentNodes[slot];
				local item = EquData[slot];
				Node.item = item;
				if item ~= nil then
					local name, link, quality, level, _, _, _, _, _, texture = GetItemInfo(item);
					if link ~= nil then
						link = gsub(link, "item[%-0-9:]+", item);
						Node:SetNormalTexture(texture);
						local color = ITEM_QUALITY_COLORS[quality];
						local r, g, b = color.r, color.g, color.b;
						Node.Glow:SetVertexColor(r, g, b);
						Node.Glow:Show();
						Node.ILvl:SetVertexColor(r, g, b);
						Node.ILvl:SetText(level);
						Node.Name:SetVertexColor(r, g, b);
						Node.Name:SetText(name);
						local enchantable, enchanted, link, level, loc, estr = MT.GetEnchantInfo(CT.SELFLCLASS, slot, item);
						if enchantable then
							Node.Ench:SetText(enchanted and estr or l10n.MISS_ENCHANT);
						else
							Node.Ench:SetText("");
						end
						if VT.__support_gem then
							local A, T, M, R, Y, B, gstr = MT.ScanGemInfo(item, true);
							Node.Gem:SetText(gstr);
						end
						Node.link = link;
					else
						Node:SetNormalTexture(TTEXTURESET.EQUIPMENT_EMPTY[Node.slot]);
						Node.Glow:Hide();
						Node.ILvl:SetText("");
						Node.Name:SetText("");
						Node.Ench:SetText("");
						Node.Gem:SetText("");
						Node.link = nil;
						recache = true;
					end
				else
					Node:SetNormalTexture(TTEXTURESET.EQUIPMENT_EMPTY[Node.slot]);
					Node.Glow:Hide();
					Node.ILvl:SetText("");
					Node.Name:SetText("");
					Node.Ench:SetText("");
					Node.Gem:SetText("");
					Node.link = nil;
				end
			end
			if recache then
				EquipmentFrameDelayUpdateList[EquipmentContainer] = EquData;
				MT._TimerStart(EquipmentFrameDelayUpdate, 0.5, 1);
			end
		end
		function MT.UI.EquipmentFrameToggle(Frame)
			local EquipmentFrameContainer = Frame.EquipmentFrameContainer;
			if EquipmentFrameContainer:IsShown() then
				EquipmentFrameContainer:Hide();
			else
				EquipmentFrameContainer:Show();
			end
		end
		function MT.UI.GlyphFrameUpdate(GlyphContainer, GlyData)
			local activeGroup = GlyphContainer.Frame.activeGroup;
			local GlyphNodes = GlyphContainer.GlyphNodes;
			if GlyData ~= nil and GlyData[activeGroup] ~= nil then
				local data = GlyData[activeGroup];
				for index = 1, 6 do
					local Node = GlyphNodes[index];
					local info = data[index];
					Node.info = info;
					if info ~= nil then
						Node.SpellID = info[3];
						Node.Glyph:Show();
						Node.Glyph:SetTexture(info[4]);
						local def = Node.def;
						Node.Background:SetTexCoord(def[7], def[8], def[9], def[10]);
					else
						Node.SpellID = nil;
						Node.Glyph:Hide();
						local d0 = Node.d0;
						Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
					end
				end
			else
				for index = 1, 6 do
					local Node = GlyphNodes[index];
					Node.SpellID = nil;
					Node.Glyph:Hide();
					local d0 = Node.d0;
					Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
				end
			end
		end
		function MT.UI.TreeFrameUpdateSize(Frame, width, height)
			local TreeFrames = Frame.TreeFrames;
			local style = Frame.style;
			if style == 1 then
				local scale = min((width - TUISTYLE.TreeFrameXToBorder * 2) / TUISTYLE.TreeFrameXSizeTriple, (height - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize));
				TreeFrames[1]:SetScale(scale);
				TreeFrames[2]:SetScale(scale);
				TreeFrames[3]:SetScale(scale);
				Frame.TreeFrameScale = scale;
			elseif style == 2 then
				local scale = min((width - TUISTYLE.TreeFrameXToBorder * 2) / TUISTYLE.TreeFrameXSizeSingle, (height - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize));
				TreeFrames[1]:SetScale(scale);
				TreeFrames[2]:SetScale(scale);
				TreeFrames[3]:SetScale(scale);
				Frame.TreeFrameScale = scale;
			end
		end
		function MT.UI.TreeUpdate(Frame, TreeIndex, force_update)
			if Frame.style ~= 2 then
				return;
			end
			if TreeIndex <= 0 or TreeIndex > 3 then
				Frame.TreeButtonsBar.CurTreeIndicator:Hide();
				return;
			end
			local TreeFrames = Frame.TreeFrames;
			local TreeButtons = Frame.TreeButtons;
			if Frame.CurTreeIndex ~= TreeIndex or force_update then
				TreeFrames[Frame.CurTreeIndex]:Hide();
				TreeFrames[TreeIndex]:Show();
				Frame.CurTreeIndex = TreeIndex;
				local CurTreeIndicator = Frame.TreeButtonsBar.CurTreeIndicator;
				CurTreeIndicator:Show();
				CurTreeIndicator:ClearAllPoints();
				CurTreeIndicator:SetPoint("CENTER", TreeButtons[TreeIndex]);
				--	CurTreeIndicator:SetScale(1.5);
				--	for i = 1, 3 do
				--		if i == TreeIndex then
				--			TreeButtons[i]:SetSize(TUISTYLE.TreeButtonXSize * 1.28, TUISTYLE.TreeButtonYSize * 1.28);
				--		else
				--			TreeButtons[i]:SetSize(TUISTYLE.TreeButtonXSize * 0.86, TUISTYLE.TreeButtonYSize * 0.86);
				--		end
				--	end
			end
		end
	--	TooltipFrame
		function MT.UI.CreateTooltipFrame()
			local TooltipFrame = CreateFrame('FRAME', nil, UIParent);
			TooltipFrame:SetSize(1, 1);
			TooltipFrame:SetFrameStrata("FULLSCREEN");
			TooltipFrame:SetClampedToScreen(true);
			TooltipFrame:EnableMouse(false);
			VT.__uireimp._SetSimpleBackdrop(TooltipFrame, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
			TooltipFrame:Hide();
			TooltipFrame:Show();

			local Tooltip1LabelLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			Tooltip1LabelLeft:SetPoint("TOPLEFT", 6, -6);
			local Tooltip1LabelRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			Tooltip1LabelRight:SetPoint("TOPRIGHT", -6, -6);
			local Tooltip1Name = "Emu_Tooltip1" .. (MT.GetUnifiedTime() + 1) .. random(1000000, 10000000);
			local Tooltip1 = CreateFrame('GAMETOOLTIP', Tooltip1Name, UIParent, "GameTooltipTemplate");
			Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
			if Tooltip1.NineSlice ~= nil then
				Tooltip1.NineSlice:SetAlpha(0.0);
				Tooltip1.NineSlice:Hide();
			end
			for _, v in next, { Tooltip1:GetRegions() } do
				if v:GetObjectType() == 'Texture' then
					v:Hide();
				end
			end
			Tooltip1.TextLeft1 = Tooltip1.TextLeft1 or _G[Tooltip1Name .. "TextLeft1"];
			Tooltip1.TextRight1 = Tooltip1.TextRight1 or _G[Tooltip1Name .. "TextRight1"];
			Tooltip1.TextLeft2 = Tooltip1.TextLeft2 or _G[Tooltip1Name .. "TextLeft2"];
			Tooltip1.TextRight2 = Tooltip1.TextRight2 or _G[Tooltip1Name .. "TextRight2"];

			local Tooltip1FooterLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			Tooltip1FooterLeft:SetPoint("TOPLEFT", Tooltip1, "BOTTOMLEFT", 12, 6);
			local Tooltip1FooterRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			Tooltip1FooterRight:SetPoint("TOPRIGHT", Tooltip1, "BOTTOMRIGHT", -12, 6);

			local Tooltip2LabelLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			Tooltip2LabelLeft:SetPoint("TOPLEFT", Tooltip1FooterLeft, "BOTTOMLEFT", -12, -4);
			local Tooltip2Name = "Emu_Tooltip2" .. (MT.GetUnifiedTime() + 100) .. random(1000000, 10000000);
			local Tooltip2 = CreateFrame('GAMETOOLTIP', Tooltip2Name, UIParent, "GameTooltipTemplate");
			Tooltip2:SetPoint("TOPLEFT", Tooltip2LabelLeft, "BOTTOMLEFT", 0, 6);
			if Tooltip2.NineSlice ~= nil then
				Tooltip2.NineSlice:SetAlpha(0.0);
				Tooltip2.NineSlice:Hide();
			end
			for _, v in next, { Tooltip2:GetRegions() } do
				if v:GetObjectType() == 'Texture' then
					v:Hide();
				end
			end
			Tooltip2.TextLeft1 = Tooltip2.TextLeft1 or _G[Tooltip2Name .. "TextLeft1"];
			Tooltip2.TextRight1 = Tooltip2.TextRight1 or _G[Tooltip2Name .. "TextRight1"];
			Tooltip2.TextLeft2 = Tooltip2.TextLeft2 or _G[Tooltip2Name .. "TextLeft2"];
			Tooltip2.TextRight2 = Tooltip2.TextRight2 or _G[Tooltip2Name .. "TextRight2"];

			local Tooltip2FooterLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			Tooltip2FooterLeft:SetPoint("TOPLEFT", Tooltip2, "BOTTOMLEFT", 12, 6);
			local Tooltip2FooterRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			Tooltip2FooterRight:SetPoint("TOPRIGHT", Tooltip2, "BOTTOMRIGHT", -12, 6);

			Tooltip1LabelLeft:SetText("")
			Tooltip1LabelRight:SetText("")
			Tooltip2LabelLeft:SetText("")

			Tooltip1FooterLeft:SetTextColor(0.25, 0.5, 1.0, 1.0);
			Tooltip1FooterRight:SetTextColor(0.25, 0.5, 1.0, 1.0);
			Tooltip2FooterLeft:SetTextColor(0.25, 0.5, 1.0, 1.0);
			Tooltip2FooterRight:SetTextColor(0.25, 0.5, 1.0, 1.0);

			Tooltip1FooterLeft:SetText("id");
			Tooltip1FooterRight:SetText("");
			Tooltip2FooterLeft:SetText("id");
			Tooltip2FooterRight:SetText("");

			TooltipFrame.Tooltip1LabelLeft = Tooltip1LabelLeft;
			TooltipFrame.Tooltip1LabelRight = Tooltip1LabelRight;
			TooltipFrame.Tooltip1 = Tooltip1;

			TooltipFrame.Tooltip1FooterLeft = Tooltip1FooterLeft;
			TooltipFrame.Tooltip1FooterRight = Tooltip1FooterRight;

			TooltipFrame.Tooltip2LabelLeft = Tooltip2LabelLeft;
			TooltipFrame.Tooltip2 = Tooltip2;

			TooltipFrame.Tooltip2FooterLeft = Tooltip2FooterLeft;
			TooltipFrame.Tooltip2FooterRight = Tooltip2FooterRight;

			return TooltipFrame;
		end
	--	SpellListFrame
		local function SpellListNode_OnEnter(Node)
			local index = Node:GetDataIndex();
			GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
			local data = Node.list[index];
			GameTooltip:SetSpellByID(data[2]);
			GameTooltip:Show();
			MT.After(0.1, function()
				if select(2, GameTooltip:GetSpell()) ~= data[2] then
					return;
				end
				if data[5] and data[1] > 0 then
					GameTooltip:AddDoubleLine(l10n.SpellListFrameGTTSpellLevel .. data[5], l10n.SpellListFrameGTTReqLevel .. data[1], 1.0, 0.75, 0.5, 1.0, 0.75, 0.5);
				elseif data[5] then
					GameTooltip:AddLine(l10n.SpellListFrameGTTSpellLevel .. data[5], 1.0, 0.75, 0.5);
				elseif data[1] > 0 then
					GameTooltip:AddLine(l10n.SpellListFrameGTTReqLevel .. data[1], 1.0, 0.75, 0.5);
				end
				if CT.SELFCLASS == Node.list.class then
					if not data[6] then
						if FindSpellBookSlotBySpellID(data[2]) then
							GameTooltip:AddLine(l10n.SpellAvailable);
						else
							GameTooltip:AddLine(l10n.SpellUnavailable);
						end
					end
				end
				if data[3] > 0 then
					local str;
					if data[3] >= 10000 then
						local c = data[3] % 100;
						local s = (data[3] % 10000 - c) / 100;
						local g = (data[3] - s) / 10000;
						str = format("|cffffbf00%d|r|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0|t|cffffffff%02d|r|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t|cffffaf7f%02d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", g, s, c);
					elseif data[3] >= 100 then
						local c = data[3] % 100;
						local s = (data[3] % 10000 - c) / 100;
						str = format("|cffffffff%d|r|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t|cffffaf7f%02d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", s, c);
					else
						str = format("|cffffaf7f%d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", data[3]);
					end
					GameTooltip:AddDoubleLine(l10n.TrainCost, str, 1, 1, 1, 1, 1, 1);
				end
				if data.race then
					local str = nil;
					for _, v in next, { strsplit("|", data.race) } do
						str = str == nil and (l10n[v] or v) or (str .. ", " .. (l10n[v] or v));
					end
					GameTooltip:AddLine(l10n.RACE .. ": " .. str, 1.0, 0.5, 0.25);
				end
				GameTooltip:Show();
			end);
		end
		local function SpellListNode_OnLeave(Node)
			if GameTooltip:IsOwned(Node) then
				GameTooltip:Hide();
			end
		end
		local function SpellListNode_OnClick(Node)
			if IsShiftKeyDown() then
				local index = Node:GetDataIndex();
				local data = Node.list[index];
				local link = MT.GetSpellLink(data[2]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			end
			Node.SearchEdit:ClearFocus();
		end
		local function SpellListNode_OnDragStart(Node)
			Node:StopMovingOrSizing();
			local index = Node:GetDataIndex();
			local data = Node.list[index];
			if not data[6] and FindSpellBookSlotBySpellID(data[2]) then
				PickupSpell(data[2]);
			end
		end
		local function CreateSpellListNode(Parent, index, buttonHeight)
			local Node = CreateFrame('BUTTON', nil, Parent);
			Node:SetHeight(buttonHeight);
			VT.__uireimp._SetSimpleBackdrop(Node, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
			Node:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
			Node:EnableMouse(true);
			Node:Show();

			local Icon = Node:CreateTexture(nil, "OVERLAY");
			Icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
			Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
			Icon:SetPoint("LEFT", 4, 0);
			Node.Icon = Icon;

			local Title = Node:CreateFontString(nil, "OVERLAY");
			Title:SetFont(TUISTYLE.SpellListFrameFont, TUISTYLE.SpellListFrameFontSize, TUISTYLE.SpellListFrameFontOutline);
			Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
			Node.Title = Title;

			Node:SetScript("OnEnter", SpellListNode_OnEnter);
			Node:SetScript("OnLeave", SpellListNode_OnLeave);
			Node:SetScript("OnClick", SpellListNode_OnClick);
			Node:RegisterForDrag("LeftButton");
			Node:SetScript("OnDragStart", SpellListNode_OnDragStart);

			local SpellListFrame = Parent:GetParent():GetParent();
			Node.SpellListFrame = SpellListFrame;
			Node.list = SpellListFrame.list;
			Node.SearchEdit = SpellListFrame.SearchEdit;

			return Node;
		end
		local function SetSpellListNode(Node, data_index)
			local list = Node.list;
			if data_index <= #list then
				local name, _, texture = GetSpellInfo(list[data_index][2]);
				Node.Icon:SetTexture(texture);
				Node.Title:SetText(name);
				Node:Show();
				if GetMouseFocus() == Node then
					SpellListNode_OnEnter(Node);
				end
			else
				Node:Hide();
			end
		end
		local function SearchEditCancel_OnClick(SearchEditCancel)
			SearchEditCancel.Edit:SetText("");
			SearchEditCancel.Edit:ClearFocus();
		end
		local function SearchEditOK_OnClick(SearchEditOK)
			SearchEditOK.Edit:ClearFocus();
		end
		local function SearchEditOK_OnEnable(SearchEditOK)
			SearchEditOK.Text:SetTextColor(1.0, 1.0, 1.0, 1.0);
		end
		local function SearchEditOK_OnDisable(SearchEditOK)
			SearchEditOK.Text:SetTextColor(1.0, 1.0, 1.0, 0.5);
		end
		local function SearchEdit_OnEnterPressed(SearchEdit)
			SearchEdit:ClearFocus();
		end
		local function SearchEdit_OnEscapePressed(SearchEdit)
			SearchEdit:ClearFocus();
		end
		local function SearchEdit_OnTextChanged(SearchEdit, isUserInput)
			MT.UI.SpellListFrameUpdate(SearchEdit.SpellListFrame, SearchEdit.SpellListFrame.Frame.class, MT.GetPointsReqLevel(SearchEdit.SpellListFrame.Frame.TotalUsedPoints));
			if not SearchEdit:HasFocus() and SearchEdit:GetText() == "" then
				SearchEdit.Note:Show();
			end
			if SearchEdit:GetText() == "" then
				SearchEdit.Cancel:Hide();
			else
				SearchEdit.Cancel:Show();
			end
		end
		local function SearchEdit_OnEditFocusGained(SearchEdit)
			SearchEdit.Note:Hide();
			SearchEdit.OK:Enable();
		end
		local function SearchEdit_OnEditFocusLost(SearchEdit)
			if SearchEdit:GetText() == "" then SearchEdit.Note:Show(); end
			SearchEdit.OK:Disable();
		end
		local function ShowAllSpell_OnClick(ShowAllSpell)
			MT.UI.SpellListFrameUpdate(ShowAllSpell.SpellListFrame, ShowAllSpell.SpellListFrame.Frame.class, MT.GetPointsReqLevel(ShowAllSpell.SpellListFrame.Frame.TotalUsedPoints));
		end
		local function Close_OnClick(Close)
			MT.UI.SpellListFrameToggle(Close.SpellListFrame.Frame);
		end
		function MT.UI.CreateSpellListFrame(Frame)
			local SpellListFrameContainer = CreateFrame('FRAME', nil, Frame);
			SpellListFrameContainer:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 0, 0);
			SpellListFrameContainer:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 0, 0);
			SpellListFrameContainer:SetWidth(TUISTYLE.SpellListFrameXSize);
			VT.__uireimp._SetSimpleBackdrop(SpellListFrameContainer, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0);
			SpellListFrameContainer:Hide();
			local SpellListFrame = CreateFrame('FRAME', nil, SpellListFrameContainer);	--	Frame:GetName() .. "SpellListFrame"
			SpellListFrame:SetPoint("CENTER", SpellListFrameContainer);
			SpellListFrame:SetWidth(TUISTYLE.SpellListFrameXSize);
			SpellListFrame:Show();
			SpellListFrame.list = {  };
			local ScrollList = VT.__scrolllib.CreateScrollFrame(SpellListFrame, nil, nil, TUISTYLE.SpellListNodeHeight, CreateSpellListNode, SetSpellListNode);
			ScrollList:SetPoint("BOTTOMLEFT", TUISTYLE.SpellListFrameXToBorder, TUISTYLE.SpellListFrameYToTop);
			ScrollList:SetPoint("TOPRIGHT", -TUISTYLE.SpellListFrameXToBorder, -TUISTYLE.SpellListFrameYToBottom);
			SpellListFrame.ScrollList = ScrollList;

			local SearchEdit = CreateFrame('EDITBOX', nil, SpellListFrame);
			SearchEdit:SetSize(TUISTYLE.SpellListFrameXSize - 2 * TUISTYLE.SpellListFrameXToBorder - 36, 16);
			SearchEdit:SetFont(GameFontHighlight:GetFont(), 10, "OUTLINE");
			SearchEdit:SetAutoFocus(false);
			SearchEdit:SetJustifyH("LEFT");
			SearchEdit:Show();
			SearchEdit:EnableMouse(true);
			SearchEdit:SetPoint("TOPLEFT", SpellListFrame, TUISTYLE.SpellListFrameXToBorder, -6);
			local SearchEditTexture = SearchEdit:CreateTexture(nil, "ARTWORK");
			SearchEditTexture:SetPoint("TOPLEFT");
			SearchEditTexture:SetPoint("BOTTOMRIGHT");
			SearchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
			SearchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
			SearchEditTexture:SetAlpha(0.75);
			SearchEditTexture:SetBlendMode("ADD");
			SearchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
			SearchEdit.Texture = SearchEditTexture;
			local SearchEditNote = SearchEdit:CreateFontString(nil, "OVERLAY");
			SearchEditNote:SetFont(GameFontNormal:GetFont(), 12);
			SearchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
			SearchEditNote:SetPoint("LEFT", 4, 0);
			SearchEditNote:SetText(l10n.Search);
			SearchEditNote:Show();
			SearchEdit.Note = SearchEditNote;
			local SearchEditCancel = CreateFrame('BUTTON', nil, SearchEdit);
			SearchEditCancel:SetSize(16, 16);
			SearchEditCancel:SetPoint("RIGHT", SearchEdit);
			SearchEditCancel:SetScript("OnClick", SearchEditCancel_OnClick);
			SearchEditCancel:Hide();
			SearchEditCancel:SetNormalTexture("interface\\petbattles\\deadpeticon");
			SearchEditCancel.Edit = SearchEdit;
			SearchEdit.Cancel = SearchEditCancel;
			local SearchEditOK = CreateFrame('BUTTON', nil, SpellListFrame);
			SearchEditOK:SetSize(32, 16);
			SearchEditOK:SetPoint("LEFT", SearchEdit, "RIGHT", 4, 0);
			SearchEditOK:SetScript("OnClick", SearchEditOK_OnClick);
			SearchEditOK:Disable();
			SearchEditOK.Edit = SearchEdit;
			SearchEdit.OK = SearchEditOK;
			local SearchEditOKTexture = SearchEditOK:CreateTexture(nil, "ARTWORK");
			SearchEditOKTexture:SetPoint("TOPLEFT");
			SearchEditOKTexture:SetPoint("BOTTOMRIGHT");
			SearchEditOKTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			SearchEditOKTexture:SetAlpha(0.75);
			SearchEditOKTexture:SetBlendMode("ADD");
			SearchEditOK.Texture = SearchEditOKTexture;
			local SearchEditOKText = SearchEditOK:CreateFontString(nil, "OVERLAY");
			SearchEditOKText:SetFont(GameFontHighlight:GetFont(), 12);
			SearchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			SearchEditOKText:SetPoint("CENTER");
			SearchEditOKText:SetText(l10n["OK"]);
			SearchEditOK.Text = SearchEditOKText;
			SearchEditOK:SetFontString(SearchEditOKText);
			SearchEditOK:SetPushedTextOffset(1, -1);
			SearchEditOK:SetScript("OnEnable", SearchEditOK_OnEnable);
			SearchEditOK:SetScript("OnDisable", SearchEditOK_OnDisable);
			SearchEdit:SetScript("OnEnterPressed", SearchEdit_OnEnterPressed);
			SearchEdit:SetScript("OnEscapePressed", SearchEdit_OnEscapePressed);
			SearchEdit:SetScript("OnTextChanged", SearchEdit_OnTextChanged);
			SearchEdit:SetScript("OnEditFocusGained", SearchEdit_OnEditFocusGained);
			SearchEdit:SetScript("OnEditFocusLost", SearchEdit_OnEditFocusLost);
			SearchEdit:ClearFocus();
			SearchEdit.SpellListFrame = SpellListFrame;
			SpellListFrame.SearchEdit = SearchEdit;
			SpellListFrame.SearchEditOK = SearchEditOK;

			local ShowAllSpell = CreateFrame('CHECKBUTTON', nil, SpellListFrame, "OptionsBaseCheckButtonTemplate");
			ShowAllSpell:SetSize(16, 16);
			ShowAllSpell:SetHitRectInsets(0, 0, 0, 0);
			ShowAllSpell:ClearAllPoints();
			ShowAllSpell:Show();
			ShowAllSpell:SetChecked(false);
			ShowAllSpell:SetPoint("BOTTOMRIGHT", -TUISTYLE.SpellListFrameXToBorder, 6);
			ShowAllSpell:SetScript("OnClick", ShowAllSpell_OnClick);
			ShowAllSpell.SpellListFrame = SpellListFrame;
			SpellListFrame.ShowAllSpell = ShowAllSpell;

			local ShowAllSpellLabel = SpellListFrame:CreateFontString(nil, "ARTWORK");
			ShowAllSpellLabel:SetFont(GameFontHighlight:GetFont(), 10, TUISTYLE.FrameFontOutline);
			ShowAllSpellLabel:SetText(l10n.ShowAllSpell);
			ShowAllSpell.Name = ShowAllSpellLabel;
			ShowAllSpellLabel:SetPoint("RIGHT", ShowAllSpell, "LEFT", 0, 0);

			local Close = CreateFrame('BUTTON', nil, SpellListFrame);
			Close:SetSize(32, 16);
			Close:SetPoint("BOTTOMLEFT", 4, 6);
			Close:SetScript("OnClick", Close_OnClick);
			local CloseTexture = Close:CreateTexture(nil, "ARTWORK");
			CloseTexture:SetPoint("TOPLEFT");
			CloseTexture:SetPoint("BOTTOMRIGHT");
			CloseTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			CloseTexture:SetAlpha(0.75);
			CloseTexture:SetBlendMode("ADD");
			local CloseLabel = Close:CreateFontString(nil, "OVERLAY");
			CloseLabel:SetFont(GameFontHighlight:GetFont(), 12);
			CloseLabel:SetTextColor(1.0, 1.0, 1.0, 0.5);
			CloseLabel:SetPoint("CENTER");
			CloseLabel:SetText(l10n["Hide"]);
			Close:SetFontString(CloseLabel);
			Close:SetPushedTextOffset(1, -1);
			Close.SpellListFrame = SpellListFrame;
			SpellListFrame.Close = Close;

			SpellListFrame.Frame = Frame;
			SpellListFrameContainer.Frame = Frame;
			return SpellListFrame, SpellListFrameContainer;
		end
	--	EquipmentFrame & GlyphFrame
		local function EquipmentNode_OnEnter(Node)
			if Node.link then
				GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
				GameTooltip:SetHyperlink(Node.link);
			end
		end
		local function EquipmentNode_OnLeave(Node, motion)
			if GameTooltip:IsOwned(Node) then
				GameTooltip:Hide();
			end
		end
		local function EquipmentNode_OnClick(Node)
			if IsShiftKeyDown() then
				if Node.link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(Node.link);
				end
			elseif IsControlKeyDown() then
				if Node.link then
					DressUpItemLink(Node.link);
				end
			end
		end
		local function EquipmentFrame_OnShow(EquipmentFrame)
			local Frame = EquipmentFrame.Frame;
			if Frame.name ~= nil then
				MT.UI.EquipmentFrameUpdate(Frame.EquipmentContainer, VT.TQueryCache[Frame.name].EquData);
				if VT.__support_glyph then
					MT.UI.GlyphFrameUpdate(Frame.GlyphContainer, VT.TQueryCache[Frame.name].GlyData);
				end
			end
		end
		local function GlyphNode_OnEnter(Node)
			local SpellID = Node.SpellID;
			if SpellID ~= nil then
				GameTooltip:SetOwner(Node, "ANCHOR_RIGHT");
				GameTooltip:SetSpellByID(SpellID);
				GameTooltip:AddLine(Node.TypeText, 0.75, 0.75, 1.0);
				GameTooltip:Show();
			end
		end
		local function GlyphNode_OnLeave(Node)
			GameTooltip:Hide();
		end
		function MT.UI.CreateEquipmentFrame(Frame)
			local EquipmentFrameContainer = CreateFrame('FRAME', nil, Frame);
			EquipmentFrameContainer:SetPoint("TOPRIGHT", Frame, "TOPLEFT", 0, 0);
			EquipmentFrameContainer:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", 0, 0);
			EquipmentFrameContainer:SetWidth(TUISTYLE.EquipmentFrameXSize);
			VT.__uireimp._SetSimpleBackdrop(EquipmentFrameContainer, 0, 1, 0.0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, 1.0);
			EquipmentFrameContainer:Hide();
			local EquipmentFrame = CreateFrame('FRAME', nil, EquipmentFrameContainer);
			EquipmentFrame:SetWidth(TUISTYLE.EquipmentFrameXSize);
			if VT.__support_glyph then
				EquipmentFrame:SetPoint("TOP", EquipmentFrameContainer);
			else
				EquipmentFrame:SetPoint("CENTER", EquipmentFrameContainer);
			end
			EquipmentFrame:Show();
			local EquipmentContainer = CreateFrame('FRAME', nil, EquipmentFrame);
			if VT.__support_glyph then
				EquipmentContainer:SetPoint("TOP", EquipmentFrame);
			else
				EquipmentContainer:SetPoint("CENTER", EquipmentFrame);
			end
			EquipmentContainer:SetSize(TUISTYLE.EquipmentFrameXSize, TUISTYLE.EquipmentContainerYSize);
			EquipmentContainer:Show();
			local EquipmentNodes = {  };
			for slot = 0, 19 do
				local Node = CreateFrame('BUTTON', nil, EquipmentContainer);
				Node:SetSize(TUISTYLE.EquipmentNodeSize, TUISTYLE.EquipmentNodeSize);
				Node:Show();

				Node:EnableMouse(true);
				Node:SetScript("OnEnter", EquipmentNode_OnEnter);
				Node:SetScript("OnLeave", EquipmentNode_OnLeave);
				Node:SetScript("OnClick", EquipmentNode_OnClick);

				Node:SetNormalTexture(TTEXTURESET.UNK);
				Node:SetHighlightTexture(TTEXTURESET.EQUIPMENT_HIGHLIGHT);
				Node:GetHighlightTexture():SetTexCoord(TTEXTURESET.EQUIPMENT_HIGHLIGHT_COORD[1], TTEXTURESET.EQUIPMENT_HIGHLIGHT_COORD[2], TTEXTURESET.EQUIPMENT_HIGHLIGHT_COORD[3], TTEXTURESET.EQUIPMENT_HIGHLIGHT_COORD[4]);

				local Glow = Node:CreateTexture(nil, "OVERLAY");
				Glow:SetAllPoints();
				Glow:SetTexture(TTEXTURESET.EQUIPMENT_GLOW);
				Glow:SetBlendMode("ADD");
				Glow:SetTexCoord(TTEXTURESET.EQUIPMENT_GLOW_COORD[1], TTEXTURESET.EQUIPMENT_GLOW_COORD[2], TTEXTURESET.EQUIPMENT_GLOW_COORD[3], TTEXTURESET.EQUIPMENT_GLOW_COORD[4]);
				Glow:Show();
				Node.Glow = Glow;

				local ILvl = Node:CreateFontString(nil, "OVERLAY");
				ILvl:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE");
				ILvl:SetPoint("BOTTOMRIGHT", Node, "BOTTOMRIGHT", 0, 2);
				Node.ILvl = ILvl;

				local Name = Node:CreateFontString(nil, "OVERLAY");
				Name:SetFont(GameFontNormal:GetFont(), 13);
				Node.Name = Name;

				local Ench = Node:CreateFontString(nil, "OVERLAY");
				Ench:SetFont(GameFontNormal:GetFont(), 13);
				Node.Ench = Ench;

				local Gem = Node:CreateFontString(nil, "OVERLAY");
				Gem:SetFont(GameFontNormal:GetFont(), 13);
				Node.Gem = Gem;

				Node.EquipmentFrame = EquipmentFrame;
				Node.slot = slot;
				EquipmentNodes[slot] = Node;
			end
			local L = {  1,  2,  3, 15,  5, 19,  4,  9, };
			local R = { 10,  6,  7,  8, 11, 12, 13, 14, };
			local B = { 16, 17, 18,  0, };
			for index, slot in next, L do
				local Node = EquipmentNodes[slot];
				Node:SetPoint("TOPLEFT", TUISTYLE.EquipmentNodeXToBorder, -TUISTYLE.EquipmentNodeYToBorder - (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap) * (index - 1));
				Node.Name:SetPoint("TOPLEFT", Node, "TOPRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Ench:SetPoint("LEFT", Node, "RIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Gem:SetPoint("BOTTOMLEFT", Node, "BOTTOMRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
			end
			for index, slot in next, R do
				local Node = EquipmentNodes[slot];
				Node:SetPoint("TOPRIGHT", -TUISTYLE.EquipmentNodeXToBorder, -TUISTYLE.EquipmentNodeYToBorder - (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap) * (index - 1));
				Node.Name:SetPoint("BOTTOMRIGHT", Node, "BOTTOMLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Ench:SetPoint("RIGHT", Node, "LEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Gem:SetPoint("TOPRIGHT", Node, "TOPLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
			end
			for index, slot in next, B do
				local Node = EquipmentNodes[slot];
				Node:SetPoint("BOTTOM",
					((index - 1) % 2 - 0.5) * (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap),
					(1 - floor((index - 1) / 2)) * (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap) + TUISTYLE.EquipmentNodeYToBorder);
				if (index - 1) % 2 == 0 then
					Node.Name:SetPoint("TOPRIGHT", Node, "TOPLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Ench:SetPoint("RIGHT", Node, "LEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Gem:SetPoint("BOTTOMRIGHT", Node, "BOTTOMLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
				else
					Node.Name:SetPoint("TOPLEFT", Node, "TOPRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Ench:SetPoint("LEFT", Node, "RIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Gem:SetPoint("BOTTOMLEFT", Node, "BOTTOMRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
				end
			end
			EquipmentFrame:SetScript("OnShow", EquipmentFrame_OnShow);
			EquipmentContainer.Frame = Frame;
			EquipmentContainer.EquipmentNodes = EquipmentNodes;
			EquipmentFrame.Frame = Frame;
			EquipmentFrame.EquipmentContainer = EquipmentContainer;
			EquipmentFrameContainer.Frame = Frame;
			EquipmentFrameContainer.EquipmentFrame = EquipmentFrame;
			EquipmentFrameContainer.EquipmentContainer = EquipmentContainer;
			--
			if VT.__support_glyph then
				local GlyphFrame = CreateFrame('FRAME', nil, EquipmentFrameContainer);
				GlyphFrame:SetSize(TUISTYLE.GlyphFrameSize, TUISTYLE.GlyphFrameSize);
				GlyphFrame:SetPoint("BOTTOM", EquipmentFrameContainer);
				GlyphFrame:Show();
				local GlyphContainer = CreateFrame('FRAME', nil, GlyphFrame);
				GlyphContainer:SetPoint("BOTTOM", GlyphFrame, "BOTTOM", 0, 8);
				GlyphContainer:SetSize(TUISTYLE.GlyphFrameSize, TUISTYLE.GlyphFrameSize);
				local GlyphNodes = {  };
				--[[
							1
						3		5
						6		4
							2
				--]]
				local NodesDef = {
					[0] = { 0,   0, 0.0, 0.00, 0.0, 1.0, 0.78125    , 0.91015625 , 0.69921875, 0.828125, },
					[1] = { 1,   0, 1.0, 0.25, 0.0, 1.0, 0.0        , 0.12890625 , 0.87109375, 1.0, },
					[2] = { 2, 180, 0.0, 0.25, 1.0, 1.0, 0.130859375, 0.259765625, 0.87109375, 1.0, },
					[3] = { 2, 300, 0.0, 0.25, 1.0, 1.0, 0.392578125, 0.521484375, 0.87109375, 1.0, },
					[4] = { 1, 120, 1.0, 0.25, 0.0, 1.0, 0.5234375  , 0.65234375 , 0.87109375, 1.0, },
					[5] = { 2,  60, 0.0, 0.25, 1.0, 1.0, 0.26171875 , 0.390625   , 0.87109375, 1.0, },
					[6] = { 1, 240, 1.0, 0.25, 0.0, 1.0, 0.654296875, 0.783203125, 0.87109375, 1.0, },
				};
				for index = 1, 6 do
					local def = NodesDef[index];
					local size = def[1] == 1 and TUISTYLE.MajorGlyphNodeSize or TUISTYLE.MinorGlyphNodeSize;
					local R = TUISTYLE.GlyphFrameSize * 0.5 - size * 0.5 - 2;
					local Node = CreateFrame('BUTTON', nil, GlyphContainer);
					Node:SetSize(size, size);
					Node:SetPoint("CENTER", GlyphContainer, "CENTER", R * sin360(def[2]), R * cos360(def[2]));
					Node:SetScript("OnEnter", GlyphNode_OnEnter);
					Node:SetScript("OnLeave", GlyphNode_OnLeave);
					local Setting = Node:CreateTexture(nil, "ARTWORK");
					Setting:SetSize(size * 1.2, size * 1.2);
					Setting:SetPoint("CENTER", 0, 0);
					Setting:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Setting:SetTexCoord(0.765625, 0.927734375, 0.15625, 0.31640625);
					local Background = Node:CreateTexture(nil, "BORDER");
					Background:SetSize(size * 1.2, size * 1.2);
					Background:SetPoint("CENTER", 0, 0);
					Background:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Background:SetTexCoord(0.78125, 0.91015625, 0.69921875, 0.828125);
					local Highlight = Node:CreateTexture(nil, "BORDER");
					Highlight:SetSize(size * 1.2, size * 1.2);
					Highlight:SetPoint("CENTER", 0, 0);
					Highlight:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Highlight:SetTexCoord(0.765625, 0.927734375, 0.15625, 0.31640625);
					Highlight:SetVertexColor(1.0, 1.0, 1.0, 0.25);
					Highlight:SetBlendMode("ADD");
					Highlight:Hide();
					Node:SetHighlightTexture(Highlight);
					local Glyph = Node:CreateTexture(nil, "ARTWORK");
					Glyph:SetSize(size * 0.75, size * 0.75);
					Glyph:SetPoint("CENTER", 0, 0);
					Glyph:SetTexture([[Interface\Spellbook\UI-Glyph-Rune1]]);
					Glyph:SetVertexColor(def[3], def[4], def[5], def[6]);
					Glyph:SetBlendMode("BLEND");
					Glyph:Hide();
					local Ring = Node:CreateTexture(nil, "OVERLAY");
					Ring:SetSize(size * 0.86, size * 0.86);
					Ring:SetPoint("CENTER", 0, 1);
					Ring:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Ring:SetTexCoord(0.787109375, 0.908203125, 0.033203125, 0.154296875);
					local Shine = Node:CreateTexture(nil, "OVERLAY");
					Shine:SetSize(size / 6, size / 6);
					Shine:SetPoint("CENTER", -size / 8, size / 6);
					Shine:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					Shine:SetTexCoord(0.9609375, 1.0, 0.921875, 0.9609375);
					Node.Type = def[1];
					Node.TypeText = def[1] == 1 and MAJOR_GLYPH or MINOR_GLYPH;
					Node.ID = index;
					Node.Setting = Setting;
					Node.Background = Background;
					Node.Highlight = Highlight;
					Node.Glyph = Glyph;
					Node.Shine = Shine;
					Node.def = def;
					Node.type = def[1];
					Node.d0 = NodesDef[0];
					GlyphNodes[index] = Node;
				end
				GlyphContainer.Frame = Frame;
				GlyphContainer.GlyphNodes = GlyphNodes;
				EquipmentFrameContainer.Frame = Frame;
				EquipmentFrameContainer.GlyphFrame = GlyphFrame;
				EquipmentFrameContainer.GlyphContainer = GlyphContainer;
			end
			--
			return EquipmentFrameContainer, EquipmentFrame, EquipmentContainer;
		end
	--	TreeFrame
		local function TreeNode_OnEnter(Node)
			MT.UI.SetTooltip(Node);
		end
		local function TreeNode_OnLeave(Node)
			MT.UI.HideTooltip(Node);
		end
		local function TreeNode_OnClick(Node, button)
			if IsShiftKeyDown() then
				local TreeFrame = Node.TreeFrame;
				local Frame = TreeFrame.Frame;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TalentSeq = Node.TalentSeq;
				local link = MT.GetSpellLink(TreeTDB[TalentSeq][8][TalentSet[TalentSeq] == 0 and 1 or TalentSet[TalentSeq]]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			else
				if not Node.active then
					return;
				end
				if button == "LeftButton" then
					MT.UI.TreeNodeChangePoint(Node, 1);
				elseif button == "RightButton" then
					MT.UI.TreeNodeChangePoint(Node, -1);
				end
			end
		end
		local function CreateTreeNode(TreeFrame, id)
			local Node = CreateFrame('BUTTON', nil, TreeFrame);	--	TreeFrame:GetName() .. "TreeNode" .. id
			Node:SetSize(TUISTYLE.TreeNodeSize, TUISTYLE.TreeNodeSize);

			Node:Hide();
			Node:EnableMouse(true);
			Node:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			Node:SetScript("OnClick", TreeNode_OnClick);
			Node:SetScript("OnEnter", TreeNode_OnEnter);
			Node:SetScript("OnLeave", TreeNode_OnLeave);

			Node:SetNormalTexture(TTEXTURESET.UNK);
			Node:SetPushedTexture(TTEXTURESET.UNK);
			Node:SetHighlightTexture(TTEXTURESET.SQUARE_HIGHLIGHT);
			Node:GetHighlightTexture():SetTexCoord(TTEXTURESET.ICON_HIGHLIGHT_COORD[1], TTEXTURESET.ICON_HIGHLIGHT_COORD[2], TTEXTURESET.ICON_HIGHLIGHT_COORD[3], TTEXTURESET.ICON_HIGHLIGHT_COORD[4]);
			Node:GetHighlightTexture():SetVertexColor(TTEXTURESET.ICON_HIGHLIGHT_COLOR[1], TTEXTURESET.ICON_HIGHLIGHT_COLOR[2], TTEXTURESET.ICON_HIGHLIGHT_COLOR[3], TTEXTURESET.ICON_HIGHLIGHT_COLOR[4]);

			local Split = Node:CreateFontString(nil, "ARTWORK", nil);
			Split:SetFont(TUISTYLE.TreeNodeFont, TUISTYLE.TreeNodeFontSize, TUISTYLE.TreeNodeFontOutline)
			Split:SetText("/");
			Split:SetPoint("CENTER", Node, "BOTTOMRIGHT", 0, 0);
			Node.Split = Split;
			local MaxVal = Node:CreateFontString(nil, "ARTWORK", nil);
			MaxVal:SetFont(TUISTYLE.TreeNodeFont, TUISTYLE.TreeNodeFontSize, TUISTYLE.TreeNodeFontOutline)
			MaxVal:SetText("1");
			MaxVal:SetPoint("LEFT", Split, "RIGHT", 0, 0);
			Node.MaxVal = MaxVal;
			local CurVal = Node:CreateFontString(nil, "ARTWORK", nil);
			CurVal:SetFont(TUISTYLE.TreeNodeFont, TUISTYLE.TreeNodeFontSize, TUISTYLE.TreeNodeFontOutline)
			CurVal:SetText("");
			CurVal:SetPoint("RIGHT", Split, "LEFT", 0, 0);
			Node.CurVal = CurVal;

			local Overlay = Node:CreateTexture(nil, "OVERLAY");
			Overlay:SetAllPoints();
			Overlay:SetBlendMode("ADD");
			Node.Overlay = Overlay;

			Node.TreeFrame = TreeFrame;
			Node.id = id;
			Node.active = true;

			return Node;
		end
		local function CreateTreeNodes(TreeFrame)
			local TreeNodes = {  };
			local posX = 0;
			local posY = 0;
			for id = 1, DT.MAX_NUM_TALENTS do
				local Node = CreateTreeNode(TreeFrame, id);
				Node:SetPoint("TOP", TreeFrame, "TOP", (TUISTYLE.TreeNodeSize + TUISTYLE.TreeNodeXGap) * (posX - DT.MAX_NUM_COL * 0.5 + 0.5), -TUISTYLE.TreeFrameHeaderYSize - TUISTYLE.TreeNodeYToTop - (TUISTYLE.TreeNodeSize + TUISTYLE.TreeNodeYGap) * posY);
				Node:Hide();
				TreeNodes[id] = Node;

				posX = posX + 1;
				if posX > 3 then
					posX = 0;
					posY = posY + 1;
				end
			end

			return TreeNodes;
		end
		local function TreeFrameResetButton_OnClick(ResetButton)
			local TreeFrame = ResetButton.TreeFrame;
			MT.UI.TreeFrameResetTalents(TreeFrame);
			--	MT.UI.FrameSetReadOnly(TreeFrame.Frame, false);
		end
		local function TreeFrame_OnDragStart(TreeFrame, button)
			local Frame = TreeFrame.Frame;
			if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
				Frame:StartMoving();
			end
		end
		local function TreeFrame_OnDragStop(TreeFrame, button)
			TreeFrame.Frame:StopMovingOrSizing();
		end
		function MT.UI.CreateTreeFrames(Frame)
			local TreeFrames = {  };

			for TreeIndex = 1, 3 do
				local TreeFrame = CreateFrame('FRAME', nil, Frame);	--	Frame:GetName() .. "TreeFrame" .. TreeIndex
				TreeFrame:SetSize(TUISTYLE.TreeFrameXSizeSingle, TUISTYLE.TreeFrameYSize);

				TreeFrame:Show();
				TreeFrame:EnableMouse(true);
				TreeFrame:SetMovable(true);
				TreeFrame:RegisterForDrag("LeftButton");
				--	TreeFrame:SetScript("OnShow", TreeFrame_OnShow);
				--	TreeFrame:SetScript("OnHide", TreeFrame_OnHide);
				TreeFrame:SetScript("OnDragStart", TreeFrame_OnDragStart);
				TreeFrame:SetScript("OnDragStop", TreeFrame_OnDragStop);

				local HSeq = {  };
				HSeq[1] = TreeFrame:CreateTexture(nil, "ARTWORK");
				HSeq[1]:SetHeight(TUISTYLE.TreeFrameSeqWidth);
				HSeq[1]:SetPoint("LEFT", TreeFrame, "TOPLEFT", 0, 0);
				HSeq[1]:SetPoint("RIGHT", TreeFrame, "TOPRIGHT", 0, 0);
				HSeq[1]:SetTexture(TTEXTURESET.SEP_HORIZONTAL);
				HSeq[1]:SetTexCoord(TTEXTURESET.SEP_HORIZONTAL_COORD[1], TTEXTURESET.SEP_HORIZONTAL_COORD[2], TTEXTURESET.SEP_HORIZONTAL_COORD[3], TTEXTURESET.SEP_HORIZONTAL_COORD[4]);
				HSeq[2] = TreeFrame:CreateTexture(nil, "ARTWORK");
				HSeq[2]:SetHeight(TUISTYLE.TreeFrameSeqWidth);
				HSeq[2]:SetPoint("LEFT", TreeFrame, "BOTTOMLEFT", 0, 0);
				HSeq[2]:SetPoint("RIGHT", TreeFrame, "BOTTOMRIGHT", 0, 0);
				HSeq[2]:SetTexture(TTEXTURESET.SEP_HORIZONTAL);
				HSeq[2]:SetTexCoord(TTEXTURESET.SEP_HORIZONTAL_COORD[1], TTEXTURESET.SEP_HORIZONTAL_COORD[2], TTEXTURESET.SEP_HORIZONTAL_COORD[3], TTEXTURESET.SEP_HORIZONTAL_COORD[4]);
				HSeq[3] = TreeFrame:CreateTexture(nil, "ARTWORK");
				HSeq[3]:SetHeight(TUISTYLE.TreeFrameSeqWidth);
				HSeq[3]:SetPoint("LEFT", TreeFrame, "BOTTOMLEFT", 0, TUISTYLE.TreeFrameFooterYSize);
				HSeq[3]:SetPoint("RIGHT", TreeFrame, "BOTTOMRIGHT", 0, TUISTYLE.TreeFrameFooterYSize);
				HSeq[3]:SetTexture(TTEXTURESET.SEP_HORIZONTAL);
				HSeq[3]:SetTexCoord(TTEXTURESET.SEP_HORIZONTAL_COORD[1], TTEXTURESET.SEP_HORIZONTAL_COORD[2], TTEXTURESET.SEP_HORIZONTAL_COORD[3], TTEXTURESET.SEP_HORIZONTAL_COORD[4]);
				TreeFrame.HSeq = HSeq;

				local VSep = {  };
				VSep[1] = TreeFrame:CreateTexture(nil, "ARTWORK");
				VSep[1]:SetWidth(TUISTYLE.TreeFrameSeqWidth);
				VSep[1]:SetPoint("TOP", TreeFrame, "TOPLEFT", 0, 0);
				VSep[1]:SetPoint("BOTTOM", TreeFrame, "BOTTOMLEFT", 0, 0);
				VSep[1]:SetTexture(TTEXTURESET.SEP_VERTICAL);
				VSep[1]:SetTexCoord(TTEXTURESET.SEP_VERTICAL_COORD[1], TTEXTURESET.SEP_VERTICAL_COORD[2], TTEXTURESET.SEP_VERTICAL_COORD[3], TTEXTURESET.SEP_VERTICAL_COORD[4]);
				VSep[2] = TreeFrame:CreateTexture(nil, "ARTWORK");
				VSep[2]:SetWidth(TUISTYLE.TreeFrameSeqWidth);
				VSep[2]:SetPoint("TOP", TreeFrame, "TOPRIGHT", 0, 0);
				VSep[2]:SetPoint("BOTTOM", TreeFrame, "BOTTOMRIGHT", 0, 0);
				VSep[2]:SetTexture(TTEXTURESET.SEP_VERTICAL);
				VSep[2]:SetTexCoord(TTEXTURESET.SEP_VERTICAL_COORD[1], TTEXTURESET.SEP_VERTICAL_COORD[2], TTEXTURESET.SEP_VERTICAL_COORD[3], TTEXTURESET.SEP_VERTICAL_COORD[4]);
				TreeFrame.VSep = VSep;

				local BG = TreeFrame:CreateTexture(nil, "BORDER");
				BG:SetAllPoints();
				BG:SetAlpha(0.6);
				local ratio = TUISTYLE.TreeFrameXSizeSingle / TUISTYLE.TreeFrameYSize;
				if ratio > 1.0 then
					BG:SetTexCoord(0.0, 1.0, (1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5);
				elseif ratio < 1.0 then
					BG:SetTexCoord((1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5, 0.0, 1.0);
				end
				TreeFrame.BG = BG;

				TreeFrame.TreeNodes = CreateTreeNodes(TreeFrame);

				local ResetButtonBG = TreeFrame:CreateTexture(nil, "ARTWORK");
				ResetButtonBG:SetSize(TUISTYLE.TreeNodeSize, TUISTYLE.TreeNodeSize);
				ResetButtonBG:SetPoint("CENTER", TreeFrame.TreeNodes[DT.MAX_NUM_TALENTS]);
				ResetButtonBG:SetTexture(TTEXTURESET.TALENT_RESET_BG);
				ResetButtonBG:SetTexCoord(TTEXTURESET.TALENT_RESET_BG_COORD[1], TTEXTURESET.TALENT_RESET_BG_COORD[2], TTEXTURESET.TALENT_RESET_BG_COORD[3], TTEXTURESET.TALENT_RESET_BG_COORD[4]);
				ResetButtonBG:SetVertexColor(TTEXTURESET.TALENT_RESET_BG_COLOR[1], TTEXTURESET.TALENT_RESET_BG_COLOR[2], TTEXTURESET.TALENT_RESET_BG_COLOR[3], TTEXTURESET.TALENT_RESET_BG_COLOR[4]);
				TreeFrame.ResetButtonBG = ResetButtonBG;

				local ResetButton = CreateFrame('BUTTON', nil, TreeFrame);
				ResetButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				ResetButton:SetPoint("CENTER", ResetButtonBG);
				ResetButton:SetHighlightTexture(TTEXTURESET.TALENT_RESET_HIGHLIGHT);
				ResetButton:GetHighlightTexture():ClearAllPoints();
				ResetButton:GetHighlightTexture():SetPoint("CENTER");
				ResetButton:GetHighlightTexture():SetSize(TUISTYLE.TreeNodeSize, TUISTYLE.TreeNodeSize);
				ResetButton:GetHighlightTexture():SetTexCoord(TTEXTURESET.TALENT_RESET_HIGHLIGHT_COORD[1], TTEXTURESET.TALENT_RESET_HIGHLIGHT_COORD[2], TTEXTURESET.TALENT_RESET_HIGHLIGHT_COORD[3], TTEXTURESET.TALENT_RESET_HIGHLIGHT_COORD[4]);
				ResetButton:SetScript("OnClick", TreeFrameResetButton_OnClick);
				ResetButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ResetButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ResetButton.information = l10n.ResetButton;
				TreeFrame.ResetButton = ResetButton;
				ResetButton.TreeFrame = TreeFrame;

				local CurTreePoints = TreeFrame:CreateFontString(nil, "ARTWORK");
				CurTreePoints:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
				CurTreePoints:SetPoint("CENTER", ResetButton);
				CurTreePoints:SetTextColor(0.0, 1.0, 0.0, 1.0);
				CurTreePoints:SetText("0");
				TreeFrame.CurTreePoints = CurTreePoints;

				local TreeLabel = TreeFrame:CreateFontString(nil, "ARTWORK");
				TreeLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
				TreeLabel:SetPoint("CENTER", TreeFrame, "BOTTOM", 0, TUISTYLE.TreeFrameFooterYSize * 0.5);
				TreeLabel:SetTextColor(0.9, 0.9, 0.9, 1.0);
				TreeFrame.TreeLabel = TreeLabel;

				TreeFrame.Frame = Frame;
				TreeFrame.id = TreeIndex;
				TreeFrame.TalentSet = { CountByTier = {  }, Total = 0, TopAvailableTier = 0, TopCheckedTier = 0, };
				for i = 1, DT.MAX_NUM_TALENTS do
					TreeFrame.TalentSet[i] = 0;
				end
				for i = 0, DT.MAX_NUM_TIER do
					TreeFrame.TalentSet.CountByTier[i] = 0;
				end
				TreeFrame.TalentChanged = {  };
				TreeFrame.DependArrows = { used = 0, };
				TreeFrame.NodeDependArrows = {  };
				for i = 1, DT.MAX_NUM_TALENTS do
					TreeFrame.NodeDependArrows[i] = {  };
				end

				TreeFrames[TreeIndex] = TreeFrame;
			end

			return TreeFrames;
		end
	--	Frame sub objects
		--	Header
		local function ReadOnlyButton_OnClick(self, button)
			--	if button == "LeftButton" then
			--		local Frame = self.Frame;
			--		MT.UI.FrameSetReadOnly(Frame, not Frame.readOnly);
			--	elseif button == "RightButton" then
				MT.ShowMenu(self, self.Frame);
			--	end
		end
		local function CloseButton_OnClick(self, button)
			self.Frame:Hide();
		end
		local function ResetToEmuButton_OnClick(self)
			local Frame = self.Frame;
			MT.UI.FrameSetName(Frame, nil);
			MT.UI.FrameSetTalent(Frame, nil);
			MT.UI.FrameSetLevel(Frame, DT.MAX_LEVEL);
			--	MT.UI.FrameSetReadOnly(Frame, false);
			self:Hide();
		end
		local function ResetToSetButton_OnClick(self)
			local Frame = self.Frame;
			local class, level, TalData, activeGroup, name, readOnly, rule =  Frame.class, Frame.level, Frame.TalData, Frame.activeGroup, Frame.name, Frame.readOnly, Frame.rule;
			local ShowEquip = Frame.EquipmentFrameContainer:IsShown();
			MT.UI.FrameReset(Frame);
			MT.UI.FrameSetInfo(Frame, class, level, TalData, activeGroup, name, readOnly, rule);
			if ShowEquip then
				Frame.EquipmentFrameContainer:Show();
				MT.Debug("EquipFrame", "ResetToSet Show");
			end
			MT.CALLBACK.OnInventoryDataRecv(name);
			self:Hide();
		end
		VT.TalentGroupSelectMenuDefinition = {
			handler = function(button, Frame, val)
				local class, level, TalData, activeGroup, name, readOnly, rule =  Frame.class, Frame.level, Frame.TalData, Frame.activeGroup, Frame.name, Frame.readOnly, Frame.rule;
				local ShowEquip = Frame.EquipmentFrameContainer:IsShown();
				MT.UI.FrameReset(Frame);
				MT.UI.FrameSetInfo(Frame, class, level, TalData, val, name, readOnly, rule);
				if ShowEquip then
					Frame.EquipmentFrameContainer:Show();
					MT.Debug("EquipFrame", "TalentGroupSelect Show");
				end
				return MT.CALLBACK.OnInventoryDataRecv(name);
			end,
			num = 0,
		};
		local function TalentGroupSelect_OnClick(self)
			local Frame = self.Frame;
			local TalData = Frame.TalData;
			if TalData.num > 1 then
				for group = 1, TalData.num do
					local val = TalData[group];
					local stats = MT.CountTreePoints(val, Frame.class);
					VT.TalentGroupSelectMenuDefinition[group] = {
						param = group,
						text = (group == Frame.activeGroup) and ("|cff00ff00>|r " .. stats[1] .. "-" .. stats[2] .. "-" .. stats[3] .. " |cff00ff00<|r") or ("|cff000000>|r " .. stats[1] .. "-" .. stats[2] .. "-" .. stats[3] .. " |cff000000<|r"),
					};
				end
				VT.TalentGroupSelectMenuDefinition.num = TalData.num;
				VT.__menulib.ShowMenu(self, "BOTTOMRIGHT", VT.TalentGroupSelectMenuDefinition, self.Frame, false, true);
			end
		end
		--	Footer
		local function ResetAllButton_OnClick(self)
			MT.UI.FrameResetTalents(self.Frame);
			--	MT.UI.FrameSetReadOnly(self.Frame, false);
		end
		local function TreeButton_OnClick(self)
			MT.UI.TreeUpdate(self.Frame, self.id);
		end
		--	side
		VT.ClassButtonMenuDefinition = {
			handler = function(button, Frame, val)
				if IsShiftKeyDown() then
					VT.VAR.savedTalent[val[1]] = nil;
				else
					VT.ImportIndex = VT.ImportIndex + 1;
					MT.ImportCode(Frame, val[2], "#" .. l10n.import .. "[" .. VT.ImportIndex .. "] " .. val[1]);
				end
			end,
			num = 0,
		};
		local function ClassButton_OnClick(self, button)
			if button == "LeftButton" then
				local Frame = self.Frame;
				if Frame.class ~= self.class then
					MT.UI.FrameReset(Frame);
					MT.UI.FrameSetClass(Frame, self.class);
					local objects = Frame.objects;
					objects.CurClassIndicator:Show();
					objects.CurClassIndicator:ClearAllPoints();
					objects.CurClassIndicator:SetPoint("CENTER", Frame.ClassButtons[DT.ClassToIndex[Frame.class]]);
				end
			elseif button == "RightButton" then
				local class = self.class;
				if next(VT.VAR.savedTalent) == nil then
					return;
				end
				local Frame = self.Frame;
				local pos = 0;
				for title, code in next, VT.VAR.savedTalent do
					if VT.__emulib.GetClass(code) == class then
						pos = pos + 1;
						VT.ClassButtonMenuDefinition[pos] = {
							param = { title, code, },
							text = title,
						};
					end
				end
				VT.ClassButtonMenuDefinition.num = pos;
				if pos > 0 then
					VT.__menulib.ShowMenu(self, "TOPRIGHT", VT.ClassButtonMenuDefinition, Frame);
				end
			end
		end
		local function SpellListButton_OnClick(self)
			MT.UI.SpellListFrameToggle(self.Frame);
		end
		StaticPopupDialogs["TalentEmu_ApplyTalents"] = {
			text = l10n.ApplyTalentsButton_Notify,
			button1 = l10n.OK,
			button2 = l10n.Cancel,
			--	OnShow = function(self) end,
			OnAccept = function(self, Frame)
				MT.ApplyTalents(Frame);
			end,
			OnHide = function(self)
				self.which = nil;
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 1,
		};
		local function ApplyTalentsButton_OnClick(self)
			if UnitLevel('player') >= 10 then
				StaticPopup_Show("TalentEmu_ApplyTalents", nil, nil, self.Frame);
			end
		end
		local function ImportButton_OnClick(self)
			local EditBox = self.Frame.EditBox;
			if EditBox:IsShown() and EditBox.Parent == self then
				EditBox:Hide();
			else
				EditBox:ClearAllPoints();
				EditBox:SetPoint("LEFT", self, "RIGHT", TUISTYLE.EditBoxYSize + 4, 0);
				EditBox:SetText("");
				EditBox:Show();
				EditBox:SetFocus();
				EditBox.OKButton:ClearAllPoints();
				EditBox.OKButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
				--	EditBox.OKButton:Show();
				EditBox.Parent = self;
				EditBox.type = "import";
			end
		end
		VT.ExportButtonMenuDefinition = {
			handler = function(button, Frame, codec)
				local code = codec.ExportCode(Frame, codec);
				if code ~= nil then
					local EditBox = Frame.EditBox;
					EditBox:SetText(code);
					EditBox:Show();
					EditBox:SetFocus();
					EditBox:HighlightText();
					EditBox.type = "export";
				end
			end,
			num = 1,
			[1] = {
				param = MT,
				text = l10n.AllData,
			},
		};
		local function ExportButton_OnClick(self, button)
			local Frame = self.Frame;
			local EditBox = Frame.EditBox;
			if EditBox:IsShown() and EditBox.Parent == self then
				EditBox:Hide();
			else
				EditBox:ClearAllPoints();
				EditBox:SetPoint("LEFT", self, "RIGHT", 4, 0);
				EditBox.OKButton:ClearAllPoints();
				EditBox.OKButton:SetPoint("LEFT", EditBox, "RIGHT", 0, 0);
				EditBox.Parent = self;
				if button == "LeftButton" then
					EditBox:SetText(MT.EncodeTalent(Frame));
					EditBox:Show();
					EditBox:SetFocus();
					EditBox:HighlightText();
					EditBox.type = "export";
				elseif button == "RightButton" then
					if VT.ExportButtonMenuDefinition.num > 0 then
						VT.__menulib.ShowMenu(self, "TOPRIGHT", VT.ExportButtonMenuDefinition, Frame);
					end
				end
			end
		end
		VT.SaveButtonMenuDefinition = {
			handler = function(button, Frame, val)
				if IsShiftKeyDown() then
					VT.VAR.savedTalent[val[1]] = nil;
				else
					VT.ImportIndex = VT.ImportIndex + 1;
					MT.ImportCode(Frame, val[2], "#" .. l10n.import .. "[" .. VT.ImportIndex .. "] " .. val[1]);
				end
			end,
			num = 0,
		};
		VT.SaveButtonMenuAltDefinition = {
			handler = function(button, Frame, val)
				if IsShiftKeyDown() then
					VT.VAR[val[1]] = nil;
					for index = VT.SaveButtonMenuAltDefinition.num, 1, -1 do
						if VT.SaveButtonMenuAltDefinition[index].param[1] == val[1] then
							tremove(VT.SaveButtonMenuAltDefinition, index);
							VT.SaveButtonMenuAltDefinition.num = VT.SaveButtonMenuAltDefinition.num - 1;
						end
					end
				else
					VT.ImportIndex = VT.ImportIndex + 1;
					MT.ImportCode(Frame, val[2], "#" .. l10n.import .. "[" .. VT.ImportIndex .. "] " .. val[3]);
				end
			end,
			num = 0,
		}
		local function SaveButton_OnClick(self, button)
			if button == "LeftButton" then
				local Frame = self.Frame;
				local EditBox = Frame.EditBox;
				if EditBox:IsShown() and EditBox.Parent == self then
					EditBox:Hide();
				else
					EditBox:ClearAllPoints();
					EditBox:SetPoint("LEFT", self, "RIGHT", TUISTYLE.EditBoxYSize + 4, 0);
					EditBox:SetText(MT.GenerateTitleFromRawData(Frame));
					EditBox:Show();
					EditBox.OKButton:ClearAllPoints();
					EditBox.OKButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
					EditBox.Parent = self;
					EditBox.type = "save";
				end
			elseif button == "RightButton" then
				if IsAltKeyDown() then
					if VT.SaveButtonMenuAltDefinition.num > 0 then
						VT.__menulib.ShowMenu(self, "TOPRIGHT", VT.SaveButtonMenuAltDefinition, self.Frame);
					end
				else
					if next(VT.VAR.savedTalent) == nil then
						return;
					end
					local pos = 0;
					for title, code in next, VT.VAR.savedTalent do
						pos = pos + 1;
						VT.SaveButtonMenuDefinition[pos] = {
							param = { title, code, },
							text = title,
						};
					end
					VT.SaveButtonMenuDefinition.num = pos;
					if pos > 0 then
						VT.__menulib.ShowMenu(self, "TOPRIGHT", VT.SaveButtonMenuDefinition, self.Frame);
					end
				end
			end
		end
		local channel_list = {
			"PARTY",
			"GUILD",
			"RAID",
			"BATTLEGROUND",
			"WHISPER",
		};
		VT.SendButtonMenuDefinition = {
			handler = function(button, Frame, val)
				return MT.CreateEmulator(Frame, val[1], val[2], val[3], l10n.message, false, false);
			end,
			num = 0,
		};
		local function SendButton_OnClick(self, button)
			local Frame = self.Frame;
			if button == "LeftButton" then
				MT.SendTalents(Frame);
			elseif button == "RightButton" then
				if VT.SendButtonMenuDefinition.num > 0 then
					VT.__menulib.ShowMenu(self, "TOPRIGHT", VT.SendButtonMenuDefinition, Frame);
				end
			end
		end
		local function EditBox_OnEnterPressed(self)
			if self.type == nil then
				return;
			end
			local Type = self.type;
			self.type = nil;
			self:ClearFocus();
			self:Hide();
			if Type == "import" then
				local code = self:GetText();
				if code ~= nil and code ~= "" then
					for media, codec in next, VT.ExternalCodec do
						local class, level, data = codec.ImportCode(code, codec);
						if class ~= nil then
							VT.ImportIndex = VT.ImportIndex + 1;
							return MT.UI.FrameSetInfo(self.Frame, class, level, { data, nil, num = 1, active = 1, }, 1, "#" .. l10n.import .. "[" .. VT.ImportIndex .. "]");
						end
					end
					VT.ImportIndex = VT.ImportIndex + 1;
					return MT.ImportCode(self.Frame, code, "#" .. l10n.import .. "[" .. VT.ImportIndex .. "]");
				end
			elseif Type == "save" then
				local title = self:GetText();
				if title == nil or title == "" then
					title = #VT.VAR.savedTalent + 1;
				end
				VT.VAR.savedTalent[title] = MT.EncodeTalent(self.Frame);
			end
		end
		local function EditBoxOKButton_OnClick(self)
			return EditBox_OnEnterPressed(self.EditBox);
		end
		--
		local function EquipmentFrameButton_OnClick(self)
			MT.UI.EquipmentFrameToggle(self.Frame);
		end

		local function EditBox_OnEscapePressed(EditBox)
			EditBox:SetText("");
			EditBox:ClearFocus();
			EditBox:Hide();
		end
		local function EditBox_OnShow(EditBox)
			EditBox.type = nil;
			EditBox.charChanged = nil;
		end
		local function EditBox_OnHide(EditBox)
			EditBox.type = nil;
			EditBox.charChanged = nil;
		end
		local function EditBox_OnChar(EditBox)
			EditBox.charChanged = true;
		end

		function MT.UI.CreateFrameSubObject(Frame)
			local objects = {  };
			Frame.objects = objects;

			--	<Header>
				local Header = CreateFrame('FRAME', nil, Frame);
				Header:SetPoint("TOPLEFT");
				Header:SetPoint("TOPRIGHT");
				Header:SetHeight(TUISTYLE.FrameHeaderYSize);
				Frame.Header = Header;
				local HeaderBG = Header:CreateTexture(nil, "BACKGROUND");
				HeaderBG:SetAllPoints();
				HeaderBG:SetColorTexture(0.0, 0.0, 0.0, 0.5);
				Header.BG = HeaderBG;

				local ReadOnlyButton = CreateFrame('BUTTON', nil, Header);
				ReadOnlyButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				ReadOnlyButton:SetNormalTexture(TTEXTURESET.LOCK);
				ReadOnlyButton:GetNormalTexture():SetVertexColor(TTEXTURESET.LOCK_UNLOCKED_COLOR[1], TTEXTURESET.LOCK_UNLOCKED_COLOR[2], TTEXTURESET.LOCK_UNLOCKED_COLOR[3], TTEXTURESET.LOCK_UNLOCKED_COLOR[4]);
				--	ReadOnlyButton:GetNormalTexture():SetVertexColor(TTEXTURESET.LOCK_NORMAL_COLOR[1], TTEXTURESET.LOCK_NORMAL_COLOR[2], TTEXTURESET.LOCK_NORMAL_COLOR[3], TTEXTURESET.LOCK_NORMAL_COLOR[4]);
				ReadOnlyButton:SetPushedTexture(TTEXTURESET.LOCK);
				ReadOnlyButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
				ReadOnlyButton:SetHighlightTexture(TTEXTURESET.LOCK);
				ReadOnlyButton:GetHighlightTexture():SetVertexColor(TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[1], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[2], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[3], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[4]);
				ReadOnlyButton:SetPoint("CENTER", Header, "LEFT", TUISTYLE.FrameHeaderYSize * 0.5, 0);
				ReadOnlyButton:Show();
				ReadOnlyButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				ReadOnlyButton:SetScript("OnClick", ReadOnlyButton_OnClick);
				ReadOnlyButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ReadOnlyButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ReadOnlyButton.Frame = Frame;
				ReadOnlyButton.information = l10n.ReadOnlyButton;
				objects.ReadOnlyButton = ReadOnlyButton;

				local CloseButton = CreateFrame('BUTTON', nil, Header);
				CloseButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				CloseButton:SetNormalTexture(TTEXTURESET.CLOSE);
				CloseButton:GetNormalTexture():SetTexCoord(TTEXTURESET.CLOSE_COORD[1], TTEXTURESET.CLOSE_COORD[2], TTEXTURESET.CLOSE_COORD[3], TTEXTURESET.CLOSE_COORD[4]);
				CloseButton:GetNormalTexture():SetVertexColor(TTEXTURESET.CLOSE_NORMAL_COLOR[1], TTEXTURESET.CLOSE_NORMAL_COLOR[2], TTEXTURESET.CLOSE_NORMAL_COLOR[3], TTEXTURESET.CLOSE_NORMAL_COLOR[4]);
				CloseButton:SetPushedTexture(TTEXTURESET.CLOSE);
				CloseButton:GetPushedTexture():SetTexCoord(TTEXTURESET.CLOSE_COORD[1], TTEXTURESET.CLOSE_COORD[2], TTEXTURESET.CLOSE_COORD[3], TTEXTURESET.CLOSE_COORD[4]);
				CloseButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
				CloseButton:SetHighlightTexture(TTEXTURESET.CLOSE);
				CloseButton:GetHighlightTexture():SetTexCoord(TTEXTURESET.CLOSE_COORD[1], TTEXTURESET.CLOSE_COORD[2], TTEXTURESET.CLOSE_COORD[3], TTEXTURESET.CLOSE_COORD[4]);
				CloseButton:GetHighlightTexture():SetVertexColor(TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[1], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[2], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[3], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[4]);
				CloseButton:SetPoint("CENTER", Header, "RIGHT", -TUISTYLE.FrameHeaderYSize * 0.5, 0);
				CloseButton:Show();
				CloseButton:SetScript("OnClick", CloseButton_OnClick);
				CloseButton:SetScript("OnEnter", MT.GeneralOnEnter);
				CloseButton:SetScript("OnLeave", MT.GeneralOnLeave);
				CloseButton.Frame = Frame;
				CloseButton.information = l10n.CloseButton;
				objects.CloseButton = CloseButton;

				local Name = Header:CreateFontString(nil, "ARTWORK");
				Name:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
				Name:SetText(l10n.Emu);
				Name:SetPoint("CENTER", Header, "CENTER", 0, 0);
				Name.Points1 = { "CENTER", Header, "CENTER", 0, 0, };
				Name.Points2 = { "BOTTOM", Header, "TOP", 0, 4, };
				objects.Name = Name;

				local ResetToEmuButton = CreateFrame('BUTTON', nil, Header);
				ResetToEmuButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				ResetToEmuButton:SetNormalTexture(TTEXTURESET.CLOSE);
				ResetToEmuButton:GetNormalTexture():SetTexCoord(TTEXTURESET.CLOSE_COORD[1], TTEXTURESET.CLOSE_COORD[2], TTEXTURESET.CLOSE_COORD[3], TTEXTURESET.CLOSE_COORD[4]);
				ResetToEmuButton:SetPushedTexture(TTEXTURESET.CLOSE);
				ResetToEmuButton:GetPushedTexture():SetTexCoord(TTEXTURESET.CLOSE_COORD[1], TTEXTURESET.CLOSE_COORD[2], TTEXTURESET.CLOSE_COORD[3], TTEXTURESET.CLOSE_COORD[4]);
				ResetToEmuButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
				ResetToEmuButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
				ResetToEmuButton:SetFrameLevel(ResetToEmuButton:GetFrameLevel() + 1);
				ResetToEmuButton:SetPoint("RIGHT", Name, "LEFT", 0, 0);
				ResetToEmuButton:SetScript("OnClick", ResetToEmuButton_OnClick);
				ResetToEmuButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ResetToEmuButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ResetToEmuButton.Frame = Frame;
				ResetToEmuButton.information = l10n.ResetToEmuButton;
				objects.ResetToEmuButton = ResetToEmuButton;

				local PackLabel = Header:CreateFontString(nil, "ARTWORK");
				PackLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
				PackLabel:SetText("");
				PackLabel:SetPoint("BOTTOM", Name, "TOP", 0, 4);
				PackLabel:Hide();
				objects.PackLabel = PackLabel;

				local Label = Header:CreateFontString(nil, "ARTWORK");
				Label:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
				Label:SetPoint("CENTER", Header, "CENTER", 0, 0);
				Label:Hide();
				objects.Label = Label;

				local ResetToSetButton = CreateFrame('BUTTON', nil, Header);
				ResetToSetButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				ResetToSetButton:SetNormalTexture(TTEXTURESET.RESET);
				ResetToSetButton:GetNormalTexture():SetTexCoord(TTEXTURESET.RESET_COORD[1], TTEXTURESET.RESET_COORD[2], TTEXTURESET.RESET_COORD[3], TTEXTURESET.RESET_COORD[4]);
				ResetToSetButton:SetPushedTexture(TTEXTURESET.RESET);
				ResetToSetButton:GetPushedTexture():SetTexCoord(TTEXTURESET.RESET_COORD[1], TTEXTURESET.RESET_COORD[2], TTEXTURESET.RESET_COORD[3], TTEXTURESET.RESET_COORD[4]);
				ResetToSetButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
				ResetToSetButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
				ResetToSetButton:SetFrameLevel(ResetToSetButton:GetFrameLevel() + 1);
				ResetToSetButton:SetPoint("LEFT", Label, "RIGHT", 0, 0);
				ResetToSetButton:SetScript("OnClick", ResetToSetButton_OnClick);
				ResetToSetButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ResetToSetButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ResetToSetButton.Frame = Frame;
				ResetToSetButton.information = l10n.ResetToSetButton;
				objects.ResetToSetButton = ResetToSetButton;

				local TalentGroupSelect = CreateFrame('BUTTON', nil, Header);
				TalentGroupSelect:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				TalentGroupSelect:SetNormalTexture(TTEXTURESET.DROP);
				-- TalentGroupSelect:GetNormalTexture():SetTexCoord(TTEXTURESET.RESET_COORD[1], TTEXTURESET.RESET_COORD[2], TTEXTURESET.RESET_COORD[3], TTEXTURESET.RESET_COORD[4]);
				TalentGroupSelect:SetPushedTexture(TTEXTURESET.DROP);
				-- TalentGroupSelect:GetPushedTexture():SetTexCoord(TTEXTURESET.RESET_COORD[1], TTEXTURESET.RESET_COORD[2], TTEXTURESET.RESET_COORD[3], TTEXTURESET.RESET_COORD[4]);
				TalentGroupSelect:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
				TalentGroupSelect:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
				TalentGroupSelect:SetPoint("RIGHT", Label, "LEFT", 0, 0);
				TalentGroupSelect:SetScript("OnClick", TalentGroupSelect_OnClick);
				TalentGroupSelect:SetScript("OnEnter", MT.GeneralOnEnter);
				TalentGroupSelect:SetScript("OnLeave", MT.GeneralOnLeave);
				TalentGroupSelect:Hide();
				TalentGroupSelect.Frame = Frame;
				TalentGroupSelect.information = l10n.TalentGroupSelect;
				objects.TalentGroupSelect = TalentGroupSelect;
			--	</Header>

			--	<Footer>
				--	Control
					local ResetAllButton = CreateFrame('BUTTON', nil, Frame);
					ResetAllButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
					ResetAllButton:SetNormalTexture(TTEXTURESET.RESET);
					ResetAllButton:GetNormalTexture():SetTexCoord(TTEXTURESET.RESET_COORD[1], TTEXTURESET.RESET_COORD[2], TTEXTURESET.RESET_COORD[3], TTEXTURESET.RESET_COORD[4]);
					ResetAllButton:SetPushedTexture(TTEXTURESET.RESET);
					ResetAllButton:GetPushedTexture():SetTexCoord(TTEXTURESET.RESET_COORD[1], TTEXTURESET.RESET_COORD[2], TTEXTURESET.RESET_COORD[3], TTEXTURESET.RESET_COORD[4]);
					ResetAllButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					ResetAllButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					ResetAllButton:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -8, (TUISTYLE.FrameFooterYSize - TUISTYLE.ControlButtonSize) * 0.5);
					ResetAllButton:Show();
					ResetAllButton:SetScript("OnClick", ResetAllButton_OnClick);
					ResetAllButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ResetAllButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ResetAllButton.Frame = Frame;
					ResetAllButton.information = l10n.ResetAllButton;
					objects.ResetAllButton = ResetAllButton;

					local CurPointsRemainingLabel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsRemainingLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeSmall, TUISTYLE.FrameFontOutline);
					CurPointsRemainingLabel:SetText(l10n.CurPointsRemaining);
					CurPointsRemainingLabel:SetPoint("CENTER", Frame, "BOTTOM", -15, TUISTYLE.FrameFooterYSize * 0.5);
					local CurPointsRemaining = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsRemaining:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
					CurPointsRemaining:SetText("51");
					CurPointsRemaining:SetPoint("LEFT", CurPointsRemainingLabel, "RIGHT", 2, 0);
					CurPointsRemainingLabel:SetTextColor(0.5, 1.0, 1.0, 1.0);
					CurPointsRemaining:SetTextColor(0.5, 1.0, 1.0, 1.0);

					local CurPointsUsed = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsUsed:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
					CurPointsUsed:SetText("0");
					CurPointsUsed:SetPoint("RIGHT", CurPointsRemainingLabel, "LEFT", -8, 0);
					local CurPointsUsedLabel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsUsedLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
					CurPointsUsedLabel:SetText(l10n.CurPointsUsed);
					CurPointsUsedLabel:SetPoint("RIGHT", CurPointsUsed, "LEFT", -2, 0);
					CurPointsUsedLabel:SetTextColor(0.5, 1.0, 0.5, 1.0);
					CurPointsUsed:SetTextColor(0.5, 1.0, 0.5, 1.0);

					local CurPointsReqLevelLabel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsReqLevelLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
					CurPointsReqLevelLabel:SetText(l10n.CurPointsReqLevel);
					CurPointsReqLevelLabel:SetPoint("LEFT", CurPointsRemaining, "RIGHT", 8, 0);
					local CurPointsReqLevel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsReqLevel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMid, TUISTYLE.FrameFontOutline);
					CurPointsReqLevel:SetText("10");
					CurPointsReqLevel:SetPoint("LEFT", CurPointsReqLevelLabel, "RIGHT", 2, 0);
					CurPointsReqLevelLabel:SetTextColor(1.0, 1.0, 0.5, 1.0);
					CurPointsReqLevel:SetTextColor(1.0, 1.0, 0.5, 1.0);

					objects.CurPointsRemainingLabel = CurPointsRemainingLabel;
					objects.CurPointsRemaining = CurPointsRemaining;
					objects.CurPointsUsedLabel = CurPointsUsedLabel;
					objects.CurPointsUsed = CurPointsUsed;
					objects.CurPointsReqLevelLabel = CurPointsReqLevelLabel;
					objects.CurPointsReqLevel = CurPointsReqLevel;
				--

				--	Tree
					local TreeButtonsBar = CreateFrame('FRAME', nil, Frame);
					TreeButtonsBar:SetPoint("CENTER", Frame, "BOTTOM", 0, TUISTYLE.FrameFooterYSize + TUISTYLE.TreeFrameFooterYSize * 0.5);
					TreeButtonsBar:SetSize(TUISTYLE.TreeButtonXSize * 3 + TUISTYLE.TreeButtonGap * 2, TUISTYLE.TreeButtonYSize);
					Frame.TreeButtonsBar = TreeButtonsBar;
					local TreeButtons = {  };
					for TreeIndex = 1, 3 do
						local TreeButton = CreateFrame('BUTTON', nil, TreeButtonsBar);
						TreeButton:SetSize(TUISTYLE.TreeButtonXSize, TUISTYLE.TreeButtonYSize);
						TreeButton:SetNormalTexture(TTEXTURESET.UNK);
						TreeButton:GetNormalTexture():SetTexCoord(TUISTYLE.TreeButtonTexCoord[1], TUISTYLE.TreeButtonTexCoord[2], TUISTYLE.TreeButtonTexCoord[3], TUISTYLE.TreeButtonTexCoord[4]);
						TreeButton:GetNormalTexture():SetVertexColor(TTEXTURESET.SPEC_NORMAL_COLOR[1], TTEXTURESET.SPEC_NORMAL_COLOR[2], TTEXTURESET.SPEC_NORMAL_COLOR[3], TTEXTURESET.SPEC_NORMAL_COLOR[4]);
						TreeButton:SetPushedTexture(TTEXTURESET.UNK);
						TreeButton:GetPushedTexture():SetTexCoord(TUISTYLE.TreeButtonTexCoord[1], TUISTYLE.TreeButtonTexCoord[2], TUISTYLE.TreeButtonTexCoord[3], TUISTYLE.TreeButtonTexCoord[4]);
						TreeButton:GetPushedTexture():SetVertexColor(TTEXTURESET.SPEC_PUSHED_COLOR[1], TTEXTURESET.SPEC_PUSHED_COLOR[2], TTEXTURESET.SPEC_PUSHED_COLOR[3], TTEXTURESET.SPEC_PUSHED_COLOR[4]);
						TreeButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
						TreeButton:GetHighlightTexture():SetTexCoord(TUISTYLE.TreeButtonTexCoord[1], TUISTYLE.TreeButtonTexCoord[2], TUISTYLE.TreeButtonTexCoord[3], TUISTYLE.TreeButtonTexCoord[4]);
						TreeButton:Show();
						TreeButton:SetScript("OnClick", TreeButton_OnClick);
						TreeButton:SetScript("OnEnter", MT.GeneralOnEnter);
						TreeButton:SetScript("OnLeave", MT.GeneralOnLeave);
						TreeButton.id = TreeIndex;
						TreeButton.information = nil;
						local Title = TreeButton:CreateFontString(nil, "OVERLAY");
						Title:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeSmall, "OUTLINE");
						Title:SetTextColor(0.9, 0.9, 0.9, 1.0);
						Title:SetPoint("CENTER");
						Title:SetWidth(TUISTYLE.TreeButtonXSize);
						Title:SetMaxLines(1);
						TreeButton.Frame = Frame;
						TreeButton.Title = Title;
						TreeButtons[TreeIndex] = TreeButton;
					end
					TreeButtons[2]:SetPoint("CENTER", TreeButtonsBar, "CENTER", 0, 0);
					TreeButtons[1]:SetPoint("RIGHT", TreeButtons[2], "LEFT", -TUISTYLE.TreeButtonGap, 0);
					TreeButtons[3]:SetPoint("LEFT", TreeButtons[2], "RIGHT", TUISTYLE.TreeButtonGap, 0);
					Frame.TreeButtons = TreeButtons;

					local CurTreeIndicator = TreeButtonsBar:CreateTexture(nil, "OVERLAY");
					CurTreeIndicator:SetSize(TUISTYLE.TreeButtonXSize + 4, TUISTYLE.TreeButtonYSize + 4);
					CurTreeIndicator:SetBlendMode("ADD");
					CurTreeIndicator:SetTexture(TTEXTURESET.SQUARE_HIGHLIGHT);
					CurTreeIndicator:SetTexCoord(TTEXTURESET.SPEC_INDICATOR_COORD[1], TTEXTURESET.SPEC_INDICATOR_COORD[2], TTEXTURESET.SPEC_INDICATOR_COORD[3], TTEXTURESET.SPEC_INDICATOR_COORD[4]);
					CurTreeIndicator:SetVertexColor(TTEXTURESET.SPEC_INDICATOR_COLOR[1], TTEXTURESET.SPEC_INDICATOR_COLOR[2], TTEXTURESET.SPEC_INDICATOR_COLOR[3], TTEXTURESET.SPEC_INDICATOR_COLOR[4]);
					CurTreeIndicator:Hide();
					TreeButtonsBar.CurTreeIndicator = CurTreeIndicator;
				--
			--	</Footer>

			--	<Side>
				local SideAnchorTop = CreateFrame('FRAME', nil, Frame);
				SideAnchorTop:SetWidth(1);
				Frame.SideAnchorTop = SideAnchorTop;
				SideAnchorTop:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorTop:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
				--	Class
					local ClassButtons = {  };--DT.IndexToClass
					for index = 1, #DT.IndexToClass do
						local class = DT.IndexToClass[index];
						local ClassButton = CreateFrame('BUTTON', nil, SideAnchorTop);
						ClassButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
						ClassButton:SetNormalTexture(TTEXTURESET.CLASS);
						ClassButton:SetPushedTexture(TTEXTURESET.CLASS);
						ClassButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
						local coord = CLASS_ICON_TCOORDS[class];
						if coord then
							ClassButton:GetNormalTexture():SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
							ClassButton:GetPushedTexture():SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 0 / 256, coord[4] - 2 / 256);
						else
							ClassButton:GetNormalTexture():SetTexCoord(0.75, 1.00, 0.75, 1.00);
							ClassButton:GetPushedTexture():SetTexCoord(0.75, 1.00, 0.75, 1.00);
						end
						ClassButton:SetHighlightTexture(TTEXTURESET.CLASS_HIGHLIGHT);
						ClassButton:GetHighlightTexture():SetTexCoord(TTEXTURESET.CLASS_HIGHLIGHT_COORD[1], TTEXTURESET.CLASS_HIGHLIGHT_COORD[2], TTEXTURESET.CLASS_HIGHLIGHT_COORD[3], TTEXTURESET.CLASS_HIGHLIGHT_COORD[4]);
						ClassButton:GetHighlightTexture():SetVertexColor(TTEXTURESET.CLASS_HIGHLIGHT_COLOR[1], TTEXTURESET.CLASS_HIGHLIGHT_COLOR[2], TTEXTURESET.CLASS_HIGHLIGHT_COLOR[3], TTEXTURESET.CLASS_HIGHLIGHT_COLOR[4]);
						ClassButton:SetPoint("TOPLEFT", SideAnchorTop, "TOPLEFT", 0, -(TUISTYLE.SideButtonSize + TUISTYLE.SideButtonGap) * (index - 1));
						ClassButton:Show();
						ClassButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
						ClassButton:SetScript("OnClick", ClassButton_OnClick);
						ClassButton:SetScript("OnEnter", MT.GeneralOnEnter);
						ClassButton:SetScript("OnLeave", MT.GeneralOnLeave);
						ClassButton.id = index;
						ClassButton.class = class;
						ClassButton.Frame = Frame;
						ClassButton.information = "|c" .. RAID_CLASS_COLORS[class].colorStr .. l10n.DATA[class] .. "|r" .. l10n.ClassButton;
						ClassButtons[index] = ClassButton;
					end
					Frame.ClassButtons = ClassButtons;

					local CurClassIndicator = Frame:CreateTexture(nil, "OVERLAY");
					CurClassIndicator:SetSize(TUISTYLE.CurClassIndicatorSize, TUISTYLE.CurClassIndicatorSize);
					CurClassIndicator:SetBlendMode("ADD");
					CurClassIndicator:SetTexture(TTEXTURESET.CLASS_INDICATOR);
					CurClassIndicator:SetTexCoord(TTEXTURESET.CLASS_INDICATOR_COORD[1], TTEXTURESET.CLASS_INDICATOR_COORD[2], TTEXTURESET.CLASS_INDICATOR_COORD[3], TTEXTURESET.CLASS_INDICATOR_COORD[4]);
					CurClassIndicator:SetVertexColor(TTEXTURESET.CLASS_INDICATOR_COLOR[1], TTEXTURESET.CLASS_INDICATOR_COLOR[2], TTEXTURESET.CLASS_INDICATOR_COLOR[3], TTEXTURESET.CLASS_INDICATOR_COLOR[4]);
					CurClassIndicator:Show();
					Frame.objects.CurClassIndicator = CurClassIndicator;
				--

				local SideAnchorBottom = CreateFrame('FRAME', nil, Frame);
				SideAnchorBottom:SetWidth(1);
				Frame.SideAnchorBottom = SideAnchorBottom;
				SideAnchorBottom:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
				--	Control
					local SpellListButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SpellListButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					SpellListButton:SetNormalTexture(TTEXTURESET.SPELLTAB);
					SpellListButton:GetNormalTexture():SetTexCoord(TTEXTURESET.SPELLTAB_COORD[1], TTEXTURESET.SPELLTAB_COORD[2], TTEXTURESET.SPELLTAB_COORD[3], TTEXTURESET.SPELLTAB_COORD[4]);
					SpellListButton:SetPushedTexture(TTEXTURESET.SPELLTAB);
					SpellListButton:GetPushedTexture():SetTexCoord(TTEXTURESET.SPELLTAB_COORD[1], TTEXTURESET.SPELLTAB_COORD[2], TTEXTURESET.SPELLTAB_COORD[3], TTEXTURESET.SPELLTAB_COORD[4]);
					SpellListButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					SpellListButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					SpellListButton:SetPoint("BOTTOMLEFT", SideAnchorBottom, "BOTTOMLEFT", 0, 0);
					SpellListButton:Show();
					SpellListButton:SetScript("OnClick", SpellListButton_OnClick);
					SpellListButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SpellListButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SpellListButton.Frame = Frame;
					SpellListButton.information = l10n.SpellListButton;
					Frame.SpellListButton = SpellListButton;

					local ApplyTalentsButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					ApplyTalentsButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					ApplyTalentsButton:SetNormalTexture(TTEXTURESET.APPLY);
					ApplyTalentsButton:SetPushedTexture(TTEXTURESET.APPLY);
					ApplyTalentsButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					ApplyTalentsButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					ApplyTalentsButton:SetDisabledTexture(TTEXTURESET.APPLY);
					ApplyTalentsButton:GetDisabledTexture():SetVertexColor(TTEXTURESET.CONTROL_DISABLED_COLOR[1], TTEXTURESET.CONTROL_DISABLED_COLOR[2], TTEXTURESET.CONTROL_DISABLED_COLOR[3], TTEXTURESET.CONTROL_DISABLED_COLOR[4]);
					ApplyTalentsButton:SetPoint("BOTTOM", SpellListButton, "TOP", 0, TUISTYLE.SideButtonGap);
					ApplyTalentsButton:Show();
					ApplyTalentsButton:SetScript("OnClick", ApplyTalentsButton_OnClick);
					ApplyTalentsButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ApplyTalentsButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ApplyTalentsButton.Frame = Frame;
					ApplyTalentsButton.information = l10n.ApplyTalentsButton;
					Frame.ApplyTalentsButton = ApplyTalentsButton;
					local ApplyTalentsButtonProgress = ApplyTalentsButton:CreateFontString(nil, "ARTWORK");
					ApplyTalentsButtonProgress:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeSmall, TUISTYLE.FrameFontOutline);
					ApplyTalentsButtonProgress:SetPoint("LEFT", ApplyTalentsButton, "RIGHT", 4, 0);
					ApplyTalentsButton.Progress = ApplyTalentsButtonProgress;
					Frame.ApplyTalentsProgress = ApplyTalentsButtonProgress;

					local EditBox = CreateFrame('EDITBOX', nil, Frame);
					EditBox:SetSize(TUISTYLE.EditBoxXSize, TUISTYLE.EditBoxYSize);
					EditBox:SetFontObject(GameFontHighlightSmall);
					EditBox:SetAutoFocus(false);
					EditBox:SetJustifyH("LEFT");
					EditBox:Hide();
					EditBox:EnableMouse(true);
					EditBox:SetScript("OnEnterPressed", EditBox_OnEnterPressed);
					EditBox:SetScript("OnEscapePressed", EditBox_OnEscapePressed);
					EditBox:SetScript("OnShow", EditBox_OnShow);
					EditBox:SetScript("OnHide", EditBox_OnHide);
					EditBox:SetScript("OnChar", EditBox_OnChar);
					EditBox.Frame = Frame;
					Frame.EditBox = EditBox;
					local Texture = EditBox:CreateTexture(nil, "ARTWORK");
					Texture:SetPoint("TOPLEFT");
					Texture:SetPoint("BOTTOMRIGHT");
					Texture:SetTexture("Interface\\Buttons\\buttonhilight-square");
					Texture:SetTexCoord(0.25, 0.75, 0.25, 0.75);
					Texture:SetAlpha(0.36);
					Texture:SetVertexColor(1.0, 1.0, 1.0);
					EditBox.Texture = Texture;
					local EditBoxOKButton = CreateFrame('BUTTON', nil, EditBox);
					EditBoxOKButton:SetSize(TUISTYLE.EditBoxYSize, TUISTYLE.EditBoxYSize);
					EditBoxOKButton:SetNormalTexture(TTEXTURESET.EDIT_OK);
					EditBoxOKButton:SetPushedTexture(TTEXTURESET.EDIT_OK);
					EditBoxOKButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					EditBoxOKButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					EditBoxOKButton:SetPoint("LEFT", EditBox, "RIGHT", 0, 4);
					EditBoxOKButton:Show();
					EditBoxOKButton:SetScript("OnClick", EditBoxOKButton_OnClick);
					EditBoxOKButton:SetScript("OnEnter", MT.GeneralOnEnter);
					EditBoxOKButton:SetScript("OnLeave", MT.GeneralOnLeave);
					EditBoxOKButton.EditBox = EditBox;
					EditBoxOKButton.information = l10n.EditBoxOKButton;
					EditBox.OKButton = EditBoxOKButton;

					local ImportButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					ImportButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					ImportButton:SetNormalTexture(TTEXTURESET.IMPORT);
					ImportButton:GetNormalTexture():SetTexCoord(TTEXTURESET.IMPORT_COORD[1], TTEXTURESET.IMPORT_COORD[2], TTEXTURESET.IMPORT_COORD[3], TTEXTURESET.IMPORT_COORD[4]);
					ImportButton:SetPushedTexture(TTEXTURESET.IMPORT);
					ImportButton:GetPushedTexture():SetTexCoord(TTEXTURESET.IMPORT_COORD[1], TTEXTURESET.IMPORT_COORD[2], TTEXTURESET.IMPORT_COORD[3], TTEXTURESET.IMPORT_COORD[4]);
					ImportButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					ImportButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					ImportButton:SetPoint("BOTTOM", ApplyTalentsButton, "TOP", 0, TUISTYLE.SideButtonGap);
					ImportButton:Show();
					ImportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					ImportButton:SetScript("OnClick", ImportButton_OnClick);
					ImportButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ImportButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ImportButton.Frame = Frame;
					ImportButton.information = l10n.ImportButton;
					Frame.ImportButton = ImportButton;

					local ExportButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					ExportButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					ExportButton:SetNormalTexture(TTEXTURESET.EXPORT);
					ExportButton:GetNormalTexture():SetTexCoord(TTEXTURESET.EXPORT_COORD[1], TTEXTURESET.EXPORT_COORD[2], TTEXTURESET.EXPORT_COORD[3], TTEXTURESET.EXPORT_COORD[4]);
					ExportButton:SetPushedTexture(TTEXTURESET.EXPORT);
					ExportButton:GetPushedTexture():SetTexCoord(TTEXTURESET.EXPORT_COORD[1], TTEXTURESET.EXPORT_COORD[2], TTEXTURESET.EXPORT_COORD[3], TTEXTURESET.EXPORT_COORD[4]);
					ExportButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					ExportButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					ExportButton:SetPoint("BOTTOM", ImportButton, "TOP", 0, TUISTYLE.SideButtonGap);
					ExportButton:Show();
					ExportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					ExportButton:SetScript("OnClick", ExportButton_OnClick);
					ExportButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ExportButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ExportButton.Frame = Frame;
					ExportButton.information = l10n.ExportButton;
					Frame.ExportButton = ExportButton;

					local SaveButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SaveButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					SaveButton:SetNormalTexture(TTEXTURESET.SAVE);
					SaveButton:SetPushedTexture(TTEXTURESET.SAVE);
					SaveButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					SaveButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					SaveButton:SetPoint("BOTTOM", ExportButton, "TOP", 0, TUISTYLE.SideButtonGap);
					SaveButton:Show();
					SaveButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					SaveButton:SetScript("OnClick", SaveButton_OnClick);
					SaveButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SaveButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SaveButton.Frame = Frame;
					SaveButton.information = l10n.SaveButton;
					Frame.SaveButton = SaveButton;

					local SendButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SendButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					SendButton:SetNormalTexture(TTEXTURESET.SEND);
					SendButton:SetPushedTexture(TTEXTURESET.SEND);
					SendButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					SendButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					SendButton:SetPoint("BOTTOM", SaveButton, "TOP", 0, TUISTYLE.SideButtonGap);
					SendButton:Show();
					SendButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					SendButton:SetScript("OnClick", SendButton_OnClick);
					SendButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SendButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SendButton.Frame = Frame;
					SendButton.information = l10n.SendButton;
					Frame.SendButton = SendButton;
				--

				--	Left
					local EquipmentFrameButton = CreateFrame('BUTTON', nil, Frame);
					EquipmentFrameButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					EquipmentFrameButton:SetNormalTexture(TTEXTURESET.EQUIPMENT_TEXTURE);
					EquipmentFrameButton:GetNormalTexture():SetTexCoord(TTEXTURESET.EQUIPMENT_TEXTURE_COORD[1], TTEXTURESET.EQUIPMENT_TEXTURE_COORD[2], TTEXTURESET.EQUIPMENT_TEXTURE_COORD[3], TTEXTURESET.EQUIPMENT_TEXTURE_COORD[4]);
					EquipmentFrameButton:SetPushedTexture(TTEXTURESET.EQUIPMENT_TEXTURE);
					EquipmentFrameButton:GetPushedTexture():SetTexCoord(TTEXTURESET.EQUIPMENT_TEXTURE_COORD[1], TTEXTURESET.EQUIPMENT_TEXTURE_COORD[2], TTEXTURESET.EQUIPMENT_TEXTURE_COORD[3], TTEXTURESET.EQUIPMENT_TEXTURE_COORD[4]);
					EquipmentFrameButton:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
					EquipmentFrameButton:SetHighlightTexture(TTEXTURESET.NORMAL_HIGHLIGHT);
					EquipmentFrameButton:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", -2, 0);
					EquipmentFrameButton:Hide();
					EquipmentFrameButton:SetScript("OnClick", EquipmentFrameButton_OnClick);
					EquipmentFrameButton:SetScript("OnEnter", MT.GeneralOnEnter);
					EquipmentFrameButton:SetScript("OnLeave", MT.GeneralOnLeave);
					EquipmentFrameButton.information = l10n.EquipmentFrameButton;
					EquipmentFrameButton.Frame = Frame;
					Frame.objects.EquipmentFrameButton = EquipmentFrameButton;
				--
			--	</Side>

		end
	--	Frame
		local function Frame_OnSizeChanged(Frame, width, height)
			width = Frame:GetWidth();
			height = Frame:GetHeight();
			--	BG 0,512;0,360
			local ratio = height / width;
			if ratio > 360 / 512 then
				Frame.BG:SetTexCoord(0.5 - 180 / 512 / ratio, 0.5 + 180 / 512 / ratio, 0.0, 360 / 512);
			elseif ratio < 360 / 512 then
				Frame.BG:SetTexCoord(0.0, 1.0, 180 / 512 - ratio / 2, 180 / 512 + ratio / 2);
			else
				Frame.BG:SetTexCoord(0.0, 1.0, 0.0, 360 / 512);
			end
			MT.UI.TreeFrameUpdateSize(Frame, width, height);
			for _, obj in next, Frame.objects do
				obj:SetScale(Frame.TreeFrameScale);
			end
			Frame.TreeButtonsBar:SetScale(Frame.TreeFrameScale);
			Frame.SideAnchorTop:SetScale(Frame.TreeFrameScale);
			Frame.SideAnchorBottom:SetScale(Frame.TreeFrameScale);
			Frame.SpellListFrameContainer:SetWidth(TUISTYLE.SpellListFrameXSize * Frame.TreeFrameScale);
			Frame.EquipmentFrameContainer:SetWidth(TUISTYLE.EquipmentFrameXSize * Frame.TreeFrameScale);
			Frame.SpellListFrame:SetScale(Frame.TreeFrameScale);
			Frame.SpellListFrame:SetHeight(Frame:GetHeight() / Frame.TreeFrameScale);
			Frame.EquipmentFrame:SetScale(Frame.TreeFrameScale);
			Frame.EquipmentFrame:SetHeight(Frame:GetHeight() / Frame.TreeFrameScale);
			if VT.__support_glyph then
				Frame.GlyphFrame:SetScale(Frame.TreeFrameScale);
			end
		end
		local function Frame_OnMouseDown(Frame, button)
			if button == "LeftButton" then
				if VT.SET.resizable_border then
					if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
						local x, y = GetCursorPosition();
						local s = Frame:GetEffectiveScale();
						x = x / s;
						y = y / s;
						local bottom = Frame:GetBottom();
						local top = Frame:GetTop();
						local left = Frame:GetLeft();
						local right = Frame:GetRight();

						if x < left + TUISTYLE.FrameBorderSize then
							if y < bottom + TUISTYLE.FrameBorderSize then
								Frame:StartSizing("BOTTOMLEFT");
							elseif y > top - TUISTYLE.FrameBorderSize then
								Frame:StartSizing("TOPLEFT");
							else
								Frame:StartSizing("LEFT");
							end
							Frame.isResizing = true;
						elseif x > right - TUISTYLE.FrameBorderSize then
							if y < bottom + TUISTYLE.FrameBorderSize then
								Frame:StartSizing("BOTTOMRIGHT");
							elseif y > top - TUISTYLE.FrameBorderSize then
								Frame:StartSizing("TOPRIGHT");
							else
								Frame:StartSizing("RIGHT");
							end
							Frame.isResizing = true;
						elseif y < bottom + TUISTYLE.FrameBorderSize then
							Frame:StartSizing("BOTTOM");
							Frame.isResizing = true;
						elseif y > top - TUISTYLE.FrameBorderSize then
							Frame:StartSizing("TOP");
							Frame.isResizing = true;
						else
							Frame:StartMoving();
							Frame.isMoving = true;
						end
					end
				else
					Frame:StartMoving();
					Frame.isMoving = true;
				end
			end
		end
		local function Frame_OnMouseUp(Frame, button)
			if button == "LeftButton" then
				if Frame.isMoving then
					Frame:StopMovingOrSizing()
					Frame.isMoving = false
				elseif Frame.isResizing then
					Frame:StopMovingOrSizing()
					Frame.isResizing = false
				end
			end
		end
		local function Frame_OnShow(Frame)
			Frame_OnSizeChanged(Frame, Frame:GetWidth(), Frame:GetHeight());
			Frame.ApplyTalentsProgress:SetText(nil);
		end
		local function Frame_OnHide(Frame)
			MT.UI.ReleaseFrame(Frame.id);
			if Frame.isMoving then
				Frame:StopMovingOrSizing();
				Frame.isMoving = false;
			end
			if Frame.isResizing then
				Frame:StopMovingOrSizing();
				Frame.isResizing = false;
			end
			if VT.TooltipFrame.OwnerFrame == Frame then
				VT.TooltipFrame:Hide();
			end
		end

		local temp_id = 0;
		function MT.UI.CreateFrame()
			temp_id = temp_id + 1;
			local Frame = CreateFrame('FRAME', nil, UIParent);
			Frame.id = temp_id;

			Frame:SetPoint("CENTER");
			Frame:SetMinResize(TUISTYLE.FrameXSizeMin_Style1, TUISTYLE.FrameYSizeMin_Style1);
			Frame:SetFrameStrata("HIGH");
			VT.__uireimp._SetSimpleBackdrop(Frame, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0);

			if VT.SET.style == 1 then
				Frame:SetSize(TUISTYLE.FrameXSizeDefault_Style1, TUISTYLE.FrameYSizeDefault_Style1);
			elseif VT.SET.style == 2 then
				Frame:SetSize(TUISTYLE.FrameXSizeDefault_Style2, TUISTYLE.FrameYSizeDefault_Style2);
			end

			local BG = Frame:CreateTexture(nil, "BORDER");
			BG:SetAlpha(0.6);
			BG:SetPoint("BOTTOMLEFT");
			BG:SetPoint("TOPRIGHT");
			Frame.BG = BG;

			Frame.TreeFrames = MT.UI.CreateTreeFrames(Frame);
			Frame.SpellListFrame, Frame.SpellListFrameContainer = MT.UI.CreateSpellListFrame(Frame);
			Frame.EquipmentFrameContainer, Frame.EquipmentFrame, Frame.EquipmentContainer = MT.UI.CreateEquipmentFrame(Frame);
			Frame.GlyphFrame = Frame.EquipmentFrameContainer.GlyphFrame;
			Frame.GlyphContainer = Frame.EquipmentFrameContainer.GlyphContainer;

			MT.UI.CreateFrameSubObject(Frame);

			Frame:EnableMouse(true);
			Frame:SetMovable(true);
			Frame:SetResizable(true);

			Frame:Hide();

			Frame:SetScript("OnMouseDown", Frame_OnMouseDown);
			Frame:SetScript("OnMouseUp", Frame_OnMouseUp);
			Frame:SetScript("OnSizeChanged", Frame_OnSizeChanged);
			Frame:SetScript("OnShow", Frame_OnShow);
			Frame:SetScript("OnHide", Frame_OnHide);

			Frame.CurTreeIndex = 1;
			MT.UI.FrameSetName(Frame, nil);
			MT.UI.FrameSetLevel(Frame, nil);
			MT.UI.FrameSetClass(Frame, CT.SELFCLASS);
			MT.UI.FrameSetTalent(Frame, nil);
			--	MT.UI.FrameSetReadOnly(Frame, false);
			Frame.initialized = false;

			MT.UI.FrameSetStyle(Frame, VT.SET.style);

			return Frame;
		end

		function MT.UI.GetFrame(FrameID)
			local Frames = VT.Frames;
			local Frame = nil;
			if FrameID ~= nil then
				if FrameID <= temp_id then
					for i = 1, Frames.num do
						if Frames[i].id == FrameID then
							if i <= Frames.used then
								Frame = Frames[i];
							elseif i == Frames.used + 1 then
								Frame = Frames[i];
								Frames.used = i;
							else
								Frame = tremove(Frames, i);
								Frames.used = Frames.used + 1;
								tinsert(Frames, Frames.used, Frame);
							end
							break;
						end
					end
				end
			end
			if Frame == nil then
				if Frames.num > Frames.used then
					Frames.used = Frames.used + 1;
					Frame = Frames[Frames.used];
				else
					Frame = MT.UI.CreateFrame();
					Frames.num = Frames.num + 1;
					Frames[Frames.num] = Frame;
					Frames.used = Frames.num;
				end
			end
			Frame:Show();
			return Frame;
		end
		function MT.UI.GetLastFrame()
			local Frames = VT.Frames;
			return Frames.used > 0 and Frames[Frames.used] or nil;
		end
		function MT.UI.ReleaseFrame(FrameID)
			local Frames = VT.Frames;
			if Frames.used <= 0 then
				return;
			end
			for i = Frames.used, 1, -1 do
				local Frame = Frames[i];
				if FrameID == Frame.id then
					if i ~= Frames.used then
						tremove(Frames, i);
						tinsert(Frames, Frames.used, Frame);
					end
					Frames.used = Frames.used - 1;
					if Frame:IsShown() then
						Frame:Hide();
					end
					MT.UI.FrameReleaseBinding(Frame);
					MT.UI.FrameReset(Frame);
					break;
				end
			end
		end
		function MT.UI.ReleaseAllFramesButOne(id)
			local Frames = VT.Frames;
			for i = Frames.used, 1, -1 do
				local Frame = Frames[i];
				if Frame.id ~= id then
					Frame:Hide();
				end
			end
			if Frames.used == 1 then
				MT.UI.SetFrameID(Frames[1], 1);
			elseif Frames.used > 1 then
				MT.Debug("Emu Warn >> RelAllButOne", "USED NEQ 1, IS", Frames.used);
			end
		end
		function MT.UI.IsAllFramesSameStyle()
			local style = -1;
			local Frames = VT.Frames;
			for i = 1, Frames.used do
				local Frame = Frames[i];
				if Frame.style ~= style then
					if style == -1 then
						style = Frame.style;
					else
						style = nil;
						break;
					end
				end
			end
			return style;
		end
		function MT.UI.SetFrameID(Frame, FrameID)
			if Frame.id == FrameID then
				return;
			end
			local Frames = VT.Frames;
			for i = 1, Frames.num do
				if Frames[i].id == FrameID then
					Frame.id, Frames[i].id = FrameID, Frame.id;
					break;
				end
			end
		end
		function MT.UI.HideFrame(FrameID)
			if type(FrameID) == 'table' then
				FrameID:Hide();
			elseif type(FrameID) == 'number' then
				local Frames = VT.Frames;
				for i = Frames.used, 1, -1 do
					local Frame = Frames[i];
					if Frame.id == FrameID then
						Frame:Hide();
						break;
					end
				end
			end
		end
		function MT.UI.FrameReleaseBinding(Frame)
			if Frame ~= nil then
				if type(Frame) == 'number' then
					Frame = MT.UI.GetFrame(Frame);
					if Frame == nil then
						return;
					end
				end
				for Key, Frames in next, VT.NameBindingFrame do
					local num = #Frames;
					if num == 2 then
						if Frame == Frames[2] then
							VT.NameBindingFrame[Key] = nil;
						end
					elseif num > 2 then
						for i = num, 2, -1 do
							if Frame == Frames[i] then
								tremove(Frames, i);
								num = num - 1;
							end
						end
						if num < 2 then
							VT.NameBindingFrame[Key] = nil;
						end
					else
						VT.NameBindingFrame[Key] = nil;
					end
				end
			end
		end
		function MT.UI.FrameSetBinding(Frame, name)
			for Key, Frames in next, VT.NameBindingFrame do
				if Key ~= name then
					local num = #Frames;
					if num == 1 then
						if Frame == Frames[1] then
							VT.NameBindingFrame[Key] = nil;
						end
					elseif num > 1 then
						for i = num, 1, -1 do
							if Frame == Frames[i] then
								tremove(Frames, i);
								num = num - 1;
							end
						end
						if num <= 0 then
							VT.NameBindingFrame[Key] = nil;
						end
					else
						VT.NameBindingFrame[Key] = nil;
					end
				end
			end
			local Frames = VT.NameBindingFrame[name];
			if Frames ~= nil then
				local num = #Frames;
				if num >= 1 then
					for i = 1, num do
						if Frame == Frames[i] then
							return;
						end
					end
					Frames[num + 1] = Frame;
				else
					Frames[1] = Frame;
				end
			else
				VT.NameBindingFrame[name] = { Frame, };
			end
		end
		function MT.UI.FrameGetNameBinding(name)
			return VT.NameBindingFrame[name];
		end
		function MT.UI.IteratorFrames(func, ...)
			local Frames = VT.Frames;
			for i = Frames.used, 1, -1 do
				func(Frames[i], ...);
			end
		end
	--

	MT.RegisterOnInit('UI', function(LoggedIn)
		if CT.LOCALE == 'zhCN' or CT.LOCALE == 'zhTW' then
			TUISTYLE.FrameFontSizeSmall = TUISTYLE.FrameFontSizeMid;
		end
		TUISTYLE.TreeFrameXSizeSingle = TUISTYLE.TreeNodeSize * DT.MAX_NUM_COL + TUISTYLE.TreeNodeXGap * (DT.MAX_NUM_COL - 1) + TUISTYLE.TreeNodeXToBorder * 2;
		TUISTYLE.TreeFrameXSizeTriple = TUISTYLE.TreeFrameXSizeSingle * 3;
		TUISTYLE.TreeFrameYSize = TUISTYLE.TreeFrameHeaderYSize + TUISTYLE.TreeNodeYToTop + TUISTYLE.TreeNodeSize * DT.MAX_NUM_TIER + TUISTYLE.TreeNodeYGap * (DT.MAX_NUM_TIER - 1) + TUISTYLE.TreeNodeYToBottom+ TUISTYLE.TreeFrameFooterYSize;
		TUISTYLE.FrameXSizeDefault_Style1 = TUISTYLE.TreeFrameXSizeTriple + TUISTYLE.TreeFrameXToBorder * 2;
		TUISTYLE.FrameYSizeDefault_Style1 = TUISTYLE.TreeFrameYSize + TUISTYLE.TreeFrameYToBorder * 2 + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize;
		TUISTYLE.FrameXSizeDefault_Style2 = TUISTYLE.TreeFrameXSizeSingle + TUISTYLE.TreeFrameXToBorder * 2;
		TUISTYLE.FrameYSizeDefault_Style2 = TUISTYLE.TreeFrameYSize + TUISTYLE.TreeFrameYToBorder * 2 + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize;
		TUISTYLE.EquipmentContainerYSize = TUISTYLE.EquipmentNodeYToBorder + TUISTYLE.EquipmentNodeSize * 10 + TUISTYLE.EquipmentNodeGap * 11 + TUISTYLE.EquipmentNodeYToBorder;
		VT.TooltipFrame = MT.UI.CreateTooltipFrame();
	end);
	MT.RegisterOnLogin('UI', function(LoggedIn)
	end);

-->
