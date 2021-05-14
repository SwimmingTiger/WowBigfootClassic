if GetLocale() ~= "frFR" then return end
local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Options générale"
})

L:SetTimerLocalization({
	TimerInvite	= "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "Met le nom en couleur en fonction de la classe dans le tableau des scores",
	TimerInvite			= "Affiche le temps restant pour rejoindre le Champ de bataille",
	AutoSpirit			= "Auto-rez à un Ange",
	HideBossEmoteFrame	= "Masquez les cadres d'émotes de boss de raid"
})

L:SetMiscLocalization({
	BgStart60			= "Début de la bataille pour le goulet des Chanteguerres dans 1 minute.",
	BgStart30			= "Début de la bataille pour le goulet des Chanteguerres dans 30 secondes. Préparez-vous!",
	ArenaInvite			= "Invitation d'arène",
	ExprFlagPickUp		= "Le Drapeau (%w+) a été pris par (.+)!",
	ExprFlagCaptured	= "(.+) a capturé le drapeau (%w+)!",
	ExprFlagReturn		= "Le Drapeau (%w+) a été renvoyé à la base par (.+)!",
	Vulnerable1			= "Le porteur du drapeau est vulnérable aux attaques!",
	Vulnerable2			= "Le porteur du drapeau devient encore plus vulnérable aux attaques!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("z30")

L:SetOptionLocalization({
	AutoTurnIn	= "Fini automatiquement les quêtes dans la Vallée d'Alterac"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Engins de Siège prêt!",
	WarnSiegeEngineSoon	= "Apparition des Engins de Siège dans ~10 sec"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Engins de Siège prêt"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Montre le timer de la construction des Engins de Siège",
	WarnSiegeEngine		= "Alerter lorsque l'Engin de Siège est prêt",
	WarnSiegeEngineSoon	= "Alerter lorsque l'Engin de Siège est presque prêt",
	ShowGatesHealth		= "Afficher la vie des portes endommagées (les valeurs peuvent être fausses après avoir rejoint un champ de bataille déjà en cours!))"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Portes endommagées",
	SiegeEngine				= "Engin de Siège",
	GoblinStartAlliance		= "Regarder ces Bombes d'hydroglycérine ? Utilisez-les sur les portes alors que je répare l'engin de siège!",
	GoblinStartHorde		= "Je travaillerai sur l'engin de siège, regarde juste mon dos. Utilse ces Bombes d'hydroglycérine sur les portes si tu en as besoin!",
	GoblinHalfwayAlliance	= "Je suis à mi-chemin! Gardez la Horde loin d'ici. Ils n'apprennent pas la lutte à l'ecole d'ingénieur!",
	GoblinHalfwayHorde		= "J'ai déjà fait mi-chemin ! Gardez l'Alliance loin - Combattre n'est pas dans mon contrat!",
	GoblinFinishedAlliance	= "Mon plus beau travail accompli jusqu'à présent! Cet engin de siège est prêt pour l'action!",
	GoblinFinishedHorde		= "L'engin de siège est prêt à rouler!",
	GoblinBrokenAlliance	= "C'est déjà cassé?! Pas de soucis. Ce n'est rien que je ne puisse arranger.",
	GoblinBrokenHorde		= "C'est encore cassé?! j'arrangerais ça... ne vous attendez pas a ce que la garantie couvre cela"
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerRespawn	= "Chariot respawn"
})

L:SetOptionLocalization({
	TimerRespawn	= "Afficher le temps de respawn des chariots",
	TimerCart		= "Show cart cap timer"
})

L:SetMiscLocalization({
	Capture	= "pris le contrôle",
	Arrived	= "has arived",
	Begun	= "has begun"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetMiscLocalization({
	OrbTaken	= "(%S+) has taken the (%S+) orb!",
	OrbReturn	= "The (%S+) orb has been returned!"
})
