local name, data = ...
data["weaponmasters"] = { }
data["weaponskills"] = { }
wm, ws = data["weaponmasters"], data["weaponskills"]

local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_NPCs (Classic)")

wm[11867] = "200, 201, 202, 227, 1180, 5011"
wm[2704] = "196, 197, 227, 264, 2567"
wm[11868] = "196, 197, 264, 1180, 2567, 15590"
wm[11865] = "196, 197, 198, 199, 266, 15590"
wm[13084] = "1180, 2567, 5011"
wm[11869] = "198, 199, 227, 266"
wm[11866] = "227, 264, 1180, 2567, 15590"
wm[11870] = "200, 201, 202, 1180, 5011"
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
ws[227] = {
	name = L["Staves"],
	icon = "inv_staff_08",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		PRIEST = true,
		SHAMAN = true,
		MAGE = true,
		WARLOCK = true,
		DRUID = true,
	}
}
ws[1180] = {
	name = L["Daggers"],
	icon = "ability_steelmelee",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		ROGUE = true,
		PRIEST = true,
		SHAMAN = true,
		MAGE = true,
		WARLOCK = true,
		DRUID = true,
	}
}
ws[5011] = {
	name = L["Crossbows"],
	icon = "inv_weapon_crossbow_01",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		ROGUE = true,
	}
}
ws[196] = {
	name = L["One-Handed Axes"],
	icon = "inv_axe_01",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		HUNTER = true,
		SHAMAN = true,
	}
}
ws[197] = {
	name = L["Two-Handed Axes"],
	icon = "inv_axe_04",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		HUNTER = true,
		SHAMAN = true,
	}
}
ws[264] = {
	name = L["Bows"],
	icon = "inv_weapon_bow_05",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		ROGUE = true,
	}
}
ws[2567] = {
	name = L["Thrown"],
	icon = "inv_throwingknife_02",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		ROGUE = true,
	}
}
ws[15590] = {
	name = L["Fist Weapons"],
	icon = "inv_gauntlets_04",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		ROGUE = true,
		SHAMAN = true,
		DRUID = true,
	}
}
ws[198] = {
	name = L["One-Handed Maces"],
	icon = "inv_mace_01",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		ROGUE = true,
		PRIEST = true,
		SHAMAN = true,
		DRUID = true,
	}
}
ws[199] = {
	name = L["Two-Handed Maces"],
	icon = "inv_mace_04",
	classes = {
		WARRIOR = true,
		PALADIN = true,
		SHAMAN = true,
		DRUID = true,
	}
}
ws[266] = {
	name = L["Guns"],
	icon = "inv_weapon_rifle_01",
	classes = {
		WARRIOR = true,
		HUNTER = true,
		ROGUE = true,
	}
}
