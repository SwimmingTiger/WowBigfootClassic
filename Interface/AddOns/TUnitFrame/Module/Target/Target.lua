--[[
	Player.lua
	实例化 模板并装载到TargetFrame上
	为其他子模块提供母模块
	Terry@bf
	2010 - 9 -30
]]
local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

local M = T:GetModule("Target",true) or T:NewModule("Target","AceHook-3.0")
if not M then return end

M.config = {
	self = 23,
	other = 17,
	row = 3,
	rowWidth = 125
}

local __3DPor = T.Templates and T.Templates.ThreeDportrait and T.Templates.ThreeDportrait:new()

local __ClassIcon = T.Templates and T.Templates.ClassIcon and T.Templates.ClassIcon:new()

local config = M.config

function M:Toggle3DPor(flag)
	if flag then
		__3DPor:SetPoint("TOPLEFT", "TargetFrame", "TOPLEFT", 127, -17)
		__3DPor:Enable()
	else
		__3DPor:Disable()
	end
end

function M:ToggleClass(flag)
	if flag then
		__ClassIcon:Enable()
	else
		__ClassIcon:Disable()
	end
end

function M:TargetFrame_UpdateAuraPositions(...)
	local frame,auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX,mirrorAurasVertically = ...
	local size;
	local rowWidth = 0;
	local firstBuffOnRow = 1;
	--重置行数量，避免重复累加
	for i=1, numAuras do
		if ( largeAuraList[i] ) then
			size = config.self
		else
			size = config.other
		end
		if ( i == 1 ) then
			rowWidth = size;
		else
			rowWidth = rowWidth + size + offsetX;
		end
		if ( rowWidth > maxRowWidth ) then
			updateFunc(frame,auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, 0,mirrorAurasVertically);
			rowWidth = size;
			firstBuffOnRow = i;

			if ( frame.auraRows > config.row ) then
				maxRowWidth = config.rowWidth;
			end
		else
			updateFunc(frame,auraName, i, numOppositeAuras, i - 1, size, offsetX, 0,mirrorAurasVertically);
		end
	end
end

function M:OnInitialize()
	assert(__3DPor,"Target 3D template does not exist.")
	__3DPor:Create("Target",TargetFrame,TargetFramePortrait or TargetPortrait)

	assert(__ClassIcon,"Target class icon template does not exist.")
	__ClassIcon:Create(TargetFrame,"target")
	__ClassIcon:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",107,2)

	T:Debug("Target Module Initialized")
end

function M:OnEnable()
	self:SecureHook("TargetFrame_UpdateAuraPositions")
	T:Debug("Target Module Enabled")
end

function M:OnDisable()
	T:Debug("Target Module Disabled")
	self:UnhookAll()
end



-----for classic
-- local LARGE_AURA_SIZE = 23;	--Self auras (Blizzard default is 21)
-- local SMALL_AURA_SIZE = 17;	--Others auras (Blizzard default is 17)
-- local AURA_START_X = 5;
-- local AURA_START_Y = 32;
-- local AURA_OFFSET_Y = 1;
local AURA_ROW_WIDTH = 122;
local TOT_AURA_ROW_WIDTH = 101;
local NUM_TOT_AURA_ROWS = 2;
local largeBuffList = {};
local largeDebuffList = {};
local PLAYER_UNITS = {
	player = true,
	vehicle = true,
	pet = true,
};

local function ShouldAuraBeLarge(caster)
	if not caster then
		return false;
	end
	for token, value in pairs(PLAYER_UNITS) do
		if UnitIsUnit(caster, token) or UnitIsOwnerOrControllerOfUnit(token, caster) then
			return value;
		end
	end
end

function TargetFrame_UpdateAuras (self)
	local frame, frameName;
	local frameIcon, frameCount, frameCooldown;
	local numBuffs = 0;
	local playerIsTarget = UnitIsUnit(PlayerFrame.unit, self.unit);
	local selfName = self:GetName();
	local canAssist = UnitCanAssist("player", self.unit);

	for i = 1, MAX_TARGET_BUFFS do
        local buffName, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _ , spellId, _, _, casterIsPlayer, nameplateShowAll = UnitBuff(self.unit, i, nil);
        if (buffName) then
            frameName = selfName.."Buff"..(i);
            frame = _G[frameName];
            if ( not frame ) then
                if ( not icon ) then
                    break;
                else
                    frame = CreateFrame("Button", frameName, self, "TargetBuffFrameTemplate");
                    frame.unit = self.unit;
                end
            end
            if ( icon and ( not self.maxBuffs or i <= self.maxBuffs ) ) then
                frame:SetID(i);

                -- set the icon
                frameIcon = _G[frameName.."Icon"];
                frameIcon:SetTexture(icon);

                -- set the count
                frameCount = _G[frameName.."Count"];
                if ( count > 1 and self.showAuraCount ) then
                    frameCount:SetText(count);
                    frameCount:Show();
                else
                    frameCount:Hide();
                end

                -- Handle cooldowns
                --frameCooldown = _G[frameName.."Cooldown"];
                --CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                -- Show stealable frame if the target is not the current player and the buff is stealable.
                local frameStealable = _G[frameName.."Stealable"];
                if ( not playerIsTarget and canStealOrPurge ) then
                    frameStealable:Show();
                else
                    frameStealable:Hide();
                end

                -- set the buff to be big if the buff is cast by the player or his pet
				numBuffs = numBuffs + 1;
                largeBuffList[numBuffs] = ShouldAuraBeLarge(caster);

                frame:ClearAllPoints();
                frame:Show();
            else
                frame:Hide();
            end
        else
            break;
        end
	end

	for i = numBuffs + 1, MAX_TARGET_BUFFS do
		local frame = _G[selfName.."Buff"..i];
		if ( frame ) then
			frame:Hide();
		else
			break;
		end
	end

	local color;
	local frameBorder;
	local numDebuffs = 0;

	local frameNum = 1;
	local index = 1;

	local maxDebuffs = self.maxDebuffs or MAX_TARGET_DEBUFFS;
	while ( frameNum <= maxDebuffs and index <= maxDebuffs ) do
	    local debuffName, icon, count, debuffType, duration, expirationTime, caster, _, _, _, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff(self.unit, index, "INCLUDE_NAME_PLATE_ONLY");
		if ( debuffName ) then
			if ( TargetFrame_ShouldShowDebuffs(self.unit, caster, nameplateShowAll, casterIsPlayer) ) then
				frameName = selfName.."Debuff"..frameNum;
				frame = _G[frameName];
				if ( icon ) then
					if ( not frame ) then
						frame = CreateFrame("Button", frameName, self, "TargetDebuffFrameTemplate");
						frame.unit = self.unit;
					end
					frame:SetID(index);

					-- set the icon
					frameIcon = _G[frameName.."Icon"];
					frameIcon:SetTexture(icon);

					-- set the count
					frameCount = _G[frameName.."Count"];
					if ( count > 1 and self.showAuraCount ) then
						frameCount:SetText(count);
						frameCount:Show();
					else
						frameCount:Hide();
					end

					-- Handle cooldowns
					--frameCooldown = _G[frameName.."Cooldown"];
					--CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

					-- set debuff type color
					if ( debuffType ) then
						color = DebuffTypeColor[debuffType];
					else
						color = DebuffTypeColor["none"];
					end
					frameBorder = _G[frameName.."Border"];
					frameBorder:SetVertexColor(color.r, color.g, color.b);

					-- set the debuff to be big if the buff is cast by the player or his pet
					numDebuffs = numDebuffs + 1;
					largeDebuffList[numDebuffs] = ShouldAuraBeLarge(caster);

					frame:ClearAllPoints();
					frame:Show();

					frameNum = frameNum + 1;
				end
			end
		else
			break;
		end
		index = index + 1;
	end

	for i = frameNum, MAX_TARGET_DEBUFFS do
		local frame = _G[selfName.."Debuff"..i];
		if ( frame ) then
			frame:Hide();
		else
			break;
		end
	end

	self.auraRows = 0;

	local mirrorAurasVertically = false;
	if ( self.buffsOnTop ) then
		mirrorAurasVertically = true;
	end
	local haveTargetofTarget;
	if ( self.totFrame ) then
		haveTargetofTarget = self.totFrame:IsShown();
	end
	self.spellbarAnchor = nil;
	local maxRowWidth;
	-- update buff positions
	maxRowWidth = ( haveTargetofTarget and self.TOT_AURA_ROW_WIDTH ) or AURA_ROW_WIDTH;
	TargetFrame_UpdateAuraPositions(self, selfName.."Buff", numBuffs, numDebuffs, largeBuffList, TargetFrame_UpdateBuffAnchor, maxRowWidth, 3, mirrorAurasVertically);
	-- update debuff positions
	maxRowWidth = ( haveTargetofTarget and self.auraRows < NUM_TOT_AURA_ROWS and self.TOT_AURA_ROW_WIDTH ) or AURA_ROW_WIDTH;
	TargetFrame_UpdateAuraPositions(self, selfName.."Debuff", numDebuffs, numBuffs, largeDebuffList, TargetFrame_UpdateDebuffAnchor, maxRowWidth, 3, mirrorAurasVertically);
	-- update the spell bar position
	if ( self.spellbar ) then
		Target_Spellbar_AdjustPosition(self.spellbar);
	end
end
