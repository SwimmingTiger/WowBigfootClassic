if GetLocale() ~= "frFR" then return end

local L

local optionWarning		= "Activer l'alerte : %s"
local optionPreWarning	= "Activer la pré-alerte : %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization(585)

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization(586)

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak (Groupe)"
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization(611)

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization(612)

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization(613)

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization(614)

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Vagues de Stratholme"
})

L:SetWarningLocalization({
	WarningWaveNow	= "Vague %d: %s"
})

L:SetTimerLocalization({
	TimerWaveIn		= 	"Prochaine vague (6)",
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("New Wave"),
	TimerWaveIn		= "Montre le timer \"Prochaine vague\" (vague 6 seulement)"
})

L:SetMiscLocalization({
	Devouring	= "Goule dévorante",
	Enraged		= "Goule enragée",
	Necro		= "Nécromancien",
	Fiend		= "Démon des cryptes",
	Stalker		= "Traqueur des tombes",
	Abom		= "Assemblage recousu",
	Acolyte		= "Acolyte",
	Wave1		= "%d %s",
	Wave2		= "%d %s et %d %s",
	Wave3		= "%d %s, %d %s et %d %s",
	Wave4		= "%d %s, %d %s, %d %s et %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Vagues du Fléau = (%d+)/10"
})

----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization(588)

------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization(589)

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization(590)

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization(591)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization(593)

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

------------
-- Loken --
------------
L = DBM:GetModLocalization(600)

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization(605)

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization(604)

----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization(607)

------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization(606)

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
   timerEvent   = "Temps restant"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Phase #"),
	timerEvent      = "Montrer le timer de l'event"
})

L:SetMiscLocalization({
	Pull	= "Ouvrez l'œil ! Je vais régler ça en deux coups de cuillè -",
	Phase1	= "Faille de sécurité détectée. Analyse des archives historiques transférée en attente de basse priorité. Contre-mesures déclenchées.",
	Phase2	= "Seuil d'indice de menace dépassé. Archivation céleste annulée. Niveau de sécurité augmenté.",
	Phase3	= "Indice de menace critique. Analyse du Vide détournée. Lancement des protocoles d'épuration.",
	Kill	= "Alerte : systèmes de protection désactivés. Purge de la mémoire en cours…"
})

---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1 	= "Il y en aura assez pour tout le monde.",
	SplitTrigger2 	= "Vous allez être trop bien servis !"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization(621)

---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Commandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Commandant Rudebarbe"
end

L:SetGeneralLocalization({
	name = commander
})

----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization(622)

L:SetOptionLocalization({
	MakeitCountTimer	= "Montre le timer pour le haut-fait Comptez là-dessus"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Comptez là-dessus"
})

--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization(624)

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization(623)

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization(625)

L:SetMiscLocalization({
	MakeitCountTimer	= "Comptez là-dessus"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization(638)

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization(639)

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization(640)

L:SetMiscLocalization({
	YellCombatEnd	= "Non ! Je peux faire... mieux, je peux..."
})

----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization(643)

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization(642)

---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization(632)

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization(626)

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization(628)

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization(630)

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization(627)

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization(629)

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization(631)

-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Timer des portails"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Portail imminent",
	WarningPortalNow	= "Portail #%d",
	WarningBossNow		= "Arrivée d'un boss"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portail #%d"
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Portail"),
	WarningPortalSoon		= optionPreWarning:format("Portail imminent"),
	WarningBossNow			= optionWarning:format("Arrivée d'un boss"),
	TimerPortalIn			= "Afficher le timer des portails",
	ShowAllPortalTimers		= "Activer les annonces pour toutes les vagues"
})

L:SetMiscLocalization({
	yell1 		= "Gardes, nous partons ! Ces aventuriers vont se charger de la suite ! Allez, en route !",
	WavePortal	= "Portails Ouverts : (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization(637)

L:SetMiscLocalization({
	YellCombatEnd			= "Non ! Pas encore... un échec..."
})

-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization(634)

L:SetMiscLocalization({
	YellCombatEnd		= "Joli combat ! Votre prochain défi vient directement des rangs de la Croisade. L'épreuve sera de vous mesurer à l'incroyable vituosité de ses cavaliers."
})

-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization(636)

L:SetMiscLocalization({
	YellCombatEnd	= "Bon travail !"
})

-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization(635)

L:SetMiscLocalization({
	YellCombatEnd			= "Grâce ! Je me rends. Excellent travail. Puis-je me débiner, maintenant ?"
})

---------------------
-- Pit of Saron --
-------------------
--  Ick and Krick  --
-------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage		= "%s commence à invoquer rapidement des mines explosives !"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetMiscLocalization({
	SaroniteRockThrow			= "%s hurls a massive saronite boulder at you!"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart		= "Hélas, mes très, très braves aventuriers, votre intrusion touche à sa fin. Entendez-vous le claquement de l'acier sur les os qui monte du tunnel, derrière vous ? C'est le son de votre mort imminente.",
	HoarfrostTarget	= "^%%s fixe (%S+) du regard et prépare une attaque de glace !",
	YellCombatEnd	= "Impossible.... Frigecroc.... avertis...."
})

---------------------
-- Forge of Souls --
---------------------
-- Bronjahm --
-------------------
L = DBM:GetModLocalization(615)

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization(616)

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Timers des vagues"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Prochaine vague bientôt",
	WarnNewWave		= "Arrivée de %s"
})

L:SetTimerLocalization({
	TimerNextWave	= "Prochaine vague"
})

L:SetOptionLocalization({
	WarnNewWave			= "Montre une alerte pour l'arrivée d'un boss",
	WarnNewWaveSoon		= "Montre une pré-alerte pour la prochaine vague",
	ShowAllWaveWarnings	= "Montre des alertes et pré-alertes pour toutes les vagues",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Affiche un timer pour le prochain ensemble de vague (après le boss de la vague 5)",
	ShowAllWaveTimers	= "Affiche un timer pour toutes les vagues"
})

L:SetMiscLocalization({
	WaveCheck	= "Vague d'esprit = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization(601)

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization(602)

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization(603)

L:SetWarningLocalization({
	WarnWave		= "%s"
})

L:SetOptionLocalization({
	WarnWave	= "Show warning for incoming waves"
})

L:SetMiscLocalization({
	CombatStart		= "Il est trop fort. Il faut vite partir d'ici ! Ma magie ne pourra le retenir qu'un court instant. Venez vite, héros !",
	YellCombatEnd	= "FEU ! FEU !"
})
