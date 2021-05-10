
function ActionBarConfigFunc()
	if GetLocale() =='zhCN' then
		BIGFOOTBAR_TITLE = {"动作条增强", "dongzuotiaozengq",2};
		BF_DISTANCE_ALERT = "启用距离提示";
		BF_DISTANCE_ALERT_TOOLTIP="当对目标释放单体技能超出施法范围时，技能图标变为红色。";

	elseif GetLocale() == 'zhTW' then
		BIGFOOTBAR_TITLE = {"動作條增強", "kuaijieliezengq",2};
		BF_DISTANCE_ALERT = "啟用距離提示";
		BF_DISTANCE_ALERT_TOOLTIP="當對目標釋放單體技能超出施法範圍時，技能圖標變為紅色。";
	else
		BIGFOOTBAR_TITLE = "Action Bar Enhance";
		BF_DISTANCE_ALERT = "Show red icon when out of range";
	end

	ModManagement_RegisterMod(
		"ActionBar",
		"Interface\\Icons\\Trade_Engineering",
		BIGFOOTBAR_TITLE,
		"",
		nil,
		nil,
		{[3]=true}
	);

	ModManagement_RegisterCheckBox(
		"ActionBar",
		BF_DISTANCE_ALERT,
		BF_DISTANCE_ALERT_TOOLTIP,
		"EnableDistanceAlert",
		1,
		DistanceAlert_Toggle
	);
end

BigFoot_AddCollector(ActionBarConfigFunc)