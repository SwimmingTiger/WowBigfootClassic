if GetLocale() ~= "deDE" then return end
local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flammenleviathan"
}

L:SetMiscLocalization{
	YellPull	= "Feindeinheiten erkannt. Bedrohungsbewertung aktiv. Hauptziel erfasst. Neubewertung in T minus 30 Sekunden.",
	Emote		= "%%s verfolgt (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Verfolgt >%s<",
	warnNextPursueSoon		= "Zielwechsel in 5 Sekunden",
	SpecialPursueWarnYou	= "Du wirst verfolgt - Lauf weg!",
	warnWardofLife			= "Zauberschutz des Lebens erscheint"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Spezialwarnung, wenn du $spell:62374 wirst",
	PursueWarn				= "Verkünde Ziele von $spell:62374",
	warnNextPursueSoon		= "Zeige Vorwarnung für nächstes $spell:62374",
	warnWardofLife			= "Spezialwarnung, wenn Zauberschutz des Lebens erscheint"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis, Meister des Eisenwerks"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Klingenschuppe"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "Letzes Geschütz bereit in 20 Sekunden",
	warnTurretsReady			= "Letzes Geschütz bereit"
}

L:SetTimerLocalization{
	timerTurret1	= "Geschütz 1",
	timerTurret2	= "Geschütz 2",
	timerTurret3	= "Geschütz 3",
	timerTurret4	= "Geschütz 4",
	timerGrounded	= "Bodenphase"
}

L:SetOptionLocalization{
	warnTurretsReadySoon		= "Zeige Vorwarnung für Fertigstellung des letzten Harpunengeschützes",
	warnTurretsReady			= "Zeige Warnung bei Fertigstellung des letzten Harpunengeschützes",
	timerTurret1				= "Zeige Zeit bis erstes Harpunengeschütz einsatzbereit ist",
	timerTurret2				= "Zeige Zeit bis zweites Harpunengeschütz einsatzbereit ist",
	timerTurret3				= "Zeige Zeit bis drittes Harpunengeschütz einsatzbereit ist (25 Spieler)",
	timerTurret4				= "Zeige Zeit bis viertes Harpunengeschütz einsatzbereit ist (25 Spieler)",
	timerGrounded			    = "Dauer der Bodenphase anzeigen"
}

L:SetMiscLocalization{
	YellAir				= "Gebt uns einen Moment, damit wir uns auf den Bau der Geschütze vorbereiten können.",
	YellAir2			= "Feuer einstellen! Lasst uns diese Geschütze reparieren!",
	YellGround			= "Beeilt Euch! Sie wird nicht lange am Boden bleiben!",
	EmotePhase2			= "ist dauerhaft an den Boden gebunden!"
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Dekonstruktor"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Die Versammlung des Eisens"
}

L:SetOptionLocalization{
	AlwaysWarnOnOverload		= "Warne immer bei $spell:63481 (sonst nur wenn Sturmrufer Brundir im Ziel)"
}

L:SetMiscLocalization{
	Steelbreaker		= "Stahlbrecher",
	RunemasterMolgeim	= "Runenmeister Molgeim",
	StormcallerBrundir 	= "Sturmrufer Brundir"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon der Beobachter"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Nächste Kollabierende Sterne",
	TimerCombatStart		= "Kampfbeginn"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "Phase 2 bald",
	warnStarLow				= "Kollabierender Stern stirbt bald"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Verkünde Ziele von $spell:64412",
	NextCollapsingStar		= "Zeige Zeit bis nächste Kollabierende Sterne erscheinen",
	TimerCombatStart		= "Zeige Zeit bis Kampfbeginn",
	WarnPhase2Soon			= "Zeige Vorwarnung für Phase 2 (bei ~23%)",
	warnStarLow				= "Spezialwarnung, wenn ein Kollabierender Stern bald stirbt (bei ~25%)"
}

L:SetMiscLocalization{
	HealthInfo				= "Heilen für Sterne",
	YellPull				= "Euer Handeln ist unlogisch. Alle Möglichkeiten dieser Begegnung wurden berechnet. Das Pantheon wird die Nachricht des Beobachters erhalten, ungeachtet des Ausgangs.",
	YellKill				= "Ich sah Welten umhüllt von den Flammen der Schöpfer, sah ohne einen Hauch von Trauer ihre Bewohner vergehen. Ganze Planetensysteme geboren und vernichtet, während Eure sterblichen Herzen nur einmal schlagen. Doch immer war mein Herz kalt... ohne Mitgefühl. Ich - habe - nichts - gefühlt. Millionen, Milliarden Leben verschwendet. Trugen sie alle dieselbe Beharrlichkeit in sich, wie Ihr? Liebten sie alle das Leben so sehr, wie Ihr es tut?",
	Emote_CollapsingStar	= "%s beginnt damit, kollabierende Sterne zu beschwören!",
	Phase2					= "Erblicket die Instrumente der Schöpfung!",
	FirstPull				= "Seht Eure Welt durch meine Augen: Ein Universum so gewaltig - grenzenlos - unbegreiflich selbst für die Klügsten unter Euch."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetTimerLocalization{
	timerLeftArm		= "Nachwachsen linker Arm",
	timerRightArm		= "Nachwachsen rechter Arm",
	achievementDisarmed	= "Zeit für Arm-ab-Erfolg"
}

L:SetOptionLocalization{
	timerLeftArm			= "Zeige Zeit bis der linke Arm nachwächst",
	timerRightArm			= "Zeige Zeit bis der rechte Arm nachwächst",
	achievementDisarmed		= "Zeige Timer für Erfolg 'Arm dran, weil Arm ab'"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Das ist nur ein Kratzer!",
	Yell_Trigger_arm_right	= "Ist nur 'ne Fleischwunde!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Rechter Arm",
	Health_Left_Arm			= "Linker Arm",
	FocusedEyebeam			= "%s fokussiert seinen Blick auf Euch!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Wilder Verteidiger (%d)",
	YellPull = "In manche Dinge mischt man sich besser nicht ein!"
}

L:SetTimerLocalization{
	timerDefender	= "Wilder Verteidiger wird aktiviert"
}

L:SetWarningLocalization{
	WarnCatDied		= "Wilder Verteidiger tot (%d Leben übrig)",
	WarnCatDiedOne	= "Wilder Verteidiger tot (1 Leben übrig)"
}

L:SetOptionLocalization{
	WarnCatDied		= "Zeige Warnung, wenn der Wilde Verteidiger stirbt",
	WarnCatDiedOne	= "Zeige Warnung, wenn der Wilde Verteidiger nur noch 1 Leben übrig hat",
	timerDefender	= "Zeige Zeit bis zur Aktivierung des Wilden Verteidigers"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetMiscLocalization{
	Pull		= "Für Euer Eindringen werdet Ihr bezahlen!",
	YellKill	= "Ich... bin von ihm befreit... endlich."
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode	= "Zeige Timer für Hard Mode",
	AnnounceFails	= "Verkünde Spieler im Schlachtzugchat, die bei $spell:62466 scheitern (benötigt aktivierte Mitteilungen und Leiter-/Assistentenstatus)"
}

L:SetMiscLocalization{
	YellPhase1	= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2	= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill	= "Senkt Eure Waffen! Ich ergebe mich!",
	ChargeOn	= "Blitzladung: %s",
	Charge		= "Fehler bei Blitzladung (dieser Versuch): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell          = "Helft mir, Kinder!",
	WaterSpirit        = "Uralter Wassergeist",
	Snaplasher         = "Knallpeitscher",
	StormLasher        = "Sturmpeitscher",
	YellKill           = "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden."
}

L:SetWarningLocalization{
	WarnSimulKill	= "Erster Elementar tot - Wiederbelebung in ~12 Sekunden"
}

L:SetTimerLocalization{
	TimerSimulKill	= "Wiederbelebung"
}

L:SetOptionLocalization{
	WarnSimulKill	= "Verkünde Tod des ersten Elementars",
	TimerSimulKill	= "Zeige Zeit bis zur Wiederbelebung der Elementare"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freyas Älteste"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< hat den Magnetischen Kern",
	WarnBombSpawn		= "Bombenbot erschienen"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode - Selbstzerstörung",
	TimeToPhase2	= "Phase 2",
	TimeToPhase3	= "Phase 3",
	TimeToPhase4	= "Phase 4"
}

L:SetOptionLocalization{
	TimeToPhase2			= "Zeige Zeit bis Phase 2",
	TimeToPhase3			= "Zeige Zeit bis Phase 3",
	TimeToPhase4			= "Zeige Zeit bis Phase 4",
	MagneticCore			= "Verkünde Spieler, die Magnetische Kerne plündern",
	WarnBombSpawn			= "Zeige Warnung für Bombenbot",
	TimerHardmode			= "Zeige Timer für Hard Mode"
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Luftkommandoeinheit",
	YellPull		= "Wir haben nicht viel Zeit, Freunde! Ihr werdet mir dabei helfen, meine neueste und großartigste Kreation zu testen. Bevor Ihr nun Eure Meinung ändert, denkt daran, dass Ihr mir etwas schuldig seid, nach dem Unfug, den Ihr mit dem XT-002 angestellt habt.",
	YellHardPull	= "Warum habt Ihr das denn jetzt gemacht? Habt Ihr das Schild nicht gesehen, auf dem steht \"DIESEN KNOPF NICHT DRÜCKEN!\"? Wie sollen wir die Tests abschließen, solange der Selbstzerstörungsmechanismus aktiv ist?",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Saronitanimus erscheint"
}

L:SetOptionLocalization{
	hardmodeSpawn					= "Zeige Zeit bis zum Erscheinen des Saronitanimus (Hard Mode)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "Eine Wolke Saronitdämpfe bildet sich in der Nähe!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Wächter %d erschienen",
	WarningCrusherTentacleSpawned	= "Schmettertentakel erschienen",
	WarningSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnMadnessOutNow			= "Wahnsinn hervorrufen - LAUF RAUS!",
	WarnBrainPortalSoon				= "Gehirnportale in 3 Sek",
	specWarnBrainPortalSoon			= "Gehirnportale bald"
}

L:SetTimerLocalization{
	NextPortal	= "Gehirnportale"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Zeige Warnung, wenn ein Wächter des Yogg-Saron erscheint",
	WarningCrusherTentacleSpawned	= "Zeige Warnung, wenn ein Schmettertentakel erscheint",
	WarningSanity					= "Zeige Warnung, wenn deine $spell:63050 niedrig ist",
	SpecWarnSanity					= "Spezialwarnung, wenn deine $spell:63050 sehr niedrig ist",
	WarnBrainPortalSoon				= "Zeige Vorwarnung für Gehirnportale",
	SpecWarnMadnessOutNow			= "Spezialwarnung kurz bevor $spell:64059 zu Ende gewirkt wird",
	specWarnBrainPortalSoon			= "Spezialwarnung für nächste Gehirnportale",
	NextPortal						= "Zeige Zeit bis nächste Gehirnportale"
}

L:SetMiscLocalization{
	YellPull 			= "Bald ist die Zeit gekommen, dem Untier den Kopf abzuschlagen! Konzentriert Euren Zorn und Euren Hass auf seine Diener!",
	YellPhase2	 		= "Ich bin der strahlende Traum.",
	Sara 				= "Sara"
}
