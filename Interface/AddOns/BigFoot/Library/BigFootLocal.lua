
--===================================================================================
-- BigFootLocal - 版本：1.0
-- 日期：2007-10-23
-- 作者：独孤傲雪
-- 描述：本地化类库, 该类库使得写插件时不再为本地化时取变量名而苦恼. 形式上支持了中文作为变量名.
-- 版权所有：艾泽拉斯国家地理
--===================================================================================

local __MAJOR_VERSION_NUMBER = 1;
local __MINOR_VERSION_NUMBER = 0;

local BLocalClass = {};
BLocalClass.localizations = {};	-- prototype

-------------------
-- 建立新的索引机制, 使之带有缺省为key的缺省值!
-------------------
local function __Bindex(__t, __k)
	assert(__k and type(__k) == "string", format("%s -- The localization key (%s) must be a string value!", tostring(rawget(__t, "__NAME")), tostring(__k)));

	return __k;
end

-------------------
-- 建立新的赋值机制
-------------------
local function __Bnewindex(__t, __k, __v)
	assert(__k and type(__k) == "string", format("%s -- The localization key (%s) must be a string value!", tostring(rawget(__t, "__NAME")), tostring(__k)));

	if (not __v or tostring(__v) == "true") then
		rawset(__t, __k, __k);
	else
		rawset(__t, __k, __v);
	end
end

-- metatable
BLocalClass.mt = {__index = __Bindex, __newindex = __Bnewindex};

local function __getLocal(self, __name)
	assert(__name and type(__name) == "string", "BLocal -- The parameter must be a string value!");

	if (not BLocalClass.localizations[__name]) then
		BLocalClass.localizations[__name] = setmetatable({}, BLocalClass.mt);
		BLocalClass.localizations[__name].__NAME = __name;
	end

	return BLocalClass.localizations[__name];
end

BLocalClass.GetLocal = __getLocal;

function BLocalClass:constructor()
end

BLibrary:Register(BLocalClass,"BLocalClass",__MAJOR_VERSION_NUMBER,__MINOR_VERSION_NUMBER);

BLocal = BLibrary("BLocalClass");
getmetatable(BLocal).__call = __getLocal;

--[[
local L = BLocal("BigFoot");	-- 参数建议为插件名
L["hello world!"] = "hello bigfoot";	-- 普通赋值
ChatFrame1:AddMessage(L["hello world!"]);	--> hello bigfoot!
L["hello world!"] = true;		-- 特殊赋值
ChatFrame1:AddMessage(L["hello world!"]);	--> hello world!
L["hello wow!"] = nil;			-- 特殊赋值
ChatFrame1:AddMessage(L["hello wow!"]);		--> hello wow!
ChatFrame1:AddMessage(L["你好大脚"]);		--> 你好大脚 -- 缺省值就是key值
ChatFrame1:AddMessage(L[1]);	-- key只能为string类型
]]
