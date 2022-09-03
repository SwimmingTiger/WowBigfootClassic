if GetLocale() ~= "frFR" then return end

local L

---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Obscuron"
})

---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Ténébron"
})

---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vespéron"
})

---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Ténébron Arrive",
	WarningShadron			= "Obscuron Arrive",
	WarningVesperon			= "Vespéron Arrive",
	WarningFireWall			= "Tsunami de flammes !",
	WarningVesperonPortal	= "Portail de Vespéron",
	WarningTenebronPortal	= "Portail de Ténébron",
	WarningShadronPortal	= "Portail d'Obscuron"
})

L:SetTimerLocalization({
	TimerTenebron	= "Ténébron Arrive",
	TimerShadron	= "Obscuron Arrive",
	TimerVesperon	= "Vespéron Arrive"
})

L:SetOptionLocalization({
	AnnounceFails		= "Affiche les joueurs qui n'ont pas évité les zones de vide / Tsunamis de flammes (Nécessite l'activation des annonces et être promu ou leader)",
	TimerTenebron		= "Montre le timer pour Ténébron",
	TimerShadron		= "Montre le timer pour Obscuron",
	TimerVesperon		= "Montre le timer pour Vespéron",
	WarningFireWall		= "Montre une alerte spéciale pour les Tsunamis de flammes",
	WarningTenebron		= "Montre le timer avant que Ténébron arrive",
	WarningShadron		= "Montre le timer avant qu'Obscuron arrive",
	WarningVesperon		= "Montre le timer avant que Vespéron arrive",
	WarningTenebronPortal	= "Montre une alerte spéciale pour les portails de Ténébron",
	WarningShadronPortal	= "Montre une alerte spéciale pour les portails d'Obscuron",
	WarningVesperonPortal	= "Montre une alerte spéciale pour les portails de Vespéron"
})

L:SetMiscLocalization({
	Wall			= "lave qui entoure",
	Portal			= "commence à incanter un portail",
	NameTenebron	= "Ténébron",
	NameShadron		= "Obscuron",
	NameVesperon	= "Vespéron",
	FireWallOn		= "Tsunamis de flammes: %s",
	VoidZoneOn		= "Zone de vide : %s",
	VoidZones		= "Zones de vide ratées (cet essai): %s",
	FireWalls		= "Tsunamis de flammes ratés (cet essai): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus the Warborn"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Show pre-warning for Split"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Ragefire"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "New adds",
	warnCleaveArmor	= "%s on >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "New adds"
})

L:SetOptionLocalization({
	WarnAdds		= "Announce new adds",
	TimerAdds		= "Show timer for new adds"
})

L:SetMiscLocalization({
	SummonMinions	= "Turn them to ash, minions!"--needs translation
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion the Twilight Destroyer"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Casting Twilight Cutter: 5 sec"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Show warning when $spell:77844 is being cast",
	AnnounceAlternatePhase	= "Show warnings/timers for phase you aren't in as well"
})

L:SetMiscLocalization({
	MeteorCast				= "Les cieux s'embrasent !",
	Phase2					= "Vous ne trouverez que souffrance au royaume du crépuscule ! Entrez si vous l'osez !",
	Phase3					= "Je suis la lumière et l'ombre ! Tremblez, mortels, devant le héraut d'Aile-de-mort !",--needs Verification
	twilightcutter			= "Les sphères volantes rayonnent d'énergie noire !",
	Kill					= "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"--needs translation
})
