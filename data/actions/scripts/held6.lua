local card_id = {13995, 13981, 13988, 13967, 13974, 13953, 13946} -- joga os id dos card aqui
function onUse(cid, item, frompos, item2, topos)
local level = 100 -- level
if item.itemid == 14187 then -- id da box
if getPlayerLevel(cid) >= level then
local w = math.random (1,#card_id)
doPlayerAddItem(cid, card_id[w])
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"Vc Abriu um Held Box T6 e ganhou  >>> ["..getItemNameById(card_id[w]).."] <<<")
doRemoveItem(item.uid, 1)
else
doPlayerSendCancel(cid,"You must be at least level "..level.."")
end return true end  end