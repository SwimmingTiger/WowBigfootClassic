AuctionatorPageStatusDialogMixin = {}

function AuctionatorPageStatusDialogMixin:OnLoad()
  Auctionator.EventBus:Register(self, {
    Auctionator.AH.Events.ScanResultsUpdate,
    Auctionator.AH.Events.ScanAborted,
    Auctionator.AH.Events.ScanPageStart,
  })
  self:Hide()
end

function AuctionatorPageStatusDialogMixin:OnHide()
  self:Hide()
end

function AuctionatorPageStatusDialogMixin:ReceiveEvent(eventName, ...)
  if eventName == Auctionator.AH.Events.ScanPageStart then
    local page = ...
    local text = AUCTIONATOR_L_SCANNING_PAGE_X:format(page + 1)
    if IsAddOnLoaded("aux-addon") then
      text = text .. "若卡住请取消勾选AUX拍卖插件"
    end
    self:Show()
    self.StatusText:SetText(text)

  elseif eventName == Auctionator.AH.Events.ScanResultsUpdate then
    local _, isComplete = ...
    if isComplete then
      self:Hide()
    end

  elseif eventName == Auctionator.AH.Events.ScanAborted then
    self:Hide()
  end
end

AuctionatorThrottlingTimeoutDialogMixin = {}

function AuctionatorThrottlingTimeoutDialogMixin:OnLoad()
  Auctionator.EventBus:Register(self, {
    Auctionator.AH.Events.CurrentThrottleTimeout,
  })
  self:Hide()
end

function AuctionatorThrottlingTimeoutDialogMixin:OnHide()
  self:Hide()
end

function AuctionatorThrottlingTimeoutDialogMixin:ReceiveEvent(eventName, ...)
  if eventName == Auctionator.AH.Events.CurrentThrottleTimeout then
    local timeout = ...
    if timeout < 8 then
      self:Show()
      self.StatusText:SetText(AUCTIONATOR_L_WAITING_AT_MOST_X_LONGER:format(math.ceil(timeout)))
    else
      if self:IsShown() then
        Auctionator.Utilities.Message(AUCTIONATOR_L_SERVER_TOOK_TOO_LONG)
      end
      self:Hide()
    end
  end
end
