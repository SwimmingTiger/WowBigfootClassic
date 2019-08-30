
--==================================================================================
-- 背包/银行整理 版本 1.03
-- 作者：独孤傲雪
-- 日期：2007-11-12
-- 版权所有：艾泽拉斯国家地理
-- 描述：将背包/银行里的物品按照一定的顺序整理好！
-- 鸣谢: 非常感谢JPack的作者提供的思路
--==================================================================================

if (GetLocale() == "zhCN") then
	__PUI_BUTTON_TEXT_BAG = "整理";
	__PUI_TOOLTIP_TEXT = "将背包或银行里的物品按顺序整理好\n勿将背包整理与银行整理同时使用";
	__PUI_KEY = "钥匙:钥匙";			--
	__PUI_CONTAINER = "容器";
	__PUI_ARMOR = "护甲";
	__PUI_CONSUMABLE = "消耗品";
elseif (GetLocale() == "zhTW") then
	__PUI_BUTTON_TEXT_BAG = "整理";
	__PUI_TOOLTIP_TEXT = "將背包或銀行裏的物品按順序整理好\n勿將背包整理與銀行整理同時使用!";
	__PUI_KEY = "鑰匙:鑰匙";
	__PUI_CONTAINER = "容器";
	__PUI_ARMOR = "護甲";
	__PUI_CONSUMABLE = "消耗品";
else
	__PUI_BUTTON_TEXT_BAG = "Sort";
	__PUI_TOOLTIP_TEXT = "Pack up items in your bags or bank automatically.";
	__PUI_KEY = "Key:Key";
	__PUI_CONTAINER = "Bag";
	__PUI_ARMOR = "Armor";
	__PUI_CONSUMABLE = "Consumable";
end

local __PUI_Config = {};
local __PUI_BAGS = {0,1,2,3,4};
local __PUI_BANKS = {-3,-1,5,6,7,8,9,10,11};
local __CURRENT_INV = __PUI_BAGS;
local __PUI_ORIG_INFO = {};	-- 整理前的物品信息
local __PUI_SORT_INFO = {};	-- 保存物品信息
local __PUI_PACK_INFO = {};
local __PUI_PACK_ONCE = false;
local __PUI_SORT_ONCE = false;
local __PUI_IS_PACKING = false;
local __PUI_IS_SORTING = false;
local __PUI_SORT_CON = false;
local DrinkAndFood;
local __PUI_DOING_SORTING,__PUI_DOING_PRVE_SORTING = false

-- 物品类别
local __PUI_INDEXTOTYPE = {
	["HEARTHSTON"] = 1,	-- 炉石
	["LIMOUSINE"]  = 2,		-- 坐骑
	["SPECIALTOOL"] = 3,	-- 特殊工具
	[__PUI_KEY] = 4;			-- 钥匙
};

-- 特殊物品数据
local __PUI_SPECIALS = {};
__PUI_SPECIALS["HEARTHSTON"] = {
	["6948"] = true,	--炉石
	["110560"] = true,	--要塞炉石
	["140192"] = true,	--达拉然炉石
};

-------------------
-- DEBUG function
-------------------
local __DEBUG = false;
local function debug(msg)
	if (not __DEBUG) then return end
	local msg = msg and tostring(msg) or "";
	msg = "|cffcccc00<PUI> |r" .. msg;
	ChatFrame1:AddMessage(msg, 0.8, 0.8, 0.8);
end

-----------------
-- create item type order
-----------------

local index = 4;
local function addItem(name, force)
	if (not __PUI_INDEXTOTYPE[name] or force) then
		index = index + 1;
		__PUI_INDEXTOTYPE[name] = index;
	end
end

local __CREATED;
local function __PUI_CreateItemType(...)	-- this is the only interface function
	if __CREATED then return end

	for i=1, select("#", ...) do
		local prefix = select(i, ...);
		local msg, to;
		if (prefix == __PUI_ARMOR) then	-- 护甲
			-- for k=1, select("#", GetAuctionInvTypes(2, 1)), 2 do
				-- msg = format("%s:%s", prefix, select(k, GetAuctionInvTypes(2, 1)));
				-- debug(msg)
				-- if (k == 4) then
					-- addItem(format("%s:%s", prefix, "INVTYPE_ROBE"));
				-- end
				-- addItem(msg);
			-- end

			for j=6, select("#", GetAuctionItemSubClasses(2)) do
				msg = format("%s:%s", prefix, select(j, GetAuctionItemSubClasses(2)));
				debug(msg)
				addItem(msg);
			end
		else
			to = select("#", GetAuctionItemSubClasses(i));
			if (prefix == __PUI_CONSUMABLE) then
				DrinkAndFood = format("%s:%s", prefix, GetAuctionItemSubClasses(i));
			end
			if (to > 0) then
				for j=1, to do
					msg = format("%s:%s", prefix, select(j, GetAuctionItemSubClasses(i)));

					debug(msg)
					addItem(msg);
				end
			else
				msg = format("%s:%s", prefix, prefix);	-- no subClass
				debug(msg)
				addItem(msg);
			end

			addItem(format("%s:%s", prefix, prefix)); -- like tradgood and consumable
		end
	end

	addItem(DrinkAndFood, 1);
	addItem("RUBBISH");	-- gray items
	addItem("NONE");		-- no item

	__CREATED = true;
end

--------------------
-- 获得id值, 缺省为""
--------------------
local function __PUI_GetItemID(__link)
	return __link and strmatch(__link, "^|c%x+|Hitem:(%d+):.+|h%[.-%]|h|r") or "";
end

--------------------
-- 获得包格的信息
--------------------
local function __PUI_GetSlotInfo(__bag,__slot)
	local Type;
	local _, __Count = GetContainerItemInfo(__bag,__slot);
	local __ID = __PUI_GetItemID(GetContainerItemLink(__bag,__slot));
	local __Item, __link, __Quality, __itemLevel, __Level, __mType, __sType, __Stack, __Inve, __Texture = GetItemInfo(__ID);

	if (__Inve and __mType == __PUI_ARMOR) then
		Type = format("%s:%s", __mType, __Inve);
	else
		Type = format("%s:%s", __mType or "", __sType or "");
 	end

	if (not __Item) then
		Type = "NONE";
	elseif ( __Quality == 0) then
		debug(__Item)
		Type = "RUBBISH";
	else
		if __PUI_SPECIALS["HEARTHSTON"][__ID] then
			Type = "HEARTHSTON";
		end
		-- for k, v in  pairs(__PUI_SPECIALS) do
			-- -- 假如将来string多了, 我们可以使用注释的条件语句
			-- --if (type(v) == "string" or (type(v) == "table" and v[__ID])) then
			-- if (type(v) == "table" and v[__ID]) then
				-- Type = k;
			-- end
		-- end
	end
	if (__Item) then
		debug(format("%s-=>%s", __Item, Type))
	end
	__Count = __Count or 0;
	local __need = __Stack and (__Stack - __Count) or 0;
	return __ID, Type, __Quality or -1, __Count, __Stack or 0, __need, __Texture or "";
end

--------------------
-- 获得背包或银行物品信息
--------------------
local function __PUI_Scan(switch)
	__PUI_SORT_INFO = {};	-- clean original information
	__PUI_ORIG_INFO = {};
	__PUI_PACK_INFO = {};

	local __PUI_Index = 0;
	local __ID, __Type, __Quality, __Count, __Stack, __Need, __subtype,__Texture;

	for _, __bag in ipairs(__CURRENT_INV) do
		if (GetBagName(__bag) or __bag == -1) then
			if (__bag == 0 or __bag == -1) then
				debug(GetBagName(__bag));
				__subtype = __PUI_CONTAINER;
			else
				__subtype = select(7, GetItemInfo(GetBagName(__bag)));
			end
			__PUI_SORT_INFO[__subtype] = __PUI_SORT_INFO[__subtype] or {};
			__PUI_ORIG_INFO[__subtype] = __PUI_ORIG_INFO[__subtype] or {};
			for __slot = 1, GetContainerNumSlots(__bag) do
				__ID, __Type, __Quality, __Count, __Stack, __Need, __Texture = __PUI_GetSlotInfo(__bag,__slot);
				__PUI_Index = __PUI_Index + 1;
				if (switch) then
					__PUI_PACK_INFO[__PUI_Index] = {["Bag"] = __bag, ["Slot"] = __slot, ["ID"] = __ID, ["Count"] = __Count,["Stack"] = __Stack,["Need"] = __Need,};
				else
					tinsert(__PUI_ORIG_INFO[__subtype], {["Bag"] = __bag, ["Slot"] = __slot, ["ID"] = __ID, ["Count"] = __Count,});
					tinsert(__PUI_SORT_INFO[__subtype], {["ID"] = __ID, ["Type"] = __Type, ["Quality"] = __Quality, ["Texture"] = __Texture, ["Count"] = __Count,});
				end
			end
		end
	end
end

-- actualy to swap item
local function __PUI_Move(ob, os, nb, ns)
	PickupContainerItem(ob, os);
	PickupContainerItem(nb, ns);
end

local function isLocked(bag, slot)
	return select(3, GetContainerItemInfo(bag, slot));
end

local function getstirng(t)
	if t.sortedString then return t.sortedString end
	local textureType, textureIndex = strmatch(t.Texture,"\\.*\\([^_]+_?[^_]*_?[^_]*)_?(%d*)$");
	t.sortedString= format("%3d %3d %10s %5s %3s %3d", __PUI_INDEXTOTYPE[t.Type] or (#(__PUI_INDEXTOTYPE) - 1), t.Quality or -1, textureType or "", t.ID, textureIndex or "", t.Count);
	return t.sortedString
end

--------------------
-- 排序规则函数
--------------------
local function sortf(a, b)
	if (__PUI_Config.reversal) then
		return getstirng(a) > getstirng(b);
	else
		return getstirng(a) < getstirng(b);
	end
end

--------------------
-- 整理物品信息
--------------------
local function __PUI_Sort()
	for k, v in pairs(__PUI_SORT_INFO) do
		if (type(v) == "table") then
			table.sort(v, sortf);
		end
	end
end

--------------------
-- 正序整理函数（直接调用系统函数）
--------------------
local function __PUI_PosOrderSort()
	--系统正序为大脚逆序，系统逆序为大脚正序
	local isReverseSort = GetSortBagsRightToLeft();
	if isReverseSort then
		SortBags();		--调用系统整理函数
	else	--若系统原先为正向
		SetSortBagsRightToLeft(true);		--先设为系统逆向整理
		SortBags();
		SetSortBagsRightToLeft(false);		--整理完后恢复原始设置
	end
end

--------------------
-- 将每一背包的物品首尾调换
--------------------
local function __PUI_ItemChangeHeadToToe()
	--先检查物品是否仍被锁住
	local stillLock = false
	for bagId = 4, 0, -1 do
		local numSlots = GetContainerNumSlots(bagId);
		if numSlots > 0 then
			local _,count,locked = GetContainerItemInfo(bagId, numSlots);
			if count and locked then
				stillLock = true;
				break;
			end
		end
	end
	if stillLock then
		BigFoot_DelayCall(__PUI_ItemChangeHeadToToe,0.5);
		return;
	end

	--开始首尾调换
	for bagId = 0, 4, 1 do
		local numSlots = GetContainerNumSlots(bagId);		--得到当前循环包的容量
		local freeSlotsNum,_= GetContainerNumFreeSlots(bagId);	--当前背包的剩余格子数
		local isSpecial = false;
		if bagId > 0 then
			for i = LE_BAG_FILTER_FLAG_EQUIPMENT, NUM_LE_BAG_FILTER_FLAGS do	--检查当前背包是否为专用背包
				isSpecial = GetBagSlotFlag(bagId, i);
				if isSpecial then
					break;
				end
			end
		end
		local count1, count2, locked1, locked2, dstSlotID;
		if (numSlots and numSlots > 0 and freeSlotsNum > 0 and freeSlotsNum < numSlots and not isSpecial) then		--当前背包存在且不全空时执行
			for slotID = 1, numSlots/2, 1 do
				dstSlotID = numSlots-slotID+1;
				_,count1,locked1 = GetContainerItemInfo(bagId, slotID);
				_,count2,locked2 = GetContainerItemInfo(bagId, dstSlotID);
				if (locked1 or locked2) then
					ClearCursor();
				end
				if (count1) then
					PickupContainerItem(bagId, slotID);
					PickupContainerItem(bagId, dstSlotID);
				elseif (not count1 and count2) then
					PickupContainerItem(bagId, dstSlotID);
					PickupContainerItem(bagId, slotID);
				end
			end
		end
	end
end

--------------------
-- 逆序整理函数（调用系统函数）
--------------------
local function __PUI_ReverseOrderSort()
	--系统正序为大脚逆序，系统逆序为大脚正序
	local isReverseSort = GetSortBagsRightToLeft();
	if isReverseSort then
		SetSortBagsRightToLeft(false);		--先设为系统逆向整理
		SortBags();
		SetSortBagsRightToLeft(true);		--整理完后恢复原始设置
	else
		SortBags();
	end
	BigFoot_DelayCall(__PUI_ItemChangeHeadToToe,0.5);
end

--------------------
-- 寻找可以交换的物品{["Bag"] = __bag, ["Slot"] = __slot, ["ID"] = __ID, ["Count"] = __Count,}
--------------------
local function FindSlot(t, id, count)
	for k, v in ipairs(__PUI_ORIG_INFO[t]) do
		if (not isLocked(v.Bag, v.Slot) and (id == v.ID and v.Count == count) and (__PUI_SORT_INFO[t][k].ID ~= id or __PUI_SORT_INFO[t][k].Count ~= count)) then
			return v.Bag, v.Slot, k;
		end
	end
	return nil, nil, nil;
end

--------------------
-- 实际交换背包里的物品
--------------------
local function __PUI_SwapItem()
	__PUI_SORT_ONCE = false;
	__PUI_SORT_CON = true;
	local bag, slot, index, from, to, step;
	for k, v in pairs(__PUI_SORT_INFO) do
		if (__PUI_Config["reversal"]) then
			from, to, step = #(v), 1, -1;
		else
			from, to, step = 1, #(v), 1;
		end
		for i=from, to, step do
			if (v[i].ID ~= "" and (__PUI_ORIG_INFO[k][i].ID ~= v[i].ID or (__PUI_ORIG_INFO[k][i].ID == v[i].ID and __PUI_ORIG_INFO[k][i].Count ~= v[i].Count))) then
				__PUI_SORT_ONCE = true;
				if (not isLocked(__PUI_ORIG_INFO[k][i].Bag, __PUI_ORIG_INFO[k][i].Slot)) then
					bag, slot, index = FindSlot(k, v[i].ID, v[i].Count);
					if (bag and slot and index) then
						__PUI_Move(bag, slot, __PUI_ORIG_INFO[k][i].Bag, __PUI_ORIG_INFO[k][i].Slot);
						__PUI_ORIG_INFO[k][i].ID, __PUI_ORIG_INFO[k][index].ID = __PUI_ORIG_INFO[k][index].ID,__PUI_ORIG_INFO[k][i].ID;
						__PUI_ORIG_INFO[k][i].Count, __PUI_ORIG_INFO[k][index].Count = __PUI_ORIG_INFO[k][index].Count,__PUI_ORIG_INFO[k][i].Count;
					end
				end
			end
		end
	end
	__PUI_SORT_CON = false;
	if (not __PUI_SORT_ONCE) then
		__PUI_IS_SORTING = false;
	end
end

--------------------
-- 将分散物品汇总
--------------------
local function delaycal()
	__PUI_Scan();		-- 扫描
	__PUI_Sort();		-- 整理
	__PUI_IS_SORTING = true;
end

local function __PUI_CollectSeparate()
	__PUI_Scan(true);	-- 扫描
	local __Flag;
	__PUI_PACK_ONCE = false;
	for __i=#(__PUI_PACK_INFO), 2, -1 do
		for __j=1, __i-1, 1 do
			if (__PUI_PACK_INFO[__i].ID ~= "" and __PUI_PACK_INFO[__i].ID == __PUI_PACK_INFO[__j].ID and __PUI_PACK_INFO[__j].Count ~= 0 and __PUI_PACK_INFO[__i].Need ~= 0) then
				__Flag = nil;
				__PUI_PACK_ONCE = true;	-- need to pack
				if (not (isLocked(__PUI_PACK_INFO[__i].Bag, __PUI_PACK_INFO[__i].Slot) and isLocked(__PUI_PACK_INFO[__j].Bag, __PUI_PACK_INFO[__j].Slot))) then
					if (__PUI_PACK_INFO[__j].Count < __PUI_PACK_INFO[__i].Need) then
						PickupContainerItem(__PUI_PACK_INFO[__j]. Bag,__PUI_PACK_INFO[__j].Slot);
						__PUI_PACK_INFO[__i].Need = __PUI_PACK_INFO[__i].Need - __PUI_PACK_INFO[__j].Count;
						__PUI_PACK_INFO[__j].Count = 0;
						__PUI_PACK_INFO[__j].ID = "";
						__Flag = 1;
					elseif (__PUI_PACK_INFO[__j].Count == __PUI_PACK_INFO[__i].Need) then
						PickupContainerItem(__PUI_PACK_INFO[__j].Bag, __PUI_PACK_INFO[__j].Slot);
						__PUI_PACK_INFO[__i].Need = 0;
						__PUI_PACK_INFO[__j].Count = 0;
						__PUI_PACK_INFO[__j].ID = "";
						__Flag = 1;
					elseif (__PUI_PACK_INFO[__j].Count > __PUI_PACK_INFO[__i].Need) then
						SplitContainerItem(__PUI_PACK_INFO[__j].Bag,__PUI_PACK_INFO[__j].Slot,__PUI_PACK_INFO[__i].Need);
						__PUI_PACK_INFO[__j].Count = __PUI_PACK_INFO[__j].Count - __PUI_PACK_INFO[__i].Need;
						__PUI_PACK_INFO[__j].Need = __PUI_PACK_INFO[__j].Stack-__PUI_PACK_INFO[__j].Count;
						__PUI_PACK_INFO[__i].Need = 0;
						__Flag = 1;
					end
					if (__Flag) then
			 			PickupContainerItem(__PUI_PACK_INFO[__i]. Bag,__PUI_PACK_INFO[__i].Slot);
					end
				else
					BigFoot_DelayCall(__PUI_CollectSeparate, 0.7);	-- 为了安全起见, 我还是选择使用该方法
					return;
				end
			end
		end
	end
	if (__PUI_PACK_ONCE or CursorHasItem()) then
		ClearCursor();
		BigFoot_DelayCall(__PUI_CollectSeparate, 0.7);
		__PUI_IS_PACKING = true;
	else
		__PUI_IS_PACKING = false;
		BigFoot_DelayCall(delaycal, 0.7);
	end
end

--------------------
-- 开始整理
--------------------
local function __PUI_StartPack(type)
	if ( __PUI_IS_PACKING or __PUI_IS_SORTING or UnitIsDead("player")) then
		return;
	end

	if (type) then	--银行为true
		if __PUI_Config["reversal"] then	--若要求逆序排序
			__CURRENT_INV = __PUI_BANKS;
				__PUI_CollectSeparate();
		else
			if SortBankBags then
				if BankFrame.activeTabIndex then
					BankFrame_AutoSortButtonOnClick()
				else
					SortBankBags();
				end
			else
				__CURRENT_INV = __PUI_BANKS;
				__PUI_CollectSeparate();
			end
		end
	else	--背包为false
		if __PUI_Config["reversal"] then	--若要求逆序排序
			if (SortBags and GetSortBagsRightToLeft and SetSortBagsRightToLeft)	then	--若系统排序函数存在
				__PUI_ReverseOrderSort();
			else	--若系统排序函数不存在，则调用原先方法
				__CURRENT_INV = __PUI_BAGS;
				__PUI_CollectSeparate();
			end
		else
			if (SortBags and GetSortBagsRightToLeft and SetSortBagsRightToLeft)	then	--若系统排序函数存在
				__PUI_PosOrderSort();
			else	--若系统排序函数不存在，则调用原先方法
				__CURRENT_INV = __PUI_BAGS;
				__PUI_CollectSeparate();
			end
		end
	end
end

--------------------
-- 获得整理的按键和进度条
--------------------

local function BuildButton(parent, width, height, point1, point2, point3,__type)
	local f = CreateFrame('Button', parent:GetName().."Sort", parent, 'UIPanelButtonTemplate')

	f:SetWidth(width)
	f:SetHeight(height)
	f:SetPoint(point1, point2, point3)
	f:SetText(__PUI_BUTTON_TEXT_BAG)
	f:SetScript('OnClick', function()
		__PUI_StartPack(__type);
	end)
	f:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(__PUI_BUTTON_TEXT_BAG);
		GameTooltip:AddLine(__PUI_TOOLTIP_TEXT);
		GameTooltip:Show();
	end)
	f:SetScript('OnLeave', function()
		GameTooltip:Hide();
	end)

	return f
end

local function createButtons()
		if not CombuctorFrame1Search then return end
		CombuctorFrame1Search:SetPoint('TOPRIGHT',-166,-44)
		BuildButton(CombuctorFrame1, 45, 25, 'TOPRIGHT', -50, -41,false)
		BuildButton(CombuctorFrame2, 45, 25, 'TOPRIGHT', -50, -41,true)
end

---------------------
-- OnUpdate
---------------------
local function __PUI_OnUpdate(self)
	if (__PUI_IS_SORTING and not __PUI_SORT_CON) then
		__PUI_SwapItem();
	end
	__PUI_DOING_PRVE_SORTING = __PUI_DOING_SORTING
	if __PUI_IS_PACKING or __PUI_IS_SORTING then
		__PUI_DOING_SORTING = true
	else
		__PUI_DOING_SORTING = false
	end
	if __PUI_DOING_PRVE_SORTING ~= __PUI_DOING_SORTING then
		if __PUI_DOING_SORTING then
			for __i =1, NUM_CONTAINER_FRAMES,1 do
				_G["ContainerFrame"..__i]:UnregisterEvent("BAG_UPDATE")
			end
		else
			for __i =1, NUM_CONTAINER_FRAMES,1 do
				_G["ContainerFrame"..__i]:RegisterEvent("BAG_UPDATE");
				-- local frame = _G["ContainerFrame"..__i];
				-- if frame.size then
					-- ContainerFrame_Update(frame);
				-- end
			end
			ContainerFrame_UpdateAll();
		end
	end
end

local frame = CreateFrame("Frame", "__PUI_UPdateFrame", UIParent);
frame:SetScript("OnUpdate",  __PUI_OnUpdate);

local function GetAuctionItemClasses()
    return AUCTION_CATEGORY_WEAPONS, AUCTION_CATEGORY_ARMOR, AUCTION_CATEGORY_CONTAINERS,
           AUCTION_CATEGORY_CONSUMABLES,AUCTION_CATEGORY_GLYPHS, AUCTION_CATEGORY_TRADE_GOODS,
           AUCTION_CATEGORY_RECIPES, AUCTION_CATEGORY_GEMS, AUCTION_CATEGORY_MISCELLANEOUS,AUCTION_CATEGORY_QUEST_ITEMS, AUCTION_CATEGORY_BATTLE_PETS
end

function PUI_Toggle(__switch)
	if not CombuctorFrame1Sort then
		createButtons()
	end
	if __switch then
		__PUI_CreateItemType(GetAuctionItemClasses());
		CombuctorFrame1Sort:Show()
		CombuctorFrame2Sort:Show()
		__PUI_UPdateFrame:Show();
	else
		CombuctorFrame1Sort:Hide()
		CombuctorFrame2Sort:Hide()
		__PUI_UPdateFrame:Hide();
	end
end

function PUI_SetOrder(__order)
	if (__order == "desc") then
		__PUI_Config["reversal"] = true;
	else
		__PUI_Config["reversal"] = nil;
	end
end
