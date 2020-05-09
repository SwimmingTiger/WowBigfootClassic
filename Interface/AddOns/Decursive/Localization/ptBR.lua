--[[
    This file is part of Decursive.

    Decursive (v 2.7.7) add-on for World of Warcraft UI
    Copyright (C) 2006-2019 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2019-11-18T13:42:00Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Brazilian Portuguese localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "ptBR");

if not L then
    T._LoadedFiles["ptBR.lua"] = "2.7.7";
    return;
end

L["ABOLISH_CHECK"] = "Verifique se há \"Abolir\" antes de curar"
L["ABOUT_LICENSE"] = "Licensa"
L["ABOUT_OFFICIALWEBSITE"] = "WEBSITE OFFICIAL"
L["ABSENT"] = "Faltando (%s)"
L["AFFLICTEDBY"] = "%s Afligido"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "A quantidade afligida para exibir"
L["ANCHOR"] = "Âncora de texto do Decursive"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar ou esconder os micro quadros de unidades."
L["BINDING_NAME_DCRPRADD"] = "Adicionar alvo na lista de prioridades"
L["BINDING_NAME_DCRPRCLEAR"] = "Limpar a lista de prioridades"
L["BINDING_NAME_DCRPRLIST"] = "Imprimir a lista de prioridades"
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar ou esconder a lista de prioridade"
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar ou esconder a Barra Principal do Decursive
(âncora de lista ao vivo)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Mostrar opção de painel estático"
L["BINDING_NAME_DCRSKADD"] = "Adiciona alvo à lista de passe"
L["BINDING_NAME_DCRSKCLEAR"] = "Limpar a lista de passe"
L["BINDING_NAME_DCRSKLIST"] = "Mostrar a lista de passe"
L["BINDING_NAME_DCRSKSHOW"] = "Mostra ou oculta a lista de passe"
L["BLACK_LENGTH"] = "Segundos na lista negra"
L["BLACKLISTED"] = "Lista negra"
L["CHARM"] = "Encantar"
L["CLASS_HUNTER"] = "Caçador"
L["COLORCHRONOS"] = "Cronometros"
L["CTRL"] = "Ctrl"
L["CURSE"] = "Maldição"
L["GLOR1"] = "Em memoria de Glorfindal"
L["GLOR2"] = [=[Decursive é dedicado a memoria de Bertrand que nós deixou muito cedo.
Ele sempre sera lembrado.]=]
L["GLOR3"] = [=[Em memoria de Bertrand Sense
1969-2007]=]
L["HIDESHOW_BUTTONS"] = "Mostrar/Esconder Buttoes"
L["OPT_NOSTARTMESSAGES"] = "Desativar mensagens de iniciar"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para amostrar a janela do Decursive, escreve /dcrshow"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s feitiço nao foi encontrado"
L["STR_CLOSE"] = "Fechar"
L["STR_DCR_PRIO"] = "Prioridade do Decursive"



T._LoadedFiles["ptBR.lua"] = "2.7.7";

