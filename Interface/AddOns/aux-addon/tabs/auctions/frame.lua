select(2, ...) 'aux.tabs.auctions'

local aux = require 'aux'
local info = require 'aux.util.info'
local gui = require 'aux.gui'
local auction_listing = require 'aux.gui.auction_listing'
local search_tab = require 'aux.tabs.search'

frame = CreateFrame('Frame', nil, aux.frame)
frame:SetAllPoints()
frame:SetScript('OnUpdate', on_update)
frame:Hide()

frame.listing = gui.panel(frame)
frame.listing:SetPoint('TOP', frame, 'TOP', 0, -8)
frame.listing:SetPoint('BOTTOMLEFT', aux.frame.content, 'BOTTOMLEFT', 0, 0)
frame.listing:SetPoint('BOTTOMRIGHT', aux.frame.content, 'BOTTOMRIGHT', 0, 0)

listing = auction_listing.new(frame.listing, 20, auction_listing.auctions_columns)
listing:SetSort(1, 2, 3, 4, 5, 6, 7, 8)
listing:Reset()
listing:SetHandler('OnClick', function(row, button)
	if IsAltKeyDown() and aux.account_data.action_shortcuts then
		if listing:GetSelection().record == row.record then
            cancel_button:Click()
		end
	elseif button == 'RightButton' then
		aux.set_tab(1)
		search_tab.set_filter(strlower(info.item(row.record.item_id).name) .. '/exact')
		search_tab.execute(nil, false)
	end
end)

do
    local btn = gui.button(frame)
    btn:SetPoint('LEFT', aux.status_bar, 'RIGHT', 5, 0)
    btn:SetText('取消')
    btn:Disable()
    btn:SetScript('OnClick', cancel_auction)
    cancel_button = btn
end