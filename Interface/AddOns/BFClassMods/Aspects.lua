-------------------
-- AspectBar - 守护动作条
-------------------
local Addon = LibStub("AceAddon-3.0"):GetAddon("BFClassMod")
if not Addon then return end

local A = Addon:NewModule("AspectBar","AceEvent-3.0","AceHook-3.0","AceTimer-3.0")
if not A then return end
--------------
--localization
--------------

local L = {}
setmetatable(L,Addon.localMt)

if GetLocale()=='zhTW' then
	L["灵猴守护"] = "靈猴守護"	
	L["雄鹰守护"] = "雄鷹守護"	
	L["龙鹰守护"] = "龍鷹守護"	
	L["猎豹守护"] = "獵豹守護"	
	L["豹群守护"] = "豹群守護"	
	L["野兽守护"] = "野獸守護"	
	L["野性守护"] = "野性守護"	
	L["蝰蛇守护"] = "蝮蛇守護"	
	
	L["法师护甲"] = "魔甲術"	
	L["冰甲术"] = "霜甲術"	
	L["熔岩护甲"] = "熔火護甲"	
	L["奥术光辉"] = ""	
	L["奥术智慧"] = "秘法光輝"	

	L["召唤餐桌"] = "餐點儀式"
	L["造餐术"] = "召喚餐點"
	
	L["左键 - "] = "左鍵 - "	
	L["右键 - "] = "右鍵 - "
	L["传送：埃索达"] = "傳送:艾克索達"
	L["传送：塞拉摩"] = "傳送:塞拉摩"
	L["传送：奥格瑞玛"] = "傳送:奧格瑪"
	L["传送：幽暗城"] = "傳送:幽暗城"
	L["传送：斯通纳德"] = "傳送:斯通納德"
	L["传送：暴风城"] = "傳送:暴風城"
	L["传送：沙塔斯"] = "傳送:撒塔斯"
	L["传送：达拉然"] = "傳送:達拉然"
	L["传送：达纳苏斯"] = "傳送:達納蘇斯"
	L["传送：雷霆崖"] = "傳送:雷霆崖"
	L["传送：铁炉堡"] = "傳送:鐵爐堡"
	L["传送：银月城"] = "傳送:銀月城"
	
	L["传送门：埃索达"] = "傳送門:艾克索達"
	L["传送门：塞拉摩"] = "傳送門:塞拉摩"
	L["传送门：奥格瑞玛"] = "傳送門:奧格瑪"
	L["传送门：幽暗城"] = "傳送門:幽暗城"
	L["传送门：斯通纳德"] = "傳送門:斯通納德"
	L["传送门：暴风城"] = "傳送門:暴風城"
	L["传送门：沙塔斯"] = "傳送門:撒塔斯"
	L["传送门：达拉然"] = "傳送門:達拉然"
	L["传送门：达纳苏斯"] = "傳送門:達納蘇斯"
	L["传送门：雷霆崖"] = "傳送門:雷霆崖"
	L["传送门：铁炉堡"] = "傳送門:鐵爐堡"
	L["传送门：银月城"] = "傳送門:銀月城"
	
	L["恶魔变形"] = "惡魔化身"
	L["恶魔支配"] = "惡魔支配"
	L["召唤恶魔卫士"] = "召喚惡魔守衛"
	L["召唤地狱猎犬"] = "召喚惡魔獵犬"
	L["召唤魅魔"] = "召喚魅魔"
	L["召唤虚空行者"] = "召喚虛無行者"
	L["召唤小鬼"] = "召喚小鬼"

	L["制造治疗石"] = "製造治療石"
	L["制造灵魂石"]	= "製造靈魂石"
	L["制造法术石"]	= "製造法術石"	
	L["制造火焰石"]	= "製造火焰石"	
	L["召唤仪式"] = "召喚儀式"
	L["灵魂仪式"] = "靈魂儀式"

	L["普通召唤宠物"] ="普通召喚寵物"
	L["快速召唤宠物"] ="快速召喚寵物"
	


	L["潜行"] = "潛行"
	L["暗影之舞"] = "暗影之舞"
	L["上毒主手"] = "上毒主手"
	L["上毒副手"] = "上毒副手"	
	L["召唤"] = "召喚"
	L["毒药"] = "毒藥"
	L["药膏"] = "藥膏"
	L["施放技能"] = "施放技能"
	L["展开菜单"] = "展開菜單"
elseif GetLocale()=="enUS" then
	L["灵猴守护"] = ""	
	L["雄鹰守护"] = "Aspect of the Hawk"	
	L["龙鹰守护"] = ""	
	L["猎豹守护"] = "Aspect of the Cheetah"	
	L["豹群守护"] = "Aspect of the Pack"	
	L["野兽守护"] = ""	
	L["野性守护"] = "Aspect of the Wild"	
	L["蝰蛇守护"] = "Aspect of the Fox"	
	
	L["法师护甲"] = "Mage Armor"	
	L["冰甲术"] = "Frost Armor"	
	L["熔岩护甲"] = "Molten Armor"	
	L["奥术光辉"] = "Arcane Brilliance"	
	L["奥术智慧"] = "Arcane Brilliance"	
	
	L["召唤餐桌"] = "Ritual of Refreshment"
	L["造餐术"] = "Conjure Refreshment"
	
	L["左键 - "] = "Left Click - "	
	L["右键 - "] = "Right Click - "
	L["传送：埃索达"] = "Teleport: Exodar"
	L["传送：塞拉摩"] = "Teleport: Theramore"
	L["传送：奥格瑞玛"] = "Teleport: Orgrimmar"
	L["传送：幽暗城"] = "Teleport: Undercity"
	L["传送：斯通纳德"] = "Teleport: Stonard"
	L["传送：暴风城"] = "Teleport: Stormwind"
	L["传送：沙塔斯"] = "Teleport: Shattrath"
	L["传送：达拉然"] = "Teleport: Dalaran"
	L["传送：达纳苏斯"] = "Teleport: Darnassus"
	L["传送：雷霆崖"] = "Teleport: Thunder Bluff"
	L["传送：铁炉堡"] = "Teleport: Ironforge"
	L["传送：银月城"] = "Teleport: Silvermoon"
	
	L["传送门：埃索达"] = "Portal: Exodar"
	L["传送门：塞拉摩"] = "Portal: Theramore"
	L["传送门：奥格瑞玛"] = "Portal: Orgrimmar"
	L["传送门：幽暗城"] = "Portal: Undercity"
	L["传送门：斯通纳德"] = "Portal: Stonard"
	L["传送门：暴风城"] = "Portal: Stormwind"
	L["传送门：沙塔斯"] = "Portal: Shattrath"
	L["传送门：达拉然"] = "Portal: Dalaran"
	L["传送门：达纳苏斯"] = "Portal: Darnassus"
	L["传送门：雷霆崖"] = "Portal: Thunder Bluff"
	L["传送门：铁炉堡"] = "Portal: Ironforge"
	L["传送门：银月城"] = "Portal: Silvermoon"
	
	L["恶魔变形"] = "Metamorphosis"
	L["恶魔支配"] = "Fel Domination"
	L["召唤恶魔卫士"] = "Summon Felguard"
	L["召唤地狱猎犬"] = "Summon Felhunter"
	L["召唤魅魔"] = "Summon Succubus"
	L["召唤虚空行者"] = "Summon Voidwalker"
	L["召唤小鬼"] = "Summon Imp"
	
	L["制造治疗石"] = "Create Healthstone"
	L["制造灵魂石"]	= "Create Soulstone"
	L["制造法术石"]	= ""	
	L["制造火焰石"]	= ""	
	L["召唤仪式"] = "Ritual of Summoning"
	L["灵魂仪式"] = "Ritual of Souls"
	
	L["普通召唤宠物"] ="Normal Summon"
	L["快速召唤宠物"] ="Fast Summon"

	L["潜行"] = "Stealth"
	L["暗影之舞"] = "Shadow Dance"
	L["上毒主手"] = "Coat Mainhand"
	L["上毒副手"] = "Coat Offhand"	
	L["召唤"] ="Summon "
	L["毒药"] = "Poison"
	L["药膏"] = "Poison"
	L["施放技能"] = "Cast Spell"
	L["展开菜单"] = "Expand Menu"

end


-- local references for ShapeShiftBarFrame
local ssbFrame
local class
local level

local debugFlag= false
local printOrg = print
local function print(...)
	if debugFlag then
		printOrg(...)
	end
end

-- all the spells, items and macros that will be used
--[[
	table rules
	t: type (s = spell,m = macro, e = expand, i = item) required
	s: spell name
	m: macro text
	d: dependency (spell id or name), default to equal n
	i: item id list or item id
	f: tooltip, if not ,default to use spell in s
]]

local wlTooltip1 = L["左键 - "]..L["普通召唤宠物"]
local wlTooltip2 = L["右键 - "]..L["快速召唤宠物"]
local rogueTooltip1 = L["左键 - "]..L["上毒主手"]
local rogueTooltip2 = L["右键 - "]..L["上毒副手"]
local aspectSpellList = {
	["HUNTER"] = {
		{t = "s"	,s = L["蝰蛇守护"]},			
		{t = "s"	,s = L["野性守护"]},		
		{t = "s"	,s = L["野兽守护"]},		
		{t = "s"	,s = L["豹群守护"]},		
		{t = "s"	,s = L["猎豹守护"]},		
		{t = "s"	,s = L["龙鹰守护"]},		
		{t = "s"	,s = L["雄鹰守护"], e = L["龙鹰守护"]},		
		{t = "s"	,s = L["灵猴守护"], e = L["龙鹰守护"]},		
	},
	["MAGE"] = {
	
		{t = "e",
			{t = "s"	, 		s=L["传送门：埃索达"] 	,i=17032},	
			{t = "s"	,		s=L["传送门：塞拉摩"]	,i=17032},
			{t = "s"	,		s=L["传送门：奥格瑞玛"]	,i=17032},		
			{t = "s"	, 		s=L["传送门：幽暗城"]	,i=17032},	
			{t = "s"	,		s=L["传送门：斯通纳德"]	,i=17032},	
			{t = "s"	, 		s=L["传送门：暴风城"]	,i=17032},
			{t = "s"	, 		s=L["传送门：沙塔斯"]	,i=17032},
			{t = "s"	,		s=L["传送门：达拉然"]	,i=17032},		
			{t = "s"	,	 	s=L["传送门：达纳苏斯"]	,i=17032},				
			{t = "s"	,		s=L["传送门：雷霆崖"]	,i=17032},	
			{t = "s"	, 		s=L["传送门：铁炉堡"]	,i=17032},	
			{t = "s"	, 		s=L["传送门：银月城"]	,i=17032},			
		},	
		{t = "e",
			{t = "s"	, 		s=L["传送：埃索达"] 	,i=17031},	
			{t = "s"	,		s=L["传送：塞拉摩"]	,i=17031},
			{t = "s"	,		s=L["传送：奥格瑞玛"]	,i=17031},		
			{t = "s"	, 		s=L["传送：幽暗城"]	,i=17031},	
			{t = "s"	,		s=L["传送：斯通纳德"]	,i=17031},	
			{t = "s"	, 		s=L["传送：暴风城"]	,i=17031},
			{t = "s"	, 		s=L["传送：沙塔斯"]	,i=17031},
			{t = "s"	,		s=L["传送：达拉然"]	,i=17031},		
			{t = "s"	,	 	s=L["传送：达纳苏斯"]	,i=17031},				
			{t = "s"	,		s=L["传送：雷霆崖"]	,i=17031},	
			{t = "s"	, 		s=L["传送：铁炉堡"]	,i=17031},	
			{t = "s"	, 		s=L["传送：银月城"]	,i=17031},			
		},	
		{t = "m"	,m = "/cast [button:1] "..L["造餐术"].." \n/cast [button:2] "..L["召唤餐桌"],
			s = L["造餐术"],
			f={L["左键 - "]..L["造餐术"],L["右键 - "]..L["召唤餐桌"]}
		},
		{t = "m"	,m = "/cast [button:2] "..L["奥术光辉"].." \n/cast [button:1,exists,noharm] "..L["奥术智慧"].."; [button:1,target=player] "..L["奥术智慧"], 
			s = L["奥术智慧"],
			f={L["左键 - "]..L["奥术智慧"],L["右键 - "]..L["奥术光辉"]}
		},	
		{t = "s"	,s = L["法师护甲"]},			
		{t = "s"	,s = L["冰甲术"]},		
		{t = "s"	,s = L["熔岩护甲"]},	
	},
	
	["WARLOCK"] = {
		{t = "m"	,m = "/cast [button:2] "..L["恶魔支配"].." \n/cast "..L["召唤恶魔卫士"], cd = 18708,	s = L["召唤恶魔卫士"]	,i=6265,f={wlTooltip1,wlTooltip2}},	
		{t = "m"	,m = "/cast [button:2] "..L["恶魔支配"].." \n/cast "..L["召唤地狱猎犬"], cd = 18708,	s = L["召唤地狱猎犬"]	,i=6265,f={wlTooltip1,wlTooltip2}},	
		{t = "m"	,m = "/cast [button:2] "..L["恶魔支配"].." \n/cast "..L["召唤魅魔"],  cd = 18708,		s = L["召唤魅魔"]		,i=6265,f={wlTooltip1,wlTooltip2}},	
		{t = "m"	,m = "/cast [button:2] "..L["恶魔支配"].." \n/cast "..L["召唤虚空行者"], cd = 18708,	s = L["召唤虚空行者"]	,i=6265,f={wlTooltip1,wlTooltip2}},	
		{t = "m"	,m = "/cast [button:2] "..L["恶魔支配"].." \n/cast "..L["召唤小鬼"],  cd = 18708,		s = L["召唤小鬼"]		,i=6265,f={wlTooltip1,wlTooltip2},
		
		},	
		{t = "e",
			{t = "s"	, 		s=L["制造治疗石"]	,i=6265},	
			{t = "s"	, 		s=L["制造灵魂石"]	,i=6265},	
			{t = "s"	, 		s=L["制造法术石"]	,i=6265},	
			{t = "s"	, 		s=L["制造火焰石"]	,i=6265},	
			{t = "s"	, 		s=L["召唤仪式"]		,i=6265},	
			{t = "s"	, 		s=L["灵魂仪式"]		,i=6265},	
		}
	},
	["ROGUE"] = {
		{t = "i"	,i = 3775,f={rogueTooltip1,rogueTooltip2}},--减速
		{t = "i"	,i = 5237,f={rogueTooltip1,rogueTooltip2}},--麻痹
		{t = "i"	,i = {43237,21835},f={rogueTooltip1,rogueTooltip2}},--麻醉

		{t = "i"	,i = {43233,43232,22054,22053,20844,8985,8984,2893,2892},f={rogueTooltip1,rogueTooltip2}}, --致命
		{t = "i"	,i = {43231,43230,21927,8928,8927,8926,6950,6949,6947},f={rogueTooltip1,rogueTooltip2}}, --速效
		{t = "i"	,i = {43235,43234,22055,10922,10921,10920,10918},f={rogueTooltip1,rogueTooltip2}},--致伤

	}
}

-- table for character learned spells list
local aspectSpells = {}

-- table for aspect buttons
local aspectButtons = {}

local __ItemTooltip

------------
-- spell functions
------------

--check whether the player knows spell, passed by name or ID
local function __IsSpellLearned(spell)
	if not spell then return end
	print("Checking if "..spell .." is learned ...")
	if spell =='number' then 
		return IsSpellKnown(spell)
	end
	if not GetSpellInfo(spell) then return end
	local i, val, currentSpell = 1,nil
	for i = 1, 300 do
		currentSpell = GetSpellInfo(i, BOOKTYPE_SPELL)
		if (spell == currentSpell) then
			val = i
		end
		i = i + 1
	end
	return val
end

-- check if the dependency is meet
local function __IsRequireMeet(dependent)
	assert(dependent,"Dependent can not be nil")
	print(dependent)
	return __IsSpellLearned(dependent)
end

-- return a list of items that the player can use.
local function __GetAvailableItems(item)
	local t = {}
	if type(item)=='table' then
		for _,_item in ipairs(item) do
			local lvlReq = select(5,GetItemInfo(_item))
			if lvlReq and lvlReq  <= level then
				tinsert(t,_item)
			end
		end
	else
		local lvlReq = select(5,GetItemInfo(item))
		if lvlReq and lvlReq  <= level then
			tinsert(t,item)
		end
	end
	return t
end

--fill in aspectSpells with macros, spells and items that player knows
local function __GetLearnedSpells()
	print("Update aspect spell table for class: "..class)
	aspectSpells = {}
	local aspectTable = aspectSpellList[class]
	if not aspectTable then return end
	local dependent ,itemList,skillList
	for _,_spellTable in ipairs(aspectTable) do
		dependent = _spellTable.s
		if dependent then
			if __IsRequireMeet(dependent) then
				tinsert(aspectSpells,_spellTable)
			end
		elseif _spellTable.i then
			itemList = __GetAvailableItems(_spellTable.i)
			if #itemList > 0 then
				_spellTable.items = itemList
				tinsert(aspectSpells,_spellTable)
			end		
		-- if the node is a collection of spells
		elseif _spellTable.t =='e' then
			local subSpellTable = {}
			subSpellTable.t='e'
			for _,_subSpell in ipairs(_spellTable) do
				dependent = _subSpell.s
				if dependent then
					if __IsRequireMeet(dependent) then
						tinsert(subSpellTable,_subSpell)
					end
				elseif _subSpell.i then
					itemList = __GetAvailableItems(_subSpell.i)
					if #itemList > 0 then
						_subSpell.items = itemList
						tinsert(subSpellTable,_subSpell)
					end
				end
			end
			if #subSpellTable >0 then
				tinsert(aspectSpells,subSpellTable)
			end
		end
	end
	local exclude
	local spell
	local i = 1
	while aspectSpells[i] do
		exclude = aspectSpells[i].e
		if exclude then
			for j = 1, #aspectSpells do
				spell = aspectSpells[j]
				if spell.s == exclude then
					tremove(aspectSpells,i)
					i = i - 1
					break;
				end
			end
		end
		i = i + 1
	end
end

--check which buff is active
local function __IsBuffActive(name)
	if not name then return end
	print("check if buff: "..name.."is active.")

	local i = 1
	local buffName = UnitBuff("player", i)
	while (buffName) do
		if (buffName == name) then
			return i
		end
		i = i + 1
		buffName = UnitBuff("player", i)
	end
	return false
end

-- check if pet is active
local function __IsPetActive(spellName)
	local creatureName = spellName:gsub(L["召唤"],"")
	local petName = UnitCreatureFamily("pet")
	if petName and petName:match(creatureName) then return true end
end

-- get the spell texture
local function __GetSpellTexture(spell,t)
	assert(type(spell)=='number' or type(spell)=='string', "Must use spell ID or name")
	if t and t=='item' then
		return select(10,GetItemInfo(spell))
	end
	return select(3,GetSpellInfo(spell))
end

--get the spell cooldown
local function __GetSpellCooldown(spell,t)
	assert(type(spell)=='number' or type(spell)=='string', "Must use spell ID or name")
	if t and t=='item' then
		return GetItemCooldown(spell)
	end
	return GetSpellCooldown(spell)
end

--get the highest lvl item
local function __GetHighestItem(itemList)
	assert(#itemList>0,"ItemList need to have at least one item")
	local count 
	for _,_item in ipairs(itemList) do
		count = GetItemCount(_item)
		if  count > 0 then return _item,count end
	end
	return itemList[1],0
end

--get poison base info
local function __GetPoisonBase(ench)
	local enchName = ench:match("^([^ ]+) ?[IVX]*$")
	local poisonName =enchName:gsub(L["药膏"],L["毒药"])	
	return poisonName,enchName
end

--check if certain weapon has enchant 
local function __WeaponHasEnch(slot,ench)
	__ItemTooltip:SetInventoryItem("player", slot)
	for i = 1,__ItemTooltip:NumLines() do
		local text = _G[__ItemTooltip:GetName().."TextLeft"..i]:GetText()
		local enchBase,poisonBase = __GetPoisonBase(ench)
		if text:match(enchBase) then return true end
		if text:match(poisonBase) then return true end
	end
end


------------------
--Button functions
------------------
-- while item attribute changes, get the item count and display new count
local function __OnItemAttrChange(button,name,val)
	assert(button,"Button does not exist!")
	assert(name,"Attribute name does not exist!")
	if name=="item" then
		local item = val
		if item and button.count then
			button.count:SetText(GetItemCount(item))
		end
	end
end

--set gametooltip here
local function __OnButtonEnter(self)
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end
	local link
	if not self.spellTable.ignoreSpell then
		if self:GetAttribute("spell") then
			GameTooltip:AddLine(self:GetAttribute("spell"));
		elseif self:GetAttribute("item") then
			GameTooltip:AddLine(self:GetAttribute("item"))
		end
	end
	if self.spellTable.f then
		for _,_line in ipairs(self.spellTable.f) do
			GameTooltip:AddLine(_line)
		end
	end
	if self.subList then
		GameTooltip:AddLine(L["左键 - "]..L["施放技能"])
		GameTooltip:AddLine(L["右键 - "]..L["展开菜单"])
	end
	GameTooltip:Show()
end

-- create sub buttons
local function __CreateSubButton(parentButton,i)
	if _G[parentButton:GetName() .."Sub".. i] then return _G[parentButton:GetName() .."Sub".. i] end
	local __button = CreateFrame("CheckButton", parentButton:GetName() .."Sub".. i, parentButton, "SecureActionButtonTemplate, ActionButtonTemplate,SecureHandlerAttributeTemplate,SecureHandlerEnterLeaveTemplate")
	__button:SetHeight(30)
	__button:SetWidth(30)
	__button:RegisterForClicks("AnyUp")
	__button:SetNormalTexture(nil)
	__button:SetPushedTexture(nil)
	__button:SetScript("OnAttributeChanged",__OnItemAttrChange)
	__button:SetFrameLevel(parentButton:GetFrameLevel())
	__button.cooldown = _G[__button:GetName().."Cooldown"]
	__button.icon = _G[__button:GetName().."Icon"]
	__button.count = _G[__button:GetName().."Count"]
	__button:Hide()
	__button:HookScript("PostClick",function(self)self:SetChecked(0) end)
	__button.OnEnterFrame = __OnButtonEnter
	__button.OnLeaveFrame = function()GameTooltip:Hide() end
	__button:SetScript("PreClick",function(self)
		self:GetParent().icon:SetTexture(self.icon:GetTexture())
	end)
	__button:SetAttribute("_onenter",[[
		control:CallMethod("OnEnterFrame",self)
	]])
	__button:SetAttribute("_onleave",
	[[ 	
		control:CallMethod("OnLeaveFrame",self)
		local parent =  self:GetParent()
		if not self:GetParent():IsUnderMouse(true) then
--			print("hide")
			local t = table.new()
			parent:GetChildList(t)
			for _i,_child in ipairs(t) do
				if _child:IsProtected() then
					_child:Hide()
				end
			end
			self:GetParent():SetAttribute("childrenshown","0")
		end
	
	]])
	__button:SetAttribute("_childupdate",[[
		if message =="show" then
			self:Show()
		else
			self:Hide()
		end
	
	]])
	parentButton:WrapScript(__button,"PostClick",
	[[
		local parent = self:GetParent()
		control:ChildUpdate(nil,"hide")
		parent:SetAttribute("childrenshown","0")
		parent:SetAttribute("type",self:GetAttribute("type"))
		parent:SetAttribute("type1",self:GetAttribute("type1"))
		parent:SetAttribute("item",self:GetAttribute("item"))
		parent:SetAttribute("spell",self:GetAttribute("spell"))
		parent:SetAttribute("macrotext",self:GetAttribute("macrotext"))	
	]])
	return __button
end

-- setup sub button, including attribute and positions
local function __SetSubButton(subButton,button, index)
	subButton:SetPoint("BOTTOM",button,"TOP",0,30* (index -1))
end

-- set up button attribute using spell table
local function __SetButton(__frame,spell)
	assert(type(spell)=='table',"Spell need to be a table")
	assert(spell.t,"Need to specify a type for spell")
	-- save the spell table here for bakup use
	__frame.spellTable = spell
	local texture 
	__frame:SetAttribute("iscollect","0")
	if spell.t == 'm' then
		__frame.spell = spell.s
		texture = __GetSpellTexture(__frame.spell)

		__frame:SetAttribute("type","macro")
		__frame:SetAttribute("macrotext",spell.m)
		if spell.s then
			__frame:SetAttribute("spell",spell.s)
		end
		if spell.i then
			__frame:SetAttribute("item",spell.i)
		end
	elseif spell.t == 'i' then
		local item = __GetHighestItem(spell.items)
		local itemName = GetItemInfo(item)
		texture = __GetSpellTexture(item,"item")

		__frame:SetAttribute("type","item")
		__frame:SetAttribute("item", itemName);
		__frame:SetAttribute("target-slot1", 16);
		__frame:SetAttribute("target-slot2", 17);
		
	elseif spell.t == 's' then
		__frame:SetAttribute("type1","spell")
		__frame:SetAttribute("spell",spell.s)
		texture = __GetSpellTexture(spell.s)
		if spell.i then
			__frame:SetAttribute("item",spell.i)
		end
	elseif spell.t == 'e' then
		assert(#spell >0,"Spell List can not be of size 0")
		-- if the button never set, set to init value
		if not(__frame:GetAttribute("spell") or __frame:GetAttribute("item") )then
			__SetButton(__frame,spell[1])
		end
		__frame:SetAttribute("iscollect","1")
		__frame.subList = __frame.subList or {}
		for _i,_spell in ipairs(spell) do
			if not __frame.subList[_i] then
				__frame.subList[_i] = __CreateSubButton(__frame,_i)
				__SetSubButton(__frame.subList[_i],__frame,_i)
				__SetButton(__frame.subList[_i],_spell)
			end
		end
		
		-- show and hide logics
	else
		error("Undefined spell type:" .. spell.t)
	end
	if texture then
		__frame.icon:SetTexture(texture)
	end
end

-- get button cooldown 
local function __GetButtonCooldown(id)
	assert(type(id)=='number',"Button id need to be number")
	local button =aspectButtons[id]
	local buttonType = button and button:GetAttribute("type1") or button:GetAttribute("type")
	local spell,sType 
	if buttonType =="spell" then
		spell = button:GetAttribute("spell")
	elseif buttonType == "item" then
		spell = button:GetAttribute("item")
		sType = "item"
	elseif buttonType == "macro" then
		spell = button.spell
	end
	if button.spellTable and button.spellTable.cd and IsSpellKnown(button.spellTable.cd) then
		spell = button.spellTable.cd
	end
	return __GetSpellCooldown(spell,sType)
end

--get button active 
local function __GetButtonActive(id)
	assert(type(id)=='number',"Button id need to be number")
	local button =aspectButtons[id]
	local buttonType = button:GetAttribute("type1") or button:GetAttribute("type")
	if buttonType =='item' then
		local hasMainEnch,_,_,hasOffEnch = GetWeaponEnchantInfo()
		if not hasMainEnch and not hasOffEnch then return false end
		return __WeaponHasEnch(16,button:GetAttribute("item")) or __WeaponHasEnch(17,button:GetAttribute("item"))
	elseif buttonType =='spell' then
		return __IsBuffActive(button:GetAttribute("spell"))
	elseif buttonType == 'macro' then
		
		return __IsBuffActive(button:GetAttribute("spell")) or __IsPetActive(button:GetAttribute("spell"))
	end
end

-- get button count
local function __GetButtonCount(button)
	local item,count = button:GetAttribute("item")
	if item then
		count = GetItemCount(item)	
		return count
	end
end

--set button count  
local function __SetButtonCount(button)
	local count = __GetButtonCount(button)
	if not count then return end
	if count > 0 then
		button.count:SetText(count)
	else
		__SetButton(button,button.spellTable)
	end
end


local function __SetAspectButtonCount(id)
	assert(type(id)=='number',"Button id need to be number")
	local button =aspectButtons[id]
	if not button then return end
	__SetButtonCount(button)
	if button.subList and #button.subList > 0 then
		for i = 1, #button.subList do
			__SetButtonCount(button.subList[i])
		end
	end
end

------------------
-- AspectBar functions
------------------

-- return the aspect button by id
local function __GetAspectButton(i)
	return aspectButtons[i]
end

-- update aspect buttons active status
local function __UpdateAspectButtonsActive()
	print("Update Current Active Button.")
	local numForms,isActive = A:GetNumShapeshiftForms()
	print(numForms)
	local isActive
	for i=1, numForms do
		isActive = __GetButtonActive(i)			
		if isActive then
			aspectButtons[i].active = true
			aspectButtons[i]:SetChecked(1)
		else
			aspectButtons[i].active = false
			aspectButtons[i]:SetChecked(0)
		end

	end
end

-- update aspect buttons cooldown 
local function __UpdateAspectButtonsCooldown()
	print("Aspect cooldown update")
	local numForms = A:GetNumShapeshiftForms()
	local start, duration, enable, cooldown
	for i=1, numForms do
		cooldown = aspectButtons[i] and aspectButtons[i].cooldown
		start, duration, enable = __GetButtonCooldown(i)
		if (cooldown and start and duration) then
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
		end		
	end
end

-- update button spells
local function __UpdateAspectButtonsSpell()
	print("Update Aspect Buttons")
	local numForms = A:GetNumShapeshiftForms()	    
	local button, icon  
	ShapeshiftBar_Update()
	for i=1, numForms do
		button = __GetAspectButton(i)	
		icon = button.icon;
		__SetButton(button,aspectSpells[i])
		if button:GetAttribute("item") then
			button.count:Show()
		else
			button.count:Hide()
		end
		button:SetNormalTexture(nil)
		button:Show()
	end
end

--update button count
local function __UpdateAspectButtonsCount()
	local numForms = A:GetNumShapeshiftForms()	   
	local button
	for i=1, numForms do
		button = __GetAspectButton(i)	
		__SetAspectButtonCount(i)
			
	end
end

--create the aspect frame
local function __CreateAspectFrame()
	local frame = CreateFrame("Frame","BFAspectFrame",UIParent)
	frame:SetWidth(1)
	frame:SetHeight(32)
	frame:Hide()
	return frame
end

-- create the aspect bar
local function __CreateAspectButtons()
	print("Create Aspect Bar")
	ssbFrame:SetWidth(1)
	local num = A:GetNumShapeshiftForms()
	local __frame
	local refFrame = ssbFrame
	for i=1,num do
		__frame =_G["BFAspectButton" .. i] or  CreateFrame("CheckButton", "BFAspectButton" .. i, ssbFrame, "SecureActionButtonTemplate, ActionButtonTemplate,SecureHandlerAttributeTemplate,SecureHandlerEnterLeaveTemplate")
		__frame:SetHeight(30)
		__frame:SetWidth(30)
		__frame:RegisterForClicks("AnyUp")
		__frame:SetPoint("RIGHT",refFrame,"LEFT",-8,0)
		refFrame = __frame
		__frame:SetNormalTexture(nil)
		__frame:SetScript("OnAttributeChanged",__OnItemAttrChange)
		_G["OldShapshiftButton" .. i] = ssb 
		__frame:SetFrameLevel(5)
		__frame.cooldown = _G[__frame:GetName().."Cooldown"]
		__frame.icon = _G[__frame:GetName().."Icon"]
		__frame.count = _G[__frame:GetName().."Count"]
		tinsert(aspectButtons,__frame)
		__frame:Show()
		__frame.SetButtonCheck = function(self)self:SetChecked(self.active) end 
		__frame.OnEnterFrame = __OnButtonEnter
		__frame.OnLeaveFrame =function()
			GameTooltip:Hide()
		end
		__frame:SetAttribute("childrenshown","0")
	
		
		__frame:WrapScript(__frame,"OnClick",[[
			if self:GetAttribute("iscollect")=="0" then return end
			if button=="RightButton" then
				if self:GetAttribute("childrenshown")=="0" then
					control:ChildUpdate(nil,"show")
					self:SetAttribute("childrenshown","1")
				elseif self:GetAttribute("childrenshown")=="1" then
					control:ChildUpdate(nil,"hide")
					self:SetAttribute("childrenshown","0")
				end
			end
			control:CallMethod("SetButtonCheck",self)
		]])
		__frame:SetAttribute("_onenter",[[
			control:CallMethod("OnEnterFrame",self)
		]])
		__frame:SetAttribute("_onleave",[[
			control:CallMethod("OnLeaveFrame")
			if not self:IsUnderMouse(true) then
				control:ChildUpdate(nil,"hide")
				self:SetAttribute("childrenshown","0")
			end
		]])
	end
	
	ssbFrame:SetScript("OnShow",function()
		BFSecureCall("UIParent_ManageFramePositions")
	end)
	ssbFrame:SetScript("OnHide",function()
		BFSecureCall("UIParent_ManageFramePositions")
	end)
	
	ssbFrame:Show()
end

--destory bar
local function __DestoryBar()
	ssbFrame:Hide()
	local num = A:GetNumShapeshiftForms()
	for i=1, num do	
		_G["BFAspectButton"..i]:Hide()
	end
end

------------------
-- hook functions 
------------------
--find out how many aspect buttons to use
function A:GetNumShapeshiftForms()
	local num = #aspectSpells or 0
	return num
end

-- move pet action bar position
function A:UIParent_ManageFramePositions()
	BFSecureCall(ssbFrame.ClearAllPoints,ssbFrame)
	if SHOW_MULTI_ACTIONBAR_2 then
		if MultiBarBottomRightButton11:GetLeft()<1150 then
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton10,"TOPRIGHT",0,7)
		else
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton11,"TOPRIGHT",0,7)
		end
	else
		if MultiBarBottomRightButton11:GetLeft()<1150 then
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton10,"BOTTOMRIGHT",0,0)
		else
			BFSecureCall(ssbFrame.SetPoint,ssbFrame,"BOTTOMRIGHT",MultiBarBottomRightButton11,"BOTTOMRIGHT",0,0)
		end
	end
	BFSecureCall(ssbFrame.Show,ssbFrame)
end

-- hook get shapeshift form function
function A:GetShapeshiftFormInfo(i)
	print("Get shapeshift form info: "..i)
	return aspectButtons[i].icon:GetTexture(),
		aspectButtons[i]:GetAttribute("spell") or aspectButtons[i]:GetAttribute("item"),
		aspectButtons[i].active,
		true
end

-----------
--- event functions
-----------
function A:UNIT_AURA(event,unit)
	print("Unit Aura Updated")

	if (unit == "player") then
		self:ScheduleTimer(__UpdateAspectButtonsActive,0.3)
	end	
end

function A:LEARNED_SPELL_IN_TAB()
	print("Learned a new spell")

	__GetLearnedSpells()
	__CreateAspectButtons()
	__UpdateAspectButtonsSpell()
end

function A:ACTIONBAR_UPDATE_USABLE()
	print("action bar update usable")

end

function A:ACTIONBAR_UPDATE_COOLDOWN()
	print("update action cooldown")
	__UpdateAspectButtonsCooldown()
end

function A:BAG_UPDATE()
	__UpdateAspectButtonsCount()
	__UpdateAspectButtonsActive()
end

function A:PET_DISMISS_START()
	__UpdateAspectButtonsActive()
end

function A:UPDATE_BINDINGS()
	print("update bindings")
	if class == "WARLOCK" or class == "ROGUE" then return end
	local numForms = A:GetNumShapeshiftForms()
	ClearOverrideBindings(ShapeshiftBarFrame)
	for i = 1, numForms do
		local button = _G["BFAspectButton"..i]
		local key1, key2 = GetBindingKey("SHAPESHIFTBUTTON"..(numForms-i+1))
		if (key1) then
			SetOverrideBindingClick(ShapeshiftBarFrame, true, key1, "BFAspectButton"..i)
		end
		if (key2) then
			SetOverrideBindingClick(ShapeshiftBarFrame, true, key2, "BFAspectButton"..i)
		end	
	end
end
--------------
--control
--------------
function A:OnInitialize()
	print("Init BFAspects")
	ssbFrame =__CreateAspectFrame()
	class = select(2,UnitClass("player"))
	level = UnitLevel("player")
	__ItemTooltip = CreateFrame( "GameTooltip", "BFAspectScanTooltip", UIParent,"GameTooltipTemplate");
	__ItemTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
	self:SetEnabledState(false)
	__GetLearnedSpells()

end

function A:OnEnable()
	__GetLearnedSpells()
	__CreateAspectButtons()
	-- do this twice to refresh game cache.	
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PET_DISMISS_START")
	self:RegisterEvent("UPDATE_BINDINGS")
	--need to call it manually?
	self:UPDATE_BINDINGS()
	self:SecureHook("UIParent_ManageFramePositions")

	__UpdateAspectButtonsSpell()
	__UpdateAspectButtonsActive()
	__UpdateAspectButtonsCooldown()
	print("BFAspects Enabled")
end

function A:OnDisable()

	self:UnhookAll()

	__UpdateAspectButtonsSpell()	
	__DestoryBar()
	BFSecureCall("UIParent_ManageFramePositions")
	print("BFAspects Disabled")

end