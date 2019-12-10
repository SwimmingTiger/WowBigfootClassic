
-------------------------------------------------------
-- BigFootPatch.lua
-- AndyXiao@BigFoot
-- 本文件是用来修正一些来自WoW本身Interface的问题
-------------------------------------------------------

-- 屏蔽界面失效的提醒
do
	UIParent:UnregisterEvent("ADDON_ACTION_BLOCKED");
	_G["ChatFrameEditBox"] = _G["ChatFrame1EditBox"]
end

--支持可以从团队框体直接选择
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event,...)
		if event == "ADDON_LOADED" and select(1,...) == "Blizzard_RaidUI" then
			BigFoot_DelayCall(BFSecureCall,1,function ()
				for i=1,40 do
					local raidbutton = getglobal("RaidGroupButton"..i);
					if(raidbutton and raidbutton.unit) then
						raidbutton:SetAttribute("type", "target");
						raidbutton:SetAttribute("unit", raidbutton.unit);
					end
				end
			end)
			f:UnregisterEvent("ADDON_LOADED")
		end
	end)
end

--QuickLoot中当拾取到空尸体的时候自动隐藏LootFrame 的逻辑移到这里
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("LOOT_READY")
	f:SetScript("OnEvent",function(self,event)
		if ( GetNumLootItems() == 0 ) then
			HideUIPanel(LootFrame);
		end
	end)
end

-- 修改系统ADDON_ACTION_FORBIDDEN逻辑
do
	UIParent:UnregisterEvent("ADDON_ACTION_FORBIDDEN");

	StaticPopupDialogs["BF_ADDON_ACTION_FORBIDDEN"] = {
		text = ADDON_ACTION_FORBIDDEN,
		button1 = RELOADUI,
		button2 = IGNORE_DIALOG,
		OnAccept = function(self, data)
			ReloadUI();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};

	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	f:SetScript("OnEvent", function(self, event, ...)
		local FORBIDDEN_ADDON,FORBIDDEN_FUNCTION = ...;
		StaticPopup_Show("BF_ADDON_ACTION_FORBIDDEN", FORBIDDEN_ADDON);
	end)
end

-- 设置一些常用的cvar
do
	local LoaderFrame = CreateFrame("FRAME")
	LoaderFrame:RegisterEvent("PLAYER_LOGIN")
	local function LoaderEvents(frame, event, arg1)
		frame:UnregisterEvent("PLAYER_LOGIN")

		local patchVersion = '2019-09-05-04'
		if (BF_Frames_Config['UtilsPatchVersion'] ~= patchVersion) then

			SetCVar("autoLootRate", "0")						--移除自动拾取多件物品时的延迟
			SetCVar("lootUnderMouse", "1")						--鼠标位置打开拾取
			SetCVar("instantQuestText", "1")					--立即显示任务文本
			SetCVar("nameplateMaxDistance", "6e1")              --扩大姓名板显示范围到60码
			SetCVar("ShowClassColorInNameplate", "1")			--显示姓名版职业颜色
			SetCVar("ShowClassColorInFriendlyNameplate", "1")	--显示友方姓名版职业颜色
			SetCVar("chatClassColorOverride", "0")				--显示聊天职业颜色

			BF_Frames_Config['UtilsPatchVersion'] = patchVersion
			print("大脚插件个人整合包：初始化完成")
		end

		local patchVersion = '2019-12-11-06'
		Combuctor_Sets = Combuctor_Sets or {}
		if (Combuctor_Sets['CombuctorPatchVersion'] ~= patchVersion) then
			Combuctor_Sets = {}
			Combuctor_Sets['CombuctorPatchVersion'] = patchVersion

			StaticPopupDialogs["RELOADUI_COMBUCTOR"] = {
				text = "背包整合插件已更新，为了防止背包出错，需要重载界面。",
				button1 = YES,
				OnAccept = function()
					ReloadUI()
				end,
				showAlert = 1,
				timeout = 0,
				hideOnEscape = false
			}
			BigFoot_DelayCall(function() StaticPopup_Show("RELOADUI_COMBUCTOR") end, 1)
		end
	end
	LoaderFrame:SetScript("OnEvent", LoaderEvents)
end

-- 背包显示剩余格子数量(同步正式服设置)
hooksecurefunc("MainMenuBarBackpackButton_UpdateFreeSlots", function(...)
	MainMenuBarBackpackButtonCount:SetText(string.format("(%s)", MainMenuBarBackpackButton.freeSlots));
end)

