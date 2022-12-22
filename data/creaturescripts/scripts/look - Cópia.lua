local NPCBattle = {
["Brock"] = {artig = "He is", cidbat = "Pewter"},
["Misty"] = {artig = "She is", cidbat = "Cerulean"}, 
["Blaine"] = {artig = "He is", cidbat = "Cinnabar"},
["Sabrina"] = {artig = "She is", cidbat = "Saffron"},         --alterado v1.9 \/ peguem tudo!
["Kira"] = {artig = "She is", cidbat = "Viridian"},
["Koga"] = {artig = "He is", cidbat = "Fushcia"},
["Erika"] = {artig = "She is", cidbat = "Celadon"},
["Surge"] = {artig = "He is", cidbat = "Vermilion"},
}

local shinys = {
["Shiny Abra"] = "Dark Abra",
["Shiny Onix"] = "Crystal Onix",
["Shiny Gyarados"] = "Red Gyarados",
["Shiny Charizard"] = "Elder Charizard",
["Shiny Venusaur"] = "Ancient Venusaur",
["Shiny Blastoise"] = "Ancient Blastoise",
["Shiny Farfetch'd"] = "Elite Farfetch'd",
["Shiny Hitmonlee"] = "Elite Hitmonlee",
["Shiny Himonchan"] = "Elite Hitmonchan",
["Shiny Snorlax"] = "Big Snorlax",
}

-- tabela adicionado ao configuration só procura por price = ..--

local xhelds = {
[1] = {name = "X-Defense(Tier: 1)"},
[2] = {name = "X-Defense(Tier: 2)"},
[3] = {name = "X-Defense(Tier: 3)"},
[4] = {name = "X-Defense(Tier: 4)"},
[5] = {name = "X-Defense(Tier: 5)"},
[6] = {name = "X-Defense(Tier: 6)"},
[7] = {name = "X-Defense(Tier: 7)"},
[8] = {name = "X-Attack(Tier : 1)"},
[9] = {name = "X-Attack(Tier : 2)"},
[10] = {name = "X-Attack(Tier: 3)"},
[11] = {name = "X-Attack(Tier: 4)"},
[12] = {name = "X-Attack(Tier: 5)"},
[13] = {name = "X-Attack(Tier: 6)"},
[14] = {name = "X-Attack(Tier: 7)"},
[15] = {name = "X-Return(Tier: 1)"},
[16] = {name = "X-Return(Tier: 2)"},
[17] = {name = "X-Return(Tier: 3)"},
[18] = {name = "X-Return(Tier: 4)"},
[19] = {name = "X-Return(Tier: 5)"},
[20] = {name = "X-Return(Tier: 6)"},
[21] = {name = "X-Return(Tier: 7)"},
[22] = {name = "X-Hellfire(Tier: 1)"},
[23] = {name = "X-Hellfire(Tier: 2)"},
[24] = {name = "X-Hellfire(Tier: 3)"},
[25] = {name = "X-Hellfire(Tier: 4)"},
[26] = {name = "X-Hellfire(Tier: 5)"},
[27] = {name = "X-Hellfire(Tier: 6)"},
[28] = {name = "X-Hellfire(Tier: 7)"},
[29] = {name = "X-Poison(Tier: 1)"},
[30] = {name = "X-Poison(Tier: 2)"},
[31] = {name = "X-Poison(Tier: 3)"},
[32] = {name = "X-Poison(Tier: 4)"},
[33] = {name = "X-Poison(Tier: 5)"},
[34] = {name = "X-Poison(Tier: 6)"},
[35] = {name = "X-Poison(Tier: 7)"},
[36] = {name = "X-Boost(Tier: 1)"},
[37] = {name = "X-Boost(Tier: 2)"},
[38] = {name = "X-Boost(Tier: 3)"},
[39] = {name = "X-Boost(Tier: 4)"},
[40] = {name = "X-Boost(Tier: 5)"},
[41] = {name = "X-Boost(Tier: 6)"},
[42] = {name = "X-Boost(Tier: 7)"},
}

local yhelds = {
[1] = {name = "Y-Regeneration(Tier: 1)"},
[2] = {name = "Y-Regeneration(Tier: 2)"},
[3] = {name = "Y-Regeneration(Tier: 3)"},
[4] = {name = "Y-Regeneration(Tier: 4)"},
[5] = {name = "Y-Regeneration(Tier: 5)"},
[6] = {name = "Y-Regeneration(Tier: 6)"},
[7] = {name = "Y-Regeneration(Tier: 7)"},
[8] = {name = "Y-Cure(Tier: 1)"},
[9] = {name = "Y-Cure(Tier: 2)"},
[10] = {name = "Y-Cure(Tier: 3)"},
[11] = {name = "Y-Cure(Tier: 4)"},
[12] = {name = "Y-Cure(Tier: 5)"},
[13] = {name = "Y-Cure(Tier: 6)"},
[14] = {name = "Y-Cure(Tier: 7)"},
}

function onLook(cid, thing, position, lookDistance)
                                                          
local str = {}
                                              
if not isCreature(thing.uid) then
   local iname = getItemInfo(thing.itemid)
   if isPokeball(thing.itemid) and getItemAttribute(thing.uid, "poke") then
      
      unLock(thing.uid)
      local lock = getItemAttribute(thing.uid, "lock")        
      local pokename = getItemAttribute(thing.uid, "poke")
      local heldx = getItemAttribute(thing.uid, "heldx")
local heldy = getItemAttribute(thing.uid, "heldy")
      table.insert(str, "You see "..iname.article.." "..iname.name..".")   
      if getItemAttribute(thing.uid, "unique") then               
         table.insert(str, " It's an unique item.")   
      end
      table.insert(str, "\nIt contains "..getArticle(pokename).." "..pokename..".\n")  
      if lock and lock > 0 then
         table.insert(str, "It will unlock in ".. os.date("%d/%m/%y %X", lock)..".\n")  
      end
      local boost = getItemAttribute(thing.uid, "boost") or 0
      if boost > 0 then
         table.insert(str, "Boost level: +"..boost..".\n")
      end
      if getItemAttribute(thing.uid, "nick") then
         table.insert(str, "It's nickname is: "..getItemAttribute(thing.uid, "nick")..".\n")
      end
      if heldx and heldy then
table.insert(str, "Holding: "..(xhelds[heldx].name).." and "..(yhelds[heldy].name)..". ")
elseif heldx then
table.insert(str, "Holding: "..(xhelds[heldx].name)..". ")
elseif heldy then
table.insert(str, "Holding: "..(yhelds[heldy].name)..". ")
end
      if getItemAttribute(thing.uid, "gender") == SEX_MALE then
         table.insert(str, "It is male.")
      elseif getItemAttribute(thing.uid, "gender") == SEX_FEMALE then
         table.insert(str, "It is female.")
      else
         table.insert(str, "It is genderless.")
      end
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false
      
   elseif string.find(iname.name, "fainted") or string.find(iname.name, "defeated") then     

      table.insert(str, "You see a "..string.lower(iname.name)..". ")     
      if isContainer(thing.uid) then
         table.insert(str, "(Vol: "..getContainerCap(thing.uid)..")")
      end
      table.insert(str, "\n")
      if getItemAttribute(thing.uid, "gender") == SEX_MALE then
         table.insert(str, "It is male.")
      elseif getItemAttribute(thing.uid, "gender") == SEX_FEMALE then
         table.insert(str, "It is female.")
      else
         table.insert(str, "It is genderless.")
      end
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false

   elseif isContainer(thing.uid) then     --containers

      if iname.name == "dead human" and getItemAttribute(thing.uid, "pName") then
         table.insert(str, "You see a dead human (Vol:"..getContainerCap(thing.uid).."). ")
         table.insert(str, "You recognize ".. getItemAttribute(thing.uid, "pName")..". ".. getItemAttribute(thing.uid, "article").." was killed by a ")
         table.insert(str, getItemAttribute(thing.uid, "attacker")..".")
      else   
         table.insert(str, "You see "..iname.article.." "..iname.name..". (Vol:"..getContainerCap(thing.uid)..").")
      end
      if getPlayerGroupId(cid) >= 4 and getPlayerGroupId(cid) <= 6 then
         table.insert(str, "\nItemID: ["..thing.itemid.."]")     
         local pos = getThingPos(thing.uid)
         table.insert(str, "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]")  
      end
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false
      
   elseif getItemAttribute(thing.uid, "unique") then    
      local p = getThingPos(thing.uid)
   
      table.insert(str, "You see ")
      if thing.type > 1 then
         table.insert(str, thing.type.." "..iname.plural..".")
      else
         table.insert(str, iname.article.." "..iname.name..".")
      end
      table.insert(str, " It's an unique item.\n"..iname.description)
      
      if getPlayerGroupId(cid) >= 4 and getPlayerGroupId(cid) <= 6 then
         table.insert(str, "\nItemID: ["..thing.itemid.."]")
         table.insert(str, "\nPosition: ["..p.x.."]["..p.y.."]["..p.z.."]")
      end
   
      sendMsgToPlayer(cid, MESSAGE_INFO_DESCR, table.concat(str))
      return false
   else
      return true
   end
end

local npcname = getCreatureName(thing.uid)
if ehNPC(thing.uid) and NPCBattle[npcname] then    --npcs duel
   table.insert(str, "You see "..npcname..". "..NPCBattle[npcname].artig.." leader of the gym from "..NPCBattle[npcname].cidbat..".")
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   return false
end
if getPlayerStorageValue(thing.uid, 697548) ~= -1 then    
   table.insert(str, getPlayerStorageValue(thing.uid, 697548))                                   
   local pos = getThingPos(thing.uid)
   if youAre[getPlayerGroupId(cid)] then
      table.insert(str, "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]")
   end
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))  
   return false
end

if not isPlayer(thing.uid) and not isMonster(thing.uid) then    --outros npcs
   table.insert(str, "You see "..getCreatureName(thing.uid)..".")
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   return false
end

if isPlayer(thing.uid) then     --player
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getPlayerDesc(cid, thing.uid, false))  
return false
end

if getCreatureName(thing.uid) == "Evolution" then return false end

if not isSummon(thing.uid) then   --monstros
   
   table.insert(str, "You see a wild "..string.lower(getCreatureName(thing.uid))..".\n")
   table.insert(str, "Hit Points: "..getCreatureHealth(thing.uid).." / "..getCreatureMaxHealth(thing.uid)..".\n")
   if getPokemonGender(thing.uid) == SEX_MALE then
      table.insert(str, "It is male.")
   elseif getPokemonGender(thing.uid) == SEX_FEMALE then
      table.insert(str, "It is female.")
   else
      table.insert(str, "It is genderless.")
   end
   doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   return false

elseif isSummon(thing.uid) and not isPlayer(thing.uid) then  --summons

   local boostlevel = getItemAttribute(getPlayerSlotItem(getCreatureMaster(thing.uid), 8).uid, "boost") or 0
   if getCreatureMaster(thing.uid) == cid then
      local myball = getPlayerSlotItem(cid, 8).uid
      table.insert(str, "You see your "..string.lower(getCreatureName(thing.uid))..".")
      if boostlevel > 0 then
         table.insert(str, "\nBoost level: +"..boostlevel..".")
      end
      table.insert(str, "\nHit points: "..getCreatureHealth(thing.uid).."/"..getCreatureMaxHealth(thing.uid)..".")
      table.insert(str, "\n"..getPokemonHappinessDescription(thing.uid))
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
   else
      doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You see a "..string.lower(getCreatureName(thing.uid))..".\nIt belongs to "..getCreatureName(getCreatureMaster(thing.uid))..".")
   end
   return false
end
return true
end