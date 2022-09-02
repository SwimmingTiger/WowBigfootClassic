--[[--
	ALA@163UI
--]]--

local __version = 1;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

-->			versioncheck
	local __autostyle = __ala_meta__.autostyle;
	if __autostyle ~= nil and __autostyle.__minor >= __version then
		return;
	elseif __autostyle == nil then
		__autostyle = CreateFrame('FRAME');
		__autostyle.addonenv = {  };
		__autostyle.objecttoreskin = {  };
		__ala_meta__.autostyle = __autostyle;
	else
		if __autostyle.Halt ~= nil then
			__autostyle:Halt();
		end
	end
	__autostyle.__minor = __version;

-->
local uireimp = __ala_meta__.uireimp;

-->		upvalue
	local next = next;
	local strupper = string.upper;
	local IsAddOnLoaded = IsAddOnLoaded;

-->		autostyle
	local __loggedin = IsLoggedIn();
	__autostyle._F_coreDeserializer = _F_coreDeserializerInternal;
	local addonenv = __autostyle.addonenv;
	local objecttoreskin = __autostyle.objecttoreskin;
	addonenv["NDUI"] = {
		function(env, object, type)
			local B = env[2];
			if B == nil then
				local NDui = _G.NDui;
				if NDui == nil then return end
				B = NDui[1];
				if B == nil then return end
				env[2] = B;
			end
			if type == "FRAME" then
				B.StripTextures(object);
				B.SetBD(object);
			elseif type == "BUTTON" then
				B.Reskin(object);
			elseif type == "BUTTON.WITH.TEXTURE" then
				local nt = object:GetNormalTexture();
				local pt = object:GetPushedTexture();
				local ht = object:GetHighlightTexture();
				local dt = object:GetDisabledTexture();
				if nt ~= nil then
					B.ReskinIcon(nt);
				end
				if pt ~= nil then
					B.ReskinIcon(pt);
				end
				if ht ~= nil then
					ht:SetColorTexture(1, 1, 1, .25);
				end
				if dt ~= nil then
					B.ReskinIcon(dt);
				end
			elseif type == "CHECKBUTTON" then
				B.ReskinCheck(object);
			elseif type == "EDITBOX" then
				B.ReskinEditBox(object);
			elseif type == "SLIDER" then
				B.ReskinSlider(object);
			elseif type == "TEXTURE" then
				B.ReskinIcon(object);
			end
		end,
	};
	addonenv["ELVUI"] = {
		function(env, object, type)
			local S = env[2];
			if S == nil then
				local ElvUI = _G.ElvUI;
				if ElvUI == nil then return end
				local E = ElvUI[1];
				if E == nil then return end
				S = E:GetModule('Skins');
				if S == nil then return end
				env[2] = S;
			end
			if type == "FRAME" then
				S:HandleFrame(object);
			elseif type == "BUTTON" then
				S:HandleButton(object);
			elseif type == "BUTTON.WITH.TEXTURE" then
				-- S:HandleButton(object);
				local nt = object:GetNormalTexture();
				local pt = object:GetPushedTexture();
				local ht = object:GetHighlightTexture();
				local dt = object:GetDisabledTexture();
				if nt ~= nil then
					nt:SetTexCoord(0.07, 0.93, 0.07, 0.93);
				end
				if pt ~= nil then
					pt:SetTexCoord(0.07, 0.93, 0.07, 0.93);
				end
				if ht ~= nil then
					ht:SetColorTexture(1, 1, 1, .25);
				end
				if dt ~= nil then
					dt:SetTexCoord(0.07, 0.93, 0.07, 0.93);
				end
			elseif type == "CHECKBUTTON" then
				S:HandleCheckBox(object);
			elseif type == "EDITBOX" then
				S:HandleEditBox(object);
			elseif type == "SLIDER" then
				S:HandleSliderFrame(object);
			elseif type == "TEXTURE" then
				S:HandleIcon(object);
			end
		end,
	};
	function __autostyle:AddReskinObject(object, type)
		type = strupper(type or object:GetObjectType());
		objecttoreskin[object] = type;
		if not __loggedin then
			return;
		end
		for addon, env in next, addonenv do
			if IsAddOnLoaded(addon) then
				if uireimp ~= nil then
					uireimp._SetBackdrop(object, nil);
				end
				return env[1](env, object, type);
			end
		end
	end
	__autostyle:RegisterEvent("PLAYER_LOGIN");
	__autostyle:SetScript("OnEvent", function(self, event, addon)
		if event == "PLAYER_LOGIN" then
			self:RegisterEvent("ADDON_LOADED");
			__loggedin = true;
			for addon, env in next, addonenv do
				if IsAddOnLoaded(addon) then
					for object, type in next, objecttoreskin do
						if uireimp ~= nil then
							uireimp._SetBackdrop(object, nil);
						end
						env[1](env, object, type);
					end
				end
			end
		else
			addon = strupper(addon);
			local env = addonenv[addon];
			if env ~= nil then
				for object, type in next, objecttoreskin do
					if uireimp ~= nil then
						uireimp._SetBackdrop(object, nil);
					end
					env[1](env, object, type);
				end
			end
		end
	end);
-->

function __autostyle:Halt()
	__autostyle:UnregisterAllEvents();
	__autostyle:SetScript("OnEvent", nil);
end
