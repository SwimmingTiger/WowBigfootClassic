
local __ActionButton_OnUpdate;

local function __BigFoot_ActionButton_UpdateUsable(self)
	if not BigFoot_DistanceAlert then return end
	local icon = self.icon;
	if ( IsActionInRange( ActionButton_GetPagedID(self)) == false ) then
		icon:SetVertexColor(0.5, 0.1, 0.1);
	else
		local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(self));
		if isUsable then
			icon:SetVertexColor(1.0, 1.0, 1.0);
		elseif notEnoughMana then
			icon:SetVertexColor(0.5, 0.5, 1.0);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
		end
	end
end

function DistanceAlert_Toggle(flag)
	if (flag == 1) then
		BigFoot_DistanceAlert = true;
		if (not __ActionButton_OnUpdate) then
			hooksecurefunc("ActionButton_UpdateUsable",__BigFoot_ActionButton_UpdateUsable)
			hooksecurefunc("ActionButton_OnUpdate", ActionButton_UpdateUsable);
			__ActionButton_OnUpdate = true
		end
	else
		BigFoot_DistanceAlert = nil;
	end
end