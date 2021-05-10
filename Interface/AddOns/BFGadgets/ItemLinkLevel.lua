
addonName,savedVariable = ...

-- constants borrowed from PersonalLootHelper
local PLH_RELIC_TOOLTIP_TYPE_PATTERN = _G.RELIC_TOOLTIP_TYPE:gsub('%%s', '(.+)')
local PLH_ITEM_LEVEL_PATTERN = _G.ITEM_LEVEL:gsub('%%d', '(%%d+)')

local frame = CreateFrame("Frame", "ItemLinkLevel");
frame:RegisterEvent("ADDON_LOADED");
local tooltip
local bf_switch

-- Inhibit Regular Expression magic characters ^$()%.[]*+-?)
local function EscapeSearchString(str)
	return str:gsub("(%W)","%%%1")
end

-- function borrowed from PersonalLootHelper
local function CreateEmptyTooltip()
    local tip = CreateFrame('GameTooltip')
	local leftside = {}
	local rightside = {}
	local L, R
	for i = 1, 6 do
		L, R = tip:CreateFontString(), tip:CreateFontString()
		L:SetFontObject(GameFontNormal)
		R:SetFontObject(GameFontNormal)
		tip:AddFontStrings(L, R)
		leftside[i] = L
		rightside[i] = R
	end
	tip.leftside = leftside
	tip.rightside = rightside
	return tip
end

-- function borrowed from PersonalLootHelper
local function PLH_GetRelicType(item)
	local relicType = nil

	if item ~= nil then
		tooltip = tooltip or CreateEmptyTooltip()
		tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		tooltip:ClearLines()
		tooltip:SetHyperlink(item)
		local t = tooltip.leftside[2]:GetText()

		local index = 1
		local t
		while not relicType and tooltip.leftside[index] do
			t = tooltip.leftside[index]:GetText()
			if t ~= nil then
				relicType = t:match(PLH_RELIC_TOOLTIP_TYPE_PATTERN)
			end
			index = index + 1
		end

		tooltip:Hide()
	end

	return relicType
end

-- function borrowed from PersonalLootHelper
local function PLH_GetRealILVL(item)
	local realILVL = nil

	if item ~= nil then
		tooltip = tooltip or CreateEmptyTooltip()
		tooltip:SetOwner(UIParent, 'ANCHOR_NONE')
		tooltip:ClearLines()
		tooltip:SetHyperlink(item)
		local t = tooltip.leftside[2]:GetText()
		if t ~= nil then
--			realILVL = t:match('Item Level (%d+)')
			realILVL = t:match(PLH_ITEM_LEVEL_PATTERN)
		end
		-- ilvl can be in the 2nd or 3rd line dependng on the tooltip; if we didn't find it in 2nd, try 3rd
		if realILVL == nil then
			t = tooltip.leftside[3]:GetText()
			if t ~= nil then
--				realILVL = t:match('Item Level (%d+)')
				realILVL = t:match(PLH_ITEM_LEVEL_PATTERN)
			end
		end
		tooltip:Hide()

		-- if realILVL is still nil, we couldn't find it in the tooltip - try grabbing it from getItemInfo, even though
		--   that doesn't return upgrade levels
		if realILVL == nil then
			_, _, _, realILVL, _, _, _, _, _, _, _ = GetItemInfo(item)
		end
	end

	if realILVL == nil then
		return 0
	else
		return tonumber(realILVL)
	end
end

-- local socketTooltip
-- local function ItemHasSockets(itemLink)
	-- local result = false
	-- socketTooltip = socketTooltip or CreateFrame("GameTooltip", "ItemLinkLevelSocketTooltip", nil, "GameTooltipTemplate")
	-- socketTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
	-- socketTooltip:ClearLines()
	-- for i = 1, 30 do
		-- local texture = _G[socketTooltip:GetName().."Texture"..i]
		-- if texture then
			-- texture:SetTexture(nil)
		-- end
	-- end
	-- socketTooltip:SetHyperlink(itemLink)
	-- for i = 1, 30 do
		-- local texture = _G[socketTooltip:GetName().."Texture"..i]
		-- local textureName = texture and texture:GetTexture()

		-- if textureName then
			-- local canonicalTextureName = string.gsub(string.upper(textureName), "\\", "/")
			-- result = string.find(canonicalTextureName, EscapeSearchString("ITEMSOCKETINGFRAME/UI-EMPTYSOCKET-"))
		-- end
	-- end
	-- return result
-- end

local itemStatTable = {}
local function ItemHasSockets(itemLink)
	wipe(itemStatTable)
	GetItemStats(itemLink, itemStatTable)
	for key, num in pairs(itemStatTable) do
		if (string.find(key, "EMPTY_SOCKET_")) then
			return true
		end
	end
end

local function Filter(self, event, message, user, ...)
	if not bf_switch then return end
	for itemLink in message:gmatch("|%x+|Hitem:.-|h.-|h|r") do
		local itemName, _, quality, _, _, itemType, itemSubType, _, itemEquipLoc, _, _, itemClassId, itemSubClassId = GetItemInfo(itemLink)
		if (quality ~= nil and quality >= 2 and (itemClassId == LE_ITEM_CLASS_WEAPON or itemClassId == LE_ITEM_CLASS_GEM or itemClassId == LE_ITEM_CLASS_ARMOR)) then
			local itemString = string.match(itemLink, "item[%-?%d:]+")
			local _, _, color = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
			local iLevel = PLH_GetRealILVL(itemLink)

			local attrs = {}

			if itemSubType ~= nil then
				if (itemClassId == LE_ITEM_CLASS_ARMOR and itemSubClassId == 0) then
				-- don't display Miscellaneous for rings, necks and trinkets
				elseif (itemClassId == LE_ITEM_CLASS_ARMOR and itemEquipLoc == "INVTYPE_CLOAK") then
				-- don't display Cloth for cloaks
				else
					table.insert(attrs, itemSubType)
				end
				if (itemClassId == LE_ITEM_CLASS_GEM and itemSubClassId == LE_ITEM_ARMOR_RELIC) then
					local relicType = PLH_GetRelicType(itemLink)
					table.insert(attrs, relicType)
				end
			end

			if (itemEquipLoc ~= nil and _G[itemEquipLoc] ~= nil) then
				table.insert(attrs, _G[itemEquipLoc])
			end

			if iLevel ~= nil and quality ~= 6 then
				local txt = iLevel
				if (ItemHasSockets(itemLink)) then
					txt = txt .. "|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Prismatic:0|t"
				end
				table.insert(attrs, txt)
			end

			local newItemName = table.concat(attrs, "/")..":"..itemName
			local newLink = "|cff"..color.."|H"..itemString.."|h["..newItemName.."]|h|r"

			message = string.gsub(message, EscapeSearchString(itemLink), newLink)
		end
	end
	return false, message, user, ...
end

local function EventHandler(self, event, arg1)
	if arg1 == addonName then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", Filter);
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", Filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", Filter);

		self:UnregisterEvent("ADDON_LOADED");
	end
end

frame:SetScript("OnEvent", EventHandler);

function bf_ItemLinkLevel_Toggle(switch)
	bf_switch = switch
end

