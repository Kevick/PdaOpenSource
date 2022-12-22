local escadas = {4820, 4821, 4822, 4823, 4824, 4825, 383, 408, 427, 432, 433, 459, 469, 482, 484, 1385, 1388, 1390, 1392, 1394, 1398, 1400, 1402, 1404, 3135, 3679, 3681, 3683, 3685, 4835, 4836, 4837, 5258, 5259, 5260, 6128, 6909, 6911, 6913, 6915, 8284}

function setAgressive(cid)

        if not isCreature(cid) or isSummon(cid) then
        return false
        end

        if not isPassive(cid) then return true end

        setPlayerStorageValue(cid, 10, 0)
 	    doRegainSpeed(cid)

return true
end

function isPassive(cid)

        if not isCreature(cid) or isSummon(cid) then
        return false
        end

        if getPlayerStorageValue(cid, 10) >= 1 then
        return true
        end

return false
end

function setPassive(cid)

        if not isCreature(cid) or isSummon(cid) then
        return false
        end

        doChangeSpeed(cid, -getCreatureSpeed(cid))
        setPlayerStorageValue(cid, 10, 1)
        startRandomWalk(cid)

return true
end

function getRandomWalkDelay(cid)
if getPlayerStorageValue(cid, 11) >= 1 then
return true
end
return false
end

function setRandomWalkDelay(cid, time)
if not isCreature(cid) then return true end
if time > 0 then
setPlayerStorageValue(cid, 11, 1)
addEvent(setRandomWalkDelay, time*850, cid, 0)
return true
end
setPlayerStorageValue(cid, 11, -1)
end

function startRandomWalk(cid)

if not isCreature(cid) or not isPassive(cid) then
return false
end

local random = math.random(2, 6)

if not getRandomWalkDelay(cid) then
   local randommove = math.random(1, 8)

   if randommove <= 1 then
      doFaceRandom(cid)
      setRandomWalkDelay(cid, random)
   else
       local pos = {}
       for a = 0, 3 do
           local checkpos = getPosByDir(getThingPos(cid), a)	
      	   if isWalkable(getPosByDir(getThingPos(cid), a), 1, 1, 1) then
	          if not isInArray(escadas, getTileThingByPos{x=checkpos.x,y=checkpos.y,z=checkpos.z,stackpos=0}.itemid) then
     		     table.insert(pos, getPosByDir(getThingPos(cid), a))
              end
      	   end
       end
  	   if #pos >= 1 then
          doChangeSpeed(cid, -getCreatureSpeed(cid))
 		  doChangeSpeed(cid, 75)
   		  doTeleportThing(cid, pos[math.random(1, #pos)], true)
   		  doChangeSpeed(cid, -75)
  	   end
  	   setRandomWalkDelay(cid, random)
   end
end
addEvent(startRandomWalk, random*110, cid)
return true
end

function resetAgressiveList(cid)        
        if not isCreature(cid) then return false end
        setPlayerStorageValue(cid, 12, "")
        end

function addPlayerToAgressiveList(cid, player)
        if not isCreature(cid) then return false end
        if not isCreature(player) then return false end
if string.find(getPlayerStorageValue(cid, 12), getCreatureName(player)..",") then
return true
end
setPlayerStorageValue(cid, 12, getPlayerStorageValue(cid, 12)..""..getCreatureName(player)..", ")
return true
end

function isPlayerInAgressiveList(cid, player)
        if not isCreature(cid) then return false end
        if not isCreature(player) then return false end
if string.find(getPlayerStorageValue(cid, 12), getCreatureName(player)..",") then
return true
end
return false
end
        
function checkForAgressivePlayers(cid)
if not isCreature(cid) then return false end
if not isPassive(cid) then return false end

local t = getSpectators(getThingPos(cid), 7, 5, false)

if #t >= 2 then
        for a = 1, #t do
        if isPlayer(getCreatureMaster(t[a])) and isPlayerInAgressiveList(cid, getCreatureMaster(t[a])) and not isPlayerGhost(getCreatureMaster(t[a])) then
        setAgressive(cid)
        doMonsterSetTarget(cid, t[a])
        end
        end
end
return true
end

function noTargets(cid)
if not isCreature(cid) then return true end
if isCreature(getCreatureTarget(cid)) then return true end
setPassive(cid)
end