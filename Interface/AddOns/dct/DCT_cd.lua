local ActiveCD = {}
local ActiveC = 0

function DCT_ProcCooldown(self, event, arg1, arg2)
	if DCT_Player["DCT_SHOWCOOLDOWN"].frame == 0 then return;end
	local cdp = DCT_Player["DCT_SPECCOOLDOWN"]

	local n, duration, enabled
	local spellName
	local ctime = GetTime()
	for spellName in pairs(cdp) do
		local n, duration, enabled = GetSpellCooldown(spellName)
		if enabled == 1 then
			if duration > 3.5 then
				if not ActiveCD[spellName] then
					ActiveCD[spellName] = {duration = duration,stime = ctime}
					ActiveC = ActiveC + 1
				end
			end
		end
	end
end

function DCT_CooldownOnUpdata()
	if ActiveC <= 0 then return;end
	if DCT_Player["DCT_SHOWCOOLDOWN"].frame == 0 then return;end

	local ctime = GetTime()
	local k,v
	for k,v in pairs(ActiveCD) do
		if ctime - v.stime > v.duration then
			DCT_SSC_Format_DisableAll()
			dct_spellName = k
			dct_icon = GetSpellTexture(k)
			DCT_AddText("DCT_SHOWCOOLDOWN",1,false,nil)
			ActiveCD[k] = nil
			ActiveC = ActiveC - 1
		end
	end
end