DCT_Ani_MaxFrame = 15


DCT_Ani_frameList = {}

--获得第一个未激活Frame的ID，返回0为失败
function DCT_Ani_FrameGetFreeFID()
	local i
	for i = 1,DCT_Ani_MaxFrame do
		if not DCT_Ani_frameList[i].active then return i;end
	end
	return 0
end

function DCT_Ani_FrameGetNextActiveFID(start)
	local i
	for i = start + 1,DCT_Ani_MaxFrame do
		if DCT_Ani_frameList[i].active then return i;end
	end
	return 1
end

function DCT_Ani_FrameGetPrevActiveFID(start)
	local i = start - 1
	while i > 1 do
		if DCT_Ani_frameList[i].active then return i;end
		i = i - 1
	end
	return 1
end

function DCT_Ani_FrameGetLastActiveFID()
	local i = DCT_Ani_MaxFrame
	while i > 1 do
		if DCT_Ani_frameList[i].active then return i;end
		i = i - 1
	end
	return 1
end


function DCT_Ani_FrameIsActive(fId)
	if fId < 1 or fId > DCT_Ani_MaxFrame then
		return false
	end
	return DCT_Ani_frameList[fId].active
end

function DCT_Ani_FrameInit()
	local i
	for i = 1,DCT_Ani_MaxFrame do
		table.insert(DCT_Ani_frameList,{active = false,fId = i,x = 0,y = 0, objL = {},anchor = 1})
		DCT_Ani_FrameSetAngle(i,0)
	end
end

function DCT_Ani_FrameActive(fId)
	local fp = DCT_Ani_frameList[fId]
	DCT_Ani_FrameSetAngle(fId,0)
	fp.active = true
	fp.addLast = 0
	fp.addFlag = 0
end

function DCT_Ani_FrameDisable(fId)
	local s,framep,objp
	framep = DCT_Ani_frameList[fId]
	framep.active = false
	s = table.getn(framep.objL)
	while s > 0 do
		objp = framep.objL[s]
		if objp.active then
			DCT_Ani_ObjClear(objp)
			table.remove(framep.objL,s)
		end
		s = s - 1
	end
end

function DCT_Ani_FramePos(fId,x,y)
	if fId > DCT_Ani_MaxFrame then return;end
	DCT_Ani_frameList[fId].x = x
	DCT_Ani_frameList[fId].y = y
end

--agl: 0 ~ 360
function DCT_Ani_FrameSetAngle(fId,agl)
	if fId > DCT_Ani_MaxFrame then return;end
	DCT_Ani_frameList[fId].rotSin = sin(agl)
	DCT_Ani_frameList[fId].rotCos = cos(agl)
end

--在指定Frame内创建一个Object,并将text内容赋值,并激活，如果指定了Object则不创建，直接覆盖
function DCT_Ani_FrameAddObject(fId,text,exParam,crit,saveP,obj)
	if fId > DCT_Ani_MaxFrame or fId < 1 then return nil;end
	if not DCT_Ani_frameList[fId].active then return nil;end
	if not saveP then saveP = DCT_Player;end
	local fp = DCT_Ani_frameList[fId]
	local fParam = DCT_Get("DCT_FRAME_CONFIG")[fId]
	local fEn,fCh,fSizeEn,fSizeCh,fEff

	if exParam.fEn then	fEn = exParam.fEn; else fEn = fParam.fEn;end
	if exParam.fCh then	fCh = exParam.fCh; else fCh = fParam.fCh;end
	if exParam.fSizeEn then	fSizeEn = fParam.fSizeEn + exParam.fSizeEn; else fSizeEn = fParam.fSizeEn;end
	if exParam.fSizeCh then	fSizeCh = fParam.fSizeCh + exParam.fSizeCh; else fSizeCh = fParam.fSizeCh;end
	if exParam.fEff then fEff = exParam.fEff; else fEff = fParam.fEff;end

	if obj == nil then
		obj = DCT_Ani_ObjGet();
	end

	if not fParam.anchor then fParam.anchor = 1;end
	DCT_Ani_ObjSetText(obj,text,fEn,fCh,fSizeEn,fSizeCh,fEff,exParam.color,fParam.anchor)

	obj.startTime = GetTime()
	obj.frmId = fId --obj所在FrameId
	if fp.alpha == 100 then
		obj.alphaMax = 1
	else
		obj.alphaMax = fParam.alpha / 100
	end
	DCT_Ani_AniInit(obj,fp)
	obj.active = true
	if crit and fParam.aniType ~= 3 and fParam.aniType ~= 7 then
		if DCT_Get("DCT_ScaleOnCrit") == 1 then obj.crit = true;end
	end
	--DCT_Ani_ObjScale(obj,1)
	table.insert(DCT_Ani_frameList[fId].objL,obj)
	fp.addLast = obj.startTime


	return obj
end--

function DCT_Ani_ChangeAni()
end

function DCT_Ani_FrameUpdata()
	local i,s,objC,objp,framep,theTime
	local drawX,drawY
	for i = 1,DCT_Ani_MaxFrame do
		framep = DCT_Ani_frameList[i]
		if framep.active then
			objC = table.getn(framep.objL)
			s = objC
			while s > 0 do
				objp = framep.objL[s]
				theTime = GetTime() - objp.startTime
				if theTime >= 0 then
					objp.funcAni(objp,theTime * DCT_Get("DCT_FRAME_CONFIG")[framep.fId].speed / 100)
				end
				drawX,drawY = DCT_Ani_AniRotate(objp.x,objp.y,framep.rotSin,framep.rotCos)
				--处理暴击
				if objp.crit then
					if theTime < 0.2 then
						objp.scale = 2
					elseif theTime < 0.4 then
						objp.scale = cos((theTime - 0.2) / 0.2 * 90) * 1 + 1
					else
						objp.scale = 1
					end
				end
				if objp.funcOther then objp.funcOther(objp);end
				if objp.active then
					DCT_Ani_AniUpdata(objp,drawX + framep.x,drawY + framep.y)
				else
					DCT_Ani_ObjClear(objp)
					table.remove(framep.objL,s)
				end
				s = s - 1
			end
		end
	end
end

function DCT_Ani_AniInit(obj,frameP)
	obj.alpha = 1
	obj.scale = 1
	obj.crit = false
	obj.lastscale = 1
	local aniParam = DCT_Get("DCT_FRAME_CONFIG")[frameP.fId]
	local aniType = aniParam.aniType
	--弹出
	if aniType == 1 then
		obj.p1 = 0
		obj.p4 = aniParam.param1 --第一段角度 0度为向右,逆时针
		obj.p5 = aniParam.param2 --第一段距离
		obj.p6 = aniParam.param3 --第二段角度
		obj.p7 = aniParam.param4 --第二段距离
		if aniParam.param7 then
			obj.p8 = aniParam.param7 --抖动开关
		else
			obj.p8 = 1
		end

		obj.funcAni = DCT_Ani_AniProc1

		if obj.startTime - frameP.addLast < 0.8 then
			frameP.addFlag = frameP.addFlag + 1
			if frameP.addFlag >= 3 then frameP.addFlag = 0;end
			obj.p4 = obj.p4 + aniParam.param5 * frameP.addFlag--角度修正
			obj.p5 = obj.p5 + aniParam.param6 * frameP.addFlag--距离修正
		else
			frameP.addFlag = 0
		end
	--弧度
	elseif aniType == 2 then
		obj.funcAni = DCT_Ani_AniProc2
		obj.p1 = aniParam.param1--圆 弧度 65~360
		obj.p2 = aniParam.param2--半径 50 ~ 400
		obj.p3 = aniParam.param3--1:向左开口  2:向右开口
		obj.p4 = aniParam.param4--1:顺时针  2:逆时针
		local ftime = 0.25 - (obj.p1 - 65) / 295 * 0.2
		if obj.startTime - frameP.addLast < ftime then
			local oc = table.getn(frameP.objL)
			frameP.objL[oc].startTime = obj.startTime - ftime

			local i = oc - 1
			while i > 0 do
				if frameP.objL[i + 1].startTime - frameP.objL[i].startTime < ftime then
					frameP.objL[i].startTime = frameP.objL[i + 1].startTime - ftime
				end
				i = i - 1
			end
		end
	--静态
	elseif aniType == 3 then
		obj.funcAni = DCT_Ani_AniProc3
		obj.p1 = aniParam.param1 --条目数
		obj.p2 = aniParam.param2 --生命周期
		obj.p3 = aniParam.param3 - 1 --推送方向 0:向上  1:向下
		obj.p4 = aniParam.param4 - 1 --显示方式 0:无 1:放大 2:粘连
		obj.p5 = 0--抖动用的计时
		obj.xbak = 0 --x轴坐标备份
		obj.ybak = 0 --y轴坐标备份

		obj.x = 0
		obj.y = 0
		local fc = table.getn(frameP.objL)
		if fc > 0 then
			local fixH = (frameP.objL[fc].fontSizeMax + obj.fontSizeMax) / 2 + 2
			local i
			if obj.p3 == 1 then fixH = -fixH;end
			for i = 1, fc do
				frameP.objL[i].y = frameP.objL[i].y + fixH
				frameP.objL[i].ybak = frameP.objL[i].y
				--如果超过条目数，则让其进入淡出阶段
				if i <= fc - obj.p1 + 1 then
					frameP.objL[i].active = false
				end
			end
		end
	--抛物线
	elseif aniType == 4 then
		if obj.startTime - frameP.addLast < 0.5 then
			frameP.addFlag = frameP.addFlag + 1
			if frameP.addFlag >= 3 then frameP.addFlag = 0;end
		else
			frameP.addFlag = 0
		end
		obj.funcAni = DCT_Ani_AniProc4
		obj.p1 = aniParam.param1 + 0.5 * frameP.addFlag --射出强度 0.5 ~ 5
		obj.p2 = aniParam.param2 --坠落深度 20 ~ 200
		obj.p3 = 2 --生命周期
		if aniParam.param3 == 1 then
			obj.p4 = -1
		else
			obj.p4 = 1 --方向 -1: 向左 1:向右
		end
	--水平
	elseif aniType == 5 then
		if obj.startTime - frameP.addLast < 0.65 then
			frameP.addFlag = frameP.addFlag + 1
			if frameP.addFlag >= 3 then frameP.addFlag = 0;end
		else
			frameP.addFlag = 0
		end
		obj.funcAni = DCT_Ani_AniProc5
		obj.p1 = aniParam.param1 --射出强度 0.5 ~ 5
		obj.p2 = 1.8 --生命周期
		if aniParam.param2 == 1 then
			obj.p3 = -1
		else
			obj.p3 = 1 --方向 -1: 向左 1:向右
		end
		local maxH = aniParam.fSizeEn
		if maxH < aniParam.fSizeCh then maxH = aniParam.fSizeCh;end
		obj.y = 0 - frameP.addFlag * maxH
	--垂直
	elseif aniType == 6 then
		obj.funcAni = DCT_Ani_AniProc6
		obj.p1 = aniParam.param1 --移动距离
		obj.p2 = aniParam.param2--生命周期
		if aniParam.param3 == 1 then
			obj.p3 = 1 --方向 1:向上  -1:向下
		else
			obj.p3 = -1
		end
		obj.p4 = aniParam.param4 --水平偏移
		obj.x = 0
		obj.y = 0
		obj.ybak = 0
		obj.alpha = 0
		local fc = table.getn(frameP.objL)
		while fc > 10 do
			DCT_Ani_ObjClear(frameP.objL[1])
			table.remove(frameP.objL,1)
			fc = fc - 1
		end
		if fc > 0 then
			local fixH = (frameP.objL[fc].fontSizeMax + obj.fontSizeMax) / 2
			local fixT = obj.p2 / obj.p1 * fixH / (aniParam.speed / 100)
			if obj.startTime - frameP.objL[fc].startTime < fixT then
				frameP.objL[fc].startTime = obj.startTime - fixT

				local i = fc - 1
				while i > 0 do
					fixH = (frameP.objL[i + 1].fontSizeMax + frameP.objL[i].fontSizeMax) / 2
					fixT = obj.p2 / obj.p1 * fixH / (aniParam.speed / 100)
					if frameP.objL[i + 1].startTime - frameP.objL[i].startTime < fixT then
						frameP.objL[i].startTime = frameP.objL[i + 1].startTime - fixT
					end
					i = i - 1
				end
			end
		end
	--静态分散式
	elseif aniType == 7 then
		obj.funcAni = DCT_Ani_AniProc7
		if not frameP.type7Fix then frameP.type7Fix = {{},{}};end
		obj.x = random(120) - 60;
		obj.y = random(80) - 20;
		local fixP = frameP.type7Fix
		local f = 2 + random(10)
		local fParam = DCT_Get("DCT_FRAME_CONFIG")[frameP.fId]
		if fParam.fSizeEn > fParam.fSizeCh then
			f = f + fParam.fSizeEn
		else
			f = f + fParam.fSizeCh
		end
		local i,j
		for i = 1,2 do
			if i == 1 then j = 2;else j = 1;end
			if fixP[i].op and fixP[i].op.active and fixP[i].uid == fixP[i].op.uid then
				if math.abs(obj.y - fixP[i].op.y) < 20 then
					if fixP[j].op and fixP[j].op.active and fixP[j].uid == fixP[j].op.uid then
						if fixP[i].op.y < fixP[j].op.y then
							obj.y = fixP[i].op.y - f;
						else
							obj.y = fixP[i].op.y + f;
						end
					else
						if random(2) == 1 then
							obj.y = fixP[i].op.y - f;
						else
							obj.y = fixP[i].op.y + f;
						end
					end
				end
			end
		end

		fixP[2].y = fixP[1].y
		fixP[2].op = fixP[1].op
		fixP[2].uid = fixP[1].uid
		fixP[1].y = obj.y
		fixP[1].op = obj
		fixP[1].uid = obj.uid

		obj.ybak = obj.x --x轴坐标备份
		obj.ybak = obj.y --y轴坐标备份
		obj.p1 = aniParam.param1 --时间
		obj.p5 = aniParam.param5 --缩放 1:普通  2:缩放
		if obj.p5 == 1 then obj.alpha = 0;end
	end
end

--静态分散式
function DCT_Ani_AniProc7(obj,theTime)
	if obj.p5 == 1 then
		if theTime < 0.2 then
			obj.alpha = theTime / 0.2
		elseif theTime < obj.p1 - 0.3 then
			obj.alpha = 1
		end
	elseif obj.p5 == 2 then
		if theTime < 0.05 then
			obj.scale = 1.5
		elseif theTime < 0.2 then
			obj.scale =  1.5 -  (theTime - 0.05) / 0.15 * 0.6
		elseif theTime < 0.26 then
			obj.scale =  0.9 + (theTime - 0.2) / 0.06 * 0.1
		elseif obj.scale ~= 1 then
			obj.scale = 1
		end
	elseif obj.p5 == 3 then
		if theTime < 0.1 then
			obj.scale = theTime / 0.1 * 0.7 + 1
		elseif theTime < 0.35 then
			obj.scale = (1 - (theTime - 0.1) / 0.25) * 0.7 + 1
		elseif obj.scale ~= 1 then
			obj.scale = 1
		end
		--[[
		if theTime < 0.4 then
			obj.scale = 1 + math.sin(theTime / 0.4* 3.1415926)
		else
			obj.scale = 1
		end]]
		obj.y = obj.ybak + obj.fontSizeMax * (obj.scale + 0.5) / 2
	end

	if theTime > obj.p1 - 0.3 then
		obj.alpha = 1 - (theTime - obj.p1 + 0.3) / 0.3
	if theTime > obj.p1 then obj.active = false;end
	end
end

--垂直
function DCT_Ani_AniProc6(obj,theTime)
	if theTime < obj.p2 then
		obj.y = (theTime / obj.p2) * obj.p1 * obj.p3 + obj.ybak
		obj.x = obj.p4 * (theTime / obj.p2)
	else
		obj.active = false
	end
	if theTime < 0.2 then
		obj.alpha = theTime / 0.2
	elseif theTime < obj.p2 - 0.3 then
		obj.alpha = 1
	else
		obj.alpha = 1 - (theTime - obj.p2 + 0.3) / 0.3
	end
end

--水平
function DCT_Ani_AniProc5(obj,theTime)
	if theTime < obj.p2 then
		obj.x = (theTime / obj.p2) * obj.p1	* obj.p3
	else
		obj.active = false
	end
	if theTime < 0.2 then
		obj.alpha = theTime / 0.2
	elseif theTime < obj.p2 - 0.3 then
		obj.alpha = 1
	else
		obj.alpha = 1 - (theTime - obj.p2 + 0.3) / 0.3
	end
end

--抛物线
function DCT_Ani_AniProc4(obj,theTime)
	if theTime < obj.p3 then
		obj.x = (theTime / obj.p3) * obj.p2
		obj.y = -obj.x * obj.x * 0.04 + obj.p1 * obj.x
		obj.x = obj.p4 * obj.x
		if theTime < 0.2 then
			obj.alpha = theTime * 5
		elseif theTime > obj.p3 - 0.4 then
			obj.alpha = 1 - (theTime - (obj.p3 - 0.4)) / 0.4
		else
			obj.alpha = 1
		end
	else
		obj.active = false
	end
end

--静态
function DCT_Ani_AniProc3(obj,theTime)
	if theTime < 0.2 then
		obj.alpha = theTime / 0.2
	elseif theTime < obj.p2 then
		obj.alpha = 1
	else
		if theTime < obj.p2 + 0.6 then
			obj.alpha = 1 - (theTime - obj.p2) / 0.6
		else
			obj.active = false
		end
	end

	if obj.p4 == 1 or obj.p4 == 3 then
		if theTime < 0.3 then
			obj.scale = 1 + (1 - theTime / 0.3) * 1.5
		else
			obj.scale = 1
		end
	end

	if obj.p4 == 2 or (obj.p4 == 3 and obj.scale == 1) then
		if theTime - obj.p5 > 0.05 then
			obj.x = obj.xbak + math.ceil(math.random(-1, 1))
			obj.y = obj.ybak + math.ceil(math.random(-1, 1))
			obj.p5 = theTime
		end
	end
end

--弧形
function DCT_Ani_AniProc2(obj,theTime)
	if theTime < 0.2 then
		obj.alpha = theTime / 0.2
	elseif theTime < 2 then
		obj.alpha = 1
	else
		obj.alpha = 1 - (theTime - 2.0) / 0.5
	end
	if theTime < 2.5 then
		obj.x = -obj.p2 + cos(obj.p1 / 2 - obj.p1 * theTime / 2.5) * obj.p2
		obj.y = sin(obj.p1 / 2 - obj.p1 * theTime / 2.5) * obj.p2
		if obj.p3 == 2 then	obj.x = -obj.x;end
		if obj.p4 == 2 then	obj.y = -obj.y;end
	else
		obj.active = false
	end
end

--弹出
function DCT_Ani_AniProc1(obj,theTime)
	--测试代码,向左上弹出
	obj.alpha = 1
	if theTime < 0.4 then
		obj.x = cos(obj.p4) * obj.p5 * theTime / 0.4
		obj.y = sin(obj.p4) * obj.p5 * theTime / 0.4
	elseif theTime < 1.0 then
		if theTime < 0.7 and obj.p8 == 1 then
			if theTime - obj.p1 > 0.08 then
				obj.p1 = theTime
				local ra = random(360)
				obj.p2 = obj.x + cos(ra) * 2.5
				obj.p3 = obj.y + sin(ra) * 2.5
				obj.xbak = obj.x
				obj.ybak = obj.y
			else
				obj.x = obj.xbak + (obj.p2 - obj.xbak) * (theTime - obj.p1) * 12.5
				obj.y = obj.ybak + (obj.p3 - obj.ybak) * (theTime - obj.p1) * 12.5
			end
		end
	elseif theTime < 2.0 then
		if obj.p1 < theTime then
			obj.p1 = 10000
			obj.xbak = obj.x
			obj.ybak = obj.y
		end
		obj.x = obj.xbak + cos(obj.p6) * obj.p7 * (theTime - 1.0)
		obj.y = obj.ybak + sin(obj.p6) * obj.p7 * (theTime - 1.0)
		obj.alpha = 1 - (theTime - 1.0)
	else
		obj.active = false
	end
end

function DCT_Ani_AniRotate(x,y,s,c)
	local rex,rey
	rex = x * c - y * s
	rey = x * s + y * c
	return rex,rey
end

function DCT_Ani_AniUpdata(obj,dx,dy)
	if obj.lastscale ~= obj.scale then
		obj.lastscale = obj.scale
		DCT_Ani_ObjScale(obj,obj.scale)
	end
	DCT_Ani_ObjAlpha(obj,obj.alpha * obj.alphaMax)
	DCT_Ani_ObjPos(obj,dx,dy)
end
