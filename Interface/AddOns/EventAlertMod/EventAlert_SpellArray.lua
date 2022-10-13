
-- Prevent tainting global _.
local _
local _G = _G

local function CopyTable(SrcTable)
	local TarTable = {};
	for sKey, sValue in pairs(SrcTable) do
		if type(sValue) == "table" then
			TarTable[sKey] = {};
			TarTable[sKey] = CopyTable(sValue);
		else
			TarTable[sKey] = sValue;
		end
	end
	return TarTable;
end

function EventAlert_LoadClassSpellArray(ItemType)
	if (ItemType == 1) or (ItemType == 9 and EA_Items[EA_playerClass] == nil) then
		EA_Items[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["ITEMS"]) do
			i = tonumber(i);
			if EA_Items[EA_playerClass][i] == nil then EA_Items[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_Items[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 2) or (ItemType == 9 and EA_AltItems[EA_playerClass] == nil) then
		EA_AltItems[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["ALTITEMS"]) do
			i = tonumber(i);
			if EA_AltItems[EA_playerClass][i] == nil then EA_AltItems[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_AltItems[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 3) or (ItemType == 9 and EA_Items[EA_CLASS_OTHER] == nil) then
		EA_Items[EA_CLASS_OTHER] = {};
		for i, v in pairsByKeys(EADef_Items[EA_CLASS_OTHER]) do
			i = tonumber(i);
			if EA_Items[EA_CLASS_OTHER][i] == nil then EA_Items[EA_CLASS_OTHER][i] = v  end;
			if GetSpellInfo(i) == nil then EA_Items[EA_CLASS_OTHER][i] = nil end;
		end
	end
	if (ItemType == 4) or (ItemType == 9 and EA_TarItems[EA_playerClass] == nil) then
		EA_TarItems[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["TARITEMS"]) do
			i = tonumber(i);
			if EA_TarItems[EA_playerClass][i] == nil then EA_TarItems[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_TarItems[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 5) or (ItemType == 9 and EA_ScdItems[EA_playerClass] == nil) then
		EA_ScdItems[EA_playerClass] = {};
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["SCDITEMS"]) do
			i = tonumber(i);
			if EA_ScdItems[EA_playerClass][i] == nil then EA_ScdItems[EA_playerClass][i] = v end;
			if GetSpellInfo(i) == nil then EA_ScdItems[EA_playerClass][i] = nil end;
		end
	end
	if (ItemType == 6) or (ItemType == 9 and EA_GrpItems[EA_playerClass] == nil) then
		EA_GrpItems[EA_playerClass] = {};
		local iGroupCnts = 0;
		--if (#EA_GrpItems[EA_playerClass] ~= nil) then iGroupCnts = #EA_GrpItems[EA_playerClass] end;
		for i, v in pairsByKeys(EADef_Items[EA_playerClass]["GRPITEMS"]) do
			i = tonumber(i);
			if EA_GrpItems[EA_playerClass][iGroupCnts+i] == nil then EA_GrpItems[EA_playerClass][iGroupCnts+i] = {} end;
			-- EA_GrpItems[EA_playerClass][iGroupCnts+i] = v;
			EA_GrpItems[EA_playerClass][iGroupCnts+i] = CopyTable(v);
		end
	end
end

function EventAlert_LoadSpellArray()

	EADef_Items = {};

--------------------------------------------------------------------------------
-- Death Knight / 死亡騎士
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_DK] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[48707] = {enable=true,self=true},   	-- 反魔法護罩
			[48792] = {enable=true,self=true},   	-- 冰錮堅韌
			[49039] = {enable=true,self=true},   	-- 巫妖之軀
			[51124] = {enable=true,self=true},   	-- 殺戮酷刑
			[57330] = {enable=true,self=true},   	-- 凜冬號角
			[59052] = {enable=true,self=true},   	-- 凝霜
			[81141] = {enable=true,self=true},   	-- 赤血災禍
			[81256] = {enable=true,self=true},   	-- 符文武器幻舞
			[194879] = {enable=true,self=true},   	-- 冰結之爪
			[196770] = {enable=true,self=true},   	-- 冷酷凜冬
			[212552] = {enable=true,self=true},   	-- 闇境靈行
			[207127] = {enable=true,self=true},		-- 飢狂符文武器
			[55233] = {enable=true,self=true},		-- 血族之裔
		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {

		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[55095] = {enable=true, self=true,},    -- 冰霜熱疫
			[55078] = {enable=true, self=true,},    -- 血魄瘟疫
			[194310] = {enable=true, self=true,},    -- 膿瘡傷口
			[191587] = {enable=true, self=true,},    -- 惡性瘟疫
			[206940] = {enable=true, self=true,},    -- 血魄印記

			},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[43265] = {enable=true,},   	-- 死亡凋零
			[45524] = {enable=true,},   	-- 冰鍊術
			[47476] = {enable=true,},   	-- 絞殺
			[47528] = {enable=true,},   	-- 心智冰封
			[48707] = {enable=true,},   	-- 反魔法護罩
			[48721] = {enable=true,},   	-- 沸血術
			[48792] = {enable=true,},   	-- 冰錮堅韌
			[49020] = {enable=true,},   	-- 滅寂
			[49576] = {enable=true,},   	-- 死亡之握
			[49998] = {enable=true,},   	-- 死亡打擊
			[77575] = {enable=true,},   	-- 疫病爆發
			[85948] = {enable=true,},   	-- 膿瘡潰擊
			[47568] = {enable=true,},   	-- 強力符文武器
			[49143] = {enable=true,},   	-- 冰霜打擊
			[51271] = {enable=true,},   	-- 冰霜之柱
			[196770] = {enable=true,},   	-- 冷酷凜冬
			[49184] = {enable=true,},   	-- 凜風衝擊
			[212552] = {enable=true,},   	-- 闇境靈行
			[207167] = {enable=true,},   	-- 致盲凍雨
			[207127] = {enable=true,},   	-- 飢狂符文武器
			[152279] = {enable=true,},   	-- 辛德拉苟莎之息
			[194913] = {enable=true,},   	-- 冰川突進
			[207256] = {enable=true,},   	-- 滅體抹殺
			[55233] = {enable=true},		-- 血族之裔
			[206930] = {enable=true},		-- 碎心打擊
			[221562] = {enable=true},		-- 窒息術
			[195292] = {enable=true},		-- 死亡的撫慰
			[195182] = {enable=true},		-- 撕骨裂髓
			[108199] = {enable=true},		-- 血魔之握
			[206977] = {enable=true},		-- 血魄之鏡
			[194844] = {enable=true},		-- 骸骨風暴
			[194679] = {enable=true},		-- 符文轉化
			[219809] = {enable=true},		-- 墓碑
			[221699] = {enable=true},		-- 血魄轉化
			[55090] = {enable=true},		-- 天譴打擊
			[47541] = {enable=true},		-- 死亡纏繞


		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Druid / 德魯依
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_DRUID] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[774] = {enable=true,},  	 	-- 回春術
			[1850] = {enable=true,},   		-- 突進
			[5215] = {enable=true,},   -- 潛行
			[5217] = {enable=true,},   -- 猛虎之怒
			[16870] = {enable=true,},   -- 節能施法(恢復專精)
			[22812] = {enable=true,},   -- 樹皮術
			[93622] = {enable=true,},   -- 割碎!(守護專精)
			[102543] = {enable=true,},   -- 化身:叢林之王
			[106951] = {enable=true,},   -- 狂暴(野性專精)
			[69369] = {enable=true,},   -- 猛獸迅捷
			[135700] = {enable=true,},   -- 節能施法(野性專精)
			[137452] = {enable=true,},   -- 獸性位移
			[158792] = {enable=true,},   -- 粉碎(守護專精)
			[145152] = {enable=true,},   -- 血爪(野性專精)
			[164545] = {enable=true,},   -- 日之活化
			[164547] = {enable=true,},   -- 月之活化
			[192081] = {enable=true,},   -- 鋼鐵毛皮
			[194223] = {enable=true,},   -- 星穹連線

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {

			[774] = {enable=true, self=true,},      -- 回春術
			[1079] = {enable=true, self=true,},     -- Rip / 撕扯
			[1822] = {enable=true, self=true,},     -- Rake / 掃擊
			[5570] = {enable=true, self=true,},     -- Insect Swarm / 蟲群
			[8921] = {enable=true, self=true,},     -- Moonfire / 月火術
			[33763] = {enable=true, self=true,},    -- 生命之花
			[93402] = {enable=true, self=true,},    -- Moonfire / 日炎術

			[155625] = {enable=true, self=true,},	-- 月火術(月之鼓舞)
			[164812] = {enable=true, self=true,},	-- 月火術(月能)(平衡專精)
			[164815] = {enable=true, self=true,},	-- 日炎術(日能)(平衡專精)
			[192090] = {enable=true, self=true,},	-- 痛擊
			[155722] = {enable=true, self=true,},	-- 掃擊
			[197637] = {enable=true, self=true,},	-- 星之活化
			[202347] = {enable=true, self=true,},	-- 星光閃焰

		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[17116] = {enable=true,},   -- 自然迅捷
			[18562] = {enable=true,},   -- 迅癒
			[29166] = {enable=true,},   -- 啟動
			[48438] = {enable=true,},   -- 野性痊癒
			[78674] = {enable=true,},   -- 星湧術

			[5215] = {enable=true,},   	-- 潛行
			[6807] = {enable=true,},   	-- 槌擊
			[22812] = {enable=true,},   -- 樹皮術
			[22842] = {enable=true,},   -- 狂暴恢復
			[33917] = {enable=true,},   -- 割碎
			[52610] = {enable=true,},   -- 兇蠻咆哮
			[61336] = {enable=true,},   -- 求生本能
			[77758] = {enable=true,},   -- 痛擊
			[78675] = {enable=true,},   -- 太陽光束
			[102280] = {enable=true,},  -- 獸性位移
			[1850] = {enable=true,},   	-- 突進
			[80313] = {enable=true,},   	-- 粉碎
			[102543] = {enable=true,},   	-- 化身:叢林之王
			[102793] = {enable=true,},   	-- 厄索之旋
			[106951] = {enable=true,},   	-- 狂暴
			[155835] = {enable=true,},   	-- 針刺毛皮
			[192081] = {enable=true,},   	-- 鋼鐵毛皮
			[192083] = {enable=true,},   	-- 厄索印記
			[194223] = {enable=true,},   	-- 星穹連線
			[202028] = {enable=true,},   	-- 兇蠻刈殺("刈"音同"意")
			[204066] = {enable=true,},   	-- 月之光
		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Hunter / 獵人
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_HUNTER] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[3045] = {enable=true,},    -- 急速射擊
			[34477] = {enable=true,},   -- 誤導
			[53257] = {enable=true,},   -- 眼鏡蛇之擊
			[61684] = {enable=true,},   -- 突進(獵人寵物)
			[70728] = {enable=true,},   -- 攻擊弱點
			[95712] = {enable=true,},   -- X光瞄準
			[118455] = {enable=true,},   -- 獸劈斬
			[185791] = {enable=true,},   -- 野性呼喚
			[186254] = {enable=true,},   -- 狂野怒火
			[186265] = {enable=true,},   -- 巨龜守護
			[193530] = {enable=true,},   -- 野性守護
			[217200] = {enable=true,},   -- 凶暴狂亂
			[186257] = {enable=true,},   -- 野性守護

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {

		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[5116] = {enable=true,self=true,},   	-- 震盪射擊
			[54680] = {enable=true,self=true,},   	-- 暴猛撕咬(奇特技能)
			[131894] = {enable=true,self=false,},   -- 黑鴉獵殺
			[132951] = {enable=true,self=false,},   -- 照明彈
			[117405] = {enable=true,self=false,},   -- 禁錮射擊


		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[17253] = {enable=true,},     -- 撕咬(基礎攻擊)
			[16827] = {enable=true,},     -- 爪擊(基礎攻擊)
			[61684] = {enable=true,},     -- 突進(寵物)
			[54644] = {enable=true,},     -- 冰息術(奇美拉)
			[92380] = {enable=true,},     -- 霜暴之息(奇美拉)
			[160065] = {enable=true,},     -- 裂筋(異種蟲族)
			[90361] = {enable=true,},     -- 心靈治療(靈獸)
			[54680] = {enable=true,},     -- 暴猛撕咬(魔暴龍)
			[781] = {enable=true,},     	-- 逃脫
			[217200] = {enable=true,},     -- 凶暴狂亂
			[109304] = {enable=true,},     -- 心曠神怡
			[147362] = {enable=true,},     -- 駁火反擊
			[55709] = {enable=true,},     -- 鳳凰之心
			[131894] = {enable=true,},     -- 黑鴉獵殺
			[109248] = {enable=true,},     -- 禁錮射擊
			[19574] = {enable=true,},     -- 狂野怒火
			[193530] = {enable=true,},     -- 野性守護
			[186257] = {enable=true,},     -- 獵豹守護


		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Mage / 法師
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_MAGE] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[12042] = {enable=true,},   -- 秘法強化
			[12051] = {enable=true,},   -- 喚醒
			[36032] = {enable=true,},   -- Arcane Blast / 奧衝堆疊
			[44544] = {enable=true,},   -- Fingers of Frost / 冰霜之指
			[48108] = {enable=true,},   -- Hot Streak / 焦炎之痕
			[57761] = {enable=true,},   -- Brain Freeze / 腦部凍結
			[64343] = {enable=true,},   -- 衝擊
			[79683] = {enable=true,},   -- Missile Barrage! / 秘法飛彈!
			[87023] = {enable=true,},   -- 燒灼
			[116257] = {enable=true,},   -- 塑能師之能 (喚醒)
		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[12654] = {enable=true, self=true,},    -- 點燃
			[22959] = {enable=true, self=true,},    -- 火焰重擊
			[31589] = {enable=true, self=true,},    -- Slow / 減速術
			[44457] = {enable=true, self=true,},    -- Living Bomb / 活體爆彈
			},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[122] = {enable=true,},     -- 冰霜新星
			[1953] = {enable=true,},    -- 閃現
			[12042] = {enable=true,},   -- 秘法強化
			[12043] = {enable=true,},   -- 氣定神閒
			[12051] = {enable=true,},   -- 喚醒
			[44572] = {enable=true,},   -- 極度冰凍
			[45438] = {enable=true,},   -- 寒冰屏障
		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Paladin / 聖騎士
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_PALADIN] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[498] = {enable=true,},     -- 聖佑術
			[642] = {enable=true,},     -- 聖盾術
			[20925] = {enable=true,},   -- 崇聖護盾
			[31821] = {enable=true,},   -- 虔誠光環
			[31842] = {enable=true,},   -- 神恩術
			[31850] = {enable=true,},   -- 忠誠防衛者
			[31884] = {enable=true,},   -- 復仇之怒
			[53657] = {enable=true,},   -- 純潔審判
			[59578] = {enable=true,},   -- 戰爭藝術
			[84963] = {enable=true,},   -- 異端審問
			[86659] = {enable=true,},   -- 遠古諸王守護者(坦)
			[86698] = {enable=true,},   -- 遠古諸王守護者(DD)
			[90174] = {enable=true,},	-- 神聖意圖
			[105809] = {enable=true,},   -- 神聖復仇者
			[114163] = {enable=true,},	-- 永恆之火
			[114637] = {enable=true,},	-- 榮耀壁壘
			[121467] = {enable=true,},	-- 雪白之盾
			[132403] = {enable=true,},	-- 公正之盾(減傷)
		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[853] = {enable=true, self=true,},      -- 制裁之錘
			[10326] = {enable=true, self=true,},    -- 退邪術
			[20066] = {enable=true, self=true,},    -- 懺悔
			[31803] = {enable=true, self=true,},    -- 譴責
			[81298] = {enable=true, self=true},		-- 奉獻
			[81326] = {enable=true, self=false},	-- 物理易傷
			[110300] = {enable=true, self=true,},	-- 罪之重擔
			[114163] = {enable=true, self=true,},	-- 永恆之火
			[114916] = {enable=true, self=true,},	-- 死刑宣判
		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[498] = {enable=true,},     -- 聖佑術
			[853] = {enable=true,},     -- 制裁之鎚
			[20066] = {enable=true,},   -- 懺悔
			[20925] = {enable=true,},   -- 崇聖護盾
			[28730] = {enable=true,},   -- 奧流之術
			[54428] = {enable=true,},   -- 神性祈求
			[96231] = {enable=true,},   -- 責難
			[114157] = {enable=true,},   -- 死刑宣判
			[114158] = {enable=true,},   -- 聖光之錘
			[114165] = {enable=true,},   -- 神聖稜石
			[115750] = {enable=true,},   -- 盲目之光
		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Priest / 牧師
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_PRIEST] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[17] = {enable=true,},      			-- 真言術:盾
			[6788] = {enable=true,},    			-- 虛弱靈魂
			[47585] = {enable=true,},  			 	-- 影散
			[81782] = {enable=true,},   			-- 真言術:壁
			[87160] = {enable=true,overgrow=3},		-- 黑暗奔騰
			[124430] = {enable=true,},   			-- 幽暗洞察
			[194249] = {enable=true,},   			-- 虛無形態
			[197937] = {enable=true,},   			-- 瘋狂殘念
			[205372] = {enable=true,overgrow=5},   	-- 虛無射線
			overgr

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[139] = {enable=true, self=true,},      -- 恢復
			[589] = {enable=true, self=true,},      -- Shadow Word: Pain / 暗言術:痛
			[2944] = {enable=true, self=true,},     -- Devouring Plague / 噬靈瘟疫
			[6788] = {enable=true, self=true,},     -- Weakened Soul / 虛弱靈魂
			[34914] = {enable=true, self=true,},    -- Vampiric Touch / 吸血之觸
			[47753] = {enable=true, self=true,},    -- 神禦之盾
			[217673] = {enable=true, self=true,overgrow=3},    -- 神禦之盾

		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[17] = {enable=true,},      -- 真言術:盾
			[10060] = {enable=true,},   -- 注入能量
			[32379] = {enable=true,},   -- 暗言術:死
			[33206] = {enable=true,},   -- 痛苦鎮壓
			[34433] = {enable=true,},   -- 暗影惡魔
			[47540] = {enable=true,},   -- 懺悟
			[47585] = {enable=true,},   -- 影散
			[81700] = {enable=true,},   -- 大天使
			[88684] = {enable=true,},   -- 聖言術:寧
			[89485] = {enable=true,},   -- 心靈專注
			[126172] = {enable=true,},   -- 脈輪運轉
			[123040] = {enable=true,},   -- 屈心魔
			[205385] = {enable=true,},   -- 暗影暴擊
			[205448] = {enable=true,},   -- 虛無箭
			[228260] = {enable=true,},   -- 虛無爆發
			[8092] = {enable=true,},   	-- 心靈震爆
			[15487] = {enable=true,},   -- 沉默
			[213634] = {enable=true,},   -- 驅淨疾病
			[528] = {enable=true,},   -- 驅散魔法
			[32375] = {enable=true,},   -- 群體驅散
			[205369] = {enable=true,},   -- 心靈炸彈
			[15286] = {enable=true,},   -- 吸血鬼的擁抱


		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Rogue / 盜賊
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_ROGUE] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[5171] = {enable=true,},    -- 切割
			[1966] = {enable=true,},    -- 佯攻
			[57934] = {enable=true,},   -- 偷天換日
			[59628] = {enable=true,},   -- 偷天換日
			[58427] = {enable=true,},   -- 極限殺戮
			[84590] = {enable=true,},   -- 致命殺陣
		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {

		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[1943] = {enable=true, self=true,},     -- 割裂
			[84617] = {enable=true, self=true,},    -- 揭底之擊

		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[65961] = {enable=true,},   -- 暗影披風
			[79140] = {enable=true,},   -- 宿怨
		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Shaman / 薩滿
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_SHAMAN] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[192106] = {enable=true,},	-- 閃電之盾
			[16166] = {enable=true,},	-- 精通元素
			[53390] = {enable=true,},	-- 治療之潮
			[73685] = {enable=true,},	-- 釋放大地生命
			[79206] = {enable=true,},	-- 靈行者之賜
			[105763] = {enable=true,},	-- 心靈激勵 (法力之潮)
			[114050] = {enable=true,},	-- 卓越術（元素）
			[114051] = {enable=true,},	-- 卓越術（增強）
			[114052] = {enable=true,},	-- 卓越術（恢復）
			[114893] = {enable=true,},	-- 石之壁壘
			[118522] = {enable=true,},	-- 元素衝擊
			[194084] = {enable=true,},	-- 火舌
			[195222] = {enable=true,},	-- 風暴鞭笞
			[196834] = {enable=true,},	-- 冰封打擊
			[201898] = {enable=true,},	-- 風之歌
			[215864] = {enable=true,},	-- 時雨

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {

			[51514] = {enable=true, self=true,},	-- 妖術

		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[16166] = {enable=true,},	-- 精通元素
			[51505] = {enable=true,},	-- 熔岩爆發
			[61295] = {enable=true,},	-- 激流
			[73920] = {enable=true,},	-- 治癒之雨
			[79206] = {enable=true,},	-- 靈行者之賜
			[98008] = {enable=true,},	-- 靈魂連結圖騰
			[108270] = {enable=true,},	-- 石之壁壘圖騰
			[108271] = {enable=true,},	-- 星界轉移
			[108280] = {enable=true,},	-- 療癒之潮圖騰
			[108285] = {enable=true,},	-- 元素呼喚
			[2825] = {enable=true,},	-- 嗜血術
			[51490] = {enable=true,},	-- 雷霆風暴
			[51514] = {enable=true,},	-- 妖術
			[17364] = {enable=true,},	-- 風暴打擊
			[51533] = {enable=true,},	-- 野性之魂
			[51886] = {enable=true,},	-- 淨化靈魂
			[57994] = {enable=true,},	-- 削風術
			[58875] = {enable=true,},	-- 幽魂步伐
			[60103] = {enable=true,},	-- 熔岩爆擊
			[187874] = {enable=true,},	-- 閃電轟擊
			[193786] = {enable=true,},	-- 石化打擊
			[193796] = {enable=true,},	-- 火舌打擊
			[196834] = {enable=true,},	-- 冰封打擊
			[215864] = {enable=true,},	-- 時雨


		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Warlock / 術士
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_WARLOCK] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[18095] = {enable=true,},   -- 夜暮
			[19028] = {enable=true,},   -- 靈魂鏈結
			[34939] = {enable=true,},   -- 反衝
			[47283] = {enable=true,},   -- Empowered Imp / 強力小鬼
			[63158] = {enable=true,},   -- 屠虐
			[63167] = {enable=true,},   -- 屠虐
			[71165] = {enable=true,},   -- 熔火之心
			[85383] = {enable=true,},   -- 強化靈魂之火
			[89937] = {enable=true,},   -- 魔化火光
		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[172] = {enable=true, self=true,},      -- Corruption / 腐蝕術
			[348] = {enable=true, self=true,},      -- Immolate / 獻祭
			[686] = {enable=true, self=true,},      -- 末日災厄
			[603] = {enable=true, self=true,},      -- 暗影箭
			[980] = {enable=true, self=true,},      -- 痛苦災厄
			[1490] = {enable=true, self=true,},     -- Curse of the Elements / 元素詛咒
			[29722] = {enable=true, self=true,},    -- 燒盡
			[30108] = {enable=true, self=true,},    -- 痛苦動盪
			[48181] = {enable=true, self=true,},    -- 蝕魂術
			[50796] = {enable=true, self=true,},    -- 混沌箭
			[80240] = {enable=true, self=true,},    -- 浩劫災厄
			[86000] = {enable=true, self=true,},    -- 古爾丹詛咒
		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[17962] = {enable=true,},   -- 焚燒
			[59672] = {enable=true,},   -- 惡魔化身
			[71165] = {enable=true,},   -- 熔火之心
		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Warrior / 戰士
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_WARRIOR] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[184362] = {enable=true,self=true},					--狂怒
			[202539] = {enable=true,self=true,overgrow=3},		--狂亂
			[206333] = {enable=true,self=true,overgrow=6},		--血腥體驗
			[215572] = {enable=true,self=true},					--飛沫戰狂
			[46924] = {enable=true,self=true},					--劍刃風暴
			[107574] = {enable=true,self=true},					--巨像化身
			[184364] = {enable=true,self=true},					--狂怒恢復
			[85739] = {enable=true,self=true},					--削骨斬肉
			[118038] = {enable=true,self=true},					--劍下亡魂
			[207982] = {enable=true,self=true,overgrow=3},		--集中怒氣
			[188923] = {enable=true,self=true,overgrow=2},		--順劈斬
			[23920] = {enable=true,self=true},					--法術反射
			[125565] = {enable=true,self=true},					--挫志怒吼
			[871] = {enable=true,self=true},					--盾牆
			[202164] = {enable=true,self=true},					--英勇躍擊+70%跑速

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[5246] = {enable=true, self=false},				-- 破膽怒吼
			[12323] = {enable=true, self=true},    			-- 刺耳怒吼
			[132169] = {enable=true,self=false},    		-- 暴風怒擲
			[132168] = {enable=true,self=false},    		-- 震攝波
			[113344] = {enable=true,self=true},    			-- 浴血
			[46924] = {enable=true,self=false},    			-- 劍刃風暴
			[118038] = {enable=true,self=false},			--劍下亡魂
			[1715] = {enable=true,self=true},				--斷筋
			[208086] = {enable=true,self=true},				--千鈞潰擊
			[772] = {enable=true,self=true},				--撕裂
			[115804] = {enable=true,self=true},				--致死重傷
			[215537] = {enable=true,self=true},				--創傷
			[147833] = {enable=true,self=true},				--阻擾
			[23920] = {enable=true,self=false},				--法術反射
			[871] = {enable=true,self=false},				--盾牆
			[12975] = {enable=true,self=false},				--破釜沉舟


		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[1719] = {enable=true},    		--戰鬥狂嘯
			[12292] = {enable=true},    	--浴血
			[18499] = {enable=true},    	--狂暴之怒
			[107574] = {enable=true},    	--巨像化身
			[184367] = {enable=true},    	--暴怒
			[46924] = {enable=true},    	--劍刃風暴
			[100] = {enable=true},    		--衝鋒
			[6544] = {enable=true},    		--英勇躍擊
			[6552] = {enable=true},    		--拳擊
			[85288] = {enable=true},    	--狂怒之擊
			[23881] = {enable=true},    	--嗜血
			[5308] = {enable=true},    		--斬殺
			[163201] = {enable=true},    	--斬殺(武戰)
			[107570] = {enable=true},    	--暴風怒擲
			[46968] = {enable=true},    	--震攝波
			[118038] = {enable=true},		--劍下亡魂
			[34428] = {enable=true},		--勝利衝擊
			[12294] = {enable=true},		--致死打擊
			[845] = {enable=true},			--順劈斬
			[167105] = {enable=true},		--千鈞潰擊
			[207982] = {enable=true},		--集中怒氣
			[152277] = {enable=true},		--劫毀旋刃(武戰)(招架+30%/12s)
			[228920] = {enable=true},		--劫毀旋刃(防戰)(招架+30%/12s)
			[198304] = {enable=true},		--攔截
			[202168] = {enable=true},		--勝利在望
			[23920] = {enable=true},		--法術反射
			[1160] = {enable=true},			--挫志怒吼
			[871] = {enable=true},			--盾牆
			[6572] = {enable=true},			--復仇
			[2565] = {enable=true},			--盾牌格檔
			[23922] = {enable=true},		--盾牌猛擊
			[6343] = {enable=true},			--雷霆一擊
			[207982] = {enable=true},		--集中怒氣(武戰致死打擊增傷)
			[204488] = {enable=true},		--集中怒氣(防戰盾牌猛擊增傷)
			[12975] = {enable=true},		--破釜沉舟

		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Monk / 武僧
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_MONK] = {
		-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[115175] = {enable=true,},   -- 舒和之霧
			[119611] = {enable=true,},   -- 回生迷霧
			[120954] = {enable=true,},   -- 石形絕釀

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
			[115078] = {enable=true, self=true,},   -- 點穴
			[115175] = {enable=true, self=true,},   -- 舒和之霧
			[119611] = {enable=true, self=true,},   -- 回生迷霧

		},
		-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[101545] = {enable=true,},   -- 翔龍腳
			[109132] = {enable=true,},   -- 迅空翻
			[113656] = {enable=true,},   -- 狂拳連打
			[115008] = {enable=true,},   -- 真氣飛龍穿
			[115078] = {enable=true,},   -- 點穴
			[115080] = {enable=true,},   -- 幽冥掌
			[115098] = {enable=true,},   -- 真氣波
			[115151] = {enable=true,},   -- 回生迷霧
			[115203] = {enable=true,},   -- 石形絕釀
			[115288] = {enable=true,},   -- 凝神絕釀
			[115399] = {enable=true,},   -- 真氣絕釀
			[116705] = {enable=true,},   -- 天矛鎖喉手
			[116847] = {enable=true,},   -- 飛玉疾風
			[119381] = {enable=true,},   -- 掃葉腿
			[119392] = {enable=true,},   -- 鐵牛衝鋒波
			[122278] = {enable=true,},   -- 卸勁訣
			[122470] = {enable=true,},   -- 乾坤挪移
			[122783] = {enable=true,},   -- 祛魔訣
			[123904] = {enable=true,},   -- 召喚白虎雪怒
		},
		-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}
--------------------------------------------------------------------------------
-- DemonHunter / 惡魔獵人
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_DEMONHUNTER]	= {
	-- Primary Alert / 本職業提醒區
		["ITEMS"] = {
			[163073] = {enable=true,self=true},	--惡魔之魂
			[188501] = {enable=true},				--靈視

		},
		-- Alternate Alert / 本職業額外提醒區
		["ALTITEMS"] = {
		},
		-- Target Alert / 目標提醒區
		["TARITEMS"] = {
		},
	-- Spell Cooldown Alert / 本職業技能CD區
		["SCDITEMS"] = {
			[131347] = {enable=true},				--
			[162794] = {enable=true},				--
			[188501] = {enable=true},				--
			[192611] = {enable=true},				--
			[195072] = {enable=true},				--
			[202644] = {enable=true},				--
			[178740] = {enable=true},				--
			[185245] = {enable=true},				--
			[187827] = {enable=true},				--
			[189110] = {enable=true},				--
			[203720] = {enable=true},				--
			[204021] = {enable=true},				--
			[204157] = {enable=true},				--
			[204596] = {enable=true},				--
			[207684] = {enable=true},				--
			[218256] = {enable=true},				--

		},
	-- GroupEvent Alert / 本職業條件技能區
		["GRPITEMS"] = {
		},
	}


--------------------------------------------------------------------------------
-- Other / 跨職業共通區 (包含自身BUFF/DEBUFF+目標BUFF/DEBUFF)
--------------------------------------------------------------------------------
	EADef_Items[EA_CLASS_OTHER] = {
		[80353] = {["enable"] = true,},
		[64901] = {["enable"] = true,["name"] = "希望象徵",},
		[29166] = {["enable"] = true,},
		[102342] ={["enable"] = true,["name"] = "鐵樹皮術",},
		[64844] = {["enable"] = true,["name"] = "神聖禮頌",},
		[53563] = {["enable"] = true,["name"] = "聖光信標",},
		[90355] = {["enable"] = true,},
		[2825] = {["enable"] = true,["name"] = "嗜血",},
		[10060] = {["enable"] = true,},
		[81782] = {["enable"] = true,},
		[33206] = {["enable"] = true,},
		[32182] = {["enable"] = true,},
		[98007] = {["enable"] = true,},
		[1022] = {["enable"] = true,["name"] = "保護祝福",self=false},
		[6940] = {["enable"] = true,["name"] = "犧牲祝福",self=false},
		[47788] = {["enable"] = true,["name"] = "守護聖靈",self=false},
		[1850] = {["enable"] = true,["name"] = "突進",self=false},
		[146555] = {["enable"] = true,["name"] = "憤怒之鼓",self=false},
		[215864] = {["enable"] = true,["name"] = "時雨",self=false},
		[159234] = {enable=true,self=true},  	-- 自身BUFF:雷霆王印記
		[186265] = {enable=true,self=false,},   -- 目標BUFF:巨龜守護
		[48707] = {enable=true,self=false,},   	-- 目標BUFF:反魔法護罩
		[163505] = {enable=true,self=false,},  	-- 目標DEBUFF:掃擊(昏迷4秒)
		[127797] = {enable=true, self=false,},	-- 目標DEBUFF:厄索之旋
		[5211] = {enable=true, self=false,},	-- 目標DEBUFF:猛力重擊
		[33786] = {enable=true, self=false,},	-- 目標DEBUFF:颶風術(榮譽天賦)
		[5211] = {enable=true,self=false},  	-- 目標DEBUFF:猛力重擊
		[45438] = {enable=true,self=false},  	-- 目標BUFF:寒冰屏障
		[82691] = {enable=true,self=false},  	-- 目標DEBUFF:霜之環
		[28271] = {enable=true,self=false},  	-- 目標DEBUFF:變形術
		[228600] = {enable=true,self=false},  	-- 目標DEBUFF:冰川長槍

	}



end
