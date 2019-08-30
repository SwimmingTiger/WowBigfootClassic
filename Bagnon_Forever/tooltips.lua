
--[[
	Bagnon Tooltips
		Does ownership tooltips based on Bagnon_Forever data
--]]

local currentPlayer = UnitName('player')
local itemInfo = {}
local SILVER = '|cffc7c7cf%s|r'
local TEAL = '|cff00ff9a%s|r'

local filterItem = {
	["6948"] = true,	--炉石
	["110560"] = true,	--要塞炉石
	["140192"] = true,	--达拉然炉石
	["141605"] = true,	--飞行管理员的哨子
}

local function CountsToInfoString(invCount, bankCount, reagentBankCount, equipCount)
	local info
	local total = invCount + bankCount + reagentBankCount + equipCount

	if invCount > 0 then
		info = BAGNON_NUM_BAGS:format(invCount)
	end

	if bankCount > 0 then
		local count = BAGNON_NUM_BANK:format(bankCount)
		if info then
			info = strjoin(', ', info, count)
		else
			info = count
		end
	end

	if reagentBankCount > 0 then
		local count = BAGNON_NUM_REAGENTBANK:format(reagentBankCount)
		if info then
			info = strjoin(', ', info, count)
		else
			info = count
		end
	end

	if equipCount > 0 then
		if info then
			info = strjoin(', ', info, BAGNON_EQUIPPED)
		else
			info = BAGNON_EQUIPPED
		end
	end

	if info then
		if total and not(total == invCount or total == bankCount or total == reagentBankCount or total == equipCount) then
			--split into two steps for debugging purposes
			local totalStr = format(TEAL, total)
			return totalStr .. format(SILVER, format(' (%s)', info))
		end
		return format(TEAL, info)
	end
end

local function AddOwners(frame, link)
	if (not link) then return end
	if tonumber(link:match('item:(%d+)')) == HEARTHSTONE_ITEM_ID then return end

	for player in BagnonDB:GetPlayers() do
		local infoString
		if player == currentPlayer then
			local invCount = BagnonDB:GetItemCount(link, KEYRING_CONTAINER, player)
			for bag = 0, NUM_BAG_SLOTS do
				invCount = invCount + BagnonDB:GetItemCount(link, bag, player)
			end

			local bankCount = BagnonDB:GetItemCount(link, BANK_CONTAINER, player)
			for i = 1, NUM_BANKBAGSLOTS do
				bankCount = bankCount + BagnonDB:GetItemCount(link, NUM_BAG_SLOTS + i, player)
			end

			local reagentBankCount = BagnonDB:GetItemCount(link, REAGENTBANK_CONTAINER, player)

			local equipCount = BagnonDB:GetItemCount(link, 'e', player)

			infoString = CountsToInfoString(invCount or 0, bankCount or 0, reagentBankCount or 0, equipCount or 0)
		else
			infoString = itemInfo[player][link]
		end

		if infoString and infoString ~= '' then
			frame:AddDoubleLine(format(TEAL, player), infoString)
		end
	end
	frame:Show()
end

local function newTooltipHooker(method, func)
	return function(tooltip)
		local modified = false

		tooltip:HookScript('OnTooltipCleared', function(self, ...)
			modified = false
		end)

		tooltip:HookScript(method, function(self, ...)
			if not modified  then
				modified = true
				func(self, ...)
			end
		end)
	end
end

local function isNotFilterItem(link)
	local itemId = strmatch(link, "^|c%x+|Hitem:(%d+):.+|h%[.-%]|h|r") or "";
	if filterItem[itemId] then
		return;
	end
	return true;
end

local hookOwners = newTooltipHooker( 'OnTooltipSetItem', function(self, ...)
	local name, link = self:GetItem()
	if link and GetItemInfo(link) and isNotFilterItem(link) then --fix for blizzard doing craziness when doing getiteminfo
		AddOwners(self, link)
	end
end)

hookOwners(GameTooltip)
hookOwners(ItemRefTooltip)

--make up the self populating table
function bf_LoadBagnonDB()
	for player in BagnonDB:GetPlayers() do
		if player ~= currentPlayer then
			itemInfo[player] = setmetatable({}, {__index = function(self, link)
				local invCount = BagnonDB:GetItemCount(link, KEYRING_CONTAINER, player)
				for bag = 0, NUM_BAG_SLOTS do
					invCount = invCount + BagnonDB:GetItemCount(link, bag, player)
				end

				local bankCount = BagnonDB:GetItemCount(link, BANK_CONTAINER, player)
				for i = 1, NUM_BANKBAGSLOTS do
					bankCount = bankCount + BagnonDB:GetItemCount(link, NUM_BAG_SLOTS + i, player)
				end

				local reagentBankCount = BagnonDB:GetItemCount(link, REAGENTBANK_CONTAINER, player)

				local equipCount = BagnonDB:GetItemCount(link, 'e', player)

				self[link] = CountsToInfoString(invCount or 0, bankCount or 0, reagentBankCount or 0, equipCount or 0) or ''
				return self[link]
			end})
		end
	end
end
