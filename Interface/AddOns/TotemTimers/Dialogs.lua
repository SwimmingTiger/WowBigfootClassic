local LibDialog = LibStub:GetLibrary("LibDialog-1.0")

LibDialog:Register("XiTimers_Spells", {
	text = "Drag spells from your spellbook to create timers for them and their buffs/effects.",	
	buttons = {
		{
			text = "Lock Spells",
			on_click = function(self, mouseButton, down)
				XiTimers.HideGrid()
				LibDialog:Dismiss("XiTimers_Spells")
			end,
		},
	}
})

LibDialog:Register("XiTimers_Bars", {
	text = "You can drag the bars around or center them with the rightclick menu.",	
	buttons = {
		{
			text = "Lock Bars",
			on_click = function(self, mouseButton, down)
				XiTimers.LockBars()
				LibDialog:Dismiss("XiTimers_Bars")
			end,
		},
	}
})

