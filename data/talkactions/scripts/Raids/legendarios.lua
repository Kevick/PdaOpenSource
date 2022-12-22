function onSay(cid, words, param, channel)

local pos_invas = {x=1021,y=1029,z=7}
local monster1 = "Moltres"
local monster2 = "Zapdos"
local monster3 = "Articuno"
local mensage1 = "Aves Legendarias Aparecieron en Saffron!"

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
doSummonCreature(monster3, {x=pos_invas.x+18, y=pos_invas.y, z=pos_invas.z})

end