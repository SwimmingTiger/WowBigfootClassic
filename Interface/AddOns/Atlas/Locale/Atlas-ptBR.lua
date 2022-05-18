-- $Id: Atlas-ptBR.lua 374 2022-01-26 14:33:01Z arithmandar $
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
local L = AceLocale:NewLocale("Atlas", "ptBR", false);
-- Localize file must set above to false, for example:
--    local AL = AceLocale:NewLocale("Atlas", "deDE", false);

-- Atlas English Localization
if ( GetLocale() == "ptBR" ) then
-- Define the leading strings to be ignored while sorting
-- Ex: The Stockade
--AtlasSortIgnore = {"the (.+)"};

-- Syntax: ["real_zone_name"] = "localized map zone name"
AtlasZoneSubstitutions = {
--	["Ahn'Qiraj"] = "Temple of Ahn'Qiraj";
--	["The Temple of Atal'Hakkar"] = "Sunken Temple";
--	["Throne of Tides"] = "The Abyssal Maw: Throne of the Tides";
};
end


if L then
L["Adult"] = "Adulto"
L["AKA"] = "Conhecido como"
L["Arms Warrior"] = "Guerreiro Armas"
L["ATLAS_CLICK_TO_OPEN"] = "Clique para abrir a janela do mapa do Atlas."
L["ATLAS_COLLAPSE_BUTTON"] = "Clique para fechar o painel de legendas do Atlas."
L["ATLAS_DDL_CONTINENT"] = "Continente"
L["ATLAS_DDL_CONTINENT_DEEPHOLM"] = "Masmorras de Geodomo"
L["ATLAS_DDL_CONTINENT_DRAENOR"] = "Instâncias de Draenor"
L["ATLAS_DDL_CONTINENT_EASTERN"] = "Masmorras dos Reinos do Leste"
L["ATLAS_DDL_CONTINENT_KALIMDOR"] = "Masmorras de Kalimdor"
L["ATLAS_DDL_CONTINENT_NORTHREND"] = "Masmorras de Nortúndria"
L["ATLAS_DDL_CONTINENT_OUTLAND"] = "Masmorras de Terralém"
L["ATLAS_DDL_CONTINENT_PANDARIA"] = "Instâncias de Pandaria"
L["ATLAS_DDL_EXPANSION"] = "Expansão"
L["ATLAS_DDL_EXPANSION_BC"] = "Masmorras de Burning Crusade"
L["ATLAS_DDL_EXPANSION_CATA"] = "Masmorras do Cataclisma"
L["ATLAS_DDL_EXPANSION_WOTLK"] = "Instância de Wrath of the Lich King"
L["ATLAS_DDL_LEVEL"] = "Nível"
L["ATLAS_DDL_LEVEL_100PLUS"] = "Instâncias de Nível 100+"
L["ATLAS_DDL_LEVEL_100TO110"] = "Instâncias de Nível 100-110"
L["ATLAS_DDL_LEVEL_110PLUS"] = "Instâncias de Nível 110+"
L["ATLAS_DDL_LEVEL_45TO60"] = "Nível das Instâncias 45-60"
L["ATLAS_DDL_LEVEL_60TO70"] = "Nível das Instâncias 60-70"
L["ATLAS_DDL_LEVEL_70TO80"] = "Nível das Instâncias 70-80"
L["ATLAS_DDL_LEVEL_80TO85"] = "Nível das Instâncias 80-85"
L["ATLAS_DDL_LEVEL_85TO90"] = "Instâncias de Nível 85-90"
L["ATLAS_DDL_LEVEL_90TO100"] = "Instâncias de Nível 90-100"
L["ATLAS_DDL_LEVEL_UNDER45"] = "Instâncias abaixo do Nível 45"
L["ATLAS_DDL_PARTYSIZE"] = "Tamanho do Grupo"
L["ATLAS_DDL_TYPE"] = "Tipo"
L["ATLAS_DDL_TYPE_ENTRANCE"] = "Entradas"
L["ATLAS_DEP_MSG1"] = "O Atlas detectou módulo(s) desatualizado(s)."
L["ATLAS_DEP_OK"] = "Ok!"
L["ATLAS_ENTRANCE_BUTTON"] = "Entrada"
L["ATLAS_EXPAND_BUTTON"] = "Clique para abrir o painel de legendas do Atlas."
L["ATLAS_INFO"] = "Informações do Atlas"
L["ATLAS_INSTANCE_BUTTON"] = "Instância"
L["ATLAS_LDB_HINT"] = [=[Clique com o botão esquerdo para abrir o Atlas.
Clique com o botão direito para abrir as opções do Atlas.]=]
L["ATLAS_MINIMAPLDB_HINT"] = [=[Clique com o botão esquerdo para abrir o Atlas.
Clique com o botão direito para as opções do Atlas.
Clique com o botão esquerdo e arraste para mover este botão.]=]
L["ATLAS_OPEN_ADDON_LIST"] = "Abra a lista de addons"
L["ATLAS_OPTIONS_AUTOSEL"] = "Selecione automaticamente o Mapa da Instância"
L["ATLAS_OPTIONS_AUTOSEL_TIP"] = "Selecione automaticamente o Mapa da Instância, o Atlas vai detectar a sua localização para escolher o melhor mapa de instância para você."
L["ATLAS_OPTIONS_BOSS_DESC"] = "Mostre a descrição do Chefe quando dsiponível"
L["ATLAS_OPTIONS_BUTPOS"] = "Poisção do botão"
L["ATLAS_OPTIONS_BUTTON"] = "Opções"
L["ATLAS_OPTIONS_CATDD"] = "Organize os Mapas de Instâncias por:"
L["ATLAS_OPTIONS_DONTSHOWAGAIN"] = "Não mostre a mesma informação novamente."
L["ATLAS_OPTIONS_LOCK"] = "Travar a janela do Atlas"
L["ATLAS_OPTIONS_RCLICK"] = "Clique com o botão direito para ir para o Mapa do Mundo"
L["ATLAS_OPTIONS_RESETPOS"] = "Recarregar posição"
L["ATLAS_OPTIONS_TRANS"] = "Transparência"
L["ATLAS_SEARCH_UNAVAIL"] = "Busca Indisponível"
L["ATLAS_SLASH"] = "/atlas"
L["ATLAS_SLASH_OPTIONS"] = "opções"
L["ATLAS_STRING_CLEAR"] = "Claro"
L["ATLAS_STRING_LOCATION"] = "Localização"
L["ATLAS_STRING_MINLEVEL"] = "Nível Mínimo"
L["ATLAS_STRING_PLAYERLIMIT"] = "Limite de Jogadores"
L["ATLAS_STRING_RECLEVELRANGE"] = "Nível Recomendado"
L["ATLAS_STRING_SEARCH"] = "Pesquisa"
L["ATLAS_STRING_SELECT_CAT"] = "Selecione a Categoria"
L["ATLAS_STRING_SELECT_MAP"] = "Selecione o Mapa"
L["ATLAS_TITLE"] = "Atlas"
L["Basement"] = "Porão"
L["Blacksmithing Plans"] = "Planos de Ferraria"
L["Child"] = "Criança"
L["Colon"] = ":"
L["Comma"] = ","
L["Connection"] = "Conexão"
L["East"] = "Leste"
L["Elevator"] = "Elevador"
L["End"] = "Fim"
L["Engineer"] = "Engenheiro"
L["Entrance"] = "Entrada"
L["Event"] = "Evento"
L["Exit"] = "Saída"
L["Fourth Stop"] = "Quarta Parada"
L["Ghost"] = "Fantasma"
L["Graveyard"] = "Cemitério"
L["Heroic"] = "Heróico"
L["Heroic_Symbol"] = "(H)"
L["Holy Paladin"] = "Paladino Sagrado"
L["Holy Priest"] = "Sacerdote Sagrado"
L["Hyphen"] = "-"
L["Key"] = "Chave"
L["L-DQuote"] = "“"
L["L-Parenthesis"] = "("
L["L-SBracket"] = "["
L["MapA"] = "[A]"
L["MapB"] = "[B]"
L["MapC"] = "[C]"
L["MapD"] = "[D]"
L["MapE"] = "[E]"
L["MapF"] = "[F]"
L["MapG"] = "[G]"
L["MapH"] = "[H]"
L["MapI"] = "[I]"
L["MapJ"] = "[J]"
L["Middle"] = "Meio"
L["Mythic"] = "Mítico"
L["Mythic_Symbol"] = "(M)"
L["North"] = "Norte"
L["Optional"] = "Opcional"
L["Period"] = "."
L["Portal"] = "Portal"
L["PossibleMissingModule"] = "É provável que este mapa seja deste módulo:"
L["Protection Warrior"] = "Guerreiro Proteção"
L["Random"] = "Aleatório"
L["Rare"] = "Raro"
L["R-DQuote"] = "“"
L["Repair"] = "Reparar"
L["Retribution Paladin"] = "Paladino Retribuição"
L["Rewards"] = "Recompensas"
L["R-Parenthesis"] = ")"
L["R-SBracket"] = [=[]
]=]
L["Second Stop"] = "Segunda Parada"
L["Semicolon"] = ";"
L["Slash"] = "/"
L["South"] = "Sul"
L["Start"] = "início"
L["Teleporter"] = "Teletransportador"
L["Teleporter destination"] = "Destino do teletransportador"
L["Third Stop"] = "Terceira Parada"
L["Top"] = "Topo"
L["Transport"] = "Transporte"
L["Tunnel"] = "Túnel"
L["West"] = "Oeste"
L["Yarley <Armorer>"] = "Yarley <Armoraria>"
L["Zaladormu"] = "Zaladormu"

end
