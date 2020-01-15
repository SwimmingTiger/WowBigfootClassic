--[[	RealMobHealth Events Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);
AddOn.API=AddOn.API or {};

----------------------------------
--[[	Local References	]]
----------------------------------
local AddOn_ArgumentCheck=AddOn.ArgumentCheck;
local C_Timer_After=C_Timer.After;
local geterrorhandler=geterrorhandler;
local GetTime=GetTime;
local ipairs=ipairs;
local pairs=pairs;
local select=select;
local string_upper=string.upper;
local table_ifind=AddOn.table_ifind;
local table_insert=table.insert;
local table_remove=table.remove;
local type=type;
local unpack=unpack;
local xpcall=xpcall;

--------------------------
--[[	Local Variables	]]
--------------------------
local TimerResolution=0.05;
local EventFrame=CreateFrame("Frame");
local GameEvents,AddOnEvents,Timers={},{},{};
local AddOnEventQueue={};

--------------------------
--[[	Dispatcher	]]
--------------------------
local GetCurrentDispatchedFunction,PCallDispatch; do--	function PCallDispatch(func,...)	function GetCurrentDispatchedFunction()
	local FuncStack,ArgStack={},{};
	function GetCurrentDispatchedFunction() return FuncStack[#FuncStack]; end

	local function Dispatcher()
		local arglist=ArgStack[#ArgStack];
		return FuncStack[#FuncStack](unpack(arglist,1,arglist.n));
	end

	local function CallDispatcher(func,errorhandler)
		table_insert(FuncStack,func);
		xpcall(Dispatcher,errorhandler);
		table_remove(FuncStack);
	end

	function PCallDispatch(funclist,...)
		if funclist==nil then return; end--	Silent fail if no function or table given

		local errorhandler=geterrorhandler();--	AddOns can change this at any time
		table_insert(ArgStack,{n=select("#",...),...});--	Push args to stack
		if type(funclist)=="table" then
			local index=1;
			while index<=#funclist do--	ipairs() and table.remove() don't mix
				local func=funclist[index];
				CallDispatcher(func,errorhandler);--	Call function
				if func==funclist[index] then index=index+1; end--	Iterate if entry wasn't removed
			end
		else CallDispatcher(funclist,errorhandler); end--	Dispatch single function
		table_remove(ArgStack);--	Pop stack
	end
end

----------------------------------
--[[	Internal Functions	]]
----------------------------------
local function RegisterGameEvent(event,func)
	if func==nil then func=GetCurrentDispatchedFunction(); end--	Default to currently dispatched function
	AddOn_ArgumentCheck("RegisterGameEvent",2,{"string","function"},event,func);

	event=string_upper(event);
	local funclist=GameEvents[event];--	Get function list
	if not funclist then--	Func list doesn't exist
		EventFrame:RegisterEvent(event);--	Register event (Throws error if event doesn't exist, doing this first so the function exits before writing anything)
		GameEvents[event]={func};--	Create function list
	elseif not table_ifind(funclist,func) then table_insert(funclist,func); end--	Add function if not found
end

local function UnregisterGameEvent(event,func)
	if func==nil then func=GetCurrentDispatchedFunction(); end--	Default to currently dispatched function
	AddOn_ArgumentCheck("UnregisterGameEvent",2,{"string","function"},event,func);

	event=string_upper(event);
	local funclist=GameEvents[event];--	Get func list
	local index=funclist and table_ifind(funclist,func);--	Get function index
	if index then--	Found function?
		table_remove(funclist,index);--	Remove function
		if #funclist<=0 then--	Is function list empty?
			GameEvents[event]=nil;--	Remove function list
			EventFrame:UnregisterEvent(event);--	Unregister event
		end
	end
end

local function RegisterAddOnEvent(event,func)
	if func==nil then func=GetCurrentDispatchedFunction(); end--	Default to currently dispatched function
	AddOn_ArgumentCheck("RegisterAddOnEvent",2,{"string","function"},event,func);

	event=string_upper(event);
	local funclist=AddOnEvents[event];--	Get function list
	if not funclist then AddOnEvents[event]={func};--	Create function list if it doesn't exist
	elseif not table_ifind(funclist,func) then table_insert(funclist,func); end--	Add function if not found
end

local function UnregisterAddOnEvent(event,func)
	if func==nil then func=GetCurrentDispatchedFunction(); end--	Default to currently dispatched function
	AddOn_ArgumentCheck("UnregisterAddOnEvent",2,{"string","function"},event,func);

	event=string_upper(event);
	local funclist=AddOnEvents[event];--	Get func list
	local index=funclist and table_ifind(funclist,func);--	Get function index
	if index then--	Found function?
		table_remove(funclist,index);--	Remove function
		if #funclist<=0 then AddOnEvents[event]=nil; end--	Remove function list if empty
	end
end

local function FireAddOnEvent(event,...)
	AddOn_ArgumentCheck("FireAddOnEvent",2,"string",event);

	event=string_upper(event);
	local funclist=AddOnEvents[event];
	if not funclist then return; end--	Need the function list

	if #funclist>0 then
--		AddOn events can cascade off each other, queueing them up and running them later prevents stack overflows
		local tbl={n=select("#",...)+1,event,...};--	tbl.n is supposed to be table size for unpack() later (event plus all arg entries)
		table_insert(AddOnEventQueue,tbl);
	else AddOnEvents[event]=nil; end--	List empty, remove it
end

local function SetTimerInterval(seconds,func)
	if func==nil then func=GetCurrentDispatchedFunction(); end--	Default to currently dispatched function
	AddOn_ArgumentCheck("SetTimerInterval",2,{"number","function"},seconds,func);
	if Timers[func] then Timers[func][1]=seconds;--	Update timer
	else Timers[func]={seconds,GetTime()}; end--	Create timer
end

local function ClearTimer(func)
	if func==nil then func=GetCurrentDispatchedFunction(); end--	Default to currently dispatched function
	AddOn_ArgumentCheck("ClearTimer",2,"function",func);
	Timers[func]=nil;--	Clear timer
end

AddOn.RegisterGameEvent=RegisterGameEvent;
AddOn.UnregisterGameEvent=UnregisterGameEvent;
AddOn.RegisterAddOnEvent=RegisterAddOnEvent;
AddOn.UnregisterAddOnEvent=UnregisterAddOnEvent;
AddOn.FireAddOnEvent=FireAddOnEvent;
AddOn.SetTimerInterval=SetTimerInterval;
AddOn.ClearTimer=ClearTimer;

--------------------------
--[[	Script Handlers	]]
--------------------------
EventFrame:SetScript("OnEvent",function(self,event,...)
	local funclist=GameEvents[event];
	if not funclist then self:UnregisterEvent(event); return; end--	No list, unregister and stop
	if #funclist>0 then PCallDispatch(funclist,event,...);--	PCall list
	else GameEvents[event]=nil; self:UnregisterEvent(event); end--	List empty, remove and unregister
end);

local function Timer_OnTick()
	local now=GetTime();--	Current timestamp

--	Process timers
	for func,data in pairs(Timers) do
		if now-data[2]>=data[1] then--	Check if last timestamp has reached interval
			data[2]=now;--	Set timestamp
			PCallDispatch(func,current);--	PCall function
		end
	end

--	Process AddOn Events
	while #AddOnEventQueue>0 do
		local tbl=table_remove(AddOnEventQueue,1);
		local event=tbl[1];

		local funclist=AddOnEvents[event];
		if funclist then--	Need the function list
			if #funclist>0 then PCallDispatch(funclist,unpack(tbl,1,tbl.n));--	PCall list
			else AddOnEvents[event]=nil; end--	List empty, remove it
		end
	end

--	Register next run
	C_Timer_After(TimerResolution,Timer_OnTick);
end
C_Timer_After(TimerResolution,Timer_OnTick);

------------------------------------------
--[[	External API Registration	]]
------------------------------------------
AddOn.API.RegisterAddOnEvent=RegisterAddOnEvent;
AddOn.API.UnregisterAddOnEvent=UnregisterAddOnEvent;
