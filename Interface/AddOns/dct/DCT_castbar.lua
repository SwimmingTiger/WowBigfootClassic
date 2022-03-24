function DCT_CastBar_Setup(barp,per,color)
	local p = getglobal(barp:GetName().."Status")
	p:SetMinMaxValues(0,1)
	p:SetValue(per)
	if color then
		p:SetStatusBarColor(color[1],color[2],color[3])
	end
	--[[
	local sp = getglobal(barp:GetName().."StatusSpark")
	if per < 1 then
		sp:SetHeight(p:GetHeight() * 2)
		sp:SetPoint("CENTER", barp:GetName().."Status", "LEFT", barp.maxW * per + 1 ,0 )
		p.overtime = 0
		sp:SetAlpha(1)
	else
		if not p.overtime or p.overtime == 0 then
			p.overtime = GetTime()
		else
			if GetTime() - p.overtime < 0.25 then
				sp:SetAlpha(1 - (GetTime() - p.overtime) * 4)
			else
				sp:SetAlpha(0)
			end
		end
	end]]

end
