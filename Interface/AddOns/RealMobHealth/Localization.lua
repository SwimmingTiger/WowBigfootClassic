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
	esES={--	Translation by Lynk_One
--		Commands
		Command_NoUnitData="No se encuentra la unidad.";
		Command_DeletedUnitFormat="Borrado %2$s(%1$s)";--	format(CreatureKey,UnitName)
		Command_HealthWiped="Datos de vida borrados.";

--		Options Panel
		Options_DynamicList={--	Button Text,Tooltip Title,Description
--					Tooltip Title=false to use Button Text
			ShowStatusBarTextAdditions={"Mostrar texto en el Marco del Objetivo",false,"Crea un texto para las barras del marco del objetivo."};
			ModifyHealthBarText={"Modificar vida en los marcos de unidad",false,"Muestra valores reales de salud de criaturas en los marcos de unidad por defecto."};
			ShowTooltipText={"Mostrar Feedback en Tooltip",false,"Muestra si la salud de la criatura se encuentra en caché."};
			ShowTooltipHealthText={"Mostrar Salud en el Tooltip",false,"Muestra la salud en el Tooltip del juego."};
			ShowNamePlateHealthText={"Mostrar vida en las Placas de Nombres",false,"Muestra la vida en el lado izquierdo de las Placas de Nombres."};

			EnablePeerCache={"Activar","Activar caché de pares","Activas recibir información de salud de otros.\n|cffffff00Nota: Este addon continuará contestando consultas y emitiendo actualizaciones de salud.|r"};
		};
		Options_SetByAddOn="|cffff0000Esta opción ha sido anulada por otro addon.|r";

--		Options Cache Panels
		Options_HealthCachePanel={"Caché de Salud","Guarda datos de salud de las criaturas encontradas."};
		Options_PeerCachePanel={"Caché de àres","Guarda datos de salud reportados por otros."};
		Options_CacheSizeLabel="Caché de pares:";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="Limpiar Caché";
		Options_ClearHealthCacheTTText="Limpia la Caché de salud";
		Options_ClearPeerCacheTTText="Limpiar la Caché de pares";
		Options_ClearCacheWarning="|cffff0000Atención! Todos los datos de esta caché se perderán para siempre.|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="Lista negra de criaturas";
		UITweaksTooltip_HealthRecorded="Datos de salud Guardados";
		UITweaksTooltip_HealthOverride="Health Data Overridden";
		UITweaksTooltip_NoData="No hay datos de Salud";
	};
	deDE={--	Translation by Figlmueller (Revised by Dathwada)
--		Commands
		Command_NoUnitData="keine Einheit gefunden.";
		Command_DeletedUnitFormat="%2$s(%1$s) gelöscht";-- format(CreatureKey,UnitName)
		Command_HealthWiped="Alle aufgezeichneten Gesundheitsdaten wurden gelöscht.";

--		Options Panel
		Options_DynamicList={--	Button Text,Tooltip Title,Description
--				Tooltip Title=false to use Button Text
			ShowStatusBarTextAdditions={"Zeige Text im Zielfenster",false,"Erstellt Text für das Zielfenster."};
			ModifyHealthBarText={"Ändere den Gesundheitszustand im Einheitenfenster",false,"Zeigt reale Gesundheitswerte für Mobs in Standard-Einheitenfenster an."};
			ShowTooltipText={"Zeige Feedback im Tooltip",false,"Zeigt an, ob die Gesundheit eines Mobs im Gesundheits-Cache vorhanden ist."};
			ShowTooltipHealthText={"Zeige den Gesundheitszustand im Tooltip",false,"Zeigt den Zustand in der Statusleiste von GameTooltip an."};
			ShowNamePlateHealthText={"Zeige den Gesundheitszustand an Namensplaketten",false,"Zeigt den Gesundheitszustand auf der linken Seite der Namensplaketten an."};

			EnablePeerCache={"Aktivieren","Aktiviere Peer-Cache","Schaltet den Empfang von Gesundheitsdaten anderer ein.\n|cffffff00Hinweis: Dieses Addon beantwortet weiterhin Anfragen und sendet Statusaktualisierungen.|r"};
		};
		Options_SetByAddOn="|cffff0000Diese Option wurde von einem anderen Addon überschrieben.|r";

--		Options Cache Panels
		Options_HealthCachePanel={"Gesundheits-Cache","Speichert Gesundheitsdaten von bekämpften Mobs."};
		Options_PeerCachePanel={"Peer-Cache","Speichert von anderen gemeldete Gesundheitsdaten."};
		Options_CacheSizeLabel="Cache größe:";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="Lösche Cache";
		Options_ClearHealthCacheTTText="Lösche Gesundheits-Cache";
		Options_ClearPeerCacheTTText="Lösche Peer-Cache";
		Options_ClearCacheWarning="|cffff0000Warnung! Alle Daten in diesem Cache gehen für immer verloren.|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="Mob ist auf der schwarzen Liste";
		UITweaksTooltip_HealthRecorded="Aufgezeichnete Gesundheitsdaten";
		UITweaksTooltip_HealthOverride="Gesundheitsdaten überschrieben";
		UITweaksTooltip_NoData="Fehlende Gesundheitsdaten";
	};
	frFR={--	Translation by Pgmbru
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
	ruRU={--	Translation by vAlshebnik
--		Commands
		Command_NoUnitData="Юнит не найден";
		Command_DeletedUnitFormat="Удален юнит %2$s(%1$s)";--	format(CreatureKey,UnitName)
		Command_HealthWiped="Данные здоровья удалены.";
 
--		Options Panel
		Options_DynamicList={--	Button Text,Tooltip Title,Description
--				Tooltip Title=false to use Button Text
			ShowStatusBarTextAdditions={"Показывать текст на рамке цели",false,"Создает текст для полоски здоровья на рамке цели."};
			ModifyHealthBarText={"Изменять здоровье на рамке цели",false,"Показывает реальные значения здоровья на рамке цели."};
			ShowTooltipText={"Показывать состояние в подсказке",false,"Показывает, есть ли здоровье моба в кэше здоровья."};
			ShowTooltipHealthText={"Показывать здоровье в подсказке",false,"Показывает здоровье цели на полоске здоровья в подсказке."};
			ShowNamePlateHealthText={"Показывать здоровье на шкале здоровья",false,"Показывает текущее здоровье цели на левой стороне шкалы здоровья."};

			EnablePeerCache={"Включить","Включить Кэш Пиров","Вкл/Выкл получение информации о здоровье мобов от других игроков.\n|cffffff00Примечание: Этот аддон все равно будет передавать новые данные о здоровье мобов другим игрокам.|r"};
		};
		Options_SetByAddOn="|cffff0000Эта опция была перезаписана другим аддоном.|r";
 
--		Options Cache Panels
		Options_HealthCachePanel={"Кэш Здоровья","Хранит информацию о здоровье известных вам мобов."};
		Options_PeerCachePanel={"Кэш Пиров","Хранит информацию о здоровье, сообщенную другими игроками."};
		Options_CacheSizeLabel="Размер кэша:";

--		Options Clear Cache Buttons
		Options_ClearCacheButtonText="Очистить Кэш";
		Options_ClearHealthCacheTTText="Очистить Кэш Здоровья";
		Options_ClearPeerCacheTTText="Очистить Кэш Пиров";
		Options_ClearCacheWarning="|cffff0000Внимание! Все данные в этом кэше будут потеряны навсегда.|r";

--		UITweaks Tooltip Lines
		UITweaksTooltip_Blacklisted="Моб в черном списке";
		UITweaksTooltip_HealthRecorded="Записаны данные здоровья";
		UITweaksTooltip_HealthOverride="Данные о здоровье перезаписаны";
		UITweaksTooltip_NoData="Нет данных о здоровье";
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
