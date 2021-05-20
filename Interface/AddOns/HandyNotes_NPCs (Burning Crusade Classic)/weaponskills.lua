local name, data = ...
data["weaponmasters"] = { }
data["weaponskills"] = { }
wm, ws = data["weaponmasters"], data["weaponskills"]

local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Burning Crusade Classic)")

wm[17005] = "200, 201, 202"
ws[200] = {
	name = L["Polearms"],
	icon = "inv_spear_06",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		HUNTER = true,
	}
}
ws[201] = {
	name = L["One-Handed Swords"],
	icon = "ability_meleedamage",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		HUNTER = true,
		ROGUE = true,
		MAGE = true,
		WARLOCK = true,
	}
}
ws[202] = {
	name = L["Two-Handed Swords"],
	icon = "ability_meleedamage",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		HUNTER = true,
	}
}
