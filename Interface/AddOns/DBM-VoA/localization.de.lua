if GetLocale() ~= "deDE" then return end
local L

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon der Steinwächter"
})

L:SetWarningLocalization({
	WarningGrab	= "Archavon durchbohrt >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Berserker (Archavon)"
})

L:SetMiscLocalization({
	TankSwitch	= "%%s stürzt sich auf (%S+)!"
})

L:SetOptionLocalization({
	WarningGrab		= "Verkünde Ziele von $spell:58666",
	ArchavonEnrage	= "Zeige Zeit bis $spell:26662"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon der Sturmwächter"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Überladener Schlag",
	EmalonEnrage		= "Berserker (Emalon)"
}

L:SetOptionLocalization{
	timerMobOvercharge	= "Zeige Zeit bis $spell:64219 (erfolgt bei 10 Stapeln von $spell:64217)",
	EmalonEnrage		= "Zeige Zeit bis $spell:26662"
}

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon der Flammenwächter"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Berserker (Koralon)"
}

L:SetOptionLocalization{
	KoralonEnrage		= "Zeige Zeit bis $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "%s wirkt 'Meteorfäuste'!"
}

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon der Eiswächter"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Berserker (Toravon)"
}

L:SetMiscLocalization{
	ToravonEnrage	= "Zeige Zeit bis $spell:26662"
}
