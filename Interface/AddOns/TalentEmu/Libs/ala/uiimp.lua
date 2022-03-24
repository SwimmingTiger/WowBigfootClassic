--[[--
	alex/ALA @ 163UI
--]]--
local __version = 5;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

local uireimp = __ala_meta__.uireimp;
if uireimp ~= nil and uireimp.__minor ~= nil and uireimp.__minor >= __version then
	return;
elseif uireimp == nil then
	uireimp = {  };
	__ala_meta__.uireimp = uireimp;
end
uireimp.__minor = __version;

local CopyTable = CopyTable;
local defaultEdgeSize = 39;		-- the old default

function uireimp._SetSimpleBackdrop(_F, inset, edgeSize, dr, dg, db, da, rr, rg, rb, ra)	--	inset > 0 : inner	--	inset < 0 : outter
	_F.__backdrop = nil;
	local ofs = edgeSize + inset;
	--
	local Center = _F.__Center or _F:CreateTexture(nil, "BACKGROUND");
	Center:Show();
	Center:ClearAllPoints();
	Center:SetPoint("BOTTOMLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	Center:SetPoint("TOPRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	Center:SetColorTexture(dr or 0.0, dg or 0.0, db or 0.0, da or 1.0);
	_F.__Center = Center;
	--
	if _F.__BLCorner ~= nil then
		_F.__BLCorner:Hide();
	end
	if _F.__TLCorner ~= nil then
		_F.__TLCorner:Hide();
	end
	if _F.__TRCorner ~= nil then
		_F.__TRCorner:Hide();
	end
	if _F.__BRCorner ~= nil then
		_F.__BRCorner:Hide();
	end
	local LBorder = _F.__LBorder or _F:CreateTexture(nil, "BORDER");
	LBorder:Show();
	local TBorder = _F.__TBorder or _F:CreateTexture(nil, "BORDER");
	TBorder:Show();
	local RBorder = _F.__RBorder or _F:CreateTexture(nil, "BORDER");
	RBorder:Show();
	local BBorder = _F.__BBorder or _F:CreateTexture(nil, "BORDER");
	BBorder:Show();
	rr, rg, rb, ra = rr or 1.0, rg or 1.0, rb or 1.0, ra or 0.5;
	LBorder:SetWidth(edgeSize);
	TBorder:SetHeight(edgeSize);
	RBorder:SetWidth(edgeSize);
	BBorder:SetHeight(edgeSize);
	LBorder:SetColorTexture(rr, rg, rb, ra);
	TBorder:SetColorTexture(rr, rg, rb, ra);
	RBorder:SetColorTexture(rr, rg, rb, ra);
	BBorder:SetColorTexture(rr, rg, rb, ra);
	LBorder:ClearAllPoints();
	LBorder:SetPoint("TOPRIGHT", _F, "TOPLEFT", ofs, -ofs);
	LBorder:SetPoint("BOTTOMRIGHT", _F, "BOTTOMLEFT", ofs, inset);
	TBorder:ClearAllPoints();
	TBorder:SetPoint("BOTTOMRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	TBorder:SetPoint("BOTTOMLEFT", _F, "TOPLEFT", inset, -ofs);
	RBorder:ClearAllPoints();
	RBorder:SetPoint("BOTTOMLEFT", _F, "BOTTOMRIGHT", -ofs, ofs);
	RBorder:SetPoint("TOPLEFT", _F, "TOPRIGHT", -ofs, -inset);
	BBorder:ClearAllPoints();
	BBorder:SetPoint("TOPLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	BBorder:SetPoint("TOPRIGHT", _F, "BOTTOMRIGHT", -inset, ofs);
	_F.__LBorder = LBorder;
	_F.__TBorder = TBorder;
	_F.__RBorder = RBorder;
	_F.__BBorder = BBorder;
end
function uireimp._SetSimpleBackdropCenter(_F, inset, edgeSize, dr, dg, db, da)	--	inset > 0 : inner	--	inset < 0 : outter
	_F.__backdrop = nil;
	local ofs = edgeSize + inset;
	local Center = _F.__Center or _F:CreateTexture(nil, "BACKGROUND");
	Center:Show();
	Center:ClearAllPoints();
	Center:SetPoint("BOTTOMLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	Center:SetPoint("TOPRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	Center:SetColorTexture(dr or 0.0, dg or 0.0, db or 0.0, da or 1.0);
	_F.__Center = Center;
end
function uireimp._SetSimpleBackdropBorder(_F, inset, edgeSize, rr, rg, rb, ra)	--	inset > 0 : inner	--	inset < 0 : outter
	_F.__backdrop = nil;
	local ofs = edgeSize + inset;
	--
	if _F.__BLCorner ~= nil then
		_F.__BLCorner:Hide();
	end
	if _F.__TLCorner ~= nil then
		_F.__TLCorner:Hide();
	end
	if _F.__TRCorner ~= nil then
		_F.__TRCorner:Hide();
	end
	if _F.__BRCorner ~= nil then
		_F.__BRCorner:Hide();
	end
	local LBorder = _F.__LBorder or _F:CreateTexture(nil, "BORDER");
	LBorder:Show();
	local TBorder = _F.__TBorder or _F:CreateTexture(nil, "BORDER");
	TBorder:Show();
	local RBorder = _F.__RBorder or _F:CreateTexture(nil, "BORDER");
	RBorder:Show();
	local BBorder = _F.__BBorder or _F:CreateTexture(nil, "BORDER");
	BBorder:Show();
	rr, rg, rb, ra = rr or 1.0, rg or 1.0, rb or 1.0, ra or 0.5;
	LBorder:SetWidth(edgeSize);
	TBorder:SetHeight(edgeSize);
	RBorder:SetWidth(edgeSize);
	BBorder:SetHeight(edgeSize);
	LBorder:SetColorTexture(rr, rg, rb, ra);
	TBorder:SetColorTexture(rr, rg, rb, ra);
	RBorder:SetColorTexture(rr, rg, rb, ra);
	BBorder:SetColorTexture(rr, rg, rb, ra);
	LBorder:ClearAllPoints();
	LBorder:SetPoint("TOPRIGHT", _F, "TOPLEFT", ofs, -ofs);
	LBorder:SetPoint("BOTTOMRIGHT", _F, "BOTTOMLEFT", ofs, inset);
	TBorder:ClearAllPoints();
	TBorder:SetPoint("BOTTOMRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	TBorder:SetPoint("BOTTOMLEFT", _F, "TOPLEFT", inset, -ofs);
	RBorder:ClearAllPoints();
	RBorder:SetPoint("BOTTOMLEFT", _F, "BOTTOMRIGHT", -ofs, ofs);
	RBorder:SetPoint("TOPLEFT", _F, "TOPRIGHT", -ofs, -inset);
	BBorder:ClearAllPoints();
	BBorder:SetPoint("TOPLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	BBorder:SetPoint("TOPRIGHT", _F, "BOTTOMRIGHT", -inset, ofs);
	_F.__LBorder = LBorder;
	_F.__TBorder = TBorder;
	_F.__RBorder = RBorder;
	_F.__BBorder = BBorder;
end

function uireimp._GetEdgeSize(_F)
	local backdrop = _F.__backdrop;
	if backdrop ~= nil and backdrop.edgeSize ~= nil and backdrop.edgeSize > 0 then
		return backdrop.edgeSize;
	else
		return defaultEdgeSize;
	end
end
function uireimp._SetBorderBlendMode(_F, blendMode)
	if _F.__BLCorner ~= nil then
		_F.__BLCorner:SetBlendMode(blendMode);
	end
	if _F.__TLCorner ~= nil then
		_F.__TLCorner:SetBlendMode(blendMode);
	end
	if _F.__TRCorner ~= nil then
		_F.__TRCorner:SetBlendMode(blendMode);
	end
	if _F.__BRCorner ~= nil then
		_F.__BRCorner:SetBlendMode(blendMode);
	end
	if _F.__LBorder ~= nil then
		_F.__LBorder:SetBlendMode(blendMode);
	end
	if _F.__TBorder ~= nil then
		_F.__TBorder:SetBlendMode(blendMode);
	end
	if _F.__RBorder ~= nil then
		_F.__RBorder:SetBlendMode(blendMode);
	end
	if _F.__BBorder ~= nil then
		_F.__BBorder:SetBlendMode(blendMode);
	end
	if _F.__Center ~= nil then
		_F.__Center:SetBlendMode(blendMode);
	end
end
function uireimp._HasBackdropInfo(_F, backdrop)
	return _F.__backdrop == backdrop;
end
function uireimp._ClearBackdrop(_F)
	_F.__backdrop = nil;
	if _F.__BLCorner ~= nil then
		_F.__BLCorner:Hide();
	end
	if _F.__TLCorner ~= nil then
		_F.__TLCorner:Hide();
	end
	if _F.__TRCorner ~= nil then
		_F.__TRCorner:Hide();
	end
	if _F.__BRCorner ~= nil then
		_F.__BRCorner:Hide();
	end
	if _F.__LBorder ~= nil then
		_F.__LBorder:Hide();
	end
	if _F.__TBorder ~= nil then
		_F.__TBorder:Hide();
	end
	if _F.__RBorder ~= nil then
		_F.__RBorder:Hide();
	end
	if _F.__BBorder ~= nil then
		_F.__BBorder:Hide();
	end
	if _F.__Center ~= nil then
		_F.__Center:Hide();
	end
end
function uireimp._ApplyBackdrop()
	uireimp._SetBackdrop(_F, _F.__backdrop);
end
function uireimp._SetBackdrop(_F, backdrop)
	if backdrop == nil then
		uireimp._ClearBackdrop(_F);
	else
		_F.__backdrop = backdrop;
		local edgeSize = backdrop.edgeSize or defaultEdgeSize;
		--
		local edgeFile = backdrop.edgeFile;
		if edgeFile ~= nil and edgeFile ~= "" then
			local tileEdge = backdrop.tileEdge; if tileEdge == nil then tileEdge = true; end
			local BLCorner = _F.__BLCorner or _F:CreateTexture(nil, "BORDER");
			BLCorner:Show();
			local TLCorner = _F.__TLCorner or _F:CreateTexture(nil, "BORDER");
			TLCorner:Show();
			local TRCorner = _F.__TRCorner or _F:CreateTexture(nil, "BORDER");
			TRCorner:Show();
			local BRCorner = _F.__BRCorner or _F:CreateTexture(nil, "BORDER");
			BRCorner:Show();
			local LBorder = _F.__LBorder or _F:CreateTexture(nil, "BORDER");
			LBorder:Show();
			local TBorder = _F.__TBorder or _F:CreateTexture(nil, "BORDER");
			TBorder:Show();
			local RBorder = _F.__RBorder or _F:CreateTexture(nil, "BORDER");
			RBorder:Show();
			local BBorder = _F.__BBorder or _F:CreateTexture(nil, "BORDER");
			BBorder:Show();
			BLCorner:SetSize(edgeSize, edgeSize);
			TLCorner:SetSize(edgeSize, edgeSize);
			TRCorner:SetSize(edgeSize, edgeSize);
			BRCorner:SetSize(edgeSize, edgeSize);
			LBorder:SetWidth(edgeSize);
			TBorder:SetHeight(edgeSize);
			RBorder:SetWidth(edgeSize);
			BBorder:SetHeight(edgeSize);
			BLCorner:ClearAllPoints();
			BLCorner:SetPoint("BOTTOMLEFT", 0, 0);
			TLCorner:SetPoint("TOPLEFT", 0, 0);
			TRCorner:ClearAllPoints();
			TRCorner:SetPoint("TOPRIGHT", 0, 0);
			BRCorner:SetPoint("BOTTOMRIGHT", 0, 0);
			LBorder:ClearAllPoints();
			LBorder:SetPoint("BOTTOMLEFT", BLCorner, "TOPLEFT", 0, 0);
			LBorder:SetPoint("TOPRIGHT", TLCorner, "BOTTOMRIGHT", 0, 0);
			TBorder:ClearAllPoints();
			TBorder:SetPoint("BOTTOMLEFT", TLCorner, "BOTTOMRIGHT", 0, 0);
			TBorder:SetPoint("TOPRIGHT", TRCorner, "TOPLEFT", 0, 0);
			RBorder:ClearAllPoints();
			RBorder:SetPoint("TOPLEFT", TRCorner, "BOTTOMLEFT", 0, 0);
			RBorder:SetPoint("BOTTOMRIGHT", BRCorner, "TOPRIGHT", 0, 0);
			BBorder:ClearAllPoints();
			BBorder:SetPoint("BOTTOMLEFT", BLCorner, "BOTTOMRIGHT", 0, 0);
			BBorder:SetPoint("TOPRIGHT", BRCorner, "TOPLEFT", 0, 0);
			BLCorner:SetTexture(edgeFile, tileEdge, tileEdge);
			BLCorner:SetTexCoord(97 / 128, 2 / 32, 97 / 128, 30 / 32, 111 / 128, 2 / 32, 111 / 128, 30 / 32);
			BLCorner:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			TLCorner:SetTexture(edgeFile, tileEdge, tileEdge);
			TLCorner:SetTexCoord(65 / 128, 2 / 32, 65 / 128, 30 / 32, 79 / 128, 2 / 32, 79 / 128, 30 / 32);
			TLCorner:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			TRCorner:SetTexture(edgeFile, tileEdge, tileEdge);
			TRCorner:SetTexCoord(81 / 128, 2 / 32, 81 / 128, 30 / 32, 95 / 128, 2 / 32, 95 / 128, 30 / 32);
			TRCorner:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			BRCorner:SetTexture(edgeFile, tileEdge, tileEdge);
			BRCorner:SetTexCoord(113 / 128, 2 / 32, 113 / 128, 30 / 32, 127 / 128, 2 / 32, 127 / 128, 30 / 32);
			BRCorner:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			LBorder:SetTexture(edgeFile, tileEdge, tileEdge);
			LBorder:SetTexCoord(1 / 128, 2 / 32, 1 / 128, 32 / 32, 15 / 128, 2 / 32, 15 / 128, 32 / 32);
			LBorder:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			TBorder:SetTexture(edgeFile, tileEdge, tileEdge);
			TBorder:SetTexCoord(33 / 128, 32 / 32, 47 / 128, 32 / 32, 33 / 128, 2 / 32, 47 / 128, 2 / 32);
			TBorder:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			RBorder:SetTexture(edgeFile, tileEdge, tileEdge);
			RBorder:SetTexCoord(17 / 128, 2 / 32, 17 / 128, 32 / 32, 31 / 128, 2 / 32, 31 / 128, 32 / 32);
			RBorder:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			BBorder:SetTexture(edgeFile, tileEdge, tileEdge);
			BBorder:SetTexCoord(49 / 128, 32 / 32, 63 / 128, 32 / 32, 49 / 128, 2 / 32, 63 / 128, 2 / 32);
			BBorder:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			_F.__BLCorner = BLCorner;
			_F.__TLCorner = TLCorner;
			_F.__TRCorner = TRCorner;
			_F.__BRCorner = BRCorner;
			_F.__LBorder = LBorder;
			_F.__TBorder = TBorder;
			_F.__RBorder = RBorder;
			_F.__BBorder = BBorder;
		else
			if _F.__BLCorner ~= nil then
				_F.__BLCorner:Hide();
			end
			if _F.__TLCorner ~= nil then
				_F.__TLCorner:Hide();
			end
			if _F.__TRCorner ~= nil then
				_F.__TRCorner:Hide();
			end
			if _F.__BRCorner ~= nil then
				_F.__BRCorner:Hide();
			end
			if _F.__LBorder ~= nil then
				_F.__LBorder:Hide();
			end
			if _F.__TBorder ~= nil then
				_F.__TBorder:Hide();
			end
			if _F.__RBorder ~= nil then
				_F.__RBorder:Hide();
			end
			if _F.__BBorder ~= nil then
				_F.__BBorder:Hide();
			end
		end
		--
		local bgFile = backdrop.bgFile;
		if bgFile ~= nil and bgFile ~= "" then
			local tile = backdrop.tile; if tile == nil then tile = true; end
			local Center = _F.__Center or _F:CreateTexture(nil, "BACKGROUND");
			Center:Show();
			Center:ClearAllPoints();
			local insets = backdrop.insets;
			if insets ~= nil then
				Center:SetPoint("BOTTOMLEFT", insets.left or 0, insets.bottom or 0);
				Center:SetPoint("TOPRIGHT", -insets.right or 0, -insets.top or 0);
			else
				Center:SetPoint("BOTTOMLEFT", 0, 0);
				Center:SetPoint("TOPRIGHT", 0, 0);
			end
			Center:SetTexture(bgFile, tile, tile);
			Center:SetVertexColor(1.0, 1.0, 1.0, 1.0);
			_F.__Center = Center;
		elseif _F.__Center ~= nil then
			_F.__Center:Hide();
		end
	end
end
function uireimp._GetBackdrop(_F)
	if _F.__backdrop ~= nil then
		local backdropInfo = CopyTable(_F.__backdrop);
		-- fill in defaults
		if not backdropInfo.bgFile then
			backdropInfo.bgFile = "";
		end
		if not backdropInfo.edgeFile then
			backdropInfo.edgeFile = "";
		end
		if backdropInfo.tile == nil then
			backdropInfo.tile = false;
		end
		if backdropInfo.tileSize == nil then
			backdropInfo.tileSize = 0;
		end
		if backdropInfo.tileEdge == nil then
			backdropInfo.tileEdge = true;
		end
		if not backdropInfo.edgeSize then
			backdropInfo.edgeSize = uireimp._GetEdgeSize(_F);
		end
		if not backdropInfo.insets then
			backdropInfo.insets = { left = 0, right = 0, top = 0, bottom = 0, };
		else
			if not backdropInfo.insets.left then
				backdropInfo.insets.left = 0;
			end
			if not backdropInfo.insets.right then
				backdropInfo.insets.right = 0;
			end
			if not backdropInfo.insets.top then
				backdropInfo.insets.top = 0;
			end
			if not backdropInfo.insets.bottom then
				backdropInfo.insets.bottom = 0;
			end
		end
		return backdropInfo;
	end
	return nil;
end
function uireimp._SetBackdropColor(_F, r, g, b, a)
	if _F.__Center ~= nil then
		_F.__Center:SetVertexColor(r, g, b, a);
	end
end
function uireimp._GetBackdropColor(_F)
	if _F.__backdrop ~= nil then
		if _F.__BLCorner ~= nil then
			return _F.__Center:GetVertexColor();
		end
	end
end
function uireimp._SetBackdropBorderColor(_F, r, g, b, a)
	if _F.__BLCorner ~= nil then
		_F.__BLCorner:SetVertexColor(r, g, b, a);
	end
	if _F.__TLCorner ~= nil then
		_F.__TLCorner:SetVertexColor(r, g, b, a);
	end
	if _F.__TRCorner ~= nil then
		_F.__TRCorner:SetVertexColor(r, g, b, a);
	end
	if _F.__BRCorner ~= nil then
		_F.__BRCorner:SetVertexColor(r, g, b, a);
	end
	if _F.__LBorder ~= nil then
		_F.__LBorder:SetVertexColor(r, g, b, a);
	end
	if _F.__TBorder ~= nil then
		_F.__TBorder:SetVertexColor(r, g, b, a);
	end
	if _F.__RBorder ~= nil then
		_F.__RBorder:SetVertexColor(r, g, b, a);
	end
	if _F.__BBorder ~= nil then
		_F.__BBorder:SetVertexColor(r, g, b, a);
	end
end
function uireimp._GetBackdropBorderColor(_F)
	if _F.__backdrop ~= nil then
		if _F.__BLCorner ~= nil then
			return _F.__BLCorner:GetVertexColor();
		end
	end
end
