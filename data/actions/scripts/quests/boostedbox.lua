function onUse (cid,item,frompos,item2,topos)
pos = {x=1039, y=1015, z=6}

        UID_DO_BAU = 3549
        STORAGE_VALUE = 3549
        ID_DO_PREMIO = 12339
        ID_DO_PREMIO2 = 12618

        if getPlayerLevel(cid) >= 200 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,1)
        doPlayerAddItem(cid,ID_DO_PREMIO2,5)
		doPlayerAddExperience(cid, 1000000)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente lvl 150')
        end
return 1
end