if GetLocale() ~= "frFR" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Les Bêtes du Norfendre"
}

L:SetMiscLocalization{
	Charge			= "fusille (%S+) du regard",
	CombatStart		= "Arrivant tout droit des plus noires et profondes cavernes des pics Foudroyés, Gormok l'Empaleur !",
	Phase2			= "car voici que les terreurs jumelles",
	Phase3			= "de notre prochain combattant",
	Gormok			= "Gormok l'Empaleur",
	Acidmaw			= "Gueule-d'acide",
	Dreadscale		= "Ecaille-d'effroi",
	Icehowl			= "Glace-hurlante"
}

L:SetOptionLocalization{
	WarningSnobold				= "Montre une alerte quand les Vassal arrivent",
	ClearIconsOnIceHowl			= "Enlève toutes les icônes avant la prochaine charge",
	TimerNextBoss				= "Montre le timer pour l'arrivée du prochain boss",
	TimerEmerge					= "Montre le timer avant que les vers rentre dans le sol",
	TimerSubmerge				= "Montre le timer avant que les vers sortent du sol"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Prochain boss dans",
	TimerEmerge					= "Sort du sol",
	TimerSubmerge				= "Rentre dans le sol"
}

L:SetWarningLocalization{
	WarningSnobold				= "Un Vassal frigbold viens d'arriver"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Seigneur Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame		= "Montre la vie du Boss avec une barre de vie pour Incinérer la chair"
}

L:SetMiscLocalization{
	IncinerateTarget			= "Incinérer la chair: %s"
}

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Champion des Factions"
}

L:SetMiscLocalization{
	AllianceVictory    = "GLORY TO THE ALLIANCE!",
	HordeVictory       = "That was just a taste of what the future brings. FOR THE HORDE!",
	YellKill				= "Une victoire tragique et depourvue de sens. La perte subie aujourd'hui nous affaiblira tous, car qui d'autre que le roi-liche pourrait beneficier d'une telle folie?? De grands guerriers ont perdu la vie. Et pour quoi?? La vraie menace plane à l'horizon?: le roi-liche nous attend, tous, dans la mort."
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Soeurs Val'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Prochaine Capacité Spéciale"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Capacité spéciale Bientôt !",
	SpecWarnSpecial				= "Changement de couleur !",
	SpecWarnEmpoweredDarkness	= "Ténèbres surpuissantes",
	SpecWarnEmpoweredLight		= "Lumière surpuissante",
	SpecWarnSwitchTarget		= "Changement de cible !",
	SpecWarnKickNow				= "Casser Maintenant !",
	WarningTouchDebuff			= "Toucher sur >%s<",
	WarningPoweroftheTwins2		= "Puissance des jumelles - plus de soins sur >%s<",
	SpecWarnPoweroftheTwins		= "Puissance des jumelles!"
}

L:SetMiscLocalization{
	Fjola 		= "Fjola Plaie-lumineuse",
	Eydis		= "Eydis Plaie-sombre"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Montre une alerte spéciale pour la prochaine Capacité spéciale",
	WarnSpecialSpellSoon		= "Montre une Pré-Alerte pour la prochaine Capacité spéciale",
	SpecWarnSpecial				= "Montre une alerte spéciale quand vous devez changer de couleur",
	SpecWarnEmpoweredDarkness	= "Montre une alerte spéciale pour les Ténèbres surpuissantes",
	SpecWarnEmpoweredLight		= "Montre une alerte spéciale pour la Lumière surpuissante",
	SpecWarnSwitchTarget		= "Montre une alerte spéciale quand l'autre boss est en train d'incanter",
	SpecWarnKickNow				= "Montre une alerte spéciale quand vous devez interrompre l'incantation",
	SpecialWarnOnDebuff			= "Montre une alerte spéciale quand vous avez un Toucher (pour changer de debuff)",
	SetIconOnDebuffTarget		= "Met des icônes sur les cibles des Toucher (héroique)",
	WarningTouchDebuff			= "Annoncer les cibles des débuff Toucher de Lumière/des Ténèbres",
	WarningPoweroftheTwins2		= "Annoncer la cible pour Puissance des jumelles",
	SpecWarnPoweroftheTwins		= "Montre une alerte spéciale quand vous êtes en train de tanker une Jumelle puissante"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Sort du sol",
	TimerSubmerge			= "Rentre dans le sol",
	timerAdds				= "Nouveaux add dans"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak Sort du sol",
	WarnEmergeSoon			= "Anub'arak Sort du sol dans 10 sec",
	WarnSubmerge			= "Anub'arak Rentre dans le sol",
	WarnSubmergeSoon		= "Anub'arak Rentre dans le sol dans 10 sec",
	warnAdds				= "Les add arrivent"
}

L:SetMiscLocalization{
	Emerge					= "surgit de la terre",
	Burrow					= "enfonce dans le sol",
	PcoldIconSet			= "Pcold Icon {rt%d} set on %s",
	PcoldIconRemoved		= "Pcold Icon removed from %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Montre une alerte quand le boss sort du sol",
	WarnEmergeSoon			= "Montre une alerte avant que le boss sorte du sol",
	WarnSubmerge			= "Montre une alerte quand le boss rentre dans le sol",
	WarnSubmergeSoon		= "Montre une alerte avant que le boss ne rentre dans le sol",
	warnAdds				= "Montre une alerte pour l'arrivée des add",
	timerAdds				= "Montre le timer avant l'arrivée des nouveaux add",
	TimerEmerge				= "Montre le timer pour la sortie du boss",
	TimerSubmerge			= "Montre le timer pour la rentrée du boss dans la terre",
	AnnouncePColdIcons		= "Marque les icones des cible du Froid pénétrant dans le chatt (Requiert les annonces activer et être le leader ou avoir une promot)"
}

