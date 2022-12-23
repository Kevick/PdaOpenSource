local ballcatch = {                    --id normal, id da ball shiy
[2394] = {cr = 4, on = 193, off = 192, ball = {11826, 11737}, send = 47, typeee = "normal", boost = "0"},  --alterado v1.9  \/
[2391] = {cr = 5, on = 198, off = 197, ball = {11832, 11740}, send = 48, typeee = "great", boost = "0"},
[2393] = {cr = 8, on = 202, off = 201, ball = {11835, 11743}, send = 46, typeee = "super", boost = "0"},
[2392] = {cr = 16, on = 200, off = 199, ball = {11829, 11746}, send = 49, typeee = "ultra", boost = "0"},
[12617] = {cr = 7, on = 204, off = 203, ball = {10975, 12621}, send = 35, typeee = "saffari", boost = "0"}, 
[12832] = {cr = 100000, on = 23, off = 24, ball = {12826, 12829}, send = 181, typeee = "dark", boost = "50"},
}

function onUse(cid, item, frompos, item3, topos)

local item2 = getTopCorpse(topos)
if item2 == null then
   return true
end

if getItemAttribute(item2.uid, "catching") == 1 then
   return true
end  

if getItemAttribute(item2.uid, "golden") and getItemAttribute(item2.uid, "golden") == 1 then
   return doPlayerSendCancel(cid, "You can't try to catch a pokemon in the Golden Arena!")   
end

local name = string.lower(getItemNameById(item2.itemid))
      name = string.gsub(name, "fainted ", "")
      name = string.gsub(name, "defeated ", "")
      name = doCorrectPokemonName(name)
local x = pokecatches[name]

if not x then return true end

local shinys = {"Shiny Alakazam", "Shiny Scyther", "Shiny Electivire", "Shiny Magmortar", "Shiny Salamence", "Shiny Magmar", "Shiny Mantine", "Shiny Gyarados", "Shiny Snorlax", "Shiny Onix", "Shiny Electabuzz", "Shiny Pidgeot", "Aerodactyl", "Ditto", "Shiny Gengar"}
if item.itemid == 12832 and isInArray(shinys, name) then
   doPlayerSendCancel(cid, "Você não pode catar esse pokemon com a master ball!")
return true
end
	
local storage = newpokedex[name].stoCatch 
if getPlayerStorageValue(cid, storage) == -1 or not string.find(getPlayerStorageValue(cid, storage), ";") then  --alterado v1.9 
   setPlayerStorageValue(cid, storage, "normal = 0, great = 0, super = 0, ultra = 0, saffari = 0, dark = 0;")             --alterado v1.9 
end     

local owner = getItemAttribute(item2.uid, "corpseowner")
	
if owner and isCreature(owner) and isPlayer(owner) and cid ~= owner then   
   doPlayerSendCancel(cid, "You are not allowed to catch this pokemon.")
   return true
end

local newidd = isShinyName(name) and ballcatch[item.itemid].ball[2] or ballcatch[item.itemid].ball[1] --alterado v1.9       
local typeee = ballcatch[item.itemid].typeee
local boost = ballcatch[item.itemid].boost
	

local catchinfo = {}
      catchinfo.rate = ballcatch[item.itemid].cr
      catchinfo.catch = ballcatch[item.itemid].on
      catchinfo.fail = ballcatch[item.itemid].off
      catchinfo.newid = newidd                      
      catchinfo.name = doCorrectPokemonName(name)
      catchinfo.topos = topos
      catchinfo.chance = x.chance

doSendDistanceShoot(getThingPos(cid), topos, ballcatch[item.itemid].send)
doRemoveItem(item.uid, 1)

-- Caught Window System
CaughtWindow.ballcount(cid, catchinfo.name, item.itemid)

local d = getDistanceBetween(getThingPos(cid), topos)
		
if getPlayerStorageValue(cid, 98796) >= 1 and getPlayerItemCount(cid, 12617) <= 0 then  --alterado v1.9
   setPlayerStorageValue(cid, 98796, -1) 
   setPlayerStorageValue(cid, 98797, -1)                                              
   doTeleportThing(cid, SafariOut, false)
   doSendMagicEffect(getThingPos(cid), 21)
   doPlayerSendTextMessage(cid, 27, "You spend all your saffari balls, good luck in the next time...")
end

addEvent(doSendPokeBall, d * 70 + 100 - (d * 14) , cid, catchinfo, false, false, typeee) 
addEvent(doSendMagicEffect, (d * 70 + 100 - (d * 14)) - 100, topos, 3)
return true
end