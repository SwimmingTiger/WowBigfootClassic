local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "esES" and TC2.locale ~= "esMX" then return end

-----------------------------
--	esES and esMX clients
-----------------------------
-- main frame
L.gui_threat		= "Amenaza"
