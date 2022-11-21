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
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('DATA');
-->		predef
-->
-->		DATA

	local function ProcDB()
		-- 1---- 2--- 3-- 4-------- 5------- 6------ 7----- 8-------- 9------- 10--------- 11-------------------- 12
		--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, icon-index, req-index[] in TreeTDB, { req-by-index } in TreeTDB
		for class, ClassTDB in next, DT.TalentDB do
			for SpecID, TreeTDB in next, ClassTDB do
				for TalentSeq = 1, #TreeTDB do
					local TalentDef = TreeTDB[TalentSeq];
					TalentDef[10] = TalentDef[1] * DT.MAX_NUM_COL + TalentDef[2] + 1;
					if TalentDef[5] ~= nil and TalentDef[6] ~= nil then
						for Seq, Def in next, TreeTDB do
							if Def[1] == TalentDef[5] and Def[2] == TalentDef[6] then
								TalentDef[11] = Seq;
								local depby = Def[12];
								if depby ~= nil then
									depby[#depby + 1] = TalentSeq;
								else
									Def[12] = { TalentSeq, };
								end
								break;
							end
						end
						if TalentDef[11] == nil then
							MT.Debug("Data.OnInit.ProcDB", 1, "req of ", TalentDef[1], TalentDef[2], TalentDef[5], TalentDef[6], "missing");
						end
					end
				end
			end
		end
		for class, ClassSDB in next, DT.SpellDB do
			for index = 1, #ClassSDB do
				local SpellDef = ClassSDB[index];
				local NumLevel = #SpellDef;
				if SpellDef.race ~= nil then
					for Level = 1, NumLevel do
						SpellDef[Level].race = SpellDef.race;
					end
				end
				for Level = NumLevel, 1, -1 do
					if SpellDef[Level][4] ~= nil and SpellDef[Level][4] > DT.CUR_PHASE then
						tremove(SpellDef, Level);
					end
				end
				for Level = 1, NumLevel do
					if SpellDef[Level][1] > 0 then
						VT.TSpellLevelHash[SpellDef[Level][2]] = SpellDef[Level][1];
					end
					if NumLevel > 1 then
						SpellDef[Level][5] = Level;
					end
					if SpellDef.passive then
						SpellDef[Level][6] = true;
					end
				end
				if SpellDef.talent then
					local rid = SpellDef.require or SpellDef[1][2];
					local ClassTDB = DT.TalentDB[class];
					local SpecList = DT.ClassSpec[class];
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						if SpellDef.requireIndex ~= nil then
							break;
						end
						for TalentSeq = 1, #TreeTDB do
							local TalentDef = TreeTDB[TalentSeq];
							if TalentDef[8][1] == rid then
								SpellDef.requireSpecIndex = TreeIndex;
								SpellDef.requireIndex = TalentSeq;
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
			for SpecID, TreeTDB in next, ClassTDB do
				for TalentSeq = 1, #TreeTDB do
					local TalentDef = TreeTDB[TalentSeq];
					for Level = 1, TalentDef[4] do
						RequestLoadSpellData(TalentDef[8][Level]);
					end
				end
			end
		end
		--
		for class, ClassSDB in next, DT.SpellDB do
			for index = 1, #ClassSDB do
				local SpellDef = ClassSDB[index];
				for Level = 1, #SpellDef do
					RequestLoadSpellData(SpellDef[Level][2]);
				end
			end
		end
	end
	MT.RegisterOnInit('DATA', function(LoggedIn)
		ProcDB();
	end);
	MT.RegisterOnLogin('DATA', function(LoggedIn)
		PreLoad();
	end);

-->
