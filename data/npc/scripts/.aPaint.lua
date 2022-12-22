local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()	 npcHandler:onThink()	end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_GREET, 'Bem-vindo à minha loja de pintura |PLAYERNAME|, Fale {Paint} para pintar!')
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local pokesalive = {'11826', '11829', '11835', '11832', '10975', '11740', '11743', '11746', '12621', '11737', '12826', '12829'}
if(msgcontains(msg, 'paint')) then
selfSay('Você quer pintar a sua pokeball?', cid)
talkState = 1
elseif(msgcontains(msg, 'yes') and talkState == 1) then
selfSay('Olá, você pode escolher: Saffari ball, Ultra ball, Great ball , Super ball', cid)
talkState = 2
elseif(msgcontains(msg, 'no') and talkState == 1) then
selfSay('Volte outra vez!', cid)
talkState = 0
npcHandler:releaseFocus(cid)
elseif((msgcontains(msg, 'Saffariball') or msgcontains(msg, 'Saffari ball') or msgcontains(msg, 'saffariball') or msgcontains(msg, 'saffari ball')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Saffari Ball? Ele vai te custar 100 dólares!', cid)
talkState = 3
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 3) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,10000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma saffariball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 10975)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end
elseif((msgcontains(msg, 'Ultraball') or msgcontains(msg, 'Ultra ball') or msgcontains(msg, 'ultraball') or msgcontains(msg, 'ultra ball')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Ultraball? Ele vai te custar 200 dólares!', cid)
talkState = 4
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 4) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,20000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Ultraball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 11829)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end
elseif((msgcontains(msg, 'Greatball') or msgcontains(msg, 'Great ball') or msgcontains(msg, 'great ball') or msgcontains(msg, 'greatball')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Greatball? Ele vai te custar 300 dólares!', cid)
talkState = 5
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 5) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,30000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Greatball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 11832)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end
elseif((msgcontains(msg, 'Super ball') or msgcontains(msg, 'Superball') or msgcontains(msg, 'super ball') or msgcontains(msg, 'superball')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Superball? Ele vai te custar 400 dólares!', cid)
talkState = 6
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 6) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,40000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Superball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 11835)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end

elseif((msgcontains(msg, '.darkball') or msgcontains(msg, '.dark ball') or msgcontains(msg, '.Darkball') or msgcontains(msg, '.Dark ball')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Darkball? Ele vai te custar 700 dólares!', cid)
talkState = 7
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 7) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,70000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Darkball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 12826)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end

elseif((msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Loveball? Ele vai te custar 300 dólares!', cid)
talkState = 8
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 8) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,30000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Loveball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 12593)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end

elseif((msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Luaball? Ele vai te custar 700 dólares!', cid)
talkState = 9
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 9) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,70000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Luaball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 12596)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end

elseif((msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2') or msgcontains(msg, 'monkzito2')) and talkState == 2) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
selfSay('Você realmente quer pintar a sua bola como um Duskball? Ele vai te custar 500 dólares!', cid)
talkState = 10
else
selfSay('Você deve colocar a bola fechada no slot.', cid)
talkState = 0
end
elseif(msgcontains(msg, 'yes') and talkState == 10) then
if isInArray(pokesalive, getPlayerSlotItem(cid,8).itemid) then
if doPlayerRemoveMoney(cid,50000) == true then
selfSay('Boa escolha, a partir de agora um, ele vai olhar como uma Duskball! Há qualquer outra coisa que eu possa ajudá-lo?', cid)
doTransformItem(getPlayerSlotItem(cid, 8).uid, 12599)
talkState = 0
else
selfSay('Sorry '.. getCreatureName(cid) ..', mas você não tem dinheiro suficiente.', cid)
talkState = 0
end
else
selfSay('Por favor, mantenha sua bola fechada na slot.', cid)
talkState = 0
end
end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())