function onTextEdit(cid, item, newText)
	
	if item.itemid == ID_ITEM_TV then
		createNewTv(cid, newText)
		return true
	end
	
	return true
	
end

function onSelectTv(cid, id)
	local tv = getTvOnlines()
	local idstarter = 200
	
	
	for i=1, #tv do
		local tv = tv[i]
		local sub_id = i+idstarter
		
		
		if sub_id == id then
			playerWatchTv(cid, tv)
		end
	end
	
	
	return true
	
end

function onLogout(cid)
	if isPlayer(cid) then
		deleteTv(cid)
		playerStopWatchTv(cid)
	end
	
	
	return true
	
end

