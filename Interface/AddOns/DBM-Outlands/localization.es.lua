if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "Su majestad Maulgar"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Gruul el Asesino de Dragones"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth	= "Mostrar aviso para $spell:36300"
}


-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Magtheridon"
}

L:SetTimerLocalization{
	timerP2	= "Fase 2"
}

L:SetOptionLocalization{
	timerP2	= "Mostrar temporizador para el cambio a Fase 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "¡Las cuerdas de %s empiezan a aflojarse!",
	DBM_MAG_YELL_PHASE2		= "¡He... sido... liberado!",
	DBM_MAG_YELL_PHASE3		= "¡No me dejaré encerrar tan fácilmente! ¡Que tiemblen las paredes de esta prisión... y se derrumben!"
}

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "Señor de fatalidad Kazzak"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "¡%s se enfurece!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "Caminante del Destino"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "¡%s se enfurece!"--Probalby won't be used, at least not long. Once spellid replaces it
}
