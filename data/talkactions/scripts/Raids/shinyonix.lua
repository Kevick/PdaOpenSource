function onSay(cid, words, param, channel)

local pos_invas = {x=1021,y=1029,z=7}
local monster1 = "Shiny Onix"
local monster2 = "Onix"
local mensage1 = "Shiny Onix ha Aparecido en Saffron! "

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
doSummonCreature(monster2, {x=pos_invas.x+13, y=pos_invas.y, z=pos_invas.z})

end