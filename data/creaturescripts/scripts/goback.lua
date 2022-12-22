function onLogout(cid)
    if not isCreature(cid) then return true end    
	local thisitem = getPlayerSlotItem(cid, 8)
	
	if thisitem.uid <= 0 then return true end
	
	local ballName = getItemAttribute(thisitem.uid, "poke")
    local btype = getPokeballType(thisitem.itemid)
    
    ---------------------------------------------------------------
    if #getCreatureSummons(cid) > 1 and getPlayerStorageValue(cid, 212124) <= 0 then    --alterado v1.6
       if getPlayerStorageValue(cid, 637501) == -2 or getPlayerStorageValue(cid, 637501) >= 1 then  
          BackTeam(cid)       
       end
    end
    --////////////////////////////////////////////////////////////////////////////////////////--
    if getPlayerStorageValue(cid, 52480) >= 1 and getPlayerStorageValue(cid, 52481) >= 0 then 
       doEndDuel(cid)
    end
    --////////////////////////////////////////////////////////////////////////////////////////--
    if #getCreatureSummons(cid) == 2 and getPlayerStorageValue(cid, 212124) >= 1 then
       local cmed2 = getCreatureSummons(cid)[1]
	   local poscmed = getThingPos(cmed2)
	   local cmeddir = getCreatureLookDir(cmed2)
	   local namecmed = getCreatureName(cmed2)
	   local hp, maxHp = getCreatureHealth(getCreatureSummons(cid)[1]), getCreatureMaxHealth(getCreatureSummons(cid)[1])
	   local gender = getPokemonGender(cmed2) 
       doRemoveCreature(getCreatureSummons(cid)[1])
	   local back = doCreateMonster(namecmed, poscmed)
	   addEvent(doCreatureSetSkullType, 150, back, gender)
	   doCreatureSetLookDir(back, cmeddir)
	   addEvent(doCreatureAddHealth, 100, back, hp-maxHp)
                                                                            
       -- pokemon controlador	
       local ball2 = getPlayerSlotItem(cid, 8)
       local mynewpos = getThingPos(getCreatureSummons(cid)[1])
       doRemoveCreature(getCreatureSummons(cid)[1])
       local pk2 = doSummonCreature(getItemAttribute(ball2.uid, "poke"), mynewpos) 
       doConvinceCreature(cid, pk2)
       addEvent(doAdjustWithDelay, 100, cid, pk2, true, true, false)
       setPlayerStorageValue(cid, 888, -1)    
       cleanCMcds(ball2.uid)
       doCreatureSetLookDir(getCreatureSummons(cid)[1], 2)
       registerCreatureEvent(pk2, "SummonDeath")   
    end
    
    ----------------------------------------------------------------------
    local summon = getCreatureSummons(cid)[1]      
      
	if #getCreatureSummons(cid) >= 1 and thisitem.uid > 1 then
	    if getPlayerStorageValue(cid, 212124) <= 0 then
		   doItemSetAttribute(thisitem.uid, "hp", (getCreatureHealth(summon) / getCreatureMaxHealth(summon)))
        end                                                          
        setPlayerStorageValue(cid, 212124, 0)
        doTransformItem(thisitem.uid, pokeballs[btype].on)
		doSendMagicEffect(getThingPos(summon), pokeballs[btype].effect)
		doRemoveCreature(summon)
	end

	if getCreatureOutfit(cid).lookType == 814 then
		doPlayerStopWatching(cid)
	end

	if tonumber(getPlayerStorageValue(cid, 17000)) and getPlayerStorageValue(cid, 17000) >= 1 then  
		markFlyingPos(cid, getThingPos(cid))
	end
	
	if getPlayerStorageValue(cid, 22545) == 1 then     
	   setGlobalStorageValue(22550, getGlobalStorageValue(22550)-1)
	   if getGlobalStorageValue(22550) <= 0 then
          endGoldenArena()          
       end 
    end

return TRUE
end

local deathtexts = {"Oh no! POKENAME, come back!", "Come back, POKENAME!", "That's enough, POKENAME!", "You did well, POKENAME!",
		    "You need to rest, POKENAME!", "Nice job, POKENAME!", "POKENAME, you are too hurt!"}

function onDeath(cid, deathList)

	local owner = getCreatureMaster(cid)

        if getPlayerStorageValue(cid, 637500) >= 1 then
           doSendMagicEffect(getThingPos(cid), 211)
           doRemoveCreature(cid)
           return true
        end
        
        if getPlayerStorageValue(cid, 212123) >= 1 then
           return true
        end
        
        --////////////////////////////////////////////////////////////////////////////////////////--
        checkDuel(owner)                                                                          
        --////////////////////////////////////////////////////////////////////////////////////////--
        
	local thisball = getPlayerSlotItem(owner, 8)
	local ballName = getItemAttribute(thisball.uid, "poke")
	
    btype = getPokeballType(thisball.itemid)

        if #getCreatureSummons(owner) > 1 then
           BackTeam(owner, getCreatureSummons(owner))      
        end

		doSendMagicEffect(getThingPos(cid), pokeballs[btype].effect)
        doTransformItem(thisball.uid, pokeballs[btype].off)

		doPlayerSendTextMessage(owner, 22, "Your pokemon fainted.")

	local say = deathtexts[math.random(#deathtexts)]
		say = string.gsub(say, "POKENAME", getCreatureName(cid))

	if getPlayerStorageValue(cid, 33) <= 0 then
		doCreatureSay(owner, say, TALKTYPE_SAY)
	end

	doItemSetAttribute(thisball.uid, "hp", 0)
	if ehMonstro(deathList[1]) then
	   doItemSetAttribute(thisball.uid, "happy", getPlayerStorageValue(cid, 1008) - happyLostOnDeath)
    end
	doItemSetAttribute(thisball.uid, "hunger", getPlayerStorageValue(cid, 1009))

    if useOTClient then
       doPlayerSendCancel(owner, '12//,hide')      --alterado v1.7
    end

	doRemoveCreature(cid)

return false
end