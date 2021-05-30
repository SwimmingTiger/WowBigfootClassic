if GetLocale() ~= "ruRU" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Аттумен Охотник"
}

L:SetMiscLocalization{
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Мороуз"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Исчезновение рассеивается"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Show vanish fade warning"
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Благочестивая дева"
}


-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization{
	name = "Ромуло и Джулианна"
}

L:SetMiscLocalization{
	DBM_RJ_PHASE2_YELL	= "Ночь, добрая и строгая, приди! Верни мне моего Ромуло!",
	Romulo				= "Ромуло",
	Julianne			= "Джулианна"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "Злой и страшный серый волк"
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "Так вам и надо!"
}


-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "Смотритель"
}


-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Терестиан Больное Копыто"
}

L:SetMiscLocalization{
	Kilrek					= "Kil'rek",
	DChains					= "Demon Chains"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Тень Арана"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Не двигайтесь!"
}

L:SetOptionLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Show special warning for $spell:30004"
}


--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization{
	name = "Пустогнев"
}

L:SetWarningLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Фаза порталов через 5 секунд",
	DBM_NS_WARN_BANISH_SOON	= "Фаза изгнания через 5 секунд",
	warningPortal			= "Фаза порталов",
	warningBanish			= "Фаза изгнания"
}

L:SetTimerLocalization{
	timerPortalPhase	= "Фаза порталов",
	timerBanishPhase	= "Фаза изгнания"
}

L:SetOptionLocalization{
	DBM_NS_WARN_PORTAL_SOON	= "Show pre-warning for Portal phase",
	DBM_NS_WARN_BANISH_SOON	= "Show pre-warning for Banish phase",
	warningPortal			= "Show warning for Portal phase",
	warningBanish			= "Show warning for Banish phase",
	timerPortalPhase		= "Show timer for Portal Phase duration",
	timerBanishPhase		= "Show timer for Banish Phase duration"
}

L:SetMiscLocalization{
	DBM_NS_EMOTE_PHASE_2	= "%s goes into a nether-fed rage!",
	DBM_NS_EMOTE_PHASE_1	= "%s cries out in withdrawal, opening gates to the nether."
}


--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "Принц Малчезар"
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_P2		= "Простофили! Время – это пламя, в котором вы сгорите!",
	DBM_PRINCE_YELL_P3		= "Как ты можешь надеяться выстоять против такой ошеломляющей мощи?",
	DBM_PRINCE_YELL_INF1	= "Все миры, все измерения открыты мне!",
	DBM_PRINCE_YELL_INF2	= "Вас ждет не один Малчезаар, но и легионы, которыми я командую!"
}


-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization{
	name = "Ночная Погибель"
}

L:SetWarningLocalization{
	DBM_NB_DOWN_WARN 		= "Наземная фаза через 15 секунд",
	DBM_NB_DOWN_WARN2 		= "Наземная фаза через 5 секунд",
	DBM_NB_AIR_WARN			= "Воздушная фаза"
}

L:SetTimerLocalization{
	timerNightbane			= "Nightbane incoming",
	timerAirPhase			= "Воздушная фаза"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Show warning for Air Phase",
	PrewarnGroundPhase		= "Show pre-warnings for Ground Phase",
	timerNightbane			= "Show timer for Nightbane summon",
	timerAirPhase			= "Show timer for Air Phase duration"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "Древнее существо пробуждается вдалеке…",
	DBM_NB_YELL_AIR			= "Жалкий гнус! Я изгоню тебя из воздуха!",
	DBM_NB_YELL_GROUND		= "Довольно! Я сойду на землю и сам раздавлю тебя!",
	DBM_NB_YELL_GROUND2		= "Ничтожества! Я вам покажу мою силу поближе!"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Страна Оз"
}

L:SetOptionLocalization{
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns"
}

L:SetMiscLocalization{
	DBM_OZ_WARN_TITO		= "*** Тито ***",
	DBM_OZ_WARN_ROAR		= "*** Хохотун ***",
	DBM_OZ_WARN_STRAWMAN	= "*** Балбес ***",
	DBM_OZ_WARN_TINHEAD		= "*** Медноголовый ***",
	DBM_OZ_WARN_CRONE		= "*** Ведьма ***",
	DBM_OZ_YELL_DOROTHEE	= "О, Тито, нам просто надо найти дорогу домой!",
	DBM_OZ_YELL_ROAR		= "I'm not afraid a' you! Do you wanna' fight? Huh, do ya'? C'mon! I'll fight ya' with both paws behind my back!",
	DBM_OZ_YELL_STRAWMAN	= "Now what should I do with you? I simply can't make up my mind.",
	DBM_OZ_YELL_TINHEAD		= "I could really use a heart. Say, can I have yours?",
	DBM_OZ_YELL_CRONE		= "Woe to each and every one of you, my pretties!"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Shadikith the Glider"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Hyakiss the Lurker"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Rokad the Ravager"
}
