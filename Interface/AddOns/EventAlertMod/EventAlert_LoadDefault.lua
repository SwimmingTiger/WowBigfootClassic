if LibDebug then LibDebug() end
--EA_Config2 改為初始預設值
EA_Config2 = 	{

		--是否顯示符文列
		ShowRunesBar = true,
		
		--脫離戰鬥後是否保持技能冷卻框架		
		SCD_NocombatStillKeep	=  true,		
		
		--當冷卻框架之技能達到可施放條件時高亮
		SCD_GlowWhenUsable		= true,	
		
		--單一技能冷卻完成即移除(true:要移除/false:不移除)
		SCD_RemoveWhenCooldown	= true,		
		
		--冷卻中是否顯示框架(true:顯示 / false:不顯示)
		SCD_ShowWhenWaitCooldown = true,
		
		--剩餘多少秒開始使用小數點一位顯示(使用0則完全不會有小數點)
		UseFloatSec				= 1,

		--是否顯示獵人寵物集中值(已移除)
		--HUNTER_ShowPetFocus		= true,
		
		--獵人寵物集中值高亮條件值(0表示不高亮)
		HUNTER_GlowPetFocus 	= 50,
		
		--滑鼠移到圖示顯示技能說明
		ICON_APPEND_SPELL_TIP = true,
		
		--是否顯示設置圖標
		OPTION_ICON = true,
		
		--BUFF/DEBUFF 的Value 值大於等於指定數值才會顯示
		ShowAuraValueWhenOver = 10,
		
}