
function SystemSetConfigFunc()
	if (GetLocale() == "zhCN") then
		BF_SYSTEM_LASTER_TITLE ={"大脚主设置","!!!",3}

		BF_SYSTEM_LASTER_LOAD="进入世界之后开始载入插件"
		BF_SYSTEM_LASTER_LOAD_TOOLTIP ="选中之后，会在玩家进入世界之后载入插件"

		ErrorFilter_Text="开启红色信息过滤"
		ErrorFilter_TOOLTIP ="过滤显示界面中上方部分的系统红字提示，可以自行设置想要屏蔽的信息"

		ErrorFilter_Set ="设置"

	elseif (GetLocale() == "zhTW") then
		BF_SYSTEM_LASTER_TITLE ={"大腳主設置","!!!",3}

		BF_SYSTEM_LASTER_LOAD="進入世界之後開始載入插件"
		BF_SYSTEM_LASTER_LOAD_TOOLTIP="選中之後，會在玩家進入世界之後載入插件"

		ErrorFilter_Text="開啟红色信息过滤"
		ErrorFilter_TOOLTIP ="過濾顯示介面中上方部份的系統紅字提示，可以自行設置想要屏蔽的信息"

		ErrorFilter_Set ="設置"

	else
		BF_SYSTEM_LASTER_TITLE ={"Bigfoot System Set","!!!"}

		BF_SYSTEM_LASTER_LOAD="load Addon after player inter word"
		BF_SYSTEM_LASTER_LOAD_TOOLTIP ="load Addon after player inter word"

		ErrorFilter_Text="Enable ErrorFilter"
		ErrorFilter_TOOLTIP ="Filters the errors dislayed in the UIErrorsFrame"

		ErrorFilter_Set ="SET"
	end

	ModManagement_RegisterMod(
		"BF_System",
		"Interface\\AddOns\\BigFoot\\Media\\BigFootIcon.tga",
		BF_SYSTEM_LASTER_TITLE,
		"",
		nil,
		nil,
		{[1]=true}
	);

	ModManagement_RegisterCheckBox(
		"BF_System",
		BF_SYSTEM_LASTER_LOAD,
		BF_SYSTEM_LASTER_LOAD_TOOLTIP,
		"EnableLoadLater",
		0,
		function (__arg)
			if __arg ==1 then
				BigFoot_SysTemSetTab.BigFoot_LoadBefore =0;
			else
				BigFoot_SysTemSetTab.BigFoot_LoadBefore =1;
			end
		end,
		nil,
		function(__arg)
			if __arg ==1 then
				BigFoot_SysTemSetTab.BigFoot_LoadBefore =0;
			else
				BigFoot_SysTemSetTab.BigFoot_LoadBefore =1;
			end
		end
	);

	if (IsConfigurableAddOn("ErrorFilter")) then
		ModManagement_RegisterCheckBox(
			"BF_System",
			ErrorFilter_Text,
			ErrorFilter_TOOLTIP,
			"EnableErrorFilter",
			nil,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("ErrorFilter")) then
						BigFoot_LoadAddOn("ErrorFilter");
					end
					if (BigFoot_IsAddOnLoaded("ErrorFilter")) then
						ErrorFilter_Toggle(1)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("ErrorFilter")) then
						ErrorFilter_Toggle()
					end
				end
			end,
			nil,
			function (__arg)
				if (__arg == 1) then
					if (not BigFoot_IsAddOnLoaded("ErrorFilter")) then
						BigFoot_LoadAddOn("ErrorFilter");
					end
					if (BigFoot_IsAddOnLoaded("ErrorFilter")) then
						ErrorFilter_Toggle(1)
					end
				else
					if (BigFoot_IsAddOnLoadedFromBigFoot("ErrorFilter")) then
						ErrorFilter_Toggle()
					end
				end
			end
		);

		ModManagement_RegisterButton(
			"BF_System",
			ErrorFilter_Set,
			function()
				if (BigFoot_IsAddOnLoadedFromBigFoot("ErrorFilter")) then
					ErrorFilter:ShowConfig()
					HideUIPanel(ModManagementFrame);
				end
			end,
			nil,
			1
		);

	end
end

BigFoot_AddCollector(SystemSetConfigFunc)
