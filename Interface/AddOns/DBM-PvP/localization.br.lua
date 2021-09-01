if GetLocale() ~= "ptBR" then return end
local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Opções gerais"
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
