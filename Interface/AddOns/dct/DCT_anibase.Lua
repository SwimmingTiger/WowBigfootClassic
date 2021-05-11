
--[[
local mask = FRMAE:CreateTexture("YOURNAME")
	mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	mask:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 4, -4)
	mask:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -4, -30)
	mask:SetBlendMode("ADD")
	mask:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 1, 1, 1, 0.76)]]

DCT_aniText = {}
DCT_ANI_MAX_TEXT = 120
DCT_aniTextFlag = DCT_ANI_MAX_TEXT

DCT_aniTexture = {}
DCT_ANI_MAX_TEXTURE = 20
DCT_aniTextureFlag = DCT_ANI_MAX_TEXTURE

DCT_Ani_Object = {}
DCT_ANI_MAX_OBJECT = 30
DCT_objFlag = DCT_ANI_MAX_OBJECT

DCT_aniCastbar = {}
DCT_ANI_MAX_CASTBAR = 15
DCT_aniCastbarFlag = DCT_ANI_MAX_CASTBAR

DCT_ANI_ENTEXTSIZE = 12
DCT_ANI_CHTEXTSIZE = 20

DCT_UID = 0

DCT_FONT_EFFECT = {
		{"",1},
		{"OUTLINE",0},
		{"THICKOUTLINE",0},
		{"OUTLINE",1},
		{"OUTLINE",2},
		{"THICKOUTLINE",2},
}

function DCT_Ani_Init()
	DCT_Ani_TextCreate()
	DCT_Ani_ObjCreate()
	DCT_Ani_TextureCreate()
	DCT_Ani_CastbarCreate()
end

function DCT_Ani_TextureCreate()
	local i,p
	for i = 1 ,DCT_ANI_MAX_TEXTURE do
		DCT_aniTexture[i] = getglobal("DCT_TEXT"):CreateTexture("DCT_aniTexture"..i,"ARTWORK")
		p = DCT_aniTexture[i]
		p:ClearAllPoints()
		p:SetAlpha(1)
		p.isTexture = true
		p.isWorking = false
		p:Hide()
	end
end

function DCT_Ani_TextureGet()
	local p = DCT_aniTexture[DCT_aniTextureFlag]
	p:SetAlpha(1)
	p:Show()
	p.isWorking = true
	if DCT_aniTextureFlag > 1 then DCT_aniTextureFlag = DCT_aniTextureFlag - 1;end
	return p
end

function DCT_Ani_TextureFree(p)
	if p.isWorking then
		DCT_aniTextureFlag = DCT_aniTextureFlag + 1
		p.isWorking = false
		p:ClearAllPoints()
		p:Hide()
		DCT_aniTexture[DCT_aniTextureFlag] = p
	end
end

function DCT_Ani_TextCreate()
	local i
	for i = 1 ,DCT_ANI_MAX_TEXT do
		DCT_aniText[i] = getglobal("DCT_TEXT"):CreateFontString("DCT_aniText"..i,"ARTWORK")
		DCT_aniText[i]:Hide()
		DCT_aniText[i].isWorking = false
	end
end
--获得一个可用的FontString
function DCT_Ani_TextGet()
	local p = DCT_aniText[DCT_aniTextFlag]
	p:Show()
	p.isWorking = true
	if DCT_aniTextFlag > 1 then DCT_aniTextFlag = DCT_aniTextFlag - 1;end
	return p
end
function DCT_Ani_TextFree(p)
	if p.isWorking then
		DCT_aniTextFlag = DCT_aniTextFlag + 1
		p.isWorking = false
		p:ClearAllPoints()
		p:Hide()
		DCT_aniText[DCT_aniTextFlag] = p
	end
end

function DCT_Ani_CastbarCreate()
	local i
	for i = 1 ,DCT_ANI_MAX_CASTBAR do
		DCT_aniCastbar[i] = CreateFrame("Frame", "DCT_aniCastbar"..i, DCT_TEXT, "DCTCastBarTemplate");
		DCT_aniCastbar[i]:Hide()
		DCT_aniCastbar[i].isWorking = false
	end
end
--获得一个可用的FontString
function DCT_Ani_CastbarGet()
	--if table.getn(DCT_aniCastbar) <
	local p = DCT_aniCastbar[DCT_aniCastbarFlag]
	p:Show()
	p.isWorking = true
	if DCT_aniCastbarFlag > 1 then DCT_aniCastbarFlag = DCT_aniCastbarFlag - 1;end
	return p
end
function DCT_Ani_CastbarFree(p)
	if p.isWorking then
		DCT_aniCastbarFlag = DCT_aniCastbarFlag + 1
		p.isWorking = false
		p:ClearAllPoints()
		p:Hide()
		DCT_aniCastbar[DCT_aniCastbarFlag] = p
	end
end

--这里创建的FontString没有实际作用,只是用来给DCT_aniText;里的FontString作依附用
function DCT_Ani_ObjCreate()
	local i
	for i = 1 ,DCT_ANI_MAX_OBJECT do
		--atTypeArr  1:en 2:ch
		DCT_Ani_Object[i] = {atP = {},atTypeArr = {},anchor = 1}
		DCT_Ani_Object[i].ad = getglobal("DCT_TEXT"):CreateFontString("OBJECT"..i,"ARTWORK")
		DCT_Ani_Object[i].ad:SetPoint("CENTER", "UIParent", "CENTER", 0 ,0 );
		DCT_Ani_Object[i].ad:Hide()
		DCT_Ani_Object[i].isWorking = false
	end
end

function DCT_Ani_ObjSetExtraTextFont(obj,isEn)
	if isEn then
		obj.extraTextP:SetFont(DCT_Font[obj.fontEn].path, obj.fontSizeEn,DCT_FONT_EFFECT[obj.fEff][1])
	else
		obj.extraTextP:SetFont(DCT_Font[obj.fontCh].path, obj.fontSizeCh,DCT_FONT_EFFECT[obj.fEff][1])
	end
	obj.extraTextP:SetShadowOffset(DCT_FONT_EFFECT[obj.fEff][2],-DCT_FONT_EFFECT[obj.fEff][2])
end
function DCT_Ani_ObjAddExtraText(obj)
	if not obj.extraTextP then
		obj.extraTextP = DCT_Ani_TextGet()
		DCT_Ani_ObjSetExtraTextFont(obj,true)
		obj.extraTextP:SetText("")
		obj.extraTextP:SetPoint("LEFT",obj.atP[obj.atPC],"RIGHT",2,0)
	end
end

function DCT_Ani_ObjAddCastbar(obj)
	if not obj.castbarP then
		obj.castbarP = DCT_Ani_CastbarGet()
		obj.castbarP.maxW = DCT_Player["DCT_CastBarWidth"]
		obj.castbarP:SetWidth(obj.castbarP.maxW)
		obj.castbarP:SetHeight(obj.fontSizeMax - 4)
		obj.castbarP:SetPoint("LEFT",obj.atP[obj.atPC],"RIGHT",2,-1)
	end
end

function DCT_Ani_ObjReset(obj)
	obj.active = false
	obj.atPC = 0
	obj.atP = {}
	obj.x = 0
	obj.y = 0
	obj.funcOther = nil
	obj.extraTextP = nil
end

--从屏幕上删除
function DCT_Ani_ObjClear(obj)
	local c = table.getn(obj.atP)
	obj.active = false
	obj.x = -4000
	obj.y = -4000
	obj.uid = 0
	obj.funcOther = nil
	if obj.extraTextP then
		DCT_Ani_TextFree(obj.extraTextP)
		obj.extraTextP = nil
	end
	if obj.castbarP then
		DCT_Ani_CastbarFree(obj.castbarP)
		obj.castbarP = nil
	end
	local p
	while c > 0 do
		p = obj.atP[c]
		if p.isTexture then
			DCT_Ani_TextureFree(p)
		else
			DCT_Ani_TextFree(p)
		end
		table.remove(obj.atP,c)
		c = c - 1
	end
	obj.atPC = 0
	DCT_Ani_ObjPos(obj,obj.x,obj.y)

	DCT_Ani_ObjFree(obj)
end

function DCT_Ani_ObjFree(p)
	if p.isWorking then
		DCT_objFlag = DCT_objFlag + 1
		p.ad:Hide()
		p.isWorking = false
		DCT_Ani_Object[DCT_objFlag] = p
	end
end

function DCT_Ani_ObjGet()
	DCT_UID = DCT_UID + 1

	local p = DCT_Ani_Object[DCT_objFlag]

	if p.active or (p.atPC and p.atPC > 0) then
		DCT_Ani_ObjClear(p)
	end

	--p.ad:Show()
	p.isWorking = true
	p.uid = DCT_UID

	DCT_Ani_ObjReset(p)
	if DCT_objFlag > 1 then DCT_objFlag = DCT_objFlag - 1;end
	return p
end

--放大的同时也会设置字体，字体大小及阴影偏移
function DCT_Ani_ObjScale(obj,scale)
	local i
	local w = 0
	for i = 1,obj.atPC do
		if obj.atTypeArr[i] == 1 then
			obj.atP[i]:SetTextHeight(scale * obj.fontSizeEn)
		elseif obj.atTypeArr[i] == 2 then
			obj.atP[i]:SetTextHeight(scale * obj.fontSizeCh)
		elseif obj.atTypeArr[i] == 3 then
			obj.atP[i]:SetHeight(scale * obj.fontSizeMax)
			obj.atP[i]:SetWidth(scale * obj.fontSizeMax)
		end
		w = w + obj.atP[i]:GetWidth()
	end

	--重新刷新坐标
	if obj.atPC > 1 then
		if obj.anchor == 1 then
			w = -w / 2
		elseif obj.anchor == 2 then
			w = 0
		else
			w = -w
		end
		for i = 1,obj.atPC do
			if obj.anchor == 1 then
				w = w + obj.atP[i]:GetWidth()
				obj.atP[i]:SetPoint("CENTER", obj.ad, "CENTER", w - obj.atP[i]:GetWidth() / 2, 0)
			elseif obj.anchor == 2 then
				obj.atP[i]:SetPoint("LEFT", obj.ad, "CENTER", w, 0)
				w = w + obj.atP[i]:GetWidth()
			else
				w = w + obj.atP[i]:GetWidth()
				obj.atP[i]:SetPoint("RIGHT", obj.ad, "CENTER", w, 0)
			end
		end
	end
	if obj.castbarP then
		obj.castbarP:SetWidth(obj.castbarP.maxW * scale)
		obj.castbarP:SetHeight((obj.fontSizeMax - 4) * scale)
	end
	if obj.extraTextP then
		obj.extraTextP:SetTextHeight(scale * obj.fontSizeMax)
	end
end


function DCT_Ani_ObjAlpha(obj,a)
	local i
	if obj.atPC > 0 then
		for i = 1,obj.atPC do
			obj.atP[i]:SetAlpha(a)
			if obj.extraTextP then obj.extraTextP:SetAlpha(a);end
			if obj.castbarP then obj.castbarP:SetAlpha(a);end
		end
	end
end

function DCT_Ani_ObjPos(obj,x,y)
	local i
	obj.ad:SetPoint("CENTER", "UIParent", "CENTER", x, y)
end



--为Obj设置文字，如果FrameString不够用会自动申请
function DCT_Ani_ObjSetText(obj,txt,fontEn,fontCh,fontSizeEn,fontSizeCh,fontEffect,color,anchor)
	if not txt then return;end
	if anchor then obj.anchor = anchor;end

	local atCount = obj.atPC
	obj.atPC = 0

	if not DCT_Font[fontEn].active then fontEn = 1;end
	if not DCT_Font[fontCh].active then fontCh = 1;end

	if fontSizeEn > fontSizeCh then
		obj.fontSizeMax = fontSizeEn
	else
		obj.fontSizeMax = fontSizeCh
	end

	local tmpTexureList = {}
	local tmpTextureC = 0
	local tmpTextureN = 0
	--先查找当前obj里有没有图标
	if atCount > 0 then
		local i = 1
		while i <= atCount do
			if obj.atP[i].isTexture then
				tmpTextureC = tmpTextureC + 1
				table.insert(tmpTexureList,obj.atP[i])
				obj.atP[i]:Hide()
				table.remove(obj.atP,i)
				atCount = table.getn(obj.atP)
			else
				i = i + 1
			end
		end
	end

	if false--[[fontEn == fontCh and fontSizeEn == fontSizeCh]] then
		--[[obj.atP[1] = DCT_Ani_TextGet()
		obj.atP[1]:SetFont(DCT_Font[fontEn].path, fontSizeEn,DCT_FONT_EFFECT[fontEffect][1])
		obj.atP[1]:SetText(txt)
		obj.atP[1]:SetPoint("CENTER", obj.ad, "CENTER", 0,0)
		obj.atP[1]:SetShadowOffset(DCT_FONT_EFFECT[fontEffect][2],-DCT_FONT_EFFECT[fontEffect][2])
		if color then
			obj.atP[1]:SetTextColor(color[1], color[2], color[3])
		end
		obj.atTypeArr[1] = 2
		obj.atPC = 1	]]
	else
		local s = 0
		local e = 0
		local i = 0
		local c = string.len(txt)
		local t = 0--0:none 1:en 2:ch
		local b
		local w = 0
		local colorStr
		local incolor = false
		local splitString = nil
		local step = 1
		while i + step <= c do
			i = i + step
			b = string.byte(txt,i)
			if b >= 128 then
				step = 3
			else
				step = 1
			end
			if b == 124 then--124 == '|'
				if i < c then
					if string.byte(txt,i + 1) == 99 then--99: 'c'
						if s == 0 then s = i;end
						colorStr = string.sub(txt,i,i + 9)
						i = i + 9
						incolor = true
					else
						i = i + 1
						incolor = false
					end
				end
			else
				if s == 0 then s = i;end
				if b ~= 32 then
					if b < 128--[[(b >= 48 and b <= 57) or b == 43 or b == 45]] then
						if t == 0 then t = 1;end
						if t == 2 then
							e = i - 1
						end
					else
						if t == 0 then t = 2;end
						if t == 1 then
							e = i - 1
						end
					end
				end

				--如果遇到icon则先结束当前的文字
				if b == 35 then
					if i < c - 1 and string.sub(txt,i + 1,i + 2) == "ic" then
						if dct_icon then
							e = i - 1
						end
					end
				end
			end
			if i == c or (b >= 128 and i >= c - 2) then
				if e == 0 and t ~= 0 then e = c;end
			end
			while e ~= 0 do
				obj.atPC = obj.atPC + 1
				if obj.atPC > atCount then
					obj.atP[obj.atPC] = DCT_Ani_TextGet()
					atCount = atCount + 1
				else
					obj.atP[obj.atPC]:Show()
				end


				obj.atTypeArr[obj.atPC] = t

				if obj.atTypeArr[obj.atPC] == 1 then
					obj.atP[obj.atPC]:SetFont(DCT_Font[fontEn].path, fontSizeEn,DCT_FONT_EFFECT[fontEffect][1])
				elseif obj.atTypeArr[obj.atPC] == 2 then
					obj.atP[obj.atPC]:SetFont(DCT_Font[fontCh].path, fontSizeCh,DCT_FONT_EFFECT[fontEffect][1])
				end
				obj.atP[obj.atPC]:SetShadowOffset(DCT_FONT_EFFECT[fontEffect][2],-DCT_FONT_EFFECT[fontEffect][2])

				if splitString then
					splitString = splitString..string.sub(txt,s,e)
				else
					splitString = string.sub(txt,s,e)
				end
				if incolor then splitString = splitString.."|r";end

				obj.atP[obj.atPC]:SetText(splitString)
				if t == 1 then t = 2;else t = 1;end


				w = w + obj.atP[obj.atPC]:GetWidth()
				s = i
				if incolor then
					splitString = colorStr
				else
					splitString = nil
				end

				if i == c or (b >= 128 and i >= c - 2) then
					if e < i then
						e = c
					else
						e = 0
					end
				else
					e = 0
				end
			end
			--如果遇到icon
			if b == 35 then
				if i < c - 1 and string.sub(txt,i + 1,i + 2) == "ic" then
					if dct_icon then
						local tx
						if tmpTextureN < tmpTextureC then
							tmpTextureN = tmpTextureN + 1
							tx = tmpTexureList[tmpTextureN]
							tx:Show()
							tx:ClearAllPoints()
							tx:SetAlpha(1)
						else
							tx = DCT_Ani_TextureGet()
						end
						tx:SetTexCoord(.1,.9,.1,.9)
						tx:SetHeight(obj.fontSizeMax)
						tx:SetWidth(obj.fontSizeMax)
						if type(dct_icon) == "string" then
							tx:SetTexture(dct_icon)
						else
							local t = select(3, GetSpellInfo(dct_icon))
							if t then
								tx:SetTexture(t)
							end
						end

						obj.atPC = obj.atPC + 1
						if obj.atP[obj.atPC] then
							table.insert(obj.atP,obj.atPC,tx)
						else
							obj.atP[obj.atPC] = tx
						end
						atCount = table.getn(obj.atP)
						obj.atTypeArr[obj.atPC] = 3
						w = w + obj.fontSizeMax

						t = 0
						step = 0
						i = i + 3
						s = i
					end
				end
			end
		end
		if obj.anchor == 1 then
			w = -w / 2
		elseif obj.anchor == 2 then
			w = 0
		else
			w = -w
		end
		for i = 1,obj.atPC do
			if obj.anchor == 1 then
				w = w + obj.atP[i]:GetWidth()
				obj.atP[i]:SetPoint("CENTER", obj.ad, "CENTER", w - obj.atP[i]:GetWidth() / 2, 0)
			elseif obj.anchor == 2 then
				obj.atP[i]:SetPoint("LEFT", obj.ad, "CENTER", w, 0)
				w = w + obj.atP[i]:GetWidth()
			else
				w = w + obj.atP[i]:GetWidth()
				obj.atP[i]:SetPoint("RIGHT", obj.ad, "CENTER", w, 0)
			end
			if color and obj.atTypeArr[i] < 3 then
				obj.atP[i]:SetTextColor(color[1], color[2], color[3])
			end
		end
	end
	if obj.atPC < atCount then
		local i;
		for i = obj.atPC + 1,atCount do
			obj.atP[i]:Hide()
		end
	end
	--如果指定的字体不可用
	obj.fontSizeEn = fontSizeEn
	obj.fontSizeCh = fontSizeCh
	obj.fontEn = fontEn
	obj.fontCh = fontCh
	obj.fEff = fontEffect
end

local DCT_eboxBuffer = {}
local DCT_eboxC = 0
local DCT_eboxLock = false

function DCT_EBox_AddEvent(showType,text,crit,saveP,icon,delay)
	if not text then return;end
	local ctime = GetTime()
	local i = DCT_eboxC
	DCT_UID = DCT_UID + 1
	while i > 0 and DCT_eboxBuffer[i].dl - ctime + DCT_eboxBuffer[i].st > delay do
		i = i - 1
	end
	local p
	if i == DCT_eboxC then
		table.insert(DCT_eboxBuffer,{dl = delay,st = ctime,cr = crit,sp = saveP,ty = showType,tx = text,ic = icon,uid = DCT_UID})
		p = DCT_eboxBuffer[DCT_eboxC]
		DCT_eboxC = DCT_eboxC + 1
	else
		table.insert(DCT_eboxBuffer,i + 1,{dl = delay,st = ctime,cr = crit,sp = saveP,ty = showType,tx = text,ic = icon,uid = DCT_UID})
		p = DCT_eboxBuffer[i + 1]
		DCT_eboxC = DCT_eboxC + 1
	end

	return (i + 1),DCT_UID
end

function DCT_EBox_UpdataEvent()
	--return;
	if DCT_eboxC == 0 then return;end

	if DCT_eboxLock then return;end
	if (DCT_eboxBuffer[DCT_eboxC].dl - GetTime() + DCT_eboxBuffer[DCT_eboxC].st) <= 0 then
		local p = DCT_eboxBuffer[DCT_eboxC]
		dct_icon = p.ic
		DCT_AddTextNoFormat(p.ty,p.tx,p.cr,p.sp)

		table.remove(DCT_eboxBuffer,DCT_eboxC)
		DCT_eboxC = DCT_eboxC - 1
	end
end

--调用此函数前必须先锁定
function DCT_EBox_GetEventP(id,uid)
	if not DCT_eboxLock then return nil;end
	if id > DCT_eboxC then return nil;end
	if uid ~= DCT_eboxBuffer[id].uid then return nil;end
	return DCT_eboxBuffer[id]
end

function DCT_EBox_Lock()
	DCT_eboxLock = true
end

function DCT_Ebox_UnLock()
	DCT_eboxLock = false
end
