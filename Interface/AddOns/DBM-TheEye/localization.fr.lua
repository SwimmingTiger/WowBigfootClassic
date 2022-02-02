if GetLocale() ~= "frFR" then return end
local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "Al'ar"
}

L:SetTimerLocalization{
	NextPlatform	= "Duration max de plateforme"
}

L:SetOptionLocalization{
	NextPlatform	= "Affiche le temps qu'Al'ar peut rester sur sa plateforme (Peut partir plus tôt mais ne partira casiment jamais plus tard)"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "Saccageur du Vide"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "Grande astromancienne Solarian"
}

L:SetWarningLocalization{
	WarnSplit		= "Rupture",
	WarnSplitSoon	= "Rupture dans 5 secondes",
	WarnAgent		= "Apparition des agents",
	WarnPriest		= "Apparition des prêtres et de Solarian"

}

L:SetTimerLocalization{
	TimerSplit		= "Prochaine rupture",
	TimerAgent		= "Arrivés des agents",
	TimerPriest		= "Arrivés des prêtres et de Solarian"
}

L:SetOptionLocalization{
	WarnSplit		= "Affiche une alerte pour la rupture",
	WarnSplitSoon	= "Affiche une pré-alerte pour la rupture",
	WarnAgent		= "Affiche une alerte pour l'apparition des agents",
	WarnPriest		= "Affiche une alerte pour l'apparition des prêtres et Solarian",
	TimerSplit		= "Affiche le temps restant avant la prochaine rupture",
	TimerAgent		= "Affiche le temps restant avant l'apparition des agents",
	TimerPriest		= "Affiche le temps restant avant l'apparation des prêtres et de Solarian"
}

L:SetMiscLocalization{
	YellSplit1		= "Je vais balayer vos illusions de grandeur.",
	YellSplit2		= "Vous êtes désespérément surclassés !",
	YellPhase2		= "Je ne fais plus qu'un... avec le VIDE!"
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "Kael'thas Haut-soleil"
}

L:SetWarningLocalization{
	WarnGaze		= "Regard sur >%s<",
	WarnMobDead		= "%s mort",
	WarnEgg			= "Apparition d'un oeuf de phénix",
	SpecWarnGaze	= "Regard sur vous - COURREZ !",
	SpecWarnEgg		= "Apparition de l'oeuf de phénix - Changez de cible !"
}

L:SetTimerLocalization{
	TimerPhase		= "Prochaine phase",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "Nouvelle cible du regard",
	TimerRebirth	= "Renaissance du phénix"
}

L:SetOptionLocalization{
	WarnGaze		= "Affiche les alertes du regard de Thaladred",
	WarnMobDead		= "Affiche une alerte pour la mort des armes en phase 2",
	WarnEgg			= "Affiche une alerte pour l'apparition d'un oeuf de phénix",
	SpecWarnGaze	= "Affiche une alerte spéciale lorsque le regard est sur vous",
	SpecWarnEgg		= "Affiche une alerte spéciale pour l'apparition d'un oeuf de phénix",
	TimerPhase		= "Affiche le temps restant avant la prochaine phase",
	TimerPhase1mob	= "Affiche le temps restant pour que les ennemis de la phase 1 soient actifs",
	TimerNextGaze	= "Affiche le temps restant avant un changement de cible du regard de Thaladred",
	TimerRebirth	= "Affiche le temps restant avant que le phénix renait de l'oeuf",
	GazeIcon		= "Mettre une icône sur la cible du regard de Thaladred"
}

L:SetMiscLocalization{
	YellPhase2	= "Comme vous le voyez, j'ai plus d'une corde à mon arc...",
	YellPhase3	= "Peut-être vous ai-je sous-estimés. Il ne serait pas très loyal de vous faire combattre mes quatre conseillers en même temps, mais... mon peuple n'a jamais été traité avec loyauté. Je ne fais que rendre la politesse.",
	YellPhase4	= "Il est hélas parfois nécessaire de prendre les choses en main soi-même. Balamore shanal !",
	YellPhase5	= "Je ne suis pas arrivé si loin pour échouer maintenant ! Je ne laisserai pas l'avenir que je prépare être remis en cause ! Vous allez goûter à ma vraie puissance !",
	YellSang	= "Vous avez tenu tête à certains de mes plus talentueux conseillers... Mais personne ne peut résister à la puissance du Marteau de sang. Je vous présente le seigneur Sanguinar !",
	YellCaper	= "Capernian fera en sorte que votre séjour ici ne se prolonge pas.",
	YellTelo	= "Bien, vous êtes dignes de mesurer votre talent à celui de mon maître ingénieur, Telonicus.",
	EmoteGaze	= "pose ses yeux sur ([^%s]+)!",
	Thaladred	= "Thaladred l'Assombrisseur",
	Sanguinar	= "Seigneur Sanguinar",
	Capernian	= "Grande astromancienne Capernian",
	Telonicus	= "Maître ingénieur Telonicus",
	Bow			= "Arc long brins-de-Néant",
	Axe			= "Dévastation",
	Mace		= "Masse d'infusion cosmique",
	Dagger		= "Lames d'infinité",
	Sword		= "Tranchoir dimensionnel",
	Shield		= "Rempart de déphasage",
	Staff		= "Bâton de désintégration",
	Egg			= "Oeuf de phénix"
}
