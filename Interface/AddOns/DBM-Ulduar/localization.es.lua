if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------------------
-- Leviatán de llamas --
------------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flame Leviathan"
}

L:SetMiscLocalization{
	YellPull	= "Entidades hostiles detectadas. Protocolo de evaluación de amenaza activado. Objetivo principal fijado. Tiempo restante para re-evaluación: 30 segundos.",
	Emote		= "%%s persigue a (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Persiguiendo a >%s<",
	warnNextPursueSoon		= "Cambio de objetivo en 5 s",
	SpecialPursueWarnYou	= "El leviatán te persigue - ¡huye!",
	warnWardofLife			= "Guarda de vida"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Mostrar aviso especial cuando te afecte $spell:62374",
	PursueWarn				= "Anunciar objetivos de $spell:62374",
	warnNextPursueSoon		= "Mostrar aviso previo para el siguiente $spell:62374",
	warnWardofLife			= "Mostrar aviso especial cuando aparezcan Guardas de vida"
}

------------------------------------
-- Ignis el Maestro de la Caldera --
------------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis the Furnace Master"
}

L:SetOptionLocalization{
	SlagPotIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TARGETS:format(63477)
}

----------------
-- Tajoescama --
----------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "Última torreta lista en 20 s",
	warnTurretsReady			= "Última torreta lista"
}

L:SetTimerLocalization{
	timerTurret1	= "Torreta 1",
	timerTurret2	= "Torreta 2",
	timerTurret3	= "Torreta 3",
	timerTurret4	= "Torreta 4",
	timerGrounded	= "En tierra"
}

L:SetOptionLocalization{
	warnTurretsReadySoon		= "Mostrar aviso previo para cuando las torretas estén listas",
	warnTurretsReady			= "Mostrar aviso cuando las torretas estén listas",
	timerTurret1				= "Mostrar temporizador para la primera torreta",
	timerTurret2				= "Mostrar temporizador para la segunda torreta",
	timerTurret3				= "Mostrar temporizador para la tercera torreta (25 jugadores)",
	timerTurret4				= "Mostrar temporizador para la cuarta torreta (25 jugadores)",
	timerGrounded			    = "Mostrar temporizador para la duración de la fase en tierra"
}

L:SetMiscLocalization{
	YellAir				        = "Danos un momento para que nos preparemos para construir las torretas.",
	YellAir2			        = "Listos para salir, ¡impedid que esos enanos se peguen a nuestra espalda!",
	YellGround				    = "¡Moveos! ¡No seguirá mucho más en el suelo!",
	EmotePhase2			        = "¡%%s ha aterrizado permanentemente!",
}

-----------------------
-- Desarmador XA-002 --
-----------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Desarmador XA-002"
}

---------------------------
-- La Asamblea de Hierro --
---------------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "La Asamblea de Hierro"
}

L:SetOptionLocalization{
	AlwaysWarnOnOverload		= "Mostrar siempre aviso para $spell:63481 (de lo contrario, solo se muestra cuando eres el objetivo)"
}

L:SetMiscLocalization{
	Steelbreaker		= "Rompeacero",
	RunemasterMolgeim	= "Maestro de runas Molgeim",
	StormcallerBrundir 	= "Clamatormentas Brundir"
}

---------------------------
-- Algalon el Observador --
---------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon el Observador"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Siguiente Estrella en colapso",
	TimerCombatStart		= "Comienza el encuentro"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "Fase 2 en breve",
	warnStarLow				= "Estrella en colapso a poca salud"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Anunciar objetivos de $spell:64412",
	NextCollapsingStar		= "Mostrar temporizador para la siguiente Estrella en colapso",
	TimerCombatStart		= "Mostrar temporizador para el inicio del encuentro",
	WarnPhase2Soon			= "Mostrar aviso previo para el cambio a Fase 2 (cuando el jefe llegue al 23% de salud)",
	warnStarLow				= "Mostrar aviso especial cuando una Estrella en colapso tenga la salud baja (25%)"
}

L:SetMiscLocalization{
	YellPull				= "Vuestros actos carecen de lógica. Se ha calculado cualquier posible resultado de este encuentro. El Panteón recibirá el mensaje del Observador sean cuales sean las consecuencias.",
	YellKill				= "He visto mundos hundirse en las llamas de los Creadores, como se desvanecían sus habitantes sin apenas un gemido. He visto sistemas planetarios enteros crearse y ser arrasados en lo que vuestros mortales corazones laten una sola vez. Y mi corazón permaneció desprovisto de emoción... de empatía. Yo... no... sentí... nada. Millones de vidas malgastadas ¿Acaso compartían vuestra tenacidad? ¿Amaban la vida como vosotros?",
	Emote_CollapsingStar	= "¡%s comienza a invocar estrellas en colapso!",
	Phase2					= "¡Observad las herramientas de la creación!",
	FirstPull				= "Mirad vuestro mundo a través de mis ojos: un universo tan vasto que es inconmensurable, incompresible incluso para vuestras grandes mentes."
}

--------------
-- Kologarn --
--------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetTimerLocalization{
	timerLeftArm		= "Brazo izquierdo reaparece",
	timerRightArm		= "Brazo derecho reaparece",
	achievementDisarmed	= "Logro: Desarmado"
}

L:SetOptionLocalization{
	timerLeftArm			= "Mostrar temporizador para la regeneración del Brazo izquierdo",
	timerRightArm			= "Mostrar temporizador para la regeneración del Brazo derecho",
	achievementDisarmed		= "Mostrar temporizador para el logro 'Desarmado'"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "¡No es más que un arañazo!",
	Yell_Trigger_arm_right	= "¡Una herida superficial!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Brazo derecho",
	Health_Left_Arm			= "Brazo izquierdo",
	FocusedEyebeam			= "sus ojos en ti",
	YellBeam				= "¡Haz ocular enfocado en mi!"
}

-------------
-- Auriaya --
-------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Defensor feral (%d)",
	YellPull = "¡Es mejor dejar ciertas cosas tal como están!"
}

L:SetTimerLocalization{
	timerDefender	= "Defensor feral activo"
}

L:SetWarningLocalization{
	WarnCatDied		= "Defensor feral muerto (%d vidas restantes)",
	WarnCatDiedOne	= "Defensor feral muerto (1 vida restante)"
}

L:SetOptionLocalization{
	WarnCatDied		= "Mostrar aviso cuando muera el Defensor feral",
	WarnCatDiedOne	= "Mostrar aviso cuando el Defensor feral solo tenga una vida restante",
	timerDefender	= "Mostrar temporizador para cuando aparezca o reviva el Defensor feral"
}

-----------
-- Hodir --
-----------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetMiscLocalization{
	Pull		= "¡Sufriréis por esta intromisión!",
	YellKill	= "Estoy... estoy libre de sus garras... al fin."
}

------------
-- Thorim --
------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetTimerLocalization{
	TimerHardmode	= "Modo difícil"
}

L:SetOptionLocalization{
	TimerHardmode	= "Mostrar temporizador para el modo difícil",
	AnnounceFails	= "Anunciar jugadores que reciban daño de $spell:62017 en el chat de banda (requiere líder o ayudante)"
}

L:SetMiscLocalization{
	YellPhase1	= "¡Intrusos! Vosotros, mortales que osáis interferir en mi diversión, pagaréis... Un momento...",
	YellPhase2	= "Gusanos impertinentes, ¿cómo osáis desafiarme en mi pedestal? ¡Os machacaré con mis propias manos!",
	YellKill	= "¡Guardad las armas! ¡Me rindo!",
	ChargeOn	= "Carga relámpago: %s",
	Charge		= "Fallos en Carga relámpago (en este intento): %s"
}

-----------
-- Freya --
-----------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell		= "¡Hijos, ayudadme!",
	WaterSpirit		= "Espíritu de agua antiguo",
	Snaplasher		= "Quiebrazotador",
	StormLasher		= "Azotador de tormenta",
	YellKill		= "Su control sobre mí se disipa. Vuelvo a ver con claridad. Gracias, héroes.",
}

L:SetWarningLocalization{
	WarnSimulKill	= "Primer esbirro muerto - Resurrección en ~12 segundos"
}

L:SetTimerLocalization{
	TimerSimulKill	= "Resurrección"
}

L:SetOptionLocalization{
	WarnSimulKill	= "Anunciar primer esbirro muerto",
	TimerSimulKill	= "Mostrar temporizador para la resurrección de esbirros"
}

------------------------
-- Ancestros de Freya --
------------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Ancestros de Freya"
}

-------------
-- Mimiron --
-------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< tiene Núcleo magnético",
	WarningShockBlast	= "Explosión de choque - ¡aléjate!",
	WarnBombSpawn		= "Bombabot"
}

L:SetTimerLocalization{
	TimerHardmode	= "Autodestrucción",
	TimeToPhase2	= "Fase 2",
	TimeToPhase3	= "Fase 3",
	TimeToPhase4	= "Fase 4"
}

L:SetOptionLocalization{
	TimeToPhase2			= "Mostrar temporizador para el cambio a Fase 2",
	TimeToPhase3			= "Mostrar temporizador para el cambio a Fase 3",
	TimeToPhase4			= "Mostrar temporizador para el cambio a Fase 4",
	MagneticCore			= "Anunciar jugadores que despojen Núcleos magnéticos",
	WarnBombSpawn			= "Mostrar aviso cuando aparezcan Bombabots",
	TimerHardmode			= "Mostrar temporizador para la autodestrucción del modo difícil",
	ShockBlastWarningInP1	= "Mostrar aviso especial para $spell:63631 en Fase 1",
	ShockBlastWarningInP4	= "Mostrar aviso especial para $spell:63631 en Fase 4"
}

L:SetMiscLocalization{
	MobPhase1		= "Mk II de leviatán",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unidad de mando aérea",
	YellPull		= "¡No tenemos mucho tiempo, amigos! Vais a ayudarme a probar mi última y mayor creación. Ahora, antes de que cambiéis de parecer, recordad que en cierta forma, me lo debéis después del desastre que causasteis con el XA-002.",
	YellHardPull	= "Secuencia de autodestrucción iniciada",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

-------------------
-- General Vezax --
-------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Animus de saronita"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Fragor de sombra en ti - ¡aléjate de los demás!",
	SpecialWarningShadowCrashNear	= "Fragot de sombra cerca de ti - ¡apártate!",
	SpecialWarningLLNear			= "Marca de los Ignotos en %s cerca de ti"
}

L:SetOptionLocalization{
	SpecialWarningShadowCrash		= "Mostrar aviso especial para $spell:62660",
	SpecialWarningShadowCrashNear	= "Mostrar aviso especial cuando $spell:62660 ocurra cerca de ti",
	SpecialWarningLLNear			= "Mostrar aviso especial cuando $spell:63276 ocurra cerca de ti",
	hardmodeSpawn					= "Mostrar temporizador para cuando aparezca el Animus de saronita (modo difícil)",
	CrashArrow						= "Mostrar flecha cuando $spell:62660 ocurra cerca de ti"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "¡Cerca se forma una nube de vapores de saronita!",
	YellLeech			= "¡Drenar vida en mí!",
	YellCrash			= "¡Fragor de sombra en mí!"
}

----------------
-- Yogg-Saron --
----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Guardián (%d)",
	WarningCrusherTentacleSpawned	= "Tentáculo triturador",
	WarningSanity 					= "%d de Cordura restante",
	SpecWarnSanity 					= "%d de Cordura restante",
	SpecWarnGuardianLow				= "Guardián a poca salud - ¡deja de atacar!",
	SpecWarnMadnessOutNow			= "Inducir a la locura en breve - ¡sal ya!",
	WarnBrainPortalSoon				= "Portales en 3 s",
	SpecWarnFervor					= "Fervor de Sara en ti",
	SpecWarnFervorCast				= "Fervor de Sara se está lanzando en ti",
	specWarnBrainPortalSoon			= "Portal en breve"
}

L:SetTimerLocalization{
	NextPortal	= "Siguientes portales"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Mostrar aviso cuando aparezca un Guardián de Yogg-Saron",
	WarningCrusherTentacleSpawned	= "Mostrar aviso cuando aparezca un Tentáculo triturador",
	WarningSanity					= "Mostrar aviso cuando te quede poca $spell:63050",
	SpecWarnSanity					= "Mostrar aviso especial cuando te quede muy poca $spell:63050",
	SpecWarnGuardianLow				= "Mostrar aviso especial cuando a un Guardián de Yogg-Saron le quede poca vida (solo para DPS)",
	WarnBrainPortalSoon				= "Mostrar aviso previo para los siguientes portales",
	SpecWarnMadnessOutNow			= "Mostrar aviso especial cuando $spell:64059 esté a punto de lanzarse",
	SpecWarnFervorCast				= "Mostrar aviso especial cuando te estén lanzando $spell:63138",
	specWarnBrainPortalSoon			= "Mostrar aviso especial para los siguientes portales",
	NextPortal						= "Mostrar temporizador para los siguientes portales",
	MaladyArrow						= "Mostrar flecha cuando $spell:63881 ocurra cerca de ti"
}

L:SetMiscLocalization{
	YellPull 			= "¡Pronto llegará la hora de golpear la cabeza del monstruo! ¡Centrad vuestra ira y odio en sus esbirros!",
	YellPhase2	 		= "Soy un sueño lúcido.",
	Sara 				= "Sara"
}
