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

local storage = 79464 -- Storage pra não fazer mais a task.
local task = {
["Maggie"] = {{"Venusaur", 10}},

}        
        if getPlayerStorageValue(cid, storage) >= 1 then
            selfSay('Você aqui de novo? você ja terminou sua task!!', cid)
            return true
        end
       
        if msgcontains(msg, 'task') or msgcontains(msg, 'Task') then
           if isMyTaskComplete(cid, getNpcCid()) then
              selfSay("Wow você conseguio! Ok then, Pega sua recompença!", cid)
              doPlayerAddItem(cid, 2160, 3) -- Primeiro premio.
              doPlayerAddExp(cid, 650000) -- Experiencia.
              local sto = getMyTaskSto(cid, getNpcCid())
              setPlayerStorageValue(cid, sto, -1)
              setPlayerStorageValue(cid, storage, 1)
              talkState[talkUser] = 0
              return true
           else
              selfSay("Then, is a simple task, i want to you kill {100 Blastoises}, you accept the task?", cid)
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