local BFRECOUNT_TOGGLE_TEXT 
local BFRECOUNT_TITLE="Recount"
if (GetLocale() == "zhTW") then
	BFRECOUNT_TOGGLE_TEXT="點擊切換打開/關閉Recount"
elseif(GetLocale() == "zhCN") then
	BFRECOUNT_TOGGLE_TEXT="点击切换打开/关闭Recount"
else
	BFRECOUNT_TOGGLE_TEXT="Click to toggle Recount"
end

local LDB = LibStub("LibDataBroker-1.1", true)
if not LDB then return end

local RecountLauncher = LDB:NewDataObject("Recount", {
	type = "launcher",
	icon = "Interface\\Icons\\inv_misc_book_12",
	label = BFRECOUNT_TOGGLE_TEXT,
	OnClick = function(clickedframe)
		if Recount.MainWindow:IsShown() then 
			Recount.MainWindow:Hide() 
		else 
			Recount.MainWindow:SetClampedToScreen(true);
			Recount.MainWindow:Show();
			Recount:RefreshMainWindow() 
		end
	end,
	OnTooltipShow = function(tt)
		tt:AddLine(BFRECOUNT_TITLE)
		tt:AddLine(BFRECOUNT_TOGGLE_TEXT)
	end,
})

local BFRecountLDBIcon = LibStub("LibDBIcon-1.0", true)
if not BFRecountLDBIcon then return end

hooksecurefunc(Recount,"OnInitialize",function(self)
	self.db.profile.minimap = self.db.profile.minimap or { 
		hide = false,
		minimapPos = 220,
		radius = 80,
	}
	BFRecountLDBIcon:Register("Recount", RecountLauncher, self.db.profile.minimap)
end)