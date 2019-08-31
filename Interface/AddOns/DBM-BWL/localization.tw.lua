if GetLocale() ~= "zhTW" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "狂野的拉佐格爾"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "小怪重生"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "為第一次小怪重生顯示計時器"
}
L:SetMiscLocalization{
	Phase2Emote	= "在寶珠的控制力消失之前逃走。",
	YellPull 	= "入侵者闖入孵化室了!警報!不惜一切代價保護蛋!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name	= "墮落的瓦拉斯塔茲"
}

L:SetMiscLocalization{
	Event	= "太遲了，朋友! 奈法利斯的腐化已經掌握了我...我已經無法...控制我自己了。"
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "幼龍領主勒西雷爾"
}

L:SetMiscLocalization{
	Pull	= "你怎麼進來的?你們這種生物不能進來!我要毀滅你們!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "費爾默"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "埃博諾克"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "弗萊格爾"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "克洛瑪古斯"
}
L:SetWarningLocalization{
	WarnBreath		= "%s"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s冷卻"
}
L:SetOptionLocalization{
	WarnBreath		= "為克洛瑪古斯其中一個吐息顯示警告",
	TimerBreathCD	= "顯示吐息冷卻"
}
L:SetMiscLocalization{
	Breath1	= "第一次吐息",
	Breath2	= "第二次吐息"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "奈法利安"
}
L:SetWarningLocalization{
	WarnClassCall		= "%s呼喊"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s呼喊結束"
}
L:SetOptionLocalization{
	TimerClassCall		= "為職業呼喊持續時間顯示計時器",
	WarnClassCall		= "提示職業呼喊"
}
L:SetMiscLocalization{
	YellP2		= "幹得好，我的手下。凡人的勇氣開始消退!現在，現在讓我們看看他們如何應對黑石之王的力量!!!",
	YellP3		= "不可能!出現吧，我的僕人!再次為我的主人服務!",
	YellShaman	= "薩滿，讓我看看",
	YellPaladin	= "聖騎士...聽說你有無數條命。讓我看看到底是怎麼樣的吧。",
	YellDruid	= "德魯伊和你們愚蠢的變身術。讓我們看看什麼會發生吧!",
	YellPriest	= "牧師!如果你要繼續這麼治療的話，那我們來玩點有趣的東西!",
	YellWarrior	= "戰士，我知道你的力量不只如此!讓我們來見識一下吧!",
	YellRogue	= "盜賊?不要躲了，面對我吧!",
	YellWarlock	= "術士，不要隨便去玩那些你不理解的法術。看看會發生什麼吧?",
	YellHunter	= "獵人和你那討厭的豌豆射擊!",
	YellMage	= "還有法師?你應該小心使用你的魔法...",
	YellDK		= "死亡騎士們...來這。",
	YellMonk	= "武僧"
}