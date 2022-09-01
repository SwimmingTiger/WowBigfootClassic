--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local next = next;
	local tremove = table.remove;
	local RequestLoadSpellData = C_Spell.RequestLoadSpellData;
	local _G = _G;

-->
	local L = CT.L;

-->		constant
	CT.DefaultSetting = {
		resizable_border = false,
		singleFrame = true,
		style = 1,
		talents_in_tip = false,
		talents_in_tip_icon = true,
		inspectButtonOnUnitFrame = false,
		inspectButtonKey = "ALT",
		show_equipment = true,
		inspect_pack = false,
		max_recv_msg = 16,
		minimap = true,
		minimapPos = 185,
		autoShowEquipmentFrame = true,
	};

-->
MT.BuildEnv('DATA');
-->		predef
-->
-->		DATA

	local function ProcDB()
		-- 1---- 2--- 3-- 4-------- 5------- 6------ 7----- 8-------- 9------- 10--------- 11-------------------- 12
		--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, icon-index, req-index[] in TreeTDB, { req-by-index } in TreeTDB
		for class, ClassTDB in next, DT.TalentDB do
			for _, TreeTDB in next, ClassTDB do
				for dbIndex, def in next, TreeTDB do
					def[10] = def[1] * DT.MAX_NUM_COL + def[2] + 1;
					if def[5] ~= nil and def[6] ~= nil then
						for pIndex, p in next, TreeTDB do
							if p[1] == def[5] and p[2] == def[6] then
								def[11] = pIndex;
								local dep = p[12];
								if dep ~= nil then
									dep[#dep + 1] = dbIndex;
								else
									p[12] = { dbIndex, };
								end
								break;
							end
						end
						if def[11] == nil then
							MT.Log("DB_PreProc", 1, "req of ", def[1], def[2], def[5], def[6], "missing");
						end
					end
				end
			end
		end
		for class, S in next, DT.SpellDB do
			for _, v in next, S do
				if v.race ~= nil then
					for i = 1, #v do
						v[i].race = v.race;
					end
				end
				for i = #v, 1, -1 do
					if v[i][4] ~= nil and v[i][4] > DT.CUR_PHASE then
						tremove(v, i);
					end
				end
				for i = 1, #v do
					if v[i][1] > 0 then
						VT.TSpellLevelHash[v[i][2]] = v[i][1];
					end
					if #v > 1 then
						v[i][5] = i;
					end
					if v.passive then
						v[i][6] = true;
					end
				end
				if v.talent then
					local rid = v.require or v[1][2];
					local ClassTDB = DT.TalentDB[class];
					local SpecList = DT.ClassSpec[class];
					for TreeIndex = 1, 3 do
						local spec = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[spec];
						if v.requireIndex ~= nil then
							break;
						end
						for dbIndex, def in next, TreeTDB do
							if def[8][1] == rid then
								v.requireSpecIndex = TreeIndex;
								v.requireIndex = dbIndex;
								break;
							end
						end
					end
				end
			end
		end
	end
	local function PreLoad()	--	unnecessary
		for class, ClassTDB in next, DT.TalentDB do
			for _, TreeTDB in next, ClassTDB do
				for dbIndex, def in next, TreeTDB do
					for i = 1, #def[8] do
						RequestLoadSpellData(def[8][i]);
					end
				end
			end
		end
		--
		for class, S in next, DT.SpellDB do
			for _, v in next, S do
				for i = 1, #v do
					RequestLoadSpellData(v[i][2]);
				end
			end
		end
	end
	MT.RegisterOnInit('DATA', function(LoggedIn)
		DT.MAX_NUM_ICONS_PER_SPEC = DT.MAX_NUM_TIER * DT.MAX_NUM_COL;
		ProcDB();
	end);
	MT.RegisterOnLogin('DATA', function(LoggedIn)
		PreLoad();
	end);

-->
