local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()    
if getCreatureLookDir(getNpcCid()) ~= 2 then
doCreatureSetLookDir(getNpcCid(), 2)
end
npcHandler:onThink()     
end

npcHandler:addModule(FocusModule:new())
