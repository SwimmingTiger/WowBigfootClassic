--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
NS.L = NS.L or {  };
local L = NS.L;

if L.Locale ~= nil and L.Locale ~= "" then return;end

BINDING_NAME_ALARAIDTOOL_NEWWINDOW = "Create a emulator.";
BINDING_NAME_ALARAIDTOOL_QUERY = "Inspect talents of target. (The target player need to install this addon).";
BINDING_HEADER_ALATALENTEMU_HEADER = "<\124cff00ff00alaTalentEmu\124r>";

L.Locale = "enUS";

L.Emu = "Emulator";
L.OK = "OK";
L.Cancel = "Cancel";
L.Search = "Search";
L.Hide = "Hide";
L.curTabPointsLabel = "Points";
L.curPointsTotal = "Total";
L.curPointsRemaining = "Remaining";
L.curPointsUsed = "Spent";
L.curPointsReqLevel = "Lv";

L.readOnly = "\124cffff0000ReadOnly\124r";
L.notReadOnly = "\124cff00ff00Editable\124r";
L.labelPointsChanged = "(\124cffff0000Modified\124r)";
L.resetButton = "Reset tanlents in current tab";
L.resetAllButton = "Reset all talents";
L.resetToSetButton = "Reset to initial state";
L.readOnlyButton = "\124cff00ff00Left click\124r to switch Editable\n\124cff00ff00Right click\124r to set win style";
L.closeButton = "Close this win";

L.classTabButton = "\n\124cff00ff00Left click\124r to toggle class.\n\124cff00ff00Right click\124r to import build-in talents\n    (Copied from \124cffff0000wowhead\124r).";
L.inspectTargetButton = "Inspect target's talents.";
L.spellTabButton = "Spell List Window";
L.spellAvailable = "\124cff00ff00Available\124r";
L.spellNotAvailable = "\124cffff0000Not Available\124r";
L.showAllSpell = "Show all ranks";
L.applyTalentsButton = "Apply this talents emulation.";
L.applyTalentsButton_Notify = "Do u want to apply these talents?";
L.importButton = "Import string or wowhead/nfu url.";
L.exportButton = "\124cff00ff00Left click\124r to export string.\n\124cff00ff00Right click\124r to export to \124cffff0000wowhead/nfu\124r url";
L.saveButton = "\124cff00ff00Left click\124r to save talents set.\n\124cff00ff00Right click\124r to load saved talents set.\n\124cff00ff00Shift & Left click\124r to del";
L.equipmentButton = "Watch equipment";

L.TalentFrameCallButton = "Open ala talent emulator.";
L.TalentFrameCallButtonFontString = "Emulator";
L.curRank = "Current Rank";
L.nextRank = "Next Rank";
L.maxRank = "Top Rank";
L.SetSingleFrame_True = "Single Window";
L.SetSingleFrame_False = "Multiple Windows";
L.SetStyleAllTo1_ThisWin = "Set this win to show all talent tree.";
L.SetStyleAllTo2_ThisWin = "Set this win to show one talent tree. Switch talent trees by clicking button.";
L.SetStyleAllTo1_AlsoSetShownWin = "Set all wins to show all talent tree.";
L.SetStyleAllTo1_LaterWin = "Set this all wins created later to show all talent tree.";
L.SetStyleAllTo2_AlsoSetShownWin = "Set all wins to show all talent tree.";
L.SetStyleAllTo2_LaterWin = "Set all wins created later to show all talent tree.";
L.inspectButtonOnUnitFrame_Enable = "Enable inspect button. (Holding alt/ctrl/shift to show a button at target's portrait)";
L.inspectButtonOnUnitFrame_Disable = "Disable inspect button.";
L.insepctALTKEY = "Holding alt to show the inspect button";
L.insepctCTRLKEY = "Holding ctrl to show the inspect button";
L.insepctSHIFTKEY = "Holding shift to show the inspect button";

L.DBIcon_Text = "\124cff00ff00Left click\124r to create a emulator\n\124cff00ff00Right click\124r to set win style";
L.spellTabGTTSpellLevel = "Spell level: ";
L.spellTabGTTReqLevel = "Level: ";

L.DATA = {
	talent = "talent",

	druid = "druid",
	hunter = "hunter",
	mage = "mage",
	paladin = "paladin",
	priest = "priest",
	rogue = "rogue",
	shaman = "shaman",
	warlock = "warlock",
	warrior = "warrior",

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




