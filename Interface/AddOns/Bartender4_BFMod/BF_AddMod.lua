---------------------修复BT4和界面调整的几处BUG--------------------------------------------------------------------
local AceAddon = LibStub("AceAddon-3.0")
if not Bartender4 then
	Bartender4 = AceAddon:GetAddon("Bartender4")
end
function Bartender4:UpdateModuleConfigs()
	local unlock = false
	local BTrue =false;
	if not self.Locked then
		self:Lock()
		unlock = true
	end
	for k,v in AceAddon:IterateModulesOfAddon(self) do
		if v.ToggleModule and type(v.ToggleModule)=="function" then
			v:ToggleModule()
		end
		BTrue =false;
		if v:IsEnabled() then
			BTrue =true;
		elseif v.db and v.db.profile and v.db.profile.enabled then
			v:Enable();
			BTrue =true;
		end
		if BTrue then
			if type(v.ApplyConfig) == "function" then
				v:ApplyConfig();
			end
		end
	end
	if LDB and LDBIcon then
		LDBIcon:Refresh("Bartender4", Bartender4.db.profile.minimapIcon)
	end

	self:UpdateBlizzardVehicle()

	if unlock then
		self:Unlock()
	end
end
------------------------------------------------------------------
local StanceBar_mod = Bartender4:GetModule("StanceBar")
-- we do not allow to disable the actionbars module
-- function StanceBar_mod:ToggleModule()
	-- return
-- end
-------------------------------------------------
local BagBar_mod = Bartender4:GetModule("BagBar")
 
-- we do not allow to disable the actionbars module
-- function BagBar_mod:ToggleModule(Info,value)
	-- print("BagBar_mod_ToggleModule",Info,value)
	-- return
-- end
------------------------------------------------------------
local MicroMenu_mod = Bartender4:GetModule("MicroMenu")
 
-- we do not allow to disable the actionbars module
-- function MicroMenu_mod:ToggleModule()
	-- return
-- end
-------------------------------------------------------------------

-----------------------------------------------------------