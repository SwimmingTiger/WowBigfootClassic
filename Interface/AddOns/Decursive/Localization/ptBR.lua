--[[
    This file is part of Decursive.

    Decursive (v 2.7.8.2) add-on for World of Warcraft UI
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
    T._LoadedFiles["ptBR.lua"] = "2.7.8.2";
    return;
end

L["ABOLISH_CHECK"] = "Verifique se há \"Abolir\" antes de curar"
L["ABOUT_AUTHOREMAIL"] = "E-MAIL DO AUTOR"
L["ABOUT_CREDITS"] = "CRÉDITOS"
L["ABOUT_LICENSE"] = "LICENÇA"
L["ABOUT_NOTES"] = "Exibição de aflições e limpeza para uso solo, em grupo e raides, com filtragem avançada e sistema de proriodades."
L["ABOUT_OFFICIALWEBSITE"] = "WEBSITE OFFICIAL"
L["ABOUT_SHAREDLIBS"] = "BIBLIOTECAS COMPARTILHADAS"
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
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "Definir o alerta de de cor quando um '%s' é necessário."
L["COLORCHRONOS"] = "Contador central"
L["COLORCHRONOS_DESC"] = "Define a cor do contador central"
L["COLORSTATUS"] = "Define a cor para o status '%s' no MQU."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Varrer e curar ajudantes"
L["CURSE"] = "Maldição"
L["DEBUG_REPORT_HEADER"] = "|cFF11FF33Por favor envie o conteúdo desta janela por email para <%s>|r |cFF009999(Use CTRL+A para selecionar tudo e então CTRL+C para por o texto na sua área de transferência)|r Também explique no seu relatório se você encontrou algum comportamento estranho no %s."
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Relatório de Depuração do Decursive|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = "|cFF11FF33O Decursive travou, mas não se apavore! Uma NOVA versão do Decursive foi detectada (%s). Você só precisa atualizar. Vá para curse.com e pesquise por 'Decursive' ou use o aplicativo do Curse, ele irá atualizar todos os seus add-ons de modo automático.|r |cFFFF1133Então não perca seu tempo relatando esse bug pois ele provavelmente já foi corrigido. Simplismente atualize o Decursive para resolver esse problema!|r |cFF11FF33Obrigado por ler esta mensagem!|r"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = "Um relatório de depuração está disponível! Digite |cFFFF0000/DCRREPORT|r para visualizar."
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Relatório de depuração disponível!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Exibe um relatório de depuração que o autor precisa ver..."
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = "Você está usando uma versão de desenvolvimento do Decursive. Se você não deseja participar do teste de novas funcionalidade/correções, receber relatórios de depuração em jogo, relatar problemas ao autor então NÃO USE ESTA VERSÃO e baixe a versão ESTÁVEL mais recente em curse.com ou wowace.com. Esta mensagem será exibida somente uma vez por versão"
L["DEV_VERSION_EXPIRED"] = "Esta versão de desenvolvimento do Decursive expirou. Você deve baixar a versão de desenvolvimento mais recente ou voltar para o lançamento estável atual, disponível em CURSE.COM ou WOWACE.COM. Este aviso será exibido a cada dois dias."
L["DEWDROPISGONE"] = "Não há um equivalente a DewDrop para Ace3. Pressione Alt-Clique-Direito para abrir o painel de opções."
L["DISABLEWARNING"] = "Decursive foi desabilitado! Para habilitar novamente, digite |cFFFFAA44/DCR ENABLE|r"
L["DISEASE"] = "Doença"
L["DONOT_BL_PRIO"] = "Não excluir nomes na lista de prioriade"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive está somente relatando o problema. Então, não culpe o mensageiro e resolva o problema real."
L["FAILEDCAST"] = "|cFF22FFFF%s %s|r |cFFAA0000falhou em|r %s |cFF00AAAA%s|r"
L["FOCUSUNIT"] = "Unidade Foco"
L["FUBARMENU"] = "Menu FuBar"
L["FUBARMENU_DESC"] = "Define as opções relacionadas ao ícone FuBar"
L["GLOR1"] = "Em memoria de Glorfindal"
L["GLOR2"] = "Decursive é dedicado a memoria de Bertrand que nós deixou muito cedo. Ele sempre será lembrado."
L["GLOR3"] = "Em memória de Bertrand Sense 1969 - 2007"
L["GLOR4"] = "Amizade e afeto podem extender suas raízes a qualquer lugar. Aqueles que conheceram Glorfindal em World of Warcraft conheceram um home de grande compromisso e um líder carismático. Ele foi em vida como foi em jogo, altruísta, generoso, dedicado aos amigos e acima de tudo, um homem apaixonado. Ele nos deixou aos 38 anos, deixando para trás não apenas jogadores anônimos em um mundo virtual, mas um grupo de amigos verdadeiros que sentirão sua falta para sempre."
L["GLOR5"] = "Ele sempre será lembrado..."
L["HANDLEHELP"] = "Arrastar todos os Micro Quadro de Unidades (MQU)"
L["HIDE_MAIN"] = "Esconder Janela do Decursive"
L["HIDESHOW_BUTTONS"] = "Ocultar/Mostrar botões e bloquear/desbloquear a barra \"Decursive\""
L["HLP_LEFTCLICK"] = "Clique-Esquerdo"
L["HLP_LL_ONCLICK_TEXT"] = "A Lista Ao Vivo não deve ser clicada. Por favor, leia a documentação para saber como usar este add-on. Basta pesquisar por 'Decursive' em WoWAce.com (Para mover esta lista, mova a barra do Decursive, /dcrshow e alt-clique-esquedo para mover)"
L["HLP_MIDDLECLICK"] = "Clique-Meio"
L["HLP_MOUSE4"] = "Mouse Botão 4"
L["HLP_MOUSE5"] = "Mouse Botão 5"
L["HLP_NOTHINGTOCURE"] = "Não há nada a ser curado!"
L["HLP_RIGHTCLICK"] = "Clique-Direito"
L["HLP_USEXBUTTONTOCURE"] = "Use \"%s\" para curar essa aflição!"
L["HLP_WRONGMBUTTON"] = "Botão do mouse errado!"
L["IGNORE_STEALTH"] = "Ignorar unidades em modo furtivo"
L["IS_HERE_MSG"] = "Decursive foi inicializado, lembre-se de conferir as opções (/decursive)"
L["LIST_ENTRY_ACTIONS"] = "|cFF33AA33[CTRL]|r-Clique: Remover este jogador Clique-|cFF33AA33ESQUERDO|r: Subir jogador Clique-|cFF33AA33DIREITO|r: Descer jogador |cFF33AA33[SHIFT]|r Clique-|cFF33AA33ESQUERDO|r: Elevar jogador ao topo |cFF33AA33[SHIFT]|r Clique-|cFF33AA33DIREITO|r: Descer jogado ao fim"
L["MACROKEYALREADYMAPPED"] = [=[AVISO: A tecla mapeada para a macro do Decursive [%s] foi mapeada para a ação '%s'.
Decursive irá restaurar o mapeamento anterior se você definir outra tecla para sua macro.]=]
L["MACROKEYMAPPINGFAILED"] = "A tecla [%s] não pôde ser mapeada para a macro do Decursive!"
L["MACROKEYMAPPINGSUCCESS"] = "A tecla [%s] foi mapeada com sucesso para a macro do Decursive."
L["MACROKEYNOTMAPPED"] = "Macro de mouse-over do Decursive não está mapeado para uma tecla, verifique as opções de 'Macro'!"
L["MAGIC"] = "Mágica"
L["MAGICCHARMED"] = "Encanto Mágico"
L["MISSINGUNIT"] = "Unidade ausente"
L["NEW_VERSION_ALERT"] = "Uma nova versão do Decursive foi detectada: |cFFEE7722%q|r lançada em |cFFEE7722%s|r! Vá para |cFFFF0000WoWAce.com|r para obtê-la! --------"
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Nenhum feitiço disponível"
L["OPT_ABOLISHCHECK_DESC"] = "seleciona se as unidades com um feitiço 'Abolir' ativo são mostradas e curadas"
L["OPT_ABOUT"] = "Sobre"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Adicionar feitiço/item personalizado"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Arraste e solte um feitiço ou item usável aqui. Você também pode escrever seu nome diretamente, seu ID numérico ou usar shift-clique."
L["OPT_ADDDEBUFF"] = "Adicionar aflição personalizada"
L["OPT_ADDDEBUFF_DESC"] = "Adiciona uma nova aflição a esta lista"
L["OPT_ADDDEBUFF_USAGE"] = "<ID de feitiço de aflição> (você pode encontrar ID de feitiços em URLs do WoWHead.com)"
L["OPT_ADDDEBUFFFHIST"] = "Adicionar uma aflição dissipada recentemente"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Adicionar uma aflição usando o histórico de aflições dissipadas por você recentemente"
L["OPT_ADVDISP"] = "Opções de exibição Avançadas"
L["OPT_ADVDISP_DESC"] = "Permite definir Transparência da borda e do centro de maneira separada, para definir o espaço entre cada MQU"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s afligido por %s será ignorado"
L["OPT_ALLOWMACROEDIT"] = "Permitir edição de macro"
L["OPT_ALLOWMACROEDIT_DESC"] = "Habilite isto para previnir o Decursive de atualizar sua macro, deixando que você a edite da maneira que quiser."
L["OPT_ALWAYSIGNORE"] = "Sempre ignorar quando fora de combate"
L["OPT_ALWAYSIGNORE_DESC"] = "Se marcada, esta aflição também será ignorada quando você estiver fora de combate"
L["OPT_AMOUNT_AFFLIC_DESC"] = "Define o número máximo de amaldiçoados para exibir na lista ao vivo"
L["OPT_ANCHOR_DESC"] = "Mostra a âncora do quadro de mensagem personalizada"
L["OPT_AUTOHIDEMFS"] = "Ocultar MQUs quando:"
L["OPT_AUTOHIDEMFS_DESC"] = "Escolha quando ocultar a janela de MQUs automaticamente."
L["OPT_BLACKLENTGH_DESC"] = "Define quanto tempo alguém permanece na lista negra"
L["OPT_BORDERTRANSP"] = "Transparência da borda"
L["OPT_BORDERTRANSP_DESC"] = "Define a transparência da borda"
L["OPT_CENTERTEXT"] = "Contador central:"
L["OPT_CENTERTEXT_DESC"] = "Exibe informações sobre a aflição superior (de acordo com suas prioridades) no centro de cada MQU. Escolha: - Tempo restante antes da expiração natural - Tempo decorrido desde a ocorrência da aflição - Número de cargas"
L["OPT_CENTERTEXT_DISABLED"] = "Desabilitado"
L["OPT_CENTERTEXT_ELAPSED"] = "Tempo decorrido"
L["OPT_CENTERTEXT_STACKS"] = "Número de cargas"
L["OPT_CENTERTEXT_TIMELEFT"] = "Tempo restante"
L["OPT_CENTERTRANSP"] = "Transparência do centro"
L["OPT_CENTERTRANSP_DESC"] = "Define a transparência do centro"
L["OPT_CHARMEDCHECK_DESC"] = "Se marcado, você será capaz de ver e lidar com unidades encantadas"
L["OPT_CHATFRAME_DESC"] = "As mensagens do Decursive serão impressas no quadro de bate-papo padrão"
L["OPT_CHECKOTHERPLAYERS"] = "Verificar outros jogadores"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Exibe a versão do Decursive entre os jogadores em seu grupo atual ou guilda (não pode exibir versões anteriores ao Decursive 2.4.6)."
L["OPT_CMD_DISBLED"] = "Desativado"
L["OPT_CMD_ENABLED"] = "Ativado"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Criar uma aflição de teste virtual"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Permite que você veja a aparência do Decursive quando uma aflição é encontrada."
L["OPT_CURE_PRIORITY_NUM"] = "Prioridade #%d"
L["OPT_CUREPETS_DESC"] = "Ajudantes serão gerenciados e curados"
L["OPT_CURINGOPTIONS"] = "Opções de Cura"
L["OPT_CURINGOPTIONS_DESC"] = "Opções de cura, incluindo opções para alterar a prioridade para cada tipo de aflição"
L["OPT_CURINGOPTIONS_EXPLANATION"] = "Selecione os tipos de aflição que deseja curar, os tipos não marcados serão completamente ignorados pelo Decursive. Os números verdes representam a prioridade associada a cada tipo de aflição. Esta prioridade determina as seguintes opções: - Qual tipo de aflição o Decursive mostra primeiro se um jogador tem vários tipos de aflições. - A cor e a teclas associadas a cada tipo de aflição. (Para alterar as prioridades, desmarque todas as caixas de seleção e marque-as na ordem da prioridade desejada.)"
L["OPT_CURINGORDEROPTIONS"] = "Tipos de aflição e prioridades"
L["OPT_CURSECHECK_DESC"] = "Se marcado, você será capaz de ver e curar unidades amaldiçoadas"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "Permitir edição de macro interna para o feitiço acima"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = "Marque isto se quiser editar a macro interna que o Decursive usará para o feitiço personalizado que está sendo adicionado. Nota: Marcar isto permite que você modifique os feitiços gerenciados pelo Decursive. Se um feitiço já estiver listado, você precisará removê-lo primeiro para habilitar a edição de macro. (--- Apenas para usuários avançados ---)"
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "Tipos de aflição"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "Este feitiço faz parte da configuração automática do Decursive. Se este feitiço não estiver mais funcionando corretamente, você pode removê-lo ou desativá-lo para recuperar o comportamento Decursivo padrão."
L["OPT_CUSTOM_SPELL_ISPET"] = "Habilidade de ajudante"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "Marque esta opção se esta é uma habilidade que pertence a um de seus ajudantes para o Decursive pode detectar e lançá-la corretamente."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "Aviso: O feitiço %q não está presente em sua macro, as informações de alcance e recarga não corresponderão..."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "Falta a palavra-chave UNITID."
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Texto da macro:"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = "Editar o texto da macro padrão. |cFFFF0000Somente 2 restrições:|r - Você deve especificar o destino utilizando a palavra-chave UNITID que será automaticamente substituída pelo ID da unidade de cada MQU. - Qualquer que seja o feitiço usado na macro, o Decursive continuará usando o nome original exibido à esquerda para alcance e exibição/rastreamento de recarga. (tenha isso em mente se você planeja usar feitiços diferentes com condicionais)"
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Sua macro é muito longa, você precisa remover %d caracteres."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Prioridade de feitiços"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = "Quando vários feitiços podem curar os mesmos tipos de aflição, aqueles com uma prioridade mais alta serão preferidos. Observe que as habilidades padrão gerenciadas pelo Decursive têm uma prioridade que varia de 0 a 9. Portanto, se você der ao seu feitiço personalizado uma prioridade negativa, ela só será escolhida se a habilidade padrão não estiver disponível."
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "indisponível"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "Filtragem de Unidades"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "Selecione as unidades que podem se beneficiar deste feitiço"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "Todas as unidades"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "Somente outros"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "Somente jogador"
L["OPT_CUSTOMSPELLS"] = "Feitiços/itens personalizados"
L["OPT_CUSTOMSPELLS_DESC"] = "Aqui você pode adicionar feitiços para estender a configuração automática do Decursive. Seus feitiços personalizados sempre têm uma prioridade mais alta e irão sobrepor e substituir os feitiços padrão (se e somente se o seu personagem puder usar esses feitiços)."
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "Atribuições feitiços eficazes:"
L["OPT_DEBCHECKEDBYDEF"] = "Marcado por padrão"
L["OPT_DEBUFFENTRY_DESC"] = "Selecione qual classe deve ser ignorada em combate quando afligida por esta aflição"
L["OPT_DEBUFFFILTER"] = "Filtragem de Aflição"
L["OPT_DEBUFFFILTER_DESC"] = "Selecione aflições para excluir por nome e classe enquanto você está em combate"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Remover"
L["OPT_DISABLEABOLISH"] = "Não use feitiços 'Abolir'"
L["OPT_DISABLEABOLISH_DESC"] = "Se habilitado, o Decursive preferirá 'Curar Doença' e 'Curar Veneno' em vez de seu equivalente 'Abolir'."
L["OPT_DISABLEMACROCREATION"] = "Desativar criação de macro"
L["OPT_DISABLEMACROCREATION_DESC"] = "A macro do Descursive não será mais criada ou mantida"
L["OPT_DISEASECHECK_DESC"] = "Se marcado, você será capaz de ver e curar unidades afligidas por doenças"
L["OPT_DISPLAYOPTIONS"] = "Opções de exibição"
L["OPT_DONOTBLPRIO_DESC"] = "Unidades priorizadas não serão colocadas na lista negra"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Ativar"
L["OPT_ENABLE_LIVELIST"] = "Ativar lista ao vivo"
L["OPT_ENABLE_LIVELIST_DESC"] = "Exibe uma lista informativa de pessoas afligidas. Você pode mover esta lista movendo a barra do Decursive (digite /DCRSHOW para exibir essa barra)."
L["OPT_ENABLEDEBUG"] = "Habilitar Depuração"
L["OPT_ENABLEDEBUG_DESC"] = "Habilitar saída de depuração"
L["OPT_ENABLEDECURSIVE"] = "Habilitar Decursive"
L["OPT_FILTERED_DEBUFF_RENAMED"] = "Aflição filtrada \"%s\" renomeada automaticamente para \"%s\" para ID de feitiço %d"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q será ignorado nas classes especificadas enquanto você está em combate."
L["OPT_GENERAL"] = "Opções gerais"
L["OPT_GROWDIRECTION"] = "Exibição reversa de MQUs"
L["OPT_GROWDIRECTION_DESC"] = "Os MQUs serão exibidos de baixo para cima"
L["OPT_HIDEMFS_GROUP"] = "em modo solo ou em grupo"
L["OPT_HIDEMFS_GROUP_DESC"] = "Ocultar a janela do MQU quando você não estiver em uma raide."
L["OPT_HIDEMFS_NEVER"] = "Nunca ocultar automaticamente"
L["OPT_HIDEMFS_NEVER_DESC"] = "Nunca ocultar automaticamente a janela dos MQUs."
L["OPT_HIDEMFS_SOLO"] = "em modo solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Ocultar a janela dos MQUs quando você não fizer parte de nenhum tipo de grupo."
L["OPT_HIDEMUFSHANDLE"] = "Ocultar a alça dos MQU"
L["OPT_HIDEMUFSHANDLE_DESC"] = "Oculta a alça dos Micro Quadros de Unidade e desativa a possibilidade de movê-los. Use o mesmo comando para recuperá-la."
L["OPT_IGNORESTEALTHED_DESC"] = "Unidades camufladas serão ignoradas"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Feitiço já listado!"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive já gerencia este feitiço. Shift-clique no feitiço ou digite seu ID para adicionar uma classificação especial."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "ID de feitiço inválido!"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Feitiço não encontrado no seu livro de feitiços!"
L["OPT_ISNOTVALID_SPELLID"] = "não é um ID de feitiço válido"
L["OPT_LIVELIST"] = "Lista ao vivo"
L["OPT_LIVELIST_DESC"] = "Estas são as configurações relativas à lista de unidades afligidas exibida abaixo da barra \"Decursive\". Para mover esta lista, você precisa mover o pequeno quadro \"Decursive\". Algumas das configurações abaixo estão disponíveis apenas quando este quadro é exibido. Você pode exibi-lo digitando |cff20CC20/DCRSHOW|r na janela de bate-papo. Depois de definir a posição, escala e transparência da lista ao vivo, você pode ocultar com segurança o quadro do Decursive digitando |cff20CC20/DCRHIDE|r."
L["OPT_LLALPHA"] = "Transparência da lista ao vivo"
L["OPT_LLALPHA_DESC"] = "Altera a barra principal descursiva e a transparência da lista ao vivo (a barra principal deve ser exibida)"
L["OPT_LLSCALE"] = "Escala da Lista ao vivo"
L["OPT_LLSCALE_DESC"] = "Define o tamanho da barra principal do Decursive e da lista ao vivo (a barra principal deve ser exibida)"
L["OPT_LVONLYINRANGE"] = "Unidades em alcance apenas"
L["OPT_LVONLYINRANGE_DESC"] = "Apenas unidades em alcance de dissipação serão mostradas na lista ao vivo"
L["OPT_MACROBIND"] = "Define o vínculo de tecla da macro"
L["OPT_MACROBIND_DESC"] = "Define a tecla na qual a macro 'Decursive' será chamada. Pressione a tecla e pressione a tecla 'Enter' do teclado para salvar a nova atribuição (com o cursor do mouse sobre o campo de edição)"
L["OPT_MACROOPTIONS"] = "Opções de macro"
L["OPT_MACROOPTIONS_DESC"] = "Define o comportamento da macro 'mouseover' criada pelo Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Se marcado, você será capaz de ver e curar unidades encantadas por magia"
L["OPT_MAGICCHECK_DESC"] = "Se marcado, você será capaz de ver e curar unidades afligidas por magia"
L["OPT_MAXMFS"] = "Unidades máximas mostradas"
L["OPT_MAXMFS_DESC"] = "Define o número máximo de micro quadros de unidade para exibir"
L["OPT_MESSAGES"] = "Mensagens"
L["OPT_MESSAGES_DESC"] = "Oções de exibição de mensagens"
L["OPT_MFALPHA"] = "Transparência"
L["OPT_MFALPHA_DESC"] = "Define a transparência dos MQU quando as unidades não estão afligidas"
L["OPT_MFPERFOPT"] = "Opções de performance"
L["OPT_MFREFRESHRATE"] = "Taxa de atualização"
L["OPT_MFREFRESHRATE_DESC"] = "Tempo entre cada chamada de atualização (1 ou vários micro quadros de unidade podem ser atualizadas de uma vez)"
L["OPT_MFREFRESHSPEED"] = "Velocidade de atualização"
L["OPT_MFREFRESHSPEED_DESC"] = "Número de micro quadros de unidade para atualizar em uma única passagem"
L["OPT_MFSCALE"] = "Escala dos micro quadros de unidade"
L["OPT_MFSCALE_DESC"] = "Define o tamanho dos micro quadros de unidade"
L["OPT_MFSETTINGS"] = "Opções de Micro Quadros de Unidade"
L["OPT_MFSETTINGS_DESC"] = "Define várias opções de exibição relacionadas à prioridade de tipo aflições e MQU"
L["OPT_MUFFOCUSBUTTON"] = "Botão de foco:"
L["OPT_MUFHANDLE_HINT"] = "Para mover os micro-quadros de unidade: ALT-clique na alça invisível localizada acima do primeiro micro-quadro de unidade."
L["OPT_MUFMOUSEBUTTONS"] = "Vínculos de mouse"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "Altere as teclas usadas para curar, definir alvo ou focar membros do grupo por meio dos MQU. Cada número de prioridade representa um tipo de aflição diferente, conforme especificado no painel '|cFFFF5533Opções de Cura|r'. O feitiço usado para cada tipo de aflição é definido por padrão, mas pode ser alterado no painel '|cFF00DDDDFeitiços personalizados|r'."
L["OPT_MUFSCOLORS"] = "Cores"
L["OPT_MUFSCOLORS_DESC"] = "Opções para alterar a cor para a prioridade de cada tipo de aflição e vários status de MQU. Cada prioridade representa um tipo de aflição diferente, conforme especificado no painel '|cFFFF5533Opções de Cura|r'."
L["OPT_MUFSVERTICALDISPLAY"] = "Exibição vertical"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "Janela de MQUs crescerá verticalmente"
L["OPT_MUFTARGETBUTTON"] = "Botão de alvo:"
L["OPT_NEWVERSIONBUGMENOT"] = "Alertas de nova versão"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Se uma versão mais recente do Decursive for detectada, um alerta pop-up será exibido uma vez a cada sete dias."
L["OPT_NOKEYWARN"] = "Alertar falta de tecla"
L["OPT_NOKEYWARN_DESC"] = "Exibir um alerta se nenhuma tecla estiver mapeada"
L["OPT_NOSTARTMESSAGES"] = "Desativar mensagens de iniciar"
L["OPT_NOSTARTMESSAGES_DESC"] = "Remover as duas mensagens que o Decursive exibe no quadro de bate-papo a cada login."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Essas opções estão desativadas enquanto você está em combate."
L["OPT_PERFOPTIONWARNING"] = "AVISO: Não altere esses valores a menos que saiba exatamente o que está fazendo. Essas configurações podem ter um grande impacto no desempenho do jogo. A maioria dos usuários deve usar os valores padrão de 0,1 e 10."
L["OPT_PLAYSOUND_DESC"] = "Tocar um som se alguém for amaldiçoado"
L["OPT_POISONCHECK_DESC"] = "Se marcado, você será capaz de ver e curar unidades envenenadas"
L["OPT_PRINT_CUSTOM_DESC"] = "As mensagens do Decursive serão impressas em um quadro de bate-papo personalizado"
L["OPT_PRINT_ERRORS_DESC"] = "Erros serão exibidos"
L["OPT_PROFILERESET"] = "Redefinir perfil..."
L["OPT_RANDOMORDER_DESC"] = "As unidades serão exibidas e curadas aleatoriamente (não recomendado)"
L["OPT_READDDEFAULTSD"] = "Re-adicionar as aflições padrão"
L["OPT_READDDEFAULTSD_DESC1"] = "Adicionar as aflições padrão do Decursive ausentes a esta lista. Suas configurações não serão alteradas"
L["OPT_READDDEFAULTSD_DESC2"] = "Todas as aflições padrão do Decursive estão nesta lista"
L["OPT_REMOVESKDEBCONF"] = "Tem certeza de que deseja remover '%s' da lista de aflições ignoradas do Decursive?"
L["OPT_REMOVETHISDEBUFF"] = "Remover esta aflição"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Remove '%s' da lista de passe"
L["OPT_RESETDEBUFF"] = "Redefinir esta aflição"
L["OPT_RESETDTDCRDEFAULT"] = "Redefine '%s' para o padrão do Decursive"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Redefinir"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Redefinir vínculos de botão do mouse para o padrão."
L["OPT_RESETOPTIONS"] = "Redefinir opções para o padrão"
L["OPT_RESETOPTIONS_DESC"] = "Redefinir o perfil atual para os valores padrão"
L["OPT_RESTPROFILECONF"] = "Tem certeza de que deseja redefinir o perfil '(%s) %s' para as opções padrão?"
L["OPT_REVERSE_LIVELIST_DESC"] = "A lista ao vivo preenche-se de baixo para cima"
L["OPT_SCANLENGTH_DESC"] = "Define o tempo entre cada varredura"
L["OPT_SETAFFTYPECOLOR_DESC"] = "Define a cor do tipo de aflição \"%s\". (Aparece principalmente nas tootips dos MQU e na lista ao vivo)"
L["OPT_SHOW_STEALTH_STATUS"] = "Mostrar status de furtividade"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Quando um jogador está furtivo, seu MQU terá uma cor especial"
L["OPT_SHOWBORDER"] = "Mostrar bordas coloridas de acordo com a classe"
L["OPT_SHOWBORDER_DESC"] = "Uma borda colorida será exibida ao redor dos MQU representando a classe da unidade"
L["OPT_SHOWHELP"] = "Mostrar Ajuda"
L["OPT_SHOWHELP_DESC"] = "Mostra uma tooltip detalhada quando você passa o mouse sobre um micro-quadro de unidade"
L["OPT_SHOWMFS"] = "Mostrar os Micro-Quadros de Unidade"
L["OPT_SHOWMFS_DESC"] = "Isso deve ser habilitado se você deseja curar clicando"
L["OPT_SHOWMINIMAPICON"] = "Ícone do minimapa"
L["OPT_SHOWMINIMAPICON_DESC"] = "Alterna o ícone do minimapa."
L["OPT_SHOWTOOLTIP_DESC"] = "Mostra dicas detalhadas sobre maldições na lista ao vivo e nos MQU"
L["OPT_SPELL_DESCRIPTION_LOADING"] = "Descrição está carregando... volte mais tarde."
L["OPT_SPELL_DESCRIPTION_UNAVAILABLE"] = "descrição indisponível"
L["OPT_SPELLID_MISSING_READD"] = "Você precisa adicionar novamente esta aflição usando seu Spell ID para ver uma descrição adequada em vez desta mensagem."
L["OPT_STICKTORIGHT"] = "Alinhar janela de MQU à direita"
L["OPT_STICKTORIGHT_DESC"] = "A janela de MQU crescerá da direita para a esquerda, a alça será movida conforme necessário."
L["OPT_TESTLAYOUT"] = "Testar Layout"
L["OPT_TESTLAYOUT_DESC"] = "Cria unidades falsas para que você possa testar o layout da tela. (Aguarde alguns segundos após clicar)"
L["OPT_TESTLAYOUTUNUM"] = "Quantidade de unidades"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Define a quantidade de unidades falsas a serem criadas."
L["OPT_TIE_LIVELIST_DESC"] = "A exibição da lista ao vivo está ligada à exibição da barra \"Decursive\""
L["OPT_TIECENTERANDBORDER"] = "Vincular transparência da borda e centro"
L["OPT_TIECENTERANDBORDER_OPT"] = "A transparência da borda é metade da transparência do centro quando marcado"
L["OPT_TIEXYSPACING"] = "Vincular espaçamento horizontal e vertical"
L["OPT_TIEXYSPACING_DESC"] = "O espaçamento vertical e horizontal entre os MQU são o mesmo"
L["OPT_UNITPERLINES"] = "Número de unidades por linha"
L["OPT_UNITPERLINES_DESC"] = "Define o número máximo de micro-quadros de unidade para exibir por linha"
L["OPT_USERDEBUFF"] = "Esta aflição não faz parte das aflições padrão do Decursive"
L["OPT_XSPACING"] = "Espaçamento horizontal"
L["OPT_XSPACING_DESC"] = "Define o espaçamento Horizontal entre os MQU"
L["OPT_YSPACING"] = "Espaçamento vertical"
L["OPT_YSPACING_DESC"] = "Define o espaçamento Vertical entre os MQU"
L["OPTION_MENU"] = "Menu de Opções do Decursive"
L["PLAY_SOUND"] = "Tocar um som quando houver alguém para curar"
L["POISON"] = "Veneno"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Popular rapidamente a lista do Decursive"
L["PRINT_CHATFRAME"] = "Imprimir mensagens no chat padrão"
L["PRINT_CUSTOM"] = "Imprimir mensagens na janela"
L["PRINT_ERRORS"] = "Imprimir mensagens de erro"
L["PRIORITY_LIST"] = "Lista de Prioridades Decursive"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Curar em ordem aleatória"
L["REVERSE_LIVELIST"] = "Exibição reversa da lista ao vivo"
L["SCAN_LENGTH"] = "Segundos entre as varreduras ao vivo:"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para amostrar a janela do Decursive, escreve /dcrshow"
L["SHOW_TOOLTIP"] = "Exibir tooltips em unidades aflitas"
L["SKIP_LIST_STR"] = "Lista de passe Decursive"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s feitiço nao foi encontrado"
L["STEALTHED"] = "camuflado"
L["STR_CLOSE"] = "Fechar"
L["STR_DCR_PRIO"] = "Prioridade do Decursive"
L["STR_DCR_SKIP"] = "Pulo Decursive"
L["STR_GROUP"] = "Grupo"
L["STR_OPTIONS"] = "Opções do Decursive"
L["STR_OTHER"] = "Outro"
L["STR_POP"] = "Popular Lista"
L["STR_QUICK_POP"] = "Popular Rapidamente"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00funcionou em|r %s"
L["TARGETUNIT"] = "Unidade Alvo"
L["TIE_LIVELIST"] = "Vincular a visibilidade da lista ao vivo à janela do DCR"
L["TOC_VERSION_EXPIRED"] = "A versão do seu Decursive está desatualizada. Esta versão do Decursive foi lançada antes da versão do World of Warcraft que você está usando. Você precisa atualizar o Decursive para corrigir possíveis incompatibilidades e erros de tempo de execução. Vá para curse.com e procure por 'Decursive' ou use o aplicativo do Curse para atualizar todos os seus add-ons de uma vez. Este aviso será exibido novamente em 2 dias."
L["TOO_MANY_ERRORS_ALERT"] = "Existem muitos erros Lua em sua interface de usuário (%d erros). Sua experiência de jogo pode ser prejudicada. Desabilite ou atualize os add-ons com falha para desligar esta mensagem. Você pode querer ativar o relatório de erros Lua (/console scriptErrors 1)."
L["TOOFAR"] = "Muito longe"
L["UNITSTATUS"] = "Status da Unidade:"
L["UNSTABLERELEASE"] = "Versão instável"



T._LoadedFiles["ptBR.lua"] = "2.7.8.2";

