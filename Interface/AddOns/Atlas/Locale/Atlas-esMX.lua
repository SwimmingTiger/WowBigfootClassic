-- $Id: Atlas-esMX.lua 374 2022-01-26 14:33:01Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas", "esMX", false);

-- Atlas Spanish (Mexico) Localization
-- Traducido por --> maqjav|Marosth de Tyrande<--
-- maqjav@gmail.com
-- Última Actualización (last update): 05/12/2015

-- Atlas Spanish (Mexico) Localization
if ( GetLocale() == "esMX" ) then
-- Define the leading strings to be ignored while sorting
-- Ex: The Stockade
AtlasSortIgnore = {"the (.+)"};

-- Syntax: ["real_zone_name"] = "localized map zone name"
AtlasZoneSubstitutions = {
	["Ahn'Qiraj"] = "Templo de Ahn'Qiraj";
	["The Temple of Atal'Hakkar"] = "El Templo de Atal'Hakkar";
--	["Throne of Tides"] = "Fauce Abisal: Trono de las Mareas";
};
end


if L then
L["Adult"] = "Adulto"
L["AKA"] = "AKA"
L["Alexston Chrome <Tavern of Time>"] = "Alexston Cromo <La Taberna del Tiempo>"
L["Alurmi <Keepers of Time Quartermaster>"] = "Alurmi <Intendente de los Vigilantes del Tiempo>"
L["Anachronos <Keepers of Time>"] = "Anacronos <Vigilantes del Tiempo>"
L["Andormu <Keepers of Time>"] = "Andormu <Vigilantes del Tiempo"
L["Arazmodu <The Scale of Sands>"] = "Arazmodu <La Escama de las Arenas>"
L["Arcane Container"] = "Contenedor Arcano"
L["Arms Warrior"] = "Guerrero Armas"
L["ATLAS_BUTTON_CLOSE"] = "Cerrar"
L["ATLAS_CLICK_TO_OPEN"] = "Click para abrir el mapa de Atlas."
L["ATLAS_COLLAPSE_BUTTON"] = "Click para cerrar el panel de Atlas's legend."
L["ATLAS_DDL_CONTINENT"] = "Continente"
L["ATLAS_DDL_CONTINENT_BROKENISLES"] = "Mazmorras de las Islas Abruptas"
L["ATLAS_DDL_CONTINENT_BROKENISLES1"] = "Dungeon de Islas Quebradas"
L["ATLAS_DDL_CONTINENT_DEEPHOLM"] = "Mazmorras de Infralar"
L["ATLAS_DDL_CONTINENT_DRAENOR"] = "Mazmorras de Draenor"
L["ATLAS_DDL_CONTINENT_EASTERN"] = "Mazmorras de los Reinos del Este"
L["ATLAS_DDL_CONTINENT_KALIMDOR"] = "Mazmorras de Kalimdor"
L["ATLAS_DDL_CONTINENT_NORTHREND"] = "Mazmorras de Rasganorte"
L["ATLAS_DDL_CONTINENT_OUTLAND"] = "Mazmorras de Terrallende"
L["ATLAS_DDL_CONTINENT_PANDARIA"] = "Mazmorras de Pandaria"
L["ATLAS_DDL_EXPANSION"] = "Expansión"
L["ATLAS_DDL_EXPANSION_BC"] = "Mazmorras de Burning Crusade"
L["ATLAS_DDL_EXPANSION_CATA"] = "Mazmorras de Cataclysm"
L["ATLAS_DDL_EXPANSION_LEGION"] = "Mazmorras de Legion"
L["ATLAS_DDL_EXPANSION_LEGION1"] = "Calabozo Legion"
L["ATLAS_DDL_EXPANSION_LEGION2"] = "Raid de Legion"
L["ATLAS_DDL_EXPANSION_MOP"] = "Mazmorras de Mists of Pandaria"
L["ATLAS_DDL_EXPANSION_OLD"] = "Antiguas Mazmorras"
L["ATLAS_DDL_EXPANSION_WOD"] = "Mazmorras de Warlords of Draenor"
L["ATLAS_DDL_EXPANSION_WOTLK"] = "Mazmorras Wrath of the Lich King"
L["ATLAS_DDL_LEVEL"] = "Nivel"
L["ATLAS_DDL_LEVEL_100PLUS"] = "Mazmorras de nivel 100+"
L["ATLAS_DDL_LEVEL_100TO110"] = "Mazmorras de nivel 100-110"
L["ATLAS_DDL_LEVEL_110PLUS"] = "Mazmorras de nivel 110+"
L["ATLAS_DDL_LEVEL_45TO60"] = "Mazmorras de nivel 45-60"
L["ATLAS_DDL_LEVEL_60TO70"] = "Mazmorras de nivel 60-70"
L["ATLAS_DDL_LEVEL_70TO80"] = "Mazmorras de nivel 70-80"
L["ATLAS_DDL_LEVEL_80TO85"] = "Mazmorras de nivel 80-85"
L["ATLAS_DDL_LEVEL_85TO90"] = "Mazmorras de nivel 85-90"
L["ATLAS_DDL_LEVEL_90TO100"] = "Mazmorras de nivel 90-100"
L["ATLAS_DDL_LEVEL_UNDER45"] = "Mazmorras de nivel inferior a 45"
L["ATLAS_DDL_PARTYSIZE"] = "Tamaño de la party"
L["ATLAS_DDL_PARTYSIZE_10"] = "Mazmorras para 10 jugadores"
L["ATLAS_DDL_PARTYSIZE_20TO40"] = "Mazmorras para 20-40 jugadores"
L["ATLAS_DDL_PARTYSIZE_5"] = "Mazmorras para 5 jugadores"
L["ATLAS_DDL_TYPE"] = "Tipo"
L["ATLAS_DDL_TYPE_ENTRANCE"] = "Entradas"
L["ATLAS_DDL_TYPE_INSTANCE"] = "Mazmorras"
L["ATLAS_DEP_MSG1"] = "Atlas ha detectado uno o varios modulos sin actualizar."
L["ATLAS_DEP_MSG2"] = "Se han sido desactivados para este personaje."
L["ATLAS_DEP_MSG3"] = "Borralos de tu directorio AddOns."
L["ATLAS_DEP_OK"] = "Vale"
L["ATLAS_ENTRANCE_BUTTON"] = "Entrada"
L["ATLAS_EXPAND_BUTTON"] = "Click para abrir el panel de Atlas' legend."
L["ATLAS_INFO"] = "Información de Atlas"
L["ATLAS_INFO_12200"] = [=[Aviso importante:

Debido al aumento del tamaño en los 
archivos de este accesorio, se han separado parte de los mapas de mazmorras, 
y otros accesorios internos en módulos separados.

Los usuarios que descarguen este accesorio desde conocidas páginas web obtendrán 
únicamente el núcleo del accesorio, el cual solo contiene la función del núcleo 
y los mapas de la última expansión.

Los usuarios que también quieran descargar los mapas de las mazmorras antiguas y 
los mapas de todos los plug-ins 
de Atlas hechos por nosotros, tendrán que 
descargarselos por separado.

Para mas información accede a:
http://www.atlasmod.com/phpBB3/viewtopic.php?t=1522]=]
L["ATLAS_INFO_12201"] = [=[Te informamos de que hemos creado un nuevo plug-in - |cff6666ffAtlas Escenarios|cffffffff, 
que contiene los nuevos mapas de los escenarios introducidos en WoW 5.0. 

Para mas detalles aacede a nuestra web, y no olvides de descargarlo / 
instalarlo por separado.
|cff6666ffhttp://www.atlasmod.com/|cffffffff]=]
L["ATLAS_INSTANCE_BUTTON"] = "Mazmorra"
L["ATLAS_LDB_HINT"] = [=[Click izquierdo para abrir Atlas.
Click central para opciones.
Click derecho para mostrar el menú.]=]
L["ATLAS_MINIMAPLDB_HINT"] = [=[Click izquierdo para abrir Atlas.
Click derecho para mostrar las opciones.
Click izquierdo y arrastrar para mover este botón.]=]
L["ATLAS_MISSING_MODULE"] = "Atlas has detected missing module(s) / plugin(s): "
L["ATLAS_OPEN_ADDON_LIST"] = "Abrir lista de addon."
L["ATLAS_OPEN_ADVENTURE"] = "Click para abrir la ventana de la Guía de mazmorras."
L["ATLAS_OPTIONS_ACRONYMS"] = "Mostrar acrónimos"
L["ATLAS_OPTIONS_ACRONYMS_TIP"] = "Muestra el acrónimo de la mazmorra en los detalles del mapa."
L["ATLAS_OPTIONS_AUTOSEL"] = "Auto-Seleccionar mazmorra"
L["ATLAS_OPTIONS_AUTOSEL_TIP"] = "Auto seleccionar mapa de mazmorra. Atlas detectará tu posición y elegirá mostrarte el mapa mas idóneo."
L["ATLAS_OPTIONS_BOSS_DESC"] = "Muestra la descripción del jefe cuando este disponible"
L["ATLAS_OPTIONS_BOSS_DESC_SCALE"] = "Escala de las ventanitas con la descripción del jefe en el mapa"
L["ATLAS_OPTIONS_BOSS_DESC_TIP"] = "Cuando pasas el ratón por encima del número del jefe, muestra la descripción del jefe si la información está disponible."
L["ATLAS_OPTIONS_BUTPOS"] = "Posición del icono"
L["ATLAS_OPTIONS_BUTRAD"] = "Radio del botón"
L["ATLAS_OPTIONS_BUTTON"] = "Opciones"
L["ATLAS_OPTIONS_CATDD"] = "Ordenar los mapas de mazmorra por:"
L["ATLAS_OPTIONS_CHECKMODULE"] = "Recuérdame que módulo(s) / plug-in(s) falta(n)."
L["ATLAS_OPTIONS_CHECKMODULE_TIP"] = "Activar para comprobar si falta algún módulo / plug-in de Atlas después del inicio de WoW."
L["ATLAS_OPTIONS_CLAMPED"] = "Ajustar ventana a la pantalla"
L["ATLAS_OPTIONS_CLAMPED_TIP"] = "Fija la ventana de Atlas. Desactiva el poder mover la ventana de Atlas fuera de la pantalla del juego."
L["ATLAS_OPTIONS_COLORINGDROPDOWN"] = "Mostrar listado de mazmorras con colores"
L["ATLAS_OPTIONS_COLORINGDROPDOWN_TIP"] = "Muestra con colores el nivel de dificultad de la mazmorra, basándose en el nivel mínimo recomendado de la mazmorra y en el nivel del personaje. "
L["ATLAS_OPTIONS_CTRL"] = "Pulsar control para ver las herramientas"
L["ATLAS_OPTIONS_CTRL_TIP"] = "Activa mostrar ventanas emergentes de texto mientras pulsas Ctrl y pasas el ratón por encima de la información del mapa. Es util cuando el texto es demasiado largo y no se puede mostrar en la ventana."
L["ATLAS_OPTIONS_DONTSHOWAGAIN"] = "No mostrar la misma información de nuevo."
L["ATLAS_OPTIONS_LOCK"] = "Bloquea la ventana de Atlas"
L["ATLAS_OPTIONS_LOCK_TIP"] = "Bloquea / desbloquea la ventana de Atlas."
L["ATLAS_OPTIONS_RCLICK"] = "Botón derecho para mapa del mundo"
L["ATLAS_OPTIONS_RCLICK_TIP"] = "Activa click derecho en la ventana del Atlas para cambiar al mapa del mundo."
L["ATLAS_OPTIONS_RESETPOS"] = "Resetear posición"
L["ATLAS_OPTIONS_SCALE"] = "Escala"
L["ATLAS_OPTIONS_SHOWBUT"] = "Mostrar botón en el minimapa"
L["ATLAS_OPTIONS_SHOWBUT_TIP"] = "Muestra el botón de Atlas en el minimapa."
L["ATLAS_OPTIONS_TRANS"] = "Transparencia"
L["ATLAS_SEARCH_UNAVAIL"] = "Buscar no disponible"
L["ATLAS_SLASH"] = "/atlas"
L["ATLAS_SLASH_OPTIONS"] = "opciones"
L["ATLAS_STRING_CLEAR"] = "Limpiar"
L["ATLAS_STRING_LEVELRANGE"] = "Rango de nivel"
L["ATLAS_STRING_LOCATION"] = "Localización"
L["ATLAS_STRING_MINLEVEL"] = "Nivel mínimo"
L["ATLAS_STRING_PLAYERLIMIT"] = "Límite de Jugadores"
L["ATLAS_STRING_RECLEVELRANGE"] = "Rng. nivel"
L["ATLAS_STRING_SEARCH"] = "Buscar"
L["ATLAS_STRING_SELECT_CAT"] = "Seleccionar Categoría"
L["ATLAS_STRING_SELECT_MAP"] = "Seleccionar Mapa"
L["ATLAS_TITLE"] = "Atlas"
L["Attunement Required"] = "Armonización requerida"
L["Back"] = "Atras"
L["Basement"] = "Sótano"
L["BINDING_HEADER_ATLAS_TITLE"] = "Enlaces Atlas"
L["BINDING_NAME_ATLAS_AUTOSEL"] = "Auto-Selecciona"
L["BINDING_NAME_ATLAS_OPTIONS"] = "Opciones de la Barra"
L["BINDING_NAME_ATLAS_TOGGLE"] = "Barra del Atlas"
L["Blacksmithing Plans"] = "Planos de herrero"
L["Bodley"] = "Bodley"
L["Bortega <Reagents & Poison Supplies>"] = "Bortega <Suministros de venenos y componentes>"
L["Brewfest"] = "Festival de la cerveza"
L["Child"] = "Niño"
L["Colon"] = ": "
L["Comma"] = ","
L["Connection"] = "Conexión"
L["East"] = "Este"
L["Elevator"] = "Ascensor"
L["End"] = "Fin"
L["Engineer"] = "Ingeniero"
L["Entrance"] = "Entrada"
L["Event"] = "Evento"
L["Exalted"] = "Exaltado"
L["Exit"] = "Salida"
L["Fourth Stop"] = "Cuarta parada"
L["Front"] = "Frente"
L["Galgrom <Provisioner>"] = "Galgrom <Galgrom>"
L["Ghost"] = "Fantasma"
L["Graveyard"] = "Cementerio"
L["Hallow's End"] = "Halloween"
L["Heroic"] = "Heróico"
L["Holy Paladin"] = "Paladín Sagrado"
L["Holy Priest"] = "Sacerdote Sagrado"
L["Imp"] = "Duendecillo"
L["Key"] = "Llave"
L["Lothos Riftwaker"] = "Lothos Levantagrietas"
L["Love is in the Air"] = "Amor en el aire"
L["Lower"] = "Abajo"
L["Lunar Festival"] = "Festival lunar"
L["MapA"] = " [A]"
L["MapB"] = " [B]"
L["MapC"] = " [C]"
L["MapD"] = " [D]"
L["MapE"] = " [E]"
L["MapF"] = " [F]"
L["MapsNotFound"] = [=[La mazmorra actual no dispone de su 
imagen de mapa correspondiente. 

Por favor, asegurate de tener instalado 
el módulo(s) de mapas Atlas correspondiente.]=]
L["Meeting Stone"] = "Piedra de encuentro"
L["Middle"] = "Medio"
L["Midsummer Festival"] = "Festival del solsticio de verano"
L["Moonwell"] = "Claro de la luna"
L["North"] = "Norte"
L["Nozari <Keepers of Time>"] = "Nozari <Vigilantes del Tiempo>"
L["Optional"] = "Opcional"
L["Orange"] = "Naranja"
L["Orb of Command"] = "Orbe de orden"
L["Outside"] = "Fuera"
L["Portal"] = "Portal"
L["PossibleMissingModule"] = "Posiblemente este mapa es de este módulo: "
L["Protection Warrior"] = "Guerrero Protección"
L["Purple"] = "Morado"
L["Random"] = "Aleatorio"
L["Rare"] = "Raro"
L["R-DQuote"] = "''"
L["Repair"] = "Reparar"
L["Retribution Paladin"] = "Paladín Reprensión"
L["Rewards"] = "Recompensas"
L["Scarshield Quartermaster <Scarshield Legion>"] = "Intendente del Escudo del Estigma <Legión Escudo del Estigma>"
L["Second Stop"] = "Segunda parada"
L["Shadow Priest"] = "Sacerdote Sombras"
L["Slash"] = "/"
L["Soridormi <The Scale of Sands>"] = "Soridormi <La Escama de las Arenas>"
L["South"] = "Sur"
L["Spawn Point"] = "Punto de aparición"
L["Start"] = "Comienzo"
L["Steward of Time <Keepers of Time>"] = "Administrador del Tiempo <Vigilantes del Tiempo>"
L["Summon"] = "Invocar"
L["Teleporter"] = "Teletransportador"
L["Teleporter destination"] = "Teletransportador de destino"
L["The Behemoth"] = "El Behemoth"
L["Third Stop"] = "Tercera parada"
L["Top"] = "Arriba"
L["Transport"] = "Transporte"
L["Tunnel"] = "Túnel"
L["Underwater"] = "Bajo el agua"
L["Upper"] = "Arriba"
L["Upper floor"] = "Piso superior"
L["Varies"] = "Varios"
L["Wanders"] = "Rondando"
L["Wave 10"] = "Ola 10"
L["Wave 12"] = "Ola 12"
L["Wave 18"] = "Ola 18"
L["Wave 5"] = "Ola 5"
L["Wave 6"] = "Ola 6"
L["West"] = "Oeste"
L["Yarley <Armorer>"] = "Yarley <Armero>"
L["Zaladormu"] = "Zaladormu"

end
