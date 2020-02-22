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

-- Add missing objects of quests
D[1367].obj = {
  U={4646,4647,4648,4649,4651,4652,4653,4661},
}
D[1368].obj = {
  U={4638,4639,4640,4641,4642,4643,4644,4645},
}

-- Alliance-specific patches
if select(4, GetAddOnInfo('MergeQuestieToCodexDB')) then return end
local D = CodexDB.units.data

if UnitFactionGroup('player') == 'Alliance' then
  D[13778].coords={
    {48.5,58.3,2597,0}, --add
    {50.2,65.3,2597,0}, --add
    {49.3,84.4,2597,0}, --add
    {48.3,84.3,2597,0}, --add
  }
end
