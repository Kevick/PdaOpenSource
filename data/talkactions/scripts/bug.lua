function onSay(cid, words, param)
pos = {x=1276, y=1006, z=7}  --> vermelho
doSendMagicEffect(getPlayerPosition(cid),53) --> azul
doPlayerSendCancel(cid,"Teleportado!") -->  verde
doTeleportThing(cid,pos)
end