if GetLocale() ~= "ptBR" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "Korinnaxx"
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "General Rajaxx"
}
L:SetWarningLocalization{
	WarnWave	= "Onda %s"
}
L:SetOptionLocalization{
	WarnWave	= "Anunciar a próxima onda de entrada"
}
L:SetMiscLocalization{
	Wave12		= "Eles estão vindo. Tenta não morrer, sangue-bom.",
	Wave12Alt	= "Você se lembra, Rajaxx, quando eu disse que ia te matar por último?",
	Wave3		= "A hora da vingança se aproxima! Deixem as trevas reinar nos corações dos nossos inimigos!",
	Wave4		= "Basta de portas trancadas e muros de pedra nos escondendo. Nossa vingança não será mais negada! Os próprios dragões tremerão diante da nossa ira!",
	Wave5		= "Levem o medo ao inimigo! Medo e morte!",
	Wave6		= "Guenelmo vai chorar e suplicar pela própria vida! Exatamente como o moleque do filho dele! Mil anos de injustiça... terminam hoje!",
	Wave7		= "Fandral, sua hora chegou! Vá se esconder no Sonho Esmeralda, e reze para que nós nunca o encontremos!",
	Wave8		= "Tolo insolente! Eu mesmo vou matá-lo!"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "Moam"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "Buru, o Banqueteador"
}
L:SetWarningLocalization{
	WarnPursue		= "Perseguir em >%s<",
	SpecWarnPursue	= "Perseguindo você",
	WarnDismember	= "%s em >%s< (%s)"
}
L:SetOptionLocalization{
	WarnPursue		= "Anunciar alvos perseguidos",
	SpecWarnPursue	= "Exibir aviso especial quando estiver sendo perseguido",
	WarnDismember	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(96)
}
L:SetMiscLocalization{
	PursueEmote 	= "%s vê o"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "Ayamiss, o Caçador"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "Ossirian, o Intocado"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "Anunciar fraqueza",
	TimerVulnerable	= "Exibir cronômetro para fraqueza"
}

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization{
	name = "AQ20: Lixo"
}
