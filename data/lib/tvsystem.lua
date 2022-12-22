names = {}
storage_hastv = 22120
storage_watchtv = 34421
storage_nametv = 12121
storage_idwatchtv = 21213
storage_msgwatch = 292924
storage_namewatchtv = 21923
storage_save_group_id = 63732


smallerros = false
ERROR_ID_NOT_FOUND = "ERROR\nPLAYER NOT FOUND\nSet Storage FALSE ON LOGIN"
MSG_TV_SYSTEM = "Esta ação não e possivel você esta assistindo"
MSG_CREATE_TV = "Parabéns, você criou sua TV "
MSG_LOGOUT_TV = "Você saiu da tv "
MSG_LOGOUT_TV_TOWN = "Você retornou a sua cidade "

ID_ITEM_TV = 12330 ---- IMPORTANTE ID DA SUA CAM(CAMERA)

MSG_WATCH_TV = "Você esta assitindo a uma tv"
MSG_HAS_TV = "Você ja tem tv"
MSG_NO_HAS_TV = "Você não tem tv"
MSG_ENTER_PLAYER = "Um novo player entrou - "


MININUM_STRING_CARACTER = 4
HAS_TV = "Você ja tem uma tv"
MSG_DELETE_TV = "Você deletou sua channel com sucesso"
MSG_WATCH_TV_ENTER_TV = "Você entrou na channel "
NAME_WRONG = "Nome incorreto"
MSG_HAS_NAME_TV = "Desculpe, ja existe uma tv com este nome escolha outro por favor"


function setBooleanStorage(cid, storage, bool)
	if not bool then
		setPlayerStorageValue(cid, storage, -1)
		return true
	end
	
	
	setPlayerStorageValue(cid, storage, "true")
	return true
end


function checkFindStrings(str, array)
	for i=1, #array do
		if string.find(str, array[i]) then
			return true
		end
	end
	return false
end


function playerHasTv(cid) 
	return getPlayerStorageValue(cid, storage_hastv) == "true" and true 
end


function playerWatchTv(cid) 
	return getPlayerStorageValue(cid, storage_watchtv) == "true" and true
end


function getTvOnlines()
	local t = {}
	local online = getPlayersOnline()
	for i=1, #online do
		if playerHasTv(online[i]) then
			table.insert(t, online[i])
		end
	end
	return t
end


function getNamesTv(sep)
	local tvs = getTvOnlines()
	str = ""
	for i=1, #tvs do
		str = str..sep..getTvName(tvs[i])
	end
	return str
end




function getIdByTvName(name)
	local tvs = getTvOnlines()
	for i=1, #tvs do
		if tvs[i] == name then
			return name
		end
	end
	return false
end




function stopWatchAllsPlayerTv(id)
	local onlines = getTvs(id)
	for i=1, #onlines do
		playerStopWatchTv(onlines[i])
	end
	return true
end


function getNameTv(id)
	if not isPlayer(id) then
		print(ERROR_ID_NOT_FOUND)
		return false
	end
	local storage = getPlayerStorageValue(id, storage_nametv)
	if storage ~= -1 then
		return storage
	end
	return ""
end




function createNewTv(cid, name)
	
	
	if #name < MININUM_STRING_CARACTER or checkFindStrings(name, names) then
		doPlayerSendCancel(cid, NAME_WRONG)
		return false
	end
	
	
	local tvs = getTvOnlines()
	for i=1, #tvs do
		if getNameTv(tvs[i]) == name then
			doPlayerSendCancel(cid, MSG_HAS_NAME_TV)
			return false
		end
	end
	
	
	if playerHasTv(cid) then
		doPlayerSendCancel(cid, MSG_HAS_TV)
		return false
	end
	
	
	if playerWatchTv(cid) then
		doPlayerSendCancel(cid, MSG_WATCH_TV)
		return false
	end
	
	
	setBooleanStorage(cid, storage_hastv, true)
	setPlayerStorageValue(cid, storage_nametv, name)
	
	
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, MSG_CREATE_TV..name)
	return true
end


function getTvNameById(id)
	if not isPlayer(id) then
		print(ERROR_ID_NOT_FOUND)
		return false
	end
	
	
	return getPlayerStorageValue(id, storage_nametv)
end


function playerWatchTv(cid, id)
	
	
	if not isPlayer(id) then
		if smallerros then
			print(ERROR_ID_NOT_FOUND)
		end
		return false
	end
	
	
	if playerHasTv(cid) then
		doPlayerSendCancel(cid, MSG_HAS_TV)
		return false
	end
	
	
	if playerWatchTv(cid) then
		doPlayerSendCancel(cid, MSG_WATCH_TV)
		return false
	end
	
	
	
	
	local name = getTvNameById(id)
	setBooleanStorage(cid, storage_watchtv, true)
	setPlayerStorageValue(cid, storage_msgwatch, MSG_TV_SYSTEM)
	setPlayerStorageValue(cid, storage_idwatchtv, id)
	setPlayerStorageValue(cid, storage_namewatchtv, name)
	setPlayerStorageValue(cid, storage_save_group_id, getPlayerGroupId(cid))
	
	
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, MSG_WATCH_TV_ENTER_TV)
	doPlayerSendTextMessage(id, MESSAGE_STATUS_CONSOLE_BLUE, MSG_ENTER_PLAYER..getCreatureName(cid))
	setPlayerTv(cid, id)
	return true
end


function playerStopWatchTv(cid)
	local id = getPlayerStorageValue(cid, storage_idwatchtv)
	local name = getPlayerStorageValue(cid, storage_namewatchtv)
	local town = getPlayerTown(cid)
	local namet = getTownName(town)
	local post = getTownTemplePosition(town)
	
	
	if getPlayerStorageValue(cid, storage_watchtv) ~= "true" then
		return true
	end
	
	
	removePlayerTv(cid, id)
	setBooleanStorage(cid, storage_watchtv, false)
	setPlayerStorageValue(cid, storage_idwatchtv, -1)
	setPlayerStorageValue(cid, storage_namewatchtv, -1)
	setPlayerGroupId(cid, getPlayerStorageValue(cid, storage_save_group_id))
	doTeleportThing(cid, post)
	
	
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, MSG_LOGOUT_TV..name)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, MSG_LOGOUT_TV_TOWN..namet)
	return true
end


function deleteTv(cid)
	if getPlayerStorageValue(cid, 22120) ~= "true" then
		return false
	end
	
	
	stopWatchAllsPlayerTv(cid)
	setBooleanStorage(cid, storage_hastv)
	setPlayerStorageValue(cid, storage_nametv, -1)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, MSG_DELETE_TV)
	return true
	
end