if GetLocale() ~= "ptBR" then return end
local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Opções gerais"
})

L:SetTimerLocalization({
	TimerInvite	= "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "Usar cor da classe para os nomes, no quadro de pontuação",
	TimerInvite			= "Exibir cronógrafo para juntar-se ao Campo de Batalha",
	AutoSpirit			= "Libertar espírito automaticamente",
	HideBossEmoteFrame	= "Esconder quadro de emoção de chefe."
})

L:SetMiscLocalization({
	BgStart60	= "A batalha começará em 1 minuto.",
	BgStart30	= "A batalha começará em 30 segundos. Preparem-se!",
	ArenaInvite	= "Convite para Arena"
})

--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name	= "Arenas"
})

L:SetTimerLocalization({
	TimerShadow	= "Shadow Sight"
})

L:SetOptionLocalization({
	TimerShadow	= "Exibir cronógrafo para Shadow Sight"
})

L:SetMiscLocalization({
	Start15	= "Fifteen seconds until the Arena battle begins!",
	highmaulArena	= "The battle for supremacy begins in 30 seconds!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("z30")

L:SetTimerLocalization({
	TimerTower	= "%s",
	TimerGY		= "%s"
})

L:SetOptionLocalization({
	TimerTower	= "Exibir cronógrafo para captura de torre",
	TimerGY		= "Exibir cronógrafo para captura de cemitério",
	AutoTurnIn	= "Automaticamente entregar missões"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("z529")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin				= "Exibir cronógrafo para vitória",
	TimerCap				= "Exibir cronógrafo para captura",
	ShowAbEstimatedPoints	= "Exibir estimativa de pontuação no final da partida",
	ShowAbBasesToWin		= "Exibir número de bases necessárias para vencer"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "%s vence",
	BasesToWin	= "Bases para vencer: %d"
})

---------------------
--  Deepwind Gorge --
---------------------
L = DBM:GetModLocalization("z1105")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerCap	= "Show capture timer",
	TimerWin	= "Show win timer"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "%s wins"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("z566")

L:SetTimerLocalization({
	TimerFlag	= "Bandeira reaparece"
})

L:SetOptionLocalization({
	TimerWin		= "Exibir cronógrafo para vitória.",
	TimerFlag		= "Exibir cronógrafo para a bandeira reaparecer",
	ShowPointFrame	= "Exibir portador da bandeira e estimativa de pontos"
})

L:SetMiscLocalization({
	ScoreExpr		= "(%d+)/1500",
	WinBarText		= "%s vence",
	Flag			= "Flag",
	FlagReset		= "The flag has been reset!",
	FlagTaken		= "(.+) has taken the flag!",
	FlagCaptured	= "The .+ ha%w+ captured the flag!",
	FlagDropped		= "A bandeira foi derrubada!"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("z489")

L:SetTimerLocalization({
	TimerStart	= "Início da partida",
	TimerFlag	= "Bandeira reaparece"
})

L:SetOptionLocalization({
	TimerStart					= "Exibir cronógrafo para início da partida",
	TimerFlag					= "Exibir cronógrafo para a bandeira reapareceer",
	ShowFlagCarrier				= "Exibir portador da bandeira",
	ShowFlagCarrierErrorNote	= "Exibir mensagem de erro de portador de bandeira, enquanto em combate"
})

L:SetMiscLocalization({
	InfoErrorText		= "A funcionalidade de mirar portador da bandeira será restaurada quando você sair de combate.",
	ExprFlagPickUp		= "(.+) pegou a Bandeira da ([%wç]+)!",
	ExprFlagCaptured	= "(.+) capturou a bandeira da ([%wç]+)!",
	ExprFlagReturn		= "A Bandeira da ([%wç]+) foi devolvida à base por (.+)!",
	FlagAlliance		= "Bandeira da Aliança: ",
	FlagHorde			= "Bandeira da Horda: ",
	FlagBase			= "Base",
	Vulnerable1			= "The flag carriers have become vulnerable to attack!",
	Vulnerable2			= "The flag carriers have become increasingly vulnerable to attack!"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("z628")

L:SetWarningLocalization({
	WarnSiegeEngine		= "Siege Engine pronto!",
	WarnSiegeEngineSoon	= "Siege Engine em ~10 seg"
})

L:SetTimerLocalization({
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Siege Engine pronto"
})

L:SetOptionLocalization({
	TimerStart			= "Exibir cronógrafo para início da partida",
	TimerPOI			= "Exibir cronógrafo para captura",
	TimerSiegeEngine	= "Exibir cronógrafo para construção de Siege Engine",
	WarnSiegeEngine		= "Exibir aviso quando Siege Engine estiver pronto",
	WarnSiegeEngineSoon	= "Exibir aviso quando Siege Engine estiver quase pronto"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Damaged gates",
	SiegeEngine				= "Siege Engine",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "I'll work on the siege engine, just watch my back. Use those seaforium bombs on the gates if you need them!",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here. They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})

------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("z726")

L:SetTimerLocalization({
	TimerStart	= "Partida inicia",
	TimerFlag	= "Bandeira reaparece"
})

L:SetOptionLocalization({
	TimerStart					= "Exibir cronógrafo para início da partida",
	TimerFlag					= "Exibir cronógrafo para a bandeira reapareceer",
	ShowFlagCarrier				= "Exibir portador da bandeira",
	ShowFlagCarrierErrorNote	= "Exibir mensagem de erro de portador de bandeira, enquanto em combate"
})

L:SetMiscLocalization({
	InfoErrorText		= "A funcionalidade de portador de bandeira será restaurada quando você sair de combate.",
	ExprFlagPickUp		= "The (%w+) .lag was picked up by (.+)!",
	ExprFlagCaptured	= "(.+) captured the (%w+) flag!",
	ExprFlagReturn		= "The (%w+) .lag was returned to its base by (.+)!",
	FlagAlliance		= "Alliance Flag: ",
	FlagHorde			= "Horde Flag: ",
	FlagBase			= "Base",
	Vulnerable1			= "The flag carriers have become vulnerable to attack!",
	Vulnerable2			= "The flag carriers have become increasingly vulnerable to attack!"
})

-------------------------
--  Battle of Gilneas  --
-------------------------
L = DBM:GetModLocalization("z761")

L:SetTimerLocalization({
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerWin					= "Exibir cronógrafo para vitória",
	TimerCap					= "Exibir cronógrafo para captura",
	ShowGilneasEstimatedPoints	= "Exibir estimativa de pontos ao final da partida",
	ShowGilneasBasesToWin		= "Exibir número de bases necessárias para vencer"
})

L:SetMiscLocalization({
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "%s vence",
	BasesToWin	= "Bases para vencer: %d"
})

-------------------------
--  Silvershard Mines  --
-------------------------
L = DBM:GetModLocalization("z727")

L:SetTimerLocalization({
	TimerCart	= "Cart respawn"
})

L:SetOptionLocalization({
	TimerCart	= "Show cart respawn timer"
})

L:SetMiscLocalization({
	Capture	= "has captured"
})

-------------------------
--  Temple of Kotmogu  --
-------------------------
L = DBM:GetModLocalization("z998")

L:SetOptionLocalization({
	TimerWin					= "Show win timer",
	ShowKotmoguEstimatedPoints	= "Show estimated points on win/loss",
	ShowKotmoguOrbsToWin		= "Show orbs required to win"
})

L:SetMiscLocalization({
	OrbTaken	= "(%S+) has taken the (%S+) orb!",
	OrbReturn	= "The (%S+) orb has been returned!",
	ScoreExpr	= "(%d+)/1500",
	WinBarText	= "Estimate %s wins",
	OrbsToWin	= "Orbs to win: %d"
})
