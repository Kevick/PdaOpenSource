
local efeito = 1 -- coloque 0 para remover o efeito quando o pokemon teleportar
local max = 7 -- distancia max entre o pokemon e o player
local function doIncreaseSpeed(cid)
    if not isCreature(cid) then return true end
    doChangeSpeed(cid, -getCreatureSpeed(cid))
    doChangeSpeed(cid, 2.5*(getCreatureBaseSpeed(cid) + getSpeed(cid)))
end
function onLogin(cid)
    registerCreatureEvent(cid, "PokemonIdle")
    return true
end 
function onThink(cid, interval)
    if not isCreature(cid) then
        return true
    end
    local stos = {getPlayerStorageValue(cid, 17000), getPlayerStorageValue(cid, 17001), getPlayerStorageValue(cid, 63215)}
    local check = 0
    for i = 1, #stos do
        if type(stos[i]) == "number" then
            check = check + 1
        end
    end
    if check == #stos then
        if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 or getPlayerStorageValue(cid, 63215) >= 1 then
            return true
        end
        if #getCreatureSummons(cid) >= 1 and not isCreature(getCreatureTarget(cid)) then
            if getDistanceBetween(getThingPos(cid), getThingPos(getCreatureSummons(cid)[1])) > max then
                doTeleportThing(getCreatureSummons(cid)[1], getThingPos(cid), false)
                doSendMagicEffect(getThingPos(cid), 21)
            end
        end
    end
    return true
end
