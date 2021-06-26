-- 以下引用自http://bbs.ngacn.cc/read.php?tid=6622128 kurapica 大大的教學
-- 插件第一个Lua文件使用，这行代码确保以下的代码以addon为环境，而不是以_G为环境， 
-- 并且在addon环境中可以访问_G的任意变量，访问的变量值也将存储到addon中，便于下次直接访问 
-- 下面的代码定义的全局变量都将保存在addon表中，而非_G 
local _ , ns = ...
setfenv(1, setmetatable(ns, { __index = function(self,  key) local v = _G[key] rawset(self, key, v) return v end })) 
_G.EventAlertMod = ns
--[[ 之後的lua 第一行均加上 setfenv(1, select(2, ...)) 來做各lua間訊息溝通
]]--

