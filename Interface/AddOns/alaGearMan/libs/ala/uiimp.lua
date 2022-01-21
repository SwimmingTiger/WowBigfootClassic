--[[--
	alex/ALA @ 163UI
--]]--
local __version = 3;

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
local uiimp = __ala_meta__.uiimp;
if uiimp ~= nil and uiimp.__minor ~= nil and uiimp.__minor >= __version then
	return;
elseif uiimp == nil then
	uiimp = {  };
	__ala_meta__.uiimp = uiimp;
end
uiimp.__minor = __version;

function __ala_meta__._SetBackdrop(_F, inset, dr, dg, db, da, width, rr, rg, rb, ra)	--	inset > 0 : inner	--	inset < 0 : outter
	local ofs = width + inset;
	local Backdrop = _F.__Backdrop or _F:CreateTexture(nil, "BACKGROUND");
	Backdrop:SetPoint("BOTTOMLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	Backdrop:SetPoint("TOPRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	Backdrop:SetColorTexture(dr or 0.0, dg or 0.0, db or 0.0, da or 1.0);
	local LBorder = _F.__LBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local TBorder = _F.__TBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local RBorder = _F.__RBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local BBorder = _F.__BBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	if width ~= nil then
		rr, rg, rb, ra = rr or 1.0, rg or 1.0, rb or 1.0, ra or 0.5;
		LBorder:SetWidth(width);
		TBorder:SetHeight(width);
		RBorder:SetWidth(width);
		BBorder:SetHeight(width);
		LBorder:SetColorTexture(rr, rg, rb, ra);
		TBorder:SetColorTexture(rr, rg, rb, ra);
		RBorder:SetColorTexture(rr, rg, rb, ra);
		BBorder:SetColorTexture(rr, rg, rb, ra);
		LBorder:SetPoint("TOPRIGHT", _F, "TOPLEFT", ofs, -ofs);
		LBorder:SetPoint("BOTTOMRIGHT", _F, "BOTTOMLEFT", ofs, inset);
		TBorder:SetPoint("BOTTOMRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
		TBorder:SetPoint("BOTTOMLEFT", _F, "TOPLEFT", inset, -ofs);
		RBorder:SetPoint("BOTTOMLEFT", _F, "BOTTOMRIGHT", -ofs, ofs);
		RBorder:SetPoint("TOPLEFT", _F, "TOPRIGHT", -ofs, -inset);
		BBorder:SetPoint("TOPLEFT", _F, "BOTTOMLEFT", ofs, ofs);
		BBorder:SetPoint("TOPRIGHT", _F, "BOTTOMRIGHT", -inset, ofs);
	end
	_F.__Backdrop = Backdrop;
	_F.__LBorder = LBorder;
	_F.__TBorder = TBorder;
	_F.__RBorder = RBorder;
	_F.__BBorder = BBorder;
end
function __ala_meta__._SetBackdropColor(_F, inset, dr, dg, db, da, width, rr, rg, rb, ra)	--	inset > 0 : inner	--	inset < 0 : outter
	local ofs = width + inset;
	local Backdrop = _F.__Backdrop or _F:CreateTexture(nil, "BACKGROUND");
	Backdrop:SetPoint("BOTTOMLEFT", _F, "BOTTOMLEFT", ofs, ofs);
	Backdrop:SetPoint("TOPRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
	Backdrop:SetColorTexture(dr or 0.0, dg or 0.0, db or 0.0, da or 1.0);
	_F.__Backdrop = Backdrop;
end
function __ala_meta__._SetBackdropBorderColor(_F, inset, dr, dg, db, da, width, rr, rg, rb, ra)	--	inset > 0 : inner	--	inset < 0 : outter
	local ofs = width + inset;
	local LBorder = _F.__LBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local TBorder = _F.__TBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local RBorder = _F.__RBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	local BBorder = _F.__BBorder or _F:CreateTexture(nil, "BACKGROUND", nil, 1);
	if width ~= nil then
		rr, rg, rb, ra = rr or 1.0, rg or 1.0, rb or 1.0, ra or 0.5;
		LBorder:SetWidth(width);
		TBorder:SetHeight(width);
		RBorder:SetWidth(width);
		BBorder:SetHeight(width);
		LBorder:SetColorTexture(rr, rg, rb, ra);
		TBorder:SetColorTexture(rr, rg, rb, ra);
		RBorder:SetColorTexture(rr, rg, rb, ra);
		BBorder:SetColorTexture(rr, rg, rb, ra);
		LBorder:SetPoint("TOPRIGHT", _F, "TOPLEFT", ofs, -ofs);
		LBorder:SetPoint("BOTTOMRIGHT", _F, "BOTTOMLEFT", ofs, inset);
		TBorder:SetPoint("BOTTOMRIGHT", _F, "TOPRIGHT", -ofs, -ofs);
		TBorder:SetPoint("BOTTOMLEFT", _F, "TOPLEFT", inset, -ofs);
		RBorder:SetPoint("BOTTOMLEFT", _F, "BOTTOMRIGHT", -ofs, ofs);
		RBorder:SetPoint("TOPLEFT", _F, "TOPRIGHT", -ofs, -inset);
		BBorder:SetPoint("TOPLEFT", _F, "BOTTOMLEFT", ofs, ofs);
		BBorder:SetPoint("TOPRIGHT", _F, "BOTTOMRIGHT", -inset, ofs);
	end
	_F.__LBorder = LBorder;
	_F.__TBorder = TBorder;
	_F.__RBorder = RBorder;
	_F.__BBorder = BBorder;
end
