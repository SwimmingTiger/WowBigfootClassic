if GetLocale() ~= "ptBR" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "Profeta Skeram"
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "A Família de Insetos"
}
L:SetMiscLocalization{
	Yauj = "Princesa Yauj",
	Vem = "Veim",
	Kri = "Lorde Kri"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "Guarda de Batalha Sartura"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "Fankriss, o Obstinado"
}

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "Viscidus"
}
L:SetWarningLocalization{
	WarnFreeze	= "Congelamento: %d/3",
	WarnShatter	= "Shatter: %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "Anunciar status de congelamento",
	WarnShatter	= "Announce Shatter status" -- check when I have phase5 emote
}
L:SetMiscLocalization{
	Slow	= "begins to slow",
	Freezing= "is freezing up",
	Frozen	= "is frozen solid",
	Phase4 	= "begins to crack",
	Phase5 	= "looks ready to shatter",
	Phase6 	= "Explodes."
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "Princesa Huhuran"
}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "Imperadores Gêmeos"
}
L:SetMiscLocalization{
	Veklor = "Imperador Vek'lor",
	Veknil = "Imperador Vek'nilash"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "C'Thun"
}
L:SetWarningLocalization{
	WarnEyeTentacle			= "Tentóculo",
	WarnClawTentacle2		= "Tentáculo de Garra",
	WarnGiantEyeTentacle	= "Tentóculo Gigante",
	WarnGiantClawTentacle	= "Tentáculo de Garra Gigante",
	SpecWarnWeakened		= "C'Thun enfraquecido!"
}
L:SetTimerLocalization{
	TimerEyeTentacle		= "Próximo Tentóculo",
	TimerClawTentacle		= "Próximo Tentáculo de Garra",
	TimerGiantEyeTentacle	= "Próximo Tentóculo Gigante",
	TimerGiantClawTentacle	= "Próximo Tentáculo de Garra Gigante",
	TimerWeakened			= "Enfraquecido acaba"
}
L:SetOptionLocalization{
	WarnEyeTentacle			= "Exibir aviso para Tentóculo",
	WarnClawTentacle2		= "Exibir aviso para Tentáculo de Garra",
	WarnGiantEyeTentacle	= "Exibir aviso para Tentóculo Gigante",
	WarnGiantClawTentacle	= "Exibir aviso para Tentáculo de Garra Gigante",
	SpecWarnWeakened		= "Exibir aviso especial quando o chefe enfraquece",
	TimerEyeTentacle		= "Exibir cronômetro para o próximo Tentóculo",
	TimerClawTentacle		= "Exibir cronômetro para o próximo Tentáculo de Garra",
	TimerGiantEyeTentacle	= "Exibir cronômetro para o próximo Tentóculo Gigante",
	TimerGiantClawTentacle	= "Exibir cronômetro para o próximo Tentáculo de Garra Gigante",
	TimerWeakened			= "Exibir cronômetro para duração mais fraca do chefe",
	RangeFrame				= "Exibir quadro de alcance (10 m)"
}
L:SetMiscLocalization{
	Stomach		= "Estômago",
	Eye			= "Olho de C'Thun",
	FleshTent	= "Tentáculo de Carne",
	Weakened 	= "enfraquecido",
	NotValid	= "AQ40 parcialmente limpo. %s chefes opcionais permanecem."
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "Ouro"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Submersão",
	WarnEmerge			= "Emersão"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Submersão",
	TimerEmerge			= "Emersão"
}
L:SetOptionLocalization{
	WarnSubmerge		= "Exibir aviso para submersão",
	TimerSubmerge		= "Exibir cronômetro para submersão",
	WarnEmerge			= "Exibir aviso para emersão",
	TimerEmerge			= "Exibir cronômetro para emersão"
}

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization{
	name = "AQ40: Lixo"
}
