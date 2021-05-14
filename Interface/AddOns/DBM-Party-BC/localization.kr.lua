if GetLocale() ~= "koKR" then return end
local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization(527)

--------------------------
--  Omor the Unscarred  --
--------------------------
L = DBM:GetModLocalization(528)

------------------------
--  Nazan & Vazruden  --
------------------------
L = DBM:GetModLocalization(529)

-------------------------
--  The Blood Furnace  --
-------------------------
--  The Maker  --
-----------------
L = DBM:GetModLocalization(555)

---------------
--  Broggok  --
---------------
L = DBM:GetModLocalization(556)

----------------------------
--  Keli'dan the Breaker  --
----------------------------
L = DBM:GetModLocalization(557)

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
L = DBM:GetModLocalization(566)

--------------------------
--  Blood Guard Porung  --
--------------------------
L = DBM:GetModLocalization(728)

--------------------------
--  Warbringer O'mrogg  --
--------------------------
L = DBM:GetModLocalization(568)

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
L = DBM:GetModLocalization(569)

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
L = DBM:GetModLocalization(570)

---------------------------
--  Rokmar the Crackler  --
---------------------------
L = DBM:GetModLocalization(571)

------------------
--  Quagmirran  --
------------------
L = DBM:GetModLocalization(572)

--------------------
--  The Underbog  --
--------------------
--  Hungarfen  --
-----------------
L = DBM:GetModLocalization(576)

---------------
--  Ghaz'an  --
---------------
L = DBM:GetModLocalization(577)

--------------------------
--  Swamplord Musel'ek  --
--------------------------
L = DBM:GetModLocalization(578)

-------------------------
--  The Black Stalker  --
-------------------------
L = DBM:GetModLocalization(579)

----------------------
--  The Steamvault  --
---------------------------
--  Hydromancer Thespia  --
---------------------------
L = DBM:GetModLocalization(573)

-----------------------------
--  Mekgineer Steamrigger  --
-----------------------------
L = DBM:GetModLocalization(574)

L:SetMiscLocalization({
	Mechs	= "얘들아, 쟤네들을 부드럽게 만져줘라!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization(575)

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization(523)

-----------------------
--  Exarch Maladaar  --
-----------------------
L = DBM:GetModLocalization(524)

------------------
--  Mana-Tombs  --
-------------------
--  Pandemonius  --
-------------------
L = DBM:GetModLocalization(534)

---------------
--  Tavarok  --
---------------
L = DBM:GetModLocalization(535)

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
L = DBM:GetModLocalization(537)

-----------
--  Yor  --
-----------
L = DBM:GetModLocalization(536)

---------------------
--  Sethekk Halls  --
-----------------------
--  Darkweaver Syth  --
-----------------------
L = DBM:GetModLocalization(541)

------------
--  Anzu  --
------------
L = DBM:GetModLocalization(542)

L:SetWarningLocalization({
	warnStoned	= "돌로 돌아옴 : %s"--확인필요
})

L:SetOptionLocalization({
	warnStoned	= "영혼이 돌로 되돌아 올때 알림 보기"--확인필요
})

L:SetMiscLocalization({
    BirdStone	= "돌아"--확인필요
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization(543)

------------------------
--  Shadow Labyrinth  --
--------------------------
--  Ambassador Hellmaw  --
--------------------------
L = DBM:GetModLocalization(544)

------------------------------
--  Blackheart the Inciter  --
------------------------------
L = DBM:GetModLocalization(545)

--------------------------
--  Grandmaster Vorpil  --
--------------------------
L = DBM:GetModLocalization(546)

--------------
--  Murmur  --
--------------
L = DBM:GetModLocalization(547)

-------------------------------
--  Old Hillsbrad Foothills  --
-------------------------------
--  Lieutenant Drake  --
------------------------
L = DBM:GetModLocalization(538)

-----------------------
--  Captain Skarloc  --
-----------------------
L = DBM:GetModLocalization(539)

--------------------
--  Epoch Hunter  --
--------------------
L = DBM:GetModLocalization(540)

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
L = DBM:GetModLocalization(552)

----------------
--  Temporus  --
----------------
L = DBM:GetModLocalization(553)

--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization(554)

L:SetMiscLocalization({
    AeonusFrenzy	= "%s|1이;가; 광란의 상태에 빠집니다!"--확인필요
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "검은 늪: 차원문"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "곧 다음 차원문",
    WarnWavePortal		= "차원문 #%d",
    WarnBossPortal		= "우두머리 등장"
})

L:SetTimerLocalization({
	TimerNextPortal		= "차원문 #%d"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "다음 차원문 이전에 알림 보기",
    WarnWavePortal		= "차원문 알림 보기",
    WarnBossPortal		= "우두머리 등장 알림 보기",
	TimerNextPortal		= "우두머리 처치 이후 다음 차원문 바 보기",
	ShowAllPortalTimers	= "모든 차원문 바 보기(부정확함)"
})

L:SetMiscLocalization({
	PortalCheck			= "시간의 균열 열림: (%d+)/18",
	Shielddown			= "No! Damn this feeble, mortal coil!"--확인필요
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")

L:SetGeneralLocalization({
	name = "문지기 회전톱날"
})

-----------------------------
--  Gatewatcher Iron-Hand  --
-----------------------------
L = DBM:GetModLocalization("Ironhand")

L:SetGeneralLocalization({
	name = "문지기 무쇠주먹"
})

L:SetMiscLocalization({
	JackHammer				= "%s|1이;가; 자신의 망치를 위협적으로 치켜듭니다..."--확인필요
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization(563)

------------------------------
--  Nethermancer Sepethrea  --
------------------------------
L = DBM:GetModLocalization(564)

--------------------------------
--  Pathaleon the Calculator  --
--------------------------------
L = DBM:GetModLocalization(565)

--------------------
--  The Botanica  --
--------------------------
--  Commander Sarannis  --
--------------------------
L = DBM:GetModLocalization(558)

------------------------------
--  High Botanist Freywinn  --
------------------------------
L = DBM:GetModLocalization(559)

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization(560)

-----------
--  Laj  --
-----------
L = DBM:GetModLocalization(561)

---------------------
--  Warp Splinter  --
---------------------
L = DBM:GetModLocalization(562)

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
L = DBM:GetModLocalization(548)

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
L = DBM:GetModLocalization(549)

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
L = DBM:GetModLocalization(550)

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization(551)

L:SetMiscLocalization({
	Split			= "밤하늘의 무한한 별처럼 온 우주를 덮으리라!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization(530)

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization(531)

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization(532)

L:SetMiscLocalization({
--	DelrissaPull	= "저들을 밟아줘라.",
	DelrissaEnd		= "뭔가... 잘못됐어..."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2				= "세상을... 거꾸로... 뒤집어주마."
})
