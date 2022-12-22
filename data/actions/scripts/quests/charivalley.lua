function onUse (cid,item,frompos,item2,topos)
pos = {x=0, y=0, z=0}

        UID_DO_BAU = 3548
        STORAGE_VALUE = 3548
        ID_DO_PREMIO = 11447
        ID_DO_PREMIO2 = 2160

        if getPlayerLevel(cid) >= 100 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,25)
        doPlayerAddItem(cid,ID_DO_PREMIO2,20)
		doPlayerAddExperience(cid, 1000000)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente lvl 100')
        end
return 1
end