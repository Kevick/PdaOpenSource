function giveBack(item)                                                        --alterado v1.8 peguem o script todo!
local cid = getPlayerByName(getItemAttribute(item.uid, "unique"))   
local attr = getBallsAttributes(item.uid) 
local sendMail = false
----------------------------------
if not isCreature(cid) or getPlayerFreeCap(cid) >= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
   item2 = doCreateItemEx(item.itemid)
   sendMail = true
else
   item2 = addItemInFreeBag(getPlayerSlotItem(cid, 3).uid, item.itemid, 1)
end
----------------------------------
for a, b in pairs (attr) do
    if b then
       doItemSetAttribute(item2, a, b)                       
    else
       doItemEraseAttribute(item2, a)
    end
end
if sendMail then
   doPlayerSendMailByName(getItemAttribute(item2, "unique"), item2, 1) 
end
doRemoveItem(item.uid, 1)
end      

function onAddItem(moveitem, tileitem, position, cid)  

if isContainer(moveitem.uid) then
   local itens = getItensUniquesInContainer(moveitem.uid)
   local sendMsg = false
   if #itens >= 1 then
      for a = 1, #itens do
          if unLock(itens[a].uid) then                
          else
              giveBack(itens[a])   
              sendMsg = true
          end
      end
      if sendMsg then
         doPlayerSendTextMessage(cid, 20, "A item in this container is a Unique Item. You can't throw away this item!")
      end
   end
else
   if getItemAttribute(moveitem.uid, "unique") then
      if unLock(moveitem.uid) then
      return true                  
      end
      giveBack(moveitem)
      doPlayerSendTextMessage(cid, 20, "It is a Unique Item, you can't throw away this item!")
   end  
end

return true 
end	

function onRemoveItem(moveitem, tileitem, position, cid)

if not moveitem or not moveitem.uid then return true end
                                                                     --alterado v1.6.1
if moveitem.uid ~= 0 and isContainer(moveitem.uid) then
   local itens = getItensUniquesInContainer(moveitem.uid)
   local sendMsg = false
   if #itens >= 1 then
      for a = 1, #itens do                     --alterado v1.8
          if not tonumber(getItemAttribute(itens[a].uid, "unique")) and getItemAttribute(itens[a].uid, "unique") ~= getCreatureName(cid) then
             if unLock(itens[a].uid) then                                        
             else
                 giveBack(itens[a]) 
                 sendMsg = true
             end
          end  
      end
      if sendMsg then
         doPlayerSendTextMessage(cid, 20, "A item in this container is a Unique Item. This item don't belongs to you! It will be sent to this owner!")
      end
   end
else
   if moveitem.uid ~= 0 and getItemAttribute(moveitem.uid, "unique") and not tonumber(getItemAttribute(moveitem.uid, "unique")) and getItemAttribute(moveitem.uid, "unique") ~= getCreatureName(cid) then
      if unLock(moveitem.uid) then                                                        --alterado v1.8
      return true                   
      end
      giveBack(moveitem)
      doPlayerSendTextMessage(cid, 20, "It is a Unique Item! This item don't belongs to you! It will be sent to this owner!")
   end  
end
return true 
end	     