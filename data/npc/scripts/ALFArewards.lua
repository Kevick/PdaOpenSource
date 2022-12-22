local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function doBuyPokemonWithCasinoCoins(cid, poke) npcHandler:onSellpokemon(cid) end
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)

if(not npcHandler:isFocused(cid)) then
return false
end

premio = {      --id box / qntdade / id balls
[-1] = {premio = {12339, {1, 14188}}, level = 250}, --Boosted
[0] = {premio = {12331, {1, 14186}}, level = 300}, --Box 5
[1] = {premio = {12832, {1, 14185}}, level = 350}, --MB
[2] = {premio = {12227, {1, 14187}}, level = 400}  --S.B
}

if msgcontains(string.lower(msg), 'rewards') or msgcontains(string.lower(msg), 'reward') then
    if premio[getPlayerStorageValue(cid, 85498)] then
       reward = premio[getPlayerStorageValue(cid, 85498)]
       if getPlayerLevel(cid) >= reward.level then
          selfSay("Wow you have reached the level "..reward.level.."! Take your reward!", cid)
          doPlayerAddItem(cid, reward.premio[1], 1)
          doPlayerAddItem(cid, reward.premio[2][2], reward.premio[2][1])
          setPlayerStorageValue(cid, 85498, getPlayerStorageValue(cid, 85498)+1)
       else
          selfSay("You need to be level "..reward.level.." to take your reward!", cid) 
          return true
       end
    else      
       selfSay("You have already take all rewards!", cid)
       return true
    end
end

return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())