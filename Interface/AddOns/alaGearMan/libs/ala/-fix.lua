--[[--
	ALA@163UI
--]]--
do return end

local __version = 2;

local _G = _G;
local __ala_meta__ = _G.__ala_meta__;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
if __ala_meta__.__fixminor ~= nil and __ala_meta__.__fixminor >= __version then
	return;
end
__ala_meta__.__fixminor = __version;

if (not select(2, GetAddOnInfo("!!!163ui!!!")) or not IsAddOnLoaded("!!!163ui!!!")) and BackdropTemplateMixin ~= nil then
	local _LT_AllFrameTypes = {
		'FRAME',
			-- 'BROWSER',
			'BUTTON',
				'CHECKBUTTON',
				-- 'ITEMBUTTON',				--	XML defined.
			-- 'CHECKOUT',
			'COLORSELECT',
			'COOLDOWN',
			'EDITBOX',
			-- 'FOGOFWARFRAME',					--	no method Hide for classic
			'GAMETOOLTIP',
			'MESSAGEFRAME',
			-- 'MINIMAP',
			'MODEL',
				'PLAYERMODEL',
					-- 'CINEMATICMODEL',
					'DRESSUPMODEL',
					'TABARDMODEL',
			-- 'MODELSCENE',
			-- 'MODELSCENEACTOR',
			'MOVIEFRAME',
			-- 'OFFSCREENFRAME',
			-- 'POIFARME',
				-- 'ARCHAEOLOGYDIGSITEFRAME',
				-- 'QUESTPOIFRAME',
				-- 'SCENARIOPOIFRAME',
			'SCROLLFRAME',
			'SCROLLINGMESSAGEFRAME',
			'SIMPLEHTML',
			'SLIDER',
			'STATUSBAR',
			-- 'UNITPOSITIONFRAME',
			-- 'WORLDFRAME'
	};
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		for _, _Type in next, {
			'BROWSER',
			'CHECKOUT',
			-- 'FOGOFWARFRAME',
			'CINEMATICMODEL',
			'MODELSCENE',
			'OFFSCREENFRAME',
			'ARCHAEOLOGYDIGSITEFRAME',
			'QUESTPOIFRAME',
			'SCENARIOPOIFRAME',
			'UNITPOSITIONFRAME',
		} do
			_LT_AllFrameTypes[#_LT_AllFrameTypes + 1] = _Type;
		end
	else
		for _, _Type in next, {
			'BROWSER',
			'CHECKOUT',
			-- 'FOGOFWARFRAME',
			'CINEMATICMODEL',
			'MODELSCENE',
			'OFFSCREENFRAME',
			'UNITPOSITIONFRAME',
		} do
			_LT_AllFrameTypes[#_LT_AllFrameTypes + 1] = _Type;
		end
	end
	local _T_coreFrameSample = {  };
	local _T_coreFrameMetaTable = {  };
	for _, _Type in next, _LT_AllFrameTypes do
		local _success, _Frame = pcall(CreateFrame, _Type);
		if _success then
			if _Frame.Hide ~= nil then
				_Frame:Hide();
			end
			local _MetaTable = getmetatable(_Frame);
			if _MetaTable ~= nil and type(_MetaTable) == 'table' then
				_MetaTable = _MetaTable.__index;
				if _MetaTable ~= nil and type(_MetaTable) == 'table' then
					_T_coreFrameSample[_Type] = _Frame;
					_T_coreFrameMetaTable[_MetaTable] = true;
				end
			end
		end
	end
	for _meta, _ in next, _T_coreFrameMetaTable do
		for _name, _func in next, BackdropTemplateMixin do
			_meta[_name] = _meta[_name] or _func;
		end
	end
end
