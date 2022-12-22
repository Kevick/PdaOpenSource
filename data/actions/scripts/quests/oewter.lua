function onUse (cid,item,frompos,item2,topos)
pos = {x=1148, y=1476, z=14}

        UID_DO_BAU     = 3553
        STORAGE_VALUE  = 3553
        ID_DO_PREMIO  = 2145
        ID_DO_PREMIO2  = 2160
        ID_DO_PREMIO3  = 12618
        ID_DO_PREMIO4  = 12227
        ID_DO_PREMIO5  = 13954
        ID_DO_PREMIO6  = 13975
        ID_DO_PREMIO7  = 13989
        ID_DO_PREMIO8  = 12832
        ID_DO_PREMIO9  = 12227
        ID_DO_PREMIO10  = 12227
        if getPlayerLevel(cid) >= 1 then
  if item.uid == UID_DO_BAU then
          queststatus = getPlayerStorageValue(cid,STORAGE_VALUE)
          if queststatus == -1 then
        doTeleportThing(cid,pos)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid,22,"Parabens seu filho da puta.") -- Msg que ira aparecer
        doPlayerAddItem(cid,ID_DO_PREMIO1,200)    
        doPlayerAddItem(cid,ID_DO_PREMIO2,5000)
        doPlayerAddItem(cid,ID_DO_PREMIO3,200)
        doPlayerAddItem(cid,ID_DO_PREMIO4,8)
        doPlayerAddItem(cid,ID_DO_PREMIO5,8)
        doPlayerAddItem(cid,ID_DO_PREMIO6,8)
        doPlayerAddItem(cid,ID_DO_PREMIO7,40)
        doPlayerAddItem(cid,ID_DO_PREMIO8,400)    
        doPlayerAddItem(cid,ID_DO_PREMIO9,5)   
        doPlayerAddItem(cid,ID_DO_PREMIO10,10) 
             doPlayerAddExperience(cid, 1000000)
        setPlayerStorageValue(cid,STORAGE_VALUE,1)
          else
        doPlayerSendTextMessage(cid,22,"Ta vazio.")
          end
  end
        else
  doPlayerSendCancel(cid,'Somente lvl 1')
        end
return 1
end