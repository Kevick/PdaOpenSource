function onSay(cid, words, param, channel)

local pos_invas = {x=1021,y=1029,z=7}
local monster1 = "Meganium"
local monster2 = "Fereligatr"
local monster3 = "Typhlosion"
local mensage1 = "Una oleada de pokemones aparecieron en Saffron!"

broadcastMessage(mensage1, MESSAGE_EVENT_ADVANCE)
doSummonCreature(monster2, {x=pos_invas.x, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x, y=pos_invas.y+3, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+3, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x-3, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+5, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x-5, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+7, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+9, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+11, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster2, {x=pos_invas.x+13, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x-8, y=pos_invas.y, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y+5, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y-5, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y-7, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y-9, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y-11, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y-13, z=pos_invas.z})
doSummonCreature(monster3, {x=pos_invas.x, y=pos_invas.y-15, z=pos_invas.z})
doSummonCreature(monster1, {x=pos_invas.x, y=pos_invas.y, z=pos_invas.z})

end