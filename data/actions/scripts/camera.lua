function onUse(cid, item, frompos, item2, topos)

	if getPlayerStorageValue(cid, 99284) == 2 then
		doPlayerSendCancel(cid, "precisa fechar o canal atual.")
	return true
	end

	if getPlayerStorageValue(cid, 99284) == 1 then
		doPlayerSendCancel(cid, "voc� est� ao vivo e seu canal �: "..getPlayerStorageValue(cid, 99285).."")
	return true
	end
end