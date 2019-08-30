
local M = MerInspect;

function M:ScanUnitBuffs(unit, class, race, level)
	local txt;
	local i = 1;	
	while UnitBuff(unit, i) do
		self.tooltip:SetOwner(UIParent,"ANCHOR_NONE");
		self.tooltip:ClearLines();
		self.tooltip:SetUnitBuff(unit, i);
		for j = 2, self.tooltip:NumLines() do	
			local textLeft=_G[self.tooltip:GetName() .."TextLeft" .. j]
			if textLeft then
				txt = textLeft:GetText();
				self:GetBuffEffect(txt, class, race, level);
			end
		end	
		i = i + 1;
	end
end

function M:GetBuffEffect(txt, class, race, level)
	for _, v in ipairs(self.patterns.buffs[self.Local]) do
		txt = gsub(txt, v.from, v.to);
	end
	if strfind(txt, "^(.-)，(.+)") then
		txt1, txt2 = strmatch(txt,"^(.-)，(.+)");
		self:GetBuffEffect(txt1 or "", class, race, level);
		self:GetBuffEffect(txt2 or "", class, race, level);
		return;
	end
	local effect = 0;	
	for _, v in ipairs(self.patterns.buffs) do
		if strfind(txt, v[self.Local] or "#&@!") then
			effect = strmatch(txt, v[self.Local]);
			if (effect and tonumber(effect) > 0) then				
				for key in string.gmatch(v.effect, "[^|]+") do					
					if v.percent then
						self:SetPercentEffect(v.anchor or key, key, effect / 100);
					elseif v.logic then	-- 这里需要修改						
						self.effect[key] = self:GetEffect(key) + self:GetPercentInRating(v.logic, effect / 100, level);
					else
						self.effect[key] = self:GetEffect(key) + (tonumber(effect) or 0);
					end
				end
			end
			--return;
		end
	end	
end
--tinsert(M.QueueScan, "ScanUnitBuffs");
