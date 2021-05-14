select(2, ...) 'aux.tabs.post'

local aux = require 'aux'
local info = require 'aux.util.info'
local money = require 'aux.util.money'
local gui = require 'aux.gui'
local listing = require 'aux.gui.listing'
local item_listing = require 'aux.gui.item_listing'
local search_tab = require 'aux.tabs.search'

frame = CreateFrame('Frame', nil, aux.frame)
frame:SetAllPoints()
frame:SetScript('OnUpdate', on_update)
frame:Hide()

frame.content = CreateFrame('Frame', nil, frame)
frame.content:SetPoint('TOP', frame, 'TOP', 0, -8)
frame.content:SetPoint('BOTTOMLEFT', aux.frame.content, 'BOTTOMLEFT', 0, 0)
frame.content:SetPoint('BOTTOMRIGHT', aux.frame.content, 'BOTTOMRIGHT', 0, 0)

frame.inventory = gui.panel(frame.content)
frame.inventory:SetWidth(212)
frame.inventory:SetPoint('TOPLEFT', 0, 0)
frame.inventory:SetPoint('BOTTOMLEFT', 0, 0)

frame.parameters = gui.panel(frame.content)
frame.parameters:SetHeight(173)
frame.parameters:SetPoint('TOPLEFT', frame.inventory, 'TOPRIGHT', 2.5, 0)
frame.parameters:SetPoint('TOPRIGHT', 0, 0)

frame.bid_listing = gui.panel(frame.content)
frame.bid_listing:SetHeight(228)
frame.bid_listing:SetWidth(271.5)
frame.bid_listing:SetPoint('BOTTOMLEFT', frame.inventory, 'BOTTOMRIGHT', 2.5, 0)

frame.buyout_listing = gui.panel(frame.content)
frame.buyout_listing:SetHeight(228)
frame.buyout_listing:SetWidth(271.5)
frame.buyout_listing:SetPoint('BOTTOMRIGHT', 0, 0)

do
    local checkbox = gui.checkbox(frame.inventory)
    checkbox:SetPoint('TOPLEFT', 49, -15)
    checkbox:SetScript('OnClick', function()
        refresh = true
    end)
    local label = gui.label(checkbox, gui.font_size.small)
    label:SetPoint('LEFT', checkbox, 'RIGHT', 4, 1)
    label:SetText('显示隐藏物品')
    show_hidden_checkbox = checkbox
end

gui.horizontal_line(frame.inventory, -45)

do
	local f = CreateFrame('Frame', nil, frame.inventory)
	f:SetPoint('TOPLEFT', 0, -51)
	f:SetPoint('BOTTOMRIGHT', 0, 0)
	inventory_listing = item_listing.new(
		f,
	    function(self, button)
	        if button == 'LeftButton' then
	            update_item(self.item_record)
	        elseif button == 'RightButton' then
	            aux.set_tab(1)
	            search_tab.set_filter(strlower(info.item(self.item_record.item_id).name) .. '/exact')
	            search_tab.execute(nil, false)
	        end
	    end,
	    function(item_record)
	        return item_record == selected_item
	    end
	)
end

bid_listing = listing.new(frame.bid_listing)
bid_listing:SetColInfo{
    {name='拍卖数', width=.17, align='CENTER'},
    {name='剩余\n时间', width=.11, align='CENTER'},
    {name='堆叠\n数量', width=.11, align='CENTER'},
    {name='竞拍\n(每组)', width=.4, align='RIGHT'},
    {name='% 价格\n对比', width=.21, align='CENTER'},
}
bid_listing:SetSelection(function(data)
	return selected_item and (data.record == get_bid_selection() or data.record.historical_value and get_bid_selection() and get_bid_selection().historical_value)
end)
bid_listing:SetHandler('OnClick', function(table, row_data, column, button)
	if button == 'RightButton' and row_data.record == get_bid_selection() or row_data.record.historical_value and get_bid_selection() and get_bid_selection().historical_value then
		set_bid_selection()
	else
		set_bid_selection(row_data.record)
	end
	refresh = true
end)
bid_listing:SetHandler('OnDoubleClick', function(table, row_data, column, button)
	stack_size_slider:SetValue(row_data.record.stack_size)
	refresh = true
end)

buyout_listing = listing.new(frame.buyout_listing)
buyout_listing:SetColInfo{
    {name='拍卖数', width=.17, align='CENTER'},
    {name='剩余\n时间', width=.11, align='CENTER'},
    {name='堆叠\n数量', width=.12, align='CENTER'},
    {name='一口价\n(每件)', width=.4, align='RIGHT'},
    {name='% 价格\n对比', width=.20, align='CENTER'},
}
buyout_listing:SetSelection(function(data)
	return selected_item and (data.record == get_buyout_selection() or data.record.historical_value and get_buyout_selection() and get_buyout_selection().historical_value)
end)
buyout_listing:SetHandler('OnClick', function(table, row_data, column, button)
	if button == 'RightButton' and row_data.record == get_buyout_selection() or row_data.record.historical_value and get_buyout_selection() and get_buyout_selection().historical_value then
		set_buyout_selection()
	else
		set_buyout_selection(row_data.record)
	end
	refresh = true
end)
buyout_listing:SetHandler('OnDoubleClick', function(table, row_data, column, button)
	stack_size_slider:SetValue(row_data.record.stack_size)
	refresh = true
end)

do
    local btn = gui.button(frame.parameters)
    btn:SetPoint('LEFT', aux.status_bar, 'RIGHT', 5, 0)
    btn:SetText('发布')
    btn:SetScript('OnClick', post_auction)
    post_button = btn
end
do
    local btn = gui.button(frame.parameters)
    btn:SetPoint('TOPLEFT', post_button, 'TOPRIGHT', 5, 0)
    btn:SetText('刷新')
    btn:SetScript('OnClick', refresh_button_click)
    refresh_button = btn
end
do
	item = gui.item(frame.parameters)
    item:SetPoint('TOPLEFT', 10, -6)
    item.button:SetScript('OnEnter', function(self)
        if selected_item then
            info.set_tooltip(selected_item.link, self, 'ANCHOR_RIGHT')
        end
    end)
    item.button:SetScript('OnLeave', function()
        GameTooltip:Hide()
    end)
    local function select_cursor_item()
        local type, item_id, item_link = GetCursorInfo()
        if type == 'item' then
            local _, suffix_id = info.parse_link(item_link)
            select_item(item_id .. ':' .. suffix_id)
            ClearCursor()
        end
    end
    item.button:HookScript('OnReceiveDrag', select_cursor_item)
    item.button:HookScript('OnMouseDown', select_cursor_item)
    item.button:HookScript('OnClick', select_cursor_item)
end
do
    local slider = gui.slider(frame.parameters)
    slider:SetValueStep(1)
    slider:SetPoint('TOPLEFT', 13, -73)
    slider:SetWidth(190)
    slider:SetScript('OnValueChanged', function(_, _, is_user_input)
--        if is_user_input then -- TODO need to solve issue of slider click not counting as user input
            quantity_update(true)
            refresh = true
--        end
    end)
    slider.editbox.change = function(self, is_user_input)
        if is_user_input then
            slider:SetValue(self:GetNumber())
            quantity_update(true)
        end
    end
    slider.editbox:SetScript('OnTabPressed', function()
        if not IsShiftKeyDown() then
            stack_count_slider.editbox:SetFocus()
        end
    end)
    slider.editbox:SetNumeric(true)
    slider.editbox:SetMaxLetters(3)
    slider.editbox.reset_text = '1'
    slider.label:SetText('堆叠数量')
    stack_size_slider = slider
end
do
    local slider = gui.slider(frame.parameters)
    slider:SetValueStep(1)
    slider:SetPoint('TOPLEFT', stack_size_slider, 'BOTTOMLEFT', 0, -32)
    slider:SetWidth(190)
    slider:SetScript('OnValueChanged', function(_, _, is_user_input)
--        if is_user_input then
            quantity_update()
--        end
    end)
    slider.editbox.change = function(self, is_user_input)
        if is_user_input then
            slider:SetValue(self:GetNumber())
            quantity_update()
        end
    end
    slider.editbox:SetScript('OnTabPressed', function()
        if IsShiftKeyDown() then
            stack_size_slider.editbox:SetFocus()
        else
            duration_dropdown:SetFocus()
        end
    end)
    slider.editbox:SetNumeric(true)
    slider.label:SetText('组数')
    stack_count_slider = slider
end
do
    local dropdown = gui.dropdown(frame.parameters, gui.font_size.large)
    dropdown.selection_change = function() duration_selection_change() end
    dropdown:SetPoint('TOPLEFT', stack_count_slider, 'BOTTOMLEFT', 0, -25)
    dropdown:SetWidth(90)
    dropdown:SetHeight(22)
    dropdown:SetFontSize(17)
    dropdown:SetScript('OnTabPressed', function()
        if IsShiftKeyDown() then
            stack_count_slider.editbox:SetFocus()
        else
            unit_start_price_input:SetFocus()
        end
    end)
    local label = gui.label(dropdown, gui.font_size.small)
    label:SetPoint('BOTTOMLEFT', dropdown, 'TOPLEFT', -2, 1)
    label:SetText('持续时间')
    duration_dropdown = dropdown
end
do
    local checkbox = gui.checkbox(frame.parameters)
    checkbox:SetPoint('TOPRIGHT', -83, -6)
    checkbox:SetScript('OnClick', function(self)
        local settings = read_settings()
        settings.hidden = self:GetChecked()
        write_settings(settings)
        refresh = true
    end)
    local label = gui.label(checkbox, gui.font_size.small)
    label:SetPoint('LEFT', checkbox, 'RIGHT', 4, 1)
    label:SetText('隐藏此物品')
    hide_checkbox = checkbox
end
do
    local editbox = gui.editbox(frame.parameters)
    editbox:SetPoint('TOPRIGHT', -71, -60)
    editbox:SetWidth(180)
    editbox:SetHeight(22)
    editbox:SetAlignment('RIGHT')
    editbox:SetFontSize(17)
    editbox:SetScript('OnTabPressed', function()
	    if IsShiftKeyDown() then
		    duration_dropdown:SetFocus()
	    else
		    unit_buyout_price_input:SetFocus()
	    end
    end)
    editbox.formatter = function()
        return money.to_string(get_unit_start_price(), true)
    end
    editbox.change = function(self, is_user_input)
        refresh = true
        if is_user_input then
            set_bid_selection()
            set_buyout_selection()
            set_unit_start_price(money.from_string(self:GetText()) or 0)
        end
    end
    editbox.enter = function(self)
        self:ClearFocus()
    end
    editbox.focus_loss = function(self)
        self:SetText(money.to_string(get_unit_start_price(), true, nil, nil, true))
    end
    do
        local label = gui.label(editbox, gui.font_size.small)
        label:SetPoint('BOTTOMLEFT', editbox, 'TOPLEFT', -2, 1)
        label:SetText('起始单价')
    end
    do
        local label = gui.label(editbox, 14)
        label:SetPoint('LEFT', editbox, 'RIGHT', 8, 0)
        label:SetWidth(50)
        label:SetJustifyH('CENTER')
        start_price_percentage = label
    end
    unit_start_price_input = editbox
end
do
    local editbox = gui.editbox(frame.parameters)
    editbox:SetPoint('TOPRIGHT', unit_start_price_input, 'BOTTOMRIGHT', 0, -19)
    editbox:SetWidth(180)
    editbox:SetHeight(22)
    editbox:SetAlignment('RIGHT')
    editbox:SetFontSize(17)
    editbox:SetScript('OnTabPressed', function()
        if IsShiftKeyDown() then
            unit_start_price_input:SetFocus()
        end
    end)
    editbox.formatter = function()
        return money.to_string(get_unit_buyout_price(), true)
    end
    editbox.change = function(self, is_user_input)
        refresh = true
        if is_user_input then
            set_buyout_selection()
            set_unit_buyout_price(money.from_string(self:GetText()) or 0)
        end
    end
    editbox.enter = function(self)
        self:ClearFocus()
    end
    editbox.focus_loss = function(self)
        self:SetText(money.to_string(get_unit_buyout_price(), true, nil, nil, true))
    end
    do
        local label = gui.label(editbox, gui.font_size.small)
        label:SetPoint('BOTTOMLEFT', editbox, 'TOPLEFT', -2, 1)
        label:SetText('一口价')
    end
    do
        local label = gui.label(editbox, 14)
        label:SetPoint('LEFT', editbox, 'RIGHT', 8, 0)
        label:SetWidth(50)
        label:SetJustifyH('CENTER')
        buyout_price_percentage = label
    end
    unit_buyout_price_input = editbox
end
do
	local label = gui.label(frame.parameters, gui.font_size.medium)
	label:SetPoint('TOPLEFT', unit_buyout_price_input, 'BOTTOMLEFT', 0, -24)
	deposit = label
end

function aux.event.AUX_LOADED()
	if not aux.account_data.post_bid then
		frame.bid_listing:Hide()
		frame.buyout_listing:SetPoint('BOTTOMLEFT', frame.inventory, 'BOTTOMRIGHT', 2.5, 0)
		buyout_listing:SetColInfo{
            {name='拍卖数', width=.15, align='CENTER'},
            {name='剩余时间', width=.15, align='CENTER'},
            {name='堆叠数量', width=.15, align='CENTER'},
            {name='一口价 (每件)', width=.4, align='RIGHT'},
            {name='% 价格对比', width=.15, align='CENTER'},
		}
	end
end