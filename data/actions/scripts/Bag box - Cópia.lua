local card_id = {13994, 13980, 13987, 13959, 13966, 13973, 13952, 13945} -- joga os id dos card aqui
function onUse(cid, item, frompos, item2, topos)
local level = 10 -- level
if item.itemid == 14155 then -- id da box
if getPlayerLevel(cid) >= level then
local w = math.random (1,#card_id)
doPlayerAddItem(cid, card_id[w])
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"Vc Abriu um Held Box T5 e ganhou  >>> ["..getItemNameById(card_id[w]).."] <<<")
doRemoveItem(item.uid, 1)
else
doPlayerSendCancel(cid,"You must be at least level "..level.."")
end return true end  end