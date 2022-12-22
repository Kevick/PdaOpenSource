local maxSlots = 3            --Quantia máxima de slots.
function getDittoSlots(item)
    if not item or item < 1 then
        return false
    elseif getItemAttribute(item, "poke") and getItemAttribute(item, "poke") ~= "Ditto" then
        return false
    end
    local slots = {}
    for i = 1, maxSlots do
        local attr = getItemAttribute(item, "memory"..i)
        if attr then
            slots[i] = attr
        end
    end
    return slots
end
function hasDittoSavedPokemon(item, name)
    if not item or item < 1 then
        return false
    elseif getItemAttribute(item, "poke") and getItemAttribute(item, "poke") ~= "Ditto" then
        return false
    end
    local check
    for i = 1, maxSlots do
        local attr = getItemAttribute(item, "memory"..i)
        if attr and attr == name then
            check = true
            break
        end
    end
    return check
end
function onSay(cid, words, param)
    local item = getPlayerSlotItem(cid, 8).uid
    if item < 1 then
        doPlayerSendCancel(cid, "Put a pokeball in the pokeball slot.")
    elseif getItemAttribute(item, "poke") ~= "Ditto" then
        doPlayerSendCancel(cid, "Put a pokeball with a Ditto in the pokeball slot.")
    elseif param == "" then
        doPlayerSendCancel(cid, "Especify a param.")
    else
        param = param:lower()
        if param == "check" then
            local str = ""
            for i = 1, maxSlots do
                local attr = getItemAttribute(item, "memory"..i) or "No memory"
                if str == "" then
                    str = i.." - "..attr
                else
                    str = str.."\n"..i.." - "..attr
                end
            end
            doPlayerPopupFYI(cid, "Ditto Memory:\n"..str.."")
        elseif param:find("forget") then
            local slot = tonumber(param:match("forget (.+)"))
            if slot and slot <= maxSlots and slot > 0 then
                if getDittoSlots(item)[slot] then
                    doItemSetAttribute(item, "memory"..slot, false)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Ditto Memory] Slot "..slot.." deleted.")
                else
                    doPlayerSendCancel(cid, "This slot is empty.")
                end
            else
                doPlayerSendCancel(cid, "Invalid slot.")
            end
        else
            local summons = getCreatureSummons(cid)
            if #summons == 0 then
                doPlayerSendCancel(cid, "You don't have any pokemon out of the pokeball.")
            else
                if param:find("save") then
                    local transformedPoke = getItemAttribute(item, "transName")
                    if transformedPoke and type(transformedPoke) == "string" then
                        local slot = tonumber(param:match("save (.+)"))
                        if slot and slot <= maxSlots and slot > 0 then
                            if not getDittoSlots(item)[slot] and not hasDittoSavedPokemon(item, transformedPoke) then
                                doItemSetAttribute(item, "memory"..slot, transformedPoke)
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Ditto Memory] You saved at the slot "..slot..": "..transformedPoke..".")
                            else
                                doPlayerSendCancel(cid, "This slot isn't empty or your Ditto already has this pokemon saved in his memory.")
                            end
                        else
                            doPlayerSendCancel(cid, "Invalid slot.")
                        end
                    else
                        doPlayerSendCancel(cid, "Your Ditto isn't transformed in any pokemon.")
                    end
                else
                    local slot = tonumber(param)
                    local transformPoke = getDittoSlots(item)[slot]
                    if not slot then
                        doPlayerSendCancel(cid, "Invalid param.")
                    elseif slot <= 0 or slot > maxSlots then
                        doPlayerSendCancel(cid, "Use a valid slot.")
                    elseif not transformPoke then
                        doPlayerSendCancel(cid, "This slot is empty.")
                    elseif getPlayerStorageValue(summons[1], 1010) == transformPoke then
                        doPlayerSendCancel(cid, "Your Ditto is already transformed in this pokemon.")
                    else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Ditto Memory] Using the slot "..slot..", your Ditto transformed into a "..transformPoke..".")
                        setPlayerStorageValue(summons[1], 1010, transformPoke)
                        doSetCreatureOutfit(summons[1], {lookType = getPokemonXMLOutfit(transformPoke)}, -1)
                        doSendMagicEffect(getThingPos(summons[1]), 184)
                        doCreatureSay(summons[1], "TRANSFORM!", TALKTYPE_MONSTER)
                        doItemSetAttribute(item, "transName", transformPoke)
                        doItemSetAttribute(item, "transOutfit", getPokemonXMLOutfit(transformPoke))
                        if useKpdoDlls then
                            doUpdateMoves(cid)
                        end
                        if dittoCopiesStatusToo then
                           setPlayerStorageValue(summons[1], 1001, dittoBonus * pokes[transformPoke].offense * getPlayerLevel(cid))
                           setPlayerStorageValue(summons[1], 1002, dittoBonus * pokes[transformPoke].defense)
                           setPlayerStorageValue(summons[1], 1003, pokes[transformPoke].agility)
                           setPlayerStorageValue(summons[1], 1004, dittoBonus * pokes[transformPoke].vitality * getPlayerLevel(cid))
                           setPlayerStorageValue(summons[1], 1005, dittoBonus * pokes[transformPoke].specialattack * getPlayerLevel(cid))
                           local pct = getCreatureHealth(summons[1]) / getCreatureMaxHealth(summons[1])
                           local vit = getVitality(summons[1]) * getPlayerLevel(cid) / 100
                           setCreatureMaxHealth(summons[1], vit * HPperVITsummon)
                           doCreatureAddHealth(summons[1], pct * vit * HPperVITsummon)
                        end
                    end
                end
            end
        end
    end
    return true
end