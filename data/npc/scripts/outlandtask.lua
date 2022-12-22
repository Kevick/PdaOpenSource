local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
 
local task = {
["Outland Task"] = {{"Brute Rhydon", 150}, {"Hard Golem", 150}, {"Ancient Alakazam", 150},{"Tribal Xatu", 150},{"Ancient Dragonite", 150},{"Ancient Kingdra", 150},{"Milch-Miltank", 150},{"War Granbull", 150},{"Aviator Pidgeot", 150},{"Brave Noctowl", 100},{"150 Lava Magmar", 150},{"Wardog Arcanine", 150},{"Roll Donphan", 150},{"Furious Sandslash", 150},{"Freezing Dewgong", 120},{"Evil Cloyster", 120},{"Ancient Meganium", 150},{"Brave Venusaur",150},{"Tribal Feraligatr", 150},{"Brave Blastoise", 150},{"War Heracross", 150},{"Furious Scyther", 150},{"Box Hitmonchan", 150},{"Taekwondo Hitmonlee", 150},{"Brave Nidoking",150 },{"Brave Nidoqueen", 150}},
}
       
        if msgcontains(msg, 'task') or msgcontains(msg, 'Task') then
           if isMyTaskComplete(cid, getNpcCid()) then
              selfSay("Wow you have already complete my task! Ok then, take your reward!", cid)
              doPlayerAddItem(cid, 12832, 1)  --premio
              doPlayerAddItem(cid, 14187, 1)
              local sto = getMyTaskSto(cid, getNpcCid())
              setPlayerStorageValue(cid, sto, -1)
              talkState[talkUser] = 0
              return true
           else
              selfSay("Then, is a simple task, i want to you kill {150 Brute Rhydon, 150 Hard Golem, 150 Ancient Alakazam, 150 Tribal Xatu,150 Ancient Dragonite, 150 Ancient Kingdra,150 Milch-Miltank, 150 War Granbull,150 Aviator Pidgeot, 100 Brave Noctowl,150 Lava Magmar, 150 Wardog Arcanine,150 Roll Donphan,150 Furious Sandslash,120 Freezing Dewgond,120 Evil Cloyster,150 Ancient Meganium,150 Brave Venusaur,150 Tribal Feraligatr,150 Brave Blastoise,150 War Heracross,150 Furious Scyther,150 Box Hitmonchan,150 Taekwondo Hitmonlee,150 Brave Nidoking,150 Brave Nidoqueen }, you accept the task?", cid)
              talkState[talkUser] = 2  
           end   
        elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'Yes')) and talkState[talkUser] == 2 then
           if getMyTaskSto(cid, getNpcCid()) ~= -1 then
              selfSay("You are already doing my task! go end it!", cid)
              talkState[talkUser] = 0
              return true
           end
           local sto = getFreeTaskStorage(cid)
           if sto == -1 then 
              selfSay("You can't catch more tasks! You are already with the maximum of "..(maxTasks).." tasks!", cid)
              talkState[talkUser] = 0
              return true
           end
                  
           selfSay("OK then... Go kill your targets!", cid)
           setStorageArray(cid, sto, task)
           talkState[talkUser] = 0
           return true
        end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())             