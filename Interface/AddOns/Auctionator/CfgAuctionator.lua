U1RegisterAddon("Auctionator", {
    title = "拍卖行助手",
    tags = { TAG_TRADING, },
    desc = "拍卖行助手",
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Misc_Coin_02]],
    nopic = 1,
    conflicts = { "AuctionLite", },

    toggle = function(name, info, enable, justload)
        if Atr_ShowTipWithPricing then
            hooksecurefunc("Atr_ShowTipWithPricing", function(tip, link, num)
                if U1GetCfgValue("Auctionator", "detailed_tip") then
                    if link and num and num > 1 then
                        local itemName, _, _, _, _, _, _, _, _, _, itemVendorPrice = GetItemInfo (link);
                        if (AUCTIONATOR_SHIFT_TIPS == 2 and IsShiftKeyDown()) or not IsShiftKeyDown() then
                            if itemVendorPrice and itemVendorPrice > 0 then
                                Atr_STWP_AddVendorInfo(tip, "|cFFAAAAFF x" .. num .. "|r", itemVendorPrice * num);
                            end
                            local ap = Atr_GetAuctionPrice(itemName);
                            if ap then
                                Atr_STWP_AddAuctionInfo(tip, "|cFFAAAAFF x" .. num .. "|r", link, ap * num);
                            end
                        else
                            if itemVendorPrice and itemVendorPrice > 0 then
                                Atr_STWP_AddVendorInfo(tip, "", itemVendorPrice);
                            end
                            local ap = Atr_GetAuctionPrice(itemName);
                            if ap then
                                Atr_STWP_AddAuctionInfo(tip, "", link, ap);
                            end
                        end
                        tip:Show();
                    end
                end
            end);

        end
        hooksecurefunc("Atr_Init", function()
            if Atr_FullScanButton then
                Atr_FullScanButton._Show = Atr_FullScanButton.Show;
                Atr_FullScanButton.Show = function() end;
                Atr_FullScanButton._Hide = Atr_FullScanButton.Hide;
                Atr_FullScanButton.Hide = function() end;
                Atr_FullScanButton._SetParent = Atr_FullScanButton.SetParent;
                Atr_FullScanButton.SetParent = function() end;
                Atr_FullScanButton:_Show();
                Atr_FullScanButton:ClearAllPoints();
                Atr_FullScanButton:SetPoint("RIGHT", AuctionFrameCloseButton, "LEFT", -6, 0);
                Atr_FullScanButton:_SetParent(AuctionFrame);
                Auctionator1Button:ClearAllPoints();
                Auctionator1Button:SetPoint("TOP", Atr_FullScanButton, "BOTTOM", 0, -4);
            end
        end);
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("Auctionator")
        end
    },

    {
        var = 'detailed_tip',
        text = '显示详细价格',
        tip = '\124cff00ff00勾选之后会显示单个价格和成组或者当前堆叠数量的价格\124r`\124cffff0000取消勾选将只显示插件设置里选择的显示选项\124r',
        default = true,
        callback = function() return true end,
    },

});
