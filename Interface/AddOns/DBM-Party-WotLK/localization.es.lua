if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------------
-- Ahn'Kahet: El Antiguo Reino --
---------------------------------
-----------------------
-- Príncipe Taldaram --
-----------------------
L = DBM:GetModLocalization(581)

--------------------
-- Ancestro Nadox --
--------------------
L = DBM:GetModLocalization(580)

-------------------------
-- Jedoga Buscasombras --
-------------------------
L = DBM:GetModLocalization(582)

--------------------
-- Heraldo Volazj --
--------------------
L = DBM:GetModLocalization(584)

--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization(583)

-----------------
-- Azjol-Nerub --
-----------------
---------------
-- Krik'thir --
---------------
L = DBM:GetModLocalization(585)

--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization(586)

---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization(587)


------------------------------
-- La Matanza de Stratholme --
------------------------------
------------
-- Gancho --
------------
L = DBM:GetModLocalization(611)

--------------
--  Salramm --
--------------
L = DBM:GetModLocalization(612)

-----------------------
--  Cronolord Época  --
-----------------------
L = DBM:GetModLocalization(613)

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization(614)

L:SetMiscLocalization({
	Outro	= "Tu viaje acaba de comenzar, joven Príncipe. Reúne a tus tropas y ven a verme en las árticas tierras de Rasganorte. Allí ajustaremos cuentas. Allí es donde se desvelará tu verdadero destino."
})

-------------------------------
-- Temporizadores de oleadas --
-------------------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Oleadas de Stratholme"
})

L:SetWarningLocalization({
	WarningWaveNow		= "Oleada %d: %s"
})

L:SetTimerLocalization({
	TimerWaveIn	= 	"Siguiente oleada (6)",
	TimerRoleplay	= "Diálogo"
})

L:SetOptionLocalization({
	WarningWaveNow	= "Mostrar avisos para nuevas oleadas",
	TimerWaveIn		= "Mostrar temporizador para próximas oleadas (despues del jefe de la quinta oleada)",
	TimerRoleplay	= "Mostrar temporizador para el diálogo inicial"
})


L:SetMiscLocalization({
	Devouring	= "Necrófago devorador",
	Enraged		= "Necrófago iracundo",
	Necro		= "Nigromante oscuro",
	Fiend		= "Maligno de cripta",
	Stalker		= "Acechador de tumbas",
	Abom		= "Ensamblaje de retazos",
	Acolyte		= "Acólito",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Oleada de la Plaga = (%d+)/10",
	Roleplay	= "Me alegra que lo consiguieras, Uther.",
	Roleplay2	= "Parece que todo el mundo está listo. Recordad, esta gente está infectada por la peste y pronto morirá. Debemos purgar Stratholme para proteger de la Plaga lo que queda de Lordaeron. Vamos."
})


------------------------------
-- Fortaleza de Drak'Tharon --
------------------------------
----------------
-- Cuernotrol --
----------------
L = DBM:GetModLocalization(588)

------------------------
-- Novos el Invocador --
------------------------
L = DBM:GetModLocalization(589)

L:SetMiscLocalization({
	YellPull		= "¡El frío que sentís es el presagio de vuestro sino!",
	HandlerYell		= "¡Refuerza mis defensas! ¡Deprisa, maldito!",
	Phase2			= "¡Seguro que ahora veis la inutilidad de todo ello!",
	YellKill		= "Vuestros esfuerzos... son en vano."
})

--------------
-- Rey Dred --
--------------
L = DBM:GetModLocalization(590)

--------------------------
-- El profeta Tharon'ja --
--------------------------
L = DBM:GetModLocalization(591)

-------------
-- Gundrak --
-------------
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization(592)

-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization(594)

---------------------
-- Coloso Drakkari --
---------------------
L = DBM:GetModLocalization(593)

---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization(596)

------------------
-- Eck el Feroz --
------------------
L = DBM:GetModLocalization(595)

---------------------------
-- Cámaras de Relámpagos --
---------------------------
-----------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization(597)

-----------
-- Ionar --
-----------
L = DBM:GetModLocalization(599)

-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization(598)

-----------
-- Loken --
-----------
L = DBM:GetModLocalization(600)

-----------------------
-- Cámaras de Piedra --
-----------------------
----------------------
-- Doncella de Pena --
----------------------
L = DBM:GetModLocalization(605)

----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization(604)

-------------------------
-- Sjonnir el Afilador --
-------------------------
L = DBM:GetModLocalization(607)

--------------------------------
-- El Tribunal de los Tiempos --
--------------------------------
L = DBM:GetModLocalization(606)

L:SetWarningLocalization({
	WarningPhase	= "Fase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Tiempo restante"
})

L:SetOptionLocalization({
	WarningPhase	= "Mostrar aviso para el cambio de fase",
	timerEvent		= "Mostrar tiempo restante del evento"
})

L:SetMiscLocalization({
	Pull	= "¡Atentos! Tendré esto listo en un par de...",
	Phase1	= "Incumplimiento del código de seguridad en progreso. Análisis de los archivos históricos relegado a la cola de menor prioridad. Contramedidas activadas.",
	Phase2	= "Límite de índice de amenaza superado. Archivo celestial cancelado. Nivel de seguridad aumentado.",
	Phase3	= "Índice de amenaza crítico. Análisis del vacío desviado. Iniciando protocolo de higienización.",
	Kill	= "Alerta: sistema de seguridad desactivado. Comenzando purga de memoria y..."
})

-------------
-- El Nexo --
-------------
--------------
-- Anomalus --
--------------
L = DBM:GetModLocalization(619)

------------------------
-- Ormorok el Talador --
------------------------
L = DBM:GetModLocalization(620)

------------------------
-- Gran maga Telestra --
------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1 = "¡Tendréis más de lo que podéis soportar!",
	SplitTrigger2 = "¡Tendréis más de lo que podéis soportar!"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization(621)

-----------------------------------
-- Comandante Kolurg/Barbarrecia --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Comandante"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Comandante Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Comandante Barbarrecia"
end

L:SetGeneralLocalization({
	name = commander
})


---------------
-- El Oculus --
---------------
----------------------------
-- Drakos el Interrogador --
----------------------------
L = DBM:GetModLocalization(622)

L:SetOptionLocalization({
	MakeitCountTimer	= "Mostrar temporizador para el logro 'Haz que cuente'"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Logro: Haz que cuente"
})


----------------------------
-- Señor de la magia Urom --
----------------------------
L = DBM:GetModLocalization(624)

L:SetMiscLocalization({
	CombatStart		= "¡Pobres necios ciegos!"
})

----------------------
-- Varos Zancanubes --
----------------------
L = DBM:GetModLocalization(623)

-------------------------
-- Guardián-Ley Eregos --
-------------------------
L = DBM:GetModLocalization(625)

L:SetMiscLocalization({
	MakeitCountTimer	= "Haz que cuente"
})

--------------------------
-- Fortaleza de Utgarde --
--------------------------
-----------------------
-- Príncipe Keleseth --
-----------------------
L = DBM:GetModLocalization(638)

------------------------
-- Skarvald y Dalronn --
------------------------
L = DBM:GetModLocalization(639)

----------------------------
-- Ingvar el Desvalijador --
----------------------------
L = DBM:GetModLocalization(640)

L:SetMiscLocalization({
	YellCombatEnd	= "¡No! Puedo hacerlo... ¡mejor! Puedo..."
})

-------------------------
-- Pináculo de Utgarde --
-------------------------
-------------------------
-- Skadi el Despiadado --
-------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "¿Qué chuchos son los que se atreven a irrumpir aquí? ¡Adelante, hermanos! ¡Un festín para quien me traiga sus cabezas!",
	Phase2			= "¡Bastardos malnacidos! ¡Vuestros cadáveres serán un buen bocado para mis nuevos dracos!"
})

----------------
-- Rey Ymiron --
----------------
L = DBM:GetModLocalization(644)

---------------------
-- Svala Tumbapena --
---------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Comienza el encuentro"
})

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar tiempo de diálogo antes de que Svala ataque"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "¡Mi señor! He hecho lo que pedisteis, ¡y ahora suplico vuestra bendición!"
})

--------------------------
-- Gortok Pezuña Pálida --
--------------------------
L = DBM:GetModLocalization(642)

------------------------
-- El Bastión Violeta --
------------------------
---------------
-- Cianigosa --
---------------
L = DBM:GetModLocalization(632)

L:SetMiscLocalization({
	CyanArrived	= "Una defensa valiente, pero esta ciudad debe ser arrasada. ¡Yo misma cumpliré los deseos de Malygos!"
})

------------
-- Erekem --
------------
L = DBM:GetModLocalization(626)

------------
-- Ícoron --
------------
L = DBM:GetModLocalization(628)

---------------
-- Lavanthor --
---------------
L = DBM:GetModLocalization(630)

------------
-- Moragg --
------------
L = DBM:GetModLocalization(627)

------------
-- Xevozz --
------------
L = DBM:GetModLocalization(629)

----------------------------
-- Zuramat el Obliterador --
----------------------------
L = DBM:GetModLocalization(631)

--------------------------------
-- Temporizadores de portales --
--------------------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Temporizador de portales"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Siguiente portal en breve",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Jefe en breve"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal %d" ,
})

L:SetOptionLocalization({
	WarningPortalNow		= "Mostrar aviso cuando aparezca un portal",
	WarningPortalSoon		= "Mostrar aviso previo para el siguiente portales",
	WarningBossNow			= "Mostrar aviso previo para el siguiente jefe",
	TimerPortalIn			= "Mostrar temporizador para el siguiente portal (después de jefe)",
	ShowAllPortalTimers		= "Mostrar temporizadores para todos los portales (impreciso)"
})


L:SetMiscLocalization({
	Sealbroken	= "¡Hemos atravesado la puerta de la prisión! ¡El camino hacia Dalaran está despejado! ¡Por fin hemos puesto punto y final a la guerra de El Nexo!",
	WavePortal		= "Portales abiertos: (%d+)/18"
})


------------------------
-- Prueba del Campeón --
------------------------
------------------------
-- El Caballero Negro --
------------------------
L = DBM:GetModLocalization(637)

L:SetOptionLocalization({
	AchievementCheck		= "Anunciar fallo del logro 'Podría ser peor' al grupo"
})

L:SetMiscLocalization({
	Pull			= "Bien hecho. Hoy has demostrado algo...",
	AchievementFailed	= ">> LOGRO FALLADO: %s ha sido alcanzado por Explosión de necrófago <<",
	YellCombatEnd	= "¡No! No debo fallar... otra vez..."
})


-----------------------
-- Grandes Campeones --
-----------------------
L = DBM:GetModLocalization(634)

L:SetMiscLocalization({
	YellCombatEnd	= "¡Bien luchado! Vuestro próximo reto llega de entre las filas de la propia Cruzada. Se os pondrá a prueba contra su considerable destreza."
})


----------------------------
-- Confesora Cabelloclaro --
----------------------------
L = DBM:GetModLocalization(636)

L:SetMiscLocalization({
	YellCombatEnd	= "¡Un trabajo excelente!"
})

--------------------
-- Eadric el Puro --
--------------------
L = DBM:GetModLocalization(635)

L:SetWarningLocalization({
	specwarnRadiance		= "Radiancia. ¡Date la vuelta!"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Mostrar aviso especial para $spell:66935"
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Me rindo! Lo admito. Un trabajo excelente. ¿Puedo escaparme ya?"
})

-------------------
-- Foso de Saron --
-------------------
-----------------
-- Agh y Puagh --
-----------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage					= "¡%s comienza a invocar minas explosivas!"
})
-------------------------------
-- Maestro de forja Gargelus --
-------------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck	= "Anunciar avisos del logro 'Solo once campanadas' en el chat de grupo"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "¡%s te lanza un pedrusco de saronita enorme!",
	AchievementWarning	= "Aviso: %s tiene %d acumulaciones de Escarcha permanente",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d acumulaciones de Escarcha permanente <<"
})

--------------------------------
-- Señor de la Plaga Tyrannus --
--------------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart					= "¡Ay! Valientes aventureros, vuestra intromisión ha llegado a su fin. ¿Oís el ruido de huesos y acero acercándose por ese túnel? Es el sonido de vuestra inminente muerte.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget				= "¡La vermis de escarcha Dientrefrío mira a (%S+) y prepara un helado ataque!",
	YellCombatEnd				= "Imposible... Dientefrío... Avisa..."
})

-----------------------
-- La Forja de Almas --
-----------------------
----------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization(615)

-----------------
-- Devoraalmas --
-----------------
L = DBM:GetModLocalization(616)

--------------------------
-- Cámaras de Reflexión --
--------------------------
-------------------------------
-- Temporizadores de oleadas --
-------------------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Temporizador de oleadas"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Nueva oleada pronto",
	WarnNewWave		= "%s"
})

L:SetTimerLocalization({
	TimerNextWave	= "Siguiente oleada"
})

L:SetOptionLocalization({
	WarnNewWave			= "Mostrar aviso cuando llega una oleada",
	WarnNewWaveSoon		= "Mostrar aviso previo para nueva oleada (después del primer jefe)",
	ShowAllWaveWarnings	= "Mostrar avisos previos para todas las oleadas",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Mostrar temporizador para la siguiente tanda de oleadas (después del primer jefe)",
	ShowAllWaveTimers	= "Mostrar temporizadores para todas las oleadas (impreciso)"
})

L:SetMiscLocalization({
	WaveCheck	= "Oleada de espíritus = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization(601)

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization(602)

---------------------
-- Huida de Arthas --
---------------------
L = DBM:GetModLocalization(603)

L:SetWarningLocalization({
	WarnWave		= "%s"
})

L:SetTimerLocalization({
	achievementEscape	= "Logro: No nos retiramos"
})

L:SetOptionLocalization({
	WarnWave	= "Mostrar avisos para las oleadas próximas"
})

L:SetMiscLocalization({
	ACombatStart	= "Es demasiado poderoso. ¡Debemos abandonar este lugar ahora mismo! Mi magia podrá inmovilizarlo brevemente. ¡Vamos rápido, héroes!",
	HCombatStart	= "Es... demasiado poderoso. Héroes, rápido... ¡venid! ¡Debemos abandonar este lugar ahora mismo! Haré lo que pueda para inmovilizarlo mientras huimos.",
	Wave1			= "¡No hay escapatoria!",
	Wave2			= "Sucumbid al frío de la tumba.",
	Wave3			= "Otro final sin salida.",
	Wave4			= "¿Cuánto vais a aguantar?",
	YellCombatEnd	= "¡FUEGO! ¡FUEGO!"
})
