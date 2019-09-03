--[[	RealMobHealth Command Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);

--------------------------
--[[	Slash Commands	]]
--------------------------
SLASH_REALMOBHEALTH_DELUNIT1="/RMHDel";
function SlashCmdList.REALMOBHEALTH_DELUNIT(msg)
	local unit=(msg~="" and msg or "target");
	if AddOn.DeleteUnitHealthData(unit) then
		print(AddOn.Localization.Command_DeletedUnitFormat:format(AddOn.GetUnitCreatureKey(unit),UnitName(unit)));
	else print(AddOn.Localization.Command_NoUnitData); end
end

SLASH_REALMOBHEALTH_WIPECACHE1="/RMHWipe";
function SlashCmdList.REALMOBHEALTH_WIPECACHE()
	AddOn.WipeHealthData();
	print(AddOn.Localization.Command_HealthWiped);
end
