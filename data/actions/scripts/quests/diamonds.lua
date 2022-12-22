function onUse (cid,item,frompos,item2,topos)
pos = {x=1039, y=1075, z=6}

        UID_DO_BAU = 3550
        STORAGE_VALUE = 3550
        ID_DO_PREMIO = 2145
        ID_DO_PREMIO2 = 2160

        if getPlayerLevel(cid) >= 200 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO,10)
        doPlayerAddItem(cid,ID_DO_PREMIO2,25)
		doPlayerAddExperience(cid, 1000000)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente lvl 200')
        end
return 1
end