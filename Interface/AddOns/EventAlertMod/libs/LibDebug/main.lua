--  Copyright (C) 2009, 2010 Tyson Brown
--
--  This file is part of LibDebug.
--
--  LibDebug is free software: you can redistribute it and/or modify
--  it under the terms of the GNU Lesser General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  LibDebug is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU Lesser General Public License for more details.
--
--  You should have received a copy of the GNU Lesser General Public License
--  along with LibDebug.  If not, see <http://www.gnu.org/licenses/>.

local version = 4
local pp=print -- plain,old,boring print
if LibDebug and LibDebug.version >= version then return end

LibDebug = setmetatable(LibDebug or {}, nil)

if LibDebug.new_hyperlink == ChatFrame_OnHyperlinkShow then
	-- Restore the old hyperlink function if nobody else has
	-- tampered with it since we did.
	ChatFrame_OnHyperlinkShow = LibDebug.old_hyperlink
end

local exempt = LibDebug.exempt or {}
local fake_G = setmetatable(LibDebug.fake_G or {}, nil)
local meta = LibDebug.meta or {}
local wipe = table.wipe

wipe(LibDebug)
wipe(meta)
wipe(fake_G)
LibDebug.exempt = exempt
LibDebug.version = 0
LibDebug.fake_G = fake_G
LibDebug.meta = meta
local function GetChatFrame(chat)
	if (chat) then
		for i=1,NUM_CHAT_WINDOWS do
			local _, _, _, _, _, _, shown = FCF_GetChatWindowInfo(i)
			local frame=_G["ChatFrame" .. i]
			if frame.name==chat and (shown or frame.isDocked) then
				return frame
			end
		end
	end
	return DEFAULT_CHAT_FRAME
end
local function ParseDebugStack(stack)

	--local file, line = stack:match("Interface[/\\]AddOns[\\//]([/\\%w_]*%.[Ll][Uu][Aa]):(%d-):")

	-- debugstack seems to truncate long file names, so if we don't get a match, we'll try removing some of the bits we're trying to match with.
	--if not file then file, line = stack:match("AddOns[\\//]([/\\%w_]*%.[Ll][Uu][Aa]):(%d-):") end -- First Interface/
	--if not file then file, line = stack:match("[\\//]([/\\%w_]*%.[Ll][Uu][Aa]):(%d-):") end  -- Then Interface/AddOns/
	--file=nil
	local addon,file, line = stack:match("([%w_]*)[/\\]?([%w_]*%.[Ll][Uu][Aa]):(%d-):")
	return file,line,addon
end

local DEFAULT_CHAT_FRAME=DEFAULT_CHAT_FRAME
local _G = _G

-- The proxy is for interacting with the actual environment.
-- Its main purpose is to notice keys set using _G, and
-- create exemptions for them.
--
-- So that you can still iterate through the global table,
-- should you need to, we also create proxy next and pairs functions.
-- We're so nice.
local proxy = {}
proxy._G = proxy

setmetatable(proxy, {
	__index=_G,
	__newindex = function(_, key, val)
		exempt[key] = true
		_G[key] = val
	end
})

-- Don't raise errors if using _G directly.
fake_G._G = proxy

-- I'll define this at the end of the file, it's rather big.
local print

function fake_G.print(...)
	print(...)
end

local next = _G.next

function fake_G.next(tbl, key)
	if tbl == proxy then
		return next(_G, key)
	end

	return next(tbl, key)
end

function fake_G.pairs(tbl)
	if tbl == proxy then
		return next, _G, nil
	end

	return next, tbl, nil
end

-- Make a copy of the coroutine table.
fake_G.coroutine = {}
for k,v in pairs(_G.coroutine) do fake_G.coroutine[k] = v end

local type, create, resume, status = type, _G.coroutine.create, _G.coroutine.resume, _G.coroutine.status

-- Appends the stack of the coroutine to msg, and returns the result.
local function coroutine_error_msg(msg, co)
	return tostring(msg).."\n---BEGIN_COROUTINE_STACK---\n"..debugstack(co).."---END_COROUTINE_STACK---"
end

-- A little wrapper function to handle the return values of coroutine.resume,
-- and invoke the global error handler in the event of an error.
local function resume_wrapper(co, state, ...)
	if state == false then
		geterrorhandler()(coroutine_error_msg(..., co))
		return false, ...
	else
		return state, ...
	end
end

-- This is a similar wrapper, but used by coroutine.wrap,
-- It returns the passed paramaters or raises an error.
local function wrap_wrapper(co, state, ...)
	if state == false then
		-- For some reason, the call at the bottom of the stack is not displayed here
		-- I really don't know why.
		_G.geterrorhandler()(coroutine_error_msg(..., co))
		error(...)
	else
		return ...
	end
end

local fake_G_resume = function(co, ...)
	if type(co) ~= "thread" then return false, "Invoked LibDebug.coroutine.resume on a non-thread."
	elseif status(co) == "dead" then return false, "Invoked LibDebug.coroutine.resume on terminated thread."
	else return resume_wrapper(co, _G.coroutine.resume(co, ...)) end
end

fake_G.coroutine.resume = fake_G_resume

function fake_G.coroutine.wrap(f)
	local co = _G.coroutine.create(f)
	return function (...) return wrap_wrapper(co, fake_G_resume(co, ...)) end
end

function meta.__index(_, key)
	local val = _G[key]

	if val == nil and not exempt[key] then
		error("Attempt to access undefined variable '"..tostring(key).."'.", 2)
	end

	return val
end

function meta.__newindex(_, key, value)
	if exempt[key] then
		_G[key] = value
	else
		error("Attempt to set global variable '"..tostring(key).."'. Use _G if this was intentional.", 2)
	end
end

setmetatable(fake_G, meta)

setmetatable(LibDebug, {
	__call = function ()
		local old_env = getfenv(2)
		if old_env ~= _G then
			error("The calling function has a modified environment, I won't replace it.", 2)
		end

		setfenv(2, fake_G)
	end
})

local formatter = {} --#formatters
local function badformat(var)
	return "|cffff8000"..tostring(var).."|r"
end

formatter["nil"] = function()
	return "|cff808080nil|r"
end

function formatter.boolean(val)
	return val and "|cff80c0fftrue|r" or "|cff80c0fffalse|r"
end

function formatter.number(val)
	return "|cffff80ff"..tostring(val).."|r"
end

local function charfix(c)
	local byte = c:byte()

	if byte == 9 then
		return "|cffff8000\\t|cffffff00"
	end

	if byte == 10 then
		return "|cffff8000\\n|cffffff00"
	end

	if byte == 34 then
		return "|cffff8000\\\"|cffffff00"
	end

	if byte < 32 or byte > 126 then
		return ("|cffff8000\\%03d|cffffff00"):format(byte)
	end

	return c
end

function formatter.string(val)
	if val=='' then val='""' end
	return ("|cffffff00%s|r"):format(val:gsub("|", "||"):gsub(".", charfix))
end

local next_free = 1
local tables = setmetatable({}, {__mode="v"})
local rtables = setmetatable({}, {__mode="k"})

function formatter.table(val)
	local id = tables[val]

	if not id then
		id = next_free
		next_free = next_free + 1
		tables[val] = id
	end

	rtables[id] = val

	return ("|cff40cc40|Hlibdebug:%d|h[%s]|h|r"):format(id, tostring(val))
end

local function tostring(var)
	return (formatter[type(var)] or badformat)(var)
end

local temp = {}
print = function (...)
	DEFAULT_CHAT_FRAME=GetChatFrame("LibDebug")
	local n = select("#", ...)
	wipe(temp)

	local file,line,addon=ParseDebugStack(debugstack(3,1,0))
	local t=GetTime()
	t=t-math.floor(t)
	t=math.floor(t*1000)
	local dt=date("*t")
	temp[1]=format("%2$s:%3$s:%4$s.%1$03d",t,dt.hour,dt.min,dt.sec)
	temp[2] = ("|cff40ff40%s::%s|r:|cff40c0ff%5d|r>"):format(addon or 'Unknown',file or "???", line or 0)

	for i = 1,n do
		temp[i+2] = tostring(select(i, ...))
	end

	DEFAULT_CHAT_FRAME:AddMessage(table.concat(temp, " "), 0.8, 0.8, 0.8)
end

local showTable -- This is further down.

local old = ChatFrame_OnHyperlinkShow
LibDebug.old_hyperlink = old

function ChatFrame_OnHyperlinkShow(...)
	local _, link = ...
	local id = tonumber(string.match(link or "", "^libdebug:(.*)"))

	if id then
		local tbl = rtables[id]
		if tbl then
			local co=coroutine.wrap(function() showTable(tbl,true) end)
			local repeater
			local interval=0.005
			repeater=function()
				local rc,res=pcall(co)
				if rc and res then
					C_Timer.After(interval,repeater)
				else
					repeater=nil
				end
			end
			return repeater()
		else
			_G.print("Apologies, that table seems to have been garbage collected.")
		end

		return
	end

	return old(...)
end

LibDebug.new_hyperlink = ChatFrame_OnHyperlinkShow

local reserved =
{
	["and"] = true,
	["break"] = true,
	["do"] = true,
	["else"] = true,
	["elseif"] = true,
	["end"] = true,
	["false"] = true,
	["for"] = true,
	["function"] = true,
	["if"] = true,
	["in"] = true,
	["local"] = true,
	["nil"] = true,
	["not"] = true,
	["or"] = true,
	["repeat"] = true,
	["return"] = true,
	["then"] = true,
	["true"] = true,
	["until"] = true,
	["while"] = true
}
local keytable={}
showTable = function(tbl)
	DEFAULT_CHAT_FRAME=GetChatFrame("LibDebug")

	DEFAULT_CHAT_FRAME:AddMessage("       ".._G.tostring(tbl)  .. (async and " async" or ""), 0.5, 0.5, 0.5)

	local meta = getmetatable(tbl)

	if type(meta) == "table" then
		DEFAULT_CHAT_FRAME:AddMessage("|cff808080@meta|r = "..tostring(meta))
	end

	local n = #tbl

	-- Do number keys first, in order.
	for i = 1,n do
		DEFAULT_CHAT_FRAME:AddMessage("["..tostring(i).."] = "..tostring(tbl[i]))
		if coroutine.running() then coroutine.yield(true) end
	end
	-- Everything else.
	-- Sort alphanumeric keys
	wipe(keytable)
	for key,_ in pairs(tbl) do
		tinsert(keytable,key)
	end
	table.sort(keytable,function(a,b) return tostring(a) < tostring(b) end)
	for _,key in ipairs(keytable) do
		local value=tbl[key]
		if type(key) ~= "number" or floor(key) ~= key or key < 1 or key > n then
			if type(key) == "string" and not reserved[key] and key:find("^[%a_][%w_]*$") then
				DEFAULT_CHAT_FRAME:AddMessage(key.." = "..tostring(value))
			else
				DEFAULT_CHAT_FRAME:AddMessage("["..tostring(key).."] = "..tostring(value))
			end
		end
		if coroutine.running() then coroutine.yield(true) end
	end
end
SLASH_DDUMP1="/ddump"
SlashCmdList['DDUMP'] = function(args,chatframe)
	local data=loadstring("return " .. args,args .. " was not a valid name")()
	pp("Dumping",args,"(",data,")")
	local co=coroutine.wrap(function() showTable(data,true) end)
	local repeater
	local interval=0.005
	repeater=function()
		local rc,res=pcall(co)
		if rc and res then
			C_Timer.After(interval,repeater)
		else
			if res then
				pp("Could not run coroutine:",res)
			end
			repeater=nil
		end
	end
	return repeater()
end
SLASH_DDUMP1="/devent"
local frame
SlashCmdList['DEVENT'] = function(args,chatframe)
	print("Not yet implemented")
	if not frame then
		frame=CreateFrame("Frame")
	end
end
