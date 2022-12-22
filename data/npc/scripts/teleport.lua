local lugar = {x=1039, y=1507, z=7}

local item = 2160
local quantidade = 0

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function santaNPC(cid, message, keywords, parameters, node)
if(not npcHandler:isFocused(cid)) then
return false
end
if (parameters.present == true) then
if(doPlayerRemoveItem(cid,item,quantidade) == true) then
doTeleportThing(cid, lugar)
npcHandler:say('Voce foi teleportado.',cid)
else
npcHandler:say('Voce não tem o item para ser teleportado',cid)
end
npcHandler:resetNpc()
return true
end
end

npcHandler:setMessage(MESSAGE_GREET, "Ola|PLAYERNAME|. Eu posso te levar para alguns lugares,fale {lugar}.")

local noNode = KeywordNode:new({'no'}, santaNPC, {present = false})
local yesNode = KeywordNode:new({'yes'}, santaNPC, {present = true})

local node = keywordHandler:addKeyword({'lugar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Vou te levar para um lugar,digite {yes}'})
node:addChildKeywordNode(yesNode)
node:addChildKeywordNode(noNode)
npcHandler:addModule(FocusModule:new())