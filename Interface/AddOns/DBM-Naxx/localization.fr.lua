if GetLocale() ~= "frFR" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Nuée de sauterelles!",
	WarningLocustFaded	= "Fin de la nuée de sauterelles"
})

L:SetOptionLocalization({
	SpecialLocust		= "Activer l'avertissement special pour la Nuée de sauterelles",
	WarningLocustFaded	= "Avertir à la fin de la Nuée de sauterelles",
	TimerLocustFade 	= "Afficher le timer pour la fin de la Nuée de sauterelles"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobia",
	Pull1				= "Oui, courez ! Faites circulez le sang !",
	Pull2				= "Rien qu'une petite bouchée…"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grande veuve Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Fin du baisé de la veuve dans 5 sec",
	WarningEmbraceExpired	= "Baisé de la veuve terminé"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Activer l'avertissement de fin du baisé de la veuve",
	WarningEmbraceExpired	= "Afficher un avertissement quand le baisé de la veuve va se terminer"
})

L:SetMiscLocalization({
	Pull					= "À genoux, vermisseau !"--Not actually pull trigger, but often said on pull
})
---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Araignées dans 5 sec",
	WarningSpidersNow	= "Arrivée des araignées!"
})

L:SetTimerLocalization({
	TimerSpider			= "Araignées"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Activer le pré-avertissement pour les araignées",
	WarningSpidersNow	= "Activer l'avertissement pour les araignées",
	TimerSpider			= "Montre le timer pour l'arrivée des araignées"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobia"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth le Porte-peste"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "Téléportation!",
	WarningTeleportSoon		= "Téléportation dans in 20 sec"
})

L:SetTimerLocalization({
	TimerTeleport			= "Téléportation",
	TimerTeleportBack		= "Retour de TP"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Activer l'avertissement pour la téléporation",
	WarningTeleportSoon		= "Activer le pré-avertissement pour la téléporation",
	TimerTeleport			= "Activer le timer pour la téléporation",
	TimerTeleportBack		= "Activer le timer pour le retour de Noth"
})

L:SetMiscLocalization({
	Pull				= "Mourez, intrus !",
	AddsYell			= "Levez-vous, soldats ! Levez-vous et combattez une fois encore !",
	Adds				= "invoque des guerriers squelettes !",
	AddsTwo				= "lève encore d'autres squelettes !"
})
--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan l'Impur"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "Téléportation!",
	WarningTeleportSoon		= "Téléporation dans %d sec"
})

L:SetTimerLocalization({
	TimerTeleport			= "Téléporation"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Activer l'avertissement de Téléporation",
	WarningTeleportSoon		= "Activer le pré-avertissement de Téléporation",
	TimerTeleport			= "Activer le timer pour la Téléporation"
})

L:SetMiscLocalization({
	Pull				= "Vous êtes à moi, maintenant."
})
----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Horreb"
})

L:SetWarningLocalization({
	WarningHealSoon		= "Soins possibles dans 3 sec",
	WarningHealNow		= "SOIGNEZ MAINTENANT!"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Activer l'avertissement \"Soins dans 3 sec\" ",
	WarningHealNow		= "Activer l'avertissement \"SOIGNEZ MAINTENANT\" "
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Le Recousu"
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	yell1 		     	= "R'cousu veut jouer !",
	yell2 		     	= "R'cousu avatar de guerre pour Kel'Thuzad !"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Gluth"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetMiscLocalization({
	Yell					= "Stalagg écraser toi !",
	Emote					= "%s entre en surcharge !",
	Emote2					= "Bobine de Tesla entre en surcharge !",
	Boss1 					= "Feugen",
	Boss2 					= "Stalagg",
	Charge1 				= "négative",
	Charge2 				= "positive"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Activer l'avertissement spécial quand votre polarité a changé",
	WarningChargeNotChanged	= "Activer l'avertissement spécial quand votre polarité n'a pas changé",
	TimerShiftCast			= "Afficher le timer pour le cast du changement de polarité",
	ArrowsEnabled			= "Afficher les flèches (stratégie normale : \"2 camps\")",
	ArrowsRightLeft			= "Afficher les flèches droite/gauche pour la stratégie \"4 camps\" (flèche gauche si la polarité a changé et droite sinon)",
	ArrowsInverse			= "Inverser la statégie \"4 camps\" (afficher la flèche droite si la polarité a changé et la gauche sinon)"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Polarité changée : %s",
	WarningChargeNotChanged	= "Même polarité"
})

-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Instructeur Razuvious"
})

L:SetMiscLocalization({
	Yell1 					= "Pas de quartier !",
	Yell2 					= "Les cours sont terminés ! Montrez-moi ce que vous avez appris !",
	Yell3 					= "Faites ce que vous ai appris !",
	Yell4 					= "Frappe-le à la jambe… Ça te pose un problème ?"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Activer l'avertissement du Mur de Bouclier"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Mur de Bouclier expire dans 5 sec"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik le Moissonneur"
})

L:SetOptionLocalization({
	TimerWave			= "Afficher le timer des vagues",
	TimerPhase2			= "Afficher le timer pour la Phase 2",
	WarningWaveSoon		= "Activer le pré-avertissement pour les Vagues",
	WarningWaveSpawned	= "Avertir quand une vague est arrivée",
	WarningRiderDown	= "Avertir quand un Cavalier meurt",
	WarningKnightDown	= "Avertir quand un Chevalier meurt",
	WarningPhase2		= "Activer l'avertissement pour la Phase 2"
})

L:SetTimerLocalization({
	TimerWave			= "Vague #%d",
	TimerPhase2			= "Phase 2"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Vague %d: %s dans 3 sec",
	WarningWaveSpawned	= "Vague %d: %s arrivée",
	WarningRiderDown	= "Cavalier down",
	WarningKnightDown	= "Chevalier down",
	WarningPhase2		= "Phase 2"
})

L:SetMiscLocalization({
	yell				= "Dans votre folie, vous avez provoqué votre propre mort.",
	WarningWave1		= "%d %s",
	WarningWave2		= "%d %s et %d %s",
	WarningWave3		= "%d %s, %d %s et %d %s",
	Trainee				= "Recrues",
	Knight				= "Chevaliers",
	Rider				= "Cavaliers"
})

----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Les Quatre Cavaliers"
})

L:SetOptionLocalization({
	TimerMark					= "Afficher le timer des Marques",
	WarningMarkSoon				= "Activer le pré-avertissement des Marques",
	SpecialWarningMarkOnPlayer	= "Avertissement spécial quand vous avez plus de 4 marques sur vous"
})

L:SetTimerLocalization({
	TimerMark 					= "Marque %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Marque %d dans 3 sec",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetMiscLocalization({
	Korthazz					= "Thane Korth'azz",
	Rivendare					= "Baron Vaillefendre",
	Blaumeux					= "Dame Blaumeux",
	Zeliek						= "Sire Zeliek"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Activer le pré-avertissement de la phase en vol",
	WarningAirPhaseNow	= "Activer l'avertissement de la phase en vol",
	WarningLanded		    = "Activer l'avertissement pour la phase au sol",
	TimerAir			    	= "Afficher le timer de la phase en vol",
	TimerLanding		   	= "Afficher le timer de l'atterrissage",
	TimerIceBlast		   	= "Afficher le timer du Souffle de givre",
	WarningDeepBreath		= "Activer l'avertissement spécial pour le Souffle de givre",
	WarningIceblock			= "Crie dans un glaçon"
})

L:SetMiscLocalization({
	EmoteBreath			    = "prend une grande inspiration",
	WarningYellIceblock	= "Je suis un bloc de glace !"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Envol dans 10 sec",
	WarningAirPhaseNow	= "Dans les airs",
	WarningLanded		    = "Atterrissage de Sapphiron",
	WarningDeepBreath	  = "Souffle de givre !"
})

L:SetTimerLocalization({
	TimerAir		   		  = "Envol",
	TimerLanding			  = "Atterrissage dans",
	TimerIceBlast			  = "Souffle de givre"
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetOptionLocalization({
	TimerPhase2				= "Afficher le timer pour la Phase 2",
	specwarnP2Soon 			= "Montre un timer pour prévenir 10 secondes avant l'arrivée de Kel'Thuzad"
})

L:SetMiscLocalization({
	Yell 					= "Serviteurs, valets et soldats des ténèbres glaciales ! Répondez à l'appel de Kel'Thuzad !"
})

L:SetWarningLocalization({
	specwarnP2Soon  		= "Kel'Thuzad sera actif dans 10 secondes"
})

L:SetTimerLocalization({
	TimerPhase2				= "Phase 2",
})

