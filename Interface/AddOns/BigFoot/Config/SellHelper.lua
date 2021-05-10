
function SellHelperConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_SELLER_HELPER_TITLE = {"售卖助手", "shoumaizhushou"}

		SELLER_HELPER_TITLE = "售卖助手";

		SELLER_HELPER_ENABLE_TEXT = "开启售卖助手";

		SELLER_HELPER_AUTO_SELL_POOR_TEXT = "自动售卖粗糙物品";

		SELLER_HELPER_SELL_ACCEPT_TEXT = "立刻出售售卖列表中的物品";

		SELLER_HELPER_AR_ACCEPT_TEXT = "自动购买物品时给予确认提示";

		SellerHelperNotSellSet ="设置例外物品";

		SELLER_HELPER_KEEP_DALARAN_COIN_TEXT = "不出售达拉然钓鱼硬币";

		SELLER_HELPER_KEEP_MINING_TOOL_TEXT = "不出售暗血矿工锄";

		SELLER_HELPER_ANNOUNCE_TEXT = "显示售卖统计";
		SELLER_HELPER_ANNOUNCE_TEXT_TOOLTIP="在交易完成后聊天窗口进行提示"

		SELLER_HELPER_AUTO_RECHARGE = "启用购买助手";
		SELLER_HELPER_AUTO_RECHARGE_TOOLTIP="在与NPC交易时自动购买NPC身上指定的物品"

	elseif (GetLocale() == "zhTW") then
		MOD_SELLER_HELPER_TITLE = {"售賣助手", "shoumaizhushou"}

		SELLER_HELPER_TITLE = "售賣助手";

		SELLER_HELPER_ENABLE_TEXT = "開啟售賣助手";
		SellerHelperNotSellSet="設置例外物品"
		SELLER_HELPER_AUTO_SELL_POOR_TEXT = "自動出售粗糙物品";

		SELLER_HELPER_SELL_ACCEPT_TEXT = "立刻出售售賣列裱中的物品";

		SELLER_HELPER_AR_ACCEPT_TEXT = "自動購買物品時給予確認提示";

		SELLER_HELPER_KEEP_DALARAN_COIN_TEXT = "不出售達拉然釣魚硬幣";

		SELLER_HELPER_KEEP_MINING_TOOL_TEXT = "不出售暗血礦工鋤";

		SELLER_HELPER_ANNOUNCE_TEXT = "顯示售賣統計";
		SELLER_HELPER_ANNOUNCE_TEXT_TOOLTIP= "在交易完成后聊天窗口進行提示";

		SELLER_HELPER_AUTO_RECHARGE = "啟用購買助手";
		SELLER_HELPER_AUTO_RECHARGE_TOOLTIP= "在與NPC交易時自動購買NPC上指定的物品";
	else
		MOD_SELLER_HELPER_TITLE = "Seller Helper"

		SELLER_HELPER_TITLE = "Seller Helper";
		SellerHelperNotSellSet = "SellerHelperNotSellSet"
		SELLER_HELPER_ENABLE_TEXT = "Enable Seller Helper";

		SELLER_HELPER_AUTO_SELL_POOR_TEXT = "Sell crappy items automatically";

		SELLER_HELPER_SELL_ACCEPT_TEXT = "Sell items in auto list";

		SELLER_HELPER_AR_ACCEPT_TEXT = "Need confirm when auto buy";

		SELLER_HELPER_KEEP_DALARAN_COIN_TEXT = "Do not sell Dalaran Coins";

		SELLER_HELPER_KEEP_MINING_TOOL_TEXT = "Do not sell mining tools";

		SELLER_HELPER_ANNOUNCE_TEXT = "Show trade gains";

		SELLER_HELPER_AUTO_RECHARGE = "Enable Auto Recharge";
	end

	if (IsConfigurableAddOn("SellerHelper")) then
		ModManagement_RegisterMod(
			"SellerHelper",
			"Interface\\Icons\\INV_Misc_Coin_03",
			MOD_SELLER_HELPER_TITLE,
			"",
			nil,
			nil,
			{[5]=true}
		);

		ModManagement_RegisterCheckBox(
			"SellerHelper",
			SELLER_HELPER_ENABLE_TEXT,
			nil,
			"EnableSellerHelper",
			1,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("SellerHelper")) then
						BigFoot_LoadAddOn("SellerHelper");
					end
				end
				if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					SellHelper_EnableToggle(__arg);
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"SellerHelper",
			SELLER_HELPER_AUTO_SELL_POOR_TEXT,
			nil,
			"AutoSellPoor",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					SellHelper_SellGrayToggle(__arg);
				end
			end,
			1
		);

		ModManagement_RegisterButton(
			"SellerHelper",
			SellerHelperNotSellSet,
			function ()
				HideUIPanel(ModManagementFrame);
				SellerHelperSetFrame:Show()
				SellerHelperSetFrame:SetFrameLevel(MerchantFrame:GetFrameLevel())
				-- MerchantFrame SetFrameLevel
			end,
			nil,
			2
		);

		ModManagement_RegisterCheckBox(
			"SellerHelper",
			SELLER_HELPER_SELL_ACCEPT_TEXT,
			nil,
			"SellAccept",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					SellHelper_SellAcceptToggle(__arg);
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"SellerHelper",
			SELLER_HELPER_AR_ACCEPT_TEXT,
			nil,
			"ARAccept",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					AR_AcceptToggle(__arg);
				end
			end,
			1
		);

		-- ModManagement_RegisterCheckBox(
			-- "SellerHelper",
			-- SELLER_HELPER_KEEP_DALARAN_COIN_TEXT,
			-- nil,
			-- "KeepDalarancoin",
			-- 1,
			-- function (__arg)
				-- if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					-- SellHelper_KeepDalarancoin(__arg);
				-- end
			-- end,
			-- 1
		-- );

		-- ModManagement_RegisterCheckBox(
			-- "SellerHelper",
			-- SELLER_HELPER_KEEP_MINING_TOOL_TEXT,
			-- nil,
			-- "KeepMiningTool",
			-- 1,
			-- function (__arg)
				-- if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					-- SellHelper_KeepMiningToggle(__arg);
				-- end
			-- end,
			-- 1
		-- );

		ModManagement_RegisterCheckBox(
			"SellerHelper",
			SELLER_HELPER_ANNOUNCE_TEXT,
			SELLER_HELPER_ANNOUNCE_TEXT_TOOLTIP,
			"ShowTradeAnnounce",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					SellHelper_SellAnnounceToggle(__arg)
				end
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"SellerHelper",
			SELLER_HELPER_AUTO_RECHARGE,
			SELLER_HELPER_AUTO_RECHARGE_TOOLTIP,
			"EnableAutoRecharge",
			1,
			function (__arg)
				if (BigFoot_IsAddOnLoaded("SellerHelper")) then
					AR_Toggle(__arg)
				end
			end,
			1
		);

	end
end

BigFoot_AddCollector(SellHelperConfigFunc)