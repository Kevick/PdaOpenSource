local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function doBuyPokemonWithCasinoCoins(cid, poke) npcHandler:onSellpokemon(cid) end
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

function creatureSayCallback(cid, type, msg)

if(not npcHandler:isFocused(cid)) then
return false
end


local function givePokemon(cid)
local pokemon = "Aerodactyl"
local gender = getRandomGenderByName(pokemon)
local btype = "normal"
local happy = 220

if getPlayerFreeCap(cid) >= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
   item = doCreateItemEx(11826)
else
    item = doAddContainerItem(getPlayerSlotItem(cid, 3).uid, 11826, 1) 
end

doItemSetAttribute(item, "poke", pokemon)
doItemSetAttribute(item, "hp", 1)
doItemSetAttribute(item, "happy", happy)
doItemSetAttribute(item, "gender", gender)
doItemSetAttribute(item, "description", "Contains a "..pokemon..".")
doItemSetAttribute(item, "fakedesc", "Contains a "..pokemon..".")

if getPlayerFreeCap(cid) >= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
   doPlayerSendMailByName(getCreatureName(cid), item, 1)
end
doPlayerRemoveItem(cid, rock, 100)   --aki tira as rocks
doPlayerRemoveItem(cid, old, 1)      --aki tira o old
selfSay("So there is it! Take this pokemon, I think he will be better with you!", cid)
setPlayerStorageValue(cid, 345965, 2)   --storage da quest
end

rock = 11445    --id da rock stone
old = 12581         --id do old amber.. 

if msgcontains(string.lower(msg), 'help') or msgcontains(string.lower(msg), 'ajuda') then
    selfSay("Hum... I need some itens to mys researches... Can you bring to me a Old Amber and 100 rock stones?", cid)
    talkState[talkUser] = 1
elseif (msgcontains(string.lower(msg), 'yes') or msgcontains(string.lower(msg), 'sim')) and talkState[talkUser] == 1 then
    if getPlayerStorageValue(cid, 345965) <= 0 then
       selfSay("Ok then go and bring this itens to me and maybe we can revive a old and rare Pokemon!!", cid)
       setPlayerStorageValue(cid, 345965, 1)
       talkState[talkUser] = 0
       return true
    elseif getPlayerStorageValue(cid, 345965) == 1 then
       if getPlayerItemCount(cid, rock) >= 100 and getPlayerItemCount(cid, old) >= 1 then   --ta pedindo 100Rocks e 1 Old amber...
          selfSay("Wow then you got the items! Let me see if I could relive that pokemon!", cid)
          addEvent(givePokemon, 2000, cid)
          talkState[talkUser] = 0
          return true
       else
          selfSay("You don't have my itens yet... Come back when you get them!!", cid)
          talkState[talkUser] = 0
          return true
       end
    elseif getPlayerStorageValue(cid, 345965) == 2 then                        --no caso soh da pra fazer isso 1x por char...
       selfSay("Hummm.. You already help me, don't you? Thanks again.. but now i can't talk with you...", cid)
       talkState[talkUser] = 0
       return true
    end     
end

return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())