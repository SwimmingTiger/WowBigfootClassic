
local M = MerInspect;

function M:ScanUnitTalent(unit, class, race, level, inspect)
	local numTabs = GetNumTalentTabs(inspect);
	for i = 1, numTabs do
		local numTalents = GetNumTalents(i,inspect);
		for j = 1, numTalents do
			nameTalent, _, _, _, currRank, maxRank= GetTalentInfo(i,j,inspect);
			if currRank > 0 then
				self:GetTalentEffect(currRank, nameTalent, class, race, level);
			end
		end
	end
end

function M:GetTalentEffect(rank, nameTalent, class, race, level)
	for _, v in ipairs(self.patterns.talent[class] or {}) do
		if v[self.Local] == nameTalent then
			local percent = select(rank, strsplit("|", v.step));			
			if (not percent) then
				if (self._DEBUG) then
					self:DEBUG(nameTalent .. " has not rank info of " .. rank .. "rank");
					return;
				else
					percent = 0;
				end				
			end
			if v.direct then
				if (v.logic) then					
					percent = self:GetPercentInRating(v.logic, percent, level) or percent;
				end
				if (v.type and v.type == 2) then
					self.effect[v.effect] = (self.effect[v.effect] or 0) - percent;	-- 负面效果
				else
					self.effect[v.effect] = (self.effect[v.effect] or 0) + percent;					
				end
			elseif v.buff then
				if self.buffeffect then
					if (v.type and v.type == 2) then
						self.buffeffect[v.effect] = floor( (self.buffeffect[v.effect] or 0) * (1 - percent) );
					else
						self.buffeffect[v.effect] = floor( (self.buffeffect[v.effect] or 0) * (1 + percent) );
					end					
				end
			elseif v.base then
				if (v.type and v.type == 2) then
					self.effectPercent[v.effect] = (self.effectPercent[v.effect] or 0) - floor(self:GetBaseEffect(strupper(v.effect), class, race, level) * percent);
				else
					self.effectPercent[v.effect] = (self.effectPercent[v.effect] or 0) + floor(self:GetBaseEffect(strupper(v.effect), class, race, level) * percent);
				end				
			else
				for key in string.gmatch(v.effect,"[^|]+") do
					if (v.type and v.type == 2) then
						self:SetPercentEffect(v.anchor or key, key, percent, true);
					else
						self:SetPercentEffect(v.anchor or key, key, percent);
					end					
				end
			end
			if not v.gonext then
				break;
			end
		end
	end
end

function M:INSPECT_TALENT_READY()
	if (self.Config.MerInspectEnable) then
		local unit = InspectFrame.unit or "target";
		if (not UnitExists(unit)) or (not UnitIsPlayer(unit)) then
			return;
		end
		local level = UnitLevel(unit);
		if (not level) then
			return;
		end
		local temp1, class = UnitClass(unit);
		if (not class) then
			return;
		end
		class = strupper(class);
		local temp2, race = UnitRace(unit);
		if (not race) then
			return;
		end
		race = strupper(race);

		self:UpdateTalentFrame(unit);	
		self:UpdateMainFrame(unit, class, race, level, true);
	end
end
 
function M:UpdateTalentFrame(unit)
	local name, iconTexture, point, point1, point2, point3
	point1 = select(3, GetTalentTabInfo(1,true,nil,GetActiveTalentGroup(true)));
	point2 = select(3, GetTalentTabInfo(2,true,nil,GetActiveTalentGroup(true)));
	point3 = select(3, GetTalentTabInfo(3,true,nil,GetActiveTalentGroup(true)));
	point = max(point1, point2, point3);
	if point == point1 then
		name, iconTexture = GetTalentTabInfo(1,true,nil,GetActiveTalentGroup(true));
	elseif point == point2 then
		name, iconTexture = GetTalentTabInfo(2,true,nil,GetActiveTalentGroup(true));
	elseif point == point3 then
		name, iconTexture = GetTalentTabInfo(3,true,nil,GetActiveTalentGroup(true));
	end	
	local frame = MerInspectTalent;
	frame.text1:SetText(name);
	frame.text2:SetFormattedText("%s/%s/%s", point1, point2, point3);
	frame.icon1:SetTexture(iconTexture);
end


function M:GetRaceEffect(unit, class, race, level)
	if race == "TAUREN" then
		self:SetPercentEffect("Stamina", "Stamina", 0.05);
	end
end
--tinsert(M.QueueScan, "GetRaceEffect");

function M:ClearTalentFrame()
	local frame = MerInspectTalent;
	frame.icon1:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
	frame.text1:SetText(".......");
	frame.text2:SetFormattedText("%s/%s/%s", "-", "-", "-");
end
tinsert(M.QueueShow, "ClearTalentFrame");
