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
-- Spanish localization
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
T._LoadedFiles["esES.lua"] = false;

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "esES");

if not L then
    T._LoadedFiles["esES.lua"] = "2.7.7";
    return;
end;

L["ABOLISH_CHECK"] = "Comprobar \"Abolido\" antes de curar"
L["ABSENT"] = "Falta (%s)"
L["AFFLICTEDBY"] = "%s Afectado"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "Cantidad de afectados a mostrar:"
L["ANCHOR"] = "Anclaje del Texto de Decursive"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar u ocultar los micro-unit frames"
L["BINDING_NAME_DCRPRADD"] = "Añadir objetivo a la lista de prioridad"
L["BINDING_NAME_DCRPRCLEAR"] = "Limpiar la lista de prioridad"
L["BINDING_NAME_DCRPRLIST"] = "Imprimir la lista de prioridad"
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar u ocultar la lista de prioridad"
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar u ocultar la barra principal de Decursive
(live-list anchor)]=]
L["CLASS_HUNTER"] = "Cazador"
L["CURSE"] = "Maldición"
L["DEFAULT_MACROKEY"] = "NONE"
L["DISEASE"] = "Enfermedad"
L["MAGIC"] = "Magia"
L["OPT_UNITPERLINES_DESC"] = "Define el número máximo de micro-marcos de unidades a mostrar por línea"
L["OPT_XSPACING"] = "Espaciado horizontal"
L["OPT_YSPACING"] = "Espaciado vertical"
L["PLAY_SOUND"] = "Reproducir un sonido cuando hay alguien a quien curar"
L["POISON"] = "Veneno"
L["POPULATE"] = "p"
L["PRINT_CHATFRAME"] = "Mostrar mensajes en el chat predeterminado"
L["RANDOM_ORDER"] = "Curar en orden aleatorio"
L["SCAN_LENGTH"] = "Segundos entre escaneos en vivo :"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para mostrar la ventana de Decursive, escribe /dcrshow"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "¡%s hechizo encontrado!"
L["STR_CLOSE"] = "Cerrar"
L["STR_DCR_PRIO"] = "Prioridad decursive"
L["STR_DCR_SKIP"] = "No decursear"
L["STR_GROUP"] = "Grupo"
L["STR_OPTIONS"] = "Opciones"
L["STR_OTHER"] = "Otro"
L["TOOFAR"] = "Muy lejos"



T._LoadedFiles["esES.lua"] = "2.7.7";
