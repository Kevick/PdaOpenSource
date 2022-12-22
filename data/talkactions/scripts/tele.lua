local poke = {"Shiny Xatu", "Jynx", "Shiny Jynx", "Xatu", "Natu", "Exeggutor", "Slowking", "Slowbro", "Shiny Mr. Mime", 'Mew', 'Mewtwo', 'Abra', 'Kadabra', 'Alakazam', 'Drowzee', 'Hypno', 'Mr. Mime', 'Porygon', 'Shiny Abra', 'Shiny Alakazam', 
'Shiny Hypno', 'Porygon2'}  --alterado v1.9

local etele = 9499
local cdtele = 1

local config = {
premium = false, -- se precisa ser premium account (true or false)
battle = false	-- se precisa estar sem battle (true). Se colocar false, poderá usar teleport no meio de batalhas
}

local places = {
[1] = {name = "Saffron", id = 1, sto = 897530},
[2] = {name = "Cerulean", id = 2, sto = 897531},
[3] = {name = "Lavender", id = 3, sto = 897532},
[4] = {name = "Fuchsia", id = 4, sto = 897533},
[5] = {name = "Celadon", id = 5, sto = 897534},
[6] = {name = "Viridian", id = 6, sto = 897535},  --alterado v1.7
[7] = {name = "Vermilion", id = 7, sto = 897536},
[8] = {name = "Pewter", id = 8, sto = 897537},          
[9] = {name = "Pallet", id = 9},
[10] = {name = "Cinnabar", id = 10, sto = 897538},
[11] = {name = "Snow", id = 11, sto = 897539},
[12] = {name = "Golden", id = 14, sto = 897540},
[13] = {name = "Ascordbia", id = 15, sto = 8975410},
[14] = {name = "Hammlin", id = 16, sto = 8975420},
[15] = {name = "Shamouti", id = 17, sto = 8975430},
}

function onSay(cid, words, param)

	if #getCreatureSummons(cid) == 0 then
		doPlayerSendCancel(cid, "You need a pokemon to use teleport.")
	return true
	end

	if not isInArray(poke, getCreatureName(getCreatureSummons(cid)[1])) then
	return 0
	end
	
    if getPlayerStorageValue(cid, 22545) == 1 then      --golden arena
       doPlayerSendCancel(cid, "You can't do that while the golden arena!")
    return true
    end
    
    if getPlayerStorageValue(cid, 212124) >= 1 then         --alterado v2.6
       return doPlayerSendCancel(cid, "You can't do it with a pokemon with mind controlled!")
    end

    if getPlayerStorageValue(cid, 52480) >= 1 then
       return doPlayerSendCancel(cid, "You can't do it while a duel!")  --alterado v2.6
    end
    
	if exhaustion.get(cid, etele) and exhaustion.get(cid, etele) > 0 then
		local tempo = tonumber(exhaustion.get(cid, etele)) or 0
		local min = math.floor(tempo)
		doPlayerSendCancel(cid, "Your pokemon is tired, wait "..getStringmytempo(tempo).." to teleport again.")
	return true
	end

	if config.premium and not isPremium(cid) then
		doPlayerSendCancel(cid, "Only premium members are allowed to use teleport.")
	return true
	end

	if config.battle and getCreatureCondition(cid, CONDITION_INFIGHT) then
		doPlayerSendCancel(cid, "Your pokemon can't concentrate during battles.")
	return true
	end

	if (param == '') then
		local str = ""
		str = str .. "Places to go :\n\nHouse\n"
			for a = 1, #places do
				str = str..""..places[a].name.."\n"
			end
		doShowTextDialog(cid, 7416, str)
	return true
	end

	local item = getPlayerSlotItem(cid, 8)
	local nome = getPokeballName(item.uid)
	local summon = getCreatureSummons(cid)[1]
	local lastppos = getThingPos(cid)
	local lastspos = getThingPos(summon)
	local telepos = {}
	local myplace = ""
	local townid = 0

	if string.lower(param) == "house" then

		if not getHouseByPlayerGUID(getPlayerGUID(cid)) then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "You don't own a house.")
		return true
		end

		telepos = getHouseEntry(getHouseByPlayerGUID(getPlayerGUID(cid)))
		myplace = "our home"

	else

		for x = 1, #places do
			if string.find(string.lower(places[x].name), string.lower(param)) then
				townid = places[x].id
				myplace = places[x].name
			end
		end

		if myplace == "" then
			doPlayerSendCancel(cid, "That place doesn't exist.")
		return true
		end

	end

	if myplace ~= "" and townid > 0 then
		telepos = getTownTemplePosition(townid)
	end

	if getDistanceBetween(getThingPos(cid), telepos) <= 15 then
		doPlayerSendCancel(cid, "You are too near to the place you want to go!")
	return true
	end

	doSendMagicEffect(getThingPos(summon), 29)
	doSendMagicEffect(getThingPos(cid), 29)

	doTeleportThing(cid, telepos, false)

	local pos2 = getClosestFreeTile(cid, getPosByDir(getThingPos(cid), SOUTH))

	doTeleportThing(summon, pos2, false)

	doSendMagicEffect(getThingPos(cid), 29)

	doCreatureSay(cid, ""..nome..", teleport to "..myplace.."!", 1)
	doCreatureSay(cid, ""..nome..", teleport to "..myplace.."!", 1, false, 0, lastppos)
	doCreatureSay(summon, "TELEPORT!", TALKTYPE_MONSTER)
	doCreatureSay(summon, "TELEPORT!", TALKTYPE_MONSTER, false, 0, lastspos)

	doCreatureSetLookDir(cid, SOUTH)
	doCreatureSetLookDir(summon, SOUTH)

	doSendMagicEffect(getThingPos(summon), CONST_ME_TELEPORT)
	exhaustion.set(cid, etele, cdtele)

return true
end