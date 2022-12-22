function onUse(cid, item, frompos, item2, topos) 
local level = 400
local msgsucess = "Bem vindo a Liga Pokemon!" -- mensagem que vai aparece caso ele passar pela porta 
local msgfault = "Você Precisa de level 400 pra entrar Na Liga Pokemon!" -- mensagem que ira aparecer caso ele nao tiver o level
local sto_ceru = 4452 
local pos = {x=653, y=1176, z=5}  -- 
if getPlayerLevel(cid) >= level then 
setPlayerStorageValue(cid, sto_ceru, 1)	
doTransformItem(item.uid, item.itemid)
doTeleportThing(cid,pos)
doSendMagicEffect(topos, 12)
doPlayerSendTextMessage(cid, 22, msgsucess) 
else 
doPlayerSendTextMessage(cid, 22, msgfault) 
end 
         if getPlayerStorageValue(cid, sto_ceru) >= 1 then
         sendMsgToPlayer(cid, 27, "Desculpe você ja terminou essa quest!")
         return true
		 end
return TRUE 
end 
