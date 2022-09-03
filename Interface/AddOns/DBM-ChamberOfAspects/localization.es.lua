if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------
-- El Sagrario Obsidiana --
---------------------------
-------------
-- Shadron --
-------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

--------------
-- Tenebron --
--------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

--------------
-- Vesperon --
--------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

----------------
-- Sartharion --
----------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron se aproxima",
	WarningShadron			= "Shadron se aproxima",
	WarningVesperon			= "Vesperon se aproxima",
	WarningFireWall			= "Fire Wall",
	WarningVesperonPortal	= "Vesperon's portal",
	WarningTenebronPortal	= "Tenebron's portal",
	WarningShadronPortal	= "Shadron's portal"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron llega",
	TimerShadron	= "Shadron llega",
	TimerVesperon	= "Vesperon llega"
})

L:SetOptionLocalization({
	AnnounceFails			= "Anunciar jugadores que reciban daño de &spell:57491 y $spell:57579 en el chat de banda (requiere líder o ayudante)",
	TimerTenebron			= "Mostrar temporizador para la llegada de Tenebron",
	TimerShadron			= "Mostrar temporizador para la llegada de Shadron",
	TimerVesperon			= "Mostrar temporizador para la llegada de Vesperon",
	WarningFireWall			= "Mostrar aviso especial para $spell:57491",
	WarningTenebron			= "Anunciar cuando Tenebron se aproxime",
	WarningShadron			= "Anunciar cuando Shadron se aproxime",
	WarningVesperon			= "Anunciar cuando Vesperon se aproxime",
	WarningTenebronPortal	= "Mostrar aviso especial cuando aparezca el portal de Tenebron",
	WarningShadronPortal	= "Mostrar aviso especial cuando aparezca el portal de Shadron",
	WarningVesperonPortal	= "Mostrar aviso especial cuando aparezca el portal de Vesperon"
})

L:SetMiscLocalization({
	Wall			= "¡La lava se arremolina alrededor de %s!",
	Portal			= "%s comienza a abrir un Portal Crepuscular",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Tsunami de llamas: %s",
	VoidZoneOn		= "Fisura de las Sombras: %s",
	VoidZones		= "Fallos en Fisura de las Sombras (en este intento): %s",
	FireWalls		= "Fallos en Tsunami de llamas (en este intento): %s"
})

----------------------
-- El Sagrario Rubí --
----------------------
-----------------------------
-- Baltharus el Batallante --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus el Batallante"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Separación en breve"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Mostrar aviso previo para la separación de banda"
})

----------------------------
-- Saviana Furia Ardiente --
----------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Furia Ardiente"
})

------------------------
-- General Zarithrian --
------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "Ónices clamallamas",
	warnCleaveArmor	= "%s en >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "Siguientes Ónices clamallamas"
})

L:SetOptionLocalization({
	WarnAdds		= "Anunciar cuando aparezcan Ónices clamallamas",
	TimerAdds		= "Mostrar temporizador para los siguientes Ónices clamallamas",
	warnCleaveArmor	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(74367)
})

L:SetMiscLocalization({
	SummonMinions	= "¡Reducidlos a cenizas, esbirros!"
})

------------
-- Halion --
------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Lanzando Corte Crepuscular en 5 s"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Mostrar aviso cuando se esté lanzando $spell:74769",
	AnnounceAlternatePhase	= "Mostrar avisos y temporizadores que no pertenezcan a tu fase actual"
})

L:SetMiscLocalization({
	Halion					= "Halion",
	MeteorCast				= "¡Los cielos arden!",
	Phase2					= "En el reino del crepúsculo solo encontraréis sufrimiento. ¡Entrad si os atrevéis!",
	Phase3					= "¡Yo soy la luz y la oscuridad! ¡Temed, mortales, la llegada de Alamuerte!",
	twilightcutter			= "¡Las esferas que orbitan emiten energía oscura!",
	Kill					= "Disfrutad la victoria, mortales, porque será la última. ¡Este mundo arderá cuando vuelva el maestro!"
})
