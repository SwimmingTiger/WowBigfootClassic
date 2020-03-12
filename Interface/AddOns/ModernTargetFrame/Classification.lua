--[[	Modern TargetFrame Classification Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);
AddOn.Options=AddOn.Options or {};

----------------------------------
--[[	Options Defaults	]]
----------------------------------
AddOn.Options.ClassificationTexture=true;

----------------------------------
--[[	Target Classification	]]
----------------------------------
local Enabled,Locked=true,nil;
hooksecurefunc("TargetFrame_CheckClassification",function(self,lock)
	if self==TargetFrame then
		Locked=lock;--	lock is set when forcing the normal texture
		if AddOn.Options.ClassificationTexture and not lock and UnitClassification(self.unit)=="rareelite" then
			self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite");
		end
	end
end);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
AddOn.RegisterFeature("ClassificationTexture",function()
	if TargetFrame:IsShown() then
--		Texture locks only happen with the disabled FocusFrame
		TargetFrame_CheckClassification(TargetFrame,Locked);
	end
end);
