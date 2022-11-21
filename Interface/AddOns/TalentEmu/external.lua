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
	local next, unpack = next, unpack;
	local strsub, strsplit, strlower, strupper, strmatch = string.sub, string.split, string.lower, string.upper, string.match;
	local tostring = tostring;
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local Ambiguate = Ambiguate;
	local _G = _G;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('EXTERNAL');
-->		predef
-->		EXTERNAL
	VT.ExternalCodec.wowhead = {
		ImportCode = function(url, codec)
			local class, data = nil;
			if CT.BUILD == "CLASSIC" then
				--	https://cn.classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
				--	https://cn.classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
				--	https://classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
				--	https://classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
				class, data = strmatch(url, "classic%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
			elseif CT.BUILD == "BCC" then
				class, data = strmatch(url, "tbc%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
			elseif CT.BUILD == "WRATH" then
				--	https://www.wowhead.com/wotlk/talent-calc/death-knight/23050005-32005350352203012300033101351
				--	https://www.wowhead.com/wotlk/talent-calc/death-knight/-32002350352203012300033101351-230200305003
				--	https://www.wowhead.com/wotlk/cn/talent-calc/death-knight/23050005-32005350352203012300033101351
				--	https://www.wowhead.com/wotlk/cn/talent-calc/death-knight/-32002350352203012300033101351-230200305003
				--	https://www.wowhead.com/wotlk/cn/talent-calc/embed/death-knight/23050005-32005350352203012300033101351
				--	https://www.wowhead.com/wotlk/cn/talent-calc/embed/death-knight/-32002350352203012300033101351-230200305003
				class, data = strmatch(url, "wowhead%.com/wotlk/.*talent%-calc.*/([^/]+)/([0-9%-]+)");
			else
				return nil;
			end
			if class ~= nil and data ~= nil then
				class = strupper(class);
				if class == "DEATH-KNIGHT" then
					class = "DEATHKNIGHT";
				end
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
								data = d1 .. CT.RepeatedZero[l1 - #d1];
							else
								data = d1;
							end
							local l2  = #ClassTDB[SpecList[2]];
							if l2 > #d2 then
								data = data .. d2 .. CT.RepeatedZero[l2 - #d2] .. d3;
							else
								data = data .. d2 .. d3;
							end
							return class, DT.MAX_LEVEL, data;
						end
					end
				end
			end
			return nil;
		end,
		ExportCode = function(Frame, codec)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local data = "";
			for TreeIndex = 3, 1, -1 do
				local TalentSet = TreeFrames[TreeIndex].TalentSet;
				local topPos = 0;
				for TreeIndex = #ClassTDB[SpecList[TreeIndex]], 1, -1 do
					if TalentSet[TreeIndex] > 0 then
						topPos = TreeIndex;
						break;
					end
				end
				if topPos > 0 then
					for TreeIndex = topPos, 1, -1 do
						data = TalentSet[TreeIndex] .. data;
					end
				end
				if TreeIndex > 1 and data ~= "" then
					data = "-" .. data;
				end
			end
			local LOC = nil;
			if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
				LOC = "cn";
			elseif CT.LOCALE == "deDE" then
				LOC = "de";
			elseif CT.LOCALE == "esES" then
				LOC = "es";
			elseif CT.LOCALE == "frFR" then
				LOC = "fr";
			elseif CT.LOCALE == "itIT" then
				LOC = "it";
			elseif CT.LOCALE == "ptBR" then
				LOC = "pt";
			elseif CT.LOCALE == "ruRU" then
				LOC = "ru";
			elseif CT.LOCALE == "koKR" then
				LOC = "ko";
			end
			if CT.BUILD == "CLASSIC" then
				if LOC == nil then
					return "classic.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				else
					return LOC .. ".classic.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				end
			elseif CT.BUILD == "BCC" then
				if LOC == nil then
					return "tbc.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				else
					return LOC .. ".tbc.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				end
			elseif CT.BUILD == "WRATH" then
				local class = strlower(Frame.class);
				if class == "deathknight" then
					class = "death-knight";
				end
				if LOC == nil then
					return "www.wowhead.com/wotlk/talent-calc/" .. class .. "/" .. data;
				else
					return "www.wowhead.com/wotlk/" .. LOC .. "/talent-calc/" .. class .. "/" .. data;
				end
			end
			return nil;
		end,
	};
	VT.ExternalCodec.nfu = {
		ImportCode = function(url, codec)
			local class, data = nil;
			if CT.BUILD == "CLASSIC" then
				--	http://www.nfuwow.com/talents/60/warrior/tal/0530500030200000000000000000000000054250110530001051
				class, data = strmatch(url, "nfuwow%.com/talents/60/([^/]+)/tal/(%d+)");
			elseif CT.BUILD == "BCC" then
				--	http://www.nfuwow.com/talents/warrior/index.html?350003013020000000000000000000000000000000000055511033010103531331
				class, data = strmatch(url, "nfuwow%.com/talents/([^/]+)/index.html%?(%d+)");
			elseif CT.BUILD == "WRATH" then
				--	http://www.nfuwow.com/talents/80/deathknight/index.html?0000000000000000000000000000320023503522030123000331013512300000000000000000000000000000
				class, data = strmatch(url, "nfuwow%.com/talents/80/([^/]+)/index.html%?(%d+)");
			else
				return nil;
			end
			if class ~= nil and data ~= nil then
				class = strupper(class);
				if DT.TalentDB[class] then
					return class, DT.MAX_LEVEL, data;
				end
			end
			return nil;
		end,
		ExportCode = function(Frame, codec)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local data = "";
			for TreeIndex = 1, 3 do
				local TalentSet = TreeFrames[TreeIndex].TalentSet;
				for TreeIndex = 1, #ClassTDB[SpecList[TreeIndex]] do
					data = data .. TalentSet[TreeIndex];
				end
			end
			if CT.BUILD == "CLASSIC" then
				return "www.nfuwow.com/talents/60/" .. strlower(Frame.class) .. "/tal/" .. data;
			elseif CT.BUILD == "BCC" then
				return "www.nfuwow.com/talents/" .. strlower(Frame.class) .. "/index.html?" .. data;
			elseif CT.BUILD == "WRATH" then
				return "www.nfuwow.com/talents/80/" .. strlower(Frame.class) .. "/index.html?" .. data;
			end
			return nil;
		end,
	};
	VT.ExternalCodec.wowfan = {
		--	WTF?
		declass = {
			["0"] = "DRUID",
			["o"] = "MAGE",
			["c"] = "HUNTER",
			["b"] = "PRIEST",
			["f"] = "ROGUE",
			["h"] = "SHAMAN",
			["s"] = "PALADIN",
			["I"] = "WARLOCK",
			["j"] = "DEATHKNIGHT",
			["L"] = "WARRIOR",
		},
		--[[
			00	0
			--
			01	z
			02	M
			03	c
			04	m
			05	V
			--
			10	o
			11	k
			12	R
			13	s
			14	a
			15	q
			--
			20	b
			21	d
			22	r
			23	f
			24	w
			25	i
			--
			30	h
			31	u
			32	G
			33	I
			34	N
			35	A
			--
			40	L
			41	p
			42	T
			43	j
			44	n
			45	y
			--
			50	x
			51	t
			52	g
			53	e
			54	v
			55	E
		--]]
		--[[
			--				p2
			--		0	1	2	3	4	5
			--
			--	0	0	z	M	c	m	V
			--
			--	1	o	k	R	s	a	q
			--
			--	2	b	d	r	f	w	i
			--
			p1	3	h	u	G	I	N	A
			--
			--	4	L	p	T	j	n	y
			--
			--	5	x	t	g	e	v	E
			--
			--	ASCII
				48	122	77	99	109	86
				111	107	82	115	97	113
				98	100	114	102	119	105
				104	117	71	73	78	65
				76	112	84	106	110	121
				120	116	103	101	118	69
			--
		--]]
		--[[
			0zMcmV
			okRsaq
			bdrfwi
			huGINA
			LpTjny
			xtgevE
			--
			0obhLx
			zkdupt
			MRrGTg
			csfIje
			mawNnv
			VqiAyE
		--]]
		base = {	--	base[p1][p2]
			[0] = {
				[0] = "0",
				[1] = "z",
				[2] = "M",
				[3] = "c",
				[4] = "m",
				[5] = "V",
			},
			[1] = {
				[0] = "o",
				[1] = "k",
				[2] = "R",
				[3] = "s",
				[4] = "a",
				[5] = "q",
			},
			[2] = {
				[0] = "b",
				[1] = "d",
				[2] = "r",
				[3] = "f",
				[4] = "w",
				[5] = "i",
			},
			[3] = {
				[0] = "h",
				[1] = "u",
				[2] = "G",
				[3] = "I",
				[4] = "N",
				[5] = "A",
			},
			[4] = {
				[0] = "L",
				[1] = "p",
				[2] = "T",
				[3] = "j",
				[4] = "n",
				[5] = "y",
			},
			[5] = {
				[0] = "x",
				[1] = "t",
				[2] = "g",
				[3] = "e",
				[4] = "v",
				[5] = "E",
			},
		},
		--	encode[p1p2] = code
		--	decode[code] = p1p2
		ImportCode = function(url, codec)
			local class, data = nil;
			if CT.BUILD == "CLASSIC" then
				class, data = strmatch(url, "60%.wowfan%.net/[e]*[n]*[/]*%?talent#(.)(.+)");
			elseif CT.BUILD == "BCC" then
				--	https://70.wowfan.net/talent/index.html?cn&druid&51402201050313520105110000000000000000000000000000000000000000
				class, data = strmatch(url, "70%.wowfan%.net/talent/index%.html%?[ce]n&([a-z]+)&(%d+)");
				if class ~= nil and data ~= nil then
					class = strupper(class);
					if DT.TalentDB[class] then
						return class, DT.MAX_LEVEL, data;
					end
				end
				return nil;
			elseif CT.BUILD == "WRATH" then
				class, data = strmatch(url, "80%.wowfan%.net/[e]*[n]*[/]*%?talent#(.)(.+)");
			else
				return nil;
			end
			if class ~= nil and data ~= nil then
				class = codec.declass[class];
				if class ~= nil then
					local ClassTDB = DT.TalentDB[class];
					local SpecList = DT.ClassSpec[class];
					if ClassTDB ~= nil and SpecList ~= nil then
						local decode = codec.decode;
						local dec = "";
						local SpecIndex = 1;
						local TreeTDB = ClassTDB[SpecList[SpecIndex]];
						local len = #TreeTDB;
						local pos = 0;
						for index = 1, #data do
							local v = strsub(data, index, index);
							if v == "Z" then
								if SpecIndex >= 3 then
									return class, DT.MAX_LEVEL, dec;
								end
								if pos < len then
									dec = dec .. CT.RepeatedZero[len - pos];
								end
								SpecIndex = SpecIndex + 1;
								TreeTDB = ClassTDB[SpecList[SpecIndex]];
								len = #TreeTDB;
								pos = 0;
							else
								if decode[v] == nil then
									return nil;
								end
								pos = pos + 2;
								if pos >= len then
									if pos == len then
										dec = dec .. decode[v];
									else
										dec = dec .. decode.short[v];
									end
									SpecIndex = SpecIndex + 1;
									if SpecIndex >= 3 then
										return class, DT.MAX_LEVEL, dec;
									end
									TreeTDB = ClassTDB[SpecList[SpecIndex]];
									len = #TreeTDB;
									pos = 0;
								else
									dec = dec .. decode[v];
								end
							end
						end
						return class, DT.MAX_LEVEL, dec;
					end
				end
			end
			return nil;
		end,
		ExportCode = function(Frame, codec)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local url = nil;
			if CT.BUILD == "CLASSIC" then
				if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
					url = "60.wowfan.net/?talent#";
				else
					url = "60.wowfan.net/en/?talent#";
				end
			elseif CT.BUILD == "BCC" then
				local data = "";
				for TreeIndex = 1, 3 do
					local TalentSet = TreeFrames[TreeIndex].TalentSet;
					for TreeIndex = 1, #ClassTDB[SpecList[TreeIndex]] do
						data = data .. TalentSet[TreeIndex];
					end
				end
				if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
					return "70.wowfan.net/talent/index.html?cn&" .. strlower(Frame.class) .. "&" .. data;
				else
					return "70.wowfan.net/talent/index.html?en&" .. strlower(Frame.class) .. "&" .. data;
				end
			elseif CT.BUILD == "WRATH" then
				if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
					url = "80.wowfan.net/?talent#";
				else
					url = "80.wowfan.net/en/?talent#";
				end
			else
				return nil;
			end
			url = url .. codec.enclass[Frame.class];
			local ofs = 0;
			local encode = codec.encode;
			local data = "";
			for TreeIndex = 1, 3 do
				local TalentSet = TreeFrames[TreeIndex].TalentSet;
				for TreeIndex = 1, #ClassTDB[SpecList[TreeIndex]] do
					data = data .. TalentSet[TreeIndex];
				end
			end
			for SpecIndex = 1, 3 do
				local TreeTDB = ClassTDB[SpecList[SpecIndex]];
				local len = #TreeTDB;
				local sub = strsub(data, ofs + 1, ofs + len);
				local val = strmatch(sub, "^(.-)[0]*$");
				if val == "" then
					url = url .. "Z";
				else
					local num = #val;
					for index = 1, num, 2 do
						local pat = strsub(val, index, index + 1);
						if encode[pat] == nil then
							return nil;
						end
						url = url .. encode[pat];
					end
					if num < #sub then
						url = url .. "Z";
					end
				end
				--
				ofs = ofs + len;
			end
			for i = 1, 3 do
				if strsub(url, -1, -1) == "Z" then
					url = strsub(url, 1, -2);
				else
					break;
				end
			end
			return url;
		end,
		init = function(codec)
			local base = codec.base;
			local encode = {  };
			local decode = { short = {  }, };
			for p1 = 0, 5 do
				for p2 = 0, 5 do
					local c = base[p1][p2];
					encode[p1 .. p2] = c;
					decode[c] = p1 .. p2;
				end
				encode[tostring(p1)] = encode[p1 .. "0"];
				decode.short[base[p1][0]] = tostring(p1);
			end
			codec.encode = encode;
			codec.decode = decode;
			local declass = codec.declass;
			local enclass = {  };
			for c, class in next, declass do
				enclass[class] = c;
			end
			codec.enclass = enclass;
		end,
	};
	VT.ExternalAddOn["D4C"] = {
		addon = "DBM",
		list = {  },
		handler = function(self, sender, msg)
			local temp = { strsplit("\t", msg) };
			if temp[1] == "V" or temp[1] == "GV" then
				--	tremove(temp, 1);
				temp[1] = tostring(temp[4]);
				self.list[Ambiguate(sender, 'none')] = temp;
				--	print(sender, "DBM Version", temp[4], unpack(temp));
				--	print(sender, "DBM Version", temp[3]);	--	temp[3]
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
				--	print(sender, "DBM Version", temp[4], unpack(temp));
				--	print(sender, "DBM Version", temp[3]);	--	temp[3]
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
				--	print(sender, "BW Version", temp[1] .. "-" .. temp[2], unpack(temp));	--	temp[1] .. "-" .. temp[2]
				return true;
			end
		end,
	};

	MT.RegisterOnInit('EXTERNAL', function(LoggedIn)
		for prefix, addon in next, VT.ExternalAddOn do
			if addon.init ~= nil then
				addon:init();
			end
			if not IsAddonMessagePrefixRegistered(prefix) then
				RegisterAddonMessagePrefix(prefix);
			end
		end
		for media, codec in next, VT.ExternalCodec do
			if codec.init ~= nil then
				codec:init();
			end
			if codec.ExportCode ~= nil then
				VT.ExportButtonMenuDefinition.num = VT.ExportButtonMenuDefinition.num + 1;
				VT.ExportButtonMenuDefinition[VT.ExportButtonMenuDefinition.num] = {
					param = codec,
					text = media,
				};
			end
		end
	end);
	MT.RegisterOnLogin('EXTERNAL', function(LoggedIn)
	end);

-->
