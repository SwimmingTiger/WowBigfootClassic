
--------------------------------------移动窗体基本库---------------------------------------
-- 目前模块，请在 PLAYER_LOGIN 这个事件之前调用 BigFoot_RegistMoveFrame

BF_Frames_Config = {};

local F = CreateFrame("Frame","Bigfoot_PosFram",UIParent);
F.BCanMove = true;
F.FrameTab = {};
F.FrameDataTab = {};
F:RegisterEvent("PLAYER_ENTERING_WORLD");

local function BigFoot_SetPosDcall(name,Check_Frame) ---延迟一下 等待官方界面自己设置位置之后 再载入自己的位置
	if BF_Frames_Config.BCanMove~=nil then
		if BF_Frames_Config.BCanMove then
			F.BCanMove =true;
		else
			F.BCanMove =false;
		end
	end
	if BF_Frames_Config[Check_Frame:GetName()] and BF_Frames_Config[Check_Frame:GetName()]["Pos"]  then
		point,ref,refPoint,Pos_x,Pos_y = unpack(BF_Frames_Config[Check_Frame:GetName()]["Pos"])
		Check_Frame:ClearAllPoints();
		Check_Frame:SetPoint(point,ref,refPoint,Pos_x,Pos_y);
	else
		local TopX = Check_Frame:GetLeft();
		local TopY = Check_Frame:GetTop();
		if not TopX or not TopY then
			Check_Frame:ClearAllPoints();
			Check_Frame:SetPoint("CENTER","UIParent","CENTER",0,0);
		else
			-- dragFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",TopX,-TopY);
			Check_Frame:ClearAllPoints();
			-- Check_Frame:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",TopX,TopY);
		end
		BF_Frames_Config[Check_Frame:GetName()]={}
	end
end

local function BigFoot_SetMoveFramePos(Check_Frame)
	local name = Check_Frame:GetName();
	if not F.FrameDataTab[name] then
		F.FrameDataTab[name] ={};
	end
	if F.FrameDataTab[name].BsetPos then return end
	F.FrameDataTab[name].BsetPos =true
	BigFoot_DelayCall(BigFoot_SetPosDcall,4,name,Check_Frame)
end

local function __GetPoint(frame)
	local point,ref,refPoint,x,y = frame:GetPoint()
	ref = ref and ref:GetName() or "UIParent"
	return point,ref,refPoint,x,y
end

local function OnDragStop(self)
	self:StopMovingOrSizing()
	if not BF_Frames_Config[self:GetName()] then
		BF_Frames_Config[self:GetName()] ={};
	end
	local point,ref,refPoint,x,y = __GetPoint(self)
	BF_Frames_Config[self:GetName()]["Pos"]={point,ref,refPoint,x,y};
end

local function OnDragStart(self)
	if self:IsMovable() then
		self:StartMoving()
	end
end

local function BigFoot_SetFrameCanMove(m_Frame)
	if m_Frame and m_Frame.EnableMouse then
		local name = m_Frame:GetName();
		if (not F.BCanMove) and (F.FrameDataTab[name] and F.FrameDataTab[name].bChanged) then
			F.FrameDataTab[name].bChanged =false;
			if F.FrameDataTab[name].IsOldMouseEnabled then
				m_Frame:EnableMouse(true);
			else
				m_Frame:EnableMouse(false);
			end

			if F.FrameDataTab[name].IsOldMovable then
				m_Frame:SetMovable(true);
			else
				m_Frame:SetMovable(false);
			end
			m_Frame:StopMovingOrSizing()
		elseif (F.BCanMove and not (F.FrameDataTab[name] and F.FrameDataTab[name].bChanged)) then
			if not F.FrameDataTab[name] then
				F.FrameDataTab[name] ={};
			end
			F.FrameDataTab[name].bChanged =true;
			if m_Frame:IsMouseEnabled() then
				F.FrameDataTab[name].IsOldMouseEnabled =true;
			else
				F.FrameDataTab[name].IsOldMouseEnabled =false;
				m_Frame:EnableMouse(true);
			end
			if m_Frame:IsMovable() then
				F.FrameDataTab[name].IsOldMovable =true;
			else
				F.FrameDataTab[name].IsOldMovable =false;
				m_Frame:SetMovable(true);
			end
			m_Frame:RegisterForDrag("LeftButton");
			m_Frame:SetScript("OnDragStart", OnDragStart)
			m_Frame:SetScript("OnDragStop", OnDragStop)
			m_Frame:SetClampedToScreen(true)
		end
	end
end

local function BigFoot_CheckMoveFrame(xPos, yPos)
	local Check_Frame;
	for k, v in pairs(F.FrameTab) do
		if type(k) =="string" then
			Check_Frame = _G[k];
			if Check_Frame then
				if Check_Frame:IsShown() then
					if F.BloadPos then
						BigFoot_SetMoveFramePos(Check_Frame);
					end
					BigFoot_SetFrameCanMove(Check_Frame);
				end
			end
		end
	end
end

local lastCheckTime = 0

F:SetScript("OnUpdate",function(F,elapsed)
	local newTime = GetTime();
	if newTime - lastCheckTime > 1 then
		lastCheckTime = newTime;
		BigFoot_CheckMoveFrame();
	end
end);

F:SetScript("OnEvent", function(_, event, ...)
	if event =="PLAYER_ENTERING_WORLD" then
		for k,v in pairs (F.FrameDataTab) do
			if v.BsetPos then
				v.BsetPos = false;
			end
		end
	end
end
)

function BigFoot_CreatFrame()
	local Check_Frame;
	for k, v in pairs(F.FrameTab) do
		if type(k) =="string" then
			Check_Frame = _G[k];
			if Check_Frame and Check_Frame:IsShown() then
				BigFoot_SetMoveFramePos(Check_Frame,k,v)
			end
		end
	end
	F.BloadPos =true
end

-----------窗体名字的string---------
-- BTop 移动锚点位置 true 为左上窗体外-----------
-- BigFoot_RegistMoveFrame("CoolLine")
function BigFoot_RegistMoveFrame(Frame,BTop)
	if BTop then
		F.FrameTab[Frame] =1;
	else
		F.FrameTab[Frame] =2;
	end
end

--------------设置所有注册的窗体是否处于解锁可移动状态---------------------------------
function BigFoot_CanMoveFrame(BTop) --- true or false
	F.BCanMove = BTop
	BF_Frames_Config.BCanMove = F.BCanMove;
end

function BigFoot_BCanMoveFrame()
	return F.BCanMove;
end
