local myname, ns = ...

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

-- This is very much based on AnimaDiversionDataProvider

local RouteWorldMapDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
ns.RouteWorldMapDataProvider = RouteWorldMapDataProvider

local RoutePinMixin = CreateFromMixins(MapCanvasPinMixin)
local RoutePinConnectionMixin = {}

function RouteWorldMapDataProvider:RemoveAllData()
    if not self:GetMap() then return end

    if self.pinPool then
        self.pinPool:ReleaseAll()
        self.connectionPool:ReleaseAll()
    end
    self:GetMap().ScrollContainer:MarkCanvasDirty()
end

function RouteWorldMapDataProvider:RefreshAllData(fromOnShow)
    if not (self:GetMap() and self:GetMap():IsShown()) then return end
    self:RemoveAllData()
    if not ns.db.show_routes then return end

    local uiMapID = self:GetMap():GetMapID()
    if not uiMapID then return end
    if not ns.points[uiMapID] then return end

    if not self.pinPool then
        self:CreatePools()
    end

    for coord, point in pairs(ns.points[uiMapID]) do
        if point.routes and ns.should_show_point(coord, point, uiMapID, false) then
            for _, route in ipairs(point.routes) do
                self:DrawRoute(route, point)
            end
        end
    end
end

function RouteWorldMapDataProvider:CreatePools()
    self.pinPool = CreateFramePool("FRAME", self:GetMap():GetCanvas(), nil, function(pool, pin)
        if not pin.OnReleased then
            Mixin(pin, RoutePinMixin)
        end
        FramePool_HideAndClearAnchors(pool, pin)
        pin:OnReleased()

        pin.pinTemplate = nil
        pin.owningMap = nil
    end)
    self.connectionPool = CreateFramePool("FRAME", self:GetMap():GetCanvas(), nil, function(pool, connection)
        if not connection.Line then
            Mixin(connection, RoutePinConnectionMixin)
            connection:SetIgnoreParentScale(true)
            connection.Line = connection:CreateLine()
        end
        FramePool_HideAndClearAnchors(pool, connection)

        connection.point = nil
        connection.route = nil
    end)
end

local pins = {}
function RouteWorldMapDataProvider:DrawRoute(route, point)
    for _, node in ipairs(route) do
        local x, y = HandyNotes:getXY(node)
        local pin = self:AcquirePin()
        pin:SetPosition(x, y)
        pin:Show()
        if pins[#pins] then
            self:ConnectPins(pins[#pins], pin, route, point)
        end
        table.insert(pins, pin)
    end
    if route.loop and #pins > 1 then
        self:ConnectPins(pins[#pins], pins[1], route, point)
    end
    wipe(pins)
end

function RouteWorldMapDataProvider:ConnectPins(pin1, pin2, route, point)
    local connection = self.connectionPool:Acquire()
    connection.point = point
    connection.route = route
    connection:Connect(pin1, pin2)
    connection.Line:SetVertexColor(route.r or 1, route.g or 1, route.b or 1, route.a or 0.6)
    if not route.highlightOnly then
        connection:Show()
    end
end

function RouteWorldMapDataProvider:HighlightRoute(point, uiMapID, coord)
    if not self.connectionPool then return end
    for connection in self.connectionPool:EnumerateActive() do
        if connection.point == point then
            connection.Line:SetThickness(40)
            if connection.route.highlightOnly then
                connection:Show()
            end
        end
    end
end

function RouteWorldMapDataProvider:UnhighlightRoute(point, uiMapID, coord)
    if not self.connectionPool then return end
    for connection in self.connectionPool:EnumerateActive() do
        if connection.point == point then
            connection.Line:SetThickness(20)
            if connection.route.highlightOnly then
                connection:Hide()
            end
        end
    end
end

function RoutePinMixin:OnLoad()
    -- This is below normal handynotes pins
    self:UseFrameLevelType("PIN_FRAME_LEVEL_EVENT_OVERLAY")
    self:SetSize(40, 40)
    self:EnableMouse()
end

function RoutePinConnectionMixin:Connect(pin1, pin2)
    self:SetParent(pin1)
    -- Anchor straight up from the origin
    self:SetPoint("BOTTOM", pin1, "CENTER")

    if not (pin1:GetCenter() and pin2:GetCenter()) then
        -- I'm seeing reports of errors in CalculateAngleBetween which would imply one of the pins
        -- isn't returning a center. I can't reproduce this to test it, but I think aborting here
        -- should avoid errors.
        return
    end

    -- Then adjust the height to be the length from origin to pin
    local length = RegionUtil.CalculateDistanceBetween(pin1, pin2) * pin1:GetEffectiveScale()
    self:SetHeight(length)
    -- And finally rotate all the textures around the origin so they line up
    local quarter = (math.pi / 2)
    local angle = RegionUtil.CalculateAngleBetween(pin1, pin2) - quarter
    self:RotateTextures(angle, 0.5, 0)

    if ns.CLASSIC then
        -- self.Line:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Line")
        self.Line:SetAtlas("_UI-Taxi-Line-horizontal")
    else
        self.Line:SetAtlas("_AnimaChannel-Channel-Line-horizontal")
    end

    self.Line:SetStartPoint("CENTER", pin1)
    self.Line:SetEndPoint("CENTER", pin2)

    self.Line:SetThickness(20)
end

do
    -- This is MapCanvasMixin.AcquirePin lightly rewritten to not require an
    -- XML template, so this can be bundled in with addons without requiring
    -- a custom bit of XML for each one.
    local function OnPinMouseUp(pin, button, upInside)
        pin:OnMouseUp(button)
        if upInside then
            pin:OnClick(button)
        end
    end
    function RouteWorldMapDataProvider:AcquirePin(...)
        local pin, newPin = self.pinPool:Acquire()
        if newPin then
            local isMouseClickEnabled = pin:IsMouseClickEnabled()
            local isMouseMotionEnabled = pin:IsMouseMotionEnabled()

            if isMouseClickEnabled then
                pin:SetScript("OnMouseUp", OnPinMouseUp)
                pin:SetScript("OnMouseDown", pin.OnMouseDown)
            end

            if isMouseMotionEnabled then
                pin:SetScript("OnEnter", pin.OnMouseEnter)
                pin:SetScript("OnLeave", pin.OnMouseLeave)
            end

            pin:SetMouseClickEnabled(isMouseClickEnabled)
            pin:SetMouseMotionEnabled(isMouseMotionEnabled)
        end

        pin.owningMap = self:GetMap()

        if newPin then
            pin:OnLoad()
        end

        self:GetMap().ScrollContainer:MarkCanvasDirty()
        pin:Show()
        pin:OnAcquired(...)

        return pin
    end
end

