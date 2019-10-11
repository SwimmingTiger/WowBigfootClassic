
--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------
MobHealth_ShowHealth = nil
MobHealth_ShowMana = nil
MobHealth_UseFormatted = nil
MobHealth_ShowHealthPercent = nil

local __healthOb , __manaOb ,__healthPercOb, __healthPercFrame,__healthPercBG

local function __GetFormattedNumber(number)
	local style
	if number > 1000000 then
		style = "%dW"
		return style:format(ceil(number/10000))
	end
	return number
end

local MobHealth_Eventer = BLibrary("BEvent");

function MobHealth_Display()
	if (not UnitExists("target")) then
		return;
	end

	__healthOb = _G["MobHealthText"]
	__manaOb = _G["MobManaText"]
	__healthPercOb = _G["MobHealthPercFrameValue"]
	__healthPercFrame = _G["MobHealthPercFrame"]
	__healthPercBG = _G["MobHealthPercFrameBG"]

	local __health = UnitHealth("target");
	local __healthMax = UnitHealthMax("target");

	local __mana = UnitPower("target");
	local __manaMax = UnitPowerMax("target");

	local __healthText = "";
	local __manaText = "";
	local __healthPercText = ""

	--显示生命数值
	if MobHealth_ShowHealth and __healthMax > 0 then
		if __health >= 0 then
			if MobHealth_UseFormatted then
				__healthText = __GetFormattedNumber(__health) .. "/" ..__GetFormattedNumber(__healthMax)
			else
				__healthText = __health .. "/" ..__healthMax
			end
		end
		__healthOb:SetText(__healthText)
		__healthOb:Show()
	else
		__healthOb:Hide()
	end

	--显示魔法数值
	if MobHealth_ShowMana and __manaMax > 0 then
		if  __mana >= 0 then
			if MobHealth_UseFormatted then
				__manaText = __GetFormattedNumber(__mana) .. "/" ..__GetFormattedNumber(__manaMax)
			else
				__manaText = __mana .. "/" ..__manaMax
			end
		end
		__manaOb:SetText(__manaText)
		__manaOb:Show()
	else
		__manaOb:Hide()
	end

	local __percent = math.floor(__health*100/__healthMax);
	__healthText = __percent .. "%";
	--显示百分比数值
	if MobHealth_ShowHealthPercent then
		__healthPercOb:SetText(__healthText)
		__healthPercFrame:Show()
		-- TargetFrameNumericalThreat:SetPoint("BOTTOM","TargetFrame","TOP",-30,-22)
		__healthPercBG:SetVertexColor(TargetFrameNameBackground:GetVertexColor())
	else
		-- TargetFrameNumericalThreat:SetPoint("BOTTOM","TargetFrame","TOP",-50,-22)
		__healthPercFrame:Hide()
	end
end

function MobHealth_Toggle(arg)
	if (arg == 1) then
		MobHealth_Eventer:RegisterEvent("UNIT_HEALTH");
		MobHealth_Eventer:RegisterEvent("PLAYER_TARGET_CHANGED");
		MobHealth_Eventer:RegisterEvent("UNIT_POWER_UPDATE");

		TargetFrameHealthBar.TextString:SetAlpha(0);
		TargetFrameManaBar.TextString:SetAlpha(0);
		if TargetFrameTextureFrameDeadText then
			TargetFrameTextureFrameDeadText:SetAlpha(0)
		end
		MobHealth_Display()
	else
		MobHealth_Eventer:UnregisterAllEvent();
		TargetFrameHealthBar.TextString:SetAlpha(1);
		TargetFrameManaBar.TextString:SetAlpha(1);
		if TargetFrameTextureFrameDeadText then
			TargetFrameTextureFrameDeadText:SetAlpha(1)
		end
		if __healthOb then
			__healthOb:Hide()
		end
		if __manaOb  then
			__manaOb:Hide()
		end
		if __healthPercFrame then
			__healthPercFrame:Hide()
		end
	end
end

function MobHealth_Eventer:UNIT_HEALTH(unit)
	MobHealth_Display();
end

function MobHealth_Eventer:UNIT_POWER_UPDATE(unit)
	MobHealth_Display();
end

function MobHealth_Eventer:PLAYER_TARGET_CHANGED()
	MobHealth_Display();
end
