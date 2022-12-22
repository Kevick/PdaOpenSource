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
local tasks = {
["blastoise"] = {["Dailly"] = {{"Blastoise", 300}}}, --modifiquei aki, mas n sei se vai da certo kk
["electabuzz"] = {["Daily"] = {{"Electabuzz", 300}}},
["venusaur"] = {["Dailly"] = {{"Venusaur", 300}}},
["charizard"] = {["Dailly"] = {{"Charizard", 300}}},
}
local msg = msg:lower() --eh sempre bom por isso.. pra deixar a msg soh em letras minusculas


if msgcontains(msg, "task") then
   if isMyTaskComplete(cid, getNpcCid()) then
          selfSay("Wow you have already complete my task! Ok then, take your reward!", cid)
          doPlayerAddExperience(cid, 1500000) --premio
          doPlayerAddItem(cid, 2160, 25)

          local sto = getMyTaskSto(cid, getNpcCid())
          setPlayerStorageValue(cid, sto, -1) --nunca esqueça disso...
          setPlayerStorageValue(cid, 25566, os.time() + 24*60*60)
              setPlayerStorageValue(cid, 181601, 1) --storage da outfit
              setPlayerStorageValue(cid, 181602, 1) --storage da outfit
          talkState[talkUser] = 0
          return true
   elseif getPlayerStorageValue(cid, 25566) > os.time() then
          selfSay("You have to wait 24h to do my task again!", cid)
          talkState[talkUser] = 0
          return true
   elseif getMyTaskSto(cid, getNpcCid()) ~= -1 then
          selfSay("You are already doing my task! Go end it!", cid)
          talkState[talkUser] = 0
          return true
   end
   selfSay("What task do you want? {blastoise}, {electabuzz}, {venusaur}, {charizard}", cid)
   talkState[talkUser] = 1
   return true
elseif isInArray({"blastoise", "electabuzz", "venusaur", "charizard"}, msg) and talkState[talkUser] == 1 then
   task = tasks[msg] --modifiquei aki tb
   selfSay("Are you sure?", cid)
   talkState[talkUser] = 2
   return true
elseif msgcontains(msg, "yes") and talkState[talkUser] == 2 then
   local sto = getFreeTaskStorage(cid)
   if sto == -1 then
          selfSay("You can't catch more tasks! You are already with the maximum of "..(maxTasks).." tasks!", cid)
          talkState[talkUser] = 0
          return true
   end
   selfSay("OK kill 300, good luck!", cid)
   setStorageArray(cid, sto, task)
   talkState[talkUser] = 0
   return true
end

return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())