--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local type = type;
	local next, unpack = next, unpack;
	local strsplit, strlower, strupper, strmatch = string.split, string.lower, string.upper, string.match;
	local tostring, tonumber = tostring, tonumber;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local Ambiguate = Ambiguate;
	local _G = _G;
	

-->
	local L = CT.L;

-->		constant
-->
MT.BuildEnv('EXTERNAL');
-->		predef
-->		EXTERNAL
	VT.ExternalCodec.wowhead = {
		import = function(url)
			--[[
				https://classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
				https://classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
					"^.*classic%.wowhead%.com/talent%-calc.*/([^/]+)/(%d.+)$"
			]]
			local class, data = strmatch(url, "classic%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
			if class and data then
				class = strupper(class);
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				if ClassTDB ~= nil and SpecList ~= nil then
					--(%d*)[%-]*(%d*)[%-]*(%d*)
					local d1, d2, d3 = strmatch(data, "(%d*)[%-]?(%d*)[%-]?(%d*)");
					if d1 and d2 and d3 then
						if d1 == "" and d2 == "" and d3 == "" then
							return class, "", DT.MAX_LEVEL;
						elseif d2 == "" and d3 == "" then
							return d1;
						else
							local l1 = #ClassTDB[SpecList[1]];
							if l1 > #d1 then
								data = d1 .. strrep("0", l1 - #d1);
							else
								data = d1;
							end
							local l2  = #ClassTDB[SpecList[2]];
							if l2 > #d2 then
								data = data .. d2 .. strrep("0", l2 - #d2) .. d3;
							else
								data = data .. d2 .. d3;
							end
							return class, data, DT.MAX_LEVEL;
						end
					end
				end
			end
			return nil;
		end,
		export = function(Frame)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local data = "";
			for i = 3, 1, -1 do
				local TalentSet = TreeFrames[i].TalentSet;
				local topPos = 0;
				for i = #ClassTDB[SpecList[i]], 1, -1 do
					if TalentSet[i] > 0 then
						topPos = i;
						break;
					end
				end
				if topPos > 0 then
					for i = topPos, 1, -1 do
						data = TalentSet[i] .. data;
					end
				end
				if i > 1 and data ~= "" then
					data = "-" .. data;
				end
			end
			local LOC = "";
			if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
				LOC = "cn.";
			elseif CT.LOCALE == "deDE" then
				LOC = "de.";
			elseif CT.LOCALE == "esES" then
				LOC = "es.";
			elseif CT.LOCALE == "frFR" then
				LOC = "fr.";
			elseif CT.LOCALE == "itIT" then
				LOC = "it.";
			elseif CT.LOCALE == "ptBR" then
				LOC = "pt.";
			elseif CT.LOCALE == "ruRU" then
				LOC = "ru.";
			elseif CT.LOCALE == "koKR" then
				LOC = "ko.";
			end
			if DT.BUILD == "BCC" then
				return LOC .. "tbc.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
			elseif DT.BUILD == "CLASSIC" then
				return LOC .. "classic.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
			end
		end,
	};
	VT.ExternalCodec.nfu = {
		import = function(url)
			--http://www.nfuwow.com/talents/60/warrior/tal/1331511131241111111100000000000000040000000000000000
			--		   nfuwow%.com/talents/60/([^/]+)/tal/(%d+)
			local class, data = strmatch(url, "nfuwow%.com/talents/" .. DT.MAX_LEVEL .. "/([^/]+)/tal/(%d+)");
			if class ~= nil and data ~= nil then
				class = strupper(class);
				if DT.TalentDB[class] then
					return class, data, DT.MAX_LEVEL;
				end
			end
			return nil;
		end,
		export = function(Frame)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local data = "";
			for i = 1, 3 do
				local TalentSet = TreeFrames[i].TalentSet;
				for i = 1, #ClassTDB[SpecList[i]] do
					data = data .. TalentSet[i];
				end
			end
			if DT.BUILD == "CLASSIC" then
				return "www.nfuwow.com/talents/60/" .. strlower(Frame.class) .. "/tal/" .. data;
			elseif DT.BUILD == "BCC" then
				return "www.nfuwow.com/talents/" .. strlower(Frame.class) .. "/index.html?" .. data;
			elseif DT.BUILD == "WRATH" then
				return "www.nfuwow.com/talents/80/" .. strlower(Frame.class) .. "/tal/" .. data;
			end
		end,
	};
	--[==[
	VT.ExternalCodec.yxrank = {
		import = function(url)
			--https://www.yxrank.com/classic/talent/warrior?count=333015011130012011111010010000000000000000000000000000000000000000000000000000000000
			local class, temp = strmatch(url, "yxrank%.com/classic/talent/([a-zA-Z]+)%?count=(%d+)");
			if class and temp then
				class = strupper(class);
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				if ClassTDB then
					local data = "";
					for i = 1, 3 do
						local TreeTDB = ClassTDB[SpecList[i]];
						for j, val in inext, TreeTDB, 0 do
							local pos = (i - 1) * DT.MAX_NUM_TALENTS + val[1] * 4 + val[2] + 1;
							local v = strsub(temp, pos, pos);
							if v == "" then
								break;
							end
							v = tonumber(v);
							if v > val[4] then
								return nil;
							end
							data = data .. v;
						end
					end
					return class, data, 60;
				end
			end
			return nil;
		end,
		export = function(Frame)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local ofs = 0;
			local temp = {  };
			for i = 1, 3 do
				local TalentSet = TreeFrames[i].TalentSet;
				for j, val in inext, ClassTDB[SpecList[i]], 0 do
					temp[ofs + val[1] * 4 + val[2] + 1] = TalentSet[j];
				end
				for j = 1, DT.MAX_NUM_TALENTS do
					temp[ofs + j] = temp[ofs + j] or 0;
				end
				ofs = ofs + DT.MAX_NUM_TALENTS;
			end
			return "www.yxrank.com/classic/talent/" .. Frame.class .. "?count=" .. tConcat(temp);
		end,
	};
	--]==]
	VT.ExternalAddOn["D4C"] = {
		addon = "DBM",
		list = {  },
		handler = function(self, sender, msg)
			local temp = { strsplit("\t", msg) };
			if temp[1] == "V" or temp[1] == "GV" then
				--	tremove(temp, 1);
				temp[1] = tostring(temp[4]);
				self.list[Ambiguate(sender, 'none')] = temp;
				--	print(sender, "dbm ver", temp[4], unpack(temp));
				--	print(sender, "dbm ver", temp[3]);	--	temp[3]
				return true;
			end
		end,
	};
	VT.ExternalAddOn["D4BC"] = {
		addon = "DBM",
		list = {  },
		handler = function(self, sender, msg)
			local temp = { strsplit("\t", msg) };
			if temp[1] == "V" or temp[1] == "GV" then
				--	tremove(temp, 1);
				temp[1] = tostring(temp[4]);
				self.list[Ambiguate(sender, 'none')] = temp;
				--	print(sender, "dbm ver", temp[4], unpack(temp));
				--	print(sender, "dbm ver", temp[3]);	--	temp[3]
				return true;
			end
		end,
	};
	VT.ExternalAddOn["BigWigs"] = {
		addon = "BigWigs",
		list = {  },
		handler = function(self, sender, msg)
			local temp = { strsplit("^", msg) };
			if temp[1] == "V" then
				--	tremove(temp, 1);
				temp[1] = temp[2] .. "-" .. temp[3];
				self.list[Ambiguate(sender, 'none')] = temp;
				--	print(sender, "bw ver", temp[1] .. "-" .. temp[2], unpack(temp));	--	temp[1] .. "-" .. temp[2]
				return true;
			end
		end,
	};

	MT.RegisterOnInit('EXTERNAL', function(LoggedIn)
		for prefix, addon in next, VT.ExternalAddOn do
			if not IsAddonMessagePrefixRegistered(prefix) then
				RegisterAddonMessagePrefix(prefix);
			end
		end
		local pos = 0;
		for media, codec in next, VT.ExternalCodec do
			if codec.export ~= nil then
				pos = pos + 1;
				VT.ExportButtonMenuDefinition[pos] = {
					param = codec,
					text = media,
				};
			end
		end
		VT.ExportButtonMenuDefinition.num = pos;
	end);
	MT.RegisterOnLogin('EXTERNAL', function(LoggedIn)
	end);

-->
