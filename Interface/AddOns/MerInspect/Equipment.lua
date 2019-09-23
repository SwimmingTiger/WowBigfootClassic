
local M = MerInspect;

function M:ScanUnitEquipment(unit, class, race, level)
	local link, txt, r, g, b;
	for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
		link = GetInventoryItemLink(unit, i);
		if link then
			self.tooltip:SetOwner(UIParent, "ANCHOR_NONE");
			self.tooltip:ClearLines();
			self.tooltip:SetInventoryItem(unit, i)	;		
			for j = 2, self.tooltip:NumLines() do
				local textLeft=_G[self.tooltip:GetName() .."TextLeft" .. j]
				if textLeft then
					txt = textLeft:GetText();
					r, g, b = textLeft:GetTextColor();
					if strfind(txt, "%(%d/%d%)") or strfind(txt, "（%d/%d）") then			
						if self.set[txt] then
							break;
						else
							self.set[txt] = select(3, strfind(link,"(|c%x+)|Hitem:.-|h|r")) or "|cffffffff";
						end
					end
					self:GetEquipmentEffect(txt, r, g, b);
				end
			end
		end
	end
end

function M:GetEquipmentEffect(txt, r, g, b)
	if r<0.6 and g<0.6 and b<0.6 then return end
	for _, v in ipairs(self.patterns.ignore) do
		if strfind(txt, v[self.Local] or "#&@!") then return end
	end
	if strfind(txt, self.patterns.front[self.Local]) then
		local e1, ee = strmatch(txt, self.patterns.front[self.Local]);
		self:EachEquipEffect(e1, "SpellPower");
		if ee and ee ~= "" then
			self:GetEquipmentEffect("OOO"..ee, r, g, b);
		end
		return
	end
	for _, v in ipairs(self.patterns.loop) do
		if strfind(txt, v[self.Local] or "#&@!") then
			txt1, txt2 = strmatch(txt,v[self.Local]);
			self:GetEquipmentEffect(txt1 or "", r, g, b);
			self:GetEquipmentEffect(txt2 or "", r, g, b);
			return
		end
	end
	if strfind(txt, "%+(%d+)") then		
		effect = strmatch(txt, "%+(%d+)");
		for _, v in ipairs(self.patterns.general) do
			if strfind(txt, v[self.Local] or "#&@!") then
				self:EachEquipEffect(effect, strsplit("|",v.effect));
				break;
			end
		end
		return;
	end
	for _, v in ipairs(self.patterns.extra) do
		if strfind(txt, v[self.Local] or "#&@!") then
			effect = strmatch(txt, v[self.Local]);
			self:EachEquipEffect(effect, strsplit("|",v.effect));
			if v.extra then
				self:EachEquipEffect(ceil(effect / 3), "SpellPower");
			end
			return;
		end
	end
	for _, v in ipairs(self.patterns.percent) do
		if strfind(txt, v[self.Local] or "#&@!") then
			effect =strmatch(txt, v[self.Local]);
			for key in string.gmatch(v.effect,"[^|]+") do
				self:SetPercentEffect(v.anchor or key, key, effect/100);
			end
			return;
		end
	end
	for _, v in ipairs(self.patterns.special) do
		if strfind(txt, v[self.Local] or "#&@!") then
			for key in string.gmatch(v.effect,"[^|]+") do
				self.effect[key] = (self.effect[key] or 0) + v.value;
			end
			if not v.gonext then
				break;
			end
		end
	end	
end

function M:EachEquipEffect(effect, ...)
	for i = 1, select("#", ...) do
		self.effect[select(i,...)] = (self.effect[select(i,...)] or 0) + (tonumber(effect) or 0);
	end
end
tinsert(M.QueueScan, "ScanUnitEquipment");

function M:UpdateMainFrame(unit, class, race, level, talent)
	local frame;	

	self:OnShowInspectFrame(talent);	
	frame = MerInspectRES;
	frame.button1.text:SetText(self:GetEffect("Resistance_Arcane") or 0);
	frame.button2.text:SetText(self:GetEffect("Resistance_Fire") or 0);
	frame.button3.text:SetText(self:GetEffect("Resistance_Nature") or 0);
	frame.button4.text:SetText(self:GetEffect("Resistance_Frost") or 0);
	frame.button5.text:SetText(self:GetEffect("Resistance_Shadow") or 0);
	
	frame = MerInspectBase
	frame.text1:SetText(self.loc.Strength);
	frame.text2:SetText(self.loc.Agility);
	frame.text3:SetText(self.loc.Stamina);
	frame.text4:SetText(self.loc.Intellect);
	frame.text5:SetText(self.loc.Spirit);
	frame.text6:SetText(self.loc.Resilience);
	frame.text7:SetText(self.loc.Armor);

	frame.stat1:SetText(self:GetEffect("Strength"));
	frame.stat2:SetText(self:GetEffect("Agility"));
	frame.stat3:SetText(self:GetEffect("Stamina"));
	frame.stat4:SetText(self:GetEffect("Intellect"));
	frame.stat5:SetText(self:GetEffect("Spirit"));
	frame.stat6:SetText(self:GetEffect("Resilience"));
	frame.stat7:SetText(self:GetEffect("Armor"));
end

tinsert(M.QueueShow, "UpdateMainFrame");
