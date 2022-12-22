function onSay(cid, words, param)
local storage = 23585
local tempo = 1800
local cidade = getPlayerTown(cid)
local pos = getTownTemplePosition(cidade)
if exhaustion.check(cid, storage) then
doPlayerSendTextMessage(cid, 22, "Espere 30 minutos desde a ultima vez que usou!")
return false
end
doTeleportThing(cid, pos)
exhaustion.set(cid, storage, tempo)
doSendAnimatedText(getThingPosWithDebug(cid), "Desbugado!", COLOR_BURN)
addEvent(doRemoveCreature, 1000, cid)
end