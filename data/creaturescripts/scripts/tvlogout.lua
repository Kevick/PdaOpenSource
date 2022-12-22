function onLogout(cid)
	if isPlayer(cid) then
		deleteTv(cid)
		playerStopWatchTv(cid)
	end
	
	
	return true
	
end