if WOW_PROJECT_ID ~= (WOW_PROJECT_MAINLINE or 1) then -- Added in MoP
	return
end
local mod	= DBM:NewMod("z727", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220126115338")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	local function Init(self)
		local zoneID = DBM:GetCurrentArea()
		if not bgzone and zoneID == 727 then
			bgzone = true
			self:RegisterShortTermEvents(
				"CHAT_MSG_BG_SYSTEM_HORDE",
				"CHAT_MSG_BG_SYSTEM_ALLIANCE",
				"CHAT_MSG_BG_SYSTEM_NEUTRAL",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"PVP_VEHICLE_INFO_UPDATED"
			)
		elseif bgzone and zoneID ~= 727 then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(1, Init, self)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end

local carts = {}
local ClearCartCache

do
	local tinsert = table.insert
	local GetTime = GetTime
	local cartRespawn = mod:NewTimer(9.5, "TimerRespawn", "134376") -- interface/icons/inv_misc_pocketwatch_01.blp
	local cartCount	= 0

	function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
		if msg == L.Capture or msg:find(L.Capture) then
			cartCount = cartCount + 1
			if cartCount % 2 == 1 then -- Event is fired twice, due to being fired both on neutral and faction.
				cartRespawn:Start(nil, cartCount)
				ClearCartCache()
			end
		elseif msg == L.Arrived or msg:find(L.Arrived) then
			tinsert(carts, 1, {
				dir		= 0,
				spawn	= GetTime(),
				x		= -1,
				y		= -1,
				c		= -1
			})
		elseif msg == L.Begun or msg:find(L.Begun) then
			carts = {}
			tinsert(carts, 1, {
				dir		= 1,
				spawn	= GetTime() - 60,
				x		= 46.34,
				y		= 34.44,
				c		= -1
			})
			tinsert(carts, 1, {
				dir		= 3,
				spawn	= GetTime() - 60,
				x		= 44.63,
				y		= 58.25,
				c		= -1
			})
		end
	end
	mod.CHAT_MSG_BG_SYSTEM_ALLIANCE = mod.CHAT_MSG_RAID_BOSS_EMOTE
	mod.CHAT_MSG_BG_SYSTEM_HORDE = mod.CHAT_MSG_RAID_BOSS_EMOTE
	mod.CHAT_MSG_BG_SYSTEM_NEUTRAL = mod.CHAT_MSG_RAID_BOSS_EMOTE
end

do
	local pairs, abs, sqrt, tremove = pairs, math.abs, math.sqrt, table.remove
	local GetTime, GetNumBattlefieldVehicles, GetBattlefieldVehicleInfo = GetTime, GetNumBattlefieldVehicles, C_PvP.GetBattlefieldVehicleInfo

	local times = { 181, 234, 129, 97, 153 }
	local caps = {
		{ x = 22.848, y = 42.823 },
		{ x = 76.517, y = 21.757 },
		{ x = 41.281, y = 48.239 },
		{ x = 69.326, y = 70.632 },
		{ x = 76.517, y = 21.757 }
	}
	local names = { "Top - Down", "Top - Up", "Middle", "Lava - Down", "Lava - Up" }
	local cartTimer	= mod:NewTimer(9.5, "TimerCart", "136002") -- Interface\\icons\\spell_misc_hellifrepvphonorholdfavor.blp

	local function IsValidUpdate(dir1, dir2)
		if dir1 == 0 or dir2 == 0 then
			return false
		end
		if dir1 == dir2 then
			return true
		elseif dir1 == 3 or dir2 == 3 then
			return false
		elseif abs(dir1 - dir2) == 1 then
			return true
		end
		return false
	end

	local function GetDistance(x1, y1, x2, y2)
		return sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
	end

	function ClearCartCache()
		local time = GetTime()
		for i, cart in pairs(carts) do
			if cart.dir ~= 0 and times[cart.dir] + cart.spawn + 2 > time then
				if GetDistance(cart.x, cart.y, caps[cart.dir].x, caps[cart.dir].y) < 3 then
					cartTimer:Stop(names[cart.dir])
					tremove(carts, i)
				end
			end
		end
	end

	local function PointToLineDist(a, b, x, y)
		return (a * x + b - y) / (sqrt(a ^ 2 + 1))
	end

	local function IdentifyCartCoord(x, y)
		local dist1, dist2, dist3, dist4 = PointToLineDist(-2.126, -168.449, x, y), PointToLineDist(-0.513, 76.476, x, y), PointToLineDist(-0.555, 64.673, x, y), PointToLineDist(0.952, -12.176, x, y)
		if dist1 < 0 and dist3 < 0 then
			return dist4 > 0 and 5 or 4 -- Lava Up / Down
		elseif dist1 > 0 and dist3 < 0 and dist2 < 0 then
			return 3 -- Middle
		elseif dist2 > 0 and (dist1 > 0 or dist3 > 0) then
			return dist4 > 0 and 2 or 1 -- Top Up / Down
		end
	end

	local function IdentifyCart(cartNum)
		local cart = carts[cartNum]
		if not cart then
			return
		end
		local closestID, distance = 0, 1000
		for d = 1, GetNumBattlefieldVehicles() do
			local x, y = GetBattlefieldVehicleInfo(d, 423)
			x = x * 100
			y = y * 100
			local dist = GetDistance(56.87, 47.117, x, y)
			if dist < distance then
				local used = false
				for _, v in pairs(carts) do
					if GetDistance(x, y, v.x, v.y) < 2 then
						used = true
						break
					end
				end
				if not used then
					closestID = d
					distance = dist
				end
			end
		end
		if closestID ~= 0 then
			local x, y = GetBattlefieldVehicleInfo(closestID, 423)
			cart.x		= x * 100
			cart.y		= y * 100
			cart.dir	= IdentifyCartCoord(cart.x, cart.y)
		end
	end

	function mod:PVP_VEHICLE_INFO_UPDATED()
		local cache = {}
		for i = 1, GetNumBattlefieldVehicles() do
			local vInfo = GetBattlefieldVehicleInfo(i, 423)
			local x, y = vInfo.x, vInfo.y
			x = x * 100
			y = y * 100
			cache[i] = {
				x	= x,
				y	= y,
				dir	= IdentifyCartCoord(x, y),
				c	= (vInfo.name:match("Red") and 0) or (vInfo.name:match("Blue") and 1) or -1
			}
		end
		local time = GetTime()
		local prune = #cache < #carts
		for _, newCart in pairs(cache) do
			for i, cart in pairs(carts) do
				if (cart.x == -1 or cart.y == -1) and cart.spawn + 1 < time then
					IdentifyCart(i)
					if not cartTimer:IsStarted(names[cart.dir]) then -- Prevent duplicate cart timers.
						cartTimer:Start(cart.spawn + times[cart.dir] - time, names[cart.dir])
					end
				elseif GetDistance(newCart.x, newCart.y, cart.x, cart.y) < 1 and IsValidUpdate(cart.dir, newCart.dir) then
					if newCart.c ~= cart.c then
						local name = names[cart.dir]
						if newCart.c == 1 then
							cartTimer:SetColor({r=0, g=0, b=1}, name)
							cartTimer:UpdateIcon("132486", name) -- Interface\\Icons\\INV_BannerPVP_02.blp
						elseif newCart.c == 0 then
							cartTimer:SetColor({r=1, g=0, b=0}, name)
							cartTimer:UpdateIcon("132485", name) -- Interface\\Icons\\INV_BannerPVP_01.blp
						else
							cartTimer:SetColor({r=128, g = 128, b=128})
							cartTimer:UpdateIcon("132487", name) -- Interface\\Icons\\INV_BannerPVP_03.blp
						end
					end
					cart.dir	= newCart.dir
					cart.x		= newCart.x
					cart.y		= newCart.y
					cart.c		= newCart.c
				elseif prune and (cart.spawn + times[cart.dir] - time < -1) then
					carts[i] = nil
				end
			end
		end
	end
end
