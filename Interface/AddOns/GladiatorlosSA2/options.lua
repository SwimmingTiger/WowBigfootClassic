local GSA = GladiatorlosSA
local gsadb
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GladiatorlosSA")
local LSM = LibStub("LibSharedMedia-3.0")
local options_created = false -- ***** @

local GSA_OUTPUT = {["MASTER"] = L["Master"],["SFX"] = L["SFX"],["AMBIENCE"] = L["Ambience"],["MUSIC"] = L["Music"],["DIALOG"] = L["Dialog"]}

function GSA:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory("GladiatorlosSA")		--bf@178.com
	InterfaceOptionsFrame_OpenToCategory("GladiatorlosSA")		--bf@178.com
end

function GSA:ShowConfig2() -- ***** @
	if options_created == false then
		self:OnOptionCreate()
	end
	AceConfigDialog:Open("GladiatorlosSA2")
end

function GSA:ChangeProfile()
	gsadb = self.db1.profile
	for k,v in GladiatorlosSA:IterateModules() do
		if type(v.ChangeProfile) == 'function' then
			v:ChangeProfile()
		end
	end
end

function GSA:AddOption(name, keyName)
	return AceConfigDialog:AddToBlizOptions("GladiatorlosSA", name, "GladiatorlosSA", keyName)
end

local function setOption(info, value)
	local name = info[#info]
	gsadb[name] = value
	if value then
		PlaySoundFile("Interface\\Addons\\"..gsadb.path_menu.."\\"..name..".ogg",gsadb.output_menu);
	end
	GSA:CanTalkHere()
end

local function getOption(info)
	local name = info[#info]
	return gsadb[name]
end

local function spellOption(order, spellID, ...)
	local spellname, _, icon = GetSpellInfo(spellID)	
	if (spellname ~= nil) then
		return {
			type = 'toggle',
			name = "\124T" .. icon .. ":24\124t" .. spellname,			
			desc = function ()
				GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
				GameTooltip:SetHyperlink(GetSpellLink(spellID))
				--GameTooltip:SetSpellByID(spellID)
				GameTooltip:Show()
				--print(GetSpellInfo((spellID)))
			end, -- https://i.imgur.com/ChzUb.jpg
			-- why are you reading this disaster, go away this is embarrassing
			descStyle = "custom",
					order = order,
		}
	else
		GSA.log("spell id: " .. spellID .. " is invalid")
		return {
			type = 'toggle',
			name = "Unknown Spell; ID:" .. spellID,	
			order = order,
		}
	end
end


local function listOption(spellList, listType, ...)
	local args = {}
	for k, v in pairs(spellList) do
		local GSA_SpellName = GSA.spellList[listType][v]
		if GSA_SpellName then
			rawset (args, GSA_SpellName, spellOption(k, v))
			GameTooltip:Hide()
		else 
		end
	end
	return args
end

function GSA:MakeCustomOption(key)
	local options = self.options.args.custom.args
	local db = gsadb.custom
	options[key] = {
		type = 'group',
		name = function() return db[key].name end,
		set = function(info, value) local name = info[#info] db[key][name] = value end,
		get = function(info) local name = info[#info] return db[key][name] end,
		order = db[key].order,
		args = {
			name = {
				name = L["name"],
				type = 'input',
				set = function(info, value)
					if db[value] then GSA.log(L["same name already exists"]) return end
					db[value] = db[key]
					db[value].name = value
					db[value].order = #db + 1
					db[value].soundfilepath = "Interface\\AddOns\\GladiatorlosSA2\\Voice_Custom\\"..value..".ogg"
					db[key] = nil
					options[value] = options[key]
					options[key] = nil
					key = value
				end,
				order = 10,
			},
			spellid = {
				name = L["spellid"],
				type = 'input',
				order = 20,
				pattern = "%d+$",
			},
			remove = {
				type = 'execute',
				order = 25,
				name = L["Remove"],
				confirm = true,
				confirmText = L["Are you sure?"],
				func = function() 
					db[key] = nil
					options[key] = nil
				end,
			},
			existingsound = {
				name = L["Use existing sound"],
				type = 'toggle',
				order = 41,
			},
			soundfilepath = {
				name = L["file path"],
				type = 'input',
				width = 'double',
				order = 26,
				disabled = function() return db[key].existingsound end,
			},
			test = {
				type = 'execute',
				order = 28,
				name = L["Test"],
				disabled = function() return db[key].existingsound end,
				func = function() PlaySoundFile(db[key].soundfilepath, "Master") end,
			},
			NewLinetest = {
					type= 'description',
					order = 29,
					name= '',
			},
			existinglist = {
				name = L["choose a sound"],
				type = 'select',
				dialogControl = 'LSM30_Sound',
				values =  LSM:HashTable("sound"),
				disabled = function() return not db[key].existingsound end,
				order = 40,
			},
			NewLine3 = {
				type= 'description',
				order = 45,
				name= '',
			},
			eventtype = {
				type = 'multiselect',
				order = 50,
				name = L["event type"],
				values = self.GSA_EVENT,
				get = function(info, k) return db[key].eventtype[k] end,
				set = function(info, k, v) db[key].eventtype[k] = v end,
			},
			sourcetypefilter = {
				type = 'select',
				order = 59,
				name = L["Source type"],
				values = self.GSA_TYPE,
			},
			desttypefilter = {
				type = 'select',
				order = 60,
				name = L["Dest type"],
				values = self.GSA_TYPE,
			},
			sourceuidfilter = {
				type = 'select',
				order = 61,
				name = L["Source unit"],
				values = self.GSA_UNIT,
			},
			sourcecustomname = {
				type= 'input',
				order = 62,
				name= L["Custom unit name"],
				disabled = function() return not (db[key].sourceuidfilter == "custom") end,
			},
			destuidfilter = {
				type = 'select',
				order = 65,
				name = L["Dest unit"],
				values = self.GSA_UNIT,
			},
			destcustomname = {
				type= 'input',
				order = 68,
				name = L["Custom unit name"],
				disabled = function() return not (db[key].destuidfilter == "custom") end,
			},
			--[[NewLine5 = {
				type = 'header',
				order = 69,
				name = "",
			},]]
		}
	}
end
	
function GSA:OnOptionCreate()
	gsadb = self.db1.profile
	options_created = true -- ***** @
	self.options = {
		type = "group",
		name = GetAddOnMetadata("GladiatorlosSA", "Title"),
		args = {
			general = {
				type = 'group',
				name = L["General"],
				desc = L["General options"],
				set = setOption,
				get = getOption,
				order = 1,
				args = {
					enableArea = {
						type = 'group',
						inline = true,
						name = L["Enable area"],
						order = 1,
						args = {
							all = {
								type = 'toggle',
								name = L["Anywhere"],
								desc = L["Alert works anywhere"],
								order = 10,
							},
							--onlyflagged = {
							--	type = 'toggle',
							--	name = L["OnlyIfPvPFlagged"],
							--	desc = L["OnlyIfPvPFlaggedDesc"],
							--	disabled = function() return not gsadb.field or gsadb.all end,
							--	order = 20,
							--},
							NewLine1 = {
								type= 'description',
								order = 30,
								name= '',
							},
							arena = {
								type = 'toggle',
								name = L["Arena"],
								desc = L["Alert only works in arena"],
								disabled = function() return gsadb.all end,
								order = 40,
							},
							battleground = {
								type = 'toggle',
								name = L["Battleground"],
								desc = L["Alert only works in BG"],
								disabled = function() return gsadb.all end,
								order = 50,
							},
							epicbattleground = {
								type = 'toggle',
								name = L["epicbattleground"],
								desc = L["epicbattlegroundDesc"],
								disabled = function() return gsadb.all end,
								order = 60,
							},
							NewLine2 = {
								type= 'description',
								order = 70,
								name= '',
							},
							field = {
								type = 'toggle',
								name = L["World"],
								desc = L["Alert works anywhere else then anena, BG, dungeon instance"],
								disabled = function() return gsadb.all end,
								order = 80,
							},
						},
					},
					voice = {
						type = 'group',
						inline = true,
						name = L["Voice config"],
						order = 2,
						args = {
							path = {
								type = 'select',
								name = L["Default / Female voice"],
								desc = L["Select the default voice pack of the alert"],
								values = self.GSA_LANGUAGE,
								order = 1,
							},
							volumn = {
								type = 'range',
								max = 1,
								min = 0,
								step = 0.1,
								name = L["Master Volume"],
								desc = L["adjusting the voice volume(the same as adjusting the system master sound volume)"],
								set = function (info, value) SetCVar ("Sound_MasterVolume",tostring (value)) end,
								get = function () return tonumber (GetCVar ("Sound_MasterVolume")) end,
								order = 6,
							},
						},
					},
					advance = {
						type = 'group',
						inline = true,
						name = L["Advance options"],
						order = 3,
						args = {
							smartDisable = {
								type = 'toggle',
								name = L["Smart disable"],
								desc = L["Disable addon for a moment while too many alerts comes"],
								order = 1,
							},
							throttle = {
								type = 'range',
								max = 5,
								min = 0,
								step = 0.1,
								name = L["Throttle"],
								desc = L["The minimum interval of each alert"],
								disabled = function() return not gsadb.smartDisable end,
								order = 2,
							},
							NewLineOutput = {
								type= 'description',
								order = 3,
								name= '',
							},
							outputUnlock = {
								type = 'toggle',
								name = L["Change Output"],
								desc = L["Unlock the output options"],
								order = 8,
								confirm = true,
								confirmText = L["Are you sure?"],
							},
							output_menu = {
								type = 'select',
								name = L["Output"],
								desc = L["Select the default output"],
								values = GSA_OUTPUT,
								order = 10,
								disabled = function() return not gsadb.outputUnlock end,
							},
						},
					},
				},
			},
			spells = {
				type = 'group',
				name = L["Abilities"],
				desc = L["Abilities options"],
				set = setOption,
				get = getOption,
				childGroups = "tab",
				order = -2,
				args = {
				menu_voice = {
						type = 'group',
						inline = true,
						name = L["Voice menu config"], 
						order = -3,
						args = {
							path_menu = {
								type = 'select',
								name = L["Choose a test voice pack"],
								desc = L["Select the menu voice pack alert"], 
								values = self.GSA_LANGUAGE,
								order = 1,
							},
						},
				},
				spellGeneral = {
						type = 'group',
						name = L["Disable options"],
						desc = L["Disable abilities by type"],
						inline = true,
						order = -2,
						args = {
							aruaApplied = {
								type = 'toggle',
								name = L["Disable Buff Applied"],
								desc = L["Check this will disable alert for buff applied to hostile targets"],
								order = 1,
							},
							aruaRemoved = {
								type = 'toggle',
								name = L["Disable Buff Down"],
								desc = L["Check this will disable alert for buff removed from hostile targets"],
								order = 2,
							},
							castStart = {
								type = 'toggle',
								name = L["Disable Spell Casting"],
								desc = L["Chech this will disable alert for spell being casted to friendly targets"],
								order = 3,
							},
							castSuccess = {
								type = 'toggle',
								name = L["Disable special abilities"],
								desc = L["Check this will disable alert for instant-cast important abilities"],
								order = 4,
							},
							interrupt = {
								type = 'toggle',
								name = L["Disable friendly interrupt"],
								desc = L["Check this will disable alert for successfully-landed friendly interrupting abilities"],
								order = 6,
							},
							interruptedfriendly = {
								type = 'toggle',
								name = L["FriendlyInterrupted"],
								desc = L["FriendlyInterruptedDesc"],
								order = 7,
							},
						},
					},
					spellAuraApplied = {
						type = 'group',
						--inline = true,
						name = L["Buff Applied"],
						disabled = function() return gsadb.aruaApplied end,
						order = 1,
						args = {
							aonlyTF = {	-- AuraApplied
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 10,
							},
							drinking = { -- AuraApplied 
								type = 'toggle',
								name = L["Alert Drinking"],
								desc = L["In arena, alert when enemy is drinking"],
								order = 20,
							},
							generalaura = { --AuraApplied
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 30,					      		
								args = listOption({5530,195901,214027,34709,44055},"auraApplied"),
							},

							dispelkickback = { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["DispelKickback"],
								order = 40,
								args = listOption({87204,196364},"auraApplied"),
							},
							druid = { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 70,
								args = listOption({5229,2893,29166,22812,9846,26999,27009,27006,17116},"auraApplied"),
							},
							hunter = { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 80,
								args = listOption({3045,19577,19263,19574,14311},"auraApplied"),
							},
							mage = { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 90,
								args = listOption({33946,33944,27128,32796,27131,12043,12042,11129,12472,33405,12355},"auraApplied"),
							},
							paladin = { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 110,
								args = listOption({1044,5573,10278,31895,1020,27158,31892,31801,27155,27166,27160,31884,27148,20216,20375,20170,31842},"auraApplied"),
							},
							priest	= { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 120,
								args = listOption({2651,6346,25441,33206,10060,14751,15286,552},"auraApplied"),
							},
							rogue = { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 130,
								args = listOption({26669,31224,14177,13750,1833,11297,26884},"auraApplied"),
							},
							shaman	= { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 140,
								args = listOption({16166,30823,16188},"auraApplied"),
							},
							warlock	= { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 150,
								args = listOption({132,28610,18288},"auraApplied"),
							},
							warrior	= { -- AuraApplied
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 160,
								args = listOption({2457,71,2458,2687,871,18499,1719,23920,12292,12975},"auraApplied"),
							},
						},
					},
					spellAuraRemoved = {
						type = 'group',
						--inline = true,
						name = L["Buff Down"],
						disabled = function() return gsadb.aruaRemoved end,
						order = 2,
						args = {
							ronlyTF = { -- AuraRemoved
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 10,
							},
							generalauradown = { --AuraRemoved
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 30,
								args = listOption({44055},"auraRemoved"),
							},
							druid = { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 60,
								args = listOption({29166},"auraRemoved"),
							},
							hunter = { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 70,
								args = listOption({19263},"auraRemoved"),
							},
							mage = { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 80,
								args = listOption({12042,11129,12472},"auraRemoved"),
							},
							paladin = { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 100,
								args = listOption({25771,5573,10278,1020,27148,20216},"auraRemoved"),
							},
							priest	= { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 110,
								args = listOption({2651,6346,25441,15286,33206,10060,14751},"auraRemoved"),
							},
							rogue = { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 120,
								args = listOption({26669,31224},"auraRemoved"),
							},
							shaman	= { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 130,
								args = listOption({30823},"auraRemoved"),
							},
--[[							warlock = { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 140,
								args = listOption({},"auraRemoved"),
							},]]
							warrior	= { -- AuraRemoved
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 150,
								args = listOption({871,1719,23920,12292,12975},"auraRemoved"),
							},
						},
					},
					spellCastStart = {
						type = 'group',
						--inline = true,
						name = L["Spell Casting"],
						disabled = function() return gsadb.castStart end,
						order = 2,
						args = {
							conlyTF = { -- CastStart
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 1,
							},
							resurrection = { -- CastStart
								type = 'toggle',
								name = L["Resurrection"],
								desc = L["Resurrection_Desc"],
								order = 20,
							},
--[[							bigHeal = { -- CastStart
								type = 'toggle',
								name = L["BigHeal"],
								desc = L["BigHeal_Desc"],
								order = 30,
							},]]
							druid = { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 60,
								args = listOption({2637,18658,26989,33786},"castStart"),
							},
							hunter = { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 70,
								args = listOption({27065,982,14327},"castStart"),
							},
							mage = { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 80,
								args = listOption({12826,12051},"castStart"),
							},
							paladin = { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 100,
								args = listOption({10326},"castStart"),
							},
							priest	= { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 110,
								args = listOption({10912,25380,32375},"castStart"),
							},
							--rogue = { -- CastStart
							--	type = 'group',
							--	inline = true,
							--	name = L["|cffFFF569Rogue|r"],
							--	order = 120,
							--	args = listOption({},"castStart"),
							--},
--[[							shaman	= { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 130,
								args = listOption({},"castStart"),
							},]]
							warlock	= { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 140,
								args = listOption({30146,1122,6215,17928,30405,18647,30414,29893,27220,30908,30545},"castStart"),
							},
--[[							warrior = { -- CastStart
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 150,
								args = listOption({},"castStart"),
							},]]
						},
					},
					spellCastSuccess = {
						type = 'group',
						--inline = true,
						name = L["Special Abilities"],
						disabled = function() return gsadb.castSuccess end,
						order = 3,
						args = {
							sonlyTF = { -- CastSuccess
								type = 'toggle',
								name = L["Target and Focus Only"],
								desc = L["Alert works only when your current target or focus gains the buff effect or use the ability"],
								order = 10,
							},
							class = { -- CastSuccess
								type = 'toggle',
								name = L["PvP Trinketed Class"],
								desc = L["Also announce class name with trinket alert when hostile targets use PvP trinket in arena"],
								--disabled = function() return not gsadb.trinket end,
								order = 13,
							},
							success = { -- CastSuccess
								type = 'toggle',
								name = L["CastingSuccess"],
								desc = L["CastingSuccess_Desc"],
								--disabled = function() return gsadb.castStart end,
								order = 15,
							},
							connected = { -- CastSuccess
								type = 'toggle',
								name = L["Connected"],
								desc = L["Connected_Desc"],
								--disabled = function() return gsadb.castStart end,
								order = 17,
							},
--[[							cure = { -- CastSuccess
								type = 'toggle',
								name = L["DPSDispel"],
								desc = L["DPSDispel_Desc"],
								order = 20,
							},]]
--[[							dispel = { -- CastSuccess
								type = 'toggle',
								name = L["HealerDispel"],
								desc = L["HealerDispel_Desc"],
								order = 24,
							},]]
--[[							purge = { -- CastSuccess
								type = 'toggle',
								name = L["Purge"],
								desc = L["PurgeDesc"],
								order = 26,
							},]]
--[[							general = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["General Abilities"],
								order = 30,
								args = listOption({},"castSuccess"),
							},]]
--[[							enemyInterrupts = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["EnemyInterrupts"],
								order = 35,
								args = listOption({},"castSuccess"),
							},]]
							druid = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cffFF7D0ADruid|r"],
								order = 70,
								args = listOption({8946,2782,8983,9913,33357,26993,33831,26983,18562},"castSuccess"),
							},
							hunter = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cffABD473Hunter|r"],
								order = 80,
								args = listOption({5116,1543,14325,14311,34490,23989,27068,19503,27019},"castSuccess"),
							},
							mage = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cff69CCF0Mage|r"],
								order = 90,
								args = listOption({475,1953,2139,45438,27088,66,30449,11113,11958,31687},"castSuccess"),
							},
							paladin = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cffF58CBAPaladin|r"],
								order = 110,
								args = listOption({20271,1152,4987,10308,27154,33072,20066},"castSuccess"),
							},
							priest	= { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cffFFFFFFPriest|r"],
								order = 120,
								args = listOption({32548,528,988,10890,34433,25467,44047,32996,15487},"castSuccess"),
							},
							rogue = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cffFFF569Rogue|r"],
								order = 130,
								args = listOption({2094,8643,8696,11305,1787,26889,38764,38768,14278,14185,36554},"castSuccess"),
							},
							shaman	= { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman|r"],
								order = 140,
								args = listOption({2484,526,8143,2870,8166,8177,8012,25454,8170,2062,2894,2825,16190},"castSuccess"),
							},
--[[							shamanTotems	= { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cff0070daShaman (Totems)|r"],
								order = 141,
								args = listOption({},"castSuccess"),
							},]]
							warlock = { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cff9482C9Warlock|r"],
								order = 150,
								args = listOption({27223},"castSuccess"),
							},
							warrior	= { -- CastSuccess
								type = 'group',
								inline = true,
								name = L["|cffC79C6EWarrior|r"],
								order = 160,
								args = listOption({676,5246,6554,29704,11578,25275,3411,12328,12809},"castSuccess"),
							},
						},
					},
				},
			},
			custom = {
				type = 'group',
				name = L["Custom"],
				desc = L["Custom Spell"],
				--set = function(info, value) local name = info[#info] gsadb.custom[name] = value end,
				--get = function(info) local name = info[#info]	return gsadb.custom[name] end,
				order = 4,
				args = {
					newalert = {
						type = 'execute',
						name = L["New Sound Alert"],
						order = -1,
						--[[args = {
							newname = {
								type = 'input',
								name = "name",
								set = function(info, value) local name = info[#info] if gsadb.custom[vlaue] then log("name already exists") return end gsadb.custom[vlaue]={} end,			
							}]]
						func = function()
							gsadb.custom[L["New Sound Alert"]] = {
								name = L["New Sound Alert"],
								soundfilepath = "Interface\\AddOns\\GladiatorlosSA2\\Voice_Custom\\Will-Demo.ogg",--"..L["New Sound Alert"]..".ogg",
								sourceuidfilter = "any",
								destuidfilter = "any",
								eventtype = {
									SPELL_CAST_SUCCESS = true,
									SPELL_CAST_START = false,
									SPELL_AURA_APPLIED = false,
									SPELL_AURA_REMOVED = false,
									SPELL_INTERRUPT = false,
								},
								sourcetypefilter = COMBATLOG_FILTER_EVERYTHING,
								desttypefilter = COMBATLOG_FILTER_EVERYTHING,
								order = 0,
							}
							self:MakeCustomOption(L["New Sound Alert"])
						end,
						disabled = function()
							if gsadb.custom[L["New Sound Alert"]] then
								return true
							else
								return false
							end
						end,
					}
				}
			}
		}
	}

	for k, v in pairs(gsadb.custom) do
		self:MakeCustomOption(k)
	end	
	AceConfig:RegisterOptionsTable("GladiatorlosSA", self.options)
	self:AddOption(L["General"], "general")
	self.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db1)
	self.options.args.profiles.order = -1
	
	self:AddOption(L["Abilities"], "spells")
	self:AddOption(L["Custom"], "custom")
	self:AddOption(L["Profiles"], "profiles")
end