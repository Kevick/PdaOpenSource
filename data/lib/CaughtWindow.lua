CaughtWindow = {
	storage_catched = 30000,
	pokemons = {
		-- 500 EXP
		["caterpie"] = {portrait = 11998, experience = 500, storage_balls = 15050},
		["weedle"] = {portrait = 12001, experience = 500, storage_balls = 15051},
		["rattata"] = {portrait = 12007, experience = 500, storage_balls = 15052},
	}
}

CaughtWindow.ballcount = function(cid, pokename, ballid)
	local poketab = CaughtWindow.pokemons[pokename:lower()]
	if poketab then
		local pokecount = {}
		if type(getPlayerStorageValue(cid, poketab.storage_balls)) == "string" then
			pokecount = loadstring("return " .. getPlayerStorageValue(cid, poketab.storage_balls))()
		end
		if pokecount[ballid] then
			pokecount[ballid] = pokecount[ballid] + 1
		else
			pokecount[ballid] = 1
		end
		setPlayerStorageValue(cid, poketab.storage_balls, table.string(pokecount))
	end
end

CaughtWindow.sendcaught = function(cid, pokename)
	local poketab = CaughtWindow.pokemons[pokename:lower()]
	if poketab and not getPlayerStorageValue(cid, CaughtWindow.storage_catched):find(pokename) then
		local send = "$CaughtWindow&" .. getItemInfo(poketab.portrait).clientId .. "&" .. pokename .. "&" .. poketab.experience

		local pokecount = loadstring("return " .. getPlayerStorageValue(cid, poketab.storage_balls))()
		for ballid, count in pairs(pokecount) do
			send  = send .. "&" .. getItemInfo(ballid).clientId .. "@" .. count .. "x " .. getItemInfo(ballid).name
		end
		if type(getPlayerStorageValue(cid, CaughtWindow.storage_catched)) == "string" then
			setPlayerStorageValue(cid, CaughtWindow.storage_catched, getPlayerStorageValue(cid, CaughtWindow.storage_catched) .. pokename)
		else
			setPlayerStorageValue(cid, CaughtWindow.storage_catched, pokename)
		end
		setPlayerStorageValue(cid, poketab.storage_balls, -1)
		return doPlayerSendCancel(cid, send)
	end
end

table.string = function(tab)
	local tableStr = "{"
	for i, info in pairs(tab) do
		local index = "[".. i .. "]"
		if (type(i) == "string") then
			index = '["'.. i ..'"]'
		end
		if (type(info) == "table") then
			value = table.string(info)
		elseif (type(info) == "string") then
			value = '"'.. info .. '"'
		else
			value = info
		end
		tableStr = tableStr .. index .. " = " .. value .. ", "
	end
	tableStr = "{" .. tableStr:sub(2, #tableStr)
	return (#tableStr < 3) and "{}" or (tableStr:sub(1, #tableStr - 2) .. "}")
end