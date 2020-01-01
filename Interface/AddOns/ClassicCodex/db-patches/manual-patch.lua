-- Manually maintained database patches

-- Add missing quests
local D = CodexDB.quests.data
D[7668]={
  class=64,
  ['end']={
    U={13417},
  },
  lvl=60,
  min=58,
  obj={
    I={18880,18746},
  },
  race=178,
  start={
    U={13417},
  },
}
D[7669]={
  class=64,
  ['end']={
    U={13417},
  },
  lvl=60,
  min=58,
  race=178,
  start={
    U={13417},
  },
}
D[7670]={
  class=2,
  ['end']={
    U={928},
  },
  excl={7638},
  lvl=60,
  min=60,
  next=7637,
  race=77,
  start={
    U={5149},
  },
}

if select(4, GetAddOnInfo('MergeQuestieToCodexDB')) then return end
local D = CodexDB.units.data
-- Chief Murgut <https://classic.wowhead.com/npc=12918/chief-murgut>
D[12918].coords={
  {56.4,63.6,331,0},
}
