
local addonName, addonTable = ...;
local ZT = addonTable.ztt.ZT;
local zc = addonTable.zc;
local zz = zc.md;
local _

local ItemUpgradeInfo = LibStub( 'LibItemUpgradeInfo-1.0' )

-----------------------------------------

function Atr_InitToolTips ()
  --tooltips are loaded every frame, don't need to do any special init
end

-----------------------------------------

local auctionator_orig_GameTooltip_OnTooltipAddMoney;

-----------------------------------------

function auctionator_GameTooltip_OnTooltipAddMoney (self, cost, maxcost)

  if (AUCTIONATOR_V_TIPS == 1) then
    return;
  end

  auctionator_orig_GameTooltip_OnTooltipAddMoney (self, cost, maxcost);
end

-----------------------------------------

function Atr_Hook_OnTooltipAddMoney()
  auctionator_orig_GameTooltip_OnTooltipAddMoney = GameTooltip_OnTooltipAddMoney;
  GameTooltip_OnTooltipAddMoney = auctionator_GameTooltip_OnTooltipAddMoney;
end

-----------------------------------------
--Hook any time an item is in the tooltip
--this is called before the SetXxxxItem functions
--GameTooltip is the main tooltip object
--ItemRefTooltip is the persistent tooltip if you click on a hyperlink
--ShoppingTooltips are the comparison tooltips, when you press shift to compare gear
GameTooltip:HookScript("OnTooltipSetItem", function(tip) Atr_OnTooltipSetItem(tip) end)
ItemRefTooltip:HookScript("OnTooltipSetItem", function(tip) Atr_OnTooltipSetItem(tip) end)
ShoppingTooltip1:HookScript("OnTooltipSetItem", function(tip) Atr_OnTooltipSetItem(tip) end)
ShoppingTooltip2:HookScript("OnTooltipSetItem", function(tip) Atr_OnTooltipSetItem(tip) end)

function Atr_OnTooltipSetItem(tip)
  --make sure we aren't doing anything bad
  if tip:IsForbidden() then return end
  --a variable to store whether we have rendered the item
  --recipes call setitem twice so it will duplicate info without this check
  if tip.Atr_TooltipRenderd then return end

  Atr_ShowTipWithPricing(tip)
  tip.Atr_TooltipRenderd = true
end

-----------------------------------------
--These tooltips don't SetItem so we have to handle them differently

-- the craft spell in craft window
hooksecurefunc( GameTooltip, 'SetCraftSpell',
  function( tip, craftspellindex )
    Atr_ShowReagentTooltip(tip, "craft",craftspellindex)
  end
);

-- reagents once a trade skill is selected in trade window
hooksecurefunc (GameTooltip, "SetTradeSkillItem",
  function (tip, skill, id)
    --we are on the tradeskill, not reagents
    if not id then
      Atr_ShowReagentTooltip(tip,"trade",skill)
    end
  end
);

-- the individual reagents once a craft spell is selected in craft window
hooksecurefunc( GameTooltip, 'SetCraftItem',
  function( tip, craftspellindex, reagentindex )
    --this blizzard api doesn't set item correctly so we have to do it manually
    local ilink = GetCraftReagentItemLink(craftspellindex,reagentindex)
    local iid = GetItemInfoInstant(ilink)
    tip:SetItemByID(iid)
  end
);

-----------------------------------------
--These hooks give us stack size
--They are called after ontooltipsetitem
hooksecurefunc (GameTooltip, "SetBagItem",
  function(tip, bag, slot)
    local _, num = GetContainerItemInfo(bag, slot);
    Atr_ShowTipWithPricing(tip, num)
  end
);

hooksecurefunc (GameTooltip, "SetTradePlayerItem",
  function (tip, id)
    local _, _, num = GetTradePlayerItemInfo(id);
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetTradeTargetItem",
  function (tip, id)
    local _, _, num = GetTradeTargetItemInfo(id);
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetAuctionItem",
  function (tip, type, index)
    local _, _, num = GetAuctionItemInfo(type, index);
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetMerchantItem",
  function(tip, index)
    local _, _, _, num = GetMerchantItemInfo(index);
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetBuybackItem",
  function(tip, index)
    local _, _, _, num = GetBuybackItemInfo(index);
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetLootItem",
  function (tip, slot)
    if LootSlotHasItem(slot) then
      local _, _, num = GetLootSlotLink(slot);
      Atr_ShowTipWithPricing (tip, num);
    end
  end
);

hooksecurefunc (GameTooltip, "SetLootRollItem",
  function (tip, slot)
    local _, _, num = GetLootRollItemInfo(slot);
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetInventoryItem",
  function (tip, unit, slot)
    local num = GetInventoryItemCount(unit, slot)
    Atr_ShowTipWithPricing (tip, num);
  end
);

hooksecurefunc (GameTooltip, "SetInboxItem",
  function (tip, index, attachIndex)
    local attachmentIndex = attachIndex or 1
    local _, _, _, num = GetInboxItem(index, attachmentIndex);
    if num then
      Atr_ShowTipWithPricing (tip, num);
    end
  end
);

-----------------------------------------
--Hook any time item is cleared, to reset rendering, for twice render check for recipes
GameTooltip:HookScript("OnTooltipCleared", function(tip) Atr_ClearTooltip(tip) end)
ItemRefTooltip:HookScript("OnTooltipCleared", function(tip) Atr_ClearTooltip(tip) end)
ShoppingTooltip1:HookScript("OnTooltipCleared", function(tip) Atr_ClearTooltip(tip) end)
ShoppingTooltip2:HookScript("OnTooltipCleared", function(tip) Atr_ClearTooltip(tip) end)

function Atr_ClearTooltip(tip)
  tip.Atr_TooltipRenderd = nil
end

------------------------------------------------

local function Atr_AppendHint (results, price, text, volume)

  if (price and price > 0) then
    local e = {};
    e.price   = price;
    e.text    = text;
    e.volume  = volume;

    table.insert (results, e);
  end

end

------------------------------------------------

function Atr_BuildHints (itemName, itemLink)

  local results = {};

  if (itemLink == nil and itemName == nil) then
    return results;
  end

  -- The Undermine Journal

  if (TUJMarketInfo) then
    local id = zc.RawItemIDfromLink (itemLink);

    local tujData = {}
    TUJMarketInfo (tonumber(id), tujData)

    local rawStdDevServer = tujData['stddev']
    local rawStdDevGlobal = tujData['globalStdDev']

    local stdDevServer = "???"
    if (rawStdDevServer) then
        stdDevServer = zc.priceToString (rawStdDevServer)
    end

    local stdDevGlobal = "???"
    if (rawStdDevGlobal) then
        stdDevGlobal = zc.priceToString (rawStdDevGlobal)
    end

    Atr_AppendHint (results, tujData['globalMean'], ZT("Undermine global avg (deviation: "..stdDevGlobal.." )"));
    Atr_AppendHint (results, tujData['recent'], ZT("Undermine 3-day server avg"));
    Atr_AppendHint (results, tujData['market'], ZT("Undermine 14-day server avg (deviation: "..stdDevServer.." )"));
    Atr_AppendHint (results, tujData['globalMedian'], ZT("Undermine global median"));
  end

  -- Wowecon

  if (Wowecon and Wowecon.API) then

    local priceG, volG, priceS, volS;

    if (itemLink) then
      priceG, volG = Wowecon.API.GetAuctionPrice_ByLink (itemLink, Wowecon.API.GLOBAL_PRICE)
      priceS, volS = Wowecon.API.GetAuctionPrice_ByLink (itemLink, Wowecon.API.SERVER_PRICE)
    else
      priceG, volG = Wowecon.API.GetAuctionPrice_ByName (itemName, Wowecon.API.GLOBAL_PRICE)
      priceS, volS = Wowecon.API.GetAuctionPrice_ByName (itemName, Wowecon.API.SERVER_PRICE)
    end

    Atr_AppendHint (results, priceG, ZT("Wowecon global price"), volG);
    Atr_AppendHint (results, priceS, ZT("Wowecon server price"), volS);

  end

  if (itemLink) then

    -- GoingPrice Wowhead

    local id = zc.RawItemIDfromLink (itemLink);

    id = tonumber(id);

    if (GoingPrice_Wowhead_Data and GoingPrice_Wowhead_Data[id] and GoingPrice_Wowhead_SV._index) then
      local index = GoingPrice_Wowhead_SV._index["Buyout price"];

      if (index ~= nil) then
        local price = GoingPrice_Wowhead_Data[id][index];

        Atr_AppendHint (results, price, "GoingPrice - Wowhead");
      end
    end

    -- GoingPrice Allakhazam

    if (GoingPrice_Allakhazam_Data and GoingPrice_Allakhazam_Data[id] and GoingPrice_Allakhazam_SV._index) then
      local index = GoingPrice_Allakhazam_SV._index["Median"];

      if (index ~= nil) then
        local price = GoingPrice_Allakhazam_Data[id][index];

        Atr_AppendHint (results, price, "GoingPrice - Allakhazam");
      end
    end
  end

  return results;

end

-----------------------------------------

function Atr_SetMFcolor (frameName, blue)

  local goldButton   = _G[frameName.."GoldButton"];
  local silverButton = _G[frameName.."SilverButton"];
  local copperButton = _G[frameName.."CopperButton"];

  if (blue) then
    goldButton:SetNormalFontObject(NumberFontNormalRightATRblue);
    silverButton:SetNormalFontObject(NumberFontNormalRightATRblue);
    copperButton:SetNormalFontObject(NumberFontNormalRightATRblue);
  else
    goldButton:SetNormalFontObject(NumberFontNormalRight);
    silverButton:SetNormalFontObject(NumberFontNormalRight);
    copperButton:SetNormalFontObject(NumberFontNormalRight);
  end

end


-----------------------------------------

function Atr_GetAuctionPrice (item)  -- itemName or itemID
  local itemName;

  if (type (item) == "number") then
    itemName = GetItemInfo (item);
  else
    itemName = item;
  end

  if (itemName == nil) then
    return nil;
  end

  if (gAtr_ScanDB and type (gAtr_ScanDB) ~= "table") then
    zc.msg_badErr ("Scanning history database appears to be corrupt")
    zc.msg_badErr ("gAtr_ScanDB:", gAtr_ScanDB)
    return nil
  end

  if ((type(gAtr_ScanDB) == "table") and gAtr_ScanDB[itemName] and gAtr_ScanDB[itemName].mr) then
    return gAtr_ScanDB[itemName].mr;
  end

  return nil;
end

-----------------------------------------

function Atr_GetAuctionPeriodPrice (item,period)
  if (type (item) == "number") then
    itemName = GetItemInfo (item);
  else
    itemName = item;
  end

  if (itemName == nil) then
    return nil;
  end

  if (gAtr_ScanDB and type (gAtr_ScanDB) ~= "table") then
    zc.msg_badErr ("Scanning history database appears to be corrupt")
    zc.msg_badErr ("gAtr_ScanDB:", gAtr_ScanDB)
    return nil
  end

  if ((type(gAtr_ScanDB) == "table")) then
    --build history tooltip
    local todayScanDay = Atr_GetScanDay_Today();
    local result, count

    -- find in auction data
    if (gAtr_ScanDB[itemName]) then
      result = 0
      count = 0
      local key, highlowprice, char1, day, when;
      for key, highlowprice in pairs (gAtr_ScanDB[itemName]) do
        -- if it's history data
        char1 = string.sub (key, 1, 1);
        if (char1 == "H") then

          -- convert to day
          day = tonumber (string.sub(key, 2));
          when = gScanHistDayZero + (day *86400);

          -- only get records for past week
          if day >= todayScanDay - period then
            -- check if item has multiple prices for this day
            local lowlowprice = gAtr_ScanDB[itemName]["L"..day];
            if (lowlowprice == nil) then
                lowlowprice = highlowprice;
            end
            highlowprice = tonumber (highlowprice)
            lowlowprice  = tonumber (lowlowprice)

            --average the low and high price
            local dayprice = zc.round ((highlowprice + lowlowprice) / 2);
            result = result + dayprice
            count = count + 1
          end
        end
      end

      --average the total
      if result > 0 then
        result = result / count
      end
      return result
    end
  end

  return nil;
end

-----------------------------------------

local function Atr_CalcTextWid (price)

  local wid = 15;

  if (price > 9)      then wid = wid + 12;  end;
  if (price > 99)     then wid = wid + 44;  end;
  if (price > 999)    then wid = wid + 12;  end;
  if (price > 9999)   then wid = wid + 44;  end;
  if (price > 99999)    then wid = wid + 12;  end;
  if (price > 999999)   then wid = wid + 12;  end;
  if (price > 9999999)  then wid = wid + 12;  end;
  if (price > 99999999) then wid = wid + 12;  end;

  return wid;
end

-----------------------------------------

local function Atr_GetDEitemName( itemID )
  local itemName = GetItemInfo( itemID )

  return itemName or Auctionator.Constants.DisenchantingItemName[ itemID ]
end

-----------------------------------------

-- same as Atr_GetAuctionPrice but understands that some "lesser" essences are
-- convertible with "greater"
function Atr_GetAuctionPriceDE( itemID )
  local mapping = Auctionator.Constants.DisenchantingMatMapping[ itemID ]

  if mapping then
    local lesserPrice = Atr_GetAuctionPrice( Atr_GetDEitemName( itemID ))
    local greaterPrice = Atr_GetAuctionPrice( Atr_GetDEitemName( mapping ))

    if lesserPrice and greaterPrice and lesserPrice * 3 > greaterPrice then
      return math.floor( greaterPrice / 3 )
    else
      return lesserPrice
    end
  else
    return Atr_GetAuctionPrice( Atr_GetDEitemName( itemID ))
  end
end

-----------------------------------------

function Auctionator.ItemLevelMatches( entry, itemLevel )
  return itemLevel >= entry[ Auctionator.Constants.DisenchantingProbabilityKeys.LOW ] and
    itemLevel <= entry[ Auctionator.Constants.DisenchantingProbabilityKeys.HIGH ]
end

local function Atr_FindDEentry (classID, itemRarity, itemLevel)
  local itemClassTable = Auctionator.Constants.DisenchantingProbability[ classID ]
  local entries = ( itemClassTable and itemClassTable[ itemRarity ] ) or {}

  for index, entry in pairs( entries ) do
    if Auctionator.ItemLevelMatches( entry, itemLevel ) then
      return entry
    end
  end
end

-----------------------------------------

function Atr_AddDEDetailsToTip( tip, classID, itemRarity, itemLevel )
  local entry = Atr_FindDEentry( classID, itemRarity, itemLevel )

  if entry then
    for x = 3, #entry, 3 do
      local percent = math.floor( entry[ x ] * 100 ) / 100
      local deitem = Atr_GetDEitemName( entry[ x + 2 ] )

      if (percent > 0) then
        tip:AddLine ("  |cFFFFFFFF" .. percent .. "%|r   " .. entry[ x + 1 ] .. " " .. ( deitem or '???' ))
      end
    end
  end
end


-----------------------------------------
function Auctionator.IsNotCommon( itemRarity )
  return itemRarity == Auctionator.Constants.Rarity.UNCOMMON or
    itemRarity == Auctionator.Constants.Rarity.RARE or
    itemRarity == Auctionator.Constants.Rarity.EPIC
end

function Auctionator.IsDisenchantable( classID )
  return Atr_IsWeaponType( classID ) or Atr_IsArmorType( classID )
end

function Atr_CalcDisenchantPrice( classID, itemRarity, itemLevel)
  if Auctionator.IsDisenchantable( classID ) and Auctionator.IsNotCommon( itemRarity ) then

    local dePrice = 0

    local ta = Atr_FindDEentry( classID, itemRarity, itemLevel )
    if ta then
      for x = 3, #ta, 3 do
        local price = Atr_GetAuctionPriceDE( ta[ x + 2 ] )

        if price then
          dePrice = dePrice + ( ta[ x ] * ta[ x + 1 ] * price )
        end
      end
    end

    return math.floor( dePrice / 100 )
  end

  return nil
end

-----------------------------------------

function Atr_STWP_AddVendorInfo (tip, xstring, vendorPrice, doreplace)
  if (AUCTIONATOR_V_TIPS == 1 and vendorPrice > 0) then
    local left = ZT("Vendor")..xstring
    local right = "|cFFFFFFFF"..zc.priceToMoneyString (vendorPrice)
    Atr_Tooltip_AddLine(tip,ZT("Vendor"),left,right, doreplace)
  end
end

-----------------------------------------

function Atr_STWP_AddAuctionInfo (tip, xstring, link, auctionPrice, doreplace)
  if AUCTIONATOR_A_TIPS == 1 then

    local itemID = zc.RawItemIDfromLink (link);
    itemID = tonumber(itemID);

    local bondtype = Atr_GetBondType (itemID);

    local left = ZT("Auction")..xstring
    local right = "|cFFFFFFFF"

    if (bondtype == ATR_BIND_ON_PICKUP) then
      right = right .. ZT("BOP").."  "
    elseif (bondtype == ATR_BINDS_TO_ACCOUNT) then
      right = right .. ZT("BOA").."  "
    elseif (bondtype == ATR_QUEST_ITEM) then
      right = right .. ZT("Quest Item").."  "
    elseif (auctionPrice ~= nil) then
      right = right .. zc.priceToMoneyString (auctionPrice)
    else
      right = right .. ZT("unknown").."  "
    end

    Atr_Tooltip_AddLine(tip,ZT("Auction"),left,right, doreplace)
  end
end

-----------------------------------------

function Atr_STWP_AddBasicDEInfo (tip, xstring, dePrice, doreplace)
  if (AUCTIONATOR_D_TIPS == 1 and dePrice ~= nil) then
    local left = ZT("Disenchant")..xstring
    local right = "|cFFFFFFFF"
    if (dePrice > 0) then
      right = right .. zc.priceToMoneyString(dePrice)
    else
      right = right .. ZT("unknown").."  "
    end

    Atr_Tooltip_AddLine(tip,ZT("Disenchant"),left,right, doreplace)
  end
end

-----------------------------------------

function Atr_STWP_GetPrices (link, num, itemVendorPrice, itemName, classID, itemRarity, itemLevel)
  local vendorPrice = 0;
  local auctionPrice  = 0;
  local dePrice   = nil;
  local auctionWeekPrice = 0;
  local auctionMonthPrice = 0;

  if (AUCTIONATOR_V_TIPS == 1) then vendorPrice = itemVendorPrice; end;
  if (AUCTIONATOR_A_TIPS == 1) then auctionPrice  = Atr_GetAuctionPrice (itemName); end;
  if (AUCTIONATOR_A_WEEK_TIPS == 1) then auctionWeekPrice  = Atr_GetAuctionPeriodPrice (itemName,7); end;
  if (AUCTIONATOR_A_MONTH_TIPS == 1) then auctionMonthPrice  = Atr_GetAuctionPeriodPrice (itemName,30); end;
  if (AUCTIONATOR_D_TIPS == 1) then dePrice   = Atr_CalcDisenchantPrice (classID, itemRarity, itemLevel); end;

  if (num) then
    if (auctionPrice) then  auctionPrice = auctionPrice * num;  end;
    if (vendorPrice)  then  vendorPrice  = vendorPrice  * num;  end;
    if (dePrice)      then  dePrice    = dePrice  * num;  end;
    if (auctionWeekPrice) then  auctionWeekPrice = auctionWeekPrice * num;  end;
    if (auctionMonthPrice) then  auctionMonthPrice = auctionMonthPrice * num;  end;
  end;

  if (vendorPrice == nil) then
    vendorPrice = 0;
  end

  return vendorPrice, auctionPrice, dePrice, auctionWeekPrice, auctionMonthPrice;
end

--get item prices without all the params
function itemPrices(link, num)
  local itemName, itemLink, itemRarity, _, itemMinLevel, itemType, _, _, _, _, itemVendorPrice, classID = GetItemInfo (link);
  local itemLevel = ItemUpgradeInfo:GetUpgradedItemLevel( itemLink )

  if not num then num = 1 end

  return Atr_STWP_GetPrices (link, num, itemVendorPrice, itemName, classID, itemRarity, itemLevel);
end

-----------------------------------------
local item_links = {}
local pet_links = {}

function Atr_ShowTipWithPricing (tip, num)
  local iname, ilink = tip:GetItem()
  local showSomething = AUCTIONATOR_A_TIPS == 1 or AUCTIONATOR_V_TIPS == 1 or AUCTIONATOR_D_TIPS == 1

  --sometimes the item is blank
  if ilink and not isIsBlank(ilink) and showSomething then
    local itemName, itemLink, itemRarity, _, itemMinLevel, itemType, _, _, _, _, itemVendorPrice, classID = GetItemInfo (ilink);
    local itemLevel = ItemUpgradeInfo:GetUpgradedItemLevel( itemLink )
    local xstring = ""

    local showStackPrices = IsShiftKeyDown();
    if (AUCTIONATOR_SHIFT_TIPS == 2) then
      showStackPrices = not IsShiftKeyDown();
    end

    if num then
      if showStackPrices and type(num) == "number" and num > 1 then
        xstring = "|cFFAAAAFF x" .. num .. "|r"
      else
        --return from this function without displaying anything, num is bad
        return
      end
    else
      -- spacing for first render (num is nil)
      tip:AddLine(" ")
    end

    local vendorPrice, auctionPrice, dePrice, auctionWeekPrice, auctionMonthPrice = Atr_STWP_GetPrices (itemLink, num, itemVendorPrice, itemName, classID, itemRarity, itemLevel);

    -- vendor info
    Atr_STWP_AddVendorInfo (tip, xstring, vendorPrice, true)

    -- auction info
    Atr_STWP_AddAuctionInfo (tip, xstring, itemLink, auctionPrice, true)

    -- auction summary
    if auctionPrice and auctionWeekPrice ~= nil and AUCTIONATOR_A_WEEK_TIPS == 1 then
      local left = ZT("Auction").." week"..xstring
      local right = "|cFFFFFFFF"
      if auctionWeekPrice > 0 then
        right = right .. zc.priceToMoneyString(auctionWeekPrice)
      else
        right = right .. "No Data"
      end

      Atr_Tooltip_AddLine(tip,ZT("Auction").." week",left,right, true)
    end

    if auctionPrice and auctionMonthPrice ~= nil and AUCTIONATOR_A_MONTH_TIPS == 1 then
      local left = ZT("Auction").." month"..xstring
      local right = "|cFFFFFFFF"
      if auctionMonthPrice > 0 then
        right = right .. zc.priceToMoneyString(auctionMonthPrice)
      else
        right = right .. "No Data"
      end

      Atr_Tooltip_AddLine(tip,ZT("Auction").." month",left,right, true)
    end

    -- disenchanting info
    Atr_STWP_AddBasicDEInfo (tip, xstring, dePrice, true)

    local showDetails = true;

    if (AUCTIONATOR_DE_DETAILS_TIPS == 1) then showDetails = IsShiftKeyDown(); end;
    if (AUCTIONATOR_DE_DETAILS_TIPS == 2) then showDetails = IsControlKeyDown(); end;
    if (AUCTIONATOR_DE_DETAILS_TIPS == 3) then showDetails = IsAltKeyDown(); end;
    if (AUCTIONATOR_DE_DETAILS_TIPS == 4) then showDetails = false; end;
    if (AUCTIONATOR_DE_DETAILS_TIPS == 5) then showDetails = true; end;

    if (showDetails and dePrice ~= nil) then
      Atr_AddDEDetailsToTip (tip, classID, itemRarity, itemLevel)
    end

    tip:Show()
  end
end

-- add regents and prices to tooltip
function Atr_ShowReagentTooltip(tip, craftType, index, reagent)
  local showSomething = AUCTIONATOR_A_TIPS == 1 or AUCTIONATOR_V_TIPS == 1 or AUCTIONATOR_D_TIPS == 1

  if showSomething and AUCTIONATOR_R_TIPS == 1 then
    tip:AddLine(" ")
    tip:AddLine("|cff69CCF0Reagents:")


    if craftType == "craft" then
      --loop through craft reagents
      local nr = GetCraftNumReagents(index);
      for i = 1,nr  do
        --get the reagent info
        local rname, _, rreq = GetCraftReagentInfo(index,i)
        local rlink = GetCraftReagentItemLink(index,i)
        ReagentLine(tip,rlink,rname,rreq)
        tip:AddLine(" ")
      end
    elseif craftType == "trade" then
      --the items reagents
      local nr = GetTradeSkillNumReagents(index)
      for i=1,nr do
        local rlink = GetTradeSkillReagentItemLink(index,i)
        local rname, _, rreq = GetTradeSkillReagentInfo(index,i)

        ReagentLine(tip,rlink,rname,rreq)
        tip:AddLine(" ")
      end
    end

    --finalize tooltip
    tip:Show()
  end
end

-- add the individual reagent prices
function ReagentLine(tip,rlink,rname,rreq)
  local xstring = ""
  if rreq then
    xstring = "|cFFAAAAFFx" .. rreq .. "|r "
  end
  if rname then
    tip:AddLine("|cFFFFFFFF" .. xstring .. rname)
  end

  -- get prices
  local vendorPrice, auctionPrice, dePrice = itemPrices(rlink,rreq)

  -- vendor info
  Atr_STWP_AddVendorInfo (tip, "", vendorPrice, auctionPrice, false)
  -- auction info
  Atr_STWP_AddAuctionInfo (tip, "", rlink, auctionPrice, false)
  -- disenchanting info
  Atr_STWP_AddBasicDEInfo (tip, "", dePrice, false)
end

--test to see if item link is "[]" which is valid item link but a blank item
function isIsBlank(itemString)
  return strmatch(itemString, "%[%]") and true or false
end

-- find if line with heading already exists
-- if it does replace it with new text
-- if not then add a new line
function Atr_Tooltip_AddLine(tip,lefttext,new_leftext,new_righttext,doreplace)
  local name = tip:GetName()
  local numlines = tip:NumLines()
  local found = false

  if doreplace then
    for i = 1, numlines do
      -- Get a reference to the aligned text on this line:
      local left = _G[name .. "TextLeft" .. i]
      local right = _G[name .. "TextRight" .. i]

      -- check if this is the line we are looking for
      if left:GetText() == lefttext then
        found = true
        left:SetText(new_leftext)
        right:SetText(new_righttext)
      end
    end
  end

  if not found then
    tip:AddDoubleLine(new_leftext,new_righttext)
  end
end

--loops through tooltip lines to get the text and color
function GetTooltipText(tip)
  local name = tip:GetName()
  local numlines = tip:NumLines()
  local lines = {}

  for i = 1, numlines do
    local line = {}
    -- Get a reference to the aligned text on this line:
    local left = _G[name .. "TextLeft" .. i]
    local right = _G[name .. "TextRight" .. i]
    -- store aligned text
    line["left"] = left:GetText() or ""
    line["leftcolor"] = {left:GetTextColor()}

    line["right"] = right:GetText() or ""
    line["rightcolor"] = {right:GetTextColor()}

    -- store line
    lines[i] = line
  end

  return lines
end

--as a last resort this compeltely kills the tooltip then recreates it
--you can then add your own text after and call tooltip:Show()
function ReRenderTooltip(tip)
  local owner = tip:GetOwner()
  local numlines = tip:NumLines()
  local lines = GetTooltipText(tip)

  -- ===== Tooltip force reset =====
  -- we force re render because sometimes tooltip doesn't update even though we call show
  -- this is a lot of work just to force rendering of tooltip, thanks blizzard :D
  if tip:GetNumPoints() > 0 then
    -- store the position
    local point, relativeTo, relativePoint, xOfs, yOfs = tip:GetPoint(1)
    -- this completely clears all tooltip data
    tip:ClearAllPoints()
    -- reset the position
    tip:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
  end

  if owner then
    tip:SetOwner(owner, "ANCHOR_PRESERVE")
  end
  -- ===== Tooltip force reset =====

  -- re render lines
  for i=1, numlines do
    if lines[i]["left"] ~= "" or lines[i]["right"] ~= "" then

      local lcolor = "|cff" .. zc.RGBtoHEX (lines[i]["leftcolor"][1], lines[i]["leftcolor"][2], lines[i]["leftcolor"][3]);
      local rcolor = "|cff" .. zc.RGBtoHEX (lines[i]["rightcolor"][1], lines[i]["rightcolor"][2], lines[i]["rightcolor"][3]);

      if lines[i]["right"] == "" or lines[i]["right"] == nil then
        --alows text to wrap on long lines (descriptions)
        tip:AddLine(lcolor .. lines[i]["left"],1,1,1,1)
      else
        tip:AddDoubleLine(lcolor .. lines[i]["left"],rcolor ..lines[i]["right"])
      end
    end
  end
end

