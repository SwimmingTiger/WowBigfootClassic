if GetLocale() ~= "ruRU" then return end

local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "Ал'ар"
}

L:SetTimerLocalization{
	NextPlatform	= "Следующая платформа"
}

L:SetOptionLocalization{
	NextPlatform	= "Show timer for when Al'ar changes platforms"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "Страж Бездны"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "Верховный звездочет Солариан"
}

L:SetWarningLocalization{
	WarnSplit		= "*** Приспешники на подходе ***",
	WarnSplitSoon	= "*** Разделение через 5 секунд ***",
	WarnAgent		= "*** Пособники появились ***",
	WarnPriest		= "*** Жрецы и Солариан появились ***"

}

L:SetTimerLocalization{
	TimerSplit		= "Разделение",
	TimerAgent		= "Пособники",
	TimerPriest		= "Жрецы и Солариан"
}

L:SetOptionLocalization{--Translate
	WarnSplit		= "Show warning for Split",
	WarnSplitSoon	= "Show pre-warning for Split",
	WarnAgent		= "Show warning for Agents spawn",
	WarnPriest		= "Show warning for Priests and Solarian spawn",
	TimerSplit		= "Show timer for Split",
	TimerAgent		= "Show timer for Agents spawn",
	TimerPriest		= "Show timer for Priests and Solarian spawn",
	WrathWhisper	= "Сообщить шепотом цели, если Гнев на нем"
}

L:SetMiscLocalization{
	WrathWhisper	= "Гнев на вас!",
	YellSplit1		= "I will crush your delusions of grandeur!",--Translate
	YellSplit2		= "You are hopelessly outmatched!",--Translate
	YellPhase2		= "I become"--Translate
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "Кель'тас Солнечный Скиталец"
}

L:SetWarningLocalization{
	WarnGaze		= "*** Таладред бросает взор на >%s< ***",
	WarnMobDead		= "%s down",--Translate
	WarnEgg			= "*** Феникс убит - появляется яйцо ***",
	SpecWarnGaze	= "Бегите!",
	SpecWarnEgg		= "*** Феникс убит - появляется яйцо ***"
}

L:SetTimerLocalization{
	TimerPhase		= "Next Phase",--Translate
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "Восстановление взгляда",
	TimerRebirth	= "Возрождение"
}

L:SetOptionLocalization{--Translate
	WarnGaze		= "Show warning for Thaladred's Gaze target",
	WarnMobDead		= "Show warning for Phase 2 mob down",
	WarnEgg			= "Show warning when Phoenix Egg spawn",
	SpecWarnGaze	= "Show special warning when Gaze on you",
	SpecWarnEgg		= "Show special warning when Phoenix Egg spawn",
	TimerPhase		= "Show time for next phase",
	TimerPhase1mob	= "Show time for Phase 1 mob active",
	TimerNextGaze	= "Show timer for Thaladred's Gaze target changes",
	TimerRebirth	= "Show timer for Phoenix Egg rebirth remaining",
	GazeWhisper		= "Сообщить шепотом цели, если Таладред на нем",
	GazeIcon		= "Установить метку на цель Таладред"
}

L:SetMiscLocalization{
	YellPhase2	= "As you see, I have many weapons in my arsenal....",--Translate
	YellPhase3	= "Perhaps I underestimated you. It would be unfair to make you fight all four advisors at once, but... fair treatment was never shown to my people. I'm just returning the favor.",--Translate
	YellPhase4	= "Alas, sometimes one must take matters into one's own hands. Balamore shanal!",--Translate
	YellPhase5	= "I have not come this far to be stopped! The future I have planned will not be jeopardized! Now you will taste true power!!",--Translate
	YellSang	= "You have persevered against some of my best advisors... but none can withstand the might of the Blood Hammer. Behold, Lord Sanguinar!",--Translate
	YellCaper	= "Capernian will see to it that your stay here is a short one.",--Translate
	YellTelo	= "Well done, you have proven worthy to test your skills against my master engineer, Telonicus.",--Translate
	EmoteGaze	= "sets eyes on ([^%s]+)!",--Translate
	GazeWhisper	= "Таладред бросает взор на ВАС! Бегите!",
	Thaladred	= "Таладред Светокрад",
	Sanguinar	= "Лорд Сангвинар",
	Capernian	= "Великий Звездочет Каперниан",
	Telonicus	= "Старший инженер Телоникус",
	Bow			= "Netherstrand Longbow",--Translate
	Axe			= "Devastation",--Translate
	Mace		= "Cosmic Infuser",--Translate
	Dagger		= "Infinity Blades",--Translate
	Sword		= "Warp Slicer",--Translate
	Shield		= "Phaseshift Bulwark",--Translate
	Staff		= "Staff of Disintegration",--Translate
	Egg			= "Яйцо феникса"
}
