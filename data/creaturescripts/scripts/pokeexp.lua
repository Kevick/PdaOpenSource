local function playerAddExp(cid, exp)
	doPlayerAddExp(cid, exp)
	doSendAnimatedText(getThingPos(cid), exp, 215)
end


function onDeath(cid, corpse, deathList)
        
	--if not isCreature(cid) then return true end
	if isSummon(cid) or not deathList or getCreatureName(cid) == "Evolution" then return true end --alterado v1.8

    -------------Edited Golden Arena-------------------------   --alterado v1.7 \/\/
    if getPlayerStorageValue(cid, 22546) == 1 then
       setGlobalStorageValue(22548, getGlobalStorageValue(22548)-1)
       if corpse.itemid ~= 0 then doItemSetAttribute(corpse.uid, "golden", 1) end  --alterado v1.8    
    end   
    if getPlayerStorageValue(cid, 22546) == 1 and getGlobalStorageValue(22548) == 0 then
       local wave = getGlobalStorageValue(22547)
       for _, sid in ipairs(getPlayersOnline()) do
           if isPlayer(sid) and getPlayerStorageValue(sid, 22545) == 1 then
              if getGlobalStorageValue(22547) < #wavesGolden+1 then
                 doPlayerSendTextMessage(sid, 20, "Wave "..wave.." will begin in "..timeToWaves.."seconds!")   
                 doPlayerSendTextMessage(sid, 28, "Wave "..wave.." will begin in "..timeToWaves.."seconds!") 
                 addEvent(creaturesInGolden, 100, GoldenUpper, GoldenLower, false, true, true)
                 addEvent(doWave, timeToWaves*1000)
              elseif getGlobalStorageValue(22547) == #wavesGolden+1 then
                 doPlayerSendTextMessage(sid, 20, "Você foi o último sobrevivente da Golden arena tome sua recompensa!")
                 doPlayerAddItem(sid, 2152, getPlayerStorageValue(sid, 22551)*2)    --premio
                 setPlayerStorageValue(sid, 22545, -1)
                 doTeleportThing(sid, getClosestFreeTile(sid, posBackGolden), false) 
                 setPlayerRecordWaves(sid)
              end
           end
       end
       if getGlobalStorageValue(22547) == #wavesGolden+1 then
          endGoldenArena()
       end
    end 
    ---------------------------------------------------   /\/\
	local givenexp = getWildPokemonExp(cid)
	---local killer = getItemAttribute(corpse.uid, "corpseowner")  

if givenexp > 0 then
for a = 1, #deathList do
local pk = deathList[a]
---
local list = getSpectators(getThingPosWithDebug(pk), 30, 30, false)
if isCreature(pk) then 
   local expTotal = math.floor(givenexp * getDamageMapPercent(pk, cid))
   local party = getPartyMembers(pk)
   if isInParty(pk) and getPlayerStorageValue(pk, 4875498) <= -1 then
      expTotal = math.floor(expTotal/#party)         --alterado v1.6.1
      for i = 1, #party do
          if isInArray(list, party[i]) then		     
if getPlayerLevel(pk) <= 50 then
             playerAddExp(party[i], expTotal * 200)  
elseif getPlayerLevel(pk) >= 51 and getPlayerLevel(pk) <= 75 then
             playerAddExp(party[i], expTotal * 130)
elseif getPlayerLevel(pk) >= 76 and getPlayerLevel(pk) <= 100 then
             playerAddExp(party[i], expTotal * 80)
elseif getPlayerLevel(pk) >= 101 and getPlayerLevel(pk) <= 150 then
             playerAddExp(party[i], expTotal * 40)
elseif getPlayerLevel(pk) >= 151 and getPlayerLevel(pk) <= 250 then
             playerAddExp(party[i], expTotal * 20)
elseif getPlayerLevel(pk) >= 251 and getPlayerLevel(pk) <= 350 then
             playerAddExp(party[i], expTotal * 10)
elseif getPlayerLevel(pk) >= 351 then
             playerAddExp(party[i], expTotal * 5)
			 end
          end
      end
   elseif not isInParty(pk) then
if getPlayerLevel(pk) <= 50 then
playerAddExp(pk, math.floor(200 * givenexp * getDamageMapPercent(pk, cid)))
elseif getPlayerLevel(pk) >= 51 and getPlayerLevel(pk) <= 75 then
playerAddExp(pk, math.floor(130 * givenexp * getDamageMapPercent(pk, cid)))
elseif getPlayerLevel(pk) >= 76 and getPlayerLevel(pk) <= 100 then
playerAddExp(pk, math.floor(80 * givenexp * getDamageMapPercent(pk, cid)))
elseif getPlayerLevel(pk) >= 101 and getPlayerLevel(pk) <= 150 then
playerAddExp(pk, math.floor(40 * givenexp * getDamageMapPercent(pk, cid)))
elseif getPlayerLevel(pk) >= 151 and getPlayerLevel(pk) <= 250 then
playerAddExp(pk, math.floor(20 * givenexp * getDamageMapPercent(pk, cid)))
elseif getPlayerLevel(pk) >= 251 and getPlayerLevel(pk) <= 350 then
playerAddExp(pk, math.floor(10 * givenexp * getDamageMapPercent(pk, cid)))
elseif getPlayerLevel(pk) >= 351 then
playerAddExp(pk, math.floor(5 * givenexp * getDamageMapPercent(pk, cid)))
return true end	  
   end       
end
end
end

	if isNpcSummon(cid) then
		local master = getCreatureMaster(cid)
		doSendMagicEffect(getThingPos(cid), getPlayerStorageValue(cid, 10000))
		doCreatureSay(master, getPlayerStorageValue(cid, 10001), 1)
		doRemoveCreature(cid)
	return false
	end
if corpse.itemid ~= 0 then   --alterado v1.8
   doItemSetAttribute(corpse.uid, "level", getPokemonLevel(cid))
   doItemSetAttribute(corpse.uid, "gender", getPokemonGender(cid))  
end
return true
end