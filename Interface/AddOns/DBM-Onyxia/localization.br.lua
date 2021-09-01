if GetLocale() ~= "ptBR" then return end
local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	WarnWhelpsSoon		= "Dragonete Onyxiano em breve"
}

L:SetTimerLocalization{
	TimerWhelps	= "Dragonete Onyxiano"
}

L:SetOptionLocalization{
	TimerWhelps				= "Mostrar cronômetro para os seguintes Dragonetes Onyxiano",
	WarnWhelpsSoon			= "Mostrar aviso prévio para os seguintes Dragonetes Onyxiano",
	SoundWTF3				= "Reproduzir sons engraçados de um lendário raide clássico de Onyxia"
}

L:SetMiscLocalization{
	Breath = "%s respira fundo...",
	YellPull = "Que sorte. Geralmente costumo sair de minha caverna para poder me alimentar.",
	YellP2 = "Este esforço inútil me aborrece. Vou atear fogo em todos vocês do alto!",
	YellP3 = "Parece que vocês vão precisar de outra lição, mortais!"
}

