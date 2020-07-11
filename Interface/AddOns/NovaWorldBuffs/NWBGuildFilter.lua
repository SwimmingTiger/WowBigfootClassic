-------------------------------
---NovaWorldBuffs chat filter--
-------------------------------

--Originally this was using L[] locales but then it didn't filter for people using english client on non-english regions.
--So we have to use this large table instead because acelocale doesn't load all locales at once to check.
--Maybe it can do that but I'm not sure how and this was easier, guild msgs aren't spammed anyway so a big table is fine.
--These need to be updated if any of these strings in the locale file changes.
local filterTypeLocales = {
	["filterYells"] = {
		--NPC dialogue started msgs (first yell).
		["Rend will drop in 6 seconds."] = true, --EN "rendFirstYellMsg".
		["Onyxia will drop in 14 seconds."] = true, --EN "onyxiaFirstYellMsg".
		["Nefarian will drop in 15 seconds."] = true, --EN "nefarianFirstYellMsg".
		["Zandalar will drop in 30 seconds."] = true, --EN "zanFirstYellMsg".
		--CN
		["雷德·黑手Buff将在 6 秒后释放。"] = true,
		["奥妮克希亚Buff将在 14 秒后释放。"] = true,
		["奈法利安Buff 15 秒后释放。"] = true,
		["赞达拉Buff 将于 30秒 后释放。"] = true,
		--DE
		["Rend Buff in 6 Sekunden"] = true,
		["Onyxia Buff in 14 Sekunden."] = true,
		["Nefarian Buff in 15 Sekunden."] = true,
		["Zandalar Buff in 27 Sekunden."] = true,
		--TW
		["酋長祝福的閃電，將在6秒後施放。"] = true,
		["奧妮克西婭的頭顱已插，閃電將在14秒後施放。"] = true,
		["奈法利安的頭顱已插，閃電將在15秒後施放。"] = true,
		["贊達拉之魂，將在30秒後施放。"] = true,
		--KR
		["대족장의 축복 6초 전!!"] = true,
		["오닉 버프 14초 전!!"] = true,
		["네파 버프 15초 전!!"] = true,
		["잔달라버프 30초 전!!"] = true,
		--FR
		["Rend va être posé dans 6 secondes."] = true,
		["Onyxia va être posé dans 14 secondes."] = true,
		["Nefarian va être posé dans 15 secondes."] = true,
		["Zandalar va être posé dans 30 secondes."] = true,
		--RU
		["Ренд будет бафнут через 6 секунд."] = true,
		["Ониксия будет бафнута через 14 секунд."] = true,
		["Нефариан будет бафнут через 15 секунд."] = true,
		["Зандалар будет бафнут через 30 секунд."] = true,
	},
	["filterDrops"] = {
		--Buff has dropped msgs.
		["Warchief's Blessing (Rend) has dropped."] = true, --EN "rendBuffDropped".
		["Rallying Cry of the Dragonslayer (Onyxia) has dropped."] = true, --EN "onyxiaBuffDropped".
		["Rallying Cry of the Dragonslayer (Nefarian) has dropped."] = true, --EN "nefarianBuffDropped".
		["Spirit of Zandalar (Hakkar) has dropped."] = true, --EN "zanBuffDropped".
		--CN
		["酋长的祝福 (雷德·黑手) 已经释放。"] = true,
		["屠龙者的咆哮（奥妮克希亚）Buff 已经释放。"] = true,
		["屠龙者的咆哮（奈法利安）Buff 已经释放。"] = true,
		["赞达拉之魂Buff (哈卡) 已经释放。"] = true,
		--DE
		["Segen des Kriegshäuptlings (Rend) Buff wurde gewirkt."] = true,
		["Schlachtruf der Drachentöter (Onyxia) Buff wurde gewirkt."] = true,
		["Schlachtruf der Drachentöter (Nefarian) Buff wurde gewirkt."] = true,
		["Geist von Zandalar (Hakkar) Buff wurde gewirkt."] = true,
		--TW
		["酋長的祝福(雷德) 已經施放。"] = true,
		["屠龍者的咆哮 (奧妮克西婭) 已經施放。"] = true,
		["屠龍者的咆哮 (奈法利安) 已經施放。"] = true,
		["贊達拉之魂已經施放。"] = true,
		--KR
		["대족장의 축복 완료!!"] = true,
		["오닉 버프 완료!!"] = true,
		["네파 버프 완료!!"] = true,
		["잔달라버프 끝!!"] = true,
		--FR
		["Bénédiction du chef de guerre (Rend) a été posé."] = true,
		["Cri de ralliement du tueur de dragon (Onyxia) a été posé."] = true,
		["Cri de ralliement du tueur de dragon (Nefarian) a été posé."] = true,
		["Esprit des Zandalar (Hakkar) a été posé."] = true,
		--RU
		["Благословление вождя (Ренд) было бафнуто."] = true,
		["Ободряющий клич Драконоборца (Ониксия) был бафнут."] = true,
		["Ободряющий клич Драконоборца (Нефариан) был бафнут."] = true,
		["Дух Зандалара (Хаккар) был бафнут."] = true,
	},
	["filterTimers"] = {
		--Timer msgs.
		["A new %s buff can be dropped now"] = true, --EN "newBuffCanBeDropped".
		["%s resets in %s"] = true, --EN "buffResetsIn".
		--CN
		["一个新的 %s buff 现在可以取得"] = true,
		["%s 重置于 %s后."] = true,
		--DE
		["Ein neuer %s Buff kann jetzt gestellt werden"] = true,
		["%s wird zurückgesetzt in %s"] = true,
		--TW
		["一個新的 %s 增益現在可以取得"] = true,
		["%s 重置在 %s"] = true,
		--KR
		["%s 버프 가능"] = true,
		["%s 버프가 %s 후 리셋"] = true,
		--FR
		["Un nouveau buff %s peut être activé"] = true,
		["%s resets dans %s"] = true,
		--RU
		["%s может быть поставлен(а) сейчас"] = true,
		["%s откатится через %s"] = true,
	},
	["filterSongflowers"] = {
		--Songflower msgs.
		["Songflower picked at %s, next spawn in 25mins."] = true, --EN "songflowerPicked".
		--CN
		["轻歌花在 %s 被拾取, 25分钟后刷新。"] = true,
		--DE
		["Liedblume %s gepflückt. Erneut zu pflücken in 25min."] = true,
		--TW
		["輕歌花已被拾取，在 %s ，重生在25分鐘後。"] = true,
		--KR
		["%s 에 노래꽃 획득, 25분 후 재생성"] = true,
		--FR
		["Songflower prise à %s, prochain spawn dans 25mins."] = true,
		--RU
		["Песнецвет взят в локации: %s. Следующий через 25 мин."] = true,
	},
	["filterNpcKilled"] = {
		--Npc killed.
		["Overlord Runthak has just been killed (Onyxia buff NPC)."] = true, --EN "onyxiaNpcKilledHorde".
		["Major Mattingly has just been killed (Onyxia buff NPC)."] = true, --EN "onyxiaNpcKilledAlliance".
		["High Overlord Saurfang has just been killed (Nefarian buff NPC)."] = true, --EN "nefarianNpcKilledHorde".
		["Field Marshal Afrasiabi has just been killed (Nefarian buff NPC)."] = true, -- EN "nefarianNpcKilledAlliance".
		--CN
		["伦萨克死亡了。 (奥妮克希亚 buff NPC)。"] = true,
		["玛丁雷少校死亡了。(奥妮克希亚 buff NPC)。"] = true,
		["萨鲁法尔大王死亡了。 (奈法利安 buff NPC)。"] = true,
		["艾法希比元帅死亡了。(奈法利安 buff NPC)。"] = true,
		--DE
		["Oberanführer Runthak wurde getötet (Onyxia Buff NPC)."] = true,
		["Major Mattingly wurde getötet (Onyxia Buff NPC)."] = true,
		["Hochfürst Saurfang wurde getötet (Nefarian Buff NPC)."] = true,
		["Feldmarschall Afrasiabi wurde getötet (Nefarian Buff NPC)."] = true,
		--TW
		["倫薩克已經被殺了!(奧妮克西婭增益NPC )."] = true,
		["瑪丁雷少校已經被殺了! (奧妮克西婭增益NPC)."] = true,
		["薩魯法爾大王已經被殺了! (奈法利安增益NPC )."] = true,
		["艾法希比元帥已經被殺了! (奈法利安增益NPC )."] = true,
		--KR
		["대군주 룬탁이 지금 죽었습니다 (오닉 버프 NPC)."] = true,
		["상사 매팅글리가 지금 죽었습니다 (오닉 버프 NPC)."] = true,
		["대군주 사울팽이 지금 죽었습니다 (네파 버프 NPC)."] = true,
		["야전사령관 아프라샤비가 지금 죽었습니다 (네파 버프 NPC)."] = true,
		--FR
		["Seigneur Runthak a été tué (PNJ Onyxia buff)."] = true,
		["Major Mattingly a été tué (PNJ Onyxia buff)."] = true,
		["Haut seigneur Saurfang a été tué (PNJ Nefarian buff)."] = true,
		["Grand maréchal Afrasiabi a été tué (PNJ Nefarian buff)."] = true,
		--RU
		["Властитель Рунтак был убит (NPC, который бафает Ониксию)."] = true,
		["Майор Маттингли был убит (NPC, который бафает Ониксию)."] = true,
		["Верховный воевода Саурфанг был убит (NPC, который бафает Нефариана)."] = true,
		["Фельдмаршал Афрасиаби был убит (NPC, который бафает Нефариана)."] = true,
	},
	["filterCommandResponse"] = {
		--!wb command response.
		["Onyxia:(.+)Nefarian:"] = true,
		--CN
		["奥妮克希亚:(.+)奈法利安:"] = true,
		--DE
		--["Onyxia:(.+)Nefarian:"] = true,
		--TW
		["奧妮克西婭:(.+)奈法利安:"] = true,
		--KR
		["오닉:(.+)네파:"] = true,
		--FR
		--["Onyxia:(.+)Nefarian:"] = true,
		--RU
		["Ониксия:(.+)Нефариан:"] = true,
	},
};

function NWB.guildChatFilter(self, event, msg, author, ...)
	if (NWB.loaded) then
		for type, locales in pairs(filterTypeLocales) do
			if (NWB.db.global[type]) then
				for k, v in pairs(locales) do
					local match = k;
					if (type ~= "filterCommandResponse") then
						--Only add escapes for strings without (.+).
						match = string.gsub(k, "%(", "%%(");
						match = string.gsub(match, "%)", "%%)");
						match = string.gsub(match, "%.", "."); --Test this.
						match = string.gsub(match, "%%s", "(.+)");
					end
					if (match and match ~= "" and string.match(msg, "%[WorldBuffs%]") and string.match(msg, match)) then
						NWB:debug("filtering", k);
						return true;
					end
				end
			end
		end
		if (NWB.db.global.filterCommand and (string.match(msg, "^!wb") or string.match(msg, "^!dmf"))) then
			NWB:debug("filtering command");
			return true;
		end
	end
	return false, msg, author, ...;
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", NWB.guildChatFilter);

--This is to make sure the whole addon loaded correctly with no errors so the chat filters work correctly.
--This is the last file to load.
NWB.loaded = true;