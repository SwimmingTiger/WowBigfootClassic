if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local lbf

function TotemTimers.SkinCallback(arg, Group, SkinID, Gloss, Backdrop, Colors, Fonts)
	local skins = lbf:GetSkins()
	if skins[SkinID].icon then
        TotemTimers.ApplySkin(skins[SkinID])
	end
	if SkinID == "Blizzard" then
		for k,v in pairs(XiTimers.timers) do
			v.animation.button.normalTexture:Hide()
			v:HideNormalTexture()
		end
	else
		for k,v in pairs(XiTimers.timers) do
			v.animation.button.normalTexture:Show()
		end
	end
end


function TotemTimers.InitButtonFacade()
	if not LibStub then return end
	lbf = LibStub("Masque", true)
	if lbf then
		local group = lbf:Group("TotemTimers")
		for k,v in pairs(XiTimers.timers) do
            group:AddButton(v.button)
            group:AddButton(v.animation.button)
        end 
        for i = 1,#TTActionBars.bars do
            for j = 1,#TTActionBars.bars[i].buttons do
                group:AddButton(TTActionBars.bars[i].buttons[j])
            end
        end
        lbf:Register("TotemTimers", TotemTimers.SkinCallback,nil)
        group:ReSkin()
	end
end

