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