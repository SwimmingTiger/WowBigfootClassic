
---------------------------------------
-- 顯示職業圖標和天赋
-- @Author: M
-- @DepandsOn: InspectUnit.lua
---------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local function GetInspectTalentInfo(unit)
    if (not GetTalentTabInfo) then return end
    local isInspect = (unit ~= "player")
    local _, name, point, name1, name2, name3, point1, point2, point3
	name1, _, point1 = GetTalentTabInfo(1, isInspect)
	name2, _, point2 = GetTalentTabInfo(2, isInspect)
	name3, _, point3 = GetTalentTabInfo(3, isInspect)
	point = max(point1, point2, point3)
	if point == point1 then
		name = name1
	elseif point == point2 then
		name = name2
	elseif point == point3 then
		name = name3
	end
    return name, point, point1, point2, point3
end

hooksecurefunc("ShowInspectItemListFrame", function(unit, parent, itemLevel, maxLevel)
    local frame = parent.inspectFrame
    if (not frame) then return end
    if (not frame.specicon) then
        frame.specicon = frame:CreateTexture(nil, "BORDER")
        frame.specicon:SetSize(42, 42)
        frame.specicon:SetPoint("TOPRIGHT", -10, -11)
        frame.specicon:SetAlpha(0.5)
        frame.specicon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        frame.spectext = frame:CreateFontString(nil, "BORDER")
        frame.spectext:SetFont(SystemFont_Outline_Small:GetFont(), 11, "THINOUTLINE")
        frame.spectext:SetPoint("BOTTOM", frame.specicon, "BOTTOM", 0, -7)
        frame.spectext:SetJustifyH("CENTER")
        --frame.spectext:SetAlpha(0.9)
    end
    local class = select(2, UnitClass(unit))
    local x1, x2, y1, y2 = unpack(CLASS_ICON_TCOORDS[strupper(class)])
    frame.specicon:SetTexCoord(x1, x2, y1, y2)
    local name, point, point1, point2, point3 = GetInspectTalentInfo(unit)
    if (not name and not point) then
        frame.spectext:SetText("")
    elseif (name and point > 0) then
        frame.spectext:SetText(format("|CFFFFD200%s|r\n\n%s/%s/%s", name, point1, point2, point3))
    else
        frame.spectext:SetText(format("%s/%s/%s", point1, point2, point3))
    end
end)
