--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.L = NS.L or {  };
local L = NS.L;

if L.Locale ~= nil and L.Locale ~= "" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "Create a emulator.";
BINDING_NAME_ALARAIDTOOL_QUERY = "Inspect target's talent.";
BINDING_HEADER_ALATALENTEMU_HEADER = "<\124cff00ff00alaTalentEmu\124r>";

L.Locale = "enUS";

L.Emu = "Emu";
L.OK = "OK";
L.Cancel = "Cancel";
L.Search = "Search";
L.Hide = "Hide";
L.curTabPointsLabel = "Points";
L.curPointsTotal = "Total";
L.curPointsRemaining = "Has";
L.curPointsUsed = "Spent";
L.curPointsReqLevel = "Lv";
L.message = "MSG: ";
L.me = "Me";

L.readOnly = "\124cffff0000ReadOnly\124r";
L.notReadOnly = "\124cff00ff00Editable\124r";
L.labelPointsChanged = "(\124cffff0000Modified\124r)";
L.resetButton = "Reset current tree";
L.resetAllButton = "Reset all";
L.resetToSetButton = "Reset to initial state";
L.readOnlyButton = "\124cff00ff00RClick\124r to set";
L.closeButton = "Close this win";

L.classTabButton = "\n\124cff00ff00Left click\124r to toggle class.\n\124cff00ff00Right click\124r to import build-in talents\n    (Copied from \124cffff0000wowhead\124r).";
L.inspectTargetButton = "Inspect target's talents.";
L.spellTabButton = "Spell List Window";
L.spellAvailable = "\124cff00ff00Available\124r";
L.spellNotAvailable = "\124cffff0000Not Available\124r";
L.showAllSpell = "All ranks";
L.applyTalentsButton = "Apply talents.";
L.applyTalentsButton_Notify = "Apply these talents?";
L.importButton = "Import from string or wowhead/nfu/yxrank url.";
L.exportButton = "\124cff00ff00Left click\124r to export string.\n\124cff00ff00Right click\124r to export to \124cffff0000wowhead/nfu/yxrank\124r url";
L.saveButton = "\124cff00ff00Left click\124r to save talents.\n\124cff00ff00Right click\124r to load saved talents.\n\124cff00ff00Shift and Left-click\124r to del";
L.sendButton = "\124cff00ff00Left click\124r to send talents to chat message\n\124cff00ff00Right click\124r to browse talents in chat.";
L.equipmentButton = "Watch equipment";

L.TalentFrameCallButton = "Open TalentEmu.";
L.TalentFrameCallButtonFontString = "Emu";
L.curRank = "Current Rank";
L.nextRank = "Next Rank";
L.maxRank = "Top Rank";
L.reqPoints = "%d/%d in %s";

L.resizable_border_TRUE = "Enable Draging border to resize";
L.resizable_border_FALSE = "Disable dragging border to resize";
L.SetWinStyle_BLZ = "Make it blz style";
L.SetWinStyle_ALA = "Make it flat style";
L.SetSingleFrame_True = "Single Window";
L.SetSingleFrame_False = "Multiple Windows";
L.SetStyleAllTo1_ThisWin = "Show three talent trees.";
L.SetStyleAllTo2_ThisWin = "Show one talent tree.";
L.SetStyleAllTo1_AlsoSetShownWin = "Show three talent trees.(Also change opened emu)";
L.SetStyleAllTo1_LaterWin = "Show three talent trees.";
L.SetStyleAllTo2_AlsoSetShownWin = "Show one talent tree.(Also change opened emu)";
L.SetStyleAllTo2_LaterWin = "Show one talent tree.";
L.inspectButtonOnUnitFrame_Enable = "Enable inspect button. (Holding alt/ctrl/shift to show a button at target's portrait)";
L.TalentsInTip_TRUE = "Show talents when mouseover players";
L.TalentsInTip_FALSE = "Donot show talents when mouseover players";
L.TalentsInTipIcon_TRUE = "Use texture of talents tree in tip";
L.TalentsInTipIcon_FALSE = "Use name of talents tree in tip";
L.inspectButtonOnUnitFrame_Disable = "Disable inspect button.";
L.insepctALTKEY = "Holding alt to show the inspect button";
L.insepctCTRLKEY = "Holding ctrl to show the inspect button";
L.insepctSHIFTKEY = "Holding shift to show the inspect button";

L.DBIcon_Text = "\124cff00ff00Left click\124r to create a emulator\n\124cff00ff00Right click\124r to set win style";
L.spellTabGTTSpellLevel = "Spell level: ";
L.spellTabGTTReqLevel = "Level: ";

L.DATA = {
	talent = "talent",

	DRUID = "druid",
	HUNTER = "hunter",
	MAGE = "mage",
	PALADIN = "paladin",
	PRIEST = "priest",
	ROGUE = "rogue",
	SHAMAN = "shaman",
	WARLOCK = "warlock",
	WARRIOR = "warrior",

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

	H = "\124cff00ff00Healer\124r",
	D = "\124cffff0000DPS\124r",
	T = "\124cffafafffTANK\124r",
	P = "\124cffff0000PVP\124r",
	E = "\124cffffff00PVE\124r",

};

L.RACE = "RACE";
L.HUMAN = "HUMAN";
L.DWARF = "DWARF";
L["HUMAN|DWARF"] = "HUMAN|DWARF";
L.NIGHTELF = "NIGHTELF";
L.SCOURGE = "SCOURGE";
L.TROLL = "TROLL";


L.label_itemLevel = "ItemLv";
L.label_missItem = "Items";
L.label_missEnchant = "Encs";
L.label_DBM = "Version of DBM";
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
L.EMTPY_SLOT = "\124cffff0000Empty\124r";
L.MISS_ENCHANT = "\124cffff0000Miss enchant\124r";
