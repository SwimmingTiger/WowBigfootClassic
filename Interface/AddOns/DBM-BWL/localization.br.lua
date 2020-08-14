if GetLocale() ~= "ptBR" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Violâminus, o Indomado"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Primeiros lacaios"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Exibir cronômetro para quando os primeiros lacaios aparecerem"
}
L:SetMiscLocalization{
	Phase2Emote	= "fogem à medida que o poder do orbe é drenado.",
	YellEgg1	= "Vocês pagarão caro por me forçarem a fazer isso!",
	YellEgg2	= "Tolos! Esses ovos são mais preciosos do que vocês imaginam!",
	YellEgg3	= "Não! Mais um, não! Cortarei suas cabeças por esta atrocidade!",
	YellPull	= "Invasores violaram a incubadora! Soem o alarme! Protejam os ovos a todo custo!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name				= "Vaelastrasz, o Corrupto"
}

L:SetMiscLocalization{
	Event				= "É tarde demais, meus amigos! A corrupção de Nefarius se espalhou... não consigo... me controlar."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "Prolemestre Flagelador"
}

L:SetMiscLocalization{
	Pull	= "Nenhum de vocês deveria estar aqui! Vocês condenaram somente a si mesmos!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Fogorja"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Petrébano"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flamagor"
}

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization{
	name = "Guarda Garra da Morte"
}
L:SetWarningLocalization{
	WarnVulnerable		= "Vulnerabilidade: %s"
}
L:SetOptionLocalization{
	WarnVulnerable		= "Exibir aviso de vulnerabilidades de feitiços"
}
L:SetMiscLocalization{
	Fire		= "Fogo",
	Nature		= "Natureza",
	Frost		= "Gelo",
	Shadow		= "Sombra",
	Arcane		= "Arcano",
	Holy		= "Sagrado"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Cromaggus"
}
L:SetWarningLocalization{
	WarnBreath		= "%s",
	WarnVulnerable	= "Vulnerabilidade: %s"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s recarga",
	TimerBreath		= "%s lançamento",
	TimerVulnCD		= "Recarga de Vulnerabilidade"
}
L:SetOptionLocalization{
	WarnBreath		= "Exibir aviso quando Cromaggus lançar uma das suas respirações",
	WarnVulnerable	= "Exibir cronômetro para recarga da respiração",
	TimerBreathCD	= "Exibir recarga da respiração",
	TimerBreath		= "Exibir lançamento da respiração",
	TimerVulnCD		= "Exibir recarga de Vulnerabilidade"
}
L:SetMiscLocalization{
	Breath1	= "Primeira respiração",
	Breath2	= "Segunda respiração",
	VulnEmote	= "%s tem espasmos à medida que sua pele começa a brilhar.",
	Vuln		= "Vulnerabilidade",
	Fire		= "Fogo",
	Nature		= "Natureza",
	Frost		= "Gelo",
	Shadow		= "Sombra",
	Arcane		= "Arcano",
	Holy		= "Sagrado"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnAddsLeft		= "%d restante",
	WarnClassCall		= "Chamada de %s",
	specwarnClassCall	= "Sua chamada de classe!"
--	WarnClassCall		= "Chamada: %s",
--	WarnPhase			= "Fase %s"
}
L:SetTimerLocalization{
	TimerClassCall		= "Chamada de %s finalizada"
}
L:SetOptionLocalization{
	TimerClassCall		= "Exibir cronômetro para duração da chamada em cada classe",
	WarnAddsLeft		= "Anunciar as mortes restantes até a Fase 2",
	WarnClassCall		= "Exibir aviso para chamadas de classe",
	specwarnClassCall	= "Exibir aviso especial quando afetado por chamada em classe"
--	WarnPhase			= "Anunciar mudanças de fase"
}
L:SetMiscLocalization{
	YellP1		= "Que comecem os jogos!",
	YellP2		= "Muito bem, meus lacaios. A coragem dos mortais começa a vacilar! Agora vejamos como eles enfrentarão o verdadeiro Senhor dos Rocha Negra!!!",
	YellP3		= "Impossível! Ergam-se, meus lacaios! Sirvam ao seu mestre mais uma vez!",
	YellShaman	= "Xamãs, mostrem-me do que seus totens são capazes!",
	YellPaladin	= "Paladinos... ouvi dizer que vocês têm muitas vidas. Isso eu quero ver.",
	YellDruid	= "Druidas e suas metamorfoses idiotas. Vamos vê-las em ação!",
	YellPriest	= "Sacerdotes! Se vocês continuarem a curar desse jeito, acho que podemos tornar as coisas um pouquinho mais interessantes!",
	YellWarrior	= "Guerreiros, sei que vocês conseguem bater mais forte que isso! Vamos!",
	YellRogue	= "Ladinos? Parem de se esconder e venham me enfrentar!",
	YellWarlock	= "Bruxos, vocês não deveriam brincar com magias que não compreendem. Viram só o que acontece?",
	YellHunter	= "Caçadores e seus irritantes atiradores de ervilhas!",
	YellMage	= "Magos também? Vocês deveriam ter mais cuidado ao brincar com magia..."
}
