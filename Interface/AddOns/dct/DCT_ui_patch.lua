
local GameTooltip_AddNewbieTip_org = GameTooltip_AddNewbieTip
local UIDropDownMenu_SetWidth_org = UIDropDownMenu_SetWidth

function GetPlayerBuff(buffId, buffFilter)
	local buffIndex, untilCancelled
	local name, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", buffId, buffFilter)
	if(duration == nil) then
		untilCancelled = 1
	end
	if(name == nil) then
		buffIndex = 0
	else
		buffIndex = buffId
	end
	return buffIndex, untilCancelled
end

function GetPlayerBuffName(buffIndex)

	local name, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", buffIndex,"HELPFUL")
	return name

end

function GetPlayerBuffTimeLeft(buffIndex)
	local name, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitAura("player", buffIndex,"HELPFUL")
	if expirationTime then
		return expirationTime - GetTime()
	else
		return 0
	end

end

function OptionsFrame_DisableCheckBox(checkBox)
	--checkBox:SetChecked(0);
	checkBox:Disable();
	getglobal(checkBox:GetName().."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function OptionsFrame_EnableCheckBox(checkBox, setChecked, checked, isWhite)
	if ( setChecked ) then
		checkBox:SetChecked(checked);
	end
	checkBox:Enable();
	if ( isWhite ) then
		getglobal(checkBox:GetName().."Text"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		getglobal(checkBox:GetName().."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end

end

function OptionsFrame_DisableSlider(slider)
	local name = slider:GetName()
	if not getglobal(name) then return end
	getglobal(name):EnableMouse(false)
	getglobal(name.."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	getglobal(name.."Low"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
	getglobal(name.."High"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
end

function OptionsFrame_EnableSlider(slider)
	local name = slider:GetName()
	if not getglobal(name) then return end
	getglobal(name):EnableMouse(true)
	getglobal(name.."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	getglobal(name.."Low"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	getglobal(name.."High"):SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
end

function OptionsFrame_EnableCheckBox(obj)
	BlizzardOptionsPanel_CheckButton_Enable(obj);
end

