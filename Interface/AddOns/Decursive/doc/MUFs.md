The Micro-Unit Frames (MUFs)
============================

Decursive makes your life easier, it [clearly shows you who is afflicted][curseexemple1] by
something you can remove, this is done using **Micro-unit-frames (MUFs)**.

A micro-unit-frame is a little square on your screen that *changes its appearance
according to the unit status*.  If you click on a MUF, it casts a cleaning
spell, **the choice of the spell depends of the mouse button you click**, Decursive
manages the button mapping automatically.

 MUFs have several colors ([which can be configured][mufscolors]):

 - **Full red**: the unit is in range and is afflicted by something you can cure by
   left-clicking on the MUF.

 - **Transparent red**: the unit is out of range and afflicted by something you could
   cure by left-clicking on the MUF

 - **Full blue**: idem as red but with right-clicking instead of left-clicking.

 - **Full orange**: idem as blue or red but with ctrl-left-clicking.

 - **Transparent grey**: The unit does not exists anymore.

 - **Dark Transparent green**: the unit is in scan range and is not afflicted by
   something you can cure.

 - **Transparent purple**: The unit is too far to be scanned or cured.

 - **Transparent light-green**: The unit is cloaked.

 - **Any color with a little green square in the middle**: the unit is
   Mind-Controlled (Charmed).

 - **Black**: the unit has been blacklisted because it was *out of line of sight* when you
   tried to cure it, the time in blacklist can be change in the options.

*The information above are also indicated by tool-tips in the game when you hover the MUFs.*

*MUFs display is done according to your settings*, **you can change every aspects
of the MUFs** (size, spacing, number, colors, grow directions, etc...), look in the [*Micro unit
frame* configuration options][mufsdisplayopts].

MUFs are very discreet when no action is required, you can see right through
them.

*You can change the spell mapping when you are not in combat*, **the mapping is
done according to your [cure priorities][cureopts]** ; go to the "[curing options][cureopts]", the
priorities are indicated by green numbers in front of the affliction types.

Besides casting, MUFs allow you to *target* the units by *Middle-clicking*,
*Ctrl-Middle-Clicking* will focus them. (To clear the focused unit, use the
command /clearfocus)
Mouse button mapping can be [completely customized][mufsmousebuttons].

**MUFs are organized intelligently by default**, you're always first then the rest
of your group, the groups after yours, the group before yours and the **pets (you
can choose to monitor them or not)** and, at last, your focused unit (changed
using the command /focus 'name' or by *Ctrl-Middle-Clicking* on a MUF).
**You can completely change this order by using the [priority and skip list][prioskipopts], a
very manageable list of players.** (see [Decursive usage][user-actions] for more information)

**IMPORTANT:**

TO MOVE THE MUFS, ALT-CLICK AND HOLD THE HANDLE JUST ABOVE THE FIRST MUF (IT
HAS THE SAME SIZE AS A MUF AND HIGHLIGHTS WHEN YOUR MOUSE POINTER IS OVER IT).

*This handle has several uses, a tool-tip explains them all.*

*See also:*

- [Decursive usage][user-actions]
- [Decursive Macro documentation][mouse-over macro]
- [Frequently Asked Questions][FAQ] *try this before asking any question*
- [commands][]




[MUFs]: http://www.wowace.com/projects/decursive/pages/main/mufs "Micro Unit Frames"
[MUF]: http://www.wowace.com/projects/decursive/pages/main/mufs "Micro Unit Frame"
[FAQ]: http://www.wowace.com/projects/decursive/pages/main/faq "F.A.Q section"
[mouse-over macro]: http://www.wowace.com/projects/decursive/pages/main/macro "Decursive's mouse-over macro documentation"
[commands]: http://www.wowace.com/projects/decursive/pages/main/commands "Command lines"
[user-actions]: http://www.wowace.com/projects/decursive/pages/main/user-actions "Decursive, user possible actions"

[cureopts]: http://www.wowace.com/addons/decursive/images/12-decursives-option-panels-curing/
[filteropts]: http://www.wowace.com/addons/decursive/images/11-decursives-option-panels-affliction-filtering/
[prioskipopts]: http://www.wowace.com/addons/decursive/images/22-priority-and-skip-list-management-interface/
[curseexemple1]: http://www.wowace.com/addons/decursive/images/7-curse-affliction-1/
[mufsdisplayopts]: http://www.wowace.com/addons/decursive/images/19-decursives-option-panels-mufs-display/
[mufscolors]: http://www.wowace.com/addons/decursive/images/18-decursives-option-panels-mufs-colors/
[mufsmousebuttons]: http://www.wowace.com/addons/decursive/images/20-decursives-option-panels-mufs-mouse-buttons/
