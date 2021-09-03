local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "esES" and TC2.locale ~= "esMX" then return end

-----------------------------
--    esES and esMX clients
-----------------------------
-- main frame
L.gui_threat            = "Amenaza"
L.gui_config            = "Abrir Config"

-- config frame
L.reset                 = "Restablecer los valores predeterminados"

-- messages
L.message_welcome       = "Escribe /tc2 para opciones."
L.message_leader        = "Debe ser el líder del grupo o tener asistente para hacer esto."
L.message_outdated      = "|cFFFBB709ThreatClassic2:|r ¡Una nueva versión está disponible! Por favor actualice."
L.message_incompatible  = "|cFFFBB709ThreatClassic2|r está desactualizado e incompatible con versiones anteriores. ¡Actualiza inmediatamente!"

L.general               = "General"
L.general_welcome       = "Muestra un mensaje de bienvenida al conectarse."
L.general_rawPercent    = "Usa el porcentaje de amenaza bruta (agro al 110% cuerpo a cuerpo / 130% de alcance)"
L.general_downscaleThreat = "Escala los valores de amenaza (por lo que 1 daño equivale a 1 amenaza antes de los modificadores)"
L.general_downscaleThreatDesc = "La API de amenazas de Blizzard usa 100 amenazas por 1 daño. Esta configuración reduce los números de API de amenazas a los que usamos antes del parche 1.13.5"
L.general_updateFreq    = "Tiempo mínimo (en segundos) entre actualizaciones."
L.general_updateFreq_desc = "Esta configuración está destinada a limitar el consumo de CPU, cuando tc2 se actualiza en intervalos (por ejemplo, cuando está en modo targettarget). En general, los valores de amenazas no se pueden actualizar más rápido ya que la API de Blizzard los proporciona."
L.general_test          = "Activar el modo de prueba."
L.general_minimap       = "Alternar el icono del minimapa."
L.general_ignorePets    = "Ignora la amenaza de las mascotas de los jugadores."

L.visibility            = "Visibilidad"
L.visibility_hideOOC    = "Ocultar marco cuando esté fuera de combate."
L.visibility_hideSolo   = "Ocultar marco cuando no esté en un grupo."
L.visibility_hideInPvP  = "Oculta marco cuando estés en campos de batalla."
L.visibility_hideOpenWorld    = "Ocultar marco cuando no esté en una estancia (¡también oculta a los jefes del mundo!)."
L.visibility_hideAlways = "Ocultar marco siempre. /tc2 toggle"

L.profiles              = "Perfiles"

L.color                 = "Colores"

L.appearance            = "Apariencia"

L.frame                 = "Marco"
L.frame_header          = "Encabezado"
L.frame_bg              = "Fondo"
L.frame_test            = "Modo de prueba"
L.frame_strata          = "Estratos"
L.frame_scale           = "Escala"
L.frame_lock            = "Bloquear"
L.frame_headerShow      = "Mostrar Encabezado"
L.frame_headerColor     = "Color del Encabezado"
L.frame_position        = "Posición"
L.frame_width           = "Anchura"
L.frame_height          = "Altura"
L.frame_xOffset         = "Compensación X"
L.frame_yOffset         = "Compensación Y"

L.bar                   = "Barras"
L.bar_descend           = "Crecimiento inverso"
L.bar_height            = "Altura"
L.bar_padding           = "Relleno"
L.bar_texture           = "Textura"
L.bar_alpha             = "Alfa de la barra (colores predeterminados)"
L.bar_showThreatValue   = "Mostrar valor de amenaza"
L.bar_showThreatPercentage = "Mostrar porcentaje de amenaza"
L.bar_showIgniteIndicator = "Mostrar indicador de ignición"
L.bar_showIgniteIndicator_desc = "Muestra un pequeño icono de ignición al lado del nombre del jugador, que actualmente posee la ignición."

L.igniteIndicator           = "Indicador de ignición"
L.igniteIndicator_makeRound = "Hacer redondo el icono"
L.igniteIndicator_makeRound_desc = "Requiere /recargar para recrear la textura."
L.igniteIndicator_size      = "Tamaño"

L.customBarColors                   = "Colores de barra personalizados"
L.customBarColorsPlayer_enabled     = "Activar el color del jugador personalizado"
L.customBarColorsPlayer_desc        = "Esta opción establece un color fijo para el jugador independientemente de otras opciones de color."
L.customBarColorsActiveTank_enabled = "Activar el color del tanque activo personalizado"
L.customBarColorsOtherUnit_enabled  = "Activar otro color de unidad personalizado"
L.customBarColorsIgnite_enabled     = "Activar color de ignición"
L.customBarColorsIgnite_desc        = "Esto cambiará el color de la barra si la unidad posee la ignición en el objetivo. El color del jugador y el tanque tienen prioridad."
L.customBarColorsPlayer_color       = "Color del jugador"
L.customBarColorsActiveTank_color   = "Color del tanque activo"
L.customBarColorsOtherUnit_color    = "Color del otra unidad"
L.customBarColorsIgnite_color       = "Color de la unidad de ignición"

L.font          = "Fuente"
L.font_name     = "Nombre"
L.font_size     = "Tamaño"
L.font_style    = "Estilo"
L.NONE          = "NINGUNO"
L.OUTLINE       = "CONTORNO"
L.THICKOUTLINE  = "CONTORNOGRUESO"
L.font_shadow   = "Dropshadow"

L.warnings              = "Advertencias"
L.warnings_flash        = "Activar el parpadeo de la pantalla."
L.warnings_sound        = "Activar sonidos"
L.warnings_threshold    = "Umbral de advertencia (100% = agro)"
L.warnings_minThreatAmount = "Amenaza mínima para activar advertencias"
L.warnings_minThreatAmount_desc = "El valor depende de la configuración 'General -> Escalar valores de amenaza' y coincide con la amenaza mostrada. Se pueden configurar números más grandes con el cuadro de entrada."

L.warnings_soundFile    = "Archivo de sonido"
L.warnings_soundChannel = "Canal de sonido"

L.soundChannel_master   = "Maestro"
L.soundChannel_sfx      = "SFX"
L.soundChannel_ambience = "Ambiente"
L.soundChannel_music    = "Música"
