local fishing = {
[-1] = { segs = 5, pokes = {{"Magikarp", 5}} },

[3976] = { segs = 5, pokes = {{"Horsea", 5}, {"Remoraid", 3}, {"Goldeen", 3}, {"Poliwag", 2}, {"Swinub", 2}} },  -- pega no client da pxg

[12855] = { segs = 5, pokes = {{"Tentacool", 3}, {"Staryu", 2}, {"Krabby", 3}, {"Shellder", 2}, {"Omanyte", 3}} },

[12854] = { segs = 5, pokes = {{"Seel", 2}, {"Chinchou", 2}, {"Slowpoke", 2}, {"Kabuto", 2}, {"Psyduck", 2}, {"Wooper", 2}} },

[12858] = { segs = 5, pokes = {{"Seaking", 2}, {"Seadra", 2}, {"Poliwhirl", 2}, {"Squirtle", 2}, {"Totodile", 2}} },

[12857] = { segs = 5, pokes = {{"Starmie", 2}, {"Kingler", 2}, {"Corsola", 2}, {"Qwilfish", 2}} },  -- pega no client da pxg

[12860] = { segs = 5, pokes = {{"Lanturn", 2}, {"Dewgong", 2}, {"Slowbro", 2}, {"Azumarill", 2}} },

[12859] = { segs = 5, pokes = {{"Cloyster", 2}, {"Poliwrath", 2}, {"Politoed", 2}, {"Octillery", 2}} },

[12856] = { segs = 5, pokes = {{"Dratini", 3}, {"Quagsire", 2}, {"Dragonair", 2}, {"Omastar", 2}, {"Lapras", 1}} },

[12853] = { segs = 5, pokes = {{"Gyarados", 3}, {"Mantine", 3}, {"Tentacruel", 3}, {"Kingdra", 3}, {"Giant Magikarp", 3}, {"Feraligatr", 3}, {"Blastoise", 3}} },
}

local storageP = 154585
local sto_iscas = 5648454 --muda aki pra sto q ta no script da isca
local bonus = 15
local limite = 100


local function doFish(cid, pos, ppos, interval)
      if not isCreature(cid) then return false end
      if getThingPos(cid).x ~= ppos.x or getThingPos(cid).y ~= ppos.y then
         return false 
      end
      
      doSendMagicEffect(pos, CONST_ME_LOSEENERGY)
      
      if interval > 0 then
         addEvent(doFish, 1000, cid, pos, ppos, interval-1)
         return true
      end   

      local peixe = 0
      local playerpos = getClosestFreeTile(cid, getThingPos(cid))
      local fishes = fishing[getPlayerStorageValue(cid, sto_iscas)]
      local random = {}   

      if getPlayerSkillLevel(cid, 6) < limite then 
         doPlayerAddSkillTry(cid, 6, bonus * 5)
      end
	  
	     --[[if math.random(1, 100) <= chance then
		if getPlayerSkillLevel(cid, 6) < limite then
		doPlayerAddSkillTry(cid, 6, bonus * 5)
		end]]
	  
      random = fishes.pokes[math.random(#fishes.pokes)]
	  
      for i = 1, math.random(random[2]) do
          peixe = doSummonCreature(random[1], playerpos)
          if not isCreature(peixe) then
             setPlayerStorageValue(cid, storageP, -1)
             doRemoveCondition(cid, CONDITION_OUTFIT)
             return true
          end
          doSetMonsterPassive(peixe)
          doWildAttackPlayer(peixe, cid)
          doCreatureSetLookDir(cid, getDirectionTo(getThingPos(cid), getThingPos(peixe)))  --alterado ver depois
	      if #getCreatureSummons(cid) >= 1 then
             doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 0)
		     doChallengeCreature(getCreatureSummons(cid)[1], peixe)
          else	
             doSendMagicEffect(getThingPos(cid), 0)
		     doChallengeCreature(cid, peixe)
          end
       end
       setPlayerStorageValue(cid, storageP, -1)
       doRemoveCondition(cid, CONDITION_OUTFIT)
return true
end

local waters = {4614, 4615, 4616, 4617, 4618, 4619, 4608, 4609, 4610, 4611, 4612, 4613, 7236, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4665, 4666, 4820, 4821, 4822, 4823, 4824, 4825}

function onUse(cid, item, fromPos, itemEx, toPos)

if getPlayerGroupId(cid) == 11 then
return true
end

local checkPos = toPos
checkPos.stackpos = 0

if getTileThingByPos(checkPos).itemid <= 0 then
   doPlayerSendCancel(cid, '!')
   return true
end

if not isInArray(waters, getTileInfo(toPos).itemid) then
   return true
end

if (getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 63215) >= 1) and not canFishWhileSurfingOrFlying then
   doPlayerSendCancel(cid, "You can't fish while surfing/flying.")
   return true
end

if isInArray(waters, getTileInfo(getThingPos(cid)).itemid) then
   doPlayerSendCancel(cid, "You can\'t fish while surfing neither flying above water.")
   return true
end

if getTileInfo(getThingPos(getCreatureSummons(cid)[1] or cid)).protection then
	doPlayerSendCancel(cid, "You can't fish pokémons if you or your pokémon is in protection zone.")
return true
end


if not isInArray({520, 521}, getCreatureOutfit(cid).lookType) then
   return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need fisher outfit for fishing.")
end

local delay = fishing[getPlayerStorageValue(cid, sto_iscas)].segs

if getPlayerStorageValue(cid, sto_iscas) ~= -1 then
   if getPlayerItemCount(cid, getPlayerStorageValue(cid, sto_iscas)) >= 1 then
      doPlayerRemoveItem(cid, getPlayerStorageValue(cid, sto_iscas), 1)
   else
      setPlayerStorageValue(cid, sto_iscas, -1)
   end
end

local outfit = getCreatureOutfit(cid)
local out = getPlayerSex(cid) == 0 and 1467 or 1468

doSetCreatureOutfit(cid, {lookType = out, lookHead = outfit.lookHead, lookBody = outfit.lookBody, lookLegs = outfit.lookLegs, lookFeet = outfit.lookFeet}, -1)
setPlayerStorageValue(cid, storageP, 1)     --alterei looktype
doCreatureSetNoMove(cid, false)

doFish(cid, toPos, getThingPos(cid), math.random(5, delay))

return true
end