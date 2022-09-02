--[[--
	ALA@163UI
--]]--

local __version = 1;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

-->			versioncheck
	local __serializer = __ala_meta__.__serializer;
	if __serializer ~= nil and __serializer.__minor >= __version then
		return;
	elseif __serializer == nil then
		__serializer = CreateFrame('FRAME');
		__ala_meta__.__serializer = __serializer;
	else
		if __serializer.Halt ~= nil then
			__serializer:Halt();
		end
	end
	__serializer.__minor = __version;

-->

-->		upvalue
	local geterrorhandler = geterrorhandler;
	local type, select = type, select;
	local next = next;
	local min = math.min;
	local table_concat = table.concat;
	local string = string;
	local strbyte, strchar, gsub, gmatch = string.byte, string.char, string.gsub, string.gmatch;
	local frexp, inf = math.frexp, math.huge;
	local tonumber, tostring = tonumber, tostring;

-->		serializer
	--[=[
		gsub	%c = \000-\032, \127
		use ~(\126)	as segment escape
		use {(\124)
		use }(\125)
		use !(\33)	as string escape
		--
		\126		!.			\33\35			\33\35
		\127		!/			\33\36			\33\36
		used, bad seg for gsub	\33\37			\33\37
		dict									\33\38 ~ \33\91
		\0 ~ \33	!(b+92)		\33\b+92		\33\92 ~ \33\125
	--]=]
	local _LT_coreSerializerDict = {
		"Create",
		"FRAME",
		"Frame",
		"BUTTON",
		"Button",
		"CHECK",
		"Check",
		"SCROLL",
		"Scroll",
		"SLIDER",
		"Slider",
		"TEXTURE",
		"Texture",
		"Type",
		"Key",
		"Name",
		"Enable",
		"Show",
		"Width",
		"Height",
		"Size",
		"Point",
		"BOTTOM",
		"TOP",
		"LEFT",
		"RIGHT",
		"CENTER",
		"Strata",
		"Level",
		"Parent",
		"Scale",
		"Alpha",
		"Backdrop",
		"Layer",
		"BACKGROUND",
		"BORDER",
		"OVERLAY",
		"Color",
		"Font",
		"String",
		"Justify",
		"Text",
		"Interface",
		"Shared",
		"AddOn",
		"Layout",
		"Child",
		"BlendMode",
		-- "ADD",
		"Icon",
		"Mouse",
		-- "Click",
		-- "Motion",
		"TexCoord",
		-- "core",
		-- "Selected",
		-- "Int",
		--	Movable, MaxLines, All, core, Border, Center, Media, Status
		"show",
		-- "page",
		-- "point",
		--	point texture
		--	InOverrideUI spacing scale hidden
	};
	local _LN_coreSerializerDict = min(#_LT_coreSerializerDict, 52);
	for _index = 1, _LN_coreSerializerDict do
		local _s = _LT_coreSerializerDict[_index];
		local _c = "!" .. strchar(_index + 37);
		_LT_coreSerializerDict[_s] = _c;
		_LT_coreSerializerDict[_c] = _s;
	end
	local _LT_SerializeTemp = { "~a", };
	local function _LF_coreSerializer_StringReplacer(s)
		local b = strbyte(s);
		if b <= 33 then
			return "!" .. strchar(b + 90);	--	\33\90 ~ \33\123
		elseif b == 124 then
			return [[!"]];
		elseif b == 126 then
			return [[!#]];	--	\33\35
		elseif b == 127 then
			return [[!$]];	--	\33\36
		else
			geterrorhandler()("Error Replace String: " .. c);
		end
	end
	local function _LF_coreDeserializer_StringReplacer(c)
		if c >= "!Z" then
			return strchar(strbyte(c, 2, 2) - 90);
		elseif c == [[!"]] then
			return "|";
		elseif c == [[!#]] then
			return "~";
		elseif c == [[!$]] then
			return "\127";
		else
			return geterrorhandler()("Invalid Escape: " .. c);
		end
	end
	local function _LF_coreDeserializer_StringReplacerDict(c)
		if c >= "!Z" then
			return strchar(strbyte(c, 2, 2) - 90);
		elseif c == [[!"]] then
			return "|";
		elseif c == [[!#]] then
			return "~";
		elseif c == [[!$]] then
			return "\127";
		else--if c > "!!" then
			return _LT_coreSerializerDict[c] or geterrorhandler()("Invalid Escape: " .. c);
		end
	end
	local _LF_coreSerializer = nil;
	_LF_coreSerializer = function(val, tbl, pos, useDict)
		local _Type = type(val);
		if _Type == 'string' then
			pos = pos + 1; tbl[pos] = "~S";
			val = gsub(val, "[%c !~|]", _LF_coreSerializer_StringReplacer);
			if useDict then
				for _index = 1, _LN_coreSerializerDict do
					local _s = _LT_coreSerializerDict[_index];
					val = gsub(val, _s, _LT_coreSerializerDict[_s]);
				end
			end
			pos = pos + 1; tbl[pos] = val;
			return pos, true;
		elseif _Type == 'number' then
			if val == inf then
				pos = pos + 1; tbl[pos] = "~N";
				pos = pos + 1; tbl[pos] = "inf";
			elseif val == -inf then
				pos = pos + 1; tbl[pos] = "~N";
				pos = pos + 1; tbl[pos] = "-inf";
			else
				local str = tostring(val);
				if tonumber(str) == val then
					pos = pos + 1; tbl[pos] = "~N";
					pos = pos + 1; tbl[pos] = str;
				else
					local x, exp = frexp(val);
					x = x * 9007199254740992 + 0.5;	--	2 ^ 53
					x = x - x % 1.0;
					pos = pos + 1; tbl[pos] = "~F";
					pos = pos + 1; tbl[pos] = tostring(x);
					pos = pos + 1; tbl[pos] = "~f";
					pos = pos + 1; tbl[pos] = tostring(exp - 53);
				end
			end
			return pos, true;
		elseif _Type == 'boolean' then
			pos = pos + 1; tbl[pos] = val and "~B" or "~b";
			return pos, true;
		elseif _Type == 'table' and (val[0] == nil or type(val[0]) ~= 'userdata') then
			pos = pos + 1; tbl[pos] = "~T";
			for k, v in next, val do
				local start = pos;
				local _isValid = nil;
				pos, _isValid = _LF_coreSerializer(k, tbl, pos, useDict);
				if _isValid then
					pos, _isValid = _LF_coreSerializer(v, tbl, pos, useDict);
					if not _isValid then
						pos = start;
					end
				end
			end
			pos = pos + 1; tbl[pos] = "~t";
			return pos, true;
		elseif _Type == 'nil' then
			pos = pos + 1; tbl[pos] = "~Z";
			return pos, true;
		else
		end

		return pos, false;
	end
	local _LF_coreDeserializer = nil;
	_LF_coreDeserializer = function(iter, noproceed, _Type, _Data, useDict, _Level)
		if _Type == nil then
			_Type, _Data = iter();
		end
		local _Val = nil;
		if _Type == nil then
			geterrorhandler()("Incomplete String!");
		elseif _Type == "~S" then
			if useDict then
				_Val = gsub(_Data, "!.", _LF_coreDeserializer_StringReplacerDict);
			else
				_Val = gsub(_Data, "!.", _LF_coreDeserializer_StringReplacer);
			end
		elseif _Type == "~N" then
			_Val = tonumber(_Data);
		elseif _Type == "~F" then
			local _Type2, _Data2 = iter();
			if _Type2 == "~f" then
				local x = tonumber(_Data);
				local exp = tonumber(_Data2);
				if x ~= nil and exp ~= nil then
					_Val = x * (2 ^ exp);
				else
					geterrorhandler()("Error Deserializing ~F~f: " .. _Data .. ", " .. _Data2);
				end
			else
				geterrorhandler()("Invalid Type following ~T: " .. _Type2);
			end
		elseif _Type == "~B" then
			_Val = true;
		elseif _Type == "~b" then
			_Val = false;
		elseif _Type == "~Z" then
			_Val = nil;
		elseif _Type == "~T" then
			_Val = {  };
			local key, val;
			while true do
				_Type, _Data = iter();
				if _Type == "~t" then
					break;
				end
				key = _LF_coreDeserializer(iter, true, _Type, _Data, useDict, _Level + 1);
				if key == nil then
					geterrorhandler()("Invalid Table Key: " .. _Type .. ", " .. _Data);
				end
				_Type, _Data = iter();
				val = _LF_coreDeserializer(iter, true, _Type, _Data, useDict, _Level + 1);
				if val == nil then
					geterrorhandler()("Invalid Table Val: " .. _Type .. ", " .. _Data);
				end
				_Val[key] = val;
			end
		elseif _Type == "~~" then
			return;
		else
			geterrorhandler()("Invalid Type: " .. _Type);
		end
		if noproceed == true then
			return _Val;
		else
			return _Val, _LF_coreDeserializer(iter, nil, nil, nil, useDict, _Level + 1);
		end
	end
	--
	local function _F_coreSerializerInternal(useDict, ...)
		local pos = 1;
		for index = 1, select("#", ...) do
			pos = _LF_coreSerializer(select(index, ...), _LT_SerializeTemp, pos, useDict);
		end
		pos = pos + 1;
		_LT_SerializeTemp[pos] = "~~";
		if useDict then
			_LT_SerializeTemp[1] = "~d";
		else
			_LT_SerializeTemp[1] = "~a";
		end
		return table_concat(_LT_SerializeTemp, "", 1, pos);
	end
	local function _F_coreDeserializerInternal(str)
		str = gsub(str, "[%c ]", "");
		local iter = gmatch(str, "(~.)([^~]*)");
		local rev = iter();
		if rev == "~a" then
			return xpcall(_LF_coreDeserializer, geterrorhandler(), iter, nil, nil, nil, false, 0);
		elseif rev == "~d" then
			return xpcall(_LF_coreDeserializer, geterrorhandler(), iter, nil, nil, nil, true, 0);
		else
			return false;
		end
	end
	__serializer._F_coreSerializer = function(...)
		return _F_coreSerializerInternal(false, ...);
	end
	__serializer._F_coreSerializerNoDict = _F_coreSerializer;
	__serializer._F_coreSerializerDict = function(...)
		return _F_coreSerializerInternal(true, ...);
	end
	__serializer._F_coreDeserializer = _F_coreDeserializerInternal;
-->

function __serializer:Halt()
	__serializer:UnregisterAllEvents();
	__serializer:SetScript("OnEvent", nil);
end
