local pewter_cfg = {
{2160, 3},
{2392, 100},
{12344, 100},
{12349, 100},
{11640, 1},
{12338, 2},
}
local sto_saffron = 91122
--//--
function onUse(cid, item, frompos, item2, topos)
         if getPlayerLevel(cid) < 20 then   
		 sendMsgToPlayer(cid, 27, "Desculpe, Apenas Players Level 20 Podem Fazer.")
	     return true
	     end
          --//
         if getPlayerStorageValue(cid, sto_pewter) >= 1 then
         sendMsgToPlayer(cid, 27, "Desculpe, Você Já Fez Está Quest!")
         return true
		 end
		 --//
        for i = 1, #pewter_cfg do
       doPlayerAddItem(cid, pewter_cfg[i][1], pewter_cfg[i][2])
       end
	   --//
setPlayerStorageValue(cid, sto_pewter, 1)	   
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
sendMsgToPlayer(cid, 27, "Congratulations, you complete the Pewter Quest!")
return true
end