if LibDebug then LibDebug() end
EA_Config = {
			SpecPowerCheck = {
				FocusPet,
				ComboPoints,				
				Rage, 
				Focus,
				Energy,
				Runes,
				RunicPower,
				Runes,
				SoulShards,
				--Eclipse,
				LunarPower,
				HolyPower,
				DarkForce,
				Chi,				
				Insanity,
				BurningEmbers,
				DemonicFury,
				LifeBloom,	
				ArcaneCharges,
				Maelstrom,
				Fury,			
				Pain,
				Happiness,
				Mana,
				Health,
				},
			DoAlertSound,
			AlertSound,
			AlertSoundValue,
			LockFrame,
			ShareSettings,
			ShowFrame,
			ShowName,
			ShowFlash,
			ShowTimer,
			BaseFontSize,
			TimerFontSize,
			StackFontSize,
			SNameFontSize,
			ChangeTimer,
			Version,
			AllowESC,
			AllowAltAlerts,
			Target_MyDebuff,
			
			}


-----------------------------------------------------------------
--STANDARD_TEXT_FONT表示針對該語系所指向的系統預設字型
EA_FONTS = STANDARD_TEXT_FONT
--EA_FONT_OBJECT = GameFontNormal
--EA_FONT_OBJECT = GameFontNormalSmall
--EA_FONT_OBJECT = GameFontNormalLarge
EA_FONT_OBJECT = GameFontHighlight
--EA_FONT_OBJECT = GameFontHighlightSmall
--EA_FONT_OBJECT = GameFontHighlightSmallOutline
--EA_FONT_OBJECT = GameFontHighlightLarge
--EA_FONT_OBJECT = GameFontDisable
--EA_FONT_OBJECT = GameFontDisableSmall
--EA_FONT_OBJECT = GameFontDisableLarge
--EA_FONT_OBJECT = GameFontGreen
--EA_FONT_OBJECT = GameFontGreenSmall
--EA_FONT_OBJECT = GameFontGreenLarge
--EA_FONT_OBJECT = GameFontRed
--EA_FONT_OBJECT = GameFontRedSmall
--EA_FONT_OBJECT = GameFontRedLarge
--EA_FONT_OBJECT = GameFontWhite
--EA_FONT_OBJECT = GameFontDarkGraySmall
--EA_FONT_OBJECT = NumberFontNormalYellow
--EA_FONT_OBJECT = NumberFontNormalSmallGray
--EA_FONT_OBJECT = QuestFontNormalSmall
--EA_FONT_OBJECT = DialogButtonHighlightText
--EA_FONT_OBJECT = ErrorFont
--EA_FONT_OBJECT = TextStatusBarText
--EA_FONT_OBJECT = CombatLogFont
EA_Position = 	{
				Anchor,
				relativePoint,
				xLoc,
				yLoc,
				xOffset,
				yOffset,
				RedDebuff,
				GreenDebuff,
				Tar_NewLine,
				TarAnchor,
				TarrelativePoint,
				Tar_xOffset,
				Tar_yOffset,
				ScdAnchor,
				Scd_xOffset,
				Scd_yOffset,
				Execution,
				PlayerLv2BOSS,
				SCD_UseCooldown,
				}
-----------------------------------------------------------------
EA_Pos = { }
EA_SPELLINFO_SELF = { }
EA_SPELLINFO_TARGET = { }
EA_SPELLINFO_SCD = { }
EA_ClassAltSpellName = { }
GC_IndexOfGroupFrame = { }
-----------------------------------------------------------------
EA_DEBUGFLAG1 	= false
EA_DEBUGFLAG2 	= false
EA_DEBUGFLAG3 	= false
EA_DEBUGFLAG11 	= false
EA_DEBUGFLAG21 	= false
-----------------------------------------------------------------
EA_DEBUGFLAG601 = false	--Deubg for
EA_DEBUGFLAG602 = false	--Deubg for
EA_DEBUGFLAG603 = false	--Deubg for
EA_DEBUGFLAG604 = false	--Deubg for
EA_DEBUGFLAG605 = false	--Deubg for
EA_DEBUGFLAG606 = false	--Deubg for
EA_DEBUGFLAG607 = false	--Deubg for
EA_DEBUGFLAG608 = false	--Deubg for
EA_DEBUGFLAG609 = false	--Deubg for
EA_DEBUGFLAG610 = false	--Deubg for
EA_DEBUGFLAG611 = false	--Deubg for
-----------------------------------------------------------------
EA_CurrentBuffs = { }
EA_TarCurrentBuffs = { }
EA_ScdCurrentBuffs = { }
EA_ShowScrollSpells = { }
EA_ShowScrollSpell_YPos = 25
-----------------------------------------------------------------
EA_SpecFrame_Self = false
EA_SpecFrame_Target = false
EA_SpecFrame_LifeBloom = { UnitID = "", UnitName = "", ExpireTime = 0, Stack = 0 }
fLock_EventAlert_Buffs_Update = false
EA_COMBO_POINTS = 0
EA_playerClass  = nil
EA_SpecID = nil
EA_RUNE_TYPE = 1
localizedPlayerClass,EA_playerClass = UnitClass("player")
-----------------------------------------------------------------
		RUNETYPE_BLOOD = 1
		RUNETYPE_FROST = 2
		RUNETYPE_UNHOLY = 3
		RUNETYPE_DEATH = 4		
		
		MAX_RUNES = 6
 
 
		iconTextures = {}
		iconTextures[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood"
		iconTextures[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy"
		iconTextures[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost"
		iconTextures[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death"
		
		--[[
		runeTextures = {
		[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Blood-Off.tga",
		[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Death-Off.tga",
		[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost-Off.tga",
		[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-Off.tga",
		} 
		]]--
		
		runeTextures = {
			[RUNETYPE_BLOOD] = "interface\\playerframe\\classoverlaydeathknightrunes.blp",
			[RUNETYPE_UNHOLY] = "interface\\playerframe\\classoverlaydeathknightrunes.blp",
			[RUNETYPE_FROST] = "interface\\playerframe\\classoverlaydeathknightrunes.blp",
			[RUNETYPE_DEATH] = "interface\\playerframe\\classoverlaydeathknightrunes.blp",
			} 
		
		runeSetTexCoord = {		
			[RUNETYPE_BLOOD] = {minX = 0.01+0, maxX = 0.01+1/4 ,minY = 0 ,maxY = 1/4 },
			[RUNETYPE_UNHOLY] = {minX = 0.01+0, maxX = 0.01+1/4 ,minY = 0.02+2/4 ,maxY = 0.02+3/4 },
			[RUNETYPE_FROST] = {minX = 0.025+1/4, maxX = 0.025+2/4 ,minY = 0.005+0 ,maxY = 0.005+1/4 },
			[RUNETYPE_DEATH] = {minX = 0.025+1/4, maxX = 0.025+2/4 ,minY = 0.005+1/4 ,maxY = 0.005+2/4 },
			} 
 
		runeEnergizeTextures = {
		[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\Deathknight-Energize-Blood",
		[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\Deathknight-Energize-Unholy",
		[RUNETYPE_FROST] = "Interface\\PlayerFrame\\Deathknight-Energize-Frost",
		[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\Deathknight-Energize-White",
		}
 
		runeColors = {
		[RUNETYPE_BLOOD] = {1, 0, 0},
		[RUNETYPE_UNHOLY] = {0, 0.5, 0},
		[RUNETYPE_FROST] = {0, 1, 1},
		[RUNETYPE_DEATH] = {0.8, 0.1, 1},
		}
		
		runeTypeText = {
		[RUNETYPE_BLOOD] = "血魄",
		[RUNETYPE_UNHOLY] = "穢邪",
		[RUNETYPE_FROST] = "冰霜",
		[RUNETYPE_DEATH] = "死亡",
		}
		
		RUNE_MAPPING = {
		[1] = 1,
		[2] = 2,
		[3] = 5,
		[4] = 6,
		[5] = 3,
		[6] = 4,
		}
-----------------------------------------------------------------	