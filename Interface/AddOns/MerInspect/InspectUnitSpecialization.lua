
---------------------------------------
-- 顯示職業圖標 (经典版天賦不给观察...)
-- @Author: M
-- @DepandsOn: InspectUnit.lua
---------------------------------------

hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    if (not frame.specicon) then
        frame.specicon = frame:CreateTexture(nil, "BORDER")
        frame.specicon:SetSize(42, 42)
        frame.specicon:SetPoint("TOPRIGHT", -10, -11)
        frame.specicon:SetAlpha(0.4)
        frame.specicon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        frame.spectext = frame:CreateFontString(nil, "BORDER")
        frame.spectext:SetFont(SystemFont_Outline_Small:GetFont(), 12, "THINOUTLINE")
        frame.spectext:SetPoint("BOTTOM", frame.specicon, "BOTTOM")
        frame.spectext:SetJustifyH("CENTER")
        frame.spectext:SetAlpha(0.8)
    end
    local class = select(2, UnitClass(unit))
    local x1, x2, y1, y2 = unpack(CLASS_ICON_TCOORDS[strupper(class)])
    frame.specicon:SetTexCoord(x1, x2, y1, y2)
    frame.spectext:SetText("") --@todo
end)
