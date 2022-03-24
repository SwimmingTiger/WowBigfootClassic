
--===========================================================
-- BubbleChat 版本 0.8
-- 作者： Andy Xiao
-- 创建日期： 2004年12月24日
-- 描述： BubbleChat能够使队伍中的队友的说话在屏幕上以泡泡框
--        的形式显示出来。
--
-- 该模块版权属于AndyXiao@WoWInside.Net
--===========================================================

__BUBBLECHAT_ANIM_INTERVAL = 0.01;
__BUBBLECHAT_ANIM_FRAME_COUNT = 4;

__BUBBLECHAT_KEEP_SOLID_TIME = 2;
__BUBBLECHAT_FADING_TIME = 3;
__BUBBLECHAT_HIDE_TIME = 2;

__BUBBLECHAT_ENABLED = nil;
__BUBBLECHAT_INITIALIZED = nil;

if (GetLocale() == "zhCN") then
	__BUBBLE_CHAT_FONT = "Fonts\\ZYHei.TTF";
elseif (GetLocale() == "zhTW") then
	__BUBBLE_CHAT_FONT = "Fonts\\bHEI01B.TTF";
else
	__BUBBLE_CHAT_FONT = "Fonts\\ARIALN.TTF";
end

function BubbleChatFrame_OnLoad(self)
	getglobal(self:GetName().."Text"):SetFont(__BUBBLE_CHAT_FONT, 11);
end

function BubbleChat_Toggle(switch)
	if (switch) then
		local __i;
		for __i = 1, 4, 1 do
			local __member_frame = getglobal("PartyMemberFrame"..__i);
			local __frame = getglobal("BubbleChatFrame"..__i);

			__member_frame:RegisterAnchorFrame(__frame, 1, "TOPLEFT", "TOPRIGHT", 0, -10, 0);

			__frame:RegisterEvent("CHAT_MSG_PARTY");
		end
		
		__BUBBLECHAT_ENABLED = 1;
	else
		local __i;
		for __i = 1, 4, 1 do
			local __frame = getglobal("BubbleChatFrame"..__i);
			local __member_frame = getglobal("PartyMemberFrame"..__i);

			__member_frame:UnregisterAnchorFrame(__frame);

			__frame:UnregisterEvent("CHAT_MSG_PARTY");
		end

		__BUBBLECHAT_ENABLED = nil;
	end
end

function BubbleChatFrame_OnEvent(self, __event, ...)
	if ( __BUBBLECHAT_ENABLED ) then
		if ( __event == "CHAT_MSG_PARTY" ) then
			local __msg, __player = ...;
			__BubbleChatFrame_Check(self, __player, __msg);
		end
	end
end

function BubbleChatFrame_OnUpdate(self, __elapsed)
	if ( self.__showing ) then
		self.__interval = self.__interval + __elapsed;
		if ( self.__interval > __BUBBLECHAT_ANIM_INTERVAL ) then
			self.__interval = 0;
			self.__showing = self.__showing + 1;
			if ( self.__showing > __BUBBLECHAT_ANIM_FRAME_COUNT ) then
				local __textOb = getglobal(self:GetName().."Text");
				local __textureOb = getglobal(self:GetName().."Texture");
				__textOb:SetText(self.__text);
				__textureOb:SetTexture("Interface\\Addons\\BubbleChat\\bubble");
				self.__showing = nil;
				self.__solid = __BUBBLECHAT_KEEP_SOLID_TIME;
				return;
			else
				local __textOb = getglobal(self:GetName().."Text");
				local __textureOb = getglobal(self:GetName().."Texture");
				__textOb:SetText("");
				__textureOb:SetTexture("Interface\\Addons\\BubbleChat\\bubbleanim"..self.__showing);
			end
		end
	elseif ( self.__solid ) then
		self.__solid = self.__solid - __elapsed;
		if ( self.__solid < 0 ) then
			self.__solid = nil;
			self.__fading = __BUBBLECHAT_FADING_TIME;
			return;
		end
	elseif ( self.__fading and self.__fading ~= 0 ) then
		self.__fading = self.__fading - __elapsed;
		if ( self.__fading < 0 ) then
			self.__fading = 0;
			self.__hide = __BUBBLECHAT_HIDE_TIME;
		end
		self:SetAlpha((self.__fading/__BUBBLECHAT_FADING_TIME)*0.5+0.5);
	elseif ( self.__hide ) then
		self.__hide = self.__hide - __elapsed;
		if ( self.__hide < 0 ) then	
			self:Hide();
			self.__hide = nil;
			self.__fading = nil;
			self.__solid = nil;
			self.__showing = nil;
			self.__text = "";
			return;
		end
	end
end

function __BubbleChatFrame_Check(self, __player, __msg)
	local __name = UnitName("party"..self:GetID());

	if ( __player == __name ) then
		local __textureOb = getglobal(self:GetName().."Texture");
		__textureOb:SetTexture("Interfce\\Addons\\BubbleChat\\bubbleanim1");
		self:SetAlpha(1.0);
		self.__interval = 0;
		self.__showing = 0;
		self.__fading = nil;
		self.__text = __msg;

		self:Show();
	end
end