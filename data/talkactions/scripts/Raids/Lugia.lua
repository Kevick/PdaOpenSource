function onSay(cid, words, param, channel)

local pos_invas = {x=1021,y=1029,z=7}
local monster1 = "Lugia"
local mensage1 = "Lugia ha Aparecido en Saffron!"


broadcastMessage(mensage1, MESSAGE_EVENT_ADVANCE)
doSummonCreature(monster1, {x=pos_invas.x, y=pos_invas.y, z=pos_invas.z})

end