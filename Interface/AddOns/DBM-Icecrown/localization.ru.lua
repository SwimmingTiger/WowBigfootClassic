if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Лорд Ребрад"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Леди Смертный Шепот"
}

L:SetTimerLocalization{
	TimerAdds	= "Призыв помощников"
}

L:SetWarningLocalization{
	WarnReanimating				= "Помощник воскрешается",			-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "Скоро призыв помощников"
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Предупреждать заранее о призыве помощников",
	WarnReanimating				= "Предупреждение при воскрешении помощников",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Отсчет времени до призыва помощников"
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "Восстань и обрети истинную форму!",
	Fanatic1				= "Фанатик культа",
	Fanatic2				= "Кособокий фанатик",
	Fanatic3				= "Воскрешенный фанатик"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Боевой корабль"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "Скоро новые помощники"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Предупреждать заранее о призыве помощников",
	TimerAdds			= "Отсчет времени до новых помощников"
}

L:SetTimerLocalization{
	TimerAdds			= "Призыв помощников"
}

L:SetMiscLocalization{
	PullAlliance	= "Запускайте двигатели! Летим навстречу судьбе.",
	KillAlliance	= "Ну не говорите потом, что я не предупреждал. В атаку, братья и сестры!",
	PullHorde		= "Воспряньте, сыны и дочери Орды! Сегодня мы будем биться со смертельным врагом! ЛОК'ТАР ОГАР!",
	KillHorde		= "Альянс повержен. Вперед, к Королю-личу!",
	AddsAlliance	= "Разрушители, сержанты, в бой!",
	AddsHorde		= "Marines, Sergeants, attack",
	MageAlliance	= "We're taking hull damage, get a battle-mage out here to shut down those cannons!",
	MageHorde		= "We're taking hull damage, get a sorcerer out here to shut down those cannons!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Саурфанг Смертоносный"
}

L:SetOptionLocalization{
	RangeFrame				= "Показывать окно проверки дистанции (12 м)",
	RunePowerFrame			= "Показывать здоровье босса + индикатор для $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Сила крови",
	PullAlliance		= "Все павшие воины Орды, все дохлые псы Альянса – все пополнят армию Короля-лича. Даже сейчас валь'киры воскрешают ваших покойников, чтобы те стали частью Плети!",
	PullHorde			= "Кор'крон, выдвигайтесь! Герои, будьте начеку. Плеть только что..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Тухлопуз"
}

L:SetOptionLocalization{
	RangeFrame			= "Показывать окно проверки дистанции (8 м)",
	AnnounceSporeIcons	= "Объявлять метки целей заклинания $spell:69279 в рейд-чат<br/>(требуются права помощника)",
	AchievementCheck	= "Объявлять о провале достижения 'Масок нет!' в рейд-чат<br/>(требуются права помощника)"
}

L:SetMiscLocalization{
	SporeSet	= "Метка Газообразных спор {rt%d} установлена на: %s",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил %d стаков Невосприимчивости к гнили <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Гниломорд"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Малый слизнюк",
	SpecWarnLittleOoze			= "Малый слизнюк атакует вас - бегите"--creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Предупреждение при появлении Малого слизнюка",
	SpecWarnLittleOoze			= "Спец-предупреждение, когда вас атакует Малый слизнюк",--creatureid 36897
	RangeFrame					= "Показывать окно проверки дистанции (8 м)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Отличные новости, народ! Я починил трубы для подачи ядовитой слизи!",	-- Professor Putricide
	YellSlimePipes2	= "Отличные новости, народ! Слизь снова потекла!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Профессор Мерзоцид"
}

L:SetOptionLocalization{
	MalleableGooIcon			= "Устанавливать метку на первую цель заклинания $spell:72295"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Кровавый Совет"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Смените цель на: %s",
	WarnTargetSwitchSoon	= "Скоро смена цели"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Смена цели"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Предупреждение о смене цели",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Предупреждать заранее о смене цели",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Отсчет времени до смены цели",
	ActivePrinceIcon		= "Устанавливать метку на наполненного силой Принца (череп)",
	RangeFrame				= "Показывать окно проверки дистанции (12 м)"
}

L:SetMiscLocalization{
	Keleseth			= "Принц Келесет",
	Taldaram			= "Принц Талдарам",
	Valanar				= "Принц Валанар",
	EmpoweredFlames		= "Жаркое пламя тянется к (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Королева Лана'тель"
}

L:SetOptionLocalization{
	RangeFrame				= "Показывать окно проверки дистанции (8 м)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "Тени собираются и окружают (%S+)!",
	YellFrenzy				= "Я голоден!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Валитрия Сноходица"
}

L:SetWarningLocalization{
	WarnPortalOpen	= "Открытие порталов"
}

L:SetTimerLocalization{
	TimerPortalsOpen		= "Открытие порталов",
	TimerBlazingSkeleton	= "Исторгающий пламя скелет",
	TimerAbom				= "След. поганище?"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Устанавливать метку на Исторгающего пламя скелета (череп)",
	WarnPortalOpen				= "Предупреждение об открытии порталов",
	TimerPortalsOpen			= "Отсчет времени для открытия порталов",
	TimerBlazingSkeleton		= "Отсчет времени до Исторгающего пламя скелета",
	TimerAbom					= "Отсчет времени до след. Прожорливого поганища (экспериментальный)"
}

L:SetMiscLocalization{
	YellPull		= "Чужаки ворвались во внутренние покои. Уничтожьте зеленого дракона! Пусть останутся лишь кости и прах для воскрешения!",
	YellKill		= "Я ИЗЛЕЧИЛАСЬ! Изера, даруй мне силу покончить с этими нечестивыми тварями.",
	YellPortals		= "Я открыла портал в Изумрудный Сон. Там вы найдете спасение, герои..."
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Синдрагоса"
}

L:SetWarningLocalization{
	WarnAirphase			= "Воздушная фаза",
	WarnGroundphaseSoon		= "Синдрагоса скоро приземлится"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "След. воздушная фаза",
	TimerNextGroundphase	= "След. наземная фаза",
	AchievementMystic		= "Время для устранения Таинственной энергии"
}

L:SetOptionLocalization{
	WarnAirphase			= "Объявлять воздушную фазу",
	WarnGroundphaseSoon		= "Предупреждать заранее о наземной фазе",
	TimerNextAirphase		= "Отсчет времени до следующей воздушной фазы",
	TimerNextGroundphase	= "Отсчет времени до следующей наземной фазы",
	AnnounceFrostBeaconIcons= "Объявлять метки целей заклинания $spell:70126 в рейд-чат<br/>(требуются права помощника)",
	ClearIconsOnAirphase	= "Снимать все метки перед воздушной фазой",
	AchievementCheck		= "Объявлять предупреждения для достижения 'Таинственная дама'<br/>в рейд-чат (требуются права помощника)",
	RangeFrame				= "Показывать игроков с метками в окне проверки дистанции (10 норм., 20 гер.)"
}

L:SetMiscLocalization{
	YellAirphase		= "Здесь ваше вторжение и окончится! Никто не уцелеет.",
	YellPhase2			= "А теперь почувствуйте всю мощь господина и погрузитесь в отчаяние!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Ледяная метка {rt%d} установлена на: %s",
	AchievementWarning	= "Предупреждение: %s получил 5 стаков Таинственной энергии",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил %d стаков Таинственной энергии <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Король-лич"
}

L:SetWarningLocalization{
	ValkyrWarning			= "|3-3(>%s<) схватили!",
	SpecWarnYouAreValkd		= "Вас схватили",
	WarnNecroticPlagueJump	= "Мертвящая чума перепрыгнула на |3-3(>%s<)",
	SpecWarnValkyrLow		= "У Валь'киры меньше 55%"
}

L:SetTimerLocalization{
	TimerRoleplay		= "Представление",
	PhaseTransition		= "Переходная фаза",
	TimerNecroticPlagueCleanse = "Очищение Мертвящей чумы"
}

L:SetOptionLocalization{
	TimerRoleplay			= "Отсчет времени для представления",
	WarnNecroticPlagueJump	= "Объявлять цели прыжков $spell:73912",
	TimerNecroticPlagueCleanse	= "Отсчет времени для очищения Мертвящей чумы до первого тика",
	PhaseTransition			= "Отсчет времени для переходной фазы",
	ValkyrWarning			= "Объявлять, кого схватили Валь'киры",
	SpecWarnYouAreValkd		= "Спец-предупреждение, когда вас схватила Валь'кира",
	AnnounceValkGrabs		= "Объявлять игроков, схваченных Валь'кирами, в рейд-чат<br/>(требуются права помощника)",
	SpecWarnValkyrLow		= "Спец-предупреждение, когда у Валь'киры меньше 55% HP",
	AnnouncePlagueStack		= "Объявлять стаки заклинания $spell:73912 в рейд-чат (10<br/>стаков, далее каждые 5) (требуются права помощника)"
}

L:SetMiscLocalization{
	LKPull					= "Неужели прибыли наконец хваленые силы Света? Мне бросить Ледяную Скорбь и сдаться на твою милость, Фордринг?",
	LKRoleplay				= "Что движет вами?.. Праведность? Не знаю...",
	ValkGrabbedIcon			= "Валь'кира {rt%d} схватила %s",
	ValkGrabbed				= "Валь'кира схватила %s",
	PlagueStackWarning		= "Предупреждение: %s получил %d стаков Мертвящей чумы",
	AchievementCompleted	= ">> ДОСТИЖЕНИЕ ВЫПОЛНЕНО: %s получил %d стаков Мертвящей чумы <<"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization{
	name = "Icecrown Trash"
}

L:SetWarningLocalization{
	SpecWarnTrapL		= "Ловушка активирована! - Заклятый страж освобожден",
	SpecWarnTrapP		= "Ловушка активирована! - приближаются Мстительные свежеватели",
	SpecWarnGosaEvent	= "Приближаются защитники Синдрагосы!"
}

L:SetOptionLocalization{
	SpecWarnTrapL		= "Спец-предупреждение для активации ловушки",
	SpecWarnTrapP		= "Спец-предупреждение для активации ловушки",
	SpecWarnGosaEvent	= "Спец-предупреждение для активации защитников Синдрагосы"
}

L:SetMiscLocalization{
	WarderTrap1			= "Кто... идет?",
	WarderTrap2			= "Я пробудился...",
	WarderTrap3			= "В покои господина проникли!",
	FleshreaperTrap1	= "Скорей, нападем на них сзади!",
	FleshreaperTrap2	= "Вам не уйти от нас.",
	FleshreaperTrap3	= "Живые? Здесь?!",
	SindragosaEvent		= "Они не должны прорваться к Синдрагосе! Скорее, остановите их!"
}
