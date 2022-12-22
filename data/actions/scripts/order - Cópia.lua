local skills = specialabilities
local surfborders = {4644, 4645, 4646, 4647, 4648, 4649, 4650, 4651, 4652, 4653, 4654, 4655, 4656, 4657, 4658, 4659, 4660, 4661, 4662, 4663}
local storages = {17000, 63215, 17001, 13008, 5700}   --alterado v1.9 \/
local unfix = {x = 1, y = 1, z = 1}

local txt = {
["rock smash"] = {"break that rock!", "smash that rock!", "destroy that rock!", "smash it!", "break it!", "destroy it!"},
["cut"] = {"cut that bush!", "cut it down!", "cut it off!", "cut off that bush!", "cut down that bush!", "cut that bush down!"},
["move"] = {"move!", "move there!", "go there!", "walk there!"},
["light"] = {"flash!", "light!", "flash this place!", "light up this place!"},
["dig"] = {"open that hole!", "dig that hole!", "open it!", "dig it!"},
["blink"] = {"teleport there!", "blink there!", "blink!", "teleport!"},
["ride"] = {"let me ride you!", "let's ride!", "let me mount you!", "let me get on you!"},
["fly"] = {"let's fly!", "let me get on you!"} ,
["untransform"] = {"go back to normal!", "transform into yourself again!", "stop transformation!"},
["headbutt"] = {"headbutt on three", "headbutt that three!", "headbutt it off"}, 
["levitate_fly"] = {"let's levitate!", "let me get on you!", "let's scary someone!"},  --alterado v1.8
}

function onUse(cid, item, frompos, item2, topos)
	local checkpos = topos
	checkpos.stackpos = 0
	
	if getPlayerStorageValue(cid, 75846) >= 1 then return true end --alterado v1.9

	if getTileThingByPos(checkpos).uid <= 0 then return true end

--------END FLY/RIDE --------
if getCreatureCondition(cid, CONDITION_OUTFIT) and (item2.uid == cid or getRecorderPlayer(topos) == cid) and (getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1) then

	if isInArray({460, 11675, 11676, 11677}, getTileInfo(getThingPos(cid)).itemid) then
        doPlayerSendCancel(cid, "You can\'t stop flying at this height!")
        return true
    end

	local item = getPlayerSlotItem(cid, 8)
	local pokemon = getItemAttribute(item.uid, "poke")
	local x = pokes[pokemon]

        if getTileInfo(getThingPos(cid)).itemid >= 4820 and getTileInfo(getThingPos(cid)).itemid <= 4825 then
        doPlayerSendCancel(cid, "You can\'t stop flying above the water!")
        return true
        end

	doSummonMonster(cid, pokemon)

	local pk = getCreatureSummons(cid)[1]

		if not isCreature(pk) then
			pk = doCreateMonster(pokemon, backupPos)
			if not isCreature(pk) then
				doPlayerSendCancel(cid, "You can't stop flying/riding here.")
			return true
			end
			doConvinceCreature(cid, pk)
		end

	doTeleportThing(pk, getThingPos(cid), false)
	doCreatureSetLookDir(pk, getCreatureLookDir(cid))

	adjustStatus(pk, item.uid, true, false, true)

	doPlayerSay(cid, ""..getPokeName(getCreatureSummons(cid)[1])..", let me get down!", 1)
	
    doRegainSpeed(cid)
    
	doRemoveCondition(cid, CONDITION_OUTFIT)
	setPlayerStorageValue(cid, 17000, -1)
	setPlayerStorageValue(cid, 17001, -1)
	
	if useOTClient then
	   doUpdateMoves(cid)
	   doPlayerSendCancel(cid, '12//,show') --alterado aki
    end

return true
end
-----------------------------
local player = getRecorderPlayer(topos)                        --alterado v1.8 \/
-------- DUEL SYSTEM ------------------------
if isPlayer(player) and player ~= cid and getPlayerStorageValue(player, 6598754) <= -1 and getPlayerStorageValue(player, 52480) <= -1 then  
if getPlayerStorageValue(cid, 52480) <= -1 or (getPlayerStorageValue(cid, 52481) >= 1 and getPlayerStorageValue(cid, 52482) ~= -1) then                  
---
for s = 1, #storages do
    if getPlayerStorageValue(cid, storages[s]) >= 1 then
       return doPlayerSendTextMessage(cid, 20, "You can't do that while is Flying, Riding, Surfing, Diving or mount a bike!") 
    end
end
if getPlayerStorageValue(cid, 6598754) == 1 or getPlayerStorageValue(cid, 6598755) == 1 then
return doPlayerSendTextMessage(cid, 20, "You can't do that while in PVP zone!")
end
if #getCreatureSummons(cid) < 1 then
return doPlayerSendTextMessage(cid, 20, "You need a pokemon to invit someone to duel!")
end
--- 
if getPlayerStorageValue(cid, 52480) <= -1 then
   doPlayerSetVocation(cid, 7) 
   openChannelDialog(cid)   
   setPlayerStorageValue(cid, 52480, 1)
   setPlayerStorageValue(cid, 6598754, 5)           
   setPlayerStorageValue(cid, 52482, getCreatureName(cid)..",")                      
   setPlayerStorageValue(cid, 52483, getCreatureName(player)..",") 
   doCreatureSetSkullType(cid, 2)
   doSendAnimatedText(getThingPosWithDebug(cid), "FIRST TEAM", 215)
   return true
elseif getPlayerStorageValue(cid, 52481) >= 1 and getPlayerStorageValue(cid, 52482) ~= -1 then 
   local t1 = string.explode(getPlayerStorageValue(cid, 52482), ",")
   local t2 = string.explode(getPlayerStorageValue(cid, 52483), ",")
   
   if (#t1 >= getPlayerStorageValue(cid, 52480) and #t2 >= getPlayerStorageValue(cid, 52480)) or (isInArray(t1, getCreatureName(player)) or isInArray(t2, getCreatureName(player))) then 
   return true 
   end
   
   local sto2, sto3, name = getPlayerStorageValue(cid, 52482), getPlayerStorageValue(cid, 52483), getCreatureName(player)
   if getPlayerStorageValue(cid, 52480) == 2 then
      setPlayerStorageValue(cid, 52483, sto3.. name..",") --time adversario 
      doSendAnimatedText(getThingPosWithDebug(player), "SECOND TEAM", 215)  
   elseif getPlayerStorageValue(cid, 52480) == 3 and #t1 < 3 then
      setPlayerStorageValue(cid, 52482, sto2.. name..",") --time aliado
      doSendAnimatedText(getThingPosWithDebug(player), "FIRST TEAM", 215)
   elseif getPlayerStorageValue(cid, 52480) == 3 and #t1 >= 3 then
      setPlayerStorageValue(cid, 52483, sto3.. name..",") --time adversario 
      doSendAnimatedText(getThingPosWithDebug(player), "SECOND TEAM", 215)  
   end  
     
   setPlayerStorageValue(player, 52481, getPlayerStorageValue(cid, 52481))
   setPlayerStorageValue(player, 52485, getCreatureName(cid))
   
   local players, pokes = getPlayerStorageValue(cid, 52480), getPlayerStorageValue(cid, 52481) 
   
   local str = {}
   table.insert(str, getCreatureName(cid).." is inviting you to a duel! Use order in him to accept it!\n")
   table.insert(str, "Info Battle: Duel "..players.."x"..players.." - "..pokes.." pokes.")     --alterado aki

   doPlayerSendTextMessage(player, 20, table.concat(str))
   return true
end
end
---   
elseif isPlayer(player) and player ~= cid and getPlayerStorageValue(player, 6598754) == 5 and getPlayerStorageValue(player, 52481) >= 1 then

local t1 = string.explode(getPlayerStorageValue(player, 52482), ",")
local t2 = string.explode(getPlayerStorageValue(player, 52483), ",")
---
if not isInArray(t1, getCreatureName(cid)) and not isInArray(t2, getCreatureName(cid)) then
return true
end
---
for s = 1, #storages do
    if getPlayerStorageValue(cid, storages[s]) >= 1 then
       return doPlayerSendTextMessage(cid, 20, "You can't do that while is Flying, Riding, Surfing, Diving or mount a bike!") 
    end
end
if getPlayerStorageValue(cid, 6598754) == 1 or getPlayerStorageValue(cid, 6598755) == 1 then
return doPlayerSendTextMessage(cid, 20, "You can't do that while in PVP zone!")
end
local pokes = getLivePokeballs(cid, getPlayerSlotItem(cid, 3).uid, true) 
if #pokes < getPlayerStorageValue(player, 52481) then
return doPlayerSendTextMessage(cid, 20, "You need atleast ".. getPlayerStorageValue(player, 52481).." pokemons to duel with this person!")
end
if getPlayerStorageValue(cid, 52482) ~= -1 then
return doPlayerSendTextMessage(cid, 20, "You already invit someone to duel!")
end 
if #getCreatureSummons(cid) < 1 then
return doPlayerSendTextMessage(cid, 20, "You need a pokemon to accept a duel!")
end
---  
   setPlayerStorageValue(cid, 52480, getPlayerStorageValue(player, 52480))
   setPlayerStorageValue(player, 52484, getPlayerStorageValue(player, 52484)-1)
   if getPlayerStorageValue(player, 52484) == 0 then   
      for a = 1, #t1 do
          local pid, sid = getPlayerByName(t1[a]), getPlayerByName(t2[a])
          if not isCreature(pid) or getPlayerStorageValue(pid, 52480) <= -1 then
             removeFromTableDuel(player, t1[a])
          else
             doCreatureSetSkullType(pid, 1)
          end
          if not isCreature(sid) or getPlayerStorageValue(sid, 52480) <= -1 then
             removeFromTableDuel(player, t2[a])
          else
             doCreatureSetSkullType(sid, 1)
          end
      end
      beginDuel(player, 6)
   else
      doCreatureSetSkullType(cid, 2)
   end
   doSendAnimatedText(getThingPos(cid), "BATTLE", COLOR_ELECTRIC)
   return true
   
elseif isPlayer(player) and player == cid and getPlayerStorageValue(player, 52480) >= 1 then
   doEndDuel(cid, true)
   return true
end
------------------------------------------------------------------------------------

if #getCreatureSummons(cid) == 0 then return doPlayerSendCancel(cid, "You need a pokemon to use order!") end
if getCreatureNoMove(getCreatureSummons(cid)[1]) then return true end
markLP(getCreatureSummons(cid)[1], -1)

local marked = getMarkedPos(getCreatureSummons(cid)[1])    --alterado v1.8 \/

if type(marked) == "table" and marked.x == topos.x and marked.y == topos.y then
return true
end

local thisball = getPlayerSlotItem(cid, 8)
local mysum = getCreatureSummons(cid)[1]
local sid = mysum or cid
local maxMoveDist = getDistanceBetween(getThingPos(sid), topos) * 2 + 1

	markPos(mysum, topos)
	markOwnerPos(mysum, getThingPos(cid))

-------- ROCK SMASH ---------
if item2.itemid == 1285 and isInArray(skills["rock smash"], getPokemonName(mysum)) then

	doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["rock smash"][math.random(1, #txt["rock smash"])].."", 1)
	addEvent(goThere, 500, mysum, topos, "rock smash", isCreature(getCreatureTarget(cid)))

return true
end
-----------------------------

-------- HEADBUTT -----------
if item2.itemid == 12591 and getPokemonLevel(mysum) >= 15 then  --alterado v1.6
                  --id do item  arvore normal
doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["headbutt"][math.random(1, #txt["headbutt"])].."", 1)
addEvent(goThere, 500, mysum, topos, "headbutt", isCreature(getCreatureTarget(cid)))

return true
end
-----------------------------

-------- CUT ----------------
if item2.itemid == 2767 and isInArray(skills["cut"], getPokemonName(mysum)) then

	doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["cut"][math.random(1, #txt["cut"])].."", 1)
	addEvent(goThere, 500, mysum, topos, "cut", isCreature(getCreatureTarget(cid)))

return true
end
-----------------------------

-------- TRANSFORM ----------                                                                                  --alterado v1.7
if (getCreatureName(mysum) == "Ditto" or getCreatureName(mysum) == "Shiny Ditto") and isMonster(item2.uid) and pokes[getCreatureName(item2.uid)] then
	if item2.uid == mysum then                                                                 --edited
		if isTransformed(mysum) then
			deTransform(mysum, getItemAttribute(thisball.uid, "transTurn"))
			markPos(mysum, unfix)
			doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["untransform"][math.random(1, #txt["untransform"])].."", 1)
			if useKpdoDlls then
               doUpdateMoves(cid) --alterado v1.9
            end
		return true
		end
	doPlayerSendCancel(cid, "Your ditto is not transformed.")
	markPos(mysum, unfix)
	return true
	end

	if getCreatureName(item2.uid) == "Ditto" or getCreatureName(item2.uid) == "Shiny Ditto" then    --edited transform for shiny ditto
		doPlayerSendCancel(cid, "Your ditto can't transform into another ditto.")
		markPos(mysum, unfix)
	return true
	end

	if getCreatureName(item2.uid) == getPlayerStorageValue(mysum, 1010) then
		doPlayerSendCancel(cid, "Your ditto is already transformed into that pokemon.")
		markPos(mysum, unfix)
	return true
	end

	local cd = getCD(thisball.uid, "trans", 40)

	if cd > 0 then
	doPlayerSendCancel(cid, "Your pokemon is too tired to transform again. Cooldown: ("..getStringmytempo(cd)..")")
	return true
	end

	if getHappiness(mysum) <= 50 then
		doSendMagicEffect(getThingPos(mysum), happinessRate[1].effect)
		markPos(mysum, unfix)
	return true
	end

	local turn = getItemAttribute(thisball.uid, "transTurn")

		if not turn or turn > 10 then
			doItemSetAttribute(thisball.uid, "transTurn", 0)
		else
			doItemSetAttribute(thisball.uid, "transTurn",  turn + 1)
		end

	local time = 140 + 2 * getPokemonLevel(mysum)

	turn = getItemAttribute(thisball.uid, "transTurn")

	markPos(mysum, unfix)
	setPlayerStorageValue(mysum, 1010, getCreatureName(item2.uid))
	doSetCreatureOutfit(mysum, {lookType = getPokemonXMLOutfit(getCreatureName(item2.uid))}, -1)  --alterado v1.8
    addEvent(deTransform, time * 1000, mysum, turn)
	doSendMagicEffect(getThingPos(mysum), 184)
	doCreatureSay(mysum, "TRANSFORM!", TALKTYPE_MONSTER)
	local name = getCreatureName(item2.uid)
	setCD(thisball.uid, "trans", 40)
	doItemSetAttribute(thisball.uid, "transBegin", os.clock())
	doSetItemAttribute(thisball.uid, "transLeft", time)
	doSetItemAttribute(thisball.uid, "transOutfit", getPokemonXMLOutfit(getCreatureName(item2.uid)))  --alterado v1.8
	doSetItemAttribute(thisball.uid, "transName", getCreatureName(item2.uid))
	doFaceCreature(mysum, getThingPos(item2.uid))
	doPlayerSay(cid, ""..getPokeName(mysum)..", transform into "..getArticle(name).." "..name.."!", 1)
	
    if useKpdoDlls then
		doUpdateMoves(cid)  --alterado v1.6
	end

if dittoCopiesStatusToo then
   setPlayerStorageValue(mysum, 1001, dittoBonus*getOffense(item2.uid))
   setPlayerStorageValue(mysum, 1002, dittoBonus*getDefense(item2.uid))
   setPlayerStorageValue(mysum, 1003, getSpeed(item2.uid))
   setPlayerStorageValue(mysum, 1004, dittoBonus*getVitality(item2.uid))
   setPlayerStorageValue(mysum, 1005, dittoBonus*getSpecialAttack(item2.uid))
   ------------------
   local pct = getCreatureHealth(mysum) / getCreatureMaxHealth(mysum)
   local vit = (getVitality(mysum) * getMasterLevel(mysum)) / 100
   setCreatureMaxHealth(mysum, ( vit * HPperVITsummon ))   --alterado v1.6
   doCreatureAddHealth(mysum, pct * vit * HPperVITsummon)
end

return true
end
-----------------------------

-------- LIGHT --------------
if isMonster(item2.uid) and getCreatureMaster(item2.uid) == cid then

	markPos(mysum, unfix)

	if not isInArray(skills["light"], getPokemonName(item2.uid)) then
	doPlayerSendCancel(cid, "Your pokemon can't use flash.")
	return true
	end
	
	local cd = getCD(thisball.uid, "light", 30)

	if cd > 0 then
	doPlayerSendCancel(cid, "Your pokemon is too tired to use flash. Cooldown: ("..getStringmytempo(cd)..")")
	return true
	end

	doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["light"][math.random(1, #txt["light"])].."", 1)
	doCreatureSay(mysum, "FLASH!", TALKTYPE_MONSTER)
	doSendMagicEffect(getThingPos(mysum), 28)

	local size = 5
		size = size + math.floor(getSpecialAttack(mysum) / 60)
		size = size + math.ceil(getPokemonLevel(mysum) / 60)

		if size > 11 then
			size = 11
		end

	doSetCreatureLight(mysum, size, 215, 600*1000)

	local delay = math.floor(30 - getPokemonLevel(mysum) / 4)
		if delay > 0 then
		setCD(thisball.uid, "light", delay)
		end

return true
end  
-----------------------------


-------- DIG ----------------
if isInArray(skills["digholes"], item2.itemid) and isInArray(skills["dig"], getPokemonName(mysum)) then

	doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["dig"][math.random(1, #txt["dig"])].."", 1)
	addEvent(goThere, 500, mysum, topos, "dig", isCreature(getCreatureTarget(cid)))

return true
end
-----------------------------


-------- BLINK / MOVE -------
if not isCreature(item2.uid) and isInArray(skills["blink"], getPokemonName(mysum)) then

	local cd = getCD(thisball.uid, "blink", 30)
    
    if getPlayerStorageValue(mysum, 2365487) ==  1 then
	return true                  --alterado v1.4
	end
	
	if cd > 0 or not canWalkOnPos(topos, false, false, true, true, true) then

		doPlayerSendCancel(cid, "Blink cooldown: ("..getStringmytempo(cd)..")")
		doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["move"][math.random(1, #txt["move"])].."", 1)
		addEvent(goThere, 500, mysum, topos, "move", isCreature(getCreatureTarget(cid)), maxMoveDist)

	return true
	end

	local CD = isShinyName(getCreatureName(mysum)) and 20 or 30   --edited blink

	markPos(mysum, topos)
	markOwnerPos(mysum, getThingPos(cid))
	setCD(thisball.uid, "blink", CD)
	doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["blink"][math.random(1, #txt["blink"])].."", 1)
	doSendDistanceShoot(getThingPos(mysum), topos, 39)
	doSendMagicEffect(getThingPos(mysum), 211)
	doTeleportThing(mysum, topos, false)
	doSendMagicEffect(topos, 134)
	doCreatureSay(mysum, "BLINK!", TALKTYPE_MONSTER)
	goThere(mysum, topos, "blink", isCreature(getCreatureTarget(cid)))  --edited blink

return true
end
-----------------------------  


----START FLY or RIDE or LEVITATE ---------
if (item2.uid == cid or getRecorderPlayer(topos) == cid) and (isInArray(skills["fly"], getPokemonName(mysum)) or isInArray(skills["ride"], getPokemonName(mysum)) or isInArray(skills["levitate_fly"], getPokemonName(mysum))) then
                                                                                                           --alterado v1.8 >>
	if getPlayerStorageValue(cid, 6598754) == 1 or getPlayerStorageValue(cid, 6598755) == 1 then 
	   return doPlayerSendCancel(cid, "You can't do it while in the PVP Zone!")   --alterado v1.7
    end
	
    if #getCreatureSummons(cid) > 1 then         --alterado v1.9
       return doPlayerSendCancel(cid, "You can't do it right now!")
    end
    
    if getPlayerStorageValue(cid, 52480) >= 1 then
       return doPlayerSendCancel(cid, "You can't do it while a duel!")  --alterado v1.6
    end   

    if getPlayerStorageValue(cid, 5700) >= 1 then   --alterado v1.9
       doPlayerSendCancel(cid, "You can't do that while is mount in a bike!") 
       return true
    end                                                                 
    
    if getPlayerStorageValue(cid, 22545) >= 1 and (isInArray(skills["fly"], getPokemonName(mysum)) or isInArray(skills["levitate_fly"], getPokemonName(mysum))) then       
       return doPlayerSendCancel(cid, "You can't do that while in the Golden Arena!")                          --alterado v1.8
    end
    
	local pct = getCreatureHealth(mysum) / getCreatureMaxHealth(mysum)
	doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "hp", 1 - pct)
                                                       
	if isInArray(skills["fly"], getPokemonName(mysum)) then
	   doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["fly"][math.random(1, #txt["fly"])].."", 1)
	   addEvent(goThere, 500, mysum, topos, "fly", isCreature(getCreatureTarget(cid)))
	elseif isInArray(skills["levitate_fly"], getPokemonName(mysum)) then
	   doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["levitate_fly"][math.random(1, #txt["levitate_fly"])].."", 1)   --alterado v1.8
	   addEvent(goThere, 500, mysum, topos, "fly", isCreature(getCreatureTarget(cid)))
	else
	   doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["ride"][math.random(1, #txt["ride"])].."", 1)
	   addEvent(goThere, 500, mysum, topos, "ride", isCreature(getCreatureTarget(cid)))
	end

return true
end
-----------------------------
----------------------------------Control Mind--------------------------------------------   alterado v1.5
if isCreature(item2.uid) and ehMonstro(item2.uid) and isInArray(skills["control mind"], getCreatureName(mysum)) and item2.uid ~= mysum then
   if not isCreature(item2.uid) then
   return true
   end

   if isSleeping(mysum) then
      return doPlayerSendCancel(cid, "Your pokemon is sleeping...zZzZ")
   end

   if getTileInfo(getThingPos(cid)).protection or getTileInfo(getThingPos(getCreatureSummons(cid)[1])).protection then
      return doPlayerSendCancel(cid, "You or your pokemon are in Pz zone!")
   end
  
   if #getCreatureSummons(cid) == 2 then
      return doPlayerSendCancel(cid, "You only can control one Pokemon!")
   end

   local cd = getCD(thisball.uid, "control", 120)
   
   if cd > 0 then
      doPlayerSendCancel(cid, "You have to wait "..cd.." segs to use Control Mind again!")
      return true
   end
   
   if getPokemonLevel(item2.uid) >= getPokemonLevel(mysum) then
      return doPlayerSendCancel(cid, "Your pokemon can't control this mind!")
   end
   
   if getPlayerStorageValue(cid, 22545) >= 1 then       --alterado v1.7
      return doPlayerSendCancel(cid, "You can't do that while in the Golden Arena!")
   end
   
local cmed = item2.uid
setCD(thisball.uid, "control", 120) 
local gender = getPokemonGender(cmed)
doSendDistanceShoot(getThingPos(mysum), getThingPos(cmed), 39)
--------------
setPlayerStorageValue(cid, 212124, 1)
doConvinceCreature(cid, cmed) 
setPlayerStorageValue(cmed, 212123, 1) 
doCreatureSay(cid, ""..getCreatureName(mysum)..", control "..string.lower(getCreatureName(cmed)).."'s mind!", 1)

local cmname = getCreatureName(mysum)
local cmpos = getThingPos(mysum)
local pokelife = (getCreatureHealth(mysum) / getCreatureMaxHealth(mysum))
doItemSetAttribute(thisball.uid, "hp", pokelife)
doRemoveCreature(mysum)
local cmzao = doSummonCreature(""..cmname.." cm", cmpos)
doConvinceCreature(cid, cmzao)
setPlayerStorageValue(cid, 888, 1)
if useKpdoDlls then
   doUpdateMoves(cid)
end

local function check(cid, controled, rod)
if isCreature(cid) then
ball2 = getPlayerSlotItem(cid, 8)
   if getPlayerStorageValue(cid, 888) <= 0 then
   return true
   end
   if not isCreature(controled) then
      setPlayerStorageValue(cid, 212124, 0)
      local sum = isCreature(getCreatureSummons(cid)[1]) and getCreatureSummons(cid)[1] or getCreatureSummons(cid)[2] 
      local pkcmpos = getThingPos(sum)
      doRemoveCreature(sum)
      local item = getPlayerSlotItem(cid, 8)
      local pk = doSummonCreature(getItemAttribute(item.uid, "poke"), pkcmpos)
      doConvinceCreature(cid, pk)
      doCreatureSetLookDir(getCreatureSummons(cid)[1], 2)
      addEvent(doAdjustWithDelay, 100, cid, pk, true, true, false)
      setPlayerStorageValue(cid, 888, -1)  --alterado v1.7
      cleanCMcds(item.uid)
      registerCreatureEvent(pk, "SummonDeath")  --alterado v1.6
      if useKpdoDlls then
         doUpdateMoves(cid)
      end
      return true
   end
   
   if rod <= 0 then
      --Pokemon controlado
      local cmed2 = getCreatureSummons(cid)[1]
	  local poscmed = getThingPos(cmed2)
	  local cmeddir = getCreatureLookDir(cmed2)
	  local namecmed = getCreatureName(cmed2)
	  local gender = getPokemonGender(cmed2)
	  local hp, maxHp = getCreatureHealth(getCreatureSummons(cid)[1]), getCreatureMaxHealth(getCreatureSummons(cid)[1])
	  doRemoveCreature(getCreatureSummons(cid)[1])
	  local back = doCreateMonster(namecmed, poscmed)
	  addEvent(doCreatureSetSkullType, 150, back, gender)
      doWildAttackPlayer(back, cid)
	  doCreatureSetLookDir(back, cmeddir)
	  addEvent(doCreatureAddHealth, 100, back, hp-maxHp)
	
	  -- pokemon controlador	
      local mynewpos = getThingPos(getCreatureSummons(cid)[1])
      doRemoveCreature(getCreatureSummons(cid)[1])
      local pk2 = doSummonCreature(getItemAttribute(ball2.uid, "poke"), mynewpos) 
      doConvinceCreature(cid, pk2)
      addEvent(doAdjustWithDelay, 100, cid, pk2, true, true, false)
      setPlayerStorageValue(cid, 888, -1) --alterado v1.7
      doCreatureSetLookDir(getCreatureSummons(cid)[1], 2)
      setPlayerStorageValue(cid, 212124, 0)
      cleanCMcds(ball2.uid)
      registerCreatureEvent(pk2, "SummonDeath")  --alterado v1.6
      if useKpdoDlls then
         doUpdateMoves(cid)
      end
   else
       if isInArray({"Haunter", "Gengar", "Shiny Gengar"}, cmname) then
          doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 214)
       else 
          doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 220)
       end
   end
end
addEvent(check, 500, cid, controled, rod-1)
end

check(cid, cmed, 40) 
return true
end
---------------------------------------------------------------------
-------- MOVE / END ---------
    
	local onlyWater = false

	if isWater(getTileThingByPos(checkpos).itemid) then
		onlyWater = true
		for checkwater = 0, 7 do
			if not isWater(getTileThingByPos(getPosByDir(checkpos, checkwater)).itemid) then
				onlyWater = false
			end
		end
	end

	if onlyWater then
		doPlayerSendCancel(cid, "Destination is not reachable.")
	return true
	end

	doPlayerSay(cid, ""..getPokeName(mysum)..", "..txt["move"][math.random(1, #txt["move"])].."", 1)
	
	if isCreature(getCreatureTarget(cid)) then
	   goThere(mysum, topos, "move", isCreature(getCreatureTarget(cid)), maxMoveDist)           
	else
       addEvent(goThere, 500, mysum, topos, "move", isCreature(getCreatureTarget(cid)), maxMoveDist)                 
	end	
-----------------------------

return true
end