-- Last update by GlitterStorm @ Azralon on Feb,28th,2015
if GetLocale() ~= "ptBR" then return end
if not DBM_COMMON_L then DBM_COMMON_L = {} end

local CL = DBM_COMMON_L

CL.UNKNOWN							= "desconhecido"
CL.LEFT								= "Esquerda"
CL.RIGHT								= "Direita"
CL.BACK								= "Atrás"
CL.FRONT								= "A frente"
CL.INTERMISSION						= "Intermissão"--No blizz global for this, and will probably be used in most end tier fights with intermission phases
