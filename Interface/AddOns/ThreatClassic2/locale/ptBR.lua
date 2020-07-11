local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "ptBR" and TC2.locale ~= "ptPT" then return end

-----------------------------
--	ptBR and ptPT clients
-----------------------------
-- main frame
L.gui_threat		= "Ameaça"
