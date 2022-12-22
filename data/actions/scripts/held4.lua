local card_id = {13944, 13951, 13972, 13986, 13979, 13993} -- joga os id dos card aqui
function onUse(cid, item, frompos, item2, topos)
local level = 100 -- level
if item.itemid == 14186 then -- id da box
if getPlayerLevel(cid) >= level then
local w = math.random (1,#card_id)
doPlayerAddItem(cid, card_id[w])
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"Vc Abriu um Held Box T4 e ganhou  >>> ["..getItemNameById(card_id[w]).."] <<<")
doRemoveItem(item.uid, 1)
else
doPlayerSendCancel(cid,"You must be at least level "..level.."")
end return true end  end