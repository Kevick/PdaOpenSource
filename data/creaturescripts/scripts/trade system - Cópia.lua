function onTradeRequest(cid, target, item)

	for a, b in pairs (pokeballs) do
		if b.use == item.itemid then
			doPlayerSendCancel(cid, "You can't trade this item.")
		return false
		end
	end
	
	if isContainer(item.uid) then
	   local bagItems = getItensUniquesInContainer(item.uid)
	   if #bagItems >= 1 then
	      doPlayerSendCancel(cid, "Has a Unique Item in this bag, you can't trade this item.")     --alterado v1.6
	      return false
       end     
	elseif getItemAttribute(item.uid, "unique") then    --alterado v1.6
	   doPlayerSendCancel(cid, "It is a Unique Item, you can't trade this item.")
	   return false
	end   
	
	if isContainer(item.uid) then
	   local itens = getPokeballsInContainer(item.uid)
	   if #itens >= 1 then                             
	      for i = 1, #itens do
	          local lvl = getItemAttribute(itens[i], "level")
	          local name = getItemAttribute(itens[i], "poke")
	          if not lvl then
	             doItemSetAttribute(itens[i], "level", pokes[name].level)     --alterado v1.6
              end
           end
       end
    elseif isPokeball(item.itemid) then
	   local lvl = getItemAttribute(item.uid, "level")
	   local name = getItemAttribute(item.uid, "poke")
	   if not lvl then
	      doItemSetAttribute(item.uid, "level", pokes[name].level)
       end
    end
    
    if getPlayerStorageValue(cid, 52480) >= 1 then             --alterado v1.6.1
       doPlayerSendTextMessage(cid, 20, "You can't do that while be in a duel!")
       return false
    end
    
    if isPokeball(item.itemid) then
       local name = getItemAttribute(item.uid, "poke")            --alterado v1.8 \/
       local boost = getItemAttribute(item.uid, "boost") or 0
       local nick = getItemAttribute(item.uid, "nick") or ""
    
       local str = "Pokemon in trade: "
       str = str.."•Name: "..name.."   •Boost: "..boost.."   "
       if nick ~= "" then str = str.."•Nick: "..nick.."" end
       sendMsgToPlayer(target, 20, str)
    end
                                                            --alterado v1.8 \/
    if isContainer(item.uid) then
	   local itens = getPokeballsInContainer(item.uid)
	   if #itens >= 1 then                             
	      for i = 1, #itens do
	          if isPokeball(getThing(itens[i]).itemid) then
	             local name = getItemAttribute(itens[i], "poke")            
                 local boost = getItemAttribute(itens[i], "boost") or 0
                 local nick = getItemAttribute(itens[i], "nick") or ""
    
                 local str = "Pokemon in trade: "
                 str = str.."•Name: "..name.."   •Boost: "..boost.."   "
                 if nick ~= "" then str = str.."•Nick: "..nick.."" end
                 sendMsgToPlayer(target, 20, str)
              end
          end
	   end       
    end
    

return true
end

local function noCap(cid, sid)
	if isCreature(cid) then
		doPlayerSendCancel(cid, "You can't carry more than six pokemons, trade cancelled.")
	end
	if isCreature(sid) then
		doPlayerSendCancel(sid, "You can't carry more than six pokemons, trade cancelled.")
	end
end

function onTradeAccept(cid, target, item, targetItem)

	local pbs = #getPokeballsInContainer(item.uid)
	local cancel = false
	local p1 = 0
	local p2 = 0
	local itemPokeball = isPokeball(item.itemid) and 1 or 0
	local targetItemPokeball = isPokeball(targetItem.itemid) and 1 or 0

    if getPlayerMana(cid) + itemPokeball > 6 then  --alterado v1.6
	   cancel = true
	   p1 = cid
    end
    if getPlayerMana(target) + targetItemPokeball > 6 then  --alterado v1.6
	   cancel = true
	   p2 = target
    end
    
	if pbs > 0 and getCreatureMana(target) + pbs > 6 + targetItemPokeball then
		cancel = true	
		p1 = target
	end

	pbs = #getPokeballsInContainer(targetItem.uid)

	if pbs > 0 and getCreatureMana(cid) + pbs > 6 + itemPokeball then
		cancel = true
		p2 = cid
	end

	if cancel then
		addEvent(noCap, 20, p1, p2)
	return false
	end

	if itemPokeball == 1 and targetItemPokeball == 1 then
		setPlayerStorageValue(cid, 8900, 1)
		setPlayerStorageValue(target, 8900, 1)
	end

return true
end