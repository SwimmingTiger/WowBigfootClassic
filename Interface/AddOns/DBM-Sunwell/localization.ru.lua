if GetLocale() ~= "ruRU" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization{
	name = "Калесгос"
}

L:SetWarningLocalization{
	WarnPortal			= "Портал #%d : >%s< (Group %d)",
	SpecWarnWildMagic	= "Wild Magic - %s!"--Translate
}

L:SetTimerLocalization{
	TimerNextPortal		= "Портал (%d)"
}

L:SetOptionLocalization{
	WarnPortal			= "Show warning for $spell:46021 target",--Translate
	SpecWarnWildMagic	= "Show special warning for Wild Magic",--Translate
	TimerNextPortal		= "Show timer for portals",--Translate
	RangeFrame			= "Show range frame (10 yards)",--Translate
	ShowFrame			= "Show Spectral Realm frame" ,--Translate
	FrameClassColor		= "Use class colors in Spectral Realm frame",--Translate
	FrameUpwards		= "Expand Spectral Realm frame upwards",--Translate
	FrameLocked			= "Set Spectral Realm frame not movable"--Translate
}

L:SetMiscLocalization{
	Demon				= "Сатроварр Осквернитель",
	Heal				= "+100% хила",
	Haste				= "+100% время каста",
	Hit					= "-50% hit chance",
	Crit				= "+100% крит дамага",
	Aggro				= "+100% threat",
	Mana				= "-50% spell costs",
	FrameTitle			= "Spectral Realm",--Translate
	FrameLock			= "Закрепить рамку",
	FrameClassColor		= "Use class colors",--Translate
	FrameOrientation	= "Expand upwards",--Translate
	FrameHide			= "Скрыть рамку",
	FrameClose			= "Close"--Translate
}

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization{
	name = "Бруталл"
}

L:SetMiscLocalization{
	Pull			= "О, а вот и новые агнцы идут на заклание!"
}

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization{
	name = "Пророк Скверны"
}

L:SetWarningLocalization{
	WarnPhase		= "%s Phase",--Translate
	WarnPhaseSoon	= "%s Phase in 10 sec",--Translate
	WarnBreath		= "Глубокий Вздох (%d)"
}

L:SetTimerLocalization{
	TimerPhase		= "Next %s Phase",
	TimerBreath		= "Глубокий Вздох"
}

L:SetOptionLocalization{
	WarnPhase		= "Show warning for next phase",--Translate
	WarnPhaseSoon	= "Show pre-warning for next phase",--Translate
	WarnBreath		= "Show warning for Deep Breath",--Translate
	TimerPhase		= "Show time for next phase",--Translate
	TimerBreath		= "Show timer for Deep Breath cooldown",--Translate
	VaporIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45392),
	EncapsIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45665),
	YellOnEncaps	= "Yell on $spell:45665"
}

L:SetMiscLocalization{
	Air				= "Air",--Translate
	Ground			= "Ground",--Translate
	YellEncaps		= "Encapsulate on me! Run away!",--Change to generic so we don't have to translate?
	AirPhase		= "I am stronger than ever before!",--Translate
	Breath			= "%s глубоко вздыхает."
}

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Близнецы"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	NovaIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45329),
	ConflagIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45333),
	RangeFrame		= "Show range frame (10 yards)",--Translate
	NovaWhisper		= "Send whisper to $spell:45329 target (requires Raid Leader)",--Translate
	ConflagWhisper	= "Send whisper to $spell:45333 target (requires Raid Leader)",--Translate
}

L:SetMiscLocalization{
	NovaWhisper		= "Shadow Nova on you!",--Translate
	ConflagWhisper	= "Conflagration on you!",--Translate
	Nova			= "Sacrolash directs Shadow Nova at (.+)%.",--Verify
	Conflag			= "Алайтесс воздействует на"--Verify
}

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization{
	name = "М'ару"
}

L:SetWarningLocalization{
	WarnHuman		= "Humanoids (%d)",--Translate
	WarnHumanSoon	= "Humanoids in 5 sec (%d)",--Translate
	WarnVoid		= "Void Sentinel (%d)",--Translate
	WarnVoidSoon	= "Void Sentinel in 5 sec (%d)",--Translate
	WarnFiend		= "Dark Fiend spawned"--Translate
}

L:SetTimerLocalization{
	TimerHuman		= "Humanoids (%s)",--Translate
	TimerVoid		= "Leerenwandler (%s)",
	TimerPhase		= "Энтропий"
}

L:SetOptionLocalization{
	WarnHuman		= "Show warning for Humanoids",--Translate
	WarnHumanSoon	= "Show pre-warning for Humanoids",--Translate
	WarnVoid		= "Show warning for Void Sentinels",--Translate
	WarnVoidSoon	= "Show pre-warning for Void Sentinels",--Translate
	WarnFiend		= "Show warning for Fiends in phase 2",--Translate
	TimerHuman		= "Show timer for Humanoids",--Translate
	TimerVoid		= "Show timer for Void Sentinels",--Translate
	TimerPhase		= "Show time for Phase 2 transition"--Translate
}

L:SetMiscLocalization{
	Entropius		= "Энтропий"
}

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization{
	name = "Кил'джеден"
}

L:SetWarningLocalization{
	WarnDarkOrb		= "Dark Orbs Spawned",--Translate
	WarnBlueOrb		= "Dragon Orb activated",--Translate
	SpecWarnDarkOrb	= "Dark Orbs Spawned!",--Translate
	SpecWarnBlueOrb	= "Dragon Orbs Activated!"--Translate
}

L:SetTimerLocalization{
	TimerBlueOrb	= "Dragon Orbs activate"--Translate
}

L:SetOptionLocalization{
	WarnDarkOrb		= "Show warning for Dark Orbs",--Translate
	WarnBlueOrb		= "Show warning for Dragon Orbs",--Translate
	SpecWarnDarkOrb	= "Show special warning for Dark Orbs",--Translate
	SpecWarnBlueOrb	= "Show special warning for Dragon Orbs",--Translate
	TimerBlueOrb	= "Show timer form Dragon Orbs activate",--Translate
	RangeFrame		= "Show range frame (10 yards)",--Translate
	BloomIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45641),
	YellOnBloom		= "Yell on $spell:45641",--Translate
	BloomWhisper	= "Send whisper to $spell:45641 target (requires Raid Leader)"--Translate
}

L:SetMiscLocalization{
	YellPull		= "Жалкие твари уничтожены. Да будет так! Я сделаю то, что не удалось Саргерасу. Я выпущу кровь из этого мерзкого мира и стану истинным повелителем Пылающего Легиона! Конец близок! Да свершится падение этого мира!",
	YellBloom		= "Fire Bloom on me!",--Translate
	BloomWhisper	= "Fire Bloom on you!",--Translate
	OrbYell1		= "I will channel my powers into the orbs! Be ready!",--Translate
	OrbYell2		= "I have empowered another orb! Use it quickly!",--Translate
	OrbYell3		= "Another orb is ready! Make haste!",--Translate
	OrbYell4		= "I have channeled all I can! The power is in your hands!"--Translate

}
