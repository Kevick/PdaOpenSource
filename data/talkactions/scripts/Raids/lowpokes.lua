function onSay(cid, words, param, channel)

local pos_invas = {x=1021,y=1029,z=7}
local monster1 = "Poliwhirl"
local monster2 = "Squirtle"
local monster3 = "Bulbasaur"
local monster4 = "Kadabra"
local monster5 = "Shiny Electrode"
local mensage1 = "Saffron City esta siendo Invadida!!"

broadcastMessage(mensage1, MESSAGE_EVENT_ADVANCE)
doSummonCreature(monster1, {x=pos_invas.x, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x, y=pos_invas.y+3, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+3, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x-3, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+5, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x-5, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+7, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+9, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+11, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x+13, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x+14, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x+15, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x+16, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x+17, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster44, {x=pos_invas.x+18, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster4, {x=pos_invas.x+19, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster4, {x=pos_invas.x+20, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster4, {x=pos_invas.x+21, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster4, {x=pos_invas.x+22, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster4, {x=pos_invas.x+23, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster4, {x=pos_invas.x+24, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster5, {x=pos_invas.x+25, y=pos_invas.y, z=pos_invas.z})

end