if GetLocale() ~= "frFR" then return end
local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization{
	name = "Lucifron"
}

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization{
	name = "Magmadar"
}

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization{
	name = "Gehennas"
}

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr-Classic")

L:SetGeneralLocalization{
	name = "Garr"
}

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization{
	name = "Baron Geddon"
}

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization{
	name = "Shazzrah"
}

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization{
	name = "Messager de Sulfuron"
}

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization{
	name = "Golemagg l'Incinérateur"
}

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization{
	name = "Chambellan Executus"
}
L:SetTimerLocalization{
	timerShieldCD		= "Bouclier suivant"
}
L:SetOptionLocalization{
	timerShieldCD		= "Afficher le timer pour le prochain bouclier de dégâts / réflexion"
}

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros-Classic")

L:SetGeneralLocalization{
	name = "Ragnaros"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Submerger",
	WarnEmerge			= "Émerger"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Submerger",
	TimerEmerge			= "Émerger",
}
L:SetOptionLocalization{
	WarnSubmerge		= "Afficher un avertissement pour submerger",
	TimerSubmerge		= "Afficher le timer pour submerger",
	WarnEmerge			= "Afficher un avertissement pour émerger",
	TimerEmerge			= "Afficher le timer pour émerger",
}
L:SetMiscLocalization{
	Submerge	= "COME FORTH, MY SERVANTS! DEFEND YOUR MASTER!",
	Pull		= "Impudent whelps! You've rushed headlong to your own deaths! See now, the master stirs!\r\n"
}

-----------------
--  MC: Trash  --
-----------------
L = DBM:GetModLocalization("MCTrash")

L:SetGeneralLocalization{
	name = "CM: Ennemis communs"
}
