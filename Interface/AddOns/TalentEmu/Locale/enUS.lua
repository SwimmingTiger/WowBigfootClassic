--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;
local L = CT.L;

if L.Locale ~= nil and L.Locale ~= "" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "Create a emulator";
BINDING_NAME_ALARAIDTOOL_QUERY = "Inspect target's talent";
BINDING_HEADER_ALATALENTEMU_HEADER = "<|cff00ff00alaTalentEmu|r>";

L.Locale = "enUS";

L.Emu = "Emu";
L.OK = "OK";
L.Cancel = "Cancel";
L.Search = "Search";
L.Hide = "Hide";
L.CurTreePointsLabel = "Points";
L.CurPointsTotal = "Total";
L.CurPointsRemaining = "Has";
L.CurPointsUsed = "Spent";
L.CurPointsReqLevel = "Lv";
L.message = "*CHAT";
L.import = "IMPORT";
L.me = "Me";

L.ReadOnly = "|cffff0000ReadOnly|r";
L.NonReadOnly = "|cff00ff00Editable|r";
L.LabelPointsChanged = "(|cffff0000Modified|r)";
L.ResetButton = "Reset current tree";
L.ResetAllButton = "Reset all";
L.ResetToSetButton = "Reset to initial state";
L.ReadOnlyButton = "|cff00ff00RClick|r Set";
L.CloseButton = "Close this win";

L.ClassButton = "\n|cff00ff00LeftClick|r Toggle class\n|cff00ff00RightClick|r Load saved talents\n|cff00ff00Shift and LeftClick in Menu|r Del saved talent";
L.InspectTargetButton = "Inspect target's talents";
L.SpellListButton = "Spell List Window";
L.SpellAvailable = "|cff00ff00Available|r";
L.SpellUnavailable = "|cffff0000Not Available|r";
L.TrainCost = "Train Cost ";
L.ShowAllSpell = "All ranks";
L.ApplyTalentsButton = "Apply talents";
L.ApplyTalentsButton_Notify = "Apply these talents?";
L.ApplyTalentsFinished = "Talents applied";
L.ImportButton = "Import from string or wowhead/nfu/yxrank url";
L.ExportButton = "|cff00ff00LeftClick|r Export string\n|cff00ff00RightClick|r Export to |cffff0000wowhead/nfu|r url";
L.AllData = "AllData";
L.SaveButton = "|cff00ff00LeftClick|r Save talents\n|cff00ff00RightClick|r Load saved talents\n|cff00ff00ALT+RightClick|rLoad talents/glyphs/equip of other characters\n|cff00ff00Shift and LeftClick in Menu|r Del";
L.SendButton = "|cff00ff00LeftClick|r Send talents to chat message\n|cff00ff00RightClick|r Browse talents in chat";
L.EquipmentFrameButton = "Watch equipment";

L.TalentFrameCallButton = "Open TalentEmu";
L.TalentFrameCallButtonString = "Emu";
L.CurRank = "Current Rank";
L.NextRank = "Next Rank";
L.MaxRank = "Top Rank";
L.ReqPoints = "%d/%d in %s";

L.AutoShowEquipmentFrame_TRUE = "Show Equipment List Automatically";
L.AutoShowEquipmentFrame_FALSE = "Show Equipment List Manually";
L.Minimap_TRUE = "Show DBIcon";
L.Minimap_FALSE = "Hide DBIcon";
L.ResizableBorder_TRUE = "Enable Draging border to resize";
L.ResizableBorder_FALSE = "Disable dragging border to resize";
L.SetWinStyle_BLZ = "Make it blz style";
L.SetWinStyle_ALA = "Make it flat style";
L.SetSingleFrame_True = "Single Window";
L.SetSingleFrame_False = "Multiple Windows";
L.SetStyleAllTo1_ThisWin = "Three talent trees in this frame";
L.SetStyleAllTo2_ThisWin = "Single talent tree in this frame";
L.SetStyleAllTo1_AlsoSetShownWin = "Three talent trees in frames and set all the opened frames";
L.SetStyleAllTo1_LaterWin = "Three talent trees in frames";
L.SetStyleAllTo2_AlsoSetShownWin = "Singlee talent tree and set all the opened frames";
L.SetStyleAllTo2_LaterWin = "Single talent tree in frames";
L.InspectButtonOnUnitFrame_TRUE = "Enable inspect button (Holding alt/ctrl/shift to show a button at target's portrait)";
L.TalentsInTip_TRUE = "Show talents in players' tip";
L.TalentsInTip_FALSE = "Donot show talents in players' tip";
L.TalentsInTipIcon_TRUE = "Use texture of talents tree in tip";
L.TalentsInTipIcon_FALSE = "Use name of talents tree in tip";
L.InspectButtonOnUnitFrame_FALSE = "Disable inspect button";
L.InsepctKey_ALT = "Holding alt to show the inspect button";
L.InsepctKey_CTRLK = "Holding ctrl to show the inspect button";
L.InsepctKey_SHIFT = "Holding shift to show the inspect button";

L.DBIcon_Text = "|cff00ff00LeftClick|r Create a emulator\n|cff00ff00RightClick|r Explorer group member";
L.SpellListFrameGTTSpellLevel = "Spell level: ";
L.SpellListFrameGTTReqLevel = "Level: ";

L.DATA = {
	talent = "talent",

	DEATHKNIGHT = "deathknight",
	DRUID = "druid",
	HUNTER = "hunter",
	MAGE = "mage",
	PALADIN = "paladin",
	PRIEST = "priest",
	ROGUE = "rogue",
	SHAMAN = "shaman",
	WARLOCK = "warlock",
	WARRIOR = "warrior",

	[398] = "Blood",
	[399] = "Frost",
	[400] = "Unholy",
	[283] = "Balance",
	[281] = "Feral",
	[282] = "Restoration",
	[361] = "BeastMastery",
	[363] = "Marksmanship",
	[362] = "Survival",
	[81] = "Arcane",
	[41] = "Fire",
	[61] = "Frost",
	[382] = "Holy",
	[383] = "Protection",
	[381] = "Combat",
	[201] = "Discipline",
	[202] = "Holy",
	[203] = "Shadow",
	[182] = "Assassination",
	[181] = "Combat",
	[183] = "Subtlety",
	[261] = "Elemental",
	[263] = "Enhancement",
	[262] = "Restoration",
	[302] = "Curses",
	[303] = "Summoning",
	[301] = "Destruction",
	[161] = "Arms",
	[164] = "Fury",
	[163] = "Protection",

	H = "|cff00ff00Healer|r",
	D = "|cffff0000DPS|r",
	T = "|cffafafffTANK|r",
	P = "|cffff0000PVP|r",
	E = "|cffffff00PVE|r",

};

L.RACE = "RACE";
L["HUMAN|DWARF|NIGHTELF|GNOME|DRAENEI"] = "Alliance";
L["ORC|SCOURGE|TAUREN|TROLL|BLOODELF"] = "Horde";
L["HUMAN"] = "Human";
L["DWARF"] = "Dwarf";
L["NIGHTELF"] = "NightElf";
L["GNOME"] = "Gnome";
L["DRAENEI"] = "Draenei";
L["ORC"] = "Orc";
L["SCOURGE"] = "Scourge";
L["TAUREN"] = "Tauren";
L["TROLL"] = "Troll";
L["BLOODELF"] = "BloodElf";


L.RaidToolLableItemLevel = "ItemLv";
L.RaidToolLableMissItem = "Items";
L.RaidToolLableMissEnchant = "Encs";
L.RaidToolLableBossMod = "Version of DBM";
L.guildList = "Guild Member";

L.SLOT = {
	[0] = "Ammo",
	[1] = "Head",
	[2] = "Neck",
	[3] = "Shoulder",
	[4] = "Skirt",
	[5] = "Chest",
	[6] = "Waist",
	[7] = "Leg",
	[8] = "Feet",
	[9] = "Wrist",
	[10] = "Glove",
	[11] = "Finger",
	[12] = "Finger",
	[13] = "Trinet",
	[14] = "Trinet",
	[15] = "Cloak",
	[16] = "MainHand",
	[17] = "OffHand",
	[18] = "Ranged",
	[19] = "Tabard",
};
L.EMTPY_SLOT = "|cffff0000Empty|r";
L.MISS_ENCHANT = "|cffff0000Miss enchant|r";




L["CANNOT APPLY : NEED MORE TALENT POINTS."] = "CANNOT APPLY : NEED MORE TALENT POINTS.";
L["CANNOT APPLY : TALENTS IN CONFLICT."] = "CANNOT APPLY : TALENTS IN CONFLICT.";
L["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."] = "CANNOT APPLY : UNABLE TO GENERATE TALENT MAP.";
L["CANNOT APPLY : TALENT MAP ERROR."] = "CANNOT APPLY : TALENT MAP ERROR.";
L["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."] = "TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE.";


L.PopupQuery = "Inspect";

--	emulib
L["WOW VERSION"] = "The talents does not fit che client";
L["NO DECODER"] = "Unable to decode talent data";
