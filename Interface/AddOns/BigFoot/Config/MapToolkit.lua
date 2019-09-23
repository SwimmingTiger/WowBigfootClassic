
function MapToolkitConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_MAP_TOOLKIT = {"地图工具", "ditugongju"};

		MAP_PLUS_ENABLE_TEXT = "开启地图标记";
		MAP_PLUS_ENABLE_TEXT_TOOLTIP= "可在地图上需要标记的地方点击鼠标左键创建一个标记";

		MAP_MARK_ENABLE = "开启NPC位置";
		MAP_MARK_ENABLE_TOOLTIP= "在地图上以图标方式显示NPC位置";

		MAP_WORLD_FLIGHT_MAP = "开启世界地图飞行点";
		MAP_WORLD_FLIGHT_MAP_TOOLTIP = "";
		MAP_SEXY_MINIMAP = "开启小地图美化"

		ENABLE_ARCHY_TEXT ="启用考古助手"
		ARCHY_DISABLE_DELAY_TEXT = "|cff00c0c0<考古助手>|r 你已经关闭考古助手(Archy)模块，该设置将在下次插件载入时生效。";

		ENABLE_RANGEDISPLAY_TEXT ="启用距离显示";
		ENABLE_RANGEDISPLAY_TEXT_TOOLTIP="显示玩家目标，焦点目标，鼠标悬停目标与玩家之间的距离数值";
		RANGEDISPLAY_DISABLE_DELAY_TEXT = "|cff00c0c0<距离显示>|r 你已经关闭距离显示(RangeDisplay)模块，该设置将在下次插件载入时生效。";

	elseif (GetLocale() == "zhTW") then
		MOD_MAP_TOOLKIT = {"地圖工具", "ditugongju"};

		MAP_PLUS_ENABLE_TEXT = "開啟地圖標記";
		MAP_PLUS_ENABLE_TEXT_TOOLTIP="可在地圖上需要標記的地方那個點擊鼠標鄒建左鍵創建一個標記"

		MAP_MARK_ENABLE = "開啟NPC位置";
		MAP_MARK_ENABLE_TOOLTIP= "在地圖上以圖表方式顯示NPC位置";

		MAP_WORLD_FLIGHT_MAP = "開啟世界地圖飛行點";
		MAP_WORLD_FLIGHT_MAP_TOOLTIP = "";
		MAP_SEXY_MINIMAP = "開啟小地圖美化"

		ENABLE_ARCHY_TEXT ="啟用考古助手"
		ARCHY_DISABLE_DELAY_TEXT = "|cff00c0c0<考古助手>|r 你已經關閉考古助手(Archy)模塊，該設置將在下次插件載入時生效。";

		ENABLE_RANGEDISPLAY_TEXT ="啟用距離顯示";
		ENABLE_RANGEDISPLAY_TEXT_TOOLTIP="顯示玩家目標，焦點目標，鼠標懸停目標與玩家之間的距離數值";
		RANGEDISPLAY_DISABLE_DELAY_TEXT = "|cff00c0c0<距離顯示>|r 你已經關閉距離顯示(RangeDisplay)模塊，該設置將在下次插件載入時生效。";
	else
		MOD_MAP_TOOLKIT = "Map Toolkit";
		MAP_PLUS_ENABLE_TEXT = "Enable Map Note";
		MAP_MARK_ENABLE = "Enable NPC locations";

		MAP_WORLD_FLIGHT_MAP = "Enable World Flight Map";
		MAP_SEXY_MINIMAP = "Enable Sexy Minimap"

		ENABLE_RANGEDISPLAY_TEXT ="Enable Range Display";
	end

	if IsConfigurableAddOn("MapPlus") or IsConfigurableAddOn("BigFootMark") or IsConfigurableAddOn("Archy")  or IsConfigurableAddOn("SexyMap") or IsConfigurableAddOn("RangeDisplay") or IsConfigurableAddOn("Mapster") or IsConfigurableAddOn("WorldFlightMap") then
		ModManagement_RegisterMod(
			"MapToolkit",
			"Interface\\Icons\\trade_engineering",
			MOD_MAP_TOOLKIT,
			nil,
			nil,
			nil,
			{[6]=true}
		);
	end

	if (IsConfigurableAddOn("RangeDisplay")) then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			ENABLE_RANGEDISPLAY_TEXT,
			ENABLE_RANGEDISPLAY_TEXT_TOOLTIP,
			"EnableRangeDisplay",
			0,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("RangeDisplay")) then
						BigFoot_LoadAddOn("RangeDisplay");
						RangeDisplay:toggleLocked(true)
					end
				else
					if (BigFoot_IsAddOnLoaded("RangeDisplay")) then
						BigFoot_RequestReloadUI(function() BigFoot_Print(RANGEDISPLAY_DISABLE_DELAY_TEXT); end);
					end
				end
			end
		);
	end

	-- if (IsConfigurableAddOn("Archy")) then
		-- ModManagement_RegisterCheckBox(
			-- "MapToolkit",
			-- ENABLE_ARCHY_TEXT,
			-- nil,
			-- "EnableArchy",
			-- nil,
			-- function (__arg)
				-- if (__arg == 1) then
					-- if (not BigFoot_IsAddOnLoaded("Archy")) then
						-- BigFoot_LoadAddOn("Archy");
					-- end
				-- else
					-- if (BigFoot_IsAddOnLoaded("Archy")) then
						-- BigFoot_RequestReloadUI(function() BigFoot_Print(ARCHY_DISABLE_DELAY_TEXT); end);
					-- end
				-- end
			-- end
		-- );
	-- end

	if (IsConfigurableAddOn("MapPlus")) then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_PLUS_ENABLE_TEXT,
			MAP_PLUS_ENABLE_TEXT_TOOLTIP,
			"EnableMapPlus",
			0,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("MapPlus")) then
						BigFoot_LoadAddOn("MapPlus");
					end
				end
				if BigFoot_IsAddOnLoaded("MapPlus") then
					MapPlus_ToggleEnable(__arg)
				end
			end
		);
	end

	if IsConfigurableAddOn("BigFootMark") and (GetLocale()=="zhCN" or GetLocale()=="zhTW") then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_MARK_ENABLE,
			MAP_MARK_ENABLE_TOOLTIP,
			"MapMarkEnable",
			1,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("BigFootMark")) then
						BigFoot_LoadAddOn("BigFootMark");
					end
					BFM_ToggleEnable(1)
				else
					if BigFoot_IsAddOnLoaded("BigFootMark") then
						BFM_ToggleEnable(0)
					end
				end
			end
		);
	end

	if IsConfigurableAddOn("WorldFlightMap") then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_WORLD_FLIGHT_MAP,
			MAP_WORLD_FLIGHT_MAP_TOOLTIP,
			"MapWordFlight",
			1,
			function (__arg)
				if (__arg == 1)then
					if (not BigFoot_IsAddOnLoaded("WorldFlightMap")) then
						BigFoot_LoadAddOn("WorldFlightMap");
					end
				else
					BigFoot_RequestReloadUI()
				end
			end,
			nil,
			function (__arg)
				if (__arg == 1)then
					if (not BigFoot_IsAddOnLoaded("WorldFlightMap")) then
						BigFoot_LoadAddOn("WorldFlightMap");
					end
				end
			end
		);
	end

	if IsConfigurableAddOn("SexyMap") then
		ModManagement_RegisterCheckBox(
			"MapToolkit",
			MAP_SEXY_MINIMAP,
			nil,
			"MapSexyMinimap",
			0,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("SexyMap")) then
						BigFoot_LoadAddOn("SexyMap");
					end
				else
					BigFoot_RequestReloadUI();
				end
			end,
			nil,
			function (__arg)
				if (__arg==1)then
					if (not BigFoot_IsAddOnLoaded("SexyMap")) then
						BigFoot_LoadAddOn("SexyMap");
					end
				else
					if Minimap then
						Minimap:SetMaskTexture([[Textures\MinimapMask]]);
					end
				end
			end
		);
	end
end

BigFoot_AddCollector(MapToolkitConfigFunc)