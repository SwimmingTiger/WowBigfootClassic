if GetLocale() ~= "ruRU" then return end

local L

local optionWarning		= "Предупреждение для %s"
local optionPreWarning	= "Предупреждать заранее о %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization(581)

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization(580)

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization(582)

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization(584)

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization(583)

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization(585)

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization(586)

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Ануб'арак (группа)"
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization(611)

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization(612)

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization(613)

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization(614)

L:SetMiscLocalization({
	Outro	= "Твое путешествие начинается, юный принц. Собирай свои войска и отправляйся в царство вечных снегов, в Нордскол. Там мы и уладим все наши дела, там ты узнаешь свою судьбу."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Волны Стратхольма"
})

L:SetWarningLocalization({
	WarningWaveNow = "Волна %d: призыв %s"
})

L:SetTimerLocalization({
	TimerWaveIn		= "Следующая волна (6)",
	TimerRoleplay	= "Вступительное представление"
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("новой волны"),
	TimerWaveIn		= "Отсчет времени до cледующей волны (после босса 5-ой волны)",
	TimerRoleplay	= "Отсчет времени для вступительного представления"
})

L:SetMiscLocalization({
	Devouring	= "Всепожирающий вурдалак",
	Enraged		= "Разъярившийся вурдалак",
	Necro		= "Некромант",
	Fiend		= "Некрорахнид",
	Stalker		= "Кладбищенский ловец",
	Abom		= "Лоскутное создание",
	Acolyte		= "Послушник",
	Wave1		= "%d %s",
	Wave2		= "%d %s и %d %s",
	Wave3		= "%d %s, %d %s и %d %s",
	Wave4		= "%d %s, %d %s, %d %s и %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Атаки Плети: (%d+)/10",
	Roleplay	= "Я рад, что ты пришел, Утер!",
	Roleplay2	= "Похоже, все готовы. Помните, эти люди заражены чумой и скоро умрут. Мы должны очистить Стратхольм и защитить Лордерон от Плети. Вперед."
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization(588)

--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization(589)

L:SetMiscLocalization({
	YellPull		= "Вам холодно? Это дыхание скорой смерти.",
	HandlerYell		= "Защищайте меня! Быстрее, будьте вы прокляты!",
	Phase2			= "Неужели вы не понимаете всей бесполезности происходящего?",
	YellKill		= "Ваши усилия… напрасны."
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization(590)

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization(591)

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization(592)

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization(594)

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization(593)

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization(596)

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization(595)

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization(597)

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization(599)

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization(598)

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization(600)

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization(605)

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization(604)

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization(607)

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization(606)

L:SetWarningLocalization({
	WarningPhase	= "Фаза %d"
})

L:SetTimerLocalization({
	timerEvent	= "Оставшееся время"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("фаз"),
	timerEvent		= "Отсчет времени продолжительности события"
})

L:SetMiscLocalization({
	Pull	= "Теперь будьте внимательны! Не успеете и глазом моргнуть, как…",
	Phase1	= "Обнаружено вторжение в систему. Приоритетность работ по анализу исторических архивов понижена. Ответные меры инициированы.",
	Phase2	= "Порог допустимой угрозы превышен. Астрономический архив отключен. Уровень безопасности повышен.",
	Phase3	= "Критическое значение уровня угрозы. Перенаправление анализа Бездны. Инициирование протокола очищения.",
	Kill	= "Внимание: меры предосторожности деактивированы. Начинаю стирание памяти и…"
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization(619)

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization(620)

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization(618)

L:SetMiscLocalization({
	SplitTrigger1		= "Меня на вас хватит!",
	SplitTrigger2		= "Вы получите больше, чем заслуживаете!"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization(621)

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Неизвестный"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Командир Колург"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Командир Пивобород"
end

L:SetGeneralLocalization({
	name = commander
})

------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization(622)

L:SetOptionLocalization({
	MakeitCountTimer	= "Отсчет времени для Вам всем зачтется (достижение)"
})

local makeItCountName = select(2, GetAchievementInfo(1868))

L:SetMiscLocalization({
	MakeitCountTimer	= makeItCountName
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization(624)

L:SetMiscLocalization({
	CombatStart		= "Несчастные слепые глупцы!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization(623)

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization(625)

L:SetMiscLocalization({
	MakeitCountTimer	= makeItCountName
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization(638)

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization(639)

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization(640)

L:SetMiscLocalization({
	YellCombatEnd	= "Нет! Я смогу это сделать… я смогу…"
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization(643)

L:SetMiscLocalization({
	CombatStart		= "Что за недоноски осмелились вторгнуться сюда? Поживее, братья мои! Угощение тому, кто принесет мне их головы!",
	Phase2			= "Ничтожные лакеи! Ваши трупы послужат хорошей закуской для моего нового дракона!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization(644)

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization(641)

L:SetTimerLocalization({
	timerRoleplay		= "Свала Вечноскорбящая активируется"
})

L:SetOptionLocalization({
	timerRoleplay		= "Отсчет времени для представления перед активацией Свалы Вечноскорбящей"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Мой господин! Я сделала, как вы велели, и теперь молю вас о благословении!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization(642)

-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization(632)

L:SetMiscLocalization({
	CyanArrived	= "Вы доблестно обороняетесь, но этот город должен быть стерт с лица земли, и я лично исполню волю Малигоса!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization(626)

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization(628)

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization(630)

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization(627)

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization(629)

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization(631)

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Таймеры порталов"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Скоро новый портал",
	WarningPortalNow	= "Портал #%d",
	WarningBossNow		= "Прибытие Босса"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Портал #%d" ,
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("нового портала"),
	WarningPortalSoon		= optionPreWarning:format("новом портале"),
	WarningBossNow			= optionWarning:format("прибытия босса"),
	TimerPortalIn			= "Отсчет времени до следующего портала (после босса)",
	ShowAllPortalTimers		= "Отсчет времени для всех порталов (неточный)"
})

L:SetMiscLocalization({
	Sealbroken	= "Мы прорвались через тюремные ворота! Дорога в Даларан открыта! Теперь мы, наконец, прекратим войну Нексуса!",
	WavePortal	= "Открыто порталов: (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization(637)

L:SetOptionLocalization({
	AchievementCheck		= "Объявлять о провале достижения 'Бывало и хуже' в чат группы"
})

L:SetMiscLocalization({
	Pull				= "Великолепно. Сегодня вы в честной борьбе заслужили…",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил урон от Взрыва вурдалака <<",
	YellCombatEnd		= "Нет! Я не могу... снова... проиграть."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization(634)

L:SetMiscLocalization({
	YellCombatEnd	= "Вы отлично сражались! Следующим испытанием станет битва с одним из членов Авангарда. Вы проверите свои силы в схватке с достойным соперником."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization(636)

L:SetMiscLocalization({
	YellCombatEnd	= "Отличная работа!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization(635)

L:SetMiscLocalization({
	YellCombatEnd	= "Я сдаюсь! Я побежден. Отличная работа. Можно теперь убегать?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization(609)

L:SetMiscLocalization({
	Barrage	= "%s начинает быстро создавать взрывающиеся снаряды."
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization(608)

L:SetOptionLocalization({
	AchievementCheck			= "Объявлять предупреждения о достижении 'Не жди до одиннадцати!' в чат группы"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s швыряет в вас глыбой саронита!",
	AchievementWarning	= "Предупреждение: %s получил %d стаков Вечной мерзлоты",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил %d стаков Вечной мерзлоты <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization(610)

L:SetMiscLocalization({
	CombatStart	= "Увы, бесстрашные герои, ваша навязчивость ускорила развязку. Вы слышите громыхание костей и скрежет стали за вашими спинами? Это предвестники скорой погибели.",
	HoarfrostTarget	= "Ледяной змей Иней смотрит на (%S+), готовя морозную атаку!",
	YellCombatEnd	= "Не может быть... Иней… Предупреди…"
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization(615)

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization(616)

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Таймеры волн"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Скоро новая волна",
	WarnNewWave		= "%s вступает в бой"
})

L:SetTimerLocalization({
	TimerNextWave	= "Следующая волна"
})

L:SetOptionLocalization({
	WarnNewWave			= "Предупреждение о вступлении босса в бой",
	WarnNewWaveSoon		= "Предупреждать заранее о новой волне (после босса 5-ой волны)",
	ShowAllWaveWarnings	= "Предупреждения для всех волн",
	TimerNextWave		= "Отсчет времени до следующей волны (после босса 5-ой волны)",
	ShowAllWaveTimers	= "Предупреждения и отсчет времени для всех волн (неточный)"
})

L:SetMiscLocalization({
	WaveCheck	= "Отражено атак призраков = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization(601)

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization(602)

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization(603)

L:SetWarningLocalization({
	WarnWave		= "%s"
})

L:SetTimerLocalization({
	achievementEscape	= "Время для побега"
})

L:SetOptionLocalization({
	WarnWave	= "Предупреждение для прибывающих волн"
})

L:SetMiscLocalization({
	ACombatStart	= "Он слишком силен. Мы должны выбраться отсюда как можно скорее. Моя магия задержит его, но не надолго. Быстрее, герои!",
	HCombatStart	= "Он... слишком силён. Герои, быстрее... идите ко мнe! Мы должны немедленно покинуть это место! Я сделаю все возможное, чтобы удержать его на месте, пока мы бежим."
})
