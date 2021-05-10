
function BF_GetCvar()
	local synchronizeBindings = GetCVar("synchronizeBindings")
	local synchronizeConfig = GetCVar("synchronizeConfig")
	local synchronizeMacros = GetCVar("synchronizeMacros")
	local synchronizeSettings = GetCVar("synchronizeSettings")
	print("synchronizeBindings=" .. synchronizeBindings)
	print("synchronizeConfig=" .. synchronizeConfig)
	print("synchronizeMacros=" .. synchronizeMacros)
	print("synchronizeSettings=" .. synchronizeSettings)
end