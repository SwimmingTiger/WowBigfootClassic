--[[	RealMobHealth Localization Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

----------------------------------
--[[	Localization Table	]]
----------------------------------
local Localization={
	enUS={
--		Commands
		Command_NoUnitData="Unit not found.";
		Command_DeletedUnitFormat="Deleted %2$s(%1$s)";--	format(CreatureKey,UnitName)
		Command_HealthWiped="Health data wiped.";

--		Options Panel
		Options_DynamicList={--	Button Text,Tooltip Title,Description
--					Tooltip Title=false to use Button Text
			ShowStatusBarTextAdditions={"Show TargetFrame Text",false,"Creates text for TargetFrame's bars."};
			ModifyHealthBarText={"Modify UnitFrame Health",false,"Shows real health values for mobs in default UnitFrames."};
			ShowTooltipText={"Show Tooltip Feedback",false,"Displays if a mob's health is present in Health Cache."};
			ShowTooltipHealthText={"Show Tooltip Health",false,"Shows health on the GameTooltip's StatusBar"};
			ShowNamePlateHealthText={"Show NamePlate Health",false,"Shows health on the left side of NamePlates."};

			EnablePeerCache={"Enable","Enable Peer Cache","Toggles receiving health data from others.\n|cffffff00Note: This addon will still answer queries and broadcast health updates.|r"};
		};
		Options_SetByAddOn="|cffff0000This option has been overridden by another addon.|r";

--		Options Cache Panels
		Options_HealthCachePanel={"Health Cache","Stores health data from mobs encountered."};
		Options_PeerCachePanel={"Peer Cache","Stores health data reported by others."};
		Options_CacheSizeLabel="Cache Size:";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="Clear Cache";
		Options_ClearHealthCacheTTText="Clear Health Cache";
		Options_ClearPeerCacheTTText="Clear Peer Cache";
		Options_ClearCacheWarning="|cffff0000Warning! All data in this cache will be lost forever.|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="Blacklisted Mob";
		UITweaksTooltip_HealthRecorded="Recorded Health Data";
		UITweaksTooltip_HealthOverride="Health Data Overridden";
		UITweaksTooltip_NoData="Missing Health Data";

--		Numbers
		NumberGroupingScale=3;--	Controls scale of FIRST_NUMBER_CAP and SECOND_NUMBER_CAP
	};
	deDE={--	Translation by Figlmueller
--		Commands
		Command_NoUnitData="Einheit nicht gefunden.";
		Command_DeletedUnitFormat="%2$s(%1$s) gel�scht";--	format(CreatureKey,UnitName)
		Command_HealthWiped="Gesundheitspunkte gel�scht.";

--		Options Panel
		Options_DynamicList={--	Button Text,Tooltip Title,Description
--					Tooltip Title=false to use Button Text
			ShowStatusBarTextAdditions={"Text im Fenster der Zielauswahl anzeigen",false,"Erstellt einen Text innerhalb der Statusleisten der Zielauswahl."};
			ModifyHealthBarText={"Gesundheitspunkte des Einheitenfensters anpassen",false,"Zeigt errechnete Gesundheitspunkte f�r Mobs in normalen Einheitenfenstern."};
			ShowTooltipText={"Feedback-Tooltip anzeigen",false,"Zeigt an, ob die Gesundheitspunkte eines Mobs im Health-Cache vorhanden sind."};
			ShowTooltipHealthText={"Gesundheitspunkte-Tooltip anzeigen",false,"Zeigt die Gesundheitspunkte in der Statusleiste der Spieletooltips an."};
			ShowNamePlateHealthText={"Gesundheitspunkte auf Namensplaketten anzeigen",false,"Gesundheitspunkte links von Namensplaketten anzeigen."};

			EnablePeerCache={"Aktivieren","Peer-Cache aktivieren","Ausw�hlen um Gesundheitspunkte-Daten von anderen Spielern zu empfangen.\n|cffffff00Hinweis: Dieses Addon wird dennoch Anfragen anderer Spieler beantworten sowie Broadcasts an Spieler schicken.|r"};
		};
		Options_SetByAddOn="|cffff0000Diese Option wurde von einem anderen Addon �berschrieben.|r";

--		Options Cache Panels
		Options_HealthCachePanel={"Health-Cache","Speichert Gesundheitspunkte-Daten von begegneten Mobs."};
		Options_PeerCachePanel={"Peer-Cache","Speichert Gesundheitspunkte-Daten, welche von anderen Spielern gemeldet wurden."};
		Options_CacheSizeLabel="Cache-Gr��e:";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="Cache leeren";
		Options_ClearHealthCacheTTText="Health-Cache leeren";
		Options_ClearPeerCacheTTText="Peer-Cache leeren";
		Options_ClearCacheWarning="|cffff0000Achtung! Alle Daten in diesem Cache gehen endg�ltig verloren.|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="Ignorierter Mob";
		UITweaksTooltip_HealthRecorded="Gesundheitspunkte-Daten vorhanden";
		UITweaksTooltip_HealthOverride="Gesundheitspunkte-Daten �berschrieben";
		UITweaksTooltip_NoData="Fehlende Gesundheitspunkte-Daten";
	};
	frFR={--	Traduction by Pgmbru
--		Commandes
		Command_NoUnitData="Unité introuvable.";
		Command_DeletedUnitFormat="Supprimé %2$s(%1$s)";-- format (CreatureKey,UnitName)
		Command_HealthWiped="Données de santé effacées.";

--		Panneau d'options
		Options_DynamicList={--	Texte du bouton,titre de l'info-bulle,description
--					Titre de l'info-bulle=false pour utiliser le texte du bouton
			ShowStatusBarTextAdditions={"Afficher le texte dans le cadre cible",false,"Créer du texte pour les barres du cadre cible."};
			ModifyHealthBarText={"Modifier l'état de santé du cadre",false,"Affiche les valeurs de santé réelles pour les mobs dans les cadres par défaut."};
			ShowTooltipText={"Afficher les commentaires de l’info-bulle",false,"Indique si l’intégrité d’un groupe est présente dans le cache de santé."};
			ShowTooltipHealthText={"Afficher la santé de l'info-bulle",false,"Affiche la santé sur la barre d'état de l'info-bulle du jeu"};
			ShowNamePlateHealthText={"Afficher la santé de la plaquette de nom",false,"Affiche la santé sur le côté gauche de la plaquette de nom."};

			EnablePeerCache={"Activer","Activer le cache entre homologues","Activer / DésActiver la réception des données de santé des autres. \n|cffffff00Note: Cet addon répondra toujours aux requêtes et aux mises à jour de la santé.|r"};
		};

--		Panneaux de cache d'options
		Options_HealthCachePanel={"Cache de Santé","Stock des données de santé des mobs rencontrées."};
		Options_PeerCachePanel={"Cache des Pairs","Stock des données de santé déclarées par d'autres."};
		Options_CacheSizeLabel="Taille du cache:";

--		Options Effacer les boutons du cache
		Options_ClearCacheButtonText="Vider le cache";
		Options_ClearHealthCacheTTText="Effacer le cache de santé";
		Options_ClearPeerCacheTTText="Effacer le cache des pairs";
		Options_ClearCacheWarning="|cffff0000Attention! Toutes les données de ce cache seront définitivement perdues!|r";

--		Interface utilisateur Tooltip d'info-bulle
		UITweaksTooltip_Blacklisted="Mob sur la liste noire";
		UITweaksTooltip_HealthRecorded="Données de santé enregistrées";
		UITweaksTooltip_HealthOverride="Données de santé annulées";
		UITweaksTooltip_NoData="Données de santé manquantes";
	};
	koKR={--	Translation by chkid
--		Commands
		Command_NoUnitData="유닛을 찾을 수 없습니다.";
		Command_DeletedUnitFormat="삭제: %2$s(%1$s)";--	format(CreatureKey,UnitName)
		Command_HealthWiped="생명력 데이터가 삭제되었습니다.";

--		Options Panel
		Options_DynamicList={--	Buttom Text, Tooltip Title, Description
--					Tooltip Title = false to use Button Text
			ShowStatusBarTextAdditions={"대상 창에 글자 표시",false,"대상 창에 생명력 정보를 표시합니다."};
			ModifyHealthBarText={"유닛프레임에 생명력 표시",false,"유닛프레임에 실제 생명력을 표시합니다."};
			ShowTooltipText={"툴팁 정보 표시",false,"생명력 정보에 저장되어 있는지 여부를 툴팁에 표시합니다."};
			ShowTooltipHealthText={"툴팁에 생명력 표시",false,"게임툴팁의 상태바에 생명력을 표시합니다."};
			ShowNamePlateHealthText={"이름표에 생명력 표시",false,"이름표의 왼쪽부분에 생명력을 표시합니다."};

			EnablePeerCache={"Enable","Enable Peer Cache","Toggles receiving health data from others.\n|cffffff00Note: This addon will still answer queries and broadcast health updates.|r"};
		};

--		Options Cache Panels
		Options_HealthCachePanel={"생명력 정보","확인된 생명력 정보를 저장합니다."};
		Options_PeerCachePanel={"주변 정보","주변의 캐릭터에서 확인된 생명력 정보를 저장합니다."};
		Options_CacheSizeLabel="저장 갯수:";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="데이터 초기화";
		Options_ClearHealthCacheTTText="데이터를 초기화 합니다.";
		Options_ClearPeerCacheTTText="주변 데이터 초기화";
		Options_ClearCacheWarning="|cffff0000경고! 모든 데이터를 삭제하며, 복원할 수 없습니다.|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="블랙리스트된 몹";
		UITweaksTooltip_HealthRecorded="생명력 데이터 저장됨";
		UITweaksTooltip_HealthOverride="생명력 데이터 중단됨";
		UITweaksTooltip_NoData="생명력 데이터 없음";

--		Numbers
		NumberGroupingScale=4;--	Controls scale of FIRST_NUMBER_CAP and SECOND_NUMBER_CAP
	};
	zhCN={--	Translation by HopeASD
		Command_NoUnitData="单位未找到";
		Command_DeletedUnitFormat="已删除 %2$s(%1$s)";--	format(CreatureKey,UnitName)
		Command_HealthWiped="清空生命值数据。";

--		Options Panel
		Options_DynamicList={--	Buttom Text, Tooltip Title, Description
--					Tooltip Title = false to use Button Text
			ShowStatusBarTextAdditions={"目标框体上显示数值",false,"在原生目标框体的条上创建数值文字。\n|cffffff00注意：这个选项的功能是将 esc > 界面选项 > 显示 > 状态数值 的设定应用到自己以外的头像框架上。|r"};
			ModifyHealthBarText={"调整单位框体生命值格式",false,"在原生单位框体上显示真实的生命值。\n|cffffff00注意：默认只支援暴雪原生框体。其他插件要由各插件作者自行添加对RealMobHealth的支持，方法可以查看APIDoc.txt。|r"};
			ShowTooltipText={"鼠标提示上显示反馈",false,"在鼠标提示上显示是否存在生命值数据。"};
			ShowTooltipHealthText={"鼠标提示上显示生命值",false,"在你的鼠标提示的状态条上显示生命值。"};
			ShowNamePlateHealthText={"姓名版上显示生命值",false,"在姓名版的左侧显示生命值。\n|cffffff00注意：默认只支援暴雪姓名板。其他插件要由作者自行添加对RealMobHealth的支持，方法可以查看APIDoc.txt。|r"};

			EnablePeerCache={"开启","开启共享缓存","开启这个选项将尝试从其他安装此插件的玩家处获取缓存。\n|cffffff00Note: 开启后，本插件将会不停的尝试询问和接受其他玩家的缓存数据。|r"};
		};
		Options_SetByAddOn="|cffff0000这个选项被其他来源给覆盖了。|r";

--		Options Cache Panels
		Options_HealthCachePanel={"生命值缓存","存储遇到的怪物的生命值数据。"};
		Options_PeerCachePanel={"共享缓存","存储其他人共享过来的生命值数据。"};
		Options_CacheSizeLabel="缓存大小：";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="清除缓存";
		Options_ClearHealthCacheTTText="清除生命值缓存";
		Options_ClearPeerCacheTTText="清除共享缓存";
		Options_ClearCacheWarning="|cffff0000警告！所有的缓存数据将被永久清除。|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="黑名单中的怪物";
		UITweaksTooltip_HealthRecorded="生命值数据 已记录";
		UITweaksTooltip_HealthOverride="生命值数据 被覆盖";
		UITweaksTooltip_NoData="生命值数据 不存在";

--		Numbers
		NumberGroupingScale=4;--	Controls scale of FIRST_NUMBER_CAP and SECOND_NUMBER_CAP
	};
	zhTW={--	Translation by EKE00372
--		Commands
		Command_NoUnitData="未找到目標";
		Command_DeletedUnitFormat="刪除%2$s（%1$s）";--	format(CreatureKey,UnitName)
		Command_HealthWiped="血量資料已重置";

--		Options Panel
		Options_DynamicList={--	Button Text,Tooltip Title,Description
--					Tooltip Title=false to use Button Text
			ShowStatusBarTextAdditions={"顯示目標狀態數值",false,"在目標頭像的血量條上創建生命值文本。\n|cffffff00注意：這個選項的功能是將 esc > 介面選項 > 顯示 > 狀態數值 的設定應用到自己以外的頭像框架上。|r"};
			ModifyHealthBarText={"在單位框架上顯示真實血量",false,"在暴雪頭像上顯示真實的血量數值。\n|cffffff00注意：預設只支援暴雪頭像。其他插件要由作者自行添加對RealMobHealth的支援，方法可以查看APIDoc.txt。|r"};
			ShowTooltipText={"提示是否已快取",false,"在滑鼠提示上顯示你指向的單位是否已有快取資料。"};
			ShowTooltipHealthText={"顯示於滑鼠提示",false,"在滑鼠提示的血量條上顯示真實血量。"};
			ShowNamePlateHealthText={"顯示於名條",false,"在名條的左側顯示真實血量。\n|cffffff00注意：預設只支援暴雪名條。其他插件要由作者自行添加對RealMobHealth的支援，方法可以查看APIDoc.txt。|r"};

			EnablePeerCache={"啟用","啟用快取共享","啟用後，從其他使用RealMobHealth的玩家那裡取得他們快取的血量資料。\n|cffffff00注意：啟用這項功能後插件會持續雙向溝通，共享自己的資料並請求他人的資料。|r"};
		};
		Options_SetByAddOn="|cffff0000這個選項的設定被其他插件覆寫了。|r";

--		Options Cache Panels
		Options_HealthCachePanel={"血量快取","將你遭遇過的敵人的血量資料儲存起來。"};
		Options_PeerCachePanel={"分享快取","儲存其他人分享給你的血量資料。"};
		Options_CacheSizeLabel="已快取：";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="清除快取";
		Options_ClearHealthCacheTTText="清除血量快取資料";
		Options_ClearPeerCacheTTText="清除分享的快取資料";
		Options_ClearCacheWarning="|cffff0000警告！所有的快取資料都會被刪除。|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="排除紀錄的單位";
		UITweaksTooltip_HealthRecorded="已取得真實血量";
		UITweaksTooltip_HealthOverride="血量數值被覆寫";
		UITweaksTooltip_NoData="尚未取得真實血量";

--		Numbers
		NumberGroupingScale=4;--	Controls scale of FIRST_NUMBER_CAP and SECOND_NUMBER_CAP
	};
};

----------------------------------
--[[	Localization Loader	]]--	Nothing to localize below this line
----------------------------------
local LocalizationMeta={__index=Localization.enUS};
local DynamicOptionsMeta={__index=Localization.enUS.Options_DynamicList};
for locale,tbl in pairs(Localization) do if locale~="enUS" then
	setmetatable(tbl,LocalizationMeta);
	if rawget(tbl,"Options_DynamicList") then setmetatable(tbl.Options_DynamicList,DynamicOptionsMeta); end
end end
select(2,...).Localization=setmetatable(Localization,{__index=function(t,k) return t.enUS; end})[GetLocale()];
