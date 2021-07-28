select(2, ...) 'aux'

local gui = require 'aux.gui'
local scan = require 'aux.core.scan'
local post = require 'aux.tabs.post'
local search = require 'aux.tabs.search'

function event.AUX_LOADED()
	for _, v in ipairs(tab_info) do
		tabs:create_tab(v.name)
	end
end

do
	local frame = CreateFrame('Frame', 'aux_frame', UIParent, 'BackdropTemplate')
	tinsert(UISpecialFrames, 'aux_frame')
	gui.set_window_style(frame)
	gui.set_size(frame, 768, 447)
	frame:SetPoint('LEFT', 100, 0)
	frame:SetToplevel(true)
	frame:SetMovable(true)
	frame:EnableMouse(true)
    frame:RegisterForDrag('LeftButton')
    frame:SetScript('OnDragStart', frame.StartMoving)
    frame:SetScript('OnDragStop', frame.StopMovingOrSizing)
	frame:SetClampedToScreen(true)
--	frame:CreateTitleRegion():SetAllPoints() TODO classic why
	frame:SetScript('OnShow', function() PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN) end)
	frame:SetScript('OnHide', function() PlaySound(SOUNDKIT.AUCTION_WINDOW_CLOSE); CloseAuctionHouse() end)
	frame.content = CreateFrame('Frame', nil, frame)
	frame.content:SetPoint('TOPLEFT', 4, -80)
	frame.content:SetPoint('BOTTOMRIGHT', -4, 35)
	frame:Hide()
	M.frame = frame
end
do
    local status_bar = gui.status_bar(frame.content)
    status_bar:SetWidth(265)
    status_bar:SetHeight(27)
    status_bar:SetPoint('TOPLEFT', frame.content, 'BOTTOMLEFT', 0, -3)
    status_bar:update_status(1, 1)
    M.status_bar = status_bar
end
do
	tabs = gui.tabs(frame, 'DOWN')
	tabs._on_select = on_tab_click
	function M.set_tab(id) tabs:select(id) end
end
do
	local btn = gui.button(frame)
	btn:SetPoint('BOTTOMRIGHT', -5, 5)
	gui.set_size(btn, 60, 24)
	btn:SetText('退出')
	btn:SetScript('OnClick', function() frame:Hide() end)
	close_button = btn
end
do
	local btn = gui.button(frame, gui.font_size.small)
	btn:SetPoint('RIGHT', close_button, 'LEFT' , -5, 0)
	gui.set_size(btn, 60, 24)
	btn:SetText(color.blizzard'暴雪UI')
	btn:SetScript('OnClick',function()
		if AuctionFrame:IsVisible() then
            AuctionFrame_Hide()
        else
            AuctionFrame_Show()
        end
	end)
    blizzard_button = btn
end
do
    local btn = gui.button(frame)
    btn:SetPoint('RIGHT', blizzard_button, 'LEFT' , -5, 0)
    gui.set_size(btn, 60, 24)
    btn:SetText('扫描')
    btn:SetScript('OnUpdate', function(self)
        if select(2, CanSendAuctionQuery()) then
            self:Enable()
            self:SetBackdropColor(color.state.enabled())
        else
            self:Enable()
            self:SetBackdropColor(color.content.background())
        end
    end)
    btn:SetScript('OnEnter', function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:AddLine("15分钟内只能扫描拍卖行一次。\n由于服务器Bug，你在关闭拍卖行界面前可以无限次扫描，\n但是关闭后必须等15分钟才能扫描。\n如果关闭拍卖行界面后15分钟内想再次扫描，请重启游戏。", 1, 1, 1)
        GameTooltip:Show()
    end)
    btn:SetScript('OnLeave', function(self)
        GameTooltip:Hide()
    end)
    StaticPopupDialogs["AUX_ADDON_CANNOT_SCAN"] = {
        text = "为了防止扫描时卡死，请先在小地图大脚按键包内取消勾选“拍卖大师”插件",
        button1 = "我知道了",
        showAlert = 1,
        timeout = 0,
        hideOnEscape = 1,
        preferredIndex = STATICPOPUP_NUMDIALOGS
    }
    btn:SetScript('OnClick', function()
        if IsAddOnLoaded("Auctionator") then
            StaticPopup_Show("AUX_ADDON_CANNOT_SCAN")
            return
        end
        local total
        local count = 0
        scan.start{
            type = 'list',
            queries = {{blizzard_query = {}}},
            get_all = true,
            on_scan_start = function()
                status_bar:update_status(0, 0)
                post.clear_auctions()
                search.clear_selection()
            end,
            on_page_loaded = function(_, _, _, page_size)
                total = page_size
            end,
            on_auction = function(auction_record)
                count = count + 1
                status_bar:update_status(count / total, 0)
                post.record_auction(auction_record)
            end,
            on_abort = function()
                status_bar:update_status(1, 1)
            end,
            on_complete = function()
                status_bar:update_status(1, 1)
            end,
        }
    end)
end
