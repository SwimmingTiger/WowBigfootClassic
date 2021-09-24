if GetLocale() ~= "zhTW" then return end
local L

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("d286")

L:SetWarningLocalization({
	Emerged				= "艾胡恩已現身",
	specWarnAttack		= "艾胡恩變得脆弱 - 現在攻擊!"
})

L:SetTimerLocalization({
	SubmergeTimer		= "隱沒",
	EmergeTimer			= "現身"
})

L:SetOptionLocalization({
	Emerged				= "當艾胡恩現身時顯示警告",
	specWarnAttack		= "當艾胡恩變得脆弱時顯示特別警告",
	SubmergeTimer		= "為隱沒顯示計時器",
	EmergeTimer			= "為現身顯示計時器"
})

L:SetMiscLocalization({
	Pull				= "冰石已經溶化了!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("d287")

L:SetWarningLocalization({
	specWarnBrew		= "在他再丟你另一個前喝掉酒!",
	specWarnBrewStun	= "提示:你瘋狂了,記得下一次喝啤酒!"
})

L:SetOptionLocalization({
	specWarnBrew		= "為$spell:47376顯示特別警告",
	specWarnBrewStun	= "為$spell:47340顯示特別警告"
})

L:SetMiscLocalization({
	YellBarrel			= "我中了空桶(暈)"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("d285")

L:SetWarningLocalization({
	WarnPhase				= "第%d階段",
	warnHorsemanSoldiers	= "跳動的南瓜出現了!",
	warnHorsemanHead		= "旋風斬 - 轉換目標!"
})

L:SetOptionLocalization({
	WarnPhase				= "為每個階段改變顯示警告",
	warnHorsemanSoldiers	= "為跳動的南瓜出現顯示警告",
	warnHorsemanHead		= "為旋風斬顯示特別警告 (第二次及最後的頭顱出現)"
})

L:SetMiscLocalization({
	HorsemanSummon			= "騎士甦醒...",
	HorsemanSoldiers		= "士兵們起立，挺身奮戰!讓這個位死去的騎士得到最後的勝利!"
})
