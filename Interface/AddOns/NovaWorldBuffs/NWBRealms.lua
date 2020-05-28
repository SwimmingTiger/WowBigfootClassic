--------------------------------------
---NovaWorldBuffs classic realm list--
--------------------------------------

--Only need layered realms here for now.
NWB.usRealms = {
	--["Arugal"] = true,
	--["Benediction"] = true,
	--["Earthfury"] = true,
	--["Faerlina"] = true,
	--["Fairbanks"] = true,
	--["Herod"] = true,
	--["Pagle"] = true,
	--["Sulfuras"] = true,
	--["Whitemane"] = true,
}

NWB.euRealms = {
	["Auberdine"] = true,
	["Ashbringer"] = true,
	["Firemaw"] = true,
	["Flamegor"] = true,
	["Gehennas"] = true,
	["Golemagg"] = true,
	["Mograine"] = true,
	["Sulfuron"] = true,
	["Venoxis"] = true,
	["Пламегор"] = true,
}

NWB.krRealms = {
	["로크홀라"] = true,
	["얼음피"] = true,
	["힐스브래드"] = true,
	["라그나로스"] = true,
	["소금 평원"] = true,
}

NWB.twRealms = {
	["伊弗斯"] = true,
	["瑪拉頓"] = true,
}

NWB.cnRealms = {
	["匕首岭"] = true,
	["乌洛克"] = true,
	["厄运之槌"] = true,
	["巴罗夫"] = true,
	["无尽风暴"] = true,
	["无畏"] = true,
	["木喉要塞"] = true,
	["比格沃斯"] = true,
	["比斯巨兽"] = true,
	["水晶之牙"] = true,
	["火锤"] = true,
	["加丁"] = true,
	["巨人追猎者"] = true,
	["巨龙沼泽"] = true,
	["巨龙追猎者"] = true,
	["布劳缪克丝"] = true,
	["布鲁"] = true,
	["弗莱拉斯"] = true,
	["末日之刃"] = true,
	["龙之召唤"] = true,
	["龙牙"] = true,
	["伊森迪奥斯"] = true,
	["伦鲁迪洛尔"] = true,
	["光芒"] = true,
	["吉兹洛克"] = true,
	["安娜丝塔丽"] = true,
	["灰烬使者"] = true,
	["艾隆纳亚"] = true,
	["克罗米"] = true,
	["希尔盖"] = true,
	["怀特迈恩"] = true,
	["沙尔图拉"] = true,
	["沙顶"] = true,
	["灵风"] = true,
	["狂野之刃"] = true,
	["辛洛斯"] = true,
	["辛迪加"] = true,
	["迈克斯纳"] = true,
	["卓越"] = true,
	["审判"] = true,
	["帕奇维克"] = true,
	["拉姆斯登"] = true,
	["法尔班克斯"] = true,
	["法拉克斯"] = true,
	["法琳娜"] = true,
	["觅心者"] = true,
	["阿什坎迪"] = true,
	["阿拉希盆地"] = true,
	["阿鲁高"] = true,
	["哈霍兰"] = true,
	["奎尔塞拉"] = true,
	["娅尔罗"] = true,
	["怒炉"] = true,
	["狮心"] = true,
	["祈福"] = true,
	["范克瑞斯"] = true,
	["范克瑞斯"] = true,
	["范沃森"] = true,
	["埃提耶什"] = true,
	["席瓦莱恩"] = true,
	["神谕林地"] = true,
	["秩序之源"] = true,
	["诺克赛恩"] = true,
	["诺格弗格"] = true,
	["骨火"] = true,
	["曼多基尔"] = true,
	["维克尼拉斯"] = true,
	["维克托"] = true,
	["维克洛尔"] = true,
	["维希度斯"] = true,
	["莫格莱尼"] = true,
	["奥罗"] = true,
	["奥金斧"] = true,
	["寒冰之王"] = true,
	["寒脊山小径"] = true,
	["湖畔镇"] = true,
	["黑曜石之锋"] = true,
	["塞卡尔"] = true,
	["塞雷布拉斯"] = true,
	["毁灭之刃"] = true,
	["萨弗拉斯"] = true,
	["萨弗隆"] = true,
	["雷德"] = true,
	["雷霆之击"] = true,
	["碧玉矿洞"] = true,
	["碧空之歌"] = true,
	["赫洛德"] = true,
	["德姆塞卡尔"] = true,
	["震地者"] = true,
	["霜语"] = true,
}

--[[function NWB:setLayered()
	--This needs to be changed to a table later.
	--TW realms.
	if (NWB.realm == "伊弗斯" or NWB.realm == "瑪拉頓"
			--CN realms (so many realms and all have layering apparently, wtf?).
			or NWB.realm == "匕首岭" or NWB.realm == "乌洛克" or NWB.realm == "厄运之槌"  or NWB.realm == "巴罗夫"
			or NWB.realm == "无尽风暴" or NWB.realm == "无畏" or NWB.realm == "木喉要塞" or NWB.realm == "比格沃斯"
			or NWB.realm == "比斯巨兽" or NWB.realm == "水晶之牙" or NWB.realm == "火锤" or NWB.realm == "加丁"
			or NWB.realm == "巨人追猎者" or NWB.realm == "巨龙沼泽" or NWB.realm == "巨龙追猎者" or NWB.realm == "布劳缪克丝"
			or NWB.realm == "布鲁" or NWB.realm == "弗莱拉斯" or NWB.realm == "末日之刃" or NWB.realm == "龙之召唤"
			or NWB.realm == "龙牙" or NWB.realm == "伊森迪奥斯" or NWB.realm == "伦鲁迪洛尔" or NWB.realm == "光芒"
			or NWB.realm == "吉兹洛克" or NWB.realm == "安娜丝塔丽" or NWB.realm == "灰烬使者" or NWB.realm == "艾隆纳亚"
			or NWB.realm == "克罗米" or NWB.realm == "希尔盖" or NWB.realm == "怀特迈恩" or NWB.realm == "沙尔图拉"
			or NWB.realm == "沙顶" or NWB.realm == "灵风" or NWB.realm == "狂野之刃" or NWB.realm == "辛洛斯"
			or NWB.realm == "辛迪加" or NWB.realm == "迈克斯纳" or NWB.realm == "卓越" or NWB.realm == "审判"
			or NWB.realm == "帕奇维克" or NWB.realm == "拉姆斯登" or NWB.realm == "法尔班克斯" or NWB.realm == "法拉克斯"
			or NWB.realm == "法琳娜" or NWB.realm == "觅心者" or NWB.realm == "阿什坎迪" or NWB.realm == "阿拉希盆地"
			or NWB.realm == "阿鲁高" or NWB.realm == "哈霍兰" or NWB.realm == "奎尔塞拉" or NWB.realm == "娅尔罗"
			or NWB.realm == "怒炉" or NWB.realm == "狮心" or NWB.realm == "祈福" or NWB.realm == "范克瑞斯"
			or NWB.realm == "范克瑞斯" or NWB.realm == "范沃森" or NWB.realm == "埃提耶什" or NWB.realm == "席瓦莱恩"
			or NWB.realm == "神谕林地" or NWB.realm == "秩序之源" or NWB.realm == "诺克赛恩" or NWB.realm == "诺格弗格"
			or NWB.realm == "骨火" or NWB.realm == "曼多基尔" or NWB.realm == "维克尼拉斯" or NWB.realm == "维克托"
			or NWB.realm == "维克洛尔" or NWB.realm == "维希度斯" or NWB.realm == "莫格莱尼" or NWB.realm == "奥罗"
			or NWB.realm == "奥金斧" or NWB.realm == "寒冰之王" or NWB.realm == "寒脊山小径" or NWB.realm == "湖畔镇"
			or NWB.realm == "黑曜石之锋" or NWB.realm == "塞卡尔" or NWB.realm == "塞雷布拉斯" or NWB.realm == "毁灭之刃"
			or NWB.realm == "萨弗拉斯" or NWB.realm == "萨弗隆" or NWB.realm == "雷德" or NWB.realm == "雷霆之击"
			or NWB.realm == "碧玉矿洞" or NWB.realm == "碧空之歌" or NWB.realm == "赫洛德" or NWB.realm == "德姆塞卡尔"
			or NWB.realm == "震地者" or NWB.realm == "霜语"
			--US/OCE layered realms.
			or NWB.realm == "Arugal" or NWB.realm == "Benediction" or NWB.realm == "Earthfury" or NWB.realm == "Faerlina"
			or NWB.realm == "Fairbanks" or NWB.realm == "Herod" or NWB.realm == "Pagle" or NWB.realm == "Sulfuras"
			or NWB.realm == "Whitemane"
			--EU layered realms.
			or NWB.realm == "Auberdine" or NWB.realm == "Ashbringer" or NWB.realm == "Firemaw" or NWB.realm == "Flamegor"
			or NWB.realm == "Gehennas" or NWB.realm == "Golemagg" or NWB.realm == "Mograine" or NWB.realm == "Sulfuron"
			or NWB.realm == "Venoxis" or NWB.realm == "Пламегор"
			--KR layered realms.
			or NWB.realm == "로크홀라" or NWB.realm == "얼음피" or NWB.realm == "힐스브래드" or NWB.realm == "라그나로스"
			or NWB.realm == "소금 평원") then
		NWB.isLayered = true;
	end
end]]